Return-Path: <netdev+bounces-164387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3FA2DA38
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 02:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D75165453
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0F24338A;
	Sun,  9 Feb 2025 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCCclelT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA712E5B;
	Sun,  9 Feb 2025 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064669; cv=none; b=sU04Bc72LRYRqpPWWnHq3yKtpixkDya1vBvdAkzKCAoqxWyQmMajRs65MtFPbRNHcEjzbEIGQH+ut+WriMfGJ05rvYumeFM2HxlmdJGMS4k6Bbc0FImzghj/nEI9NHUYVJQVXeUNPoFDEFZl/ozgV/fW++BUyLxZFhebnfl6wOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064669; c=relaxed/simple;
	bh=mlHLGDgu0lLYDoOEZj9Dh7DdijgTluzA7NKpDjvci0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIjU+AMYJrwl9TwhHxxUtw8bdWo7mVBfwoT48QDGJHzfCje4Zrz0d8LrvetP7FXvP22BKu1bI+/6HXGG6/zuXaTjLhAN5ygd/P7AyoimP/YvI7sA/On+NMpS4+eaQCcc4mfbaxq/diFMlEURKbzGMiKWdOBcunOROWmMId7FQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCCclelT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c05b91245fso356485a.2;
        Sat, 08 Feb 2025 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739064666; x=1739669466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e7ZzwqztMziHLUhoVfnoipumOCTxC0BX+2clstSkaw=;
        b=fCCclelT4GMt+TGaENJIjZMr8V9DuPD9voF2AW03FoB5aFUpIMduCbvNX61fCCFiuC
         HQ4bEIK/brtkCF83/A44ElrapPqVuOKo0IGGjCwJHRCYbVc2VILFBuEduTH9LWmnppLh
         reja0Lbyh9PspQ2uwCGnvNGezUdX8ddlJ2Zhd9R+ZjCR569Lq2uDSeEMApQ/ZvEKvkVv
         f6kgUysQqBSpztYczfVu3FGYuQc1IdvcvGRjHXsWYJWqyobqsdulhyBaz8nL9B7YJzg+
         BgaVbfSzya3469WlfTocNMangZpBASjMCX7DRTiZXGuHgj4EjAYpz1j9cR8EyGVsqJR0
         atVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739064666; x=1739669466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4e7ZzwqztMziHLUhoVfnoipumOCTxC0BX+2clstSkaw=;
        b=TF/VCCZua1uk6LGlj0wDNPXuHHBoKNohYkIFkHg1zp3NJc5LgDgqyze/WL8YGMCIzj
         JZqTVYCTptb6prm/fhnzOQiVmXklkbunqwiekd6Nj3GHotPxSi9Vhw67CKVTF2vSy/HY
         j6qt92aSaHmCQKIQSsdwKKbBNVubP4slUquGkOjVK4ZxMtVpHDGUc1cVUXxQdzWc5fQa
         xvN3YuM6e54fujgeq6jUQkIrm/A8mSFR8LeEv2hFWaGb2uQdpH9sLTGWHA0/zVSjL1iU
         TH+CTSqmAR5xDNcgAKeY598d60V42+O38RAlGB9vDiBnFGRPHtEuRIwCtTC1tU5jpJgx
         QMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVqG8ukzumcqgRZYNy7e0dBxpmHPlapqSeSNgxFdfsalt2d5BoNaTOLbOu8Kfd1yq0XYjfHdvkitOLh@vger.kernel.org, AJvYcCX5FUCnz3QJnc2z+Jp4CQbfp6UrWscacCLAaZm/DFkOKMbzxDZOX07KM0mfP29qBZ4/RZe8H4t2jQrIVV1j@vger.kernel.org, AJvYcCX9+fhxIZ+nqqjqqw2HlJRmBjZQIASCPRKLFK8irINN/7JLGTYjbh4n4hPtqOc2S6KgFJKUkyX5@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTUI/oP8JvSSnc7GqPKlqm6DagZEPQRIuUgCZfeVhJgN1l7SA
	8iphme/tlVi1ebhq7iKhgWK3GfYT1BIq/810z8BHhrvrD3Q3Mc9q
X-Gm-Gg: ASbGncuNprX26zT4aOVY0APhw1aquSIx32wE5jtSnn0xasKrPyM+ijIM8seByCLY2pt
	hnj3m4DCXF8Fn3bAC2s+E4woJy+RcaPho/lt+mpHujcEKEz+KaoZR9KsKY/RLMWz5MyJMnTrbLk
	HBuyYbzgZgYPuei4AoyQp4W8mtsQsnG5d8rLCjAQghXmrs9nUtycq+F382BWzuKYb+06SMqs91M
	l7Rcj/FlozB71QGOESCYrXqBlizHQM2OmMsyY0OyeTJz0YZDhPFRu04JuMwdLWRLIk=
X-Google-Smtp-Source: AGHT+IEH039HXExAei+7K/JmIEv7mGaHuYCB4awQfxRtlfWTrGL3Y1l9ujrADjSQi+g127ZTesIcZQ==
X-Received: by 2002:a05:620a:bc9:b0:7b6:cedf:1b4e with SMTP id af79cd13be357-7c047c29ademr1345409585a.41.1739064665917;
        Sat, 08 Feb 2025 17:31:05 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041dfb0d2sm356691185a.34.2025.02.08.17.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:31:05 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v4 1/3] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Sun,  9 Feb 2025 09:30:50 +0800
Message-ID: <20250209013054.816580-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209013054.816580-1-inochiama@gmail.com>
References: <20250209013054.816580-1-inochiama@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 91e75eb3f329..02ab6a9aded2 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -32,6 +32,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -98,8 +99,10 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
         - thead,th1520-gmac
@@ -631,6 +634,7 @@ allOf:
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
2.48.1


