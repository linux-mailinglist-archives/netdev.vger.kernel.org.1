Return-Path: <netdev+bounces-152915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01E9F6533
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF97164C6A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB31A23B6;
	Wed, 18 Dec 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huqTZX2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FB1A23A6;
	Wed, 18 Dec 2024 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522297; cv=none; b=aVyneg0GlZfMomN9tuMBRteyZcIjBOFr2oxIADROpXXfm//rCwYGsCE2SZQQDRAIc3SRaIJ9g+yBj4g9oJBY1xU+pi6ONykAG7PQ0so5Y8rJfzSZfVBEZn3pORQxOk01XTwNqyH0v4fQ5rW50eD1WJkVysCuE0GpO6UonqpajtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522297; c=relaxed/simple;
	bh=yny0NlIdMZcnh9SPksE3fIPfMjVhWTQRP8RvSOm/ffo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XvzoS6uwvmFnXeqXa2kXAy/YLFbhA+/QdEri0nH6ZxCA2fKTmxSxovZedBxRma98o3Gb9W4STiloY03vXAp1KsV4c9pDTrNG8ssGIDWRexbGI+W1OEluJ6KYm5EqrxhIFu1TBz5Lka7hVCuWoNw1SBYk4/EBwXC/jv/Kpmj+qiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huqTZX2J; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd51285746so3819615a12.3;
        Wed, 18 Dec 2024 03:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734522295; x=1735127095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dW9tSKSb3CcOFy1YNdY01ABpN6qWxIbLh8Rm1LEF2s=;
        b=huqTZX2J1JsrAnAWiXPNCbsUFRL9NWXo7YWDenPpYbytxQrodRb7yeiRkeWwkY8M8T
         OXDQSy+syjubNF2YzWNEEhqmOEPWAEmglFQXgrCMNGtScZbNiJIyTByp7QQbLUQbQkwX
         yz9ZrWIB6fMhfgQ0PvU4DyLt1Telx6f1+UklM/uv3ReWXU8N6uvIewDzpu+X5eYuhQ1v
         DqJfANM+U0t/6wEOjh0lLoa1xiRVzjvLFZKa/WKE4DqEtd5dFRZ225T6yvD+sQhbsW74
         2cNY9MOdCJsLs2GCijLp97d+aZEineALzzSyV6BKA6H3RpfbeQxpn0Vq7HrILjBy+X89
         ZoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522295; x=1735127095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dW9tSKSb3CcOFy1YNdY01ABpN6qWxIbLh8Rm1LEF2s=;
        b=OYTd1hExf9t1a3NolfaMZQnv28VsW6pvPrEnlf3FuCHbGA17pvkHon8SEOU1gNe2uT
         6UZwDxaEpyNHxK6WNIqUa26Em3F3YfK39hQyXvbRGlmdS57+N5x/qH08BPgVpPP7M9Zx
         /6ZZDd6fqGO1VedF21AdzQhI5cbayjWoNdyeIghEwJIQYeFrOWFly7UPJLLbN4nJGIhD
         cKMsCIbLb3Hx6dkeczNTwcHOeq18b7XxvtgH6lin8z3dUhcHghVbsEXA7VSFZFfBUAfY
         GPvAmgl8MOOkDcFCdM5IFDyhOrEA77c70wIQRkpfxJVZ5JCwil4/utkMJWuOCxO84h+X
         xfxg==
X-Forwarded-Encrypted: i=1; AJvYcCU88/L3fEU9vkicuXBSkeZKqhuk89eKFWdqXCGQHIcZkv+W90R2KaExgu7F9WUMCVE6jIJ4qbDXcfQxWbNe@vger.kernel.org, AJvYcCUnAlLuC/HlGRtGWle4LxNnK5ovEXQyqL18EBsPrBZ1XN6HD7WyQ89rYy2cp5Uru6pwwi6a3YFb@vger.kernel.org, AJvYcCWSwTNHapt4CL5V85PclAprJoLlYb29XfLhgbavkEo1FQ/tEaviKW2iRbT0he046SALjugRrIYH+BsZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yysrq6NWWysNYEGsL51yzfaakISVOxzQsHNXX1MvVYi1RDWZEj1
	uxq86ni6BVubgXaO4+cLx46crD8sAW7MIhpYvwCSO+/pQXQSpTNF
X-Gm-Gg: ASbGncseIkKUYXUvjRlTOrlQ6Zd8KreovDUFJbmPMS3Oqv3fcibyJi+RlK/s4tkglbE
	H5cLbhCckIpIWZS4YPtDEIqb9w8iKu5MJM6DVbofDmEufK5cHRMR/C4J6LLcKvk5dHKfWiw/DMN
	yAtn+uArfFTvziYHyUj8cJenHwUh+P7fSQGQpLs11NkmdUhTkksoob9y31Ovx7cqL2x8xL7wKhE
	iz4+qfDNCrpZH1QTDZr3Ls/LHIk0DdKWAL43+82iXQlqJQzOqNkgyrZ7Bf0tHuM2gHHAA4k8TxY
	4adkGjCNZYnG0333b46zpg==
X-Google-Smtp-Source: AGHT+IHONX6Gx0giguOpmTW6fQVk1CaAqSvv5cTzOJz9POkcYbKiTEO3GeqPM6pq2BbnSq8Z/eze6A==
X-Received: by 2002:a17:90a:c2c6:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-2f2e91c13demr3765154a91.6.1734522295379;
        Wed, 18 Dec 2024 03:44:55 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm1324362a91.15.2024.12.18.03.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:44:55 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Wed, 18 Dec 2024 19:44:40 +0800
Message-Id: <20241218114442.137884-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218114442.137884-1-a0987203069@gmail.com>
References: <20241218114442.137884-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..c3f2ad423cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,ma35d1-dwmac
+
+  reg:
+    maxItems: 1
+    description:
+      Register range should be one of the GMAC interface.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum:
+              - 0
+              - 1
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+required:
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac";
+        reg = <0x40120000 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index eb1f3ae41ab9..4bf59ab910cc 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
-- 
2.34.1


