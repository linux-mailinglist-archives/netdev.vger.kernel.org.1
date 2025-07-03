Return-Path: <netdev+bounces-203596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600EAF67C8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6694A7430
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3D1B0F17;
	Thu,  3 Jul 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCmPu2DF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DC78F3B;
	Thu,  3 Jul 2025 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508763; cv=none; b=LlTfC2ZGl4sDyLXXUAneHho41e85ZcKjLO66jchnZV/YyO8wywkkz1bR4XatBEc2BYcUh/iBWO8/P8f/FzOSAp6nM+GrsEgSBcRLPuUDwmqLJalZnlGhIQRMnSpLSnZxurhAoZh/OcV5EkfKdYDARhmlcwINzi+uzXZEhClPLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508763; c=relaxed/simple;
	bh=sMqFnXsB9KHf9HSqojnNLZvxtE3M1hEaE1+cY5TdKiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUR/I8N1Zxeb8fdXfSzejrfjpJyvHY3PQ8MbT/8PACfHbucbSCenlCqry524sWzqTIlb+KVv/j1A5buaotnlkn/V0i6glHlfcil5jwLmh9Pyonuf7nbwyjz5qKcy4jyRwm8mxjbNZ1cRvX1Y6g514NDTM2d1Bw5hWz3nLhcPOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCmPu2DF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ef62066eso96182965ad.3;
        Wed, 02 Jul 2025 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751508761; x=1752113561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S16+Wo1JY0zCcQqq1dcPzIA9NOiw0i4loy9qh5wd/pc=;
        b=KCmPu2DFpT+ia3G8ZJ0BwfYp+d7q91+IS6f8IPkwJvA6u4X8UP8uVoQHJhJw67h1ur
         sIHtA/rdGgCBIA7CJIfbR2FZeqLTEYPxnmJhXr6HQWWWkNnWZOtV/oSPhGIq+HIMX0Bo
         h3qie4UEKeItaKBcwaucMjL60ArPOPBcRM1QXHZX3GTj/fpIMfP6CzU8kUcs3XaVqvB6
         XcR1Hwq9Sp1k2tw4zTir7kcxAmiQgYNld87s3QIqgqke5Lt1QGDRf/bMKiVGG4pVEEqV
         SHoOTDhUIhxVkV7oGGsBlfO3uyDlsEBVv8MNYwbHr2dbTRdqk3ArKD3Hav1I1EieKY5o
         3skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508761; x=1752113561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S16+Wo1JY0zCcQqq1dcPzIA9NOiw0i4loy9qh5wd/pc=;
        b=Dzgvg27YNFoEp6z06hHc2NZwF0f3eHQ8rxDBZF/V3gh5T3myN3IcMz7EIODXnexi8w
         CpccjJgtbkRPq2i3jp4nxsZrIgpRBkKP3Ac8Qr0u6Z847gqd5u0CueRJ9RMfIyH+XqqY
         d6kcCdxlNR5uF+o+SfAu5Q1WEKQDBvyEI+rD0aGfEwcdJx4LqCrmdtVqDxU5lPlzS3IM
         +AIc2OwK0PafSh2L8Gd6Zg7QsoA2ucOfLq6vHZCBhdMfe3b+J2oV3s1ILaeJxaS3xYwn
         K4ZA8nwntdM3np+A1hYgmF0C7JUe9FYWrCP7qjLo9e/yMZj8xlVbvbhqd7CIJ1WoetG2
         PC7g==
X-Forwarded-Encrypted: i=1; AJvYcCV6ED4GK0TOfEyzpX3pmZPp7yt9sYYhuMeb29Sda3iseNpTt+0LAVXrEdPe9KUWAATmG2OTQ7EpVgPo@vger.kernel.org, AJvYcCWmG/2JawE9gIHhNXIl8PjXhuQqtOVmzpAfNLDB3B2tb1U45VolkoDJA/mbjNNdmOmMh2+ggkWRm1RsuIUD@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbJWwhhQWgdM/x/pAaI8xPzrwzpyzcPRMWd2zy6Ql/Kj26R2K
	qpcVEy0Do3ODSlDi98dJ2gIWZ+E4LI7wGxohb14/Id9IKt8X7RRX71jd
X-Gm-Gg: ASbGncst0kN9kgZme7EjdCjpQxTW9qyuc3rWTCieUdRtHaOlKq97YJ3nlLx3qbg+1HZ
	Ph7EoNH5VGRN3F/FYLOf7MRbgxYgCZGFe1AndDZGuuY1D8eH1btC3ajpI3z7mNmvUucSbJcaA2/
	F2HZSWOdJ/IKxyNoqUdSpPDog623tQIvEvpbn5nDHcjd9Pgma1bUvjRg8tN1T9l5azkqf7Szbkt
	GzRYAz8rXl8P76KTbQW7JX2afhkZTrlJH2Hqi6Xz/801j7iSb0TfRbwKwsNiQbyDAIS/Jv79wv2
	lICe/lxOkWQw/HtFnNw8gruMX1Y5p5UtqwLrikD9wm84gf66lkM1tdGwn2zTwA==
X-Google-Smtp-Source: AGHT+IFnmlwLaBLaGwc+N19c2w52c0k4AcjFAlDtZ/2XEfLCT2lg1jaNUPZxftwxJdpBB1iqrVZDJA==
X-Received: by 2002:a17:902:d492:b0:236:8df9:ab38 with SMTP id d9443c01a7336-23c6e591cd5mr88563685ad.34.1751508761218;
        Wed, 02 Jul 2025 19:12:41 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f1b31sm140649065ad.69.2025.07.02.19.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:12:40 -0700 (PDT)
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
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next] dt-bindings: net: Add support for Sophgo CV1800 dwmac
Date: Thu,  3 Jul 2025 10:12:19 +0800
Message-ID: <20250703021220.124195-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
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
The binding patch is split from the origianl series
"[PATCH net-next RFC v4 0/4] riscv: dts: sophgo: Add ethernet support
for cv18xx".

Change from origianl RFC v4:
- https://lore.kernel.org/all/20250701011730.136002-1-inochiama@gmail.com
2. remove status, add "phy-handle" and "phy-mode" for binding test.
---
 .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
new file mode 100644
index 000000000000..b89456f0ef83
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
@@ -0,0 +1,114 @@
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
+      phy-handle = <&internal_ephy>;
+      phy-mode = "internal";
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


