Return-Path: <netdev+bounces-181172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CCA83F9E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4077B6F2C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD126B96A;
	Thu, 10 Apr 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOKI3eFC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A26B94D;
	Thu, 10 Apr 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278930; cv=none; b=tZo8RNw3TvPWqiNzcPA63NoSUpVB6rr2HqXUew2HqTRHRjLKJ+nUSfYm1XrT8zlAd34CGJQkdV4gxNQNMGdtvbnwhruXS5DlSQLGnQ8u60is5J/+8yKZbpyoFLwouduzEagVTetKMGtk/xTWwE1qmjcRGOK+W1xk1VUwvXMx2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278930; c=relaxed/simple;
	bh=4THuh4l2cNhIbqy6HlF/J7Hc+TBYJG/XLk/3DEKuZfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lucW8jpKVe54mX8o6CIVLW4U6mbGaR0oestUpoQQ16QgIbxnuhzvzMRb1vkgX9aQsnx0SIXNTAy3WOc/A4tFuhVWvMRGTEoF6VYbnU2JJKA3VIEDFXSQ+qb8zvxBuTr/RMiyH67xGHXj8uzDiqLYxYLoXCQKD8pPXmZ/KFu9+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOKI3eFC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so475406f8f.1;
        Thu, 10 Apr 2025 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278926; x=1744883726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=kOKI3eFCLYAUmKueFM8Q1Rt8nWz/U5YGdmobenbIMTYYWxqCw529yAao7TwDHAavhn
         pYW08eRZp++xLs/+J5aLV5cBXN5IEZ2VrxEeyro6OFTynXRDN1ucjLRh9DmBtErgnfAZ
         ovYF2gIYWiX2bsAKHUDGA4RfRjx0Kv1sz+vxdDO/kmrV3Gdd69MNJ+CGFO4i2255Olp6
         efEj4Ho9EMDeQOcsrKN6SiLhXz7rbB8+aDF+Jj5SCeSZNpwQHqFXisAwb2WmgDFiHJDv
         hwTOSVJGntzdyd9ypNU96D5WDp9ecBboBpgIlHi1KKkG8iLokFwVo9nXYZ++GwCXVJhI
         ATPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278926; x=1744883726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=VEqCF/PdSd2+HHpCsP8wHVBRi60TX+LzsLTQAI0p/A/ZB7KJnTuDJz8zTb4Y5kTV7v
         XkZx0uo0J7X7q9wF81Q0R0wOjo5ihzLvZ34MHDYyGMMjfMpE+B4jS/KJevJcsEmkzapf
         Kgq8nNei6ogxblWzfYPFpBWQ8PSZbE4RdjGO+Xrlw4xM36WgYMMabXgiEQ/O7PFRJyYr
         IIcGViPJd35T0GkpVCnt0VqpcJ4mtbRLACecHKqDXhj5/TtHxZqeYZCH7uXR4E2VpGq4
         5bSk4yi8u0w8QKH37z95NgcjW920BoLASAC8J8PTnlsQIV5Rr4xkHSztcRv2B3BL3xBI
         ktlg==
X-Forwarded-Encrypted: i=1; AJvYcCWX2KatwtH771DvQxqs1AI8lGFx0A5eUkq8UdR5hYSgftKpSQbNvqjmK8e46Jl6IvIKTUT/YxvN@vger.kernel.org, AJvYcCWgGhGbAjqjP9Nenw+M8aLTHQZyixYA2/hAEN6y7MqM9RVPjbnsjTlhWDCtjzNSjLx9nGiTamgcYtXD@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAVn9bvgtpP7JP7kQSt3/eDQI5Jrk1bVuRmsVapE0yHZYVC4R
	boe436WerH5pceqq7VM8PwbCKuF0cAt6z19EQjXGLGeAOkQNRPzm
X-Gm-Gg: ASbGnctyTU6/RCUwQSVzKO86cYVRYfthz/rStJaWkXdTBUlzvibXCjU+mD92Xw+BINl
	AfzJmUgNJY9Y69VfWK65PDYOaZR0rBypE3e+L/TOoT3mUy0lKLelY4II2KL7M1uBu7qxiHqbc5u
	0oRnS6rVp/lPlAtfwFoaBqkM2FYciFit5UIa3z6df0qdnFfyrWJBOJbq95l92YTVoMtGqlbYPAv
	omslCNZumFSps2YioaNdznSeQDyHpFbeTZMejvqrGqQ6BlOKk1jJW/MeKXL+3EwvHzrcHA2ajoS
	ihgDHOUJLNSeSuOZ/enPm49d3knfDez5Pv2e2ArmBNHEEVGGttEWPmtae4j15psGyGLxyou1BpZ
	7fQW/5BlMNdWp5vpF9qsm
X-Google-Smtp-Source: AGHT+IFoTYNKuvisb2Nf2HNU64oJYWZ1oJ5EubtlHVoN0Ry37Umdzq3TL1vC1SX2bh8dDZ/J/0RBnA==
X-Received: by 2002:a5d:5f48:0:b0:39c:13fd:e2fa with SMTP id ffacd0b85a97d-39d8f4731e8mr1579097f8f.28.1744278925847;
        Thu, 10 Apr 2025 02:55:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:25 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Subject: [net-next PATCH v7 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Thu, 10 Apr 2025 11:53:36 +0200
Message-ID: <20250410095443.30848-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aeonsemi PHYs and the requirement of a firmware to correctly work.
Also document the max number of LEDs supported and what PHY ID expose
when no firmware is loaded.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
registers before the firmware is loaded.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


