Return-Path: <netdev+bounces-218371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3BB3C3C4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FA5560361
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE0C33EAF6;
	Fri, 29 Aug 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I25FKPhU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150A235345;
	Fri, 29 Aug 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499303; cv=none; b=KpCgCAwz7ujq04gLUFvenqTrARNAjrHfkODZUm/JaUJ2QwoyDCCEatn2Rjpf21vL5NCAZOBsNCaAOus+KBOx6LSlKxnWZUuiY25aBmwNmd5Ew3+4BoPdNYFi0CvBSgCB0xEBSw5ftvndwTPRkFZoEbp2PkePUJ6PNHQEhlI04Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499303; c=relaxed/simple;
	bh=g45j9M/8HC4aZSBga0Ho4anG8ckxtQ5/Rp9XwZP3x0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixMk7YEk/OwJHuKzRxfTOUF1l28xgR59ONlEuWrCffnUncJV2hFKV1Kwr+VL1sTlI6zVbWYlYHG4rgSkSs2Dhg9ZSGzSsvGax81dm4MObXPoxiLmM5KMb9oAHfiP7Tz4YisEwuD3wAhDxvodKEnNMaJho0XaocyU62j2Q0ZlpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I25FKPhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA81C4CEF0;
	Fri, 29 Aug 2025 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499303;
	bh=g45j9M/8HC4aZSBga0Ho4anG8ckxtQ5/Rp9XwZP3x0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I25FKPhU4dPgziIxoysO7wWfy4ivSrMg1GfUY9YwFouMXGiH6tl9ztIU4w28L2deQ
	 NkiDizGsI2zoYBZQ6Hp6m82pG72NfT/zLxQoV5tf+v1HJS/3BmeX8XfgG/YQRHhXID
	 nzfdiGZmoVoHfOU23n6vLDnjRIdPsE7aul9CuyjIP7BZFJ+ppJKEeKrB1TuNUO8yj4
	 Ew/KBAVTAbhBP5fZ6a1BGQEezJMmgkRFmFk/Ky2EinD1qZ6TSeQYAk8zB7VdehIop6
	 WWJ+d4p1KII0Lq00YBYchN9bQH2+BHvchBsxkV23b2hMZ2z6SaW3D0j7deAqCxFX3S
	 woZ6FG5qX4ihg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] dt-bindings: net: Convert APM XGene MDIO to DT schema
Date: Fri, 29 Aug 2025 15:28:15 -0500
Message-ID: <20250829202817.1271907-2-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829202817.1271907-1-robh@kernel.org>
References: <20250829202817.1271907-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the APM XGene MDIO bus binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/apm,xgene-mdio-rgmii.yaml    | 54 +++++++++++++++++++
 .../bindings/net/apm-xgene-mdio.txt           | 37 -------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 55 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-mdio.txt

diff --git a/Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml b/Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
new file mode 100644
index 000000000000..470fb5f7f7b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/apm,xgene-mdio-rgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC MDIO
+
+maintainers:
+  - Iyappan Subramanian <iyappan@os.amperecomputing.com>
+  - Keyur Chudgar <keyur@os.amperecomputing.com>
+  - Quan Nguyen <quan@os.amperecomputing.com>
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    enum:
+      - apm,xgene-mdio-rgmii
+      - apm,xgene-mdio-xfi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    mdio@17020000 {
+        compatible = "apm,xgene-mdio-rgmii";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x17020000 0xd100>;
+        clocks = <&menetclk 0>;
+
+        phy@3 {
+            reg = <0x3>;
+        };
+        phy@4 {
+            reg = <0x4>;
+        };
+        phy@5 {
+            reg = <0x5>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt b/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
deleted file mode 100644
index 78722d74cea8..000000000000
--- a/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-APM X-Gene SoC MDIO node
-
-MDIO node is defined to describe on-chip MDIO controller.
-
-Required properties:
-	- compatible: Must be "apm,xgene-mdio-rgmii" or "apm,xgene-mdio-xfi"
-	- #address-cells: Must be <1>.
-	- #size-cells: Must be <0>.
-	- reg: Address and length of the register set
-	- clocks: Reference to the clock entry
-
-For the phys on the mdio bus, there must be a node with the following fields:
-	- compatible: PHY identifier.  Please refer ./phy.txt for the format.
-	- reg: The ID number for the phy.
-
-Example:
-
-	mdio: mdio@17020000 {
-		compatible = "apm,xgene-mdio-rgmii";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x0 0x17020000 0x0 0xd100>;
-		clocks = <&menetclk 0>;
-	};
-
-	/* Board-specific peripheral configurations */
-	&mdio {
-		menetphy: phy@3 {
-			reg = <0x3>;
-		};
-		sgenet0phy: phy@4 {
-			reg = <0x4>;
-		};
-		sgenet1phy: phy@5 {
-			reg = <0x5>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 206ff023f5b3..c0b42d03d040 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1893,7 +1893,7 @@ M:	Keyur Chudgar <keyur@os.amperecomputing.com>
 M:	Quan Nguyen <quan@os.amperecomputing.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
-F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
+F:	Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
 F:	drivers/net/ethernet/apm/xgene/
 F:	drivers/net/mdio/mdio-xgene.c
 
-- 
2.50.1


