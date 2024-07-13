Return-Path: <netdev+bounces-111291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AF9307C0
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6149B1C211CF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE815DBB6;
	Sat, 13 Jul 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="VQWcCCCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE14EC5E
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910126; cv=none; b=ahV8g3nUgEtcPKh3qfjo479MZy16xbIg2xV+uGcfhq4hQdMi0Xcgpt/ptE9RwQMAhlUFGfI/Giw8QgHdAwHHRjqOqXLZpZlX8CRKOpaqfAaVx0ZxB2mxA6i+kDyx8h+6+CugpojVqDbhAuxo7LSRqxNeIwayMYC4KTFRx2STRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910126; c=relaxed/simple;
	bh=zCLySV5EiWp6xCmHvjwHnXYPPFGzjEkiFSbsL+beAvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtBAhYiwBUU6FKSYLRFhhKqz+o5QcWCk6yQqsGF+zWyxcvOePYGBFMzCXMGh0PBkKM19qxp/OIPa/y4lxXzXK7e7Lbbgvjk70Sv1BUn074V9goDFI/9c2cWDZRi7jcQKymR+z+NGaTO35f7KmnwkW6ZoSGPtpaMm9ria14NiE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=VQWcCCCG; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9dfc7c5f6so1458516b6e.0
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720910124; x=1721514924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alTBG+u/YLjKyTy47XAD1gqzMa09sOqVoRaB/kIbg6M=;
        b=VQWcCCCGe85V0eos3nAAwlsMOcZe7ohy5/MpR8gktKpRrRTX6hVgQtB/mQ4HXZu9+S
         kr6danvovbxyHEfNhd+A1ovmD3scVFPB6IECR3nPLmEwGOs/ZYJLuwN7Zyuqe94Ata8a
         C2iuFJ5F+7mHkpEOXZF+BvRDOgVihX8FzoJlsJgPrwtwQmsUXfk5RKhsZCTbUV8ikhF5
         UN5t7ElLR1y2AUSrXIgfcQpdoH4t/DlaX5a6JbdRoCOShN5w5onfDG9QcCr2lm/wiqyL
         Lx9L/98h9lTPyC/3pZR3hGInZ484Axj9haHo/fG58aTku5ZRZdJ4BxdSGCbfovMFkQmc
         Zgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720910124; x=1721514924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alTBG+u/YLjKyTy47XAD1gqzMa09sOqVoRaB/kIbg6M=;
        b=uBmm5mcu+xLIFtC42/fkzV9EVs1yn8ppAwAE9eznZbymMmy3AeQ6i5YuEu1FRNMZtb
         49R5RMLPDKVNj5a5z+UP6DEQD/4lxhX0ZdaI+uKM1Jk/1wpnBLKO4I8fgcUzsMAPqrXg
         4+A1ptN5Zp1JN2/BWdyEPhQzbl33QknotubOL0uOXr5gsA/J2yPDsIF9IItRU8Qr/K5a
         UUruh9eDukoao/zNUDre6sCaeJY+FMBxyBP62n8IHGZ+wnzG9wRspRvzSEJTgmR4YSnK
         cyG09xitf6divJUibfqct69t+v8i8NeGWeM/4GYeho2J2qnoAne3FWhS1ubKByNU/kN3
         UUkg==
X-Gm-Message-State: AOJu0YytvKl/eYz8dvWqOawI0lg/lsAL96lsuieGwCJScwnmkA76ySj1
	bY3rKMcNAoFMVa4vkgO6Kwowndq5JWlxmakW37GhxnISXOcSMw7EpRiGEB1i6/8=
X-Google-Smtp-Source: AGHT+IEYT0gC2VTZYS2sf8gfKkEAnenEHDXxurHyzMbwt0lUKt7Uw0JJq9+GvaJQa3SRamrYdVWDxQ==
X-Received: by 2002:a54:4887:0:b0:3da:a6ce:f02c with SMTP id 5614622812f47-3daa6cef4c8mr8226788b6e.20.1720910123980;
        Sat, 13 Jul 2024 15:35:23 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:d7fc:57d0:ada6:13b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4d9d8sm14640025ad.264.2024.07.13.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:35:23 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Sat, 13 Jul 2024 15:35:11 -0700
Subject: [PATCH RFC net-next 2/4] dt-bindings: net: add T-HEAD dwmac
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240713-thead-dwmac-v1-2-81f04480cd31@tenstorrent.com>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
In-Reply-To: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720910119; l=3679;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=Y0E8nHMS0ChuTKJIO/9LY9pitgmvEOTz6OdEh2EGJdM=;
 b=CnXpDka3RYSnvNevDmDeEY3cdh4Cuclhx83gpRYciYZPaW7Lncl7HiKfGGZ+vf+vL/6bKiiAg
 NqzeNosEJGHCjNVVRAFPPUyhZ9vKonMP2wKOgI5NMbo4mgJUTSUKo60
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

From: Jisheng Zhang <jszhang@kernel.org>

Add documentation to describe T-HEAD dwmac.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/r/20230827091710.1483-3-jszhang@kernel.org
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: change apb registers from syscon to second reg of gmac node]
Signed-off-by: Drew Fustini <drew@pdp7.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |  1 +
 .../devicetree/bindings/net/thead,dwmac.yaml       | 81 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 0ad3bf5dafa7..d417f0e2d9c6 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -97,6 +97,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - thead,th1520-dwmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
new file mode 100644
index 000000000000..5618ede47925
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD DWMAC Ethernet controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - thead,th1520-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - thead,th1520-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: DesignWare GMAC IP core registers
+      - description: GMAC APB registers
+
+  reg-names:
+    minItems: 2
+    maxItems: 2
+    items:
+      - const: dwmac
+      - const: apb
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@e7070000 {
+        compatible = "thead,th1520-dwmac", "snps,dwmac-3.70a";
+        reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
+        reg-names = "dwmac", "apb";
+        clocks = <&clk 1>, <&clk 2>;
+        clock-names = "stmmaceth", "pclk";
+        interrupts = <66>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,pbl = <32>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e1736969189b..c724c2c4e06c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19319,6 +19319,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/net/thead,dwmac.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h

-- 
2.34.1


