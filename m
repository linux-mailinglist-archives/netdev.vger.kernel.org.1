Return-Path: <netdev+bounces-13034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58E73A020
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4AD1C210DA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA51C77E;
	Thu, 22 Jun 2023 11:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786A5239
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:55:58 +0000 (UTC)
Received: from ultron (136.red-2-136-200.staticip.rima-tde.net [2.136.200.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1A4171C;
	Thu, 22 Jun 2023 04:55:54 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ultron (Postfix) with ESMTP id DE00D1AC0361;
	Thu, 22 Jun 2023 13:55:52 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: carlos.fernandez@technica-engineering.de,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: macsec SCI assignment for ES = 0
Date: Thu, 22 Jun 2023 13:55:51 +0200
Message-Id: <20230622115551.9163-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
	HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_FAIL,TO_EQ_FM_DOM_SPF_FAIL,
	TO_EQ_FM_SPF_FAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

According to 802.1AE standard, when ES and SC flags in TCI are zero, used
SCI should be the current active SC_RX. Current kernel does not implement
it and uses the header MAC address.

Without this patch, when ES = 0 (using a bridge or switch), header MAC
will not fit the SCI and MACSec frames will be discarted.

Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
---
 drivers/net/macsec.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3427993f94f7..46a7776ef9a2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -256,16 +256,31 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
 {
+	struct macsec_dev *macsec_device;
 	sci_t sci;
 
-	if (sci_present)
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
-		       sizeof(hdr->secure_channel_id));
-	else
+                      sizeof(hdr->secure_channel_id));	
+	} else if (!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) {
+		list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) {
+			struct macsec_secy *secy = &macsec_device->secy;
+			struct macsec_rx_sc *rx_sc;
+
+			for_each_rxsc(secy, rx_sc) {
+				rx_sc = rx_sc ? macsec_rxsc_get(rx_sc) : NULL;
+				if (rx_sc && rx_sc->active)
+					return rx_sc->sci;
+			}
+		}
+		/* If not found, use MAC in hdr as default*/
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
-
+	} else {
+		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 	return sci;
 }
 
@@ -1150,11 +1165,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
-- 
2.34.1


