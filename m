Return-Path: <netdev+bounces-157119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74319A08F4B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09E716A6CB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6D20D4ED;
	Fri, 10 Jan 2025 11:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A420CCC5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508446; cv=none; b=OChwQ5jnKDe18lbLhd23HdgKQaSy7cESdKlylXA6MChfm/ekxEK7Ma5wVvN64xN0u97NeHSBL609PNRsN/Wnzd5YSovYjsQC4+qKxGgtJDlGNndiYar9D1cHUwO47s4LX/MK58ssgpbWrv1jz3yeKHvrlWeUqruMKsvfhiWNxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508446; c=relaxed/simple;
	bh=qnN58YsuQTzfmgZQMtdiRBvYXrWYo8wwBnDtplWKtl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVPk2a8wGdLkxVghP3isz6yb1TCoIV9WFWzExLQJbz7Mm4B4+gg3OAZew+VmhA0XBXNXI8dYyu4Urm0KCfGMFHUi2L872jsK6HoulK66EC5NVxtIDel6jzMN/5ITKe8t0I3UXOlumZEAxSu1wOqloXD+dsFxoaepJJOERNuLftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAf-00053d-ON
	for netdev@vger.kernel.org; Fri, 10 Jan 2025 12:27:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAc-0009he-2v
	for netdev@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7B1013A4611
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C4A1F3A4597;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cca0c545;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Charan Pedumuru <charan.pedumuru@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/18] dt-bindings: net: can: atmel: Convert to json schema
Date: Fri, 10 Jan 2025 12:04:15 +0100
Message-ID: <20250110112712.3214173-8-mkl@pengutronix.de>
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

From: Charan Pedumuru <charan.pedumuru@microchip.com>

Convert old text based binding to json schema.
Changes during conversion:
- Add a fallback for `microchip,sam9x60-can` as it is compatible with the
  CAN IP core on `atmel,at91sam9x5-can`.
- Add the required properties `clock` and `clock-names`, which were
  missing in the original binding.
- Update examples and include appropriate file directives to resolve
  errors identified by `dt_binding_check` and `dtbs_check`.

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20241120-can-v3-1-da5bb4f6128d@microchip.com
[mkl: fixed indention in example]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/atmel,at91sam9263-can.yaml        | 58 +++++++++++++++++++
 .../devicetree/bindings/net/can/atmel-can.txt | 15 -----
 2 files changed, 58 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt

diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
new file mode 100644
index 000000000000..c818c01a718b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 CAN Controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9263-can
+          - atmel,at91sam9x5-can
+      - items:
+          - enum:
+              - microchip,sam9x60-can
+          - const: atmel,at91sam9x5-can
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: can_clk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    can@f000c000 {
+          compatible = "atmel,at91sam9263-can";
+          reg = <0xf000c000 0x300>;
+          interrupts = <30 IRQ_TYPE_LEVEL_HIGH 3>;
+          clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
+          clock-names = "can_clk";
+    };
diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
deleted file mode 100644
index 218a3b3eb27e..000000000000
--- a/Documentation/devicetree/bindings/net/can/atmel-can.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* AT91 CAN *
-
-Required properties:
-  - compatible: Should be "atmel,at91sam9263-can", "atmel,at91sam9x5-can" or
-    "microchip,sam9x60-can"
-  - reg: Should contain CAN controller registers location and length
-  - interrupts: Should contain IRQ line for the CAN controller
-
-Example:
-
-	can0: can@f000c000 {
-		compatible = "atmel,at91sam9x5-can";
-		reg = <0xf000c000 0x300>;
-		interrupts = <40 4 5>
-	};
-- 
2.45.2



