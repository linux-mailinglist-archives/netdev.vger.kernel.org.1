Return-Path: <netdev+bounces-123819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225659669A9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5586D1C23F1F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888601BF819;
	Fri, 30 Aug 2024 19:27:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138841BF813
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046032; cv=none; b=FpjRevnQZxBAHyWniZ6ICOF6liYaJrf7RWcD7k62+KrRb2YrJ8Q76SCrLeDXDYFRU2YUxtHOeZdZZ9KO57zKUcVVrpg5AclplxpjJkUt+Nb7FnKoyEU5HoEfgvFVC12kLE0Z/1vW01Khe2nFWn3V1nbjnybng8ODmeH8l0ujrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046032; c=relaxed/simple;
	bh=S2FPUCLf0HBw5+QixJBEj6Z5Avphz5THqZA6bqbQ93k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJiKD2c5BZ4eM5BFqQIzpaEMG+BWEHM5A8/N3yKmwDQEPYkH8LMFXLTL37WQBXPNZuhPEX+kDeJENzNt4W69ML7hUfnjyLqVGO0LrdpGesOGTZ4Rn7mqPzARGphdYZfOtFso4eiBnUZulsvXQaZ3po21g5eLqWqN5Fn01zIt1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gz-0006KT-Qy
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 21:27:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gr-004Dpc-Bj
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 21:26:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9309932E246
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 19:26:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 53CEE32E110;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a5043944;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:10 +0200
Subject: [PATCH can-next v3 13/20] can: rockchip_canfd: implement
 workaround for erratum 12
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-13-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=S2FPUCLf0HBw5+QixJBEj6Z5Avphz5THqZA6bqbQ93k=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzpP6wKpibmHfjLF1qfFuihHr56ftTgVnR6z
 LIlpPNt6IyJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc6QAKCRAoOKI+ei28
 bx5dB/4yPBgAM53a48MOSFzCdZDUgDWQAgUuVlJECEna86uJhVcJos/7VYOYM9ogf04TXi7Ko3U
 NvzsxRchuy8RMckHiY5uv6QNDN6D0kzox+eBdnaXLt8JD4p7M8RY8oowyeHDfhhUuzkxux9GigX
 SZQpPLwpb7MawqNMFgcKGaL5gNIgQRz58nRIIHDc8gVeVXtxcI8WzNbjfHIstE2NiKzf4AYdfQW
 tU8h0fQ+h3JJSK4hPr4TqW9aaVr6gKMD9rjzQZ8ExQ/xsfFIAbvwtp8++0R5qOjn29F3zMJx3yP
 dh/AkVp8kUWwlvdOuH43+WPPVv/Pu+QTZvVV61ycv2i/aSXn
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
says:

| A dominant bit at the third bit of the intermission may cause a
| transmission error.
|
| When sampling the third bit of the intermission as a dominant bit, if
| tx_req is configured to transmit extended frames at this time, the
| extended frame may be sent to the bus in the format of a standard
| frame. The extended frame will be sent as a standard frame and will not
| result in error frames

Turn on "Interframe Spaceing RX Mode" only during TX to work around
erratum 12, according to rock-chip:

| Spaceing RX Mode = 1, the third Bit between frames cannot receive
| and send, and the fourth Bit begins to receive and send.
|
| Spaceing RX Mode = 0, allowing the third Bit between frames to
| receive and send.

Message-ID: <be72939f-0a9e-0608-dfff-7b0096a26eba@rock-chips.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index e98e7a836b83..9db6d90a4e7f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -11,7 +11,14 @@
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 					 const u32 reg_cmd)
 {
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
+		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
+			      RKCANFD_REG_MODE_SPACE_RX_MODE);
+
 	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
+
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
+		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);
 }
 
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)

-- 
2.45.2



