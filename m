Return-Path: <netdev+bounces-56058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2638B80DACD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C671F21A14
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11B537EA;
	Mon, 11 Dec 2023 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIE9IMlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206FCF;
	Mon, 11 Dec 2023 11:23:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so44963955e9.3;
        Mon, 11 Dec 2023 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322630; x=1702927430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tu3fg1/rS/+bYOcrvks/nBcdytZNwbzNp186x5K+04=;
        b=AIE9IMlmzE0JirVeS7ZYw+hkHOVkw/WytTuf2ThkdqP+F+Uhju/pmsauD7auFreEcr
         eXbF8Wk3Av/xaCkg0WwMiZ0ZEAmuMKA1F9talkFM2xX3Q0m0bHNCBPAmVqczyk3iYFdY
         xrBM2JmFguIqjXJLvuPAoJzSvgyDt1l+QkhIFgaVjBJ5EW8g+0L/I61u1hF/luZauR3f
         zj4icCiEim8YfQ0MPxomOiY+HkekFYZXEYfLC3a8qCyfOFx9SGi2wzEFYmeWbkMyEYj1
         C+ZST+7sPJBAjN3+/IwCJaI9K/xKR2Xp0H5aLBcuh2+LYAoCm82UwxQAaZvG0KN4Jlb+
         N/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322630; x=1702927430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tu3fg1/rS/+bYOcrvks/nBcdytZNwbzNp186x5K+04=;
        b=qd7HevFtxk7F+i8Fy5KR3BY9xud0ZYVtJcok2nXUWD+qndQ5Iu0pKYs6oIuFrEDQkF
         uQFKbdYjzQDLTI/9pt6Fm6ANFxLPeZnsKHg3iwS4lw2u5RGzcrMZKgirdiipQi1I0jNA
         mL7y4JbfyLoB9DL7RXt/p3Nb5/K8w2sk6wK4fuBxM9MHa4E7l3dpTG87xer+Y5TQn9Uj
         EVl8jqXn5Au8TP4OflinctiiKoNBn/MDhfBIeNH2jqXvxjFxJNltZ2SjgVOJ8B/8J/ts
         tV8IJhmCOomQnfp8fSSK5nTRi0zJy0jMs7HPwYRgAXVzZkU2lq0OTqBIDNYSEPg/sPCt
         kltQ==
X-Gm-Message-State: AOJu0Yz1ctQjhxb0bMOuyP9pmwREn5PK2WqZ5okGFychm+CBAG9E3BYR
	fvUQBjFviVr1ZpqzGImGN2A=
X-Google-Smtp-Source: AGHT+IE4pEvyhN1PLvE5n0ISF8j0xJx6F272hJXp74r92/8qMW5tbhqUw8yYMqcxHHEeuFuqMmYoPA==
X-Received: by 2002:a05:600c:3217:b0:40c:246c:bd88 with SMTP id r23-20020a05600c321700b0040c246cbd88mr1214054wmp.343.1702322629834;
        Mon, 11 Dec 2023 11:23:49 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d16-20020a5d4f90000000b0033349bccac6sm9325197wru.1.2023.12.11.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:23:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 3/4] dt-bindings: net: Document QCA808x PHYs
Date: Mon, 11 Dec 2023 20:23:17 +0100
Message-Id: <20231211192318.16450-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211192318.16450-1-ansuelsmth@gmail.com>
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation for QCA808x PHYs for the additional LED configuration
for this PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix License warning from checkpatch
- Drop redundant Description phrase
- Improve commit tile
- Drop special property (generalized)

 .../devicetree/bindings/net/qca,qca808x.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
new file mode 100644
index 000000000000..ec8b31324df5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros QCA808X PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  QCA808X PHYs can have up to 3 LEDs attached.
+  All 3 LEDs are disabled by default.
+  2 LEDs have dedicated pins with the 3rd LED having the
+  double function of Interrupt LEDs/GPIO or additional LED.
+
+  By default this special PIN is set to LED function.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id004d.d101
+  required:
+    - compatible
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
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id004d.d101";
+            reg = <0>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_WAN;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
-- 
2.40.1


