Return-Path: <netdev+bounces-28416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D777F600
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28141281EA6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85A13AED;
	Thu, 17 Aug 2023 12:05:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D213ACF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:05:04 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4663599;
	Thu, 17 Aug 2023 05:04:39 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qWbjj-0001mN-0l;
	Thu, 17 Aug 2023 12:04:23 +0000
Date: Thu, 17 Aug 2023 13:04:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: pcs: lynxi: fully reconfigure if link is down
Message-ID: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On MT7988 When switching from 10GBase-R/5GBase-R/USXGMII to one of the
interface modes provided by mtk-pcs-lynxi we need to make sure to
always perform a full configuration of the PHYA.
As the idea behind not doing that was mostly to prevent an existing link
going down without any need for it to do so. Hence we can just always
perform a full confinguration in case the link is down.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index b0f3ede945d96..788c2ccde064e 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -108,8 +108,8 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				bool permit_pause_to_mac)
 {
 	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
-	bool mode_changed = false, changed;
-	unsigned int rgc3, sgm_mode, bmcr;
+	bool mode_changed = false, changed, link;
+	unsigned int bm, rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
 
 	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
@@ -117,6 +117,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (advertise < 0)
 		return advertise;
 
+	/* Check if link is currently up */
+	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
+	link = !!(FIELD_GET(SGMII_BMSR, bm) & BMSR_LSTATUS);
+
 	/* Clearing IF_MODE_BIT0 switches the PCS to BASE-X mode, and
 	 * we assume that fixes it's speed at bitrate = line rate (in
 	 * other words, 1000Mbps or 2500Mbps).
@@ -137,7 +141,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		bmcr = 0;
 	}
 
-	if (mpcs->interface != interface) {
+	/* Do a full reconfiguration only if the link is down or the interface
+	 * mode has changed
+	 */
+	if (mpcs->interface != interface || !link) {
 		link_timer = phylink_get_link_timer_ns(interface);
 		if (link_timer < 0)
 			return link_timer;
-- 
2.41.0

