Return-Path: <netdev+bounces-123880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CD966B6C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA8A1C2239F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608A1C1757;
	Fri, 30 Aug 2024 21:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869F1B5304
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054259; cv=none; b=ep+5zOcsPSLgqb+2j8u/NuSDlpknfzI2Ap4y/M3eaEQBKvacOrOKrMU4DEfwkdWTeYna1QW/Xg8ZJkAwf61KEiMlMg0BcTCEDm02N2jdd57XrFKKsvWlvrRsgkAO6aW2NWZCo7uN6Afisjgc2JBOjHQu6H22ax1+/i5Dj4X98iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054259; c=relaxed/simple;
	bh=K+aNE6xY81gBfaUyJFWAxOwY/yjwy9DN64loW/izHIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lacWeLtrkHDxd5sA8rBHqpQbkEM1C1TK0ZQU3r5bozBNJMWLy2SO0CmYNg0OAhjIa7kl1Pko5Vn0WxaRlkS17vla9L4qwXSYutaHG3l3bFqyGSldV+XhB0Jtw/3gRquPFHLKdvcJWXbQt2mkNclBDf4FNjPcdyYpdcrDBUOJRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pj-0002gy-Ke
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:44:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pi-004FNb-8m
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:44:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EEC8632E47E
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:44:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E58D032E450;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff443a91;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/6] dt-bindings: can: convert microchip,mcp251x.txt to yaml
Date: Fri, 30 Aug 2024 23:34:35 +0200
Message-ID: <20240830214406.1605786-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830214406.1605786-1-mkl@pengutronix.de>
References: <20240830214406.1605786-1-mkl@pengutronix.de>
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

From: Frank Li <Frank.Li@nxp.com>

Convert binding doc microchip,mcp251x.txt to yaml.
Additional change:
- add ref to spi-peripheral-props.yaml

Fix below warning:
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/spi@5a020000/can@0:
	failed to match any schema with compatible: ['microchip,mcp2515']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20240814164407.4022211-1-Frank.Li@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/microchip,mcp2510.yaml   | 70 +++++++++++++++++++
 .../bindings/net/can/microchip,mcp251x.txt    | 30 --------
 2 files changed, 70 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
new file mode 100644
index 000000000000..db446dde6842
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/can/microchip,mcp2510.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP251X stand-alone CAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp2510
+      - microchip,mcp2515
+      - microchip,mcp25625
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@1 {
+             compatible = "microchip,mcp2515";
+             reg = <1>;
+             clocks = <&clk24m>;
+             interrupt-parent = <&gpio4>;
+             interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+             vdd-supply = <&reg5v0>;
+             xceiver-supply = <&reg5v0>;
+             gpio-controller;
+             #gpio-cells = <2>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
deleted file mode 100644
index 381f8fb3e865..000000000000
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Microchip MCP251X stand-alone CAN controller device tree bindings
-
-Required properties:
- - compatible: Should be one of the following:
-   - "microchip,mcp2510" for MCP2510.
-   - "microchip,mcp2515" for MCP2515.
-   - "microchip,mcp25625" for MCP25625.
- - reg: SPI chip select.
- - clocks: The clock feeding the CAN controller.
- - interrupts: Should contain IRQ line for the CAN controller.
-
-Optional properties:
- - vdd-supply: Regulator that powers the CAN controller.
- - xceiver-supply: Regulator that powers the CAN transceiver.
- - gpio-controller: Indicates this device is a GPIO controller.
- - #gpio-cells: Should be two. The first cell is the pin number and
-                the second cell is used to specify the gpio polarity.
-
-Example:
-	can0: can@1 {
-		compatible = "microchip,mcp2515";
-		reg = <1>;
-		clocks = <&clk24m>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&reg5v0>;
-		xceiver-supply = <&reg5v0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-- 
2.45.2



