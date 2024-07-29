Return-Path: <netdev+bounces-113663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105C93F670
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED331C22A0E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4D18787D;
	Mon, 29 Jul 2024 13:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD6187568
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258445; cv=none; b=UcdO3iYQ3nlpMKizMzx7ixPB+zUL7s7Aivau9FFQnBeTwNjLcguEyBEXYe62dWU2RuzG+Cp3HAs8Dl/JxqEiaKMIUjrVHvSDw1/DpjP8YlcEh1qmWILqyjUKBGCbdJ6KvOBq9yi2wTXqBrY/L5ySVLJnqubuAzCjWAlHO5IfVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258445; c=relaxed/simple;
	bh=X2bxg+jou4U5hGaXKiE7cV5iCANBwwffLWJgMLlPWoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTCLPA1DAq0mqF18YQW29d41bx4yIHIKEgtXysWoji3+lQeG88EX41jDfo9uJA3JVG0Jj8VitKXl6iTJkJ7vN8e0NWMazm39gyqsovgnjmmX1S1xE0OxB/baBEaDni8Zgh5Yx2Fkvq9qeLdSyPO6d5Ynhqkh4DPKmkaUZ+EF5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5y-000127-Pp
	for netdev@vger.kernel.org; Mon, 29 Jul 2024 15:07:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5y-0033Lh-2D
	for netdev@vger.kernel.org; Mon, 29 Jul 2024 15:07:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 98CF2310F12
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:07:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 89EA2310E73;
	Mon, 29 Jul 2024 13:07:10 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f6604ea6;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:49 +0200
Subject: [PATCH can-next 18/21] can: rockchip_canfd: enable full TX-FIFO
 depth of 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-18-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=X2bxg+jou4U5hGaXKiE7cV5iCANBwwffLWJgMLlPWoE=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PQtF+eEcFBaoKWOLSlstAvHYWEUjMBDUWiY
 fxko0qCh22JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeT0AAKCRAoOKI+ei28
 b3w3CACYdDk9GeFyKi7g79Gyp3surxMmUdrsl4PSQB+H1Il+2FPl2JLRqrMADLqi9FWGqZgFhJD
 3j/JAATZOFKD3WDX3tOq17WgGfJHv4rBJR/3m1F0vOgbZtKtdu+dYfCZGXVp6RghzIw3DhMaC0q
 LOeq244aXgpSeSt0UMFMxRhPZTxiD/Z9HATyRxq+6RTgngibM7ddoqAmVjnnPQ4piCOfoEWGvDp
 SO3nQmwfnBFAekEA++2N24LbA4Wu0h27JurPtM+54pja/LBdk6BDUeDHdegEuKqUsqEAe+sYwQi
 G1PTwhAErtbdIXaidqZSgUYc+3zdyolS6R1Cw2mWr1KdZe8L
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The previous commit prepared the TX path to make use of the full
TX-FIFO depth as much as possible. Increase the available TX-FIFO
depth to the hardware maximum of 2.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3c1d61c8632f..f06f6a83b77f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -287,7 +287,7 @@
 
 #define DEVICE_NAME "rockchip_canfd"
 #define RKCANFD_NAPI_WEIGHT 32
-#define RKCANFD_TXFIFO_DEPTH 1
+#define RKCANFD_TXFIFO_DEPTH 2
 #define RKCANFD_TX_STOP_THRESHOLD 1
 #define RKCANFD_TX_START_THRESHOLD 1
 

-- 
2.43.0



