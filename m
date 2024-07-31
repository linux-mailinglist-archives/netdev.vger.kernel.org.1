Return-Path: <netdev+bounces-114475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B1942AEF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5291F25C24
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D51B29AB;
	Wed, 31 Jul 2024 09:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D091B1407
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418697; cv=none; b=X8sCcNB92qVYXZG1NYcece2WXAhwfxeTwgmk31r5U+FP1wrUlotOklD80VTr3QCJF2un1IbNJdQyqvIVLlgJ2JCgJIfKeGoB+dxqKxzzklRhZTYoWkvprw+76Mt09XJvodpA3z7y9cXrflu4n6vfCkkZgVaQdm1v1hFj0zWMh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418697; c=relaxed/simple;
	bh=BlcxfAqSbXd3sZ1Kv2UZQvKnGTWSAqMMKwm64wMXdjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6qACHDm6M29v0Oxh1c9p9G3YjKW1vMOtjxTDnyecBvYy3CPBADITZCqB/2h90v/SNemKNsaB8LdBiy6M86k2xMT9ccC+OBmKN0ycHf+W7sy6R6couIk5kvGi2pfUUvh4+Fm1AowupJ6ZNdoBhtPqoy6A6piOyZNTC6vyvRa2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mc-0005pA-Mw
	for netdev@vger.kernel.org; Wed, 31 Jul 2024 11:38:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mU-003Uys-CV
	for netdev@vger.kernel.org; Wed, 31 Jul 2024 11:38:02 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1216F31297D
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:38:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DD56B31288D;
	Wed, 31 Jul 2024 09:37:55 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a11d2bf2;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:19 +0200
Subject: [PATCH can-next v2 17/20] can: rockchip_canfd: enable full TX-FIFO
 depth of 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-17-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BlcxfAqSbXd3sZ1Kv2UZQvKnGTWSAqMMKwm64wMXdjk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmqgXfc1xcLfflpZUZCDKNBLwAjolA6mgvp0Phc
 rTYFnvoSqeJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqoF3wAKCRAoOKI+ei28
 b/BkCACYdKDR8Lv2DB4V7gDtJiZnJvQGx4DMCLuXWyVkuEHhDI7w5hT7KsYYPyoGIvQHy4RexY0
 i4f3HEIQbvwYARDccdQb5VJBkiQQAZWWIQzBotuMoUyRLPZww38d+L2FlPX7uRxxcqp4AJ/yKye
 aPpCaMlFX9ktEj4qHYT9yXQwLObMqtjRc14cfuohdak+iUQMBYdwEqtkpBZNDp3hSqFXV76LFiY
 lB7ewsXxBJg8fdemFewWaoWVlwyk0OmpHyLcLFPZwS4N7fpx2foNz0+QXug7U0kZUYLqqsCq4W6
 V9c1YTpeAJZGuP3sK6AvwpNbmBTqiqjB8CQRpuFomZn/63+1
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
2.43.0



