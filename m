Return-Path: <netdev+bounces-19789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F775C565
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B651C21662
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3071BE8B;
	Fri, 21 Jul 2023 11:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD261D2F6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:04:39 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818B46B5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:04:12 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1qMnvL-0000Ly-A7; Fri, 21 Jul 2023 13:03:51 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com
Cc: devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 2/3] net: stmmac: introduce small helper to check STMMAC_FLAG_USE_PHY_WOL
Date: Fri, 21 Jul 2023 13:03:44 +0200
Message-Id: <20230721110345.3925719-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721110345.3925719-1-m.felsch@pengutronix.de>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a convenient helper to make it easier to check the
STMMAC_FLAG_USE_PHY_WOL flag which is useful for the follow up commit.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v4:
- new patch

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e7ca52f0d2f2d..add271ec8d801 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6949,6 +6949,11 @@ static void stmmac_service_task(struct work_struct *work)
 	clear_bit(STMMAC_SERVICE_SCHED, &priv->state);
 }
 
+static bool stmmac_use_phy_wol(struct stmmac_priv *priv)
+{
+	return priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL;
+}
+
 /**
  *  stmmac_hw_init - Init the MAC device
  *  @priv: driver private structure
@@ -6983,7 +6988,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		 */
 		priv->plat->enh_desc = priv->dma_cap.enh_desc;
 		priv->plat->pmt = priv->dma_cap.pmt_remote_wake_up &&
-				!(priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL);
+				!stmmac_use_phy_wol(priv);
 		priv->hw->pmt = priv->plat->pmt;
 		if (priv->dma_cap.hash_tb_sz) {
 			priv->hw->multicast_filter_bins =
-- 
2.39.2


