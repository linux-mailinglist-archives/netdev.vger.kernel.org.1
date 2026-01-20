Return-Path: <netdev+bounces-251359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B8D3BF60
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46DC14F95E2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2836C5B9;
	Tue, 20 Jan 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvZctAGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBC2BE043
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890669; cv=none; b=AGwREei+BxAoOAKc7WOSH+NpWdzPihXqrPpz1xoPawmMsqkSOCN8Fda+km7ZMlE/gZDB3e1QLspP7H0xV9u/1Z243VswT5DktWifBr1vXlk42oIsTHRUuM6dTQunDtpHH8UQDMDDTs9lihtc/eoQnL4R6mOEkg4Rx4y4zKITJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890669; c=relaxed/simple;
	bh=0+Y9hEB70xxqyIY6tsWCzgo3WT4f+mm90U6/OsPJkFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idrVf8QjUISiW3if0FZHzf2cUwaBM7rT8dJPx4Kc3hVmeCpRaqE5u0WfirTUtT44J97XnwNmzypUCtZ9J68WgtvVKnnDySvYjBsM5hQiM7bEQMSSQ4BC7IOMr680TSr2NXu46bmAYzz4nMxIAQkx8wYF/8+m+yY8DZC/yNDBVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvZctAGI; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94121102a54so3368961241.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890667; x=1769495467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/P4vB6ZrTUYfKL01JZTaSnR0v+y3e+rmtwAP48/qa4=;
        b=YvZctAGIN9yL+LpJOq3yrFedFqvtBEjgvEiSo0nrw3yY13h6DtvM0+zPxwt8UzS6VS
         89M0zi/OIi4kAb85aZiy6aWvEKp3b7bQOA66QsPkXCq+6HeJEwgRq9Bz+2/jueQca42/
         4USevSnMF6hkL0+dAnDig+u0/xCvpCjXn4AuBav0f5y/lOK0KDShA+nvj9Lul1fID3Tc
         7d8LmsDsdTvDifgTN0OffXW3GhZYkwAQlI5B/J8D0vaxZJdjauWgpr2FvLGrVsmXcDZW
         rOI4494m2dU0s2VLbvWdcakMbiJEKLirBIXMfDdRhREogqJpW7Ir6ELytA1cgfo3b1O1
         sodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890667; x=1769495467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/P4vB6ZrTUYfKL01JZTaSnR0v+y3e+rmtwAP48/qa4=;
        b=j5WRKr72ZeZdiIqpSXQHOvaFPDDPK/1qT/Rtq4td45seGZ7EgiLud0rlVUpAgWrW77
         DWhf+6sBm1B5U+QrbpW2/2WsXgP+CUKaX6yzHU/oGwzGldv9u/EoioYE+IxWIKOnviUp
         fLythWa9jYGO6wtqxmN0qC7uZm4mB6qnbnS7G71yy0iPxxxY5g8VJt1zZa/43EMY2X8e
         FbNxTOifgSvXB4cjRK+RhguCoxHCLR5Q0xTebARUVNaNrEvzPcTeYaOUFEs1YpJ03Nwu
         tXRWkZB+dHTpAfke16c8RIxIO/nqPaWD3+gMmEgnhZEDB4ac2b0xZJaIligO9ir9brcL
         Z4UA==
X-Gm-Message-State: AOJu0Yx9c2t8mS7LPZDJ2IB/GH/EgWKTLAv4fOTVC3yb49z0SlOeYm1I
	D8gWuCI9uFw2NN0ba695EHgGBEv1x783tSxxTd6SJBC5varkUYisgDS4oC38W/fO
X-Gm-Gg: AZuq6aK0SVhl65e/+Lie/prv195TF5f924D1Gd5JLNreW/M6KK7CSN9DO1l2xrTk0nv
	Aqk86wcPHP/gsOpkuXoalLyP5LTytI9fVv7hpAL6my0a6kLFws0E6tsYTTSx77ZvxJMLs+NsoHs
	aF0dkUwDmpPfQXkTT8gb8An82iaEYc591UVFMkWw8Wj3OeELo327GccD9KQEysUpgZDYvdrMvlR
	T5v0UKg8+AESG1gxZ1xrnPktTpc6HlKqDu+Q5V09FzBGrLb83TfuVUzAzGSEp5kYeAdqAvFJpT5
	vnLZJC/4htbYRZiFcJIEkTllBgfC4GD/eDbdzPelfo/T6JEIQnWVBDtu0o5iW2Qu2Amcqe8Rkxa
	Hr3nRnIJ+W0XPyF93C2HlOdBFaxVnqLgyYmcBlzx3r0Jp+ijVvrUK5nqe8g1cUemqzXf2eua/v7
	AuNksxkcoOkXcwQOIwwIQt
X-Received: by 2002:a05:7300:6d1f:b0:2b0:4e86:8157 with SMTP id 5a478bee46e88-2b6b46eb100mr10720484eec.17.1768883786512;
        Mon, 19 Jan 2026 20:36:26 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15459859eec.9.2026.01.19.20.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:36:26 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 1/3] dt-bindings: net: Add support for Spacemit K3 dwmac
Date: Tue, 20 Jan 2026 12:36:06 +0800
Message-ID: <20260120043609.910302-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120043609.910302-1-inochiama@gmail.com>
References: <20260120043609.910302-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
MAC (version 5.40a) with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 107 ++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index dd3c72e8363e..3c2c6cb6b10b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -34,6 +34,7 @@ select:
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
           - snps,dwmac-5.30a
+          - snps,dwmac-5.40a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -108,6 +109,7 @@ properties:
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
         - snps,dwmac-5.30a
+        - snps,dwmac-5.40a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - sophgo,sg2042-dwmac
@@ -653,6 +655,7 @@ allOf:
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
                 - snps,dwmac-5.30a
+                - snps,dwmac-5.40a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
new file mode 100644
index 000000000000..58dd98f79e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K3 DWMAC glue layer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: spacemit,k3-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: spacemit,k3-dwmac
+      - const: snps,dwmac-5.40a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+      - description: TX clock
+      - description: PHY clock
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: tx
+      - const: phy
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: MAC interrupt
+      - description: MAC wake interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: stmmaceth
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the syscon node which control the glue register
+          - description: offset of the control register
+          - description: offset of the dline register
+
+    description:
+      A phandle to syscon with offset to control registers for this MAC
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
+    eth0: ethernet@cac80000 {
+      compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+      reg = <0xcac80000 0x2000>;
+      clocks = <&syscon_apmu 66>, <&syscon_apmu 68>,
+               <&syscon_apmu 69>;
+      clock-names = "stmmaceth", "ptp_ref", "tx";
+      interrupts = <131 IRQ_TYPE_LEVEL_HIGH>, <276 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_wake_irq";
+      phy-mode = "rgmii-id";
+      phy-handle = <&phy0>;
+      resets = <&syscon_apmu 67>;
+      reset-names = "stmmaceth";
+      spacemit,apmu = <&syscon_apmu 0x384 0x38c>;
+    };
+
-- 
2.52.0


