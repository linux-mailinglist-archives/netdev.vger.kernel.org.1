Return-Path: <netdev+bounces-124449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C809698BC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E481C1F24315
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD261D0962;
	Tue,  3 Sep 2024 09:22:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8E1CEAB2
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355372; cv=none; b=int6ayzHmdbcf4gXqEFjgIvDvuDnPt1IGs2nhUPQgjk/cD9zalrFo+4lfwBwEGKUiXey43EYdBuOjsORdMxXYnw3zSH2CWix0faXXfJghG8pBB0EV9s+i6JXr8iAEL5X6VsLiD/HHSXeKb5cgtcrYREmtB8v6iez/yXQBnOPdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355372; c=relaxed/simple;
	bh=kI/a3LIJoA6o+D0CBQkvFfYlrafVr1kbTwEszrFv5+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IF76x2jjCb0T9Z7+523O/+2Qtjbr8mEOiQ5aE2hLO9wZN+9acTVkyLUFGECdY4uIQbTtg0NOSDiSlVnehnzP8dTKvqvY6SFHhEMphVUgA7LWzMhJQcM8B8PqQTe6YGUAiiHOC2skfSSNggy7Z/Zz8tWsMjxc/mEK1UNJtHcKR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkK-0000s5-Iy
	for netdev@vger.kernel.org; Tue, 03 Sep 2024 11:22:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkE-0059Wh-9L
	for netdev@vger.kernel.org; Tue, 03 Sep 2024 11:22:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C1A243311AA
	for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 09:22:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8073C33102D;
	Tue, 03 Sep 2024 09:22:27 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7aaf2de3;
	Tue, 3 Sep 2024 09:22:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 03 Sep 2024 11:21:49 +0200
Subject: [PATCH can-next v4 07/20] can: rockchip_canfd: add support for
 rk3568v3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rockchip-canfd-v4-7-1dc3f3f32856@pengutronix.de>
References: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
In-Reply-To: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=kI/a3LIJoA6o+D0CBQkvFfYlrafVr1kbTwEszrFv5+U=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm1tU9JGg4HfLADD2e0kvz7ec8ndJ43QrCh816s
 ujz+7vTAGKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtbVPQAKCRAoOKI+ei28
 b1DpB/9glYwYWjXOn1Z4r/arxSUtA9R3N4MGWmKzEKWKbsIo7W/i6zNTSPvdwh5uO8TIjLj1Kn4
 qyORnfb5oA0OSDcsmChvXto8xHzZgJesOQ/ZuBCiDigRoxVkX22pBcV+xkvqy6h0ctv+vSwy3FQ
 Voe+FWluDhhvERbYPmvsjYEtd7y6df2sOAU3vVh4BerK9yp4MJLXY3YT5Dr4b1jz/tw+nfXzNHz
 Fp7tV3k07mihR1w1AYWT3qid0eiEeJi+ZkoBdh98F1ryApL/5/NvTTy+EJvqKfNjTE32ufTypcv
 ob9pJoXcF9itb4VK9e9AlcEDSZ46wWc6bX8k02df9P8spTjV
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add the support for the rk3568v3 SoC, the CAN-FD IP core has 7
documented errata.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 20 ++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h      |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 61de6f89cf16..40911bb63623 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -35,11 +35,28 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by erratum 5, but tests
+ * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. In contrast to the errata sheet mark rk3568v3
+ * as effected by erratum 5, too.
+ */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
+	.model = RKCANFD_MODEL_RK3568V3,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
 	case RKCANFD_MODEL_RK3568V2:
 		return "rk3568v2";
+	case RKCANFD_MODEL_RK3568V3:
+		return "rk3568v3";
 	}
 
 	return "<unknown>";
@@ -764,6 +781,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	{
 		.compatible = "rockchip,rk3568v2-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v2,
+	}, {
+		.compatible = "rockchip,rk3568v3-canfd",
+		.data = &rkcanfd_devtype_data_rk3568v3,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 7321027534fb..9b446331fbd0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -372,6 +372,7 @@
 
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
+	RKCANFD_MODEL_RK3568V3 = 0x35683,
 };
 
 struct rkcanfd_devtype_data {

-- 
2.45.2



