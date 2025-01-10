Return-Path: <netdev+bounces-157124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A02A08F52
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC973A4965
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026020DD64;
	Fri, 10 Jan 2025 11:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3720CCE1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508447; cv=none; b=Wkyy8byj0c1TuMpPahPyTdhSmZumEu6uPBIVahm+vzo9/x3XIVNmDLD8sRQ3cancUV36r0l1TZe2bPj6Ye86iuVcjxWa6+TtUoM4Z2nXbBa3spJbOnpD4rAkuXS/SdXRV0gKjzpovV3yJ1YWKhKx2F3IyXlCMAFI+9mWHlJmyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508447; c=relaxed/simple;
	bh=5WZoNl6FYahmcNjdkY1RLhHEL1bpj5DQZ9FaV4eXDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7YJnR/C1Lp6grP0IzmsuOk+XilxBU4RUdJbkIPX5varKa58PpcUSTI2p5URBFiD8VzKeJ1GSNAa0bGrav7U/B356AnSUiHhXVTljnNmDh2U9WXiHuuDfJkVz7Nq9Teu+PE8sKXten8/UoMqp3ILAz43vrdZcgDrom8QSXdgjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00054R-Dj
	for netdev@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAd-0009iJ-0q
	for netdev@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EB4F63A461B
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5DBD83A45A9;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8453415e;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 14/18] dt-bindings: can: st,stm32-bxcan: fix st,gcan property type
Date: Fri, 10 Jan 2025 12:04:22 +0100
Message-ID: <20250110112712.3214173-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

The SRAM memory shared pointed to by the st,gcan property is unique, so
we don't need an array of phandles.

Fixes: e43250c0ac81 ("dt-bindings: net: can: add STM32 bxcan DT bindings")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20241228150043.3926696-1-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
index de1d4298893b..c7510b00954a 100644
--- a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
@@ -63,7 +63,7 @@ properties:
     maxItems: 1
 
   st,gcan:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The phandle to the gcan node which allows to access the 512-bytes
       SRAM memory shared by the two bxCAN cells (CAN1 primary and CAN2
-- 
2.45.2



