Return-Path: <netdev+bounces-225195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EAB8FEC7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7887169872
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFC22F5A08;
	Mon, 22 Sep 2025 10:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD82882A6
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535763; cv=none; b=ekTNpfGi0kuTfVn2g19aVKYN9C8HlYwuZ/vG9bTiV9NMlJzJk1Impih0LbhnLFNKUo9s6zvOCRiAqoJyghwjxQWSx0m5Aa1DV22qCZxDXz8NjAOH3E+vYzbjXsDDxWPDPdE/4vg0Pp9wMetZeNtjQgmdF1hjucqCpD+ET7VWSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535763; c=relaxed/simple;
	bh=rd32eBhFiAAJLcDnvaafjRB6AVqo9CCTAgAfyMBrfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETXHiazvxLxUM8o0LqAq1lxtGGP6DBaR73h4zOx7XgfsZuApcp4qOcBrGpWXE1ezwNiNGTvLzS1M+ZsoyK4Via4tD+qNhDM/2LCeowpRBoeIH2uPDN4+oh9xT4fJm2CpUW3ROGW6s5rq1GXD27R8v8XPHwlUPG+JGgKSsVumSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dTz-0006vp-OQ
	for netdev@vger.kernel.org; Mon, 22 Sep 2025 12:09:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dTz-002ZV1-0g
	for netdev@vger.kernel.org;
	Mon, 22 Sep 2025 12:09:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D5501476D0A
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:09:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F1729476CDE;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id df03a408;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/10] can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
Date: Mon, 22 Sep 2025 12:07:33 +0200
Message-ID: <20250922100913.392916-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922100913.392916-1-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

Sending an PF_PACKET allows to bypass the CAN framework logic and to
directly reach the xmit() function of a CAN driver. The only check
which is performed by the PF_PACKET framework is to make sure that
skb->len fits the interface's MTU.

Unfortunately, because the etas_es58x driver does not populate its
net_device_ops->ndo_change_mtu(), it is possible for an attacker to
configure an invalid MTU by doing, for example:

  $ ip link set can0 mtu 9999

After doing so, the attacker could open a PF_PACKET socket using the
ETH_P_CANXL protocol:

	socket(PF_PACKET, SOCK_RAW, htons(ETH_P_CANXL));

to inject a malicious CAN XL frames. For example:

	struct canxl_frame frame = {
		.flags = 0xff,
		.len = 2048,
	};

The CAN drivers' xmit() function are calling can_dev_dropped_skb() to
check that the skb is valid, unfortunately under above conditions, the
malicious packet is able to go through can_dev_dropped_skb() checks:

  1. the skb->protocol is set to ETH_P_CANXL which is valid (the
     function does not check the actual device capabilities).

  2. the length is a valid CAN XL length.

And so, es58x_start_xmit() receives a CAN XL frame which it is not
able to correctly handle and will thus misinterpret it as a CAN(FD)
frame.

This can result in a buffer overflow. For example, using the es581.4
variant, the frame will be dispatched to es581_4_tx_can_msg(), go
through the last check at the beginning of this function:

	if (can_is_canfd_skb(skb))
		return -EMSGSIZE;

and reach this line:

	memcpy(tx_can_msg->data, cf->data, cf->len);

Here, cf->len corresponds to the flags field of the CAN XL frame. In
our previous example, we set canxl_frame->flags to 0xff. Because the
maximum expected length is 8, a buffer overflow of 247 bytes occurs!

Populate net_device_ops->ndo_change_mtu() to ensure that the
interface's MTU can not be set to anything bigger than CAN_MTU or
CANFD_MTU (depending on the device capabilities). By fixing the root
cause, this prevents the buffer overflow.

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250918-can-fix-mtu-v1-1-0d1cada9393b@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index db1acf6d504c..adc91873c083 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/unaligned.h>
@@ -1977,6 +1977,7 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
-- 
2.51.0



