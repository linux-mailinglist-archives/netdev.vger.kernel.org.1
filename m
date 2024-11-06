Return-Path: <netdev+bounces-142361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D49BE858
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A1D2851DF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B21E0488;
	Wed,  6 Nov 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW5rSW8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F71DF994;
	Wed,  6 Nov 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895805; cv=none; b=Xjn7d9f8HHlOq9H6rzCfmqvL1nQS6pgKH0HnXnINujQZey/9kiE2z6j/nO5CYPQbbqqwxN7ULkfcPOZf3SoGMB26H7qQBlFmlsxci6VPanTLkofbklUNXkh4a0imoVOMm6XpGYtBaFJAo1FX3N77KB6YvmOHzZ4O4Vmux9DAW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895805; c=relaxed/simple;
	bh=EuVj+9OMIaLTyVuSZL6kdsE5pTRxnvf5fPLOoIor06I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2FWXHE9saqMTXykmY0O2szJPt/CMVV7WSLXm36+Yz7E3Jfk5862NbeRifq22CSvKS7VAR78fgbCq8grQGph1DXx6JLn34FFzd5peRnx6MXEsrcUOHJQiMV1BwlYTfFZkD5lK9pG/6ParrlNAJTmgHzvz3TBMw+ucP9qbROyZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW5rSW8g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315abed18aso55846905e9.2;
        Wed, 06 Nov 2024 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730895801; x=1731500601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZrFVIFCE+2ZVecKOZ8L2aVOCyo+e6QKd5kK73pNQH8=;
        b=WW5rSW8gNVCmWDY+pVLZ4xbwYGAJlKGwRCgIqotCDDlyWW6AAnxCf5+7amwLCaVvZD
         w5QznhFNsVwwSUlfD02WsmNSTNptrPNPXAgRbd6cAJmJHWbPP0r3qEXymwFCwymIcF6T
         q1XCitSzkiLGO/QdjUyO66l0ztG9MgknKFJIqvVZCaLEsJks6R0qCFlcFFOmwd2GOY7a
         nB4epE42fXaCJexvsSAs191WfOItNWn4WJzW8vLWEoZajBkP7q2gB/5kbrccfnfcOdb8
         mthGT42Cmbsaj2ieTGd3VOrEgGptMdreV5BPjPBSN3lqqtFMUp0UVskHsxWcSjtHzjzq
         7dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730895801; x=1731500601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZrFVIFCE+2ZVecKOZ8L2aVOCyo+e6QKd5kK73pNQH8=;
        b=fMKDOVz0QA+rizRIwSimWBMu8LZP/NadNSCKIbJ8Sh/JHr8ohnInu6Xl1TRcO7UuVc
         gNhrK//jhpxkVdF34YAO/SrYQfwuWFLU71pomY+kha0oBIrPcIE3B6fY/ZOFDRh9UVaQ
         KBnPf/dMxIL1gGnhwhd1eZhNIcvnyZ+YG4wR3eU2/LVMIvRGg80/hRVs0oqH0jlE0Uu4
         OvowccFdmLK3apLYlyhGf3+4BxJLqRZUgsa19d+R9JaRN8ouS5lYJHAWm2pQsllzRBBj
         DWADqKFHZuhmNfmEZg7JzUBhDXxVpMfIQ0pMQGa/HttHb3FwyqEsKHaNTWRoRvo5MYgi
         IsFA==
X-Forwarded-Encrypted: i=1; AJvYcCV+F/B6T4xfOxBokd5AjAtR7T9NND3Rzwa4z9P8J3+f0nYgd+VPjJd32J0H6e5vWPoUioiO1nBE@vger.kernel.org, AJvYcCV9uZ8rQ8mg+vbK8sJiN/OxrsOFejhvMRTvLxKXXTF3UyKGa3Qi0OwwacVz+w4OgIMzscFuDEVB7k3tPImx@vger.kernel.org, AJvYcCWUBaAFCWLWTyMt08G0LEnZMeKSY5jT2fQH/082xut7/IPIo58F0HivecgbvbPeoHMlqSe8lZ1BziRo@vger.kernel.org
X-Gm-Message-State: AOJu0YyHL7hbzICZUTAyYSTLTH9FIxfAmgJVq7uBiUtpAr8asp3y+7JT
	LiF46yoR0iTFc+6AmY2W4KHd/W5yFn6yqz7YjAnnyCoURCbdX1oG
X-Google-Smtp-Source: AGHT+IEj6hE+tQwtB/65FRGX1/cBAtHut3RMUlDjObqb+8G6xOtFXmNVjOC60buvXZBrwC+qjVAZ6Q==
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-4328328481dmr178997795e9.25.1730895801099;
        Wed, 06 Nov 2024 04:23:21 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa6b60e9sm20444155e9.14.2024.11.06.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:23:20 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v3 1/3] dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
Date: Wed,  6 Nov 2024 13:22:36 +0100
Message-ID: <20241106122254.13228-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106122254.13228-1-ansuelsmth@gmail.com>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 5 port Gigabit Switch documentation.

The switch node requires an additional mdio node to describe each internal
PHY absolute address on the bus.

Calibration values might be stored in switch EFUSE and internal PHY
might need to be calibrated, in such case, airoha,ext-surge needs to be
enabled and relative NVMEM cells needs to be defined in nvmem-layout
node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/dsa/airoha,an8855.yaml       | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
new file mode 100644
index 000000000000..8ea2fadbab85
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
@@ -0,0 +1,242 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  The switch node requires an additional mdio node to describe each internal
+  PHY relative offset as the PHY address for the switch match the one for
+  the PHY ports. On top of internal PHY address, the switch base PHY address
+  is added.
+
+  Also the switch base PHY address can be configured and changed after the
+  first initialization. On reset, the switch PHY address is ALWAYS 1.
+
+properties:
+  compatible:
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  airoha,ext-surge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Calibrate the internal PHY with the calibration values stored in EFUSE
+      for the r50Ohm values.
+
+  '#nvmem-cell-cells':
+    const: 0
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+    description:
+      NVMEM Layout for exposed EFUSE. (for example to propagate calibration
+      value for r50Ohm for internal PHYs)
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Define the absolute address of the internal PHY for each port.
+
+$ref: dsa.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
+            reset-gpios = <&pio 39 0>;
+
+            airoha,ext-surge;
+
+            #nvmem-cell-cells = <0>;
+
+            nvmem-layout {
+                compatible = "fixed-layout";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                    reg = <0xc 0x4>;
+                };
+
+                shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                    reg = <0x10 0x4>;
+                };
+
+                shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                    reg = <0x14 0x4>;
+                };
+
+                shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                    reg = <0x18 0x4>;
+                };
+
+                shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                    reg = <0x1c 0x4>;
+                };
+
+                shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                    reg = <0x20 0x4>;
+                };
+
+                shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                    reg = <0x24 0x4>;
+                };
+
+                shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                    reg = <0x28 0x4>;
+                };
+
+                shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
+                    reg = <0x2c 0x4>;
+                };
+
+                shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
+                    reg = <0x30 0x4>;
+                };
+
+                shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
+                    reg = <0x34 0x4>;
+                };
+
+                shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
+                    reg = <0x38 0x4>;
+                };
+
+                shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
+                    reg = <0x4c 0x4>;
+                };
+
+                shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
+                    reg = <0x50 0x4>;
+                };
+
+                shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
+                    reg = <0x54 0x4>;
+                };
+
+                shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
+                    reg = <0x58 0x4>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy1>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy2>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy3>;
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy4>;
+                };
+
+                port@5 {
+                    reg = <5>;
+                    label = "cpu";
+                    ethernet = <&gmac0>;
+                    phy-mode = "2500base-x";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: phy@1 {
+                    reg = <1>;
+
+                    nvmem-cells = <&shift_sel_port0_tx_a>,
+                                  <&shift_sel_port0_tx_b>,
+                                  <&shift_sel_port0_tx_c>,
+                                  <&shift_sel_port0_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: phy@2 {
+                    reg = <2>;
+
+                    nvmem-cells = <&shift_sel_port1_tx_a>,
+                                  <&shift_sel_port1_tx_b>,
+                                  <&shift_sel_port1_tx_c>,
+                                  <&shift_sel_port1_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy3: phy@3 {
+                    reg = <3>;
+
+                    nvmem-cells = <&shift_sel_port2_tx_a>,
+                                  <&shift_sel_port2_tx_b>,
+                                  <&shift_sel_port2_tx_c>,
+                                  <&shift_sel_port2_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy4: phy@4 {
+                    reg = <4>;
+
+                    nvmem-cells = <&shift_sel_port3_tx_a>,
+                                  <&shift_sel_port3_tx_b>,
+                                  <&shift_sel_port3_tx_c>,
+                                  <&shift_sel_port3_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
-- 
2.45.2


