Return-Path: <netdev+bounces-232777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA9C08C5B
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304AF1A65094
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89602D592D;
	Sat, 25 Oct 2025 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQxycQ4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996527E056
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761374946; cv=none; b=Ljn419CfIXdvVY3USsRbJ0YwdLioVlQcFp/NYmOIGz1jZqVoiOgYStuEem/rxTZyf+X1C+/mZpyBPTPdibpW2x7CW09dUJBtMGJa6bTZWv04Oo2Wxn8Tk0Zi5dIhvDC45Dt+KgCGsfolXRHY6j8sIrQhRaudIalYqyZgYOkcxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761374946; c=relaxed/simple;
	bh=pVTlcY1X+kIhO3r0God2rsT/x3/ox7cpLS4Nu9m5TXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPS3kGrT9IokFIPc8bk0s1+9kwLxcNtvjcdC8wIYtMqbNr1nIs1OmsJgVW1cHec/c8w7YHiod1+DOOwLGT3uqYAkL1mb8vUWPOamkWELurYQPHdaU0Ak5j7yENyXFgKpuo6NpupKZ3YerXl8RMy6He1EdaEbmkAt8MSquswILQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQxycQ4c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso3545729b3a.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761374944; x=1761979744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgMCq/BY+uw753rejJGDNmeTuTUhlxJMjMZ33QupS54=;
        b=iQxycQ4cNnpDD5x2RfsUUo7OVXQ2JpqvFL4CYGAGN2hDr/NHqfsmDJ63CXPQNFTfjL
         ZiRbRvx3mUoaPkdHNvalsJzWtUhh309hU5C+53NfnvsvlzjD8CZEZNxOPCjL2h0KZjnm
         Cen9qOEKSYEAewzXFHOOIBI1oSyZ1DK3J3W3xICfRkivY8LPKzemOfe6rqdSMjYiWwri
         Ha7Ajpnf6VybSDrCeMZzrs97ZC0SF0jofpFACViEQbUQEtBPMvZ4Rt7zorXj0ZGaiDmT
         VqjtgQJIjZKF/hLfvxToYJwi7j5q5gjPL4U3J+Q9aZMe2+ReVWK+pAH/mCKz2zubYE0M
         4IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761374944; x=1761979744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgMCq/BY+uw753rejJGDNmeTuTUhlxJMjMZ33QupS54=;
        b=uSiRTfg5ElJBdWgi37e06GF5SaUKx5NCwbQk5gI9KLqvgETDEO64LPFH9poicsRhVS
         mlOyJRU1ivQJH05NSqd99fEuK1RsSEx1X+01J6ydetroNtM5vHKf/4A/Vj+Ra9n6L06x
         iRhNcBaJFVQ1LQld+Kd23Xtr7o4xuHTLh8xTAIzyvyufaZFimUU7RnEDFQQ3q01NPfrW
         koFKa+8/Dw/UoDGsBwKJ89XIvgmG0alhLYSrvzDqDZ8f7UG0Zj1Sf5HPpU1MFlSCIIjk
         Pzt4ZPUhPUooeu6T4cDjN54nZKT6joRQ4/MvJzphtl7AtGQFF/BV6VsIDZNsBegZH5Dl
         EuYg==
X-Gm-Message-State: AOJu0YyOVOHrOq12CKrvUtI1S5TLlubMN6jRPGf7ajRBZEDHeENtTkCd
	g2wlCbY1L8MFpCiKy17f8SPrlaFZNFAHVOZGPxfhrsrpfBu0vdEieEkC
X-Gm-Gg: ASbGncuNeG8OpFgCiQXclYp8AQ0Q4DXbEeXbBHPWPZUwQeQu9lQr5NOYh2VY9i8hzl3
	ywGUyBmHhQYH7d9fSB2f9QdvniQrOgcA1PyfUDyov93SDoy1VbuwDThhiu+yIQMdnwSeZpSvXVq
	BxOCefS+a012GcnpDPc0Sv3PMHFuMji19iI+P2WuoxqH+EexuLADhttf56/O1aNezyGdt3D2+CX
	tcEufHA1h53yiJmY/zM6DVYGQYiU0FwGiSx8+gM6EWDw/qi5mEpFjRJX6zTJAi0quDdhACUGY3a
	0A5+FeXufiMBzhIjktDxyxWL0D0SMYlunkPXjjhebfdjdJos429BbdgmW9P62P0zNN9lVD6mSgZ
	48gsOFj+0N8suAYDqngMYwh9arpf3o/CyNpi/E3j1/L1jBE0VFbaj5Q+oq/Eo2kZbnD7UOISTdQ
	od1O4S+k6sLgPOjNFoXZUXxoDYBQtI38o=
X-Google-Smtp-Source: AGHT+IHwaj0UZRsnj8dcvgC/D/fSCnQYIZ0bRmj1nAwG07azhqtDDwbJkmRQ+8lLnIHl9U3aFl4gJQ==
X-Received: by 2002:a05:6a00:3d13:b0:7a2:7bdd:cbf4 with SMTP id d2e1a72fcca58-7a27bddcd09mr9126120b3a.27.1761374944226;
        Fri, 24 Oct 2025 23:49:04 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:564:1203:6acd:bae8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414034661sm1281886b3a.26.2025.10.24.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:49:03 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2] dt-bindings: net: phy: vsc8531: Convert to DT schema
Date: Sat, 25 Oct 2025 07:48:50 +0100
Message-ID: <20251025064850.393797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
at it add compatible string for VSC8541 PHY which is very much similar
to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
is present on the Renesas RZ/T2H EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Inspired from the DT warnings seen while running dtbs check [0],
took an opportunity to convert this binding to DT schema format.
As there was no entry in the maintainers file Ive added myself
as the maintainer for this binding.
[0] https://lore.kernel.org/all/176073765433.419659.2490051913988670515.robh@kernel.org/

Note,
1] As there is no entry in maintainers file for this binding, Ive added myself
as the maintainer for this binding.

v1->v2:
- Updated dependencies format as per review comments.
- Updated vsc8531,edge-slowdown description to use formatting.
---
 .../bindings/net/mscc-phy-vsc8531.txt         |  73 ----------
 .../bindings/net/mscc-phy-vsc8531.yaml        | 131 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +-
 3 files changed, 132 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
 create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
deleted file mode 100644
index 0a3647fe331b..000000000000
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Microsemi - vsc8531 Giga bit ethernet phy
-
-Optional properties:
-- vsc8531,vddmac	: The vddmac in mV. Allowed values is listed
-			  in the first row of Table 1 (below).
-			  This property is only used in combination
-			  with the 'edge-slowdown' property.
-			  Default value is 3300.
-- vsc8531,edge-slowdown	: % the edge should be slowed down relative to
-			  the fastest possible edge time.
-			  Edge rate sets the drive strength of the MAC
-			  interface output signals.  Changing the
-			  drive strength will affect the edge rate of
-			  the output signal.  The goal of this setting
-			  is to help reduce electrical emission (EMI)
-			  by being able to reprogram drive strength
-			  and in effect slow down the edge rate if
-			  desired.
-			  To adjust the edge-slowdown, the 'vddmac'
-			  must be specified. Table 1 lists the
-			  supported edge-slowdown values for a given
-			  'vddmac'.
-			  Default value is 0%.
-			  Ref: Table:1 - Edge rate change (below).
-- vsc8531,led-[N]-mode	: LED mode. Specify how the LED[N] should behave.
-			  N depends on the number of LEDs supported by a
-			  PHY.
-			  Allowed values are defined in
-			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
-			  Default values are VSC8531_LINK_1000_ACTIVITY (1),
-			  VSC8531_LINK_100_ACTIVITY (2),
-			  VSC8531_LINK_ACTIVITY (0) and
-			  VSC8531_DUPLEX_COLLISION (8).
-- load-save-gpios	: GPIO used for the load/save operation of the PTP
-			  hardware clock (PHC).
-
-
-Table: 1 - Edge rate change
-----------------------------------------------------------------|
-| 		Edge Rate Change (VDDMAC)			|
-|								|
-| 3300 mV	2500 mV		1800 mV		1500 mV		|
-|---------------------------------------------------------------|
-| 0%		0%		0%		0%		|
-| (Fastest)			(recommended)	(recommended)	|
-|---------------------------------------------------------------|
-| 2%		3%		5%		6%		|
-|---------------------------------------------------------------|
-| 4%		6%		9%		14%		|
-|---------------------------------------------------------------|
-| 7%		10%		16%		21%		|
-|(recommended)	(recommended)					|
-|---------------------------------------------------------------|
-| 10%		14%		23%		29%		|
-|---------------------------------------------------------------|
-| 17%		23%		35%		42%		|
-|---------------------------------------------------------------|
-| 29%		37%		52%		58%		|
-|---------------------------------------------------------------|
-| 53%		63%		76%		77%		|
-| (slowest)							|
-|---------------------------------------------------------------|
-
-Example:
-
-        vsc8531_0: ethernet-phy@0 {
-                compatible = "ethernet-phy-id0007.0570";
-                vsc8531,vddmac		= <3300>;
-                vsc8531,edge-slowdown	= <7>;
-                vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
-                vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
-		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
-        };
diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
new file mode 100644
index 000000000000..0afbd0ff126f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsemi VSC8531 Gigabit Ethernet PHY
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The VSC8531 is a Gigabit Ethernet PHY with configurable MAC interface
+  drive strength and LED modes.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id0007.0570 # VSC8531
+          - ethernet-phy-id0007.0772 # VSC8541
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ethernet-phy-id0007.0570 # VSC8531
+          - ethernet-phy-id0007.0772 # VSC8541
+      - const: ethernet-phy-ieee802.3-c22
+
+  vsc8531,vddmac:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The VDDMAC voltage in millivolts. This property is used in combination
+      with the edge-slowdown property to control the drive strength of the
+      MAC interface output signals.
+    enum: [3300, 2500, 1800, 1500]
+    default: 3300
+
+  vsc8531,edge-slowdown:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Percentage by which the edge rate should be slowed down relative to
+      the fastest possible edge time. This setting helps reduce electromagnetic
+      interference (EMI) by adjusting the drive strength of the MAC interface
+      output signals. Valid values depend on the vddmac voltage setting
+      according to the edge rate change table in the datasheet.
+
+      - When vsc8531,vddmac = 3300 mV: allowed values are 0, 2, 4, 7, 10, 17, 29, and 53.
+        (Recommended: 7)
+      - When vsc8531,vddmac = 2500 mV: allowed values are 0, 3, 6, 10, 14, 23, 37, and 63.
+        (Recommended: 10)
+      - When vsc8531,vddmac = 1800 mV: allowed values are 0, 5, 9, 16, 23, 35, 52, and 76.
+        (Recommended: 0)
+      - When vsc8531,vddmac = 1500 mV: allowed values are 0, 6, 14, 21, 29, 42, 58, and 77.
+        (Recommended: 0)
+    enum: [0, 2, 3, 4, 5, 6, 7, 9, 10, 14, 16, 17, 21, 23, 29, 35, 37, 42, 52, 53, 58, 63, 76, 77]
+    default: 0
+
+  vsc8531,led-0-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[0] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 1
+
+  vsc8531,led-1-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[1] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 2
+
+  vsc8531,led-2-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[2] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  vsc8531,led-3-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[3] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 8
+
+  load-save-gpios:
+    description: GPIO phandle used for the load/save operation of the PTP hardware
+      clock (PHC).
+    maxItems: 1
+
+dependencies:
+  vsc8531,edge-slowdown:
+    - vsc8531,vddmac
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
+    #include <dt-bindings/net/mscc-phy-vsc8531.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
+            reg = <0>;
+            vsc8531,vddmac = <3300>;
+            vsc8531,edge-slowdown = <7>;
+            vsc8531,led-0-mode = <VSC8531_LINK_1000_ACTIVITY>;
+            vsc8531,led-1-mode = <VSC8531_LINK_100_ACTIVITY>;
+            load-save-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 54ba517d7e79..1af57177a747 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -20,7 +20,7 @@ patternProperties:
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
   "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
-  "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
+  "^(simple-audio-card|st-plgpio|st-spics|ts|vsc8531),.*": true
   "^pool[0-3],.*": true
 
   # Keep list in alphabetical order.
-- 
2.43.0


