Return-Path: <netdev+bounces-179929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA4A7EEF2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CBE441EDC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292424DFFB;
	Mon,  7 Apr 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX8t4Gtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845B224254;
	Mon,  7 Apr 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056616; cv=none; b=G0L25882N6jEGdjgdeTQfTBuS7E2g4mC5R9QCCSXQZnIOxJ4rGQRiuziiMA30aJVwj0O6J734psEimrdlGkzA5kdlwzzntEmmlwgRrRItgIvTH9OZ6uIfpnsmPB4ELY1jRkM1Z4rrnljQGZNmi2R05DKktaVmb4weLmG0N0K/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056616; c=relaxed/simple;
	bh=4THuh4l2cNhIbqy6HlF/J7Hc+TBYJG/XLk/3DEKuZfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxSRsQhT4YanMwsmS4/pay6RMN6PhqdRBMFWkKligXobbxfK3SEBldGsBIVNqjjwctVWsolvJzP+g0WD56tVRW7X6tm0SNuHWtPYs7F1eUq0CPEizhXs5FUSzfps2tt19J4t6JA+ZwSt0/mYi4FlGaukUDxrfnXjhZyuTuICVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX8t4Gtc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39149bccb69so4409410f8f.2;
        Mon, 07 Apr 2025 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056613; x=1744661413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=XX8t4Gtc+DV3MsCJT+xuT7IUlWODJlLdGxo2WknOdXFn6sktlkHE2DPsJPIhjNtCUv
         3U11HSJp2UJZzdNmk4IP/8jRHvdZpUfhZWV3OCfP5u+YRc6BWFgjvDWpsK15YNAugpay
         F441CWyMhWfixxrBhMMTQSvTRQWvShW4E9NzERe4SDm/givFVJrJ46dPALCeBJXlZCz/
         dTEVGn2DR0N756cjVEEwBNjqpC7Ne/SGxsR3oRwY0I+V1L4orIDBLcTuaiLzCOSc4eNp
         an0kr5H1INi9pi68njja9IJsEybofsD/mWgKKTlXHs02O33dp4ymVL884lVTVALlJ8Ei
         YC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056613; x=1744661413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=bM6BHzZEk0RwxVoypcfQrtYpFN5k4IUOVA86eBoeFfP3tfYcKlG+J9y5sOBo2DSLpK
         g8qckjDGDj7ckpgF6wOK9BrHd3stOm8ylXTfYGWrGwUmbctJ90HQpMUFB5svYiuqBF1l
         h6fesGznfrMSdZXOtBPbcYbtP9EEtHIOA/ERHs3gv4sL+d7PTZjujxqG5AT/YfgxlpWy
         szuUdyQGtIeJjL6STC+GjzlZLTBPu+JPslu/c4RX6v0+bHusL/ZvETq6s0WifMAryISi
         rEizbyhekLdcGm5XwyDrZx2Bf122AeAAW4hRMTrlBzMA6P1o6qPigLEdCRB5jwlRhJlm
         5cGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb/VK2WMJ2i5S0X7mw1JetLgPMpXxh4FHd0LLjquSlR9MPALNoeC0Bd2cYT1SDo8FlNM8h21ewH5bdghOF@vger.kernel.org, AJvYcCWGI5BugClzgRgDl64gqmGrS0CQCbWN/FDvd2V1TIZxooGDA4GZjrrkmCH/a0i6rybASsi+sMGu@vger.kernel.org, AJvYcCWu13XfipQ85M/GDUFZiU15sBhYpqRQONcTFDx2MBZbgul/gtbIb2Y5qsnKBlFvAtNHGC8MRtDK6ExJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzisOlyto3b77XCZU8xazd9n7joNkemENJzQHdKgW/NNDoHpufx
	wNh2xsUBkrNWN5ibezCk8oL7OKiVsDY1jHyCLTmz6JWf6L31/21C
X-Gm-Gg: ASbGnctPp2Fa1X4Yz6s7HSHbYL8h7MGXerQQXqoro9GOkQ6hgHyLH3PHIwmDmFUCT/a
	WKMFFvVv0H7ALMj+IhAMMSsYly7qrShS0QJfff1TgRz4+E2elXYcEG5rBfH37Gq2wHlsUl4UCD1
	i9VyezX/4dg0n2i4WvCx3sFwlCjU/Gg24ELkYDl43mmLldmrldlfaVXKYWA2fduxlNZ1aBXiCwd
	LCK9N34P84MjfqaCFViQo6ZaVUrSyY3MOyNhYmImGc6xjI/6yCnWEEXL/PfSVdLaxfsciDOgNzM
	8GZPcQvooaFwNR3Dwoanh3eF9tdWreG0ExCV28cOwY1GYZ0jGOslK1r+oXglgki3gjKi+Xr8Kjq
	XL8xy7gcyc/Iskw==
X-Google-Smtp-Source: AGHT+IHcKTiAAT1Xb4Y7xPSiHnxVFr56KUk1LUjvUXUD8GOBUmmIlQOlFAQVy4mp+4uzzkAuN3gNYA==
X-Received: by 2002:a5d:64ac:0:b0:39c:30e2:7218 with SMTP id ffacd0b85a97d-39d6fd18da7mr6942191f8f.41.1744056612651;
        Mon, 07 Apr 2025 13:10:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:12 -0700 (PDT)
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
Subject: [net-next PATCH v6 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Mon,  7 Apr 2025 22:09:26 +0200
Message-ID: <20250407200933.27811-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200933.27811-1-ansuelsmth@gmail.com>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
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


