Return-Path: <netdev+bounces-139181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBCF9B0BD0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8D11F2480E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D520C336;
	Fri, 25 Oct 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="EBnNh4pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB902800
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877984; cv=none; b=F0aGRjOIP7EH1V1h8Ib3QvU/rKCv0l9jH57ddlUpxTqFcW+RJ4H2hXXm/RifUtBUbs9k8k8qAhjahyxKAxkX2WS6DV3VfzUJTSzdXalgxr+xQdNnAvXYjPR4VUaqLHLT/VGh37NIpSm0awXF8A8lHYeqdMdIdW7k+cvwspW35RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877984; c=relaxed/simple;
	bh=9pP9vG1L+mjIEPXQobrdDm63/EukPkmkytiXylfiwJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OamRrIIDvU/+wpqHkU3mpgdgn/yOH5iICKxCknNhAt31ae3f6/nAmHzDb68NI/eOc2cXy82F6gBsiLTxVbh86XBWstPDJRY10fhamCcoH1zAlN15KWauU4s+BuWxJv3Gftm+JStI48tauBVJCCw8WVLDZv3dbeSMT2hpSuwpRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=EBnNh4pa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso1719515a91.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1729877982; x=1730482782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RE/6bdE82IU4QyzbV1hsrlTmhXugWRMXOJiUEpwCLi8=;
        b=EBnNh4paSe7YXlT+ohkUuZxJHtGS0h1TWp8pyOT7mn2hBMR2jwKw0L9koyNVsnHQ98
         Su9Zp5FUQckFqagrN3kLhCkW/cr/nlbtuMsyfLhkD9zkB0zzOK8YkZdsLteTlGu4MA1y
         6XOzi3aBMhcg3oJGYhuEv6XGjgd1xePagzxNx1+v5/x32wm7wWTrCEVA6Oh9uMvg0TBT
         MQZG1yczEd4NduxC0urVXI0FoCr5wLqPIJvPA19YJGA81DechZBeudCyk0/DZ+osE0Sz
         QkrdsbIkwKj0KuBmYskPoGn88A1rKfYJJ7xK1TMtDdwxZI1gXHuENsXbLa1vSZNAqr76
         OudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877982; x=1730482782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE/6bdE82IU4QyzbV1hsrlTmhXugWRMXOJiUEpwCLi8=;
        b=cLdA8j3QrpHd2eSGdrZOOBhUQ3UnrOH3i7NR3qEo1/YYFNfMfKZukIhnKLgu163OuF
         02FCVmY7YPMCPusrSwDhCqfdbQbsniHsNXbcasP4GCJfFB9bUW1wX+q8Yc0MrMpH5hvp
         HDvJOx7RT+eFsC8K0aBRTB4x36Yx5wbKhnQ6p0JcuqxHzl5IlgpM5hy2dI/yfn87iL/l
         DhPLlzOad8fDt3lEJ87eQ8kLhkopunSGP3IP6qex+4foR5v7Zqtim1hUIJIFSSkPFzvJ
         XMNK27HBdY5XQ01N8h07HujBYH2J17hJKPPsB7yx6opU79B0UJAfySuO7bVmrlHO7kLu
         Q14g==
X-Gm-Message-State: AOJu0Yx8/771vdPwzsqX3lcowsdjirD0K8CI05fLJLqfyWwi0rSfkehM
	ZORJnO6YsOyeF8alTPhnYlak6R1iEHr715bzlfGeqttE+HWxyKmG+b5/HC3/rYA=
X-Google-Smtp-Source: AGHT+IEVi/JnSEoEmb/oANDw83QHAV0rm+Tjpr64rcE0SEGxppo+dS3Gh8supNN8sTs49Y30HpEovQ==
X-Received: by 2002:a17:90a:fb8a:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2e8f11bee8bmr150527a91.33.1729877982182;
        Fri, 25 Oct 2024 10:39:42 -0700 (PDT)
Received: from [127.0.1.1] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm3813961a91.13.2024.10.25.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:39:41 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Fri, 25 Oct 2024 10:39:08 -0700
Subject: [PATCH net-next v5 1/2] dt-bindings: net: Add T-HEAD dwmac support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-th1520-gmac-v5-1-38d0a48406ff@tenstorrent.com>
References: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
In-Reply-To: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1

From: Jisheng Zhang <jszhang@kernel.org>

Add documentation to describe the DesginWare-based GMAC controllers in
the T-HEAD TH1520 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: rename compatible, add apb registers as second reg of gmac node,
       add clocks and interrupts poroperties]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 110 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..474ade185033 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -99,6 +99,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - thead,th1520-gmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
new file mode 100644
index 000000000000..6d9de3303762
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/thead,th1520-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 GMAC Ethernet controller
+
+maintainers:
+  - Drew Fustini <dfustini@tenstorrent.com>
+
+description: |
+  The TH1520 GMAC is described in the TH1520 Peripheral Interface User Manual
+  https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
+
+  Features include
+    - Compliant with IEEE802.3 Specification
+    - IEEE 1588-2008 standard for precision networked clock synchronization
+    - Supports 10/100/1000Mbps data transfer rate
+    - Supports RGMII/MII interface
+    - Preamble and start of frame data (SFD) insertion in Transmit path
+    - Preamble and SFD deletion in the Receive path
+    - Automatic CRC and pad generation options for receive frames
+    - MDIO master interface for PHY device configuration and management
+
+  The GMAC Registers consists of two parts
+    - APB registers are used to configure clock frequency/clock enable/clock
+      direction/PHY interface type.
+    - AHB registers are use to configure GMAC core (DesignWare Core part).
+      GMAC core register consists of DMA registers and GMAC registers.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - thead,th1520-gmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - thead,th1520-gmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    items:
+      - description: DesignWare GMAC IP core registers
+      - description: GMAC APB registers
+
+  reg-names:
+    items:
+      - const: dwmac
+      - const: apb
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: Peripheral registers interface clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: pclk
+
+  interrupts:
+    items:
+      - description: Combined signal for various interrupt events
+
+  interrupt-names:
+    items:
+      - const: macirq
+
+required:
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@e7070000 {
+        compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
+        reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
+        reg-names = "dwmac", "apb";
+        clocks = <&clk 1>, <&clk 2>;
+        clock-names = "stmmaceth", "pclk";
+        interrupts = <66>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,pbl = <32>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..72dee6d07ced 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19827,6 +19827,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h

-- 
2.34.1


