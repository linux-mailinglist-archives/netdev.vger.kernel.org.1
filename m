Return-Path: <netdev+bounces-203003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54772AF00F0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4097AD8B9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6E27F72D;
	Tue,  1 Jul 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKksomHT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415E27E7DA;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389089; cv=none; b=bXCISWv9I4LDWpGaHWOVNrrfGaQXvSadAfL7meJxrAz4V3g9rZBFqUMkmToAQiSwpSW7fsWaaA4CAwF0CEctJjWXQqMQ0iN9dxiFhkNrdo8v3AeCE1EnIDiNI7SlaIKUX3LCNrFfbEuHE6VCD93gRTgOXYIyb5pBfS0GTvwssjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389089; c=relaxed/simple;
	bh=8pDXLMIdjg7l7iGhqLIn7yMNQfVsnJSkhXUt6bPrRgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNUCJJGJIWHg/r+xAJRbZTqdiI+ljiqM2QyvcIumnypow4ROUFKZaEZqU0wBnD8qYc20strBGHr4nnGMSo+JuRlE7MS4utmv5HT5AKUgbKhXL/SaO8DttsMGSSthsHiEVfT3Os215kBfKL5ZxdC476bBGntfqoHe1AaCG76oY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKksomHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566BFC4AF09;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389088;
	bh=8pDXLMIdjg7l7iGhqLIn7yMNQfVsnJSkhXUt6bPrRgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKksomHTMgLqBBFiBPxvB+hjcKob5ZBWNC+cf16cQnyeN3zn7FNwg3T1Se4O+HUbb
	 XAKnJ4ZG56d4vJHn7SY8I5qNigfV+X/m2QHqEq8ynCnTzZKRv0DtEaePp4CaOJypQp
	 HNiQTRNGM8falFXgu8tEfwPu55FsNlptolffnikgexSorzEWkX6aCUDZrS2Haxr08Z
	 RF3WJ4cVoxjOCqY6Qs7CeNNdplPKBf9QuFNwibYOPVEamFGS92IFIaQxYJqZDhsd16
	 WXN8NekLqQ1lNX4GVTfGN4fM2FGflCkHtx/b8NmQPtvX5yt322IN9Y3JA1ZeRgZYGL
	 N04+sQXcqxt5g==
Received: by wens.tw (Postfix, from userid 1000)
	id B3A745F71D; Wed,  2 Jul 2025 00:58:05 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH RFT net-next 01/10] dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
Date: Wed,  2 Jul 2025 00:57:47 +0800
Message-Id: <20250701165756.258356-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Allwinner A523 SoC family has a second Ethernet controller, called
the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
numbering. This controller, according to BSP sources, is fully
compatible with a slightly newer version of the Synopsys DWMAC core.
The glue layer around the controller is the same as found around older
DWMAC cores on Allwinner SoCs. The only slight difference is that since
this is the second controller on the SoC, the register for the clock
delay controls is at a different offset. Last, the integration includes
a dedicated clock gate for the memory bus and the whole thing is put in
a separately controllable power domain.

Add a compatible string entry for it, and work in the requirements for
a second clock and a power domain.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../net/allwinner,sun8i-a83t-emac.yaml        | 68 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 2ac709a4c472..1058e5af92ba 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -26,6 +26,9 @@ properties:
               - allwinner,sun50i-h616-emac0
               - allwinner,sun55i-a523-gmac0
           - const: allwinner,sun50i-a64-emac
+      - items:
+          - const: allwinner,sun55i-a523-gmac200
+          - const: snps,dwmac-4.20a
 
   reg:
     maxItems: 1
@@ -37,14 +40,19 @@ properties:
     const: macirq
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    const: stmmaceth
+    minItems: 1
+    maxItems: 2
 
   phy-supply:
     description: PHY regulator
 
+  power-domains:
+    maxItems: 1
+
   syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -75,6 +83,7 @@ allOf:
               - allwinner,sun8i-h3-emac
               - allwinner,sun8i-v3s-emac
               - allwinner,sun50i-a64-emac
+              - allwinner,sun55i-a523-gmac200
 
     then:
       properties:
@@ -191,6 +200,31 @@ allOf:
             - mdio-parent-bus
             - mdio@1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun55i-a523-gmac200
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: mbus
+      required:
+        - power-domains
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: stmmaceth
+        power-domains: false
+
+
 unevaluatedProperties: false
 
 examples:
@@ -323,4 +357,34 @@ examples:
         };
     };
 
+  - |
+    ethernet@4510000 {
+        compatible = "allwinner,sun55i-a523-gmac200",
+                     "snps,dwmac-4.20a";
+        reg = <0x04510000 0x10000>;
+        clocks = <&ccu 117>, <&ccu 79>;
+        clock-names = "stmmaceth", "mbus";
+        resets = <&ccu 43>;
+        reset-names = "stmmaceth";
+        interrupts = <0 47 4>;
+        interrupt-names = "macirq";
+        pinctrl-names = "default";
+        pinctrl-0 = <&rgmii1_pins>;
+        power-domains = <&pck600 4>;
+        syscon = <&syscon>;
+        phy-handle = <&ext_rgmii_phy_1>;
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&gmac1_stmmac_axi_setup>;
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ext_rgmii_phy_1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
 ...
-- 
2.39.5


