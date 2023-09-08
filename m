Return-Path: <netdev+bounces-32616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D1798C5A
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A48D1C20BD1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513914AB8;
	Fri,  8 Sep 2023 18:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFD14A98;
	Fri,  8 Sep 2023 18:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCD4C116A2;
	Fri,  8 Sep 2023 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196849;
	bh=WllazrnZK0zNC+xRvsjB/+MK5mWapWEDFuwgqp2oeKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVeS/ZGsIiQyjTtqnuImRv1nQUZbvMT01PCXGUgJoFGaZ+0xCOW1JEbDsrG1ekVQu
	 QnOn2ldG9i7by1SpwvBSJ1lUJZsCjFcRc4f9wsplsy4SX+JS0MBfnQIdw6nDNNpvN2
	 IUrtERdFhfC8Ah/HWo7k1OJyiYZIi3td2gKFbPG2PHi2ptjhFo6V5rN2xsX9yyhPPF
	 4fIUVAeSlJoH1xJ+WFPg9UeHx9bNjLwSVfiV73M23QlsEOPvvVDbsz5eKMI17tmFST
	 3CRgw43nbhtYXWcZgM1/HaZGIX8ZlH1YQG9JCVBaiFDmwIRWKUjI1fM9YoKg9HUxqQ
	 hyl8BWQQet8Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	wg@grandegger.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 14/45] can: sun4i_can: Add support for the Allwinner D1
Date: Fri,  8 Sep 2023 14:12:55 -0400
Message-Id: <20230908181327.3459042-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: John Watts <contact@jookia.org>

[ Upstream commit 8abb95250ae6af2d51993da8fcae18da2ce24cc4 ]

The controllers present in the D1 are extremely similar to the R40
and require the same reset quirks, but An extra quirk is needed to support
receiving packets.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-6-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/Kconfig     |  4 ++--
 drivers/net/can/sun4i_can.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a5c5036dfb943..e626de33e735d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -185,10 +185,10 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
-	  A10/A20 SoCs.
+	  A10/A20/D1 SoCs.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called sun4i_can.
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 1f90fe6dbb8bb..c508a328e38d4 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -91,6 +91,8 @@
 #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
 #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
 #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
+#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1 */
+#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 on the D1 */
 #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer start */
 #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN transmit buffer end */
 
@@ -779,6 +781,11 @@ static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.acp_offset = 0,
 };
 
+static const struct sun4ican_quirks sun4ican_quirks_d1 = {
+	.has_reset = true,
+	.acp_offset = (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
+};
+
 static const struct of_device_id sun4ican_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-can",
@@ -789,6 +796,9 @@ static const struct of_device_id sun4ican_of_match[] = {
 	}, {
 		.compatible = "allwinner,sun8i-r40-can",
 		.data = &sun4ican_quirks_r40
+	}, {
+		.compatible = "allwinner,sun20i-d1-can",
+		.data = &sun4ican_quirks_d1
 	}, {
 		/* sentinel */
 	},
@@ -913,4 +923,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");
-- 
2.40.1


