Return-Path: <netdev+bounces-224294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD02B83884
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B6F17DBF8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9432F8BEE;
	Thu, 18 Sep 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P2G932N/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97362F549D;
	Thu, 18 Sep 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184449; cv=none; b=cXDvbnLw/7SEZcRiW1Ca0xTDtuPbaUDy8Cs3dJfiOJQkkXlCFYLbBNLT+FR6yYMgaYYYG4AmC51ZrxsjsQkgXzGMtBtWO7tYBKMuduuZa/422OyYHrJMWNeJVTqlXsAJt72ajsvu45+vGF+abdM75MMYlBzyVNMz8kf2VjH52uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184449; c=relaxed/simple;
	bh=0LE5CMKztylMWzf5OmUCksRfrSOx6vertoNG0dXiE0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXOrrRbTovdk3IEC/6nF6ZPhgZ08cCSSs/ivYijdl6z5pLB/Fb65G39uBMq//Pe88ja6XrE/fphUi64cdZJgeqYZk31TF9dfUO5UZiSJjjCTM0bu6tgdj+80DmFNoi/vYRh6xt0YpQeA/MaDtNWeSziEoThOu3QGYQ+355J/4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P2G932N/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B206BC00091;
	Thu, 18 Sep 2025 08:33:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B4A16062C;
	Thu, 18 Sep 2025 08:34:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB3C6102F1CA4;
	Thu, 18 Sep 2025 10:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wco5og6PxoPGaVfMfkjz/oyPR7pgqy7wjoXlpbqsw1Q=;
	b=P2G932N/rQYBdoDcyTNONL7ZHlP19QVB8sxA15G1Ccs3IUE8v8O7x9bPyNSUL2VomMFJoP
	AKnQ6BB6eEWWnYf4hGMZC1zx8TcDWxbjxOZxHH5IgfGL1scnJJekZJw9LWXB4RIigGC2lM
	Uffo9nZjisBL/Ixmb0q5ic7CD9SGd0uzeJ9TLjpmGNUGnM4NRvpj+1kpUf4IeN99SWLFEp
	hIlmCeRKuzk5oqqMAde/k8HxUiKLFZWM3Y21WfdlBHVvxLpBqyCMyQVgk1MJvatQB11CY6
	bXu6zh90MMW4OBdTVjpe7D1+BEhF97GxzReqiF+QqD2Vb5y/dPGICBCYI86BKg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 18 Sep 2025 10:33:51 +0200
Subject: [PATCH net-next v3 2/3] dt-bindings: net: dsa: microchip: Add
 strap description to set SPI mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ksz-strap-pins-v3-2-16662e881728@bootlin.com>
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
In-Reply-To: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At reset, KSZ8463 uses a strap-based configuration to set SPI as
interface bus. If the required pull-ups/pull-downs are missing (by
mistake or by design to save power) the pins may float and the
configuration can go wrong preventing any communication with the switch.

Add a 'reset' pinmux state
Add a KSZ8463 specific strap description that can be used by the driver
to drive the strap pins during reset. Two GPIOs are used. Users must
describe either both of them or none of them.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index db8175b4ced6d136ba97c371b68ba993637e444a..a8c8009414ae00b1a60aad715e15c23343e241ff 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -34,6 +34,13 @@ properties:
       - microchip,ksz8567
       - microchip,lan9646
 
+  pinctrl-names:
+    items:
+      - const: default
+      - const: reset
+        description:
+          Used during reset for strap configuration.
+
   reset-gpios:
     description:
       Should be a gpio specifier for a reset line.
@@ -139,6 +146,18 @@ allOf:
                     should be provided externally.
               dependencies:
                 microchip,rmii-clk-internal: [ethernet]
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,ksz8463
+    then:
+      properties:
+        straps-rxd-gpios:
+          description:
+            RXD0 and RXD1 pins, used to select SPI as bus interface.
+          minItems: 2
+          maxItems: 2
 
 unevaluatedProperties: false
 

-- 
2.51.0


