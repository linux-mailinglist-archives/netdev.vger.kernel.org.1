Return-Path: <netdev+bounces-177873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA70A72712
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 00:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B600189592B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA052265600;
	Wed, 26 Mar 2025 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4gG70e9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5289264F8A;
	Wed, 26 Mar 2025 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032154; cv=none; b=pKG6gsy04geC/RdBAamn5pYaErF4qNgGZ+Pmnp/kqaz6a1Rx+k/evv3hXnMRpLVeBULvGrgX3u0b3xwhF1yihkTO91zjO6cjcAXrxwF54D4G9DAjGzYllOqtkrwIP8gaqC+FZ2kZKsgSbjMfp0F0P5zTvv3xkMqq91M0YV0UptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032154; c=relaxed/simple;
	bh=aaP5jjL1QpF5Nj21o9Xb0lF9G3T0YoMhm8JsQ1WNWVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SebclYdcl/pMFL67SQ6S/J5OchrcYu5l6BkY53aBhejSfaISckB9bqhp5hC8Wa7y65psfOl8+JTDXmuP20KRWGMB2W6jHYioxy/ECzaSUo69qtUEBt1n61F2vUkEk5u5EWcqOQrF0SOnkyCo9ddLDJhVegb3lAM700Y5vButNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4gG70e9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso267930f8f.2;
        Wed, 26 Mar 2025 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743032151; x=1743636951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GVOqH2dtb9yz9XSZOrN5yDH4kiqYTHV4lLBUZDoMkU=;
        b=c4gG70e9mqVteghtXEbd41WjIF91Kv+CutxcYqCSZibH/QMoCPIcH9AJd6K5taxRjA
         9ayko0n8EzzFEjG4Ua+n9XbELAgXjjAHIWvmB2uH6xFDZQv23caYPOMrmBikc7gC9d5l
         nenhowVJseTkzOMPFP3Eyi2JYnSVUiewo683VWyUdzj8z5fLb0SjM9ToGML6U9Btxg/l
         XVe0EASzo6uAC2Z3PCc5XowXupAt0WQpz3LUSGsBMDYieZiHnS2TGSQ7QgXRT5XkaYXa
         oGJgm1+8T3iPF3a2mfPgIDnggSXT1r4qD9wJoclfDWc7Q8JTeevnxX0f6FX2xcHwLkeS
         bhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743032151; x=1743636951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GVOqH2dtb9yz9XSZOrN5yDH4kiqYTHV4lLBUZDoMkU=;
        b=E29ZYJljNmc4dGUFjOJijmFzr2JbPhUE4ZVJRhdWumS1XvUENoju8bRpBK/0f9rLtv
         3Aajxq4691ZOdgML9/CXUzoWdYH4tCnsOAThks3tjH+q1NkHb5bB8Y3If0WbvnUY4LQW
         J2IAjbEpxO+IoFSdekzhlanuLseOg1gi5xKaAsKz25Y7JUg7DETVo0Gj2yIymGYKeN01
         RnwiJTJM6O6uBo3jyldfXPZbTu7IKwMlcy9I6iOXKRxMwiJvuRDN9olCnb8sCE/NseJm
         DsFOWoeGeYwEWZn1k5Q7Sb5xagXJZH7f5Npwd5oByJgaejfvgOx2igMVE4bKtCft8GxW
         IGhA==
X-Forwarded-Encrypted: i=1; AJvYcCU97o1lKmiF2bleZE+4Ko8zO/BF0VeR8L1JtBaxiLPNzH79j4TYNjSfpg69M4oYOy/9f0U5OjKO71kHe8G4@vger.kernel.org, AJvYcCVRzyEKVM02xYc3GhYlUytQf0mpskf0BdjBBAbbg+dmkIl+96Qa9UiycjqQ2C62nyOHeeoRVCwE@vger.kernel.org, AJvYcCXtAxdQhwYRstdy70on7BKEC7CoYAJVaunFLC9YwtasCx0AAet6u/uqc+mxvnrsLu8NH71e1Swgz3TQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3Do2qGHQKfta7Z+REnMipel3CQSQWogRafX7KbTz0f0nr71f
	N+kmG7BVUaKhljnWB6vzQF2df1X/d5AiKtBk000cOgNhby0qK5NCBQ5UTg==
X-Gm-Gg: ASbGnctQGA54uv+gBGBIUcPXOdgN9yZmUKP/dcyWCSVy8L8HHvuWoYYR3Ttpk70inJz
	kpC3hZZB5Kz1Aw1DY/qTimp8Kz0XLnmA/ckKKZASvfrX3wbeFE+tuWtTCEk0j5P0y/I3tPbMyDb
	GEv8U2sfjAKUaNIVHwlYTlEyDY88yf4wdySX/SqjwOVILdKfOjWLqb3Dbd5UVB3oE3C+byIE0q1
	BrI+/WjIHk51SCl+EsibRm2t0DPdIGlmVOXsvj4fdS7cQHtXcXjsc/oLPmykIgNI9OrE2Veg3NW
	opf/rx2Bbz7RTxUgBb1VGh1Gz5eyT3ybmkGNGLWjux8ZsPBjaHlU38tf39XyazxnO5TympyMH7x
	w5VH59+VW4x58qQ==
X-Google-Smtp-Source: AGHT+IFOa8WBGjFsJmHmRWSTbNPfcCi7DBXbnYepm+dNeI31EeMdbL+3WWzWWeVUU99LlcbWl2kQPQ==
X-Received: by 2002:a05:6000:1ace:b0:391:29f:4f70 with SMTP id ffacd0b85a97d-39ad17544e8mr1002400f8f.3.1743032150980;
        Wed, 26 Mar 2025 16:35:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f99579bsm18390328f8f.19.2025.03.26.16.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:35:50 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v3 4/4] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Thu, 27 Mar 2025 00:35:04 +0100
Message-ID: <20250326233512.17153-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326233512.17153-1-ansuelsmth@gmail.com>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
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
index 9a2df6d221bd..59a863dd3b70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -649,6 +649,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


