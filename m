Return-Path: <netdev+bounces-102596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C5903E0C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A87B235B5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4017DE0F;
	Tue, 11 Jun 2024 13:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD817D88C;
	Tue, 11 Jun 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114120; cv=none; b=U8a6T1sKtY9En5RFD7jmpE6LAeh9n/BcSXewYgZM+FhrO3vqnkIWjb8/olw1Ns5rc/7yTMA4JXQiqfRWcHZtfbt20wRwMi1HeMbWEDLz9HP17jLXzZf+6nLcKiHgy6i7wmHBsASDcS3Z+Mw0nU0Pjz/HRRlh+ZckAuxgTS2SEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114120; c=relaxed/simple;
	bh=5q5TavBawM582cp2Cm9k1IG5Dt0+9hr41tfNcRPzkig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPB8u/vKqxjWNGQrhR+rMCL33tTGyo5fSNnuC2gabUJkkV/orR2k+3f42tXEH3zV1693CBRqJYNx/eT3uqSjjmHRANjko2qwzaVXva/VjI9kbTjbZ44wzdDn8WeoO1ab7/1B+8ZZfnJLs7s9GVWonY2mc56glIgI/+NsYXuelCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1xu-003Hc2-T9; Tue, 11 Jun 2024 15:55:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1xu-009Q20-AC; Tue, 11 Jun 2024 15:55:10 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 03E4E240053;
	Tue, 11 Jun 2024 15:55:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 8B7BF240050;
	Tue, 11 Jun 2024 15:55:09 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E8488376FA;
	Tue, 11 Jun 2024 15:55:08 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v5 01/12] dt-bindings: net: dsa: lantiq,gswip: convert to YAML schema
Date: Tue, 11 Jun 2024 15:54:23 +0200
Message-ID: <20240611135434.3180973-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718114110-A8EBED95-12043B99/0/0

Convert the lantiq,gswip bindings to YAML format.

Also add this new file to the MAINTAINERS file.

Furthermore, the CPU port has to specify a phy-mode and either a phy or
a fixed-link. Since GSWIP is connected using a SoC internal protocol
there's no PHY involved. Add phy-mode =3D "internal" and a fixed-link to
the example code to describe the communication between the PMAC
(Ethernet controller) and GSWIP switch.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 .../bindings/net/dsa/lantiq,gswip.yaml        | 202 ++++++++++++++++++
 .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
 MAINTAINERS                                   |   1 +
 3 files changed, 203 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswi=
p.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswi=
p.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml =
b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
new file mode 100644
index 000000000000..f3154b19af78
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq GSWIP Ethernet switches
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+maintainers:
+  - Hauke Mehrtens <hauke@hauke-m.de>
+
+properties:
+  compatible:
+    enum:
+      - lantiq,xrx200-gswip
+      - lantiq,xrx300-gswip
+      - lantiq,xrx330-gswip
+
+  reg:
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: switch
+      - const: mdio
+      - const: mii
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: lantiq,xrx200-mdio
+
+    required:
+      - compatible
+
+  gphy-fw:
+    type: object
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      compatible:
+        items:
+          - enum:
+              - lantiq,xrx200-gphy-fw
+              - lantiq,xrx300-gphy-fw
+              - lantiq,xrx330-gphy-fw
+          - const: lantiq,gphy-fw
+
+      lantiq,rcu:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to the RCU syscon
+
+    patternProperties:
+      "^gphy@[0-9a-f]{1,2}$":
+        type: object
+
+        additionalProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 255
+            description:
+              Offset of the GPHY firmware register in the RCU register r=
ange
+
+          resets:
+            items:
+              - description: GPHY reset line
+
+          reset-names:
+            items:
+              - const: gphy
+
+        required:
+          - reg
+
+    required:
+      - compatible
+      - lantiq,rcu
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    switch@e108000 {
+            compatible =3D "lantiq,xrx200-gswip";
+            reg =3D <0xe108000 0x3100>,  /* switch */
+                  <0xe10b100 0xd8>,    /* mdio */
+                  <0xe10b1d8 0x130>;   /* mii */
+            dsa,member =3D <0 0>;
+
+            ports {
+                    #address-cells =3D <1>;
+                    #size-cells =3D <0>;
+
+                    port@0 {
+                            reg =3D <0>;
+                            label =3D "lan3";
+                            phy-mode =3D "rgmii";
+                            phy-handle =3D <&phy0>;
+                    };
+
+                    port@1 {
+                            reg =3D <1>;
+                            label =3D "lan4";
+                            phy-mode =3D "rgmii";
+                            phy-handle =3D <&phy1>;
+                    };
+
+                    port@2 {
+                            reg =3D <2>;
+                            label =3D "lan2";
+                            phy-mode =3D "internal";
+                            phy-handle =3D <&phy11>;
+                    };
+
+                    port@4 {
+                            reg =3D <4>;
+                            label =3D "lan1";
+                            phy-mode =3D "internal";
+                            phy-handle =3D <&phy13>;
+                    };
+
+                    port@5 {
+                            reg =3D <5>;
+                            label =3D "wan";
+                            phy-mode =3D "rgmii";
+                            phy-handle =3D <&phy5>;
+                    };
+
+                    port@6 {
+                            reg =3D <0x6>;
+                            phy-mode =3D "internal";
+                            ethernet =3D <&eth0>;
+
+                            fixed-link {
+                                    speed =3D <1000>;
+                                    full-duplex;
+                            };
+                    };
+            };
+
+            mdio {
+                    #address-cells =3D <1>;
+                    #size-cells =3D <0>;
+                    compatible =3D "lantiq,xrx200-mdio";
+
+                    phy0: ethernet-phy@0 {
+                            reg =3D <0x0>;
+                    };
+                    phy1: ethernet-phy@1 {
+                            reg =3D <0x1>;
+                    };
+                    phy5: ethernet-phy@5 {
+                            reg =3D <0x5>;
+                    };
+                    phy11: ethernet-phy@11 {
+                            reg =3D <0x11>;
+                    };
+                    phy13: ethernet-phy@13 {
+                            reg =3D <0x13>;
+                    };
+            };
+
+            gphy-fw {
+                    #address-cells =3D <1>;
+                    #size-cells =3D <0>;
+                    compatible =3D "lantiq,xrx200-gphy-fw", "lantiq,gphy=
-fw";
+                    lantiq,rcu =3D <&rcu0>;
+
+                    gphy@20 {
+                            reg =3D <0x20>;
+
+                            resets =3D <&reset0 31 30>;
+                            reset-names =3D "gphy";
+                    };
+
+                    gphy@68 {
+                            reg =3D <0x68>;
+
+                            resets =3D <&reset0 29 28>;
+                            reset-names =3D "gphy";
+                    };
+            };
+    };
diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt b=
/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
deleted file mode 100644
index 8bb1eff21cb1..000000000000
--- a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
+++ /dev/null
@@ -1,146 +0,0 @@
-Lantiq GSWIP Ethernet switches
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Required properties for GSWIP core:
-
-- compatible	: "lantiq,xrx200-gswip" for the embedded GSWIP in the
-		  xRX200 SoC
-		  "lantiq,xrx300-gswip" for the embedded GSWIP in the
-		  xRX300 SoC
-		  "lantiq,xrx330-gswip" for the embedded GSWIP in the
-		  xRX330 SoC
-- reg		: memory range of the GSWIP core registers
-		: memory range of the GSWIP MDIO registers
-		: memory range of the GSWIP MII registers
-
-See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
-additional required and optional properties.
-
-
-Required properties for MDIO bus:
-- compatible	: "lantiq,xrx200-mdio" for the MDIO bus inside the GSWIP
-		  core of the xRX200 SoC and the PHYs connected to it.
-
-See Documentation/devicetree/bindings/net/mdio.txt for a list of additio=
nal
-required and optional properties.
-
-
-Required properties for GPHY firmware loading:
-- compatible	: "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw"
-		  "lantiq,xrx300-gphy-fw", "lantiq,gphy-fw"
-		  "lantiq,xrx330-gphy-fw", "lantiq,gphy-fw"
-		  for the loading of the firmware into the embedded
-		  GPHY core of the SoC.
-- lantiq,rcu	: reference to the rcu syscon
-
-The GPHY firmware loader has a list of GPHY entries, one for each
-embedded GPHY
-
-- reg		: Offset of the GPHY firmware register in the RCU
-		  register range
-- resets	: list of resets of the embedded GPHY
-- reset-names	: list of names of the resets
-
-Example:
-
-Ethernet switch on the VRX200 SoC:
-
-switch@e108000 {
-	#address-cells =3D <1>;
-	#size-cells =3D <0>;
-	compatible =3D "lantiq,xrx200-gswip";
-	reg =3D <	0xe108000 0x3100	/* switch */
-		0xe10b100 0xd8		/* mdio */
-		0xe10b1d8 0x130		/* mii */
-		>;
-	dsa,member =3D <0 0>;
-
-	ports {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
-		port@0 {
-			reg =3D <0>;
-			label =3D "lan3";
-			phy-mode =3D "rgmii";
-			phy-handle =3D <&phy0>;
-		};
-
-		port@1 {
-			reg =3D <1>;
-			label =3D "lan4";
-			phy-mode =3D "rgmii";
-			phy-handle =3D <&phy1>;
-		};
-
-		port@2 {
-			reg =3D <2>;
-			label =3D "lan2";
-			phy-mode =3D "internal";
-			phy-handle =3D <&phy11>;
-		};
-
-		port@4 {
-			reg =3D <4>;
-			label =3D "lan1";
-			phy-mode =3D "internal";
-			phy-handle =3D <&phy13>;
-		};
-
-		port@5 {
-			reg =3D <5>;
-			label =3D "wan";
-			phy-mode =3D "rgmii";
-			phy-handle =3D <&phy5>;
-		};
-
-		port@6 {
-			reg =3D <0x6>;
-			ethernet =3D <&eth0>;
-		};
-	};
-
-	mdio {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-		compatible =3D "lantiq,xrx200-mdio";
-		reg =3D <0>;
-
-		phy0: ethernet-phy@0 {
-			reg =3D <0x0>;
-		};
-		phy1: ethernet-phy@1 {
-			reg =3D <0x1>;
-		};
-		phy5: ethernet-phy@5 {
-			reg =3D <0x5>;
-		};
-		phy11: ethernet-phy@11 {
-			reg =3D <0x11>;
-		};
-		phy13: ethernet-phy@13 {
-			reg =3D <0x13>;
-		};
-	};
-
-	gphy-fw {
-		compatible =3D "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw";
-		lantiq,rcu =3D <&rcu0>;
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
-		gphy@20 {
-			reg =3D <0x20>;
-
-			resets =3D <&reset0 31 30>;
-			reset-names =3D "gphy";
-		};
-
-		gphy@68 {
-			reg =3D <0x68>;
-
-			resets =3D <&reset0 29 28>;
-			reset-names =3D "gphy";
-		};
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..ca1050f6691b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12449,6 +12449,7 @@ LANTIQ / INTEL Ethernet drivers
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
 F:	drivers/net/dsa/lantiq_gswip.c
 F:	drivers/net/dsa/lantiq_pce.h
 F:	drivers/net/ethernet/lantiq_xrx200.c
--=20
2.39.2


