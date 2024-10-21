Return-Path: <netdev+bounces-137429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0839A63F9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03AE1C22084
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124B1F4FBE;
	Mon, 21 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7QVhJQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9C1F4730;
	Mon, 21 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507014; cv=none; b=a1+0qmSg/iXmHK+LRfd6uOjTdXHmtKjmxvVwQdurcrfiB7iLFbgyY3+9BlRDZSffg+NxoMXUmhT6o0h4vOflVBmEHUmu9ULO0bRuQ73o4QYDkUproGc4F5sGV8Gmp9W40UU+ZWYibgLaUHx3thRu+2t7c3Yzyhi5yh2rBraviEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507014; c=relaxed/simple;
	bh=kZXJ3DQ0Jh/J5QPQJqoZESvxBuSqHtS8WWbLXbahlWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEDoWg0VusoDLJhKcNK2Rl67clN0EqBvS+JiluUW0tWSoOwUH8bqJinMzP9+SL621+AKZENX9JyzhYAxX0P0JcnFaPfHQjk+lh49kxZHEybB4DESq/u9ZEiTPvYWv82HjG+Kk4oO10e/KvKoXmmywU0OJ/rdpdnWROB13uy9ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7QVhJQO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cd76c513cso35659475ad.3;
        Mon, 21 Oct 2024 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507011; x=1730111811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROalFAeuv2FT5XJcCDsa2eyjiagS1IAfhK+ybSBBNOk=;
        b=Z7QVhJQO67s5JH3PFwhlGh8Ru0tNN69IBbMq5skZIegNbdJBB8icLg4INW4ay0lXN9
         l3zjvzDcda7hJ2O856twBlHTj1VqSlU5crgiOrMI+fGBrDONVaQ9SIK+E68IoFRjEl7w
         95TQaDDnaVvQxhHU8SIpgrYunP6hLK0e7JG4waREH7hi0240nTBiVtE8w+bBS0ioKlBU
         AGoXWTTthn45C13OU3QdoqwHFY5ap+oY6jRVUIUbcpZFZN59/RBCOtjsCBN8xdhBa1G9
         DFaTHG7ScJovSQJsmoVHL6dTAVHzGEjGsUknWevLW5T8gfxnbgBwy8P6zS8aZbTBL4U2
         DjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507011; x=1730111811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROalFAeuv2FT5XJcCDsa2eyjiagS1IAfhK+ybSBBNOk=;
        b=C7DvYkd4lFU/3L2hLcagHx1x/Jf1Eq8SON8oeidelFrB7a/ie1yYPUlRyqXmLVB3aq
         kMMWGnBuxwjM9zcDXz3+P5666LBrgmIPcS3p9cY/d6cFmracBNKRsTSTdu+jmWu51ijM
         izpMc/d7K+2SNRhX8VFb9oAopNmCgff1k/ng+UaltspdPgTXTUHBEm2z5iOi8c4MM1xX
         MAXet+9baHhJUIjSqmnilPzJM8r4688KBhuHGzqRciDFJYYQDFQYyXKlFaKTrYn+nrZq
         zG8HqH1FIEMp462h4TURQZgBYxD3BPrJAVAXhzP2mFTpQ8rIlDoW1AyWtq2npotRCqpF
         gKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUXm2dKjTxndSK0QfYhgFpximmC88Xai+R6BRNcLYn4MjN7Vy0lUC0iI+b0Ywwr6f93rwd2+jaQYEIDCVoP@vger.kernel.org, AJvYcCVktecPd582Lr9eaBRqlIuvcSqKdF6bAuCywImB3Zpaxvi0gjImIdBCkWlq9/grscIQlkvdu+84@vger.kernel.org, AJvYcCX3fS8PflhA6Il0Sqby1/XQhlQoQe/MZAFDPEfZNJOKqH/G/YAqdeZpo7fFTElJqX7evlSRRpQwUWhw@vger.kernel.org
X-Gm-Message-State: AOJu0YwNs97oBLncfQltnurRHTNIFYsCTplsS66+sK/oyqwetyq6NLFT
	wjS0lT71Kf5KjfHT1vl81arHKRN0F3/vUwjDfnb0x7eyPLhCbsbE
X-Google-Smtp-Source: AGHT+IGtGQdZs96OgFnH+jxQO02blnd9Mr30IOhQfnSRFPAMbUhlzzNhum28G7bu+yZXf1ru9cnQAw==
X-Received: by 2002:a17:902:e846:b0:20c:a8cf:fa25 with SMTP id d9443c01a7336-20e5a9339efmr140267755ad.46.1729507011181;
        Mon, 21 Oct 2024 03:36:51 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0e5asm22850335ad.167.2024.10.21.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:36:50 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Mon, 21 Oct 2024 18:36:15 +0800
Message-ID: <20241021103617.653386-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021103617.653386-1-inochiama@gmail.com>
References: <20241021103617.653386-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 3c4007cb65f8..69f6bb36970b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -99,6 +99,7 @@ properties:
         - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
 
diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
new file mode 100644
index 000000000000..93c41550b0b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 DWMAC glue layer
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
+  sophgo,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to syscon that configures phy
+          - description: offset of phy mode register
+          - description: length of the phy mode register
+    description:
+      A phandle to syscon with two arguments that configure phy mode.
+      The argument one is the offset of phy mode register, the
+      argument two is the length of phy mode register.
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2044-dwmac
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+
+        interrupt-names:
+          minItems: 1
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          const: stmmaceth
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


