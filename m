Return-Path: <netdev+bounces-189571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40842AB2A6A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A192E7A567A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326F266564;
	Sun, 11 May 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDkV+Tlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3426561A;
	Sun, 11 May 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988833; cv=none; b=EKo1GQQPz8gDOXOYuIOzKDTzpkSUfrk/lbiPV/NiMIi9cazJnselGe0lFZ8BWC5HyI6N/s6zHEUDPW+BmvzruwS+SP9tuaX9ZKMAobp8wLZue7IoaA9asbu0EQ7NfTrQYEAuNLQQw6O8Mq/7ijKt90oklIDjw17t6uyKLglVQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988833; c=relaxed/simple;
	bh=p1ogddfKyDLswZD+8Lq4q/ukt2Ed9aQburf2hvVJ6Ro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBkUc/VObJxN7DWNFH3PjeCfWuK82oVyiJ1CsPhZawG/Q5vsgvzVsV0tXo2ddO7Q8+RQhXvzlNz2EaIGZds6duZbl0+JEiS7Fel25nPek4XfbXJg6zsaPC6q/rmgUlzbgqRUmOhwDpysvctTL/8gsKKOD7PHqyafd6IDEBFG3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDkV+Tlc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edb40f357so24693435e9.0;
        Sun, 11 May 2025 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988829; x=1747593629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uezwVFz0Zcagk+1GhVcJ7am3l2Fc5VtSdFSVCAllSAg=;
        b=GDkV+Tlc3WlIsEGdUsMO6rJsEPR5xQhF2Te0UEu1MwqfGB4pa5Q+IHuEvUmg+AJ0Ud
         ZYZ7hVoPtCnHmjKTE0wenTbFNcHIAcpe9ivu3U0JWGDOWJ5liiyulLsG3Zf9bvwmJNSW
         JEmot8/szIkPiYTIPVCphZdHjurE9JXlYlth4VeBew+KuG1HamD/bwqJnlMMN1cUMWII
         EKqn+UBng21OXHDMf6b7Gdqr6FoctOGmU6GyjHCUYymexjyzttuawtbp6xge8r8gFMXB
         jpe578LAQ2vxDk1ZwkefIqDzh5SlAlGekHjD+lJ5TItYA6t1zvYf/HxPvnOCRshOjnuG
         OusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988829; x=1747593629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uezwVFz0Zcagk+1GhVcJ7am3l2Fc5VtSdFSVCAllSAg=;
        b=B26ml9bbmNhMeR/981+gZXkhN4aCJOWGXbDJjL/U78U+34Zn+vH3uzEaSag4nzAec5
         f77rxGPGhdlXYb2sYLz+b02Nd6vCuy8VoSgCQQ7l3J5KHx6PYhOlVKouG+WrVQ7sDYJT
         O3csjzjTfx80n9l+tV4yqY5tmId/bTap+eOQKej6y0Wa8seb5axAbW1RXDs7WAMVYM5/
         2ZMSjc+jRV5o3EKofPDr4K2YMxq2ZWXw98XFeIgqW9scjQDOjQR/kO1I1LY7VL9R7drz
         NA5i8AgvmmXEr6usC8Me+XlbQYapibyO9Xl3YdCHJdrOna9Kt3wKz69W49FE72VrLWOv
         MXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26YQGhcAJbib0Qhj/Tz+kxLsBx9xUramPGpfpJW75STB0yInor6oczz0qSDnN5Gic1Mn9LvIWeqp2@vger.kernel.org, AJvYcCUXYYbQA4vJmnxd30p5yviHJRSstwGl6kduJ8CsRz0P6qgqAKKZEvLozAgfLFYAtIc66Z2DdLybHzMmy8Z9@vger.kernel.org, AJvYcCWu3BrADRCNsxpr2sx5MzMKX5WnD+o5Snx4UWDzQ/9oxaMXaWnZ1u2ukQLUB0sodftE7D630tZv@vger.kernel.org
X-Gm-Message-State: AOJu0YzNy0/euWYL8b95STngi9hCwBNcb7Kg89Yxhf+orQ3/RxaxlcQK
	NFiKZz0RWv1M8k2V6sES0+LSn7ATqm+eM/xzRoQTZ40QqEy3i46m
X-Gm-Gg: ASbGnctuooDf+29B2Hx2daMzr+XkIP4JkvOlrjYx97pKg8cCWC8+QJ055gIx7Bx9O3S
	E1v63wR26/EM5RBVNuV6ycy0ygntusubzb1KhpKBfJDvkGVHdKoFgQSw4xZnvuybnMoePTvU9zo
	9P+hXgiSq1wlJFlBcrni7MU3CPEecLyqCoU4hJM21SwZWRqR+pE3oCg0e+D8GDemiTcOT7vq++x
	MXUWNZSi3Lsinb3vGpbWZ93CVballaNCM5dXrbCRwq4b7PGZUu8NGrI3K5RSCLjLFWXqxddyBvr
	qeP2CvyCJ3UhvURpsNGCP1way4BkhJULhR5z/Jv6cVKy6FRbKbU2VuSAi44c+P9PDeY8Sx69XRd
	CTAZMXqDRDNNsdA1GzVpI
X-Google-Smtp-Source: AGHT+IGPjqsU0Ip7uh8YSG5JzxxEBr4k3RRUbVfTQt+wUKn8t+Nq0pI8B+VtSjQZzfxKUTtTNDf3yA==
X-Received: by 2002:a05:600c:8207:b0:43c:ee62:33f5 with SMTP id 5b1f17b1804b1-442d6ddcf2dmr84090325e9.27.1746988828786;
        Sun, 11 May 2025 11:40:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:28 -0700 (PDT)
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
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v9 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Sun, 11 May 2025 20:39:30 +0200
Message-ID: <20250511183933.3749017-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511183933.3749017-1-ansuelsmth@gmail.com>
References: <20250511183933.3749017-1-ansuelsmth@gmail.com>
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
index 39f66be67729..6ef492ffbaaf 100644
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


