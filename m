Return-Path: <netdev+bounces-138911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561EF9AF679
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01381F2241E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4E481B6;
	Fri, 25 Oct 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg5U/cX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F23B290;
	Fri, 25 Oct 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818632; cv=none; b=liT2NA5zeshDsTaGaI2//Nc2CRh7Poh01Bagdh5rdI5pdkAuFxv3D7o70elewLn7ye1rYNaCwVCeQylF1SpARCW5xX7FyTwgzNIMSnEHZcLr0Ct3PKg1YAX6jp4uLO3mxMjbE9lgq8YAc1piNXsD1jT123Q7BFKh13M/DiVK28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818632; c=relaxed/simple;
	bh=OnFEaOU1kULi6oPNGWWGHqOMwYv7yDsJ85wEJrz9eHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsgshcpAT/qajAneuyu6So3FsNdbIvRFIs7l+xXDT3Gfq2pWi4jvX8qjgPIOFJuFc2zrD0Uj1HZbvzLc+WAg6bTJbvwuw2joOaSLTtnMhw8009d44SZMF97CifV/KBWdtnKfiTiDQXzIVnMvAAUM/MQWWzvjjLvOUiLKjVPIEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg5U/cX0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20caccadbeeso14740735ad.2;
        Thu, 24 Oct 2024 18:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818629; x=1730423429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjsxbPPZPhrPsk8Kv9v/JHWFfPAbNR5NFf7Fw2jHbOc=;
        b=Mg5U/cX0v/6LlUCkM12fLN3wqdkpnaxYvL+RDieu+HRdqCeIW/mf3zSsB3hF7zNYvB
         W/3Kjnxq3Vp/OnvPhaX6HnQzJcpuu8dgzXEFbqqnBZlbaYdPEKv8/c9u9SROqi54TWDG
         QdIx8XGKoVpke7sA6xsY5iNfbacRSNHWiKe3iKdo4apspQ80tR9uXua+MrPSyIg2VnXb
         +y2bYslLrrQb/8gilJEpVquW0v6/ixaBhVCKcl5ma1VDlUA5f2u/qqqfNy1ACelXTwhd
         97kTCU3HuMtNh2akXRugW6Kxny1vVzC4fP+I3/NJjrHqB+BtBUfZsjgffdMWDCZ4Ny9y
         uKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818629; x=1730423429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjsxbPPZPhrPsk8Kv9v/JHWFfPAbNR5NFf7Fw2jHbOc=;
        b=FtfO+bcTF5FndjmAxwNvtvHA8CZjTIO22azAeMENcqJ2P19ZWe8x8TBtA1oS8ZR+uo
         pZZSczxGlzmBEZqBFAcgi5e2TE2HqRIpp9IaDGGXHQI9oc8yD5tMEDTMSZtny269lshq
         QMtASf82IJLjWfCsxoZKiLRQortZ/8ku2qkGXh1d9wIKHt0ib/MLdj6tV5SyCBM8jQT4
         NH1oUdEw9XnziQpveGckr8Kz6XETXWfUzqVy2ccqZxaEIm02LPE0pZNmr1g1N1w2vE9/
         stbKbCsEo0RHVqWoolgAIdrYR011FYDp0+trMuDNzgZzHn+GxunHzZoSXopwe2HwyR/r
         8JrA==
X-Forwarded-Encrypted: i=1; AJvYcCUTQcLr8gnvJcTmW8vQOwRx9+poR1TX7oLtPgImXmsQbGkRGW3Qn2paGwZ9C96U5AF+dY3bbElp@vger.kernel.org, AJvYcCWvdSxFbuZaQMxbqzBeQUR01F59vFwVdtxPjB5CNrD/7z9W1qPt0FwyyEBUAHDzhvVhejJMkWA2RnrIjeC1@vger.kernel.org, AJvYcCXRi9G9GI/iDXH1XLiGyDAVfLL5jWq/hYnDH93e76TPn25woX3+Uvs+IIMpPqCM68rzD8uzxsX7Hnii@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6G2G6uXqZl3Iq+8yMGWgqq0P+AbxTwb2GVlApogka8jiF31ou
	qpWareeYyF6yLYG9xlPmegy+sJgSB1MvFISF2m0pSagv9KeUr89R
X-Google-Smtp-Source: AGHT+IEHoc6nWkrNG5/p9qR6jUUXfLELQg+uXNgVWwe925mwCigDiK3oPKX/W5C+XTBSotaJSY3yxw==
X-Received: by 2002:a17:902:cec6:b0:20c:b483:cce2 with SMTP id d9443c01a7336-20fab2e0fe7mr75143555ad.60.1729818629525;
        Thu, 24 Oct 2024 18:10:29 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02f6f1sm577455ad.226.2024.10.24.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:10:29 -0700 (PDT)
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
Subject: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Fri, 25 Oct 2024 09:09:58 +0800
Message-ID: <20241025011000.244350-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025011000.244350-1-inochiama@gmail.com>
References: <20241025011000.244350-1-inochiama@gmail.com>
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
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 2 files changed, 125 insertions(+)
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


