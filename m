Return-Path: <netdev+bounces-22166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410676661E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524851C217CF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05BC101E2;
	Fri, 28 Jul 2023 07:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576810787
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:58:50 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF164216
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:58:32 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMo-0008Ca-I4
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4ACF71FD1F4
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5D69E1FD19C;
	Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 356e560a;
	Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/21] can: sun4i_can: Add acceptance register quirk
Date: Fri, 28 Jul 2023 09:55:56 +0200
Message-Id: <20230728075614.1014117-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: John Watts <contact@jookia.org>

The Allwinner D1's CAN controllers have the ACPC and ACPM registers
moved down. Compensate for this by adding an offset quirk for the
acceptance registers.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-5-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..1f90fe6dbb8b 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -205,9 +205,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +218,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +341,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,10 +771,12 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -870,6 +875,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.40.1



