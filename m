Return-Path: <netdev+bounces-28691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042EB78042D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B280228227A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C5E6AC2;
	Fri, 18 Aug 2023 03:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AC380
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:08:06 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE2100;
	Thu, 17 Aug 2023 20:08:05 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qWpq5-00056L-0G;
	Fri, 18 Aug 2023 03:07:53 +0000
Date: Fri, 18 Aug 2023 04:07:46 +0100
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
Subject: [PATCH net-next] net: pcs: lynxi: implement pcs_disable op
Message-ID: <f23d1a60d2c9d2fb72e32dcb0eaa5f7e867a3d68.1692327891.git.daniel@makrotopia.org>
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

When switching from 10GBase-R/5GBase-R/USXGMII to one of the interface
modes provided by mtk-pcs-lynxi we need to make sure to always perform
a full configuration of the PHYA.

Implement pcs_disable op which resets the stored interface mode to
PHY_INTERFACE_MODE_NA to trigger a full reconfiguration once the LynxI
PCS driver had previously been deselected in favor of another PCS
driver such as the to-be-added driver for the USXGMII PCS found in
MT7988.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index b0f3ede945d96..8501dd365279b 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -233,11 +233,19 @@ static void mtk_pcs_lynxi_link_up(struct phylink_pcs *pcs,
 	}
 }
 
+static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
+{
+	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
+
+	mpcs->interface = PHY_INTERFACE_MODE_NA;
+}
+
 static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
 	.pcs_get_state = mtk_pcs_lynxi_get_state,
 	.pcs_config = mtk_pcs_lynxi_config,
 	.pcs_an_restart = mtk_pcs_lynxi_restart_an,
 	.pcs_link_up = mtk_pcs_lynxi_link_up,
+	.pcs_disable = mtk_pcs_lynxi_disable,
 };
 
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-- 
2.41.0

