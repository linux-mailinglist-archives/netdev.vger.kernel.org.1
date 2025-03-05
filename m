Return-Path: <netdev+bounces-171928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE478A4F747
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16C616DEE5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F811EB5D4;
	Wed,  5 Mar 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQdLeY+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5B1EA7E6;
	Wed,  5 Mar 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156797; cv=none; b=qURPHCWhMS3jfFZNHd4fEy0mKb+eNNWT89/OyT5YhvypckZdpjWJx+Itd6Q+3Ws+u1a8e3L2CAxGUciVQBUHSNuY41ElRy0KeYpOHe22l+8otHaNUwPZAYiLT+IfY+KFmU6oTsiOzgINo4wNBxX0BwsQUO0BNQX1onvXGuDl1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156797; c=relaxed/simple;
	bh=rBXNuRvrHKraLlcS5FsB4L0lUJGAUOlWg4KSv4THZGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z77CEeVB9BJrts2ck2Fmz+xCNcu1egymyC1jtA1pfNaMGQ4GtuIVOdmU1Z3Ia8r944diPOo1POk1HLzUtSe1kzj888ZEkDBIfp4BnSq4wlTi1+/TJLlUOY547PLOCYcuPi/3BQdz7yXNWca7Cnc4si/N08jfnykhL9wQO3CYAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQdLeY+h; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e895f3365aso48944336d6.0;
        Tue, 04 Mar 2025 22:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156794; x=1741761594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm0v1oLCij0h6SDkpOwWiVAdzDZKq77pVrdFNubwArE=;
        b=JQdLeY+h4RiRo8C61IFaXvA1Eh3PBS7bruRrEvXxENcXaXn4zznWfIla9dXEdifVl1
         RzfVjp7/5ESXv7kdIoo/EnK9XF2J35ludRIBoLy1JCwGZc/qRb/sNL8BU/Mj/kjgx61c
         WUGGGcGSZdEp3cxDIuwJXvP397EU7PhQOvfK734FTG5Yvp/KDYCVlFTQdEGr0/XOFnEK
         0FyCoCuMRd5mbDtGqToQWu8Ga86WIT4520slP3Fa/UtvBS70TkQ9j1KLGQtaZBJZI24s
         kx8/qvLRYLdH7zwWWz6ehuivMJ23iAmNQjQCSyDtWfuaaF4tSbAq8bSawdqGpEwdPpnb
         6u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156794; x=1741761594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm0v1oLCij0h6SDkpOwWiVAdzDZKq77pVrdFNubwArE=;
        b=iLxNsC4/Zn6pjUH41V342JBr9Jy5KS+csv2jTceuS4WZ1uYiF7Farv3dL07tegj7cm
         9+Wq4pp1HO/cwSdYwRhoS7tUfZIqEHEAMjU2T/TjNkx8gT3JbFFrfWUlrshWH1D4CItL
         Yv0ukwH4DqjtlYb/EKDjfRmK1eSE++1gaFEgQR8tIm67/KhklF0IQVBHWUQdLo3UhCOS
         hzgSoB+cHT7EYiXcFOg4TYx0bcnkhgTJKUC9ydRvetIGZe//wfC1JqCWF95eQutrPcTs
         Frcg9ZcvrYzHT6U9eIZQaTkRNnpIqz+jacPOUvhF4VRMNOZxs4ZXW3Vg4T2p2v2LItl4
         iAjg==
X-Forwarded-Encrypted: i=1; AJvYcCWEmkCA7teA+y3VNzRaIGC0s+duNuF2iSeTrHGC9xl8YDcC5KOa3Cn9we5EjKgNc0vu/aJkvdXy3C18@vger.kernel.org, AJvYcCXjAaGNcjDCa+kZBvG2R1h9Sh0iCDuHTZBJ3WLjGQbL7AAbxlZEeDm1RhQ+02ZaHmY+jpu4pn91QQFqqxiE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIRJyjczhl/hs/zZnJFlRoBOVDOYcJ4/QvgVnekl55Bk8ik1M
	tTXbipgm34PF6KS1tX2gcsOeoMqs8CazUjkt78kh4VfU2TzHXiUC
X-Gm-Gg: ASbGncuTfxNhJFDp2h+tTW2bK0iiIr6FVzcxVTsx+Lo3mpQWzwH1eskV6zokwgJPG6y
	KJLQgUEWPxZY2tin+12OUZW5pCTeD/liIf8Jj4vU4AKTLM7b/nAHnYEL7rbeWbVRSb1UMYJonO4
	K8vEF9DywgbhsHk7UcUVob7TkqnQCnmIWGf+UntBXzQ9pbcwseCAXAUSMmeukSxf/K7aPwr7qaQ
	vrJImWQXiLL13xOF+hhAhkORZmk6vCGua40V7JfLEvgqW2uC4SMbQq9QghbQe/N8VxD1mhNYNqF
	RtB/+EkkeAfutKUhdmvn
X-Google-Smtp-Source: AGHT+IE2PxHyAWGJwBqsd4XqiNnUfpUNBM6sb+RyGuOLvmBafepSZRle0SjnzsdkzlpqNK/+2dp1ng==
X-Received: by 2002:a05:6214:e6a:b0:6d8:9b20:64e8 with SMTP id 6a1803df08f44-6e8e6d11d4amr25735466d6.10.1741156794196;
        Tue, 04 Mar 2025 22:39:54 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8a2170bcasm62382096d6.34.2025.03.04.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:39:53 -0800 (PST)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v6 1/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Wed,  5 Mar 2025 14:39:13 +0800
Message-ID: <20250305063920.803601-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305063920.803601-1-inochiama@gmail.com>
References: <20250305063920.803601-1-inochiama@gmail.com>
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
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 126 ++++++++++++++++++
 2 files changed, 130 insertions(+)
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
index 000000000000..4dd2dc9c678b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -0,0 +1,126 @@
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
+  dma-noncoherent: true
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


