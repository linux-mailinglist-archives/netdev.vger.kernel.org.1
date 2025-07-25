Return-Path: <netdev+bounces-210091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB118B12192
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F711893C47
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274D2EFD88;
	Fri, 25 Jul 2025 16:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D232EF9BA
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460021; cv=none; b=ZB1zeiWXs76F89OZPxkvSbd+E7Zx3EY6LLUBzF2Ola/jo2pk++CSVm48VMR26gsLnUGrVX99vcG2tsrXLkwrI/4W7fBjqMLNd95P9KcARQi5H3ynM8mYt+CLOPHIxloJsmENHuj41a5rkiQnIpOax6PvBxyIgP+DLxMQkhyzkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460021; c=relaxed/simple;
	bh=3PNgz4ikQj8yxEhPlKTE+xK2sRMPODlCS1m/obi2d/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Gx7zHDZiSmpZZ8ZlFwdgmFCoUeXZAPaj60kepEqCrIQG7sGP/8rwtNqUqYBNfnTshXyyBk3z5hxMjL+r97gLbaA/eSTkh2Fe1Xiuft8OXkjWOVTK1Y3+HfQyWs21rYvT31uWW8XFsk7EYnKotZpw9yIjw03JsUalYglPbJ4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-0006eT-AU
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL38-00AFYc-1g
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8025744988B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3CAD6449813;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2e16aa99;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/27] can: kvaser_pciefd: Add support to control CAN LEDs on device
Date: Fri, 25 Jul 2025 18:05:17 +0200
Message-ID: <20250725161327.4165174-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add support to turn on/off CAN LEDs on device.
Turn off all CAN LEDs in probe, since they are default on after a reset or
power on.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 09510663988c..c8f530ef416e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
 #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
+#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
 #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
 #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
 #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
@@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Request status packet */
 #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 
+/* Control CAN LED, active low */
+#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
+
 /* Transmitter unaligned */
 #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
 /* Tx FIFO empty */
@@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
+	u32 ioc;
 	u8 cmd_seq;
 	u8 tx_max_count;
 	u8 tx_idx;
@@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
 	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
 }
 
+static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
+{
+	if (on)
+		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
+	else
+		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
+
+	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+}
+
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
 {
 	u32 mode;
@@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
+		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+		kvaser_pciefd_set_led(can, false);
+
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-- 
2.47.2



