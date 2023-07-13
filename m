Return-Path: <netdev+bounces-17629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24C7526FA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8BD1C21421
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290A1F170;
	Thu, 13 Jul 2023 15:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D11F167
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:29:19 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED1F271C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso7834425e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262138; x=1691854138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQO6gNAEktA8kEixN8D27EH+Cpq5epFEey0edwAdXMY=;
        b=oQo6Gx7KIFLJF9/K18gtoCqYQ33/wKzBynQefMMsCw64qAU+lu7pQHtH+wC+8mwry1
         PyLLEWVT2oYpK9MntYve7kl+T0UZdJO2rwtz/IqOfahsHem9ft+J39t8LMKhfqbhRnBX
         9id4DrC3Ane9yGZuPBdqgKLthyhi85yLXeNVLyVDlzKjzrbq/yVyLi97nmUSRThibz/p
         5NS4ThHGgmBjmGO6t6CSmK23j3XuCMSHASFmNWMNYbDef1HPeMin265rAqmpTrpXwwqI
         AIgoZDtZzWQnpuy/mVHhbVRcNLj2eNpZMcm5QhBhCDGnT9iTckx9J9b54oB7H14QfQ8n
         XokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262138; x=1691854138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQO6gNAEktA8kEixN8D27EH+Cpq5epFEey0edwAdXMY=;
        b=jGjdfrNt+IbU+U23hh89s5XX8Hh66T6HOaA5HmHBODcU4tFwwKEw9g15r45sDwzy6j
         023Crq61YSod6ptqpc3mlYOLLDP612tY4kObQHJgE4rZPLJUlbznzDODB4mJ3rQOjKzP
         4S4Q+0XdbSrUx4LQhPudevEMCL0ym5UdRLG0nEbVyilIVeEOA+Vc9unzdSnhAQbcT/Z9
         +Y/zEJ/HdcvkqVK5G9hL/YYDxUSfA0ufXBiH+0jRZ5SbR0kCHKb9aKejQ031hgjjrpTD
         ZX9DLXDHcCxn4BdelU/6hRTI+Kqha5Bpu1yx6WTjbZCVQ+ElG5mBDdw8f8q/qTBOXzqZ
         AeRw==
X-Gm-Message-State: ABy/qLaxPWQqlv08f6TkNyEEha8D8q3sYDsTcsaMiViK3ML3UcOPnT2z
	3SVDhKLpZTy6ix8VLI5Qo5Wuuw==
X-Google-Smtp-Source: APBJJlGvxD217zUNMBN8WO2s3a+6x9vPlciyEoAeCGQQ7j2Yltg/heP99SNtLyfacrt14HvPp1etHg==
X-Received: by 2002:a05:600c:2902:b0:3fc:80a:993e with SMTP id i2-20020a05600c290200b003fc080a993emr1650459wmd.17.1689262137885;
        Thu, 13 Jul 2023 08:28:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm18563121wmi.18.2023.07.13.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:28:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: net: davicom,dm9000: convert to DT schema
Date: Thu, 13 Jul 2023 17:28:48 +0200
Message-Id: <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert the Davicom DM9000 Fast Ethernet Controller bindings to DT
schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/davicom,dm9000.yaml          | 59 +++++++++++++++++++
 .../bindings/net/davicom-dm9000.txt           | 27 ---------
 2 files changed, 59 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/davicom,dm9000.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000.txt

diff --git a/Documentation/devicetree/bindings/net/davicom,dm9000.yaml b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
new file mode 100644
index 000000000000..66a7c6eec767
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Davicom DM9000 Fast Ethernet Controller
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  compatible:
+    const: davicom,dm9000
+
+  reg:
+    items:
+      - description: Address registers
+      - description: Data registers
+
+  interrupts:
+    maxItems: 1
+
+  davicom,no-eeprom:
+    type: boolean
+    description: Configuration EEPROM is not available
+
+  davicom,ext-phy:
+    type: boolean
+    description: Use external PHY
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@a8000000 {
+        compatible = "davicom,dm9000";
+        reg = <0xa8000000 0x2>, <0xa8000002 0x2>;
+        interrupt-parent = <&gph1>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+        local-mac-address = [00 00 de ad be ef];
+        davicom,no-eeprom;
+    };
diff --git a/Documentation/devicetree/bindings/net/davicom-dm9000.txt b/Documentation/devicetree/bindings/net/davicom-dm9000.txt
deleted file mode 100644
index 64c159e9cbf7..000000000000
--- a/Documentation/devicetree/bindings/net/davicom-dm9000.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Davicom DM9000 Fast Ethernet controller
-
-Required properties:
-- compatible = "davicom,dm9000";
-- reg : physical addresses and sizes of registers, must contain 2 entries:
-    first entry : address register,
-    second entry : data register.
-- interrupts : interrupt specifier specific to interrupt controller
-
-Optional properties:
-- davicom,no-eeprom : Configuration EEPROM is not available
-- davicom,ext-phy : Use external PHY
-- reset-gpios : phandle of gpio that will be used to reset chip during probe
-- vcc-supply : phandle of regulator that will be used to enable power to chip
-
-Example:
-
-	ethernet@18000000 {
-		compatible = "davicom,dm9000";
-		reg = <0x18000000 0x2 0x18000004 0x2>;
-		interrupt-parent = <&gpn>;
-		interrupts = <7 4>;
-		local-mac-address = [00 00 de ad be ef];
-		davicom,no-eeprom;
-		reset-gpios = <&gpf 12 GPIO_ACTIVE_LOW>;
-		vcc-supply = <&eth0_power>;
-	};
-- 
2.34.1


