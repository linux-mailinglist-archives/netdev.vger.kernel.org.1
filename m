Return-Path: <netdev+bounces-178037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D9A7411B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1254F1892A77
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A331F471D;
	Thu, 27 Mar 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX1i2Rkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1551F3D54;
	Thu, 27 Mar 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115572; cv=none; b=uB68K4HAJUXfzodPJVj8++srq7EYyByyPFi3pibfz4RKWXfFPl26EtsM0l8tvKvRGPobjpiq3zXtLYadGqGfPtPBA11TzAXexrsHjLvyyuYrwWN8wy6KiNuMUx5YmpIsHa4FmBjAo+0/HZwmFbIA31hofURsVaQyIt7WDiRIqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115572; c=relaxed/simple;
	bh=3JAbx/6zHxDcZcVrqonGIc+yq6mzD6vU7qPwcQ3/KuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZXPkkwq2Dw3GAHyPjf9kLG5yY/rQ4AS89D1H/f6V96h7N+dKfhYyRsVUb7HLQXotPRW98JimnJyyhldERFYXM85t/TVZgqWNG+FEP8LBY9z6B4N45tVkwFT4JgQKVVyRVNFR3koOMT8zplfkuhGT1kGCIok70P5v6O2pj+/xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX1i2Rkd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ac9aea656so1249937f8f.3;
        Thu, 27 Mar 2025 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115569; x=1743720369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlCP40OPLX2TWKsloKBZ4s4PKxe95hK/BBiMij9W8Xc=;
        b=TX1i2RkdHLrCn0Gmc4SoZMB+RLa3uqfolNrWcR02jpROC/QAcYF8QgnOTIiL2bOx8j
         5OA5wTWsDf1lfG6S/ubV41b1Qo2pWNaun0YVf+bX7w2pp8K1Z978If1zze+7qYmWKHdF
         9NpiDAADXOIBaskWxR+Dz1dsJMSZF+JY7tuXEdNO68rtaS+KruWbROE8DypiYAARMKoc
         Ezjr6BFxcgS5ALwcNleMMSPXbqnvcnZOhumG6d6AGmoYsP77iDL2PPegKyqLDx2feEcR
         5kuYyd2wft3ztMmuBhuZVNcVyTVmKyg40yRIhK6TojrV13uxMEfZawv6wEImdGV1kalt
         53QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115569; x=1743720369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlCP40OPLX2TWKsloKBZ4s4PKxe95hK/BBiMij9W8Xc=;
        b=NeKX0HDXjjw5E5UxcKaHM2UUruGffn2BT+N26DVrHMg0OADaewGJxCYt9LpNvlpQHo
         3eO8nn+w+i6bzQqNoK8HYIeXU9RHgI1CeN/sbX+JJ80bUwSkIOZ2DIsi6MIrQYSrQ/rY
         FplUjFQvp9Kh01GBz16cOXhSo2qpz2O2HWsEfiFByAx543cR6hALEQT2RqVJ+hGc9IT+
         HDz9TkCV3crxmpN1HIbudKrMPf2kVHOQmgJCmqYQeFCoyyGXOWxWZXpqoFT7ngrTMTgg
         dqPi/ib1BCEeZTaPOP7mONjZ2lDukE8mtWqYIamRbV1qu7WIOBkSAdD37AzD4Q93eOtG
         DX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW20IBKLhLzZkJVxgG4atl9tvO3YCenxGGH2c3m/79VJhuBlN5DivYLM2NHB/EttQqydjesFMxYqYHkcqY@vger.kernel.org, AJvYcCUkg+7pXogMXT7t/6JjNey9JygYoxTd/05wnGPKuAwedFHqGbCazcAu+UVjkUMrAcMu8YaRWpPo@vger.kernel.org, AJvYcCWLOWg5fwRBNp84ZT5pGSHlVfaSwQpIjMo63zFfeP2zujsyKBPjh4aHMEbno6iED2veJ/mBiC7fn9x/@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAyIxwdsLWonpQD8rZ81pRsTWlH3dXpfUXBRb/3O05R06yBCo
	WigqbHPvryW9ifxjZTgbpKSxQfdTc0o6qdci2HnbYGjRogTwYCpE
X-Gm-Gg: ASbGncuXfBJDJ9gzsOTABpqUM4J+hgC6GhiKC8Alg3fUOfH1baEzEi5MtC/0QkWwpTI
	8/X6A9CRkLqlLyCM0Q8b8QQFCqqBy+AqX5EzHQIDoVsC2OZUZz4y+Fi/Axy1/OFCIHQfFDr4W7Y
	YPqE1b6aKxVySZ7IPUf8OAVR/9+vECKClxHgOwaNL1AkmSCpKmvuAgkJz4NH7UieqrBEiXFP651
	W9WYwiPCXvPaDtLFtBUmVEtN6WMhksZWydHRQQiiIXJ7oxqLVSBDy6BI8FWtnobb5qkRg3TiOuI
	ayxyKCVKdQsYLIUaQ6NeAqEKvctTR31EawhHDvmHaxnXrAxpvhRMGFGB4YIB519cyxsmb1wA22V
	A6nVPrik6Fc3VRw==
X-Google-Smtp-Source: AGHT+IHUHmnpA4FH5YPF+VwL8jrJIx9pyRXvNp/0wMnPzueR/mR9Z/EEFGUZXXT99NmJKYaFy8Bz2Q==
X-Received: by 2002:a05:6000:40e1:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-39ad1773089mr5001980f8f.31.1743115569067;
        Thu, 27 Mar 2025 15:46:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:46:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v4 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Thu, 27 Mar 2025 23:45:17 +0100
Message-ID: <20250327224529.814-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327224529.814-1-ansuelsmth@gmail.com>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Aeonsemi PHYs and the requirement of a firmware to
correctly work. Also document the max number of LEDs supported and what
PHY ID expose when no firmware is loaded.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
registers before the firmware is loaded.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/aeonsemi,as21xxx.yaml        | 122 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
new file mode 100644
index 000000000000..69eb29dc4d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/aeonsemi,as21xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeonsemi AS21XXX Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Aeonsemi AS21xxx Ethernet PHYs requires a firmware to be loaded to actually
+  work. The same firmware is compatible with various PHYs of the same family.
+
+  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
+  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.
+
+  This can be done and is implemented by OEM in 2 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  Each PHY can support up to 5 LEDs.
+
+  AS2xxx PHY Name logic:
+
+  AS21x1xxB1
+      ^ ^^
+      | |J: Supports SyncE/PTP
+      | |P: No SyncE/PTP support
+      | 1: Supports 2nd Serdes
+      | 2: Not 2nd Serdes support
+      0: 10G, 5G, 2.5G
+      5: 5G, 2.5G
+      2: 2.5G
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id7500.9410
+          - ethernet-phy-id7500.9402
+          - ethernet-phy-id7500.9412
+          - ethernet-phy-id7500.9422
+          - ethernet-phy-id7500.9432
+          - ethernet-phy-id7500.9442
+          - ethernet-phy-id7500.9452
+          - ethernet-phy-id7500.9462
+          - ethernet-phy-id7500.9472
+          - ethernet-phy-id7500.9482
+          - ethernet-phy-id7500.9492
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id7500.9410
+then:
+  required:
+    - firmware-name
+else:
+  properties:
+    firmware-name: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1f {
+            compatible = "ethernet-phy-id7500.9410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <31>;
+            firmware-name = "as21x1x_fw.bin";
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <0>;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 53ca93b0cc18..310530649a48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -650,6 +650,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


