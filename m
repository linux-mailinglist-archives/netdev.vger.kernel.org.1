Return-Path: <netdev+bounces-147969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198F9DF8F8
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A51B21633
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE803A8CB;
	Mon,  2 Dec 2024 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gifRNBRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483C2C1A2;
	Mon,  2 Dec 2024 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107027; cv=none; b=Kw9fqx7DY4G+NfQ5abQjgC0OZvqxJx4Fuji11QLuhclp6WE0TU6p5/saDMfoRTJSDAojTOqQK8sxv+GWmF2GAKJqjxXrNUxWCJmAXpFcw2qqmViCMLuylPmUTVXqztD0aT47v7mS9jdqqbhKLtfKHlozUGiywm4NfFKaUkZH/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107027; c=relaxed/simple;
	bh=jVkEV8xbrrm6VXOVBhcrl25jIFssS06OALSSAY0egeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV2Wevo4JhF5QElGRzhw5E07fX2cC9zJiVz4uL20mK2A4N8cYahxtq8Cz/IYSIeN+czH+sekfViJRR2Q77CIRU4by9pTSbE4CoZxPGQ+V6zhYl5zZBdW67TSYvkPESZyl5bGOLrfogmkqOVlTzNhaN2snlnydv2VD/Fp5hk4+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gifRNBRW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2127d4140bbso32401105ad.1;
        Sun, 01 Dec 2024 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733107025; x=1733711825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG94va8ypf99d2NskGYXMHjsD3eWiwiqY5c/5WU2nZg=;
        b=gifRNBRWowTlrVAcBv+3WMWly5ujELV4ubowLe8o7MLCsc7v1M6ndeT0N7nvBpAhDC
         CSRpCHQDetyAG6K+yl/4N9yuHkglxiXhYURWtCTk06Q1Zuh8ZzsivUo2jWrSHyTD0MBg
         k4itnfG94n432u2ylUkVSXq18K8heALBjFyFvvhlkUV0ZKXaAF7F3zoTfUYRdy7PFlLw
         pt2kntmBVCJJvT747KSdJuk/KpNhnn8GeJydDwItdoPn65E5OCvP+v/JSLj4rlJj3KSA
         K9HltGQ/u6rl7+JYCoZeEgw5tQb9iHTy18iaj1e5KhGQzpy2xJBlzhYvfhxULvd2LCbL
         041g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733107025; x=1733711825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG94va8ypf99d2NskGYXMHjsD3eWiwiqY5c/5WU2nZg=;
        b=YFw9mOeQgEbStMLOAsumn/UZrTVS7WeLtlqbvpXg3D1UaFtDa7qSqDo518uZ3SA835
         2gm84TVHqfdz812rEFJGbsend7/3xLwL004JoheEQD4kRrMxP29ORqTn7bKx/BUN2Qwt
         0XLmrPuBKcxFupCrvpbhlK8J1P84Z1fC/2yA/boQgpAdNWjqCyoVjAV9iHGWOSQNeouu
         mzsTnEt6j85c2BeeUo553MeY2N6VRtRILAzoJGnimLxNbmw9SDv7fXUGUm4dzWo3qwdy
         gEHMfjczjHNlRkloHHR1qTWg5Ot8PAAjP9IwF0R3BNePlXjyACfj6bN67pJ6gjRWcM4X
         6TNg==
X-Forwarded-Encrypted: i=1; AJvYcCUdN3lYaunt9d4fABlo33JjW4qEnGIzlTuTz21fzTNEfXtdNTCGwlF0A7lC9tVocRKGWrbjRnh0vNSaEvs7@vger.kernel.org, AJvYcCWikanWyrwKWdjAh0lMV9upucaTXZN0b4CG1ibejWYOTlM/UN7xAtE/+mutkY2g/XyMNB+XUd0p@vger.kernel.org, AJvYcCXCeCqMj+9qBH1q8DtUkMF60mWIYZ9uWTr1XOmBjQ84k6kOVhVP5UA7lBU7gHnTV/1qsIfzIq/GwSzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoCvTMTXcS/l0KpFLVbhnkheWeLCs+881KgxmjMygyv8AnWKC
	os8BJ1tT5F5WSa8ABHQhyTig93upfUs8suSfQhNRCY3E8nJGjYLG+bMsoO2X
X-Gm-Gg: ASbGncubj6ZnV7E4GEvyukY8u55Owy+EO6h0fYSG7fpkPD/XtazhcuX5HR4eXDs9JEj
	JNR2csmqxG5fkjHzuXBxdDaC4KL3pxOzUi4Zr7OcC8JkZ2ryrY3YM6j9oc5IJ9keB6qFaQ6xTuZ
	0x5uoN9AnL25jgje94pP3g6C3QeiQZu64ystUG1qLADKLoRcaGMR2SjcYM8zxeLq+OW3uKcyb+o
	Z5E9whCzk+F1GOxovByboJJTArc/HjZAm4/AHS00ccCKJphTyU2we5dfAKLISTnZfwVt8H72RCG
	L50nsxlCvTOeik8=
X-Google-Smtp-Source: AGHT+IGyPeW7JXPciQ4EHmDYDKeuvpqZEgyqs8QENTRM0ZvMM7Orzqyw1FSYyWgIqIU42eiZfyWhgw==
X-Received: by 2002:a17:902:f60c:b0:215:8103:6339 with SMTP id d9443c01a7336-215810365demr56187415ad.41.1733107024763;
        Sun, 01 Dec 2024 18:37:04 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebee334sm2306375ad.67.2024.12.01.18.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 18:37:04 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Mon,  2 Dec 2024 10:36:41 +0800
Message-Id: <20241202023643.75010-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202023643.75010-1-a0987203069@gmail.com>
References: <20241202023643.75010-1-a0987203069@gmail.com>
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
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 134 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..e44abaf4da3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,134 @@
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
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+  - phy-mode
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


