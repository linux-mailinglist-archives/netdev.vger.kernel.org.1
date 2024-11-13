Return-Path: <netdev+bounces-144309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF79C6898
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BDA285325
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312A178CE4;
	Wed, 13 Nov 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9ygzPMh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AA176AA1;
	Wed, 13 Nov 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475204; cv=none; b=nqX3/f4sqNJ5kVq1mJI5BZheON2GmXw/LvxtF5s2+8LEfmQlPgRXqyJDsvIxAt53/hg9Ie88L8qUzlEO+44cV4aHuOPoQph08ks95Tfb2tIGoXbGXl8c4pe4fej2JX6pcQ4f/P/yfvj4OW1VIdeg7PAdG15IqL5futaig83VM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475204; c=relaxed/simple;
	bh=IXIpGPjA3gjJSh36bBLq3ZszAJZrgLpd20kmz+OkXb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgNaRWbE69cGFF03trvsRaMD74hLAHMlE1P3Lv5mCrlzpVrfcfDUdkcvobhEWmwEe3HvmgjevYxqwWjJrTFHKzpL94ao+jtQJCAe3VtLtQoDG3HyZjUBWsngWCZHq2nU+lVtT/EhGGUs6VrYXRG1YtQ2o66m2rnY8dtlZEYnQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9ygzPMh; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-290c69be014so2925962fac.3;
        Tue, 12 Nov 2024 21:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731475202; x=1732080002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMli1N+z0DyyhK39bT3ifRmFqQyEYElNZ9GJSN3gXSM=;
        b=D9ygzPMhsbGcRb5UyKvEG0d1xLUwiO2W2THpuDQpvsBF4cpnT/FJxRjclCJCUqVgIv
         UjDKm6PIUIKtuZ72mH1RWNXtQURFl8fmNWUcNx6M3Pz3bmtA7t2x1N2EQRYT/TSYXttc
         b8B22cXAwG27OGHarqEImvaEsSXAFsjuLOqHJ+CuBafsam9zBVoH2TD6mPAH+FX1ZDIL
         wd/eXJtm8caqiP0a/FBsMjYlLOg+pGfkr4y4RrGXPQC6uSAh6MXmhr4Z8Mx6ePdqe+kS
         ET3fYzjdGKTCKq3sK58k0bzWlBBN9uBUgMr1Xm9UMag3b69Qrguh4JjhlprsG23JkHKG
         Mf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731475202; x=1732080002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMli1N+z0DyyhK39bT3ifRmFqQyEYElNZ9GJSN3gXSM=;
        b=foK8sP5Sbn0XhLFf5kIRFZlqdQM9zr7ls3noRC9ZBzupZzFi9IeNZ/b1uCXzqLwi0k
         3P9JNQRhhRspatwSdkx49hPtoC2IjK30EdjEO6dm9+Ao4iyTfigp7V+i60hg7hBJ1Ddu
         21bpS0WXetfnZILNN6aFnzYWVz8GgumtlKjowa/kXTj5B4a5DwmRpY805SiPIyZ7B6Zt
         Hhw+8SLw6l0hZMOzHTswF3vaMvOEGlBxWTb9UsZllxhu1/JKejbNr4KnuM82pUZvJKbJ
         kj3knq4aRxQo9/u37AMbm3qgayQ5Fzv2ftsiUa21f5TcmVgkHDkuZngzZKrYGvZMRcUX
         8pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQzHiAmVx9ocRR+wFn7uUa5pyHyBFrmDWBrExqq4nV0xmPqRe42NoCA+UYWOXOaoABLyo9LST0@vger.kernel.org, AJvYcCWnbhlpbnfbEMeB6djRZGId6Wz7SbGKHVjPi1gqNsndnQwrOHCwscEzRHC8B2jELw3iCCx8lZasndh0Ki+A@vger.kernel.org, AJvYcCXnEwb7tXbfMQoKCoEkjUy8KKpQvxYKzaFUZHfADI6gThDgoO8/klx4x7H5mKrCQOEVT2HX3e46ZDT6@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbWTGzNqzkGyR94KWmJgmJevRYY6CbenQ/TQrMuEAwP2HcoH6
	/u+S8NPsFfeZsXFYDTxPxetPmUGIM5tGBDZFVGsbREOuOIvfDe16
X-Google-Smtp-Source: AGHT+IFe3VKkmjJmFK7cHt6HbH+71V9EWcoc7te6pi89V3VQcehyCiLGVfV8cx19XT/Qp+l+Gy43rA==
X-Received: by 2002:a05:6870:4686:b0:26c:64f8:d6c4 with SMTP id 586e51a60fabf-2956032f1bfmr14436206fac.38.1731475202093;
        Tue, 12 Nov 2024 21:20:02 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aaa01sm12644376b3a.100.2024.11.12.21.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:20:01 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: net: nuvoton: Add schema for MA35 family GMAC
Date: Wed, 13 Nov 2024 13:18:55 +0800
Message-Id: <20241113051857.12732-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113051857.12732-1-a0987203069@gmail.com>
References: <20241113051857.12732-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..45eaf13467b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+# We need a select here so we don't match all nodes with 'snps,dwmac'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nuvoton,ma35d1-dwmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    - items:
+        - enum:
+            - nuvoton,ma35d1-dwmac
+        - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum: [0, 1]
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  phy-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specifies a reference to a node representing a PHY device.
+
+  tx-internal-delay-ps:
+    enum: [0, 2000]
+    default: 0
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+
+  rx-internal-delay-ps:
+    enum: [0, 2000]
+    default: 0
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+  - phy-mode
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    //Example 1
+    gmac0: ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac";
+        reg = <0x0 0x40120000 0x0 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio0 {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eth_phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
+
+  - |
+    //Example 2
+    gmac1: ethernet@40130000 {
+        compatible = "nuvoton,ma35d1-dwmac";
+        reg = <0x0 0x40130000 0x0 0x10000>;
+        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 1>;
+        resets = <&sys MA35D1_RESET_GMAC1>;
+        reset-names = "stmmaceth";
+
+        phy-mode = "rmii";
+        phy-handle = <&eth_phy1>;
+        mdio1 {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eth_phy1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
-- 
2.34.1


