Return-Path: <netdev+bounces-200528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5EAE5E36
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F5C162BA9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68B255F56;
	Tue, 24 Jun 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv0ac55w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6625229C
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750888; cv=none; b=oCvL/GmUTmLCMQtmIVRZ6TzCkRmqWVXXl4V1RENVbiSO6BGmCHyFnYYgoiyl1rYka8jxbvuB2vwgD05nBNMAdlTtbbKSir2IXOsJCq/XKyT7y5HmD7A/ylALPM0BZQ8bivQNiyxkjU5shy/Zd4fDgTSHQn+2k7iQlqY2I2GQa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750888; c=relaxed/simple;
	bh=DNuz6iFvphGnaJx3Izi4GE+g8TrJoAvIY4eoazXj6hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGklXkYtwcmSnkXJxWeeZkSU2jFOQCk+CRz3YJPzAJqvx3madiN/5auAv4amcxaOlV+DML4iDfcu8ocjHuHhiDPMQzV7xb8LOnic8XHkRbi8mLpWl9sYv9utlc2O0breoVL08whMhKhjGZXyBMbH3IxlHzea1zTcMxHc2pjCs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sv0ac55w; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b3316160so3862938e87.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750750884; x=1751355684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze8jlwcX3wGpoBSVQqWFzuz8lb3yzavNGri+69brSiI=;
        b=sv0ac55wOOID9w8j+/hcu56TnS8iqUd8sjpo2uzWO9KviNleX2RKKl7Zy5SPE4fZuR
         w42rSG2zXzWMkGdVYSPezn4kEY3JKNG3a+90X2xodNnwlz3To6y5YP4Pie2UWtcJssmu
         rEOHpd8RR5RtyTHuoQPE6Yn8L3Q3Yc4W0rRVhJHKpUU4MLdEFh+cvJ1GNVbxTiEc2j3D
         VbuVKFcfczZo2Gz9aoXm8eUWGqPxe0DxWB+qEWJ4YaFqd5fOVnnWv3IqoNi0FfU+FIRg
         x84CRA2qvtBElxwcyu/QBXPLrkJOZUXYbxvDyskbgHnDpyQtXcxliBjwSEYCEeUWvGLr
         gU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750884; x=1751355684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze8jlwcX3wGpoBSVQqWFzuz8lb3yzavNGri+69brSiI=;
        b=DekIYL2L5h8VJq0Z6nJ7EfL2Zt70fulVGN+STsJc8qA4iwRmzr0VtBRNRN0Ht46DWb
         Vv+6BikXNeDITiJ2FbU8KIuMU26GMdISFUMoPjxQdEdRK/dNTU/QH+QSYtce+DcskmTB
         1g+XXAVgzl0vTo3A5Jj7CdDp+vV6Y1GtJ5cLYMTVkL0Urv8NdUpe+sLqBQiTJ39i22u7
         SwCftl29w+Dl9RZ1e6cxphfoESvoJLFXIFKtThk6u9FA8gAcl9wabxt0r1hCXYMMM4jQ
         23WyzGn1JwcoSWqRTyZqk9ffQ52YS/0TJXaySVgFj9wm6LSDSvnDSrr5SwCiqQBIS1ri
         MVvA==
X-Forwarded-Encrypted: i=1; AJvYcCWXgItS38cdu1Kg1epv9e10YCzfKxVGpdYVKKM0G+Dphyxyj6bJDwmes9LEzweZRCXxZaepSYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlz/0fMP0AmqXE43UByeyRt1txUubArdmrd/0MMYJ8BMwBTKlw
	hTYB9f94BHX2Cf972Eau467g8njFbQNtt8B+FivzdOsMC/LpEyvIz9zCMDS2Dnu6tRs=
X-Gm-Gg: ASbGnctegrCBSQu5mT/9E8rOCI0DVTJtEMXbqRqsI90cDdfXTcG4jB8LGvJDWtvix/i
	JZ+iJp+WDAsnoky5LicH3basPGn2AWfilEefb99H6wsQ8r7VbZp8IMpQ5jMjTnuAmSI0jEDmxIO
	uTDGX55NnSNxK99/UeUyt9JjkUD5iPN/ReDShgNpXVL+wjHTpTM0dEJS2GZGExf1CXRtasrglbB
	xXpCZEKzk/DVo132Gy9jJ6JAMx3QdiBH+32M+mLcozmhUsVtX8Q2XVfqRRbAmaC/yUYspOYXYEs
	EuYbZX2/Yau+RHbHQXC38qLEiG7dQYXRwh7+N6fEsUS5g1GggH3G/4gvFM5UTQGiwBgJ4Cu3
X-Google-Smtp-Source: AGHT+IF7w7unFh+Qj1ghtqC3NBYjATYxbPX/8QFxjMt18MPM2O6aYmvQYqDIBUtxD/2CaXDd62dqmA==
X-Received: by 2002:ac2:4bc8:0:b0:553:35ad:2f2d with SMTP id 2adb3069b0e04-553e3baf9c5mr3916779e87.18.1750750884270;
        Tue, 24 Jun 2025 00:41:24 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cc0d4sm1702545e87.197.2025.06.24.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:41:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Jun 2025 09:41:11 +0200
Subject: [PATCH net-next 1/2] dt-bindings: dsa: Rewrite Micrel KS8995 in
 schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-ks8995-dsa-bindings-v1-1-71a8b4f63315@linaro.org>
References: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
In-Reply-To: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Imre Kaloz <kaloz@openwrt.org>
Cc: Frederic Lambert <frdrc66@gmail.com>, Gabor Juhos <juhosg@openwrt.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

After studying the datasheets for some of the KS8995 variants
it becomes pretty obvious that this is a straight-forward
and simple DSA switch with one port in (CPU) and four outgoing
ports, and it even supports custom tags by setting a bit in
a special register, and elaborate VLAN handling as all DSA
switches do.

Rewrite the terse bindings to YAML, and move to the proper
subdirectory.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/dsa/micrel,ks8995.yaml | 86 ++++++++++++++++++++++
 .../devicetree/bindings/net/micrel-ks8995.txt      | 20 -----
 2 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml b/Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fcecfccbac2bb084db4166539bdd130cdcdae2df
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/micrel,ks8995.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Micrel KS8995 Family DSA Switches
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The Micrel KS8995 DSA Switches were produced in the early-to-mid 2000s.
+  The chip features a CPU port and four outgoing ports, each with an
+  internal PHY. The chip is managed over SPI.
+
+properties:
+  compatible:
+    enum:
+      - micrel,ks8995
+      - micrel,ksz8795
+      - micrel,ksz8864
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO to be used to reset the whole device
+    maxItems: 1
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet-switch@0 {
+        compatible = "micrel,ks8995";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+
+        ethernet-ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ethernet-port@0 {
+            reg = <0>;
+            label = "lan1";
+          };
+          ethernet-port@1 {
+            reg = <1>;
+            label = "lan2";
+          };
+          ethernet-port@2 {
+            reg = <2>;
+            label = "lan3";
+          };
+          ethernet-port@3 {
+            reg = <3>;
+            label = "lan4";
+          };
+          ethernet-port@4 {
+            reg = <4>;
+            ethernet = <&gmac1>;
+            phy-mode = "rgmii-id";
+            fixed-link {
+              speed = <1000>;
+              full-duplex;
+              pause;
+            };
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/micrel-ks8995.txt b/Documentation/devicetree/bindings/net/micrel-ks8995.txt
deleted file mode 100644
index 281bc2498d12764740dab821e8cabcb5e0a3d8fc..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/net/micrel-ks8995.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Micrel KS8995 SPI controlled Ethernet Switch families
-
-Required properties (according to spi-bus.txt):
-- compatible: either "micrel,ks8995", "micrel,ksz8864" or "micrel,ksz8795"
-
-Optional properties:
-- reset-gpios : phandle of gpio that will be used to reset chip during probe
-
-Example:
-
-spi-master {
-	...
-	switch@0 {
-		compatible = "micrel,ksz8795";
-
-		reg = <0>;
-		spi-max-frequency = <50000000>;
-		reset-gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
-	};
-};

-- 
2.49.0


