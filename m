Return-Path: <netdev+bounces-140882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321C9B88BF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5253428234F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFE12EBE9;
	Fri,  1 Nov 2024 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUmssTYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C951C687;
	Fri,  1 Nov 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425447; cv=none; b=EB5XQwOp3OCfh+U3sSC7GuixmJRV5GkBhsQxfnlhMmp1XvvLgDxoHnGRx7X4+mB2+kCl95n4JqmidnYueOTEO70C50KB3ahcAvcELjgFyDV4PWsdu4sd25LfubN0kaJeU8Ppd0ki6eHGLvEPcTyuiGYTavS6mNzxPWJ4KeLFc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425447; c=relaxed/simple;
	bh=20bJSjv4jt+C0TC2PG5qcin1ziynK583FwI1gLhIQtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUhVO+fn3hgKjy0oczftLdXnKUv0TtvLlSFdl/YaMS6M+OfWY+ntOQuuyA/v7/YkZyvmZiYfB+MMBns7IC56YnUx5l1dUmliflouEoitBZZT2wLbTvjWpXWVmwF33Bjl4R8OVJeQEeIyrnA6qJgopJncefnPLuIbLdisrysCTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUmssTYE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf6eea3c0so13322625ad.0;
        Thu, 31 Oct 2024 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730425440; x=1731030240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D83zUD3CTgh/1eqyO1pfkLK+N2dWxttwy3sSJgFuC1w=;
        b=BUmssTYEf32YezHOelby6Ssjw1rIvdGKsEgZ12/ELaYlkbWti5dGcVUcoRjCAJgJUp
         5KqMnCLi3yUlLxc5SnVwNnzyxf0yNRyV0SBdUt/O8oJwURZtYe7z/r1hSr3QIEL5Ozf2
         nNx2MdwjrT6nO7OhfMFxyqgWhsW2HSFses7TUcp+u3ckE/NyIIMQIlMAZPx2AeTDMBur
         pszyHvIg8Zqln55DYam5cV9AE4pYvy4J/vkDeIVIBUcUytSTmtSyfrPFyFEkk4+CBOZB
         THPprR9zr1+oWbPOyhoyCfqecH9l+Mj1bLPG8/DC9FHXXvyGSPIQwBd0D4fgiftUpaRg
         7Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730425440; x=1731030240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D83zUD3CTgh/1eqyO1pfkLK+N2dWxttwy3sSJgFuC1w=;
        b=jXEXrS88xjlEz/qqimXGwB+aqw1wFq7lm7mwdAt9UCspR2Dmsl6PRBJ5LE+Jcd9Ax/
         c3K79zIzfukJeOO2DFaSz9KC6DpVtNVRm7M2jh/ZFFplPc7/KZIroHVAKM57exysEBye
         qEFvYioytn+ca/CbiQcy+0GrEbiSfZiBY+NIKJa2wwlesWS5PXX3s8VrKi8BqrCJzNjZ
         cTxRQ+3ODqmVkl6vmhjL8jstwWCgB3OZ7dDlytHNdDgj9A6NQiPCjVUvYLimjeGQQAsK
         nPtOjyuCXouUpgZi8mB68oO02MszPw1n0VWVPB2hG0MR98yAdWaqbylLFYynJZCwdxJf
         j4XA==
X-Forwarded-Encrypted: i=1; AJvYcCUIG7HPxTjMz+9pK4qw+MQ9UBH/0Bz8VOT08+sbVbl7DbVsufJSRIIWyUQ2rxzbt1fJbkACPf7m3LM9@vger.kernel.org, AJvYcCV3j1qbfJzB4d6tbHAtQEPCGabTuCTNi373ybTv0gwZotq2PrwtunC71NWLqTYCeaih5AY1ARocyG6sPbJe@vger.kernel.org, AJvYcCXkzIuHP3NX2mn+DPCMWvXzIJPFTLhEsEZ67FweqhIw1Ww169CSZBFkgrzKGuPWHLp0GlleXCG7@vger.kernel.org
X-Gm-Message-State: AOJu0YyFp230jkcNd05wLh5xBQZzKHPKwV/QowWpMHsEwurLHQQPwJpV
	jWvaPghY/bMcRmeVozN5WPiVZzvHajJewmOEygPmHgmf3F7HdrvJ
X-Google-Smtp-Source: AGHT+IH8ClJCvm8SMQlEP26mhBKhiwtPhGm4vHIJFTxKdWRzsSUKpwtONxc6wRtHFIxmornn8f85jg==
X-Received: by 2002:a17:902:e808:b0:20c:8f98:5dbe with SMTP id d9443c01a7336-210c6ae3d6bmr267036415ad.33.1730425440342;
        Thu, 31 Oct 2024 18:44:00 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3ccsm14453055ad.46.2024.10.31.18.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:44:00 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC net-next 1/3] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Fri,  1 Nov 2024 09:43:25 +0800
Message-ID: <20241101014327.513732-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101014327.513732-1-inochiama@gmail.com>
References: <20241101014327.513732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on SG2044 is almost a standard Synopsys DesignWare
MAC (version 5.30a) with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..69f6bb36970b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -31,6 +31,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -95,8 +96,10 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
 
@@ -627,6 +630,7 @@ allOf:
                 - snps,dwmac-4.20a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
+                - snps,dwmac-5.30a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
new file mode 100644
index 000000000000..b7e4216ea45a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2044 DWMAC glue layer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - sophgo,sg2044-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,sg2044-dwmac
+      - const: snps,dwmac-5.30a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+      - description: TX clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: tx
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: stmmaceth
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@30006000 {
+      compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
+      reg = <0x30006000 0x4000>;
+      clocks = <&clk 151>, <&clk 152>, <&clk 154>;
+      clock-names = "stmmaceth", "ptp_ref", "tx";
+      interrupt-parent = <&intc>;
+      interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq";
+      resets = <&rst 30>;
+      reset-names = "stmmaceth";
+      snps,multicast-filter-bins = <0>;
+      snps,perfect-filter-entries = <1>;
+      snps,aal;
+      snps,tso;
+      snps,txpbl = <32>;
+      snps,rxpbl = <32>;
+      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+      snps,axi-config = <&gmac0_stmmac_axi_setup>;
+      status = "disabled";
+
+      gmac0_mtl_rx_setup: rx-queues-config {
+        snps,rx-queues-to-use = <8>;
+        snps,rx-sched-wsp;
+        queue0 {};
+        queue1 {};
+        queue2 {};
+        queue3 {};
+        queue4 {};
+        queue5 {};
+        queue6 {};
+        queue7 {};
+      };
+
+      gmac0_mtl_tx_setup: tx-queues-config {
+        snps,tx-queues-to-use = <8>;
+        queue0 {};
+        queue1 {};
+        queue2 {};
+        queue3 {};
+        queue4 {};
+        queue5 {};
+        queue6 {};
+        queue7 {};
+      };
+
+      gmac0_stmmac_axi_setup: stmmac-axi-config {
+        snps,blen = <16 8 4 0 0 0 0>;
+        snps,wr_osr_lmt = <1>;
+        snps,rd_osr_lmt = <2>;
+      };
+    };
-- 
2.47.0


