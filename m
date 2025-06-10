Return-Path: <netdev+bounces-196368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0651FAD46B5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0233A7F3C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE928B7EE;
	Tue, 10 Jun 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wRWzVcOa"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7726E70B
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598309; cv=none; b=bkjvczzapQZZaWmq+3D6cj5wkDSUaLYctcDXCBvce290hyUjw/Cv4kNPAX0kxKTlUZFqkrFnf7U3+7yuIkrCuma53wBhN64bunRx2XxYmLXSG7/KlbDHXWtDLDsvNvaRWrxrD2fllG7g6nQOPMsTQ59zEqZyXJf3r2eOzyW8bQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598309; c=relaxed/simple;
	bh=4Rk4PcZp/P0dgRokTbY66gQ53B57GAnzFe0P29JFxrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7s05MlJwZYpqtmwDKYYSZ9RAqXKSm9rX5IS/v17x7/sftwKXf2vaiYRY6wcoz1ZgNiFKZJpqZGkBmu8GI3/Tq+b/QVQcvciVK+59G59APbWUQJgsajNsc5gW+lp33XNAzJQHcxAydoS6pNUDicEPaBae/egC1JrE0hz8V10fTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wRWzVcOa; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOaKt+XhutGsACo0AIeTjd+wJVp9zlX2M1zDj3epVuo=;
	b=wRWzVcOalWralpljSZBtABeIpDrwhCoLsoRM0ng1KJSS/flJLAOcTR9ojSRhTQi/YoMMFx
	0cbUWAoxrnuE4PpT9tKnQS/oIkr6jE3fp0gdIwivFPk+0TKsyAetaT9Hbld1+HZd+6k5N/
	/lpU/j3kjtGz5usKdWg2rW324IN2meo=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	devicetree@vger.kernel.org
Subject: [net-next PATCH v6 01/10] dt-bindings: net: Add Xilinx PCS
Date: Tue, 10 Jun 2025 19:31:25 -0400
Message-Id: <20250610233134.3588011-2-sean.anderson@linux.dev>
In-Reply-To: <20250610233134.3588011-1-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a binding for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE
IP. This device is a soft device typically used to adapt between GMII
and SGMII or 1000BASE-X (possbilty in combination with a serdes).
pcs-modes reflects the modes available with the as configured when the
device is synthesized. Multiple modes may be specified if dynamic
reconfiguration is supported.

One PCS may contain "shared logic in core" which can be connected to
other PCSs with "shared logic in example design." This primarily refers
to clocking resources, allowing a reference clock to be shared by a bank
of PCSs. To support this, if #clock-cells is defined then the PCS will
register itself as a clock provider for other PCSs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

(no changes since v3)

Changes in v3:
- Add '>' modifier for paragraph to description
- Edit description to reference clocks instead of resets

Changes in v2:
- Change base compatible to just xlnx,pcs
- Drop #clock-cells description
- Move #clock-cells after compatible
- Remove second example
- Rename pcs-modes to xlnx,pcs-modes
- Reword commit message

 .../devicetree/bindings/net/xilinx,pcs.yaml   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/xilinx,pcs.yaml b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
new file mode 100644
index 000000000000..11bbae6936eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
@@ -0,0 +1,114 @@
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
+description: >
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
+  design" (provided by another PCS). PCSs with shared logic in the core provide
+  a clock for other PCSs in the same bank.
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,pcs-16.2
+      - const: xlnx,pcs
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
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
+  xlnx,pcs-modes:
+    description:
+      The interfaces that the PCS supports. Multiple interfaces may be
+      specified if dynamic reconfiguration is enabled.
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
+  - xlnx,pcs-modes
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
+            compatible = "xlnx,pcs-16.2", "xlnx,pcs";
+            reg = <0>;
+            #clock-cells = <0>;
+            clocks = <&si570>;
+            clock-names = "refclk";
+            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "an";
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+            done-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            xlnx,pcs-modes = "sgmii", "1000base-x";
+        };
+
+        pcs1: ethernet-pcs@1 {
+            compatible = "xlnx,pcs-16.2", "xlnx,pcs";
+            reg = <1>;
+            xlnx,pcs-modes = "sgmii";
+            clocks = <&pcs0>;
+            clock-names = "refclk";
+        };
+    };
-- 
2.35.1.1320.gc452695387.dirty


