Return-Path: <netdev+bounces-153981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE99FA8D4
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 01:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4F1885190
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C710940;
	Mon, 23 Dec 2024 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu35CF37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED1F4E2;
	Mon, 23 Dec 2024 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915566; cv=none; b=eAL2goKy3qcNxwcg884oynFc0CnDRCdnEwcUeWdnXHo3bl61YARmL6a6fKBsAhOnxZ4/x72c21ABAbiiQErlG/eGrqPiVu7ZzhfxZVZJOQVsjJePxW9QDRXWUctW+v8iJxtaNjplPu4OKM+mclFcU8KDZKACxtQ9B0xxIUjV3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915566; c=relaxed/simple;
	bh=i3nUkXLpsqr/fJEuk3YUem+exM6C72muUCZwzlnuuas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dySVcajTKt5ElC5P4Irw4wL/+c5l8ClwtQkhgxJtrslpbBtMyx6dstlk7QvXgH+itv0Xu7jCCR7IxNaGRoSeN3ho+9S3ucWwFXKKlKH2OzfWauCAOfWHNTVCeX12JjGq6g68TI0H/X7loASwQJkDxkp3yL8Ufk7eaITfpZ9sn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu35CF37; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1b895541so29055206d6.0;
        Sun, 22 Dec 2024 16:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734915564; x=1735520364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRWA/tM4Nlwg4+7MH+fMHivDiS7vd/AnzDx119oQ4ZA=;
        b=Pu35CF37JHEQTmJiMGg3AyYcLEvGb/k2KvV39I1qT/TeRfY6vpExacm440+h/HjQS6
         LHnEILwWAZ5ikuZjsT0ikjXTRXztoBSJfRi8cQhvnDfTeaqbiTGCt49PTmFSLx1kwrJt
         cbvdITmTK3PKyzeg/fGek2A+N5nM9Eh5TAL4TL42/LnuGtnsNMmWZLLlZk6cjodDhoXQ
         P0G0vJnmugZjN0eLV3rVdgdIjgV8xucpFctVUMzn/zL1rUSCG2AYI/lKKygVAZjtsrLx
         M3OlJnsV4TRf8bPZdSNNqt3mahdkI6X6iqozvXvVeHs5njqLc0Vhyy0geh7AFvliYpd9
         FWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734915564; x=1735520364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRWA/tM4Nlwg4+7MH+fMHivDiS7vd/AnzDx119oQ4ZA=;
        b=AqVlVTBLvZZCBBTlkUY4dUdgkYmv/yHYpITWO4792/I4ayEyvGMy1h7tgDu/cwtWyV
         CqrxQQtBDo1GW6mFqbtq0HN5F1URIk0YBzCpmbMzQhME8PHEs40fSEwVx4ovKGYSTRs/
         3bxU/HVnRBLnyVxsPBOIqxmrNavXiuVorcMehaMfAx066Da+ewwI18fSbZ7kh5UK3S7C
         qbK/tayJJ+4CLu4msqhMNAXkerhCTzFrMHOrCml4QbqLAaUyvnzoSwLv7a8NUb/v1BNz
         0ccSPDaKSKVQabXYZXss2ZT4EmIWNLKmixTbhQ4nOgNX7HCyd1BHV/HVEn/nq5UIgXPf
         U1dA==
X-Forwarded-Encrypted: i=1; AJvYcCVezuHUDxTfOmtwLRnEpNGjw53LSdwV2c9Ez8B3BuLSg2NQgE9FWlq1z9bRGYgMVHqpye68vKNj0oR6@vger.kernel.org, AJvYcCVx8fBdsWTTA2BV5HBdabdIlnM5nx/lZfjjcHRL/t0lbihIFQlSaONYJDDcQwusdxxPX4b+RiiCuX8haB7n@vger.kernel.org, AJvYcCWew+gO8p8icfPL14aczyn2GvGGec2buo1MaK8gZ/swTUB2xCaiR7/QVdCA2Y5MoA57OvUPeH1j@vger.kernel.org
X-Gm-Message-State: AOJu0YxEu5YFUbmJdWZJ/bTKFxc4sGcOc2xwU5QTvKcVs2tcZ34aZHDH
	s2Gi93WJMbjpkLtqAhZe++hJ1aK9nD9Ng+Ta8TQBbyLp+1IVD6hjwu+Luw==
X-Gm-Gg: ASbGncviL7+EVrPZrPZrkyGkYij4PO2oZXlbDR76RKi+2L7nFcqcKqs0zyKs0QDAkQg
	IKvewWRxoSaBQe6fVpecX+SiazXCKg23lkpXCak90U8kkMD4sQG2MkERRhOjVFR8yQRMx1RNFz2
	YBK4/QwsdGCBMm7INQd5KJVhq9QXhkvdYq2cnhXW/aPrqBHC6BCZZ/24RYHNXKBYVKM+bCjXlzs
	ltobM945ZG0yFGv88/U5zDzmmrk9iMe
X-Google-Smtp-Source: AGHT+IHN9d1bnlxRzzqRiDcadAYUGSNIOJpqNW2TaHPm8W5wc6dU1Ev4iY1D0s3G2OYKNDwOXlA05w==
X-Received: by 2002:a05:6214:d89:b0:6d4:1ea3:981d with SMTP id 6a1803df08f44-6dd233a2bccmr164013606d6.43.1734915563662;
        Sun, 22 Dec 2024 16:59:23 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea9d0sm39145406d6.7.2024.12.22.16.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 16:59:22 -0800 (PST)
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v3 1/3] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Mon, 23 Dec 2024 08:58:37 +0800
Message-ID: <20241223005843.483805-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223005843.483805-1-inochiama@gmail.com>
References: <20241223005843.483805-1-inochiama@gmail.com>
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
index eb1f3ae41ab9..cd112ef6b3bf 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -32,6 +32,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -97,8 +98,10 @@ properties:
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
@@ -630,6 +633,7 @@ allOf:
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
2.47.1


