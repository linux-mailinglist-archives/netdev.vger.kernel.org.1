Return-Path: <netdev+bounces-221001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D0B49D58
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EF24E0758
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DB2F9C32;
	Mon,  8 Sep 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWQdLabe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C842F7475;
	Mon,  8 Sep 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373033; cv=none; b=t15qKzAk0U8BljHaTZOtaNPBbMeJU/6LEh7bOHKnTAuwjJHYiTEPFpmcvgcjKmfAmvBLXEa0nsdEDmQ8OJWAkslwfX7VBcnoTTpEfkLnzo1zHCrvKVP58gNN0j/WUItZ0l5Hx33/+vcnghHw1yi1XAGBsXyi9XTTFogzGttAHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373033; c=relaxed/simple;
	bh=kBQ1BZ7kGAdyqiHEixGCUXGg0bBphkU4OibNmwHdc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK2cMFMxqH99CICFFKImtPe3Yeb6Y2J8bGMVDHeC83JDHd1MkKvvsroFljPoF4+po23B1i6sJ/AJieAxmKagjBK0uEv768u2VArzWxvEuD9BsPr1UZDXgvdAqPmvYqgaSjBcwkqyYLVa2WpK58FPzqVT71KM9eHRqpccLz8sJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWQdLabe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52742C4CEF1;
	Mon,  8 Sep 2025 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757373032;
	bh=kBQ1BZ7kGAdyqiHEixGCUXGg0bBphkU4OibNmwHdc8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWQdLabeArdPBJ9WSOqALwoNZ04TAD2VXWhKPbKo0Hua3+P8wg4fQ702RoCExN/3w
	 peji19GIP7MJqcloBQU/27s7Whh86SQKZ49lFccTPoQeEbidxJIWv7iG/HsRDX+1CF
	 QWp8U01QtIDzCbFgI7x9fsCyXcu7/V32tFUbc0Q9NelyuBfy6AvLW/47k8JOM/+WdE
	 GQl9mwPwkpf3SXKC9oCQIpLIyNmLNFJ+1WtU4Ea1DBf8sB7Bs3EpZ+Kk2UW1XeftKa
	 YyxldUNwd8pDdjXl0/MZrJSDVTGAzkqB0+EnLSD8FR/PlXQ1c7v6AaMYo5UonFEOda
	 CuAwNltm/RgbQ==
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
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: net: Convert APM XGene MDIO to DT schema
Date: Mon,  8 Sep 2025 18:10:14 -0500
Message-ID: <20250908231016.2070305-2-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908231016.2070305-1-robh@kernel.org>
References: <20250908231016.2070305-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the APM XGene MDIO bus binding to DT schema format. It's a
straight-forward conversion.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
index c2a669258494..49edc6989684 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1894,7 +1894,7 @@ M:	Keyur Chudgar <keyur@os.amperecomputing.com>
 M:	Quan Nguyen <quan@os.amperecomputing.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
-F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
+F:	Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
 F:	drivers/net/ethernet/apm/xgene/
 F:	drivers/net/mdio/mdio-xgene.c
 
-- 
2.50.1


