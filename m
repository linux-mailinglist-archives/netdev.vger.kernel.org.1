Return-Path: <netdev+bounces-130007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3D987903
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021461C21DBC
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415016A949;
	Thu, 26 Sep 2024 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="aZi7VZdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982D159598
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374580; cv=none; b=t2vnzRmzEBI9WXhRD8LLsOIDZ43gLvtExAtGHGM88md8ocXqtnn1hvzN8ogIYOTox3DWTtjPLwvykUob1IibS1MCpcaMJ9crHhGuvogiGqPAOMJe8rOtJGSZ2y7rtTaznVhxcP+UQ7q07hVyt6Wt1Z/lgmenTSALFe+ElVwIjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374580; c=relaxed/simple;
	bh=+DmOg772KRTncUlaaGhpnHiKABEQOPwsLnRZwNSfYRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6N5bW3XSUiadLqB5pKTLj4330lsu3awpmaJ3reZacLsylfOFDwZ4AVY3JmzQsj/CwJDyD1L4gFiVCvMaLHV2qA44oeM9zPYP/8WLfi2nl3gBsIV8fgJ0xGbzBrbuaQXb6aYtSPnKzCf0468+pc9/UYpcOqXSYqFKy86E7mWpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=aZi7VZdu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20aff65aa37so12059555ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727374578; x=1727979378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HADv+qSfkgZ8nk61nX3QcQ1gwTszTm91CMmr80W4IFM=;
        b=aZi7VZdudtEJedCaPH/rzMzSyFEqiaoeHHwkTNbmz4QLqj1G9spk5cENojuXi3fJwS
         lzE1J9SBm+jLsEjxuYxb/vAio/2JDkgj+asVpYMff4bRY5JRTks6urL0C1JQeG4/1IU1
         HfdmSGLx/cMDvsTCC9t8irl+ZEMLWiTBrmqkfzIeTartjiuw1FB/ZFMKkIds/tuIYWeJ
         jSHTnvmLIwg8mc07nfQe8idiSIkRi9c2KOpDUlKduYGkjMZmqzaRGAdsgXoMnqFjoVpS
         DvPxYCxplq3dx5M+Ux2oDj9wu50aCE9ybphOedP3lK80Jyn6eWPgM9jSXAyRwB1zd2Mi
         ecpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374578; x=1727979378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HADv+qSfkgZ8nk61nX3QcQ1gwTszTm91CMmr80W4IFM=;
        b=ULt23p47y4fET27qnTkTaqDGSPZQqwWK4RG9VeoRtjj5xI/GSDLqPzhW234+hzgWbw
         vG2FktBfRYrqVeJwn9kZavQNenILgumXnVw/aI+ZCYRECSyvJVdCTdo7hxvYsaqCpglM
         OlAyTFLDgci4CG/DBmpPfA7npc1tALiX3ThutWyHVfBFG1T97EbmimEsAeFXSNbQIJ5R
         IeH0yPEcwlQNzmOKp9ksIwK6NjVlNJKxLotS7lJTcWbdXIVxCs8nxR6AV8h42QxJCVVe
         gd6NnlL8hhCjJVAg7y1GFKW7NFWlcKd3BclszdEoy/RXkY9clJKnzrTDjv3sTV40gO5q
         S2Gg==
X-Gm-Message-State: AOJu0YyuczC1JNbOXZzVpgEJWWn2PJLIkqin57UxCkLpmgPI2iWHs9sB
	sZ37SIWALEBSvg7bzW6LDJ9nU9Pg9nFde6t6wJxFXipHRF9lCGUXJm38d3NJediE0uzgH5QG/t6
	o
X-Google-Smtp-Source: AGHT+IGj65OstZpitcA04pfkL8g5/NbyWX6+B/UQFa6le4tH/WNWTgOmFuHD32LjEcHjtAPKzkH/Qw==
X-Received: by 2002:a17:902:fc47:b0:205:7e3f:9e31 with SMTP id d9443c01a7336-20b37ba6a1emr7187025ad.60.1727374578172;
        Thu, 26 Sep 2024 11:16:18 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef5dsm1454145ad.32.2024.09.26.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:16:17 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Thu, 26 Sep 2024 11:15:50 -0700
Subject: [PATCH v2 1/3] dt-bindings: net: Add T-HEAD dwmac support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-th1520-dwmac-v2-1-f34f28ad1dc9@tenstorrent.com>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
In-Reply-To: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Drew Fustini <dfustini@tenstorrent.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.1

From: Jisheng Zhang <jszhang@kernel.org>

Add documentation to describe T-HEAD dwmac.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: change apb registers from syscon to second reg of gmac node]
[drew: rename compatible, add thead rx/tx internal delay properties]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 109 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 111 insertions(+)

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
index 000000000000..1070e891c025
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -0,0 +1,109 @@
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
+  thead,rx-internal-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RGMII receive clock delay. The value is used for the delay_ctrl
+      field in GMAC_RXCLK_DELAY_CTRL. Units are not specified.
+
+  thead,tx-internal-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RGMII transmit clock delay. The value is used for the delay_ctrl
+      field in GMAC_TXCLK_DELAY_CTRL. Units are not specified.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
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
index 3e18aefd1222..aaa24189de43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19940,6 +19940,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/net/thead,dwmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


