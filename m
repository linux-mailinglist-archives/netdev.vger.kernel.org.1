Return-Path: <netdev+bounces-179093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11385A7A923
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582433AC0CE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C51253331;
	Thu,  3 Apr 2025 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkOxBJId"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623A251780
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704370; cv=none; b=ZqIGuutl2NsTvMTXMmCiksoJUlCmyPkg49qZ9y/DuB0WPwTG/jtuSc5SHVPTVMPP5OEtmn1lW6znafmeiUQcaFsrQMbKd8rJ9E0eBPZQh30pVhHi1o8AmbKIbFD0WsZoDittUQy0EdsS32s10OApPhfNkc9y4sV1/hbDHqPKBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704370; c=relaxed/simple;
	bh=xVE2lXOKmBCKTcYCr499G6FhNYWBcLBfWfpnJWoEQT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYx0sphNaW5UdTmGgTuQ5FjDs30iwBtSndOnC4oh+a6N7wUrCoeX2CyOYalURGN0aZoKyyn0yoKttQIZm0RYM/eXPtU4mIAf1gIRPl3AjN3cyrVa2zpi4d0zFEPL6ioRpxKkSyD6pAFaFfsui4SMDf02ti755Jwd8uwCaLrPatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkOxBJId; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBvHqHOnFT/ZCUCG3ape7UEeqS5DfFtchmilRVe8jjI=;
	b=ZkOxBJIdhSlhsgcEaEj1hjohe+Awg+08todA7TDEBfkIAzP7TT0L5LVg87dTo+S5KhNjkI
	3MaLys214tLGmNyvX3yrD/tA1icqqNaus6rLCYxVcoOipQtd6NKFaPX7zNr+D+T9DZ8olp
	I9elhS7m+uSmfkYq8wWFCK6/dr7XIjA=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	upstream@airoha.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh@kernel.org>,
	Robert Hancock <robert.hancock@calian.com>,
	devicetree@vger.kernel.org
Subject: [RFC net-next PATCH 01/13] dt-bindings: net: Add binding for Xilinx PCS
Date: Thu,  3 Apr 2025 14:18:55 -0400
Message-Id: <20250403181907.1947517-2-sean.anderson@linux.dev>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds a binding for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII
LogiCORE IP. This device is a soft device typically used to adapt
between GMII and SGMII or 1000BASE-X (possbilty in combination with a
serdes). pcs-modes reflects the modes available with the as configured
when the device is synthesized. Multiple modes may be specified if
dynamic reconfiguration is supported.

One PCS may contain "shared logic in core" which can be connected to
other PCSs with "shared logic in example design." This primarily refers
to clocking resources, allowing a reference clock to be shared by a bank
of PCSs. To support this, if #clock-cells is defined then the PCS will
register itself as a clock provider for other PCSs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../devicetree/bindings/net/xilinx,pcs.yaml   | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/xilinx,pcs.yaml b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
new file mode 100644
index 000000000000..56a3ce0c4ef0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xilinx,pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE IP
+
+maintainers:
+  - Sean Anderson <sean.anderson@seco.com>
+
+description:
+  This is a soft device which implements the PCS and (depending on
+  configuration) PMA layers of an IEEE Ethernet PHY. On the MAC side, it
+  implements GMII. It may have an attached SERDES (internal or external), or
+  may directly use LVDS IO resources. Depending on the configuration, it may
+  implement 1000BASE-X, SGMII, 2500BASE-X, or 2.5G SGMII.
+
+  This device has a notion of "shared logic" such as reset and clocking
+  resources which must be shared between multiple PCSs using the same I/O
+  banks. Each PCS can be configured to have the shared logic in the "core"
+  (instantiated internally and made available to other PCSs) or in the "example
+  design" (provided by another PCS). PCSs with shared logic in the core are
+  reset controllers, and generally provide several resets for other PCSs in the
+  same bank.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: xilinx,pcs-16.2
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+    description:
+      Register a clock representing the clocking resources shared with other
+      PCSs.
+
+  clocks:
+    items:
+      - description:
+          The reference clock for the PCS. Depending on your setup, this may be
+          the gtrefclk, refclk, clk125m signal, or clocks from another PCS.
+
+  clock-names:
+    const: refclk
+
+  done-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the reset-done output, if present.
+
+  interrupts:
+    items:
+      - description:
+          The an_interrupt autonegotiation-complete interrupt.
+
+  interrupt-names:
+    const: an
+
+  pcs-modes:
+    description:
+      The interfaces that the PCS supports.
+    oneOf:
+      - const: sgmii
+      - const: 1000base-x
+      - const: 2500base-x
+      - items:
+          - const: sgmii
+          - const: 1000base-x
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the reset input.
+
+required:
+  - compatible
+  - reg
+  - pcs-modes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pcs0: ethernet-pcs@0 {
+            #clock-cells = <0>;
+            compatible = "xlnx,pcs-16.2";
+            reg = <0>;
+            clocks = <&si570>;
+            clock-names = "refclk";
+            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "an";
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+            done-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            pcs-modes = "sgmii", "1000base-x";
+        };
+
+        pcs1: ethernet-pcs@1 {
+            compatible = "xlnx,pcs-16.2";
+            reg = <1>;
+            clocks = <&pcs0>;
+            clock-names = "refclk";
+            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "an";
+            reset-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            done-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+            pcs-modes = "sgmii", "1000base-x";
+        };
+
+        pcs2: ethernet-pcs@2 {
+            compatible = "xlnx,pcs-16.2";
+            reg = <2>;
+            pcs-modes = "sgmii";
+        };
+    };
-- 
2.35.1.1320.gc452695387.dirty


