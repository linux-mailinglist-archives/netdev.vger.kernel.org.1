Return-Path: <netdev+bounces-244803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81212CBEF1B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 251C130146EC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0599331232;
	Mon, 15 Dec 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YnPx5LAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEC3128B6
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816716; cv=none; b=jDVsCygazCH86B/aoV/LN+PrGe4Qkv5PYGPb9UAJZqS4xVhOOPv11Ma7MvCHj5U57CIGl1tdmKc0BDrcxfzuTFvI4RuTkHfkohbKbNOrTMfss+D1i3gBb7oEYM+CLoYKPJDoPY9xTYInNcS8pV7UFtpfcBjPn+q8Ff6SpNobz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816716; c=relaxed/simple;
	bh=YtDrhz214maGpV2hZoz5P9MBOOxn5+fyXOlqcl1OMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmflpMKV2XNHjnM43vou15RdWaIZzmTf9zwY567U7jFx7XEWOKRBPGq4eIS9C0IL0C8/hUtz9jvlN96mP9Gt3uzAmSyt2X9QNU1s3qDRWpnZ7B8SxkfPMbaTct7k+k91CX/d+KRp1MacGpKZaEz9Q+nkzTpAAMNXUAnyD8SXeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YnPx5LAD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a8195e515so30233705e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816712; x=1766421512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=YnPx5LADHooQfHmE6ykE1da16k0NjskImATy7uqlFvTBNvCCQH2WAT0l49qLplLOaM
         J5jbVuV6MDQ031Uof1vE++YZQMfRdffMXKYB7YxOXfCSj/7Zpt1IEwEXOCiP0+l466k9
         6tqcY4fC35uQYdlAPDqfgt7jC0COjonwLDwDZFVdSd90XPWey6Zo9NopDkBerGdhosG6
         kx2v/uqWGu83kPNLUOU0SpJrR3qAYVzyPcOeMvhOC0uXq7QnT8DWUXDtyBcYsVyLeERS
         z+x/pwLGeLLxUQ0rzWmjr33izxdxv4JS7tBIlFSFFJR+i+zwfU3ab00QiVnqoWHy4iSe
         iZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816712; x=1766421512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=TTNRS4vul4OG/n8gz2Cg+NLYhwLzqbOl+OSE9bwWNUHeg26bxYqsRrM/dD03Kymwng
         0cWs1R6a5slPsYTZNPXaCAP8nNWyQrds637HOPPT5LxAGCBNV/BkcNY27HpdnpQ5hhZp
         LYXnbm78/o7QqYZZ7AiOUHuwxkDIo7UCBDl7HWOicHfkvjIfjI88BgDixSOcpK1gqi+4
         PVf5ZIscQjKgx/vkbOKMMB2MHzx9REHrU4LodEuIXFMY8XZcV0V2RUBBfVAUeHYzmiam
         wU1kcpV34qOiwTRL68Rzt0WaMoJ5/Ei0KRn+XZZQYUylvIzS7HOpkAyGZMwtuqqG3WLh
         BS0A==
X-Forwarded-Encrypted: i=1; AJvYcCV/w7BeVGIofPync3QVKS0X5FW1pB2jOPAamOnhlN+4+1YNUe8ryQWrZMKVLQvrdBRxZXuEaIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOSWZm+WfCW7qreDLZiqWjpOtdHsHLmfBdq7fHteWS06PE0Ac
	JjWRpuvMLaj5bxn97ROUwd5UP17zoBNaGcUlzOHj/5zG3qKXciGwhcsj1YRbePpL78c=
X-Gm-Gg: AY/fxX74o7AFoe8j05ac368Q+5DGOZ9lfbsrF4Da9bK5GfjLK1jLaDCgbWnXVuSrbQy
	CKvzyovG9tlXFWEAts1+GYSPg60bo+hrJNC2Q/9PxgvHWp6q8kJJt37A/7kP9Bi3uArlxA4UeeX
	gF/I+n35S1+nTWV9ftVnUQ2n0qjHEwdZSworiL19RHW8iXarGnwsqOeF193ljJbscJzsYgW6m/I
	dKaeMf3y061wgOCqAVWFmfz3+U2ZD4Wx1CiL0Y/8gyn/36hcaWiEg3WB5BPsQKGfxVHLn6heCvZ
	tJ5WoVZQTsWOVbBFFnWEEykHp0q9fXzVvEfegG0jKOHPfPZ/3+c9dGqqjxL4BFSQ8qLOa56Mf9D
	8nVGk3AJm8SbchAE4lRV+MDU7XbBbHnWiL2sVgaU5uFfoUOjF7EQKiM3oqjK394qhnXaQP/rTqr
	430VQUmYC/kwy5ehb+tLPk84uonidSJEDbWp/GUZ6SVsOLnN+zvNNKCAM=
X-Google-Smtp-Source: AGHT+IFeCHS7YG9Ek+7zJu3i6olxUvaN+c10eLM1oMJBARdN2+vi1MoaN/SefG9EfAqWjo+NykYUoQ==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118534745e9.24.1765816711687;
        Mon, 15 Dec 2025 08:38:31 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:31 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 02/19] dt-bindings: usb: Add Microchip LAN969x support
Date: Mon, 15 Dec 2025 17:35:19 +0100
Message-ID: <20251215163820.1584926-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
speed, so document it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Fix example indentation

 .../bindings/usb/microchip,lan9691-dwc3.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
new file mode 100644
index 000000000000..6b49ef0a6bdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,lan9691-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN969x SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - microchip,lan9691-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microchip,lan9691-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gated USB DRD clock
+      - description: Controller reference clock
+
+  clock-names:
+    items:
+      - const: bus_early
+      - const: ref
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/microchip,lan9691.h>
+
+    usb@300000 {
+        compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+        reg = <0x300000 0x80000>;
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks GCK_GATE_USB_DRD>,
+                 <&clks GCK_ID_USB_REFCLK>;
+        clock-names = "bus_early", "ref";
+    };
-- 
2.52.0


