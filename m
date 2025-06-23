Return-Path: <netdev+bounces-200102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49EBAE331D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F2B7A6199
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634A38FA6;
	Mon, 23 Jun 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW/R6MeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F927735;
	Mon, 23 Jun 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750638663; cv=none; b=l+N3Hivplt2QEP8U31HmYb7ZQWal55oZgVcx/uiSuWLxpSZS66rXhTlLDSaLt5K9ShSrJbePVrx8AILmpgFq7zHLle/57GFxzJRamScmBXc0UukYs/Sg8kzv0/FKf6RV8hpgvXFq94pdnkmjPjwdHiDVlUjaH5Rndxipv4EBqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750638663; c=relaxed/simple;
	bh=+m1cjMVUqVL4jSAdL934TE3auUADv5zRm6QadAi/ysc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkiVhoZEUgSUTSnYn/DP3GKGSyrgMPKPEO/M61XTUBnmJpalkiAtDVal7DhUE5d9FGnYZD2JVtmWBBj1a7XsBGwuNKME6TIhdX38KoRM7Rc6HlAVhmpNP+o1eKySWOOFNaZFI6Bn/ixdT9MS1cTetVwgsLn/hPoyl9QVD5O7k7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW/R6MeO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-749248d06faso1097107b3a.2;
        Sun, 22 Jun 2025 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750638661; x=1751243461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbYiO19sh3IJdvvUSW/e03MZMQRypRJDEB888I8b3Cc=;
        b=iW/R6MeOJ/LO14YF0pblbhoGRfaq/yu5UwAOU0OcU2PK+Y4qECGUAJnpzopSEv73Yl
         ga3nh1JCAVugXCcsEquuk2uRhiatC208VF7bLpI2zcBT+EBKimjhlLKYbbrku1T5R6M/
         W+qcFL7XMchoCuNc8HyU66kG+R9l623crtGYtyZVivDZLnSqqhUPiViNLu8jutihhLsX
         Tn/WwuUAoJHlxKun5trAA7b/VjB/fVTfHA0qHKZIEX5BNGfh2YomlT/utPVXLCXogIT9
         3hjbT6UsUFpveiBOFXdfTg3apdwKuP2DqhsGSR3Xd84EhFtr0pNBN8pVKU0LJ/Vn/YGp
         mR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750638661; x=1751243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbYiO19sh3IJdvvUSW/e03MZMQRypRJDEB888I8b3Cc=;
        b=b81qNWqM0s2Hx6A0pWQGe7dQKWLBY+bm13JNzZEmqxAEh3XNUZa2IGPUcP9PhoZGdM
         EdQREbDuwiDvdjQkatEXbBw6asCVpa+QluFAmXT3C5eszLbt1CUVjSMvh2v+j5hBjMEK
         LeIOa8w0TXGEr091f4xA80X28B4ZXKQ0qc5XedZOlujCtuzZio4TTrv7PjVsFiHnzC4z
         jdeRaYTj9CvWp2Hw/uTLT8LykPnGlR/FUXFXILjLsjmYP5lZWdIiyAJa/ZwjbfiY/8Cn
         /9ZR1slV5bdBuh+yBRez6J8HgHysNJQslsMIJTHB/Nbl/AEpLlg3ATPYTkmpOTcFJx07
         et7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEszObyInfoYFNCx5Z4i2Uooz8WAXKL5ty/sRx0n/0JWShQBIaHGPftrqWImwVHRUCkO4fQyU/VeyQslPU@vger.kernel.org, AJvYcCXMFK+xB1UJ1Z7l+V6NIVeM+6JDW8Gm38EsTZKW0dABY088AwpmYbBIPL0bJH0PxLOuHT9SUfFSDimv@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVt+xFHWdOPfO8CVXmYxLOJC9pgdqUvF6dCbr8urdCIeCplS7
	scOJASm9pm3T3ZMKz1PnP9AzaeOUuSoE28ZvwZHbqmjMXE6H3h7jlu+o
X-Gm-Gg: ASbGncunf+kmL72sEY+GXLTtkS0lJilEY56a2RYx8sfQPneTg+wn56IZEv/91vgYjof
	+xw5ckjYDaq+x47U+Im9bO4BvG7qNk/mF0k8yWPLvM5twISgQTFYG2tn8qgl58AY6k8Ctu8I02u
	RCbYyg58eCPyJulG7OVUUgBNJemggtTjSFYg8kql2+lG6kp6ay3dwMIoUIlx41Xf+jXno9evSuq
	z8Zq4ZxYiTdkqTWILdtyO3Lt9u9plcPeVaQrNnSS/vSqSUWyeIlveWeAJ5CyRReFUnwbI/amocK
	wOHBkMQ9Yd40LIvaris4Td2HOnl7oeSHAaPVU/fT1+MYkc11VLd1Jam4mwnFHg==
X-Google-Smtp-Source: AGHT+IFjUa0B87qNht8ZgulbTuJng0m9HcDVwcnodg7C5wpEEen3v8W1bwLiOFMIWmrUqYCVfsCUkg==
X-Received: by 2002:a05:6a00:2e88:b0:746:31d1:f7d0 with SMTP id d2e1a72fcca58-7490d540a23mr15000357b3a.9.1750638661258;
        Sun, 22 Jun 2025 17:31:01 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a6492fasm6826040b3a.111.2025.06.22.17.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:31:00 -0700 (PDT)
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
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next RFC v2 1/4] dt-bindings: net: Add support for Sophgo CV1800 dwmac
Date: Mon, 23 Jun 2025 08:30:43 +0800
Message-ID: <20250623003049.574821-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623003049.574821-1-inochiama@gmail.com>
References: <20250623003049.574821-1-inochiama@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.50.0


