Return-Path: <netdev+bounces-201435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F1AE975E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F1D3AB12D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3D25C838;
	Thu, 26 Jun 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6QA/HZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F225C6FA;
	Thu, 26 Jun 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924875; cv=none; b=ZWb6jsWVGn1XBQK2LX03JZlMOjycqGasrE08K7Ay4G1FxKjVvrqUDPxRV1jJKq1yEJmNuka5aKKkOdkDUrZdtlBZR5YtpO+4iiThwa9uiUIub+NsZuwNTGCj6RdjoHcPNsSa1ZmyKXommwpjrZlU+s5urRmR+u1XyZp3czaDXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924875; c=relaxed/simple;
	bh=Zf9YtBRoyG1fXgqH+qYiZixnKJmXnCz2BxV3aQe2Ago=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbXpDBGPksUwxnBuWIvOdhuA0lS6+HSsIoDKECpvWwc6UrtyLNu4D+2+Un/P6vLE8vu8NHQRiHrVmQUBTNIfJ/pPGjY97YaBuO0S9HGmP0nvXSVjUB8bSLArOUVj9FD+dxn3Vx1QVHi7dfXnlm+dIwIUYPrtczf9O1hsrWnSjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6QA/HZg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748d982e92cso590794b3a.1;
        Thu, 26 Jun 2025 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924873; x=1751529673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6V/oR/DnwI2Qi+5VQkNfiNRfkRvGXnx3kp/m9SpAb0=;
        b=D6QA/HZgZ81oHY6+JIEhjVX3agXk3rI3dP2OzvrgGdMFpl+H/HzhLs1pffTavanFKe
         DTpYhs4mQyu2VAKJaIjq6P4Ap2l/4AwbgtWGD2nTe0cg1k33DVeFv1LEeOMzfGUUxj8N
         SUwfdHerygmldit/NoqLQVcH8vOc/X9BFPBw6T2ulJkiiwC4T3I/LY1W3QBTSs8lHj4q
         DxXyFyFfOPDeY3S+H2GV41GOyZmJsrxkBwZ44PBylWEsSdFnnTiWg/l5kZ5ZH+PRRWF+
         gaIM0yXlwL5fS9bsy1vOlO8lVebLIpgiT3QHG5mw2OYrx+fze8xDVIcaWH24I7vhPCfJ
         Ru9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924873; x=1751529673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6V/oR/DnwI2Qi+5VQkNfiNRfkRvGXnx3kp/m9SpAb0=;
        b=gnLaubA+MoKsTFxI9rAin4Av9M/3Qn078izFMNgwIim6XckyQkHZ/9BVfkviNRbHcc
         Ce2IbfoFBR8BLFfmh8mldduvaOclypPBWerKKlk7W960+yzMcP1ewsIiLI/yULrVOT+D
         wVJBlvSC4RPgPkdEWho4nDutTZs9qS7zQYhARSFCChdM2jZ71op8pfLiRTJdRz4K5k1T
         dlGBHhreUrVu3cDA7Z97aOAFoF9UrMrZTQi1GrhtuNUToaCnqTgUX7PjM36AKwXUH4ui
         omUD+poFBiYdcAs4x8Cunxn8QA2YpaiGzeYxSB+foSGEejeaB62vGybBOKkrEFdOuUoj
         eDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVUbuNaWpYKT3//Dz9tPtm7TiQ2YnQR1kOJRcb9TSRqfVdBVHJ5R8ushqhzksqNuWImneSr7+Ptu9HrnlD1@vger.kernel.org, AJvYcCWbyWNvqJM05C6ZVW7QqCcPdviDekT0MQV0Rb6AfkIDPKtHX9XIEJJe8LqlDhnDQVItsh8hy5HuJ+1L@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2naS/GLNVZAxf8Bg1feVdVpH9+BgDSPlxfwqseb4Prko/kFe
	8cZtz1ndF9xwBRRK5YCze5v+H8WLKLuE4EuVWGUYg/84tg9g18bkhW8I
X-Gm-Gg: ASbGnct5ayQR72/QP1tzPZRIqlElAs0liSr3Tr6UMOtd1xqF2RtC8AxuCHV/BOTOqw/
	DVPTJ1xCeS9V0d5O89AymK19EwrF1w4hQmTVX2jcd9mBAcBcBE0gUFCzZFlOL5U6Sa/uvX8j8bJ
	lzOo40i2MkqeQmcdpXS8nf7lTsoJdSTE86o7XVCAaZRjgPxfvcBvSvkUJX2eLVSrhjcPkLslzkR
	cAdmKsky3Xe/7TbmJyAh9Bqu0bkGin82E1xhdwDlw5rdUskv92WHeJe34WiYEEdyTTaogDLuN+z
	tLWPrfKy+ig/1gCAoHvVNd2490/UaXzewMnKgyFnIbja4y3r0+HHTnra3icFVw==
X-Google-Smtp-Source: AGHT+IHj+Op94mzlo16js4gRYFsEOUzqX/RPIICMR4H1DzKdZ+5MaSCW3aQOPebkZZvTUcK0EQmzrw==
X-Received: by 2002:a05:6a21:103:b0:21a:e751:e048 with SMTP id adf61e73a8af0-2207f289a0emr10750457637.35.1750924872745;
        Thu, 26 Jun 2025 01:01:12 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ad63d3facsm3799107b3a.102.2025.06.26.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:01:12 -0700 (PDT)
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
	Ze Huang <huangze@whut.edu.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next RFC v3 1/4] dt-bindings: net: Add support for Sophgo CV1800 dwmac
Date: Thu, 26 Jun 2025 16:00:51 +0800
Message-ID: <20250626080056.325496-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626080056.325496-1-inochiama@gmail.com>
References: <20250626080056.325496-1-inochiama@gmail.com>
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


