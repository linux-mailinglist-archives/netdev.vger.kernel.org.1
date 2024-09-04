Return-Path: <netdev+bounces-124454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C500F9698CF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C0A287713
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB891D86FD;
	Tue,  3 Sep 2024 09:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AC1AD240
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355374; cv=none; b=mKIRj7s0f2t2jIwrfOfmadUVcs5109nqXLlkwXlNnI3rGi4rropTvjYS/G+fdHjXkvZmeiBC9T+VVIiPnHq6OX7ebPXedWy4/UJYFlDGirK/84+mFF9MKhMJ3ninBYi4GSGO+Tjtjo3ANBxxAxu4CW3SvmzmMycoXOq4EI2+Opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355374; c=relaxed/simple;
	bh=Rb+DPh6I1pIZR5OwMWvyyqc8QfjnlVzZzpFMC3B2FWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tahZJk1o21i56PVLgrVUEXY3sj3vLnkwOCd7d/zZFfuEh+vZix2iolIR927uEyvFRvJIO1pLmsgmt/ic6dkE2EFasvajpC9qZ9NOd+6D+XAXoSJId2t0iu/MdlxQLjRjk/fx2mNDRx4aZ4oHK4aV89WpMpv0fnnbhl7CD6SYEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkO-000128-C0
	for netdev@vger.kernel.org; Tue, 03 Sep 2024 11:22:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkJ-0059eJ-AF
	for netdev@vger.kernel.org; Tue, 03 Sep 2024 11:22:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E73AE331233
	for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 09:22:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 910AB33104E;
	Tue, 03 Sep 2024 09:22:28 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 05c965a7;
	Tue, 3 Sep 2024 09:22:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 03 Sep 2024 11:21:59 +0200
Subject: [PATCH can-next v4 17/20] can: rockchip_canfd: enable full TX-FIFO
 depth of 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rockchip-canfd-v4-17-1dc3f3f32856@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Rb+DPh6I1pIZR5OwMWvyyqc8QfjnlVzZzpFMC3B2FWI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm1tVMBeFSFmOa6zI4gd+z+CgPmODOkUkNzsxbx
 wWia+lv1ImJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtbVTAAKCRAoOKI+ei28
 b3h4B/wMzCZveqIFUd3Ln0diZ+eV2pI3Ak5fKS4j5/eaeMiQSbS4fDLMxl+HdEDoXA0mqf1CGXI
 5byvf8TafkEKEBMBH2kYDrgRc6OlQRxFcQVeTLlsAkp3g6GIlBKTtC9J6RtrKjyPsVxxOrZ0BeH
 2u1uuDhwwjeJLbq8BkmmsS50QgUg9remfMhLOscPp0ABokHPu8P8RTB7MQaGDwb1roIW0PsE3eb
 LRAbtO+3djse9CHqDEN0sOwzWGcHgB1mbTE/FPGdY5tNYkQn0s6IoWZCCtHGy/H2CjLG8ybTfSF
 hFmq/OvIRiEVypRP8tMP3VAMLMohm3H5faHhob3TyIj0+L7Z
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The previous commit prepared the TX path to make use of the full
TX-FIFO depth as much as possible. Increase the available TX-FIFO
depth to the hardware maximum of 2.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 37d90400429f..6be2865ec95a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -288,7 +288,7 @@
 
 #define DEVICE_NAME "rockchip_canfd"
 #define RKCANFD_NAPI_WEIGHT 32
-#define RKCANFD_TXFIFO_DEPTH 1
+#define RKCANFD_TXFIFO_DEPTH 2
 #define RKCANFD_TX_STOP_THRESHOLD 1
 #define RKCANFD_TX_START_THRESHOLD 1
 

-- 
2.45.2



