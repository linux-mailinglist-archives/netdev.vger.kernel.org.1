Return-Path: <netdev+bounces-196447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725DAD4DF0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6F7A5BC3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78F2367BC;
	Wed, 11 Jun 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWvznaPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC12367B2;
	Wed, 11 Jun 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629306; cv=none; b=P8ZyVQaop2g05EfzrNgFcIlata+dOH98v/vRyuvsDsQkNLZRduhTQkrGwDY+rpUVGd9Q9fpJ/oiKv/GTpKHIaifPGhspA3xeGNtciGibg5xxMmm/wgIqj8D3pbrsgOBEbbQCK5MGz8mmbXAXQN99Vn1iJFXfpXIgHHB3XtbbcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629306; c=relaxed/simple;
	bh=DrqMQ49i01HIdFYjm/LKGgiRhhEO+OPa6PK6orMmpjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8AvHPq5VJRd1xPQasyfqlH+qjbSbAxiEhrFDgN0zuX9449414qnTDUm5KOJSPpmxeqeanPOaDd9t5sWdFhRNWNV1KFBfqZfquvFl2DpG9MqS7AWexzAxVNQTirZm+CRPWn5+Wa4jkMVzKdnJcOL5XU0+hTYm58ArmypPqV3UuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWvznaPa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58ba6c945so105584641cf.2;
        Wed, 11 Jun 2025 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629304; x=1750234104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKco8WF5XLIx4+g+zOsrDdvMj/5C2WSueef/n5luzHI=;
        b=iWvznaPaLtOtWF03RAh4TWjADEintkQPwG2Bu04hk+27fY4maZxmmDPBCBFmiDmzVC
         v+xUhzxAfFSCUJtmyGIyeFh6VKo914D2Y/gA64rSPALdcM/U5ZkhqUnrWnqI8qSCS9XZ
         w1w3X+xan1dICH1ktgxuQoQ98AEYFjRL9yg6pecRqiGN7mvKkd51GAzib/D2v6nVvOkE
         LQboqy0bi0X0lwjJ88Y+fnVXvGBKLYvYmwghEYeOmnwH+jDp4vu8oX4uYJo/ALidKvsD
         4AHidNJtr+Lc0x6T9pCM8WWOkxdaWHRyUJWbMtGa33atZzMlv7f/DR3ndON7T6zNYkzj
         LZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629304; x=1750234104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKco8WF5XLIx4+g+zOsrDdvMj/5C2WSueef/n5luzHI=;
        b=XRVIuJvPMMGxnpcoK/a4hNoFF0fFBzbfgCf22htTAyGQlfDcnKArBencTDP023xwdi
         /Rce3LZblBU/aNMLn1l6GaSd7TWGPEzuztW2+QEoFSlS0OoEyHg1eoGcteBusDh91V5b
         X2stGKK3W9GaxUMXhU8MVA6xEJ/lf46/IRfFHZuPEVUBb0lcnXm0j2Ppvg3IBQUP76fP
         LYuVGG2epXSFseOcKsTRtt/wjJUK10Jv0+UE6bfOSD+66WV2waTPfkv1ssrMaKHhMofw
         H6QaHQaCtTLRxatn9bnGPOeI8BXuy4CYUzYQyRm7mxbWMQAoIPahFChKu9ct8h0KN0Ah
         E0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVW2jwdgl2iPFCkvrvvlHcqY3f+iyjfU5EpdJeZhZ3OLIoIyNflsd2jriFqi749q08DHk/UUy1Twvry@vger.kernel.org, AJvYcCVl7e/6AQjYxD7EN5AMwivbaRAGc7+DumwOWZBiUKC4KiR1dzBLPtm+m8yvN92wHy9EOmXZ5eSkbf0LqHS3@vger.kernel.org
X-Gm-Message-State: AOJu0YwJofJkst52Po40b0vgUo4cy8E9TX1+adNay00y5vDdoVIZE0h8
	pc77GgOS1TAWbx0bG7m9EihY+a0d3iR/0iG2b/GrWUpaxATlCcrTK2eS
X-Gm-Gg: ASbGnctsX7TLe11GFp44HXxZDbk6NiBLVC9a0DzA7C1PEUIMQVjILvPlIuQ9xpdHNbs
	j+QBehXeD8yCeh487Vc35PkwLlQG2XM/XlUj0mWtkgjcvmQEK/hJK12CeKUFa05W99WkFtIIUxw
	P6GB6O005odwd8ejshG4kPuBULNJEdvlVyBKKImZO2XKayBTdWsf5k8XKSoj0cKrbf1adMcOZ7/
	j993dOltgSPztL87C0m6WxtgrIet/n6UL9AigixYTZL/Hol1RgAFFC3astwWBilmhVc/C7b/JLQ
	3FvZfCOzWl7vullNc0ArgywffwPyXSzmpXcS4Q==
X-Google-Smtp-Source: AGHT+IE0wepui9ZWUWrK1RdnFP2P1vv+cUAkbMh57NubxjGl2orNJ+i+g4FXFBHss/bMOX/R1l7e7Q==
X-Received: by 2002:a05:622a:5907:b0:476:87f6:3ce4 with SMTP id d75a77b69052e-4a714c9d74amr33190841cf.39.1749629303992;
        Wed, 11 Jun 2025 01:08:23 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a611150462sm84318391cf.14.2025.06.11.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:08:23 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC 1/3] dt-bindings: net: Add support for Sophgo CV1800 dwmac
Date: Wed, 11 Jun 2025 16:07:06 +0800
Message-ID: <20250611080709.1182183-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on CV1800 series SoC is a standard Synopsys
DesignWare MAC (version 3.70a).

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
new file mode 100644
index 000000000000..2821cca26487
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,cv1800b-dwmac.yaml#
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
+          - sophgo,cv1800b-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800b-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
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
+    ethernet@4070000 {
+      compatible = "sophgo,cv1800b-dwmac", "snps,dwmac-3.70a";
+      reg = <0x04070000 0x10000>;
+      clocks = <&clk 35>, <&clk 36>;
+      clock-names = "stmmaceth", "ptp_ref";
+      interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq";
+      resets = <&rst 12>;
+      reset-names = "stmmaceth";
+      rx-fifo-depth = <8192>;
+      tx-fifo-depth = <8192>;
+      snps,multicast-filter-bins = <0>;
+      snps,perfect-filter-entries = <1>;
+      snps,aal;
+      snps,txpbl = <8>;
+      snps,rxpbl = <8>;
+      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+      snps,axi-config = <&gmac0_stmmac_axi_setup>;
+      status = "disabled";
+
+      mdio {
+        compatible = "snps,dwmac-mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+
+      gmac0_mtl_rx_setup: rx-queues-config {
+        snps,rx-queues-to-use = <1>;
+        queue0 {};
+      };
+
+      gmac0_mtl_tx_setup: tx-queues-config {
+        snps,tx-queues-to-use = <1>;
+        queue0 {};
+      };
+
+      gmac0_stmmac_axi_setup: stmmac-axi-config {
+        snps,blen = <16 8 4 0 0 0 0>;
+        snps,rd_osr_lmt = <2>;
+        snps,wr_osr_lmt = <1>;
+      };
+    };
-- 
2.49.0


