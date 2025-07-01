Return-Path: <netdev+bounces-202714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF1AEEBFD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A69117705F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB119AD89;
	Tue,  1 Jul 2025 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTW75aTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F781991CB;
	Tue,  1 Jul 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332676; cv=none; b=dizkfqjM7+b0I0ZYGLD3P1hiuGwguCLSEtztwIvaB6jj1D5Yyjkkk0urxDpgHhZv12u/16BMs2cHRJ51kUa5J+TYhp9rC4DGU4aDkdND3TL8r6FWnY44iFHjYbm1Zgxy40v7GDEL22VofQjxymlerDz7U402pqRiZVgr08QtB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332676; c=relaxed/simple;
	bh=Zf9YtBRoyG1fXgqH+qYiZixnKJmXnCz2BxV3aQe2Ago=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHbs2D30Z+KgbeWEl8tEvEwRsHSPdx3tO5poINgTNBXW3nwaOcEQJtxJJC+7TaDpWQzM65EvNT0uHPRV6JmVLza8I3p/nCWLnO67e0Km8xiPQDOBCiIKJBDV8+ejXsPzW0yxCYy8w8/GUM1NbuCuRkKyFsAzGNNRUEBJdns0VZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTW75aTI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a8f69862so2674061a12.2;
        Mon, 30 Jun 2025 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332673; x=1751937473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6V/oR/DnwI2Qi+5VQkNfiNRfkRvGXnx3kp/m9SpAb0=;
        b=FTW75aTIh7dNxGASYg1mdqH3nm0LRRRoVZmDz71Dc7b9nK2kUXxheDcjrXG83Ac3g8
         wgTmdA5u+APOkSPHbycVL2A46xlrn2vK1a8FJagYKJqzU4CiRIibBXC0hrgjh6aeao3a
         jZ3ANBOL20uXNn3sbro6dFFOCgvabaIZLmmLSgwoAYn9XOliGeN4kHHGBkg+QNVtCJHJ
         1BNVdAYHu7njMUSI5v32k+zBz1HZDc+y2ysA8LfnIVtnmk7QmQW33Xsh++fVeXlXoQFs
         OzR61kkQ9RMVHPk4DeuitEvEO4aMgbkjjC8GpPcnjGF3KFNQC7d96Qv2jWqelz+eD4H/
         BYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332673; x=1751937473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6V/oR/DnwI2Qi+5VQkNfiNRfkRvGXnx3kp/m9SpAb0=;
        b=wuBbtGAPpqfEFKf5zNJ959d+m23BVIys+GDVpq0/gItdVTPSobnM4+mGK070G/Suiq
         JcotYa16L+h1kCF3Sw2JkL4LADhoKzN7PSOPP6N9AAdOHCGOHu+P1+w4ogiiLuBPC2LE
         ms81ZkX7bT8ma4XTXTKzpACkZajQBYdsTjw8iB0OGFPDaCNVE2hlod+uI2zfHbPo0Vix
         YP74rbbbxBLsfM6k7pZD+kYSSRhTp/cYNz+ycezmlrr5xZR3bXK/tvP6dch4ZfKcfdCR
         dk7G8/0s60QiLmsgpbp/rMBI7CHbBgO6Bdpp0PbH2OmGP57Edp+xW30kxTY8RfsqNjUr
         DEPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4mDymiVuPJ8AsBZE3jZrJE4DPYW6ytTZBkiZiRdthduGZ2bx13UesjHhzSaiPCt3kpFmvCQ02yCCT@vger.kernel.org, AJvYcCW22U7em14/LD/s8yTh/kJ1RZD+OV2qG9TALX6DSUc083nuK4qY6PzNZ97Iv9W9OqYqoyCn3Rx/upVcL4Vr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hjSa3YVixvfA/hd7KtgHu/bzdnDIVHxTxg9W1X0WWPPCxOlI
	k+5EMaFsR13xwhlqOHtlj7hHCdf8aZ4JVDwJiTVUhI7SDBNZdGyW00Um
X-Gm-Gg: ASbGncvKJZVPIq+CdOu7dqpXVX1l0IJH49tgu7qtnneUEXNMbC9Qlf963AQjpUfLWcg
	en9ta1NZ/NA6Zb6LPvDS55omvDX9UFPfNbrOH6oIde7IcIe2CZZJqWQ+3J1uo3E1s/XEnJSyXqC
	56usLDQ/H/CaguEwQFmf2ibjtoVjuYb9+gZPeAmF+s/9wH7+O2+A7fDCuMh3KCW2TGkl84YqRiu
	GOgxZCrGjB73H7NlLblMKVq6fknQ5//ogLEG9n93vhDiHCW/tnhecbnLfwibliY1v/kV4ZjqDgw
	FB9b/NNcxKHj1l0NL9uJsPtVMoXrnsjoMjAr6DKOhZUuIBbI+KmS9/W57/ycsw==
X-Google-Smtp-Source: AGHT+IEFk/FnRYvs6Y6xEEcbP+1Lq6A9vyPI9waISIZsADUyiuWGqUmeYCfcJmprh6OASfWb+Olujw==
X-Received: by 2002:a17:90a:e703:b0:312:b4a:6342 with SMTP id 98e67ed59e1d1-318c93101afmr23958419a91.33.1751332672895;
        Mon, 30 Jun 2025 18:17:52 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e1af8sm91067735ad.41.2025.06.30.18.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:17:52 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next RFC v4 1/4] dt-bindings: net: Add support for Sophgo CV1800 dwmac
Date: Tue,  1 Jul 2025 09:17:26 +0800
Message-ID: <20250701011730.136002-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701011730.136002-1-inochiama@gmail.com>
References: <20250701011730.136002-1-inochiama@gmail.com>
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
index 000000000000..8abd2cf06e2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,cv1800b-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800B DWMAC glue layer
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


