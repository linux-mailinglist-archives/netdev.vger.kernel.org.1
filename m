Return-Path: <netdev+bounces-225870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A34B98D81
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126BC2E3AAE
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473732C0289;
	Wed, 24 Sep 2025 08:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61976288CBF
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702117; cv=none; b=JziL/pH1uVMIjjRUwPdx3ujtVj1FkGhg1ltJhEQrwZOPj1BMbdmrHaA5HNPNGdMRBMmJpq6XU7Tk+liJXvlmrkz0v/lBPSGvS3QWe+hQENBCKsG7B2bYFaXfsp3cKEUFZOvKqXkYa/cNjOEfFbu5p/aaJhajoxhHXyRrT9xb6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702117; c=relaxed/simple;
	bh=dLRB8xSJ5Bf8h2CAv6aJzVHTA8Yj8WBCfUiaa37rtFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Luxdp3XYYQGsW5n0N/4nk5t6c34s8G1ar9ImlBYHZ2nhU6XMAD8PUEzcyf/+CWnqcGPB1lO1aoml+3Zcmzt4P9C56IM6i6ruq/QkHAN4Xj1GpnyNSKzh775aW3AWSGQodW/XucrzMUlfAVYwMsVytBgSP+xPab055WGXfpmV62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001Fo-UI; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwI-0u;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8B9E47889C;
	Wed, 24 Sep 2025 08:21:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/48] can: enable CAN XL for virtual CAN devices by default
Date: Wed, 24 Sep 2025 10:06:45 +0200
Message-ID: <20250924082104.595459-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

In commit 97edec3a11cf ("can: enable CAN FD for virtual CAN devices by
default"), vcan and vxcan default MTU was set to CANFD_MTU by default.
The reason was that users were confused on how to activate CAN FD on
virtual interfaces.

Following the introduction of CAN XL, the same logic should be
applied. Set the MTU to CANXL_MTU by default.

The users who really wish to use a Classical CAN only or a CAN FD
virtual device can do respectively:

  $ ip link set vcan0 mtu 16

or

  $ ip link set vcan0 mtu 72

to force the old behaviour.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-can-fix-mtu-v3-4-581bde113f52@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/vcan.c  | 2 +-
 drivers/net/can/vxcan.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index f67e85807100..fdc662aea279 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -156,7 +156,7 @@ static const struct ethtool_ops vcan_ethtool_ops = {
 static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANFD_MTU;
+	dev->mtu		= CANXL_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 99a78a757167..b2c19f8c5f8e 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -156,7 +156,7 @@ static void vxcan_setup(struct net_device *dev)
 	struct can_ml_priv *can_ml;
 
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANFD_MTU;
+	dev->mtu		= CANXL_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
-- 
2.51.0


