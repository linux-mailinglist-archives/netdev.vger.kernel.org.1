Return-Path: <netdev+bounces-111854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0119339B3
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B617283AD4
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6082E416;
	Wed, 17 Jul 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfCjYCuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53C9445
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207769; cv=none; b=UvLmVbjnIee1l06rEUh/T69OUIEhFVNHND5Xvm5NgolAORcwcsXeXPs+iDarPq3HrcfWrgPuQllmAbEBz3a2TY1RhKKDvZ/TUs2m1N+2Mm1wHXBGe/m+U3ROLdoOjS4dDbkKE6VTOPlSP6Dpz1VpRSw1OKDvWjDq9i9No/4ACgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207769; c=relaxed/simple;
	bh=rEDmvGP/7HEHFsXeyIpKWdXY9i1W5sc+/b6JOs+P7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6W1GurVlQ27LnwRmRVKXejeRhP28nq3JU7BAXW/vx1YO+HWpRu+aLtpfWnM/SJPnz6iXMOnfTw5Ni7RHnvughLOWNt/7SIANUTYFRGrWQnu5fR7O5gedinfbyvPUhZT7dAd9octHCuGHJhDveU2jnGf5x7QIS5K0ZmS+//0ZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfCjYCuR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e99060b0dso6996070e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721207766; x=1721812566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAGwBZ5/2/abZOIQ/WbKa/E9jM19SDyxUXs27zwt33I=;
        b=sfCjYCuRIYgGdRXlFt+tkYky+qWK3RVw8phiip/M72GLvhVbeBjrSk2o1GJQOia9qv
         x7nEdgAYzU0STwQTAAoZGfePGD0DF22V2Ola1dVOIfP5vZ3It63dIzvVpP+y0OtJxcQn
         8zmN+2mtBMwQheYGRDVNLgAq2rOeJE0wYSaWraNFVbu+af9WcsRXomF6KSSCttF5ZIrp
         bz+PjTRrvx5FMONWYa+y8CQWwTpzLHHRrv6BqbcAZNewEAfQzyazw7KzyC7lIVawEFXo
         9CZuC++a6RX35YXXTxJjZV1hkRdQ3Gg7VvA7maCw7hYfg1y3ADPuoVUII8iBBZGgM+mw
         5Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721207766; x=1721812566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAGwBZ5/2/abZOIQ/WbKa/E9jM19SDyxUXs27zwt33I=;
        b=Os3zo13hnZoflUzpaJVDCzOvsJuKam/a1hcswcOBj78OYa1tbjXdgQtAkTcGo9Uwq7
         aNA/+dsB7PVseUlLFp7nCUXvGKlR2c3JhXaiO16gvLMzIoXZs5hfr2Cpn1VEV3b+YC9K
         7w7EnZG/2j6rG+RKtbP+j+/CjCN1sdw0fwbXkPx5eoEF3NkIf0J/vhEDMoqrFPdbIw/t
         iQaQT1nOspCx/KNjdpUQ6Rvxnw6RC6Q4R15d25tT+MbqAdD9hWAP9q1qnR4GBW9AYhEY
         /6e4zFCwDny2Ackhl/dDNU5k5T1t3wpSbRyRE9Z+fAFr5vyEYmBnSfT8slvWMpZB0v4e
         jyWA==
X-Forwarded-Encrypted: i=1; AJvYcCWsvh5J4LQXCDT5YY1+QuzWS9TBv1CbO4uJmYd/Gf38+Wl6foU0IgMefOI0n/1U7LE3WF3OZcStk9Yfw9JhJZxQU6fugxWN
X-Gm-Message-State: AOJu0Yyu18GI8EWjywc6AOKPLL98X+ZQ8kRnPAEGg/5f7mJDxKHPr9Ze
	u5ds3vwREqOAuKC8DXuRT+DPTmJRfuNeqY8CsySacl9Ht0h2gtBsvgnIOecjoI8=
X-Google-Smtp-Source: AGHT+IFHQSFYViOBOK8vHKeLMIdPnvlreP9K9gfs/GNi0dmjCSk5ciB2W8fe8e9J9+2ku1SnZm1oAg==
X-Received: by 2002:a05:6512:33ce:b0:52c:d5b3:1a6a with SMTP id 2adb3069b0e04-52ee53d34e2mr817777e87.28.1721207765677;
        Wed, 17 Jul 2024 02:16:05 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23cc5bsm195433585e9.2.2024.07.17.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:16:05 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Timur Tabi <timur@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: qcom,emac: convert to dtschema
Date: Wed, 17 Jul 2024 10:09:27 +0100
Message-ID: <20240717090931.13563-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the bindings for the Qualcomm EMAC Ethernet Controller from the
old text format to yaml.

Also move the phy node of the controller to be within an mdio block so
we can use mdio.yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../devicetree/bindings/net/qcom,emac.yaml    |  98 ++++++++++++++++
 .../devicetree/bindings/net/qcom-emac.txt     | 111 ------------------
 2 files changed, 98 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,emac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/qcom-emac.txt

diff --git a/Documentation/devicetree/bindings/net/qcom,emac.yaml b/Documentation/devicetree/bindings/net/qcom,emac.yaml
new file mode 100644
index 000000000000..cef65130578f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,emac.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+---
+$id: http://devicetree.org/schemas/net/qcom,emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm EMAC Gigabit Ethernet Controller
+
+maintainers:
+  - Timur Tabi <timur@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,fsm9900-emac
+      - enum:
+          - qcom,fsm9900-emac-sgmii
+          - qcom,qdf2432-emac-sgmii
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+if:
+  properties:
+    compatible:
+      const: qcom,fsm9900-emac
+then:
+  allOf:
+    - $ref: ethernet-controller.yaml#
+  properties:
+    clocks:
+      minItems: 7
+      maxItems: 7
+
+    clock-names:
+      items:
+        - const: axi_clk
+        - const: cfg_ahb_clk
+        - const: high_speed_clk
+        - const: mdio_clk
+        - const: tx_clk
+        - const: rx_clk
+        - const: sys_clk
+
+    internal-phy:
+      maxItems: 1
+
+    mdio:
+      $ref: mdio.yaml#
+      unevaluatedProperties: false
+
+  required:
+    - clocks
+    - clock-names
+    - internal-phy
+    - phy-handle
+    - mdio
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    emac0: ethernet@feb20000 {
+        compatible = "qcom,fsm9900-emac";
+        reg = <0xfeb20000 0x10000>,
+              <0xfeb36000 0x1000>;
+        interrupts = <76>;
+
+        clocks = <&gcc 0>, <&gcc 1>, <&gcc 3>, <&gcc 4>, <&gcc 5>,
+                 <&gcc 6>, <&gcc 7>;
+        clock-names = "axi_clk", "cfg_ahb_clk", "high_speed_clk",
+                      "mdio_clk", "tx_clk", "rx_clk", "sys_clk";
+
+        internal-phy = <&emac_sgmii>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
+
+    emac_sgmii: ethernet@feb38000 {
+        compatible = "qcom,fsm9900-emac-sgmii";
+        reg = <0xfeb38000 0x1000>;
+        interrupts = <80>;
+    };
diff --git a/Documentation/devicetree/bindings/net/qcom-emac.txt b/Documentation/devicetree/bindings/net/qcom-emac.txt
deleted file mode 100644
index 7ae8aa148634..000000000000
--- a/Documentation/devicetree/bindings/net/qcom-emac.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-Qualcomm Technologies EMAC Gigabit Ethernet Controller
-
-This network controller consists of two devices: a MAC and an SGMII
-internal PHY.  Each device is represented by a device tree node.  A phandle
-connects the MAC node to its corresponding internal phy node.  Another
-phandle points to the external PHY node.
-
-Required properties:
-
-MAC node:
-- compatible : Should be "qcom,fsm9900-emac".
-- reg : Offset and length of the register regions for the device
-- interrupts : Interrupt number used by this controller
-- mac-address : The 6-byte MAC address. If present, it is the default
-	MAC address.
-- internal-phy : phandle to the internal PHY node
-- phy-handle : phandle to the external PHY node
-
-Internal PHY node:
-- compatible : Should be "qcom,fsm9900-emac-sgmii" or "qcom,qdf2432-emac-sgmii".
-- reg : Offset and length of the register region(s) for the device
-- interrupts : Interrupt number used by this controller
-
-The external phy child node:
-- reg : The phy address
-
-Example:
-
-FSM9900:
-
-soc {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	emac0: ethernet@feb20000 {
-		compatible = "qcom,fsm9900-emac";
-		reg = <0xfeb20000 0x10000>,
-		      <0xfeb36000 0x1000>;
-		interrupts = <76>;
-
-		clocks = <&gcc 0>, <&gcc 1>, <&gcc 3>, <&gcc 4>, <&gcc 5>,
-			<&gcc 6>, <&gcc 7>;
-		clock-names = "axi_clk", "cfg_ahb_clk", "high_speed_clk",
-			"mdio_clk", "tx_clk", "rx_clk", "sys_clk";
-
-		internal-phy = <&emac_sgmii>;
-
-		phy-handle = <&phy0>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&mdio_pins_a>;
-	};
-
-	emac_sgmii: ethernet@feb38000 {
-		compatible = "qcom,fsm9900-emac-sgmii";
-		reg = <0xfeb38000 0x1000>;
-		interrupts = <80>;
-	};
-
-	tlmm: pinctrl@fd510000 {
-		compatible = "qcom,fsm9900-pinctrl";
-
-		mdio_pins_a: mdio {
-			state {
-				pins = "gpio123", "gpio124";
-				function = "mdio";
-			};
-		};
-	};
-
-
-QDF2432:
-
-soc {
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	emac0: ethernet@38800000 {
-		compatible = "qcom,fsm9900-emac";
-		reg = <0x0 0x38800000 0x0 0x10000>,
-		      <0x0 0x38816000 0x0 0x1000>;
-		interrupts = <0 256 4>;
-
-		clocks = <&gcc 0>, <&gcc 1>, <&gcc 3>, <&gcc 4>, <&gcc 5>,
-			 <&gcc 6>, <&gcc 7>;
-		clock-names = "axi_clk", "cfg_ahb_clk", "high_speed_clk",
-			"mdio_clk", "tx_clk", "rx_clk", "sys_clk";
-
-		internal-phy = <&emac_sgmii>;
-
-		phy-handle = <&phy0>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-		phy0: ethernet-phy@4 {
-			reg = <4>;
-		};
-	};
-
-	emac_sgmii: ethernet@410400 {
-		compatible = "qcom,qdf2432-emac-sgmii";
-		reg = <0x0 0x00410400 0x0 0xc00>, /* Base address */
-		      <0x0 0x00410000 0x0 0x400>; /* Per-lane digital */
-		interrupts = <0 254 1>;
-	};
-- 
2.45.2


