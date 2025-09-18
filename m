Return-Path: <netdev+bounces-223131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A124B58074
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7171174238
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A466350D49;
	Mon, 15 Sep 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mZ8JiBAB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566734AAF1;
	Mon, 15 Sep 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949699; cv=none; b=UsUkC37mPsvdReBX/UFoTnSDR0XIgmREIpYtL104IKTRD4sTx2MCb5YX18egrW5jLQax7aGLmlN7oVsyz9Ou8tGBGl74CPcSTx38XVb3Ca2G34EaAfKetTdgtldgWAoaaiVITgyKoYYaC4JOkqpA3nq4iFltoNQnq3n8bLYWios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949699; c=relaxed/simple;
	bh=l+BGCj+L0MnYj+rDJpYqSeJFI3YpMtcpk7qjkVNx9dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRIJa5sd9d9QRzjEORA1x2sPoQDM/gCh85rtTYxlMUI1Wxtq25fwFblE377md3NN7yTx4IbPQdjgTnF51kI+5e6XZnCf3cv2lrQTkMofgu7qSCvJy19drTWqmFss0wig0G+hg63t3t5+9kMWRt/mM3Q3ZOwS7wTsWqP9GfLZsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mZ8JiBAB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949694;
	bh=l+BGCj+L0MnYj+rDJpYqSeJFI3YpMtcpk7qjkVNx9dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZ8JiBAB1j9vWn97ABZAV/aGIJwjmpp14sFSrJTnBwGVfv9CrilRcBP2gopy6foWh
	 u0NMJ0AUimvrYXDWfg5D5Hx+blYFu960a+RBHPnrQYmsrB5ec5rkiOZXRE1GC30orr
	 NwTMW+xDkEzxAlwqdPliFUa3/lAScnwBSn9IG4I4bQmcH/FF1YPNiXVda3v+mAd6XY
	 i+bPElAXwkg1oa11+XzoG1yO+FUDobqy5plL000PQKY9OT4XPHO2FScF7IoLdZCxUp
	 HtHQSKn/eKL3wfGTC88GwaxTO0t6EXY0BuzS/FEic6oA/wwSFygvFrR2RGAgqWDBVX
	 osHvF31A7Yw8w==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 710E717E1340;
	Mon, 15 Sep 2025 17:21:33 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 09/27] dt-bindings: clock: mediatek: Describe MT8196 clock controllers
Date: Mon, 15 Sep 2025 17:19:29 +0200
Message-Id: <20250915151947.277983-10-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915151947.277983-1-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce binding documentation for system clocks, functional clocks,
and PEXTP0/1 and UFS reset controllers on MediaTek MT8196.

This binding also includes a handle to the hardware voter, a
fixed-function MCU designed to aggregate votes from the application
processor and other remote processors to manage clocks and power
domains.

The HWV on MT8196/MT6991 is incomplete and requires software to manually
enable power supplies, parent clocks, and FENC, as well as write to both
the HWV MMIO and the controller registers.
Because of these constraints, the HWV cannot be modeled using generic
clock, power domain, or interconnect APIs. Instead, a custom phandle is
exceptionally used to provide direct, syscon-like register access to
drivers.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../bindings/clock/mediatek,mt8196-clock.yaml | 112 +++
 .../clock/mediatek,mt8196-sys-clock.yaml      | 107 +++
 .../dt-bindings/clock/mediatek,mt8196-clock.h | 803 ++++++++++++++++++
 .../reset/mediatek,mt8196-resets.h            |  26 +
 4 files changed, 1048 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
new file mode 100644
index 000000000000..bfdbd2e4a167
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8196-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Functional Clock Controller for MT8196
+
+maintainers:
+  - Guangjie Song <guangjie.song@mediatek.com>
+  - Laura Nao <laura.nao@collabora.com>
+
+description: |
+  The clock architecture in MediaTek SoCs is structured like below:
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The device nodes provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8196-imp-iic-wrap-c
+          - mediatek,mt8196-imp-iic-wrap-e
+          - mediatek,mt8196-imp-iic-wrap-n
+          - mediatek,mt8196-imp-iic-wrap-w
+          - mediatek,mt8196-mdpsys0
+          - mediatek,mt8196-mdpsys1
+          - mediatek,mt8196-pericfg-ao
+          - mediatek,mt8196-pextp0cfg-ao
+          - mediatek,mt8196-pextp1cfg-ao
+          - mediatek,mt8196-ufscfg-ao
+          - mediatek,mt8196-vencsys
+          - mediatek,mt8196-vencsys-c1
+          - mediatek,mt8196-vencsys-c2
+          - mediatek,mt8196-vdecsys
+          - mediatek,mt8196-vdecsys-soc
+          - mediatek,mt8196-vdisp-ao
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+    description:
+      Reset lines for PEXTP0/1 and UFS blocks.
+
+  mediatek,hardware-voter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the "Hardware Voter" (HWV), as named in the vendor
+      documentation for MT8196/MT6991.
+
+      The HWV is a SoC-internal fixed-function MCU used to collect votes from
+      both the Application Processor and other remote processors within the SoC.
+      It is intended to transparently enable or disable hardware resources (such
+      as power domains or clocks) based on internal vote aggregation handled by
+      the MCU's internal state machine.
+
+      However, in practice, this design is incomplete. While the HWV performs
+      some internal vote aggregation,software is still required to
+      - Manually enable power supplies externally, if present and if required
+      - Manually enable parent clocks via direct MMIO writes to clock controllers
+      - Enable the FENC after the clock has been ungated via direct MMIO
+      writes to clock controllers
+
+      As such, the HWV behaves more like a hardware-managed clock reference
+      counter than a true voter. Furthermore, it is not a separate
+      controller. It merely serves as an alternative interface to the same
+      underlying clock or power controller. Actual control still requires
+      direct access to the controller's own MMIO register space, in
+      addition to writing to the HWV's MMIO region.
+
+      For this reason, a custom phandle is used here - drivers need to directly
+      access the HWV MMIO region in a syscon-like fashion, due to how the
+      hardware is wired. This differs from true hardware voting systems, which
+      typically do not require custom phandles and rely instead on generic APIs
+      (clocks, power domains, interconnects).
+
+      The name "hardware-voter" is retained to match vendor documentation, but
+      this should not be reused or misunderstood as a proper voting mechanism.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pericfg_ao: clock-controller@16640000 {
+        compatible = "mediatek,mt8196-pericfg-ao", "syscon";
+        reg = <0x16640000 0x1000>;
+        mediatek,hardware-voter = <&scp_hwv>;
+        #clock-cells = <1>;
+    };
+  - |
+    pextp0cfg_ao: clock-controller@169b0000 {
+        compatible = "mediatek,mt8196-pextp0cfg-ao", "syscon";
+        reg = <0x169b0000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
new file mode 100644
index 000000000000..660ab64f390d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8196-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Clock Controller for MT8196
+
+maintainers:
+  - Guangjie Song <guangjie.song@mediatek.com>
+  - Laura Nao <laura.nao@collabora.com>
+
+description: |
+  The clock architecture in MediaTek SoCs is structured like below:
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The apmixedsys, apmixedsys_gp2, vlpckgen, armpll, ccipll, mfgpll and ptppll
+  provide most of the PLLs which are generated from the SoC's 26MHZ crystal oscillator.
+  The topckgen, topckgen_gp2 and vlpckgen provide dividers and muxes which
+  provide the clock source to other IP blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8196-apmixedsys
+          - mediatek,mt8196-armpll-b-pll-ctrl
+          - mediatek,mt8196-armpll-bl-pll-ctrl
+          - mediatek,mt8196-armpll-ll-pll-ctrl
+          - mediatek,mt8196-apmixedsys-gp2
+          - mediatek,mt8196-ccipll-pll-ctrl
+          - mediatek,mt8196-mfgpll-pll-ctrl
+          - mediatek,mt8196-mfgpll-sc0-pll-ctrl
+          - mediatek,mt8196-mfgpll-sc1-pll-ctrl
+          - mediatek,mt8196-ptppll-pll-ctrl
+          - mediatek,mt8196-topckgen
+          - mediatek,mt8196-topckgen-gp2
+          - mediatek,mt8196-vlpckgen
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  mediatek,hardware-voter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the "Hardware Voter" (HWV), as named in the vendor
+      documentation for MT8196/MT6991.
+
+      The HWV is a SoC-internal fixed-function MCU used to collect votes from
+      both the Application Processor and other remote processors within the SoC.
+      It is intended to transparently enable or disable hardware resources (such
+      as power domains or clocks) based on internal vote aggregation handled by
+      the MCU's internal state machine.
+
+      However, in practice, this design is incomplete. While the HWV performs
+      some internal vote aggregation,software is still required to
+      - Manually enable power supplies externally, if present and if required
+      - Manually enable parent clocks via direct MMIO writes to clock controllers
+      - Enable the FENC after the clock has been ungated via direct MMIO
+      writes to clock controllers
+
+      As such, the HWV behaves more like a hardware-managed clock reference
+      counter than a true voter. Furthermore, it is not a separate
+      controller. It merely serves as an alternative interface to the same
+      underlying clock or power controller. Actual control still requires
+      direct access to the controller's own MMIO register space, in
+      addition to writing to the HWV's MMIO region.
+
+      For this reason, a custom phandle is used here - drivers need to directly
+      access the HWV MMIO region in a syscon-like fashion, due to how the
+      hardware is wired. This differs from true hardware voting systems, which
+      typically do not require custom phandles and rely instead on generic APIs
+      (clocks, power domains, interconnects).
+
+      The name "hardware-voter" is retained to match vendor documentation, but
+      this should not be reused or misunderstood as a proper voting mechanism.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    apmixedsys_clk: syscon@10000800 {
+        compatible = "mediatek,mt8196-apmixedsys", "syscon";
+        reg = <0x10000800 0x1000>;
+        #clock-cells = <1>;
+    };
+  - |
+    topckgen: syscon@10000000 {
+        compatible = "mediatek,mt8196-topckgen", "syscon";
+        reg = <0x10000000 0x800>;
+        mediatek,hardware-voter = <&scp_hwv>;
+        #clock-cells = <1>;
+    };
+
diff --git a/include/dt-bindings/clock/mediatek,mt8196-clock.h b/include/dt-bindings/clock/mediatek,mt8196-clock.h
new file mode 100644
index 000000000000..ae0946ab7621
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt8196-clock.h
@@ -0,0 +1,803 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Guangjie Song <guangjie.song@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    Laura Nao <laura.nao@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8196_H
+#define _DT_BINDINGS_CLK_MT8196_H
+
+/* CKSYS */
+#define CLK_TOP_AXI					0
+#define CLK_TOP_MEM_SUB					1
+#define CLK_TOP_IO_NOC					2
+#define CLK_TOP_P_AXI					3
+#define CLK_TOP_UFS_PEXTP0_AXI				4
+#define CLK_TOP_PEXTP1_USB_AXI				5
+#define CLK_TOP_P_FMEM_SUB				6
+#define CLK_TOP_PEXPT0_MEM_SUB				7
+#define CLK_TOP_PEXTP1_USB_MEM_SUB			8
+#define CLK_TOP_P_NOC					9
+#define CLK_TOP_EMI_N					10
+#define CLK_TOP_EMI_S					11
+#define CLK_TOP_AP2CONN_HOST				12
+#define CLK_TOP_ATB					13
+#define CLK_TOP_CIRQ					14
+#define CLK_TOP_PBUS_156M				15
+#define CLK_TOP_EFUSE					16
+#define CLK_TOP_MCL3GIC					17
+#define CLK_TOP_MCINFRA					18
+#define CLK_TOP_DSP					19
+#define CLK_TOP_MFG_REF					20
+#define CLK_TOP_MFG_EB					21
+#define CLK_TOP_UART					22
+#define CLK_TOP_SPI0_BCLK				23
+#define CLK_TOP_SPI1_BCLK				24
+#define CLK_TOP_SPI2_BCLK				25
+#define CLK_TOP_SPI3_BCLK				26
+#define CLK_TOP_SPI4_BCLK				27
+#define CLK_TOP_SPI5_BCLK				28
+#define CLK_TOP_SPI6_BCLK				29
+#define CLK_TOP_SPI7_BCLK				30
+#define CLK_TOP_MSDC30_1				31
+#define CLK_TOP_MSDC30_2				32
+#define CLK_TOP_DISP_PWM				33
+#define CLK_TOP_USB_TOP_1P				34
+#define CLK_TOP_USB_XHCI_1P				35
+#define CLK_TOP_USB_FMCNT_P1				36
+#define CLK_TOP_I2C_P					37
+#define CLK_TOP_I2C_EAST				38
+#define CLK_TOP_I2C_WEST				39
+#define CLK_TOP_I2C_NORTH				40
+#define CLK_TOP_AES_UFSFDE				41
+#define CLK_TOP_UFS					42
+#define CLK_TOP_AUD_1					43
+#define CLK_TOP_AUD_2					44
+#define CLK_TOP_ADSP					45
+#define CLK_TOP_ADSP_UARTHUB_B				46
+#define CLK_TOP_DPMAIF_MAIN				47
+#define CLK_TOP_PWM					48
+#define CLK_TOP_MCUPM					49
+#define CLK_TOP_IPSEAST					50
+#define CLK_TOP_TL					51
+#define CLK_TOP_TL_P1					52
+#define CLK_TOP_TL_P2					53
+#define CLK_TOP_EMI_INTERFACE_546			54
+#define CLK_TOP_SDF					55
+#define CLK_TOP_UARTHUB_BCLK				56
+#define CLK_TOP_DPSW_CMP_26M				57
+#define CLK_TOP_SMAP					58
+#define CLK_TOP_SSR_PKA					59
+#define CLK_TOP_SSR_DMA					60
+#define CLK_TOP_SSR_KDF					61
+#define CLK_TOP_SSR_RNG					62
+#define CLK_TOP_SPU0					63
+#define CLK_TOP_SPU1					64
+#define CLK_TOP_DXCC					65
+#define CLK_TOP_APLL_I2SIN0				66
+#define CLK_TOP_APLL_I2SIN1				67
+#define CLK_TOP_APLL_I2SIN2				68
+#define CLK_TOP_APLL_I2SIN3				69
+#define CLK_TOP_APLL_I2SIN4				70
+#define CLK_TOP_APLL_I2SIN6				71
+#define CLK_TOP_APLL_I2SOUT0				72
+#define CLK_TOP_APLL_I2SOUT1				73
+#define CLK_TOP_APLL_I2SOUT2				74
+#define CLK_TOP_APLL_I2SOUT3				75
+#define CLK_TOP_APLL_I2SOUT4				76
+#define CLK_TOP_APLL_I2SOUT6				77
+#define CLK_TOP_APLL_FMI2S				78
+#define CLK_TOP_APLL_TDMOUT				79
+#define CLK_TOP_APLL12_DIV_TDMOUT_M			80
+#define CLK_TOP_APLL12_DIV_TDMOUT_B			81
+#define CLK_TOP_MAINPLL_D3				82
+#define CLK_TOP_MAINPLL_D4				83
+#define CLK_TOP_MAINPLL_D4_D2				84
+#define CLK_TOP_MAINPLL_D4_D4				85
+#define CLK_TOP_MAINPLL_D4_D8				86
+#define CLK_TOP_MAINPLL_D5				87
+#define CLK_TOP_MAINPLL_D5_D2				88
+#define CLK_TOP_MAINPLL_D5_D4				89
+#define CLK_TOP_MAINPLL_D5_D8				90
+#define CLK_TOP_MAINPLL_D6				91
+#define CLK_TOP_MAINPLL_D6_D2				92
+#define CLK_TOP_MAINPLL_D7				93
+#define CLK_TOP_MAINPLL_D7_D2				94
+#define CLK_TOP_MAINPLL_D7_D4				95
+#define CLK_TOP_MAINPLL_D7_D8				96
+#define CLK_TOP_MAINPLL_D9				97
+#define CLK_TOP_UNIVPLL_D4				98
+#define CLK_TOP_UNIVPLL_D4_D2				99
+#define CLK_TOP_UNIVPLL_D4_D4				100
+#define CLK_TOP_UNIVPLL_D4_D8				101
+#define CLK_TOP_UNIVPLL_D5				102
+#define CLK_TOP_UNIVPLL_D5_D2				103
+#define CLK_TOP_UNIVPLL_D5_D4				104
+#define CLK_TOP_UNIVPLL_D6				105
+#define CLK_TOP_UNIVPLL_D6_D2				106
+#define CLK_TOP_UNIVPLL_D6_D4				107
+#define CLK_TOP_UNIVPLL_D6_D8				108
+#define CLK_TOP_UNIVPLL_D6_D16				109
+#define CLK_TOP_UNIVPLL_192M				110
+#define CLK_TOP_UNIVPLL_192M_D4				111
+#define CLK_TOP_UNIVPLL_192M_D8				112
+#define CLK_TOP_UNIVPLL_192M_D16			113
+#define CLK_TOP_UNIVPLL_192M_D32			114
+#define CLK_TOP_UNIVPLL_192M_D10			115
+#define CLK_TOP_TVDPLL1_D2				116
+#define CLK_TOP_MSDCPLL_D2				117
+#define CLK_TOP_OSC_D2					118
+#define CLK_TOP_OSC_D3					119
+#define CLK_TOP_OSC_D4					120
+#define CLK_TOP_OSC_D5					121
+#define CLK_TOP_OSC_D7					122
+#define CLK_TOP_OSC_D8					123
+#define CLK_TOP_OSC_D10					124
+#define CLK_TOP_OSC_D14					125
+#define CLK_TOP_OSC_D20					126
+#define CLK_TOP_OSC_D32					127
+#define CLK_TOP_OSC_D40					128
+#define CLK_TOP_SFLASH					129
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_MAINPLL				0
+#define CLK_APMIXED_UNIVPLL				1
+#define CLK_APMIXED_MSDCPLL				2
+#define CLK_APMIXED_ADSPPLL				3
+#define CLK_APMIXED_EMIPLL				4
+#define CLK_APMIXED_EMIPLL2				5
+#define CLK_APMIXED_NET1PLL				6
+#define CLK_APMIXED_SGMIIPLL				7
+
+/* CKSYS_GP2 */
+#define CLK_TOP2_SENINF0				0
+#define CLK_TOP2_SENINF1				1
+#define CLK_TOP2_SENINF2				2
+#define CLK_TOP2_SENINF3				3
+#define CLK_TOP2_SENINF4				4
+#define CLK_TOP2_SENINF5				5
+#define CLK_TOP2_IMG1					6
+#define CLK_TOP2_IPE					7
+#define CLK_TOP2_CAM					8
+#define CLK_TOP2_CAMTM					9
+#define CLK_TOP2_DPE					10
+#define CLK_TOP2_VDEC					11
+#define CLK_TOP2_CCUSYS					12
+#define CLK_TOP2_CCUTM					13
+#define CLK_TOP2_VENC					14
+#define CLK_TOP2_DP1					15
+#define CLK_TOP2_DP0					16
+#define CLK_TOP2_DISP					17
+#define CLK_TOP2_MDP					18
+#define CLK_TOP2_MMINFRA				19
+#define CLK_TOP2_MMINFRA_SNOC				20
+#define CLK_TOP2_MMUP					21
+#define CLK_TOP2_MMINFRA_AO				22
+#define CLK_TOP2_MAINPLL2_D2				23
+#define CLK_TOP2_MAINPLL2_D3				24
+#define CLK_TOP2_MAINPLL2_D4				25
+#define CLK_TOP2_MAINPLL2_D4_D2				26
+#define CLK_TOP2_MAINPLL2_D4_D4				27
+#define CLK_TOP2_MAINPLL2_D5				28
+#define CLK_TOP2_MAINPLL2_D5_D2				29
+#define CLK_TOP2_MAINPLL2_D6				30
+#define CLK_TOP2_MAINPLL2_D6_D2				31
+#define CLK_TOP2_MAINPLL2_D7				32
+#define CLK_TOP2_MAINPLL2_D7_D2				33
+#define CLK_TOP2_MAINPLL2_D9				34
+#define CLK_TOP2_UNIVPLL2_D3				35
+#define CLK_TOP2_UNIVPLL2_D4				36
+#define CLK_TOP2_UNIVPLL2_D4_D2				37
+#define CLK_TOP2_UNIVPLL2_D5				38
+#define CLK_TOP2_UNIVPLL2_D5_D2				39
+#define CLK_TOP2_UNIVPLL2_D6				40
+#define CLK_TOP2_UNIVPLL2_D6_D2				41
+#define CLK_TOP2_UNIVPLL2_D6_D4				42
+#define CLK_TOP2_UNIVPLL2_D7				43
+#define CLK_TOP2_IMGPLL_D2				44
+#define CLK_TOP2_IMGPLL_D4				45
+#define CLK_TOP2_IMGPLL_D5				46
+#define CLK_TOP2_IMGPLL_D5_D2				47
+#define CLK_TOP2_MMPLL2_D3				48
+#define CLK_TOP2_MMPLL2_D4				49
+#define CLK_TOP2_MMPLL2_D4_D2				50
+#define CLK_TOP2_MMPLL2_D5				51
+#define CLK_TOP2_MMPLL2_D5_D2				52
+#define CLK_TOP2_MMPLL2_D6				53
+#define CLK_TOP2_MMPLL2_D6_D2				54
+#define CLK_TOP2_MMPLL2_D7				55
+#define CLK_TOP2_MMPLL2_D9				56
+#define CLK_TOP2_TVDPLL1_D4				57
+#define CLK_TOP2_TVDPLL1_D8				58
+#define CLK_TOP2_TVDPLL1_D16				59
+#define CLK_TOP2_TVDPLL2_D2				60
+#define CLK_TOP2_TVDPLL2_D4				61
+#define CLK_TOP2_TVDPLL2_D8				62
+#define CLK_TOP2_TVDPLL2_D16				63
+#define CLK_TOP2_DVO					64
+#define CLK_TOP2_DVO_FAVT				65
+#define CLK_TOP2_TVDPLL3_D2				66
+#define CLK_TOP2_TVDPLL3_D4				67
+#define CLK_TOP2_TVDPLL3_D8				68
+#define CLK_TOP2_TVDPLL3_D16				69
+
+/* APMIXEDSYS_GP2 */
+#define CLK_APMIXED2_MAINPLL2				0
+#define CLK_APMIXED2_UNIVPLL2				1
+#define CLK_APMIXED2_MMPLL2				2
+#define CLK_APMIXED2_IMGPLL				3
+#define CLK_APMIXED2_TVDPLL1				4
+#define CLK_APMIXED2_TVDPLL2				5
+#define CLK_APMIXED2_TVDPLL3				6
+
+/* IMP_IIC_WRAP_E */
+#define CLK_IMPE_I2C5					0
+
+/* IMP_IIC_WRAP_W */
+#define CLK_IMPW_I2C0					0
+#define CLK_IMPW_I2C3					1
+#define CLK_IMPW_I2C6					2
+#define CLK_IMPW_I2C10					3
+
+/* IMP_IIC_WRAP_N */
+#define CLK_IMPN_I2C1					0
+#define CLK_IMPN_I2C2					1
+#define CLK_IMPN_I2C4					2
+#define CLK_IMPN_I2C7					3
+#define CLK_IMPN_I2C8					4
+#define CLK_IMPN_I2C9					5
+
+/* IMP_IIC_WRAP_C */
+#define CLK_IMPC_I2C11					0
+#define CLK_IMPC_I2C12					1
+#define CLK_IMPC_I2C13					2
+#define CLK_IMPC_I2C14					3
+
+/* PERICFG_AO */
+#define CLK_PERI_AO_UART0_BCLK				0
+#define CLK_PERI_AO_UART1_BCLK				1
+#define CLK_PERI_AO_UART2_BCLK				2
+#define CLK_PERI_AO_UART3_BCLK				3
+#define CLK_PERI_AO_UART4_BCLK				4
+#define CLK_PERI_AO_UART5_BCLK				5
+#define CLK_PERI_AO_PWM_X16W_HCLK			6
+#define CLK_PERI_AO_PWM_X16W_BCLK			7
+#define CLK_PERI_AO_PWM_PWM_BCLK0			8
+#define CLK_PERI_AO_PWM_PWM_BCLK1			9
+#define CLK_PERI_AO_PWM_PWM_BCLK2			10
+#define CLK_PERI_AO_PWM_PWM_BCLK3			11
+#define CLK_PERI_AO_SPI0_BCLK				12
+#define CLK_PERI_AO_SPI1_BCLK				13
+#define CLK_PERI_AO_SPI2_BCLK				14
+#define CLK_PERI_AO_SPI3_BCLK				15
+#define CLK_PERI_AO_SPI4_BCLK				16
+#define CLK_PERI_AO_SPI5_BCLK				17
+#define CLK_PERI_AO_SPI6_BCLK				18
+#define CLK_PERI_AO_SPI7_BCLK				19
+#define CLK_PERI_AO_AP_DMA_X32W_BCLK			20
+#define CLK_PERI_AO_MSDC1_MSDC_SRC			21
+#define CLK_PERI_AO_MSDC1_HCLK				22
+#define CLK_PERI_AO_MSDC1_AXI				23
+#define CLK_PERI_AO_MSDC1_HCLK_WRAP			24
+#define CLK_PERI_AO_MSDC2_MSDC_SRC			25
+#define CLK_PERI_AO_MSDC2_HCLK				26
+#define CLK_PERI_AO_MSDC2_AXI				27
+#define CLK_PERI_AO_MSDC2_HCLK_WRAP			28
+#define CLK_PERI_AO_FLASHIF_FLASH			29
+#define CLK_PERI_AO_FLASHIF_27M				30
+#define CLK_PERI_AO_FLASHIF_DRAM			31
+#define CLK_PERI_AO_FLASHIF_AXI				32
+#define CLK_PERI_AO_FLASHIF_BCLK			33
+
+/* UFSCFG_AO */
+#define CLK_UFSAO_UNIPRO_TX_SYM				0
+#define CLK_UFSAO_UNIPRO_RX_SYM0			1
+#define CLK_UFSAO_UNIPRO_RX_SYM1			2
+#define CLK_UFSAO_UNIPRO_SYS				3
+#define CLK_UFSAO_UNIPRO_SAP				4
+#define CLK_UFSAO_PHY_SAP				5
+#define CLK_UFSAO_UFSHCI_UFS				6
+#define CLK_UFSAO_UFSHCI_AES				7
+
+/* PEXTP0CFG_AO */
+#define CLK_PEXT_PEXTP_MAC_P0_TL			0
+#define CLK_PEXT_PEXTP_MAC_P0_REF			1
+#define CLK_PEXT_PEXTP_PHY_P0_MCU_BUS			2
+#define CLK_PEXT_PEXTP_PHY_P0_PEXTP_REF			3
+#define CLK_PEXT_PEXTP_MAC_P0_AXI_250			4
+#define CLK_PEXT_PEXTP_MAC_P0_AHB_APB			5
+#define CLK_PEXT_PEXTP_MAC_P0_PL_P			6
+#define CLK_PEXT_PEXTP_VLP_AO_P0_LP			7
+
+/* PEXTP1CFG_AO */
+#define CLK_PEXT1_PEXTP_MAC_P1_TL			0
+#define CLK_PEXT1_PEXTP_MAC_P1_REF			1
+#define CLK_PEXT1_PEXTP_MAC_P2_TL			2
+#define CLK_PEXT1_PEXTP_MAC_P2_REF			3
+#define CLK_PEXT1_PEXTP_PHY_P1_MCU_BUS			4
+#define CLK_PEXT1_PEXTP_PHY_P1_PEXTP_REF		5
+#define CLK_PEXT1_PEXTP_PHY_P2_MCU_BUS			6
+#define CLK_PEXT1_PEXTP_PHY_P2_PEXTP_REF		7
+#define CLK_PEXT1_PEXTP_MAC_P1_AXI_250			8
+#define CLK_PEXT1_PEXTP_MAC_P1_AHB_APB			9
+#define CLK_PEXT1_PEXTP_MAC_P1_PL_P			10
+#define CLK_PEXT1_PEXTP_MAC_P2_AXI_250			11
+#define CLK_PEXT1_PEXTP_MAC_P2_AHB_APB			12
+#define CLK_PEXT1_PEXTP_MAC_P2_PL_P			13
+#define CLK_PEXT1_PEXTP_VLP_AO_P1_LP			14
+#define CLK_PEXT1_PEXTP_VLP_AO_P2_LP			15
+
+/* VLP_CKSYS */
+#define CLK_VLP_APLL1					0
+#define CLK_VLP_APLL2					1
+#define CLK_VLP_SCP					2
+#define CLK_VLP_SCP_SPI					3
+#define CLK_VLP_SCP_IIC					4
+#define CLK_VLP_SCP_IIC_HS				5
+#define CLK_VLP_PWRAP_ULPOSC				6
+#define CLK_VLP_SPMI_M_TIA_32K				7
+#define CLK_VLP_APXGPT_26M_B				8
+#define CLK_VLP_DPSW					9
+#define CLK_VLP_DPSW_CENTRAL				10
+#define CLK_VLP_SPMI_M_MST				11
+#define CLK_VLP_DVFSRC					12
+#define CLK_VLP_PWM_VLP					13
+#define CLK_VLP_AXI_VLP					14
+#define CLK_VLP_SYSTIMER_26M				15
+#define CLK_VLP_SSPM					16
+#define CLK_VLP_SRCK					17
+#define CLK_VLP_CAMTG0					18
+#define CLK_VLP_CAMTG1					19
+#define CLK_VLP_CAMTG2					20
+#define CLK_VLP_CAMTG3					21
+#define CLK_VLP_CAMTG4					22
+#define CLK_VLP_CAMTG5					23
+#define CLK_VLP_CAMTG6					24
+#define CLK_VLP_CAMTG7					25
+#define CLK_VLP_SSPM_26M				26
+#define CLK_VLP_ULPOSC_SSPM				27
+#define CLK_VLP_VLP_PBUS_26M				28
+#define CLK_VLP_DEBUG_ERR_FLAG				29
+#define CLK_VLP_DPMSRDMA				30
+#define CLK_VLP_VLP_PBUS_156M				31
+#define CLK_VLP_SPM					32
+#define CLK_VLP_MMINFRA					33
+#define CLK_VLP_USB_TOP					34
+#define CLK_VLP_USB_XHCI				35
+#define CLK_VLP_NOC_VLP					36
+#define CLK_VLP_AUDIO_H					37
+#define CLK_VLP_AUD_ENGEN1				38
+#define CLK_VLP_AUD_ENGEN2				39
+#define CLK_VLP_AUD_INTBUS				40
+#define CLK_VLP_SPVLP_26M				41
+#define CLK_VLP_SPU0_VLP				42
+#define CLK_VLP_SPU1_VLP				43
+#define CLK_VLP_CLK26M                                  44
+#define CLK_VLP_APLL1_D4				45
+#define CLK_VLP_APLL1_D8				46
+#define CLK_VLP_APLL2_D4				47
+#define CLK_VLP_APLL2_D8				48
+
+/* DISPSYS_CONFIG */
+#define CLK_MM_CONFIG					0
+#define CLK_MM_DISP_MUTEX0				1
+#define CLK_MM_DISP_AAL0				2
+#define CLK_MM_DISP_AAL1				3
+#define CLK_MM_DISP_C3D0				4
+#define CLK_MM_DISP_C3D1				5
+#define CLK_MM_DISP_C3D2				6
+#define CLK_MM_DISP_C3D3				7
+#define CLK_MM_DISP_CCORR0				8
+#define CLK_MM_DISP_CCORR1				9
+#define CLK_MM_DISP_CCORR2				10
+#define CLK_MM_DISP_CCORR3				11
+#define CLK_MM_DISP_CHIST0				12
+#define CLK_MM_DISP_CHIST1				13
+#define CLK_MM_DISP_COLOR0				14
+#define CLK_MM_DISP_COLOR1				15
+#define CLK_MM_DISP_DITHER0				16
+#define CLK_MM_DISP_DITHER1				17
+#define CLK_MM_DISP_DLI_ASYNC0				18
+#define CLK_MM_DISP_DLI_ASYNC1				19
+#define CLK_MM_DISP_DLI_ASYNC2				20
+#define CLK_MM_DISP_DLI_ASYNC3				21
+#define CLK_MM_DISP_DLI_ASYNC4				22
+#define CLK_MM_DISP_DLI_ASYNC5				23
+#define CLK_MM_DISP_DLI_ASYNC6				24
+#define CLK_MM_DISP_DLI_ASYNC7				25
+#define CLK_MM_DISP_DLI_ASYNC8				26
+#define CLK_MM_DISP_DLI_ASYNC9				27
+#define CLK_MM_DISP_DLI_ASYNC10				28
+#define CLK_MM_DISP_DLI_ASYNC11				29
+#define CLK_MM_DISP_DLI_ASYNC12				30
+#define CLK_MM_DISP_DLI_ASYNC13				31
+#define CLK_MM_DISP_DLI_ASYNC14				32
+#define CLK_MM_DISP_DLI_ASYNC15				33
+#define CLK_MM_DISP_DLO_ASYNC0				34
+#define CLK_MM_DISP_DLO_ASYNC1				35
+#define CLK_MM_DISP_DLO_ASYNC2				36
+#define CLK_MM_DISP_DLO_ASYNC3				37
+#define CLK_MM_DISP_DLO_ASYNC4				38
+#define CLK_MM_DISP_DLO_ASYNC5				39
+#define CLK_MM_DISP_DLO_ASYNC6				40
+#define CLK_MM_DISP_DLO_ASYNC7				41
+#define CLK_MM_DISP_DLO_ASYNC8				42
+#define CLK_MM_DISP_GAMMA0				43
+#define CLK_MM_DISP_GAMMA1				44
+#define CLK_MM_MDP_AAL0					45
+#define CLK_MM_MDP_AAL1					46
+#define CLK_MM_MDP_RDMA0				47
+#define CLK_MM_DISP_POSTMASK0				48
+#define CLK_MM_DISP_POSTMASK1				49
+#define CLK_MM_MDP_RSZ0					50
+#define CLK_MM_MDP_RSZ1					51
+#define CLK_MM_DISP_SPR0				52
+#define CLK_MM_DISP_TDSHP0				53
+#define CLK_MM_DISP_TDSHP1				54
+#define CLK_MM_DISP_WDMA0				55
+#define CLK_MM_DISP_Y2R0				56
+#define CLK_MM_SMI_SUB_COMM0				57
+#define CLK_MM_DISP_FAKE_ENG0				58
+
+/* DISPSYS1_CONFIG */
+#define CLK_MM1_DISPSYS1_CONFIG				0
+#define CLK_MM1_DISPSYS1_S_CONFIG			1
+#define CLK_MM1_DISP_MUTEX0				2
+#define CLK_MM1_DISP_DLI_ASYNC20			3
+#define CLK_MM1_DISP_DLI_ASYNC21			4
+#define CLK_MM1_DISP_DLI_ASYNC22			5
+#define CLK_MM1_DISP_DLI_ASYNC23			6
+#define CLK_MM1_DISP_DLI_ASYNC24			7
+#define CLK_MM1_DISP_DLI_ASYNC25			8
+#define CLK_MM1_DISP_DLI_ASYNC26			9
+#define CLK_MM1_DISP_DLI_ASYNC27			10
+#define CLK_MM1_DISP_DLI_ASYNC28			11
+#define CLK_MM1_DISP_RELAY0				12
+#define CLK_MM1_DISP_RELAY1				13
+#define CLK_MM1_DISP_RELAY2				14
+#define CLK_MM1_DISP_RELAY3				15
+#define CLK_MM1_DISP_DP_INTF0				16
+#define CLK_MM1_DISP_DP_INTF1				17
+#define CLK_MM1_DISP_DSC_WRAP0				18
+#define CLK_MM1_DISP_DSC_WRAP1				19
+#define CLK_MM1_DISP_DSC_WRAP2				20
+#define CLK_MM1_DISP_DSC_WRAP3				21
+#define CLK_MM1_DISP_DSI0				22
+#define CLK_MM1_DISP_DSI1				23
+#define CLK_MM1_DISP_DSI2				24
+#define CLK_MM1_DISP_DVO0				25
+#define CLK_MM1_DISP_GDMA0				26
+#define CLK_MM1_DISP_MERGE0				27
+#define CLK_MM1_DISP_MERGE1				28
+#define CLK_MM1_DISP_MERGE2				29
+#define CLK_MM1_DISP_ODDMR0				30
+#define CLK_MM1_DISP_POSTALIGN0				31
+#define CLK_MM1_DISP_DITHER2				32
+#define CLK_MM1_DISP_R2Y0				33
+#define CLK_MM1_DISP_SPLITTER0				34
+#define CLK_MM1_DISP_SPLITTER1				35
+#define CLK_MM1_DISP_SPLITTER2				36
+#define CLK_MM1_DISP_SPLITTER3				37
+#define CLK_MM1_DISP_VDCM0				38
+#define CLK_MM1_DISP_WDMA1				39
+#define CLK_MM1_DISP_WDMA2				40
+#define CLK_MM1_DISP_WDMA3				41
+#define CLK_MM1_DISP_WDMA4				42
+#define CLK_MM1_MDP_RDMA1				43
+#define CLK_MM1_SMI_LARB0				44
+#define CLK_MM1_MOD1					45
+#define CLK_MM1_MOD2					46
+#define CLK_MM1_MOD3					47
+#define CLK_MM1_MOD4					48
+#define CLK_MM1_MOD5					49
+#define CLK_MM1_MOD6					50
+#define CLK_MM1_CG0					51
+#define CLK_MM1_CG1					52
+#define CLK_MM1_CG2					53
+#define CLK_MM1_CG3					54
+#define CLK_MM1_CG4					55
+#define CLK_MM1_CG5					56
+#define CLK_MM1_CG6					57
+#define CLK_MM1_CG7					58
+#define CLK_MM1_F26M					59
+
+/* OVLSYS_CONFIG */
+#define CLK_OVLSYS_CONFIG				0
+#define CLK_OVL_FAKE_ENG0				1
+#define CLK_OVL_FAKE_ENG1				2
+#define CLK_OVL_MUTEX0					3
+#define CLK_OVL_EXDMA0					4
+#define CLK_OVL_EXDMA1					5
+#define CLK_OVL_EXDMA2					6
+#define CLK_OVL_EXDMA3					7
+#define CLK_OVL_EXDMA4					8
+#define CLK_OVL_EXDMA5					9
+#define CLK_OVL_EXDMA6					10
+#define CLK_OVL_EXDMA7					11
+#define CLK_OVL_EXDMA8					12
+#define CLK_OVL_EXDMA9					13
+#define CLK_OVL_BLENDER0				14
+#define CLK_OVL_BLENDER1				15
+#define CLK_OVL_BLENDER2				16
+#define CLK_OVL_BLENDER3				17
+#define CLK_OVL_BLENDER4				18
+#define CLK_OVL_BLENDER5				19
+#define CLK_OVL_BLENDER6				20
+#define CLK_OVL_BLENDER7				21
+#define CLK_OVL_BLENDER8				22
+#define CLK_OVL_BLENDER9				23
+#define CLK_OVL_OUTPROC0				24
+#define CLK_OVL_OUTPROC1				25
+#define CLK_OVL_OUTPROC2				26
+#define CLK_OVL_OUTPROC3				27
+#define CLK_OVL_OUTPROC4				28
+#define CLK_OVL_OUTPROC5				29
+#define CLK_OVL_MDP_RSZ0				30
+#define CLK_OVL_MDP_RSZ1				31
+#define CLK_OVL_DISP_WDMA0				32
+#define CLK_OVL_DISP_WDMA1				33
+#define CLK_OVL_UFBC_WDMA0				34
+#define CLK_OVL_MDP_RDMA0				35
+#define CLK_OVL_MDP_RDMA1				36
+#define CLK_OVL_BWM0					37
+#define CLK_OVL_DLI0					38
+#define CLK_OVL_DLI1					39
+#define CLK_OVL_DLI2					40
+#define CLK_OVL_DLI3					41
+#define CLK_OVL_DLI4					42
+#define CLK_OVL_DLI5					43
+#define CLK_OVL_DLI6					44
+#define CLK_OVL_DLI7					45
+#define CLK_OVL_DLI8					46
+#define CLK_OVL_DLO0					47
+#define CLK_OVL_DLO1					48
+#define CLK_OVL_DLO2					49
+#define CLK_OVL_DLO3					50
+#define CLK_OVL_DLO4					51
+#define CLK_OVL_DLO5					52
+#define CLK_OVL_DLO6					53
+#define CLK_OVL_DLO7					54
+#define CLK_OVL_DLO8					55
+#define CLK_OVL_DLO9					56
+#define CLK_OVL_DLO10					57
+#define CLK_OVL_DLO11					58
+#define CLK_OVL_DLO12					59
+#define CLK_OVLSYS_RELAY0				60
+#define CLK_OVL_INLINEROT0				61
+#define CLK_OVL_SMI					62
+#define CLK_OVL_SMI_SMI					63
+
+
+/* OVLSYS1_CONFIG */
+#define CLK_OVL1_OVLSYS_CONFIG				0
+#define CLK_OVL1_OVL_FAKE_ENG0				1
+#define CLK_OVL1_OVL_FAKE_ENG1				2
+#define CLK_OVL1_OVL_MUTEX0				3
+#define CLK_OVL1_OVL_EXDMA0				4
+#define CLK_OVL1_OVL_EXDMA1				5
+#define CLK_OVL1_OVL_EXDMA2				6
+#define CLK_OVL1_OVL_EXDMA3				7
+#define CLK_OVL1_OVL_EXDMA4				8
+#define CLK_OVL1_OVL_EXDMA5				9
+#define CLK_OVL1_OVL_EXDMA6				10
+#define CLK_OVL1_OVL_EXDMA7				11
+#define CLK_OVL1_OVL_EXDMA8				12
+#define CLK_OVL1_OVL_EXDMA9				13
+#define CLK_OVL1_OVL_BLENDER0				14
+#define CLK_OVL1_OVL_BLENDER1				15
+#define CLK_OVL1_OVL_BLENDER2				16
+#define CLK_OVL1_OVL_BLENDER3				17
+#define CLK_OVL1_OVL_BLENDER4				18
+#define CLK_OVL1_OVL_BLENDER5				19
+#define CLK_OVL1_OVL_BLENDER6				20
+#define CLK_OVL1_OVL_BLENDER7				21
+#define CLK_OVL1_OVL_BLENDER8				22
+#define CLK_OVL1_OVL_BLENDER9				23
+#define CLK_OVL1_OVL_OUTPROC0				24
+#define CLK_OVL1_OVL_OUTPROC1				25
+#define CLK_OVL1_OVL_OUTPROC2				26
+#define CLK_OVL1_OVL_OUTPROC3				27
+#define CLK_OVL1_OVL_OUTPROC4				28
+#define CLK_OVL1_OVL_OUTPROC5				29
+#define CLK_OVL1_OVL_MDP_RSZ0				30
+#define CLK_OVL1_OVL_MDP_RSZ1				31
+#define CLK_OVL1_OVL_DISP_WDMA0				32
+#define CLK_OVL1_OVL_DISP_WDMA1				33
+#define CLK_OVL1_OVL_UFBC_WDMA0				34
+#define CLK_OVL1_OVL_MDP_RDMA0				35
+#define CLK_OVL1_OVL_MDP_RDMA1				36
+#define CLK_OVL1_OVL_BWM0				37
+#define CLK_OVL1_DLI0					38
+#define CLK_OVL1_DLI1					39
+#define CLK_OVL1_DLI2					40
+#define CLK_OVL1_DLI3					41
+#define CLK_OVL1_DLI4					42
+#define CLK_OVL1_DLI5					43
+#define CLK_OVL1_DLI6					44
+#define CLK_OVL1_DLI7					45
+#define CLK_OVL1_DLI8					46
+#define CLK_OVL1_DLO0					47
+#define CLK_OVL1_DLO1					48
+#define CLK_OVL1_DLO2					49
+#define CLK_OVL1_DLO3					50
+#define CLK_OVL1_DLO4					51
+#define CLK_OVL1_DLO5					52
+#define CLK_OVL1_DLO6					53
+#define CLK_OVL1_DLO7					54
+#define CLK_OVL1_DLO8					55
+#define CLK_OVL1_DLO9					56
+#define CLK_OVL1_DLO10					57
+#define CLK_OVL1_DLO11					58
+#define CLK_OVL1_DLO12					59
+#define CLK_OVL1_OVLSYS_RELAY0				60
+#define CLK_OVL1_OVL_INLINEROT0				61
+#define CLK_OVL1_SMI					62
+
+
+/* VDEC_SOC_GCON_BASE */
+#define CLK_VDE1_LARB1_CKEN				0
+#define CLK_VDE1_LAT_CKEN				1
+#define CLK_VDE1_LAT_ACTIVE				2
+#define CLK_VDE1_LAT_CKEN_ENG				3
+#define CLK_VDE1_VDEC_CKEN				4
+#define CLK_VDE1_VDEC_ACTIVE				5
+#define CLK_VDE1_VDEC_CKEN_ENG				6
+#define CLK_VDE1_VDEC_SOC_APTV_EN			7
+#define CLK_VDE1_VDEC_SOC_APTV_TOP_EN			8
+#define CLK_VDE1_VDEC_SOC_IPS_EN			9
+
+/* VDEC_GCON_BASE */
+#define CLK_VDE2_LARB1_CKEN				0
+#define CLK_VDE2_LAT_CKEN				1
+#define CLK_VDE2_LAT_ACTIVE				2
+#define CLK_VDE2_LAT_CKEN_ENG				3
+#define CLK_VDE2_VDEC_CKEN				4
+#define CLK_VDE2_VDEC_ACTIVE				5
+#define CLK_VDE2_VDEC_CKEN_ENG				6
+
+/* VENC_GCON */
+#define CLK_VEN1_CKE0_LARB				0
+#define CLK_VEN1_CKE1_VENC				1
+#define CLK_VEN1_CKE2_JPGENC				2
+#define CLK_VEN1_CKE3_JPGDEC				3
+#define CLK_VEN1_CKE4_JPGDEC_C1				4
+#define CLK_VEN1_CKE5_GALS				5
+#define CLK_VEN1_CKE29_VENC_ADAB_CTRL			6
+#define CLK_VEN1_CKE29_VENC_XPC_CTRL			7
+#define CLK_VEN1_CKE6_GALS_SRAM				8
+#define CLK_VEN1_RES_FLAT				9
+
+/* VENC_GCON_CORE1 */
+#define CLK_VEN2_CKE0_LARB				0
+#define CLK_VEN2_CKE1_VENC				1
+#define CLK_VEN2_CKE2_JPGENC				2
+#define CLK_VEN2_CKE3_JPGDEC				3
+#define CLK_VEN2_CKE5_GALS				4
+#define CLK_VEN2_CKE29_VENC_XPC_CTRL			5
+#define CLK_VEN2_CKE6_GALS_SRAM				6
+#define CLK_VEN2_RES_FLAT				7
+
+/* VENC_GCON_CORE2 */
+#define CLK_VEN_C2_CKE0_LARB				0
+#define CLK_VEN_C2_CKE1_VENC				1
+#define CLK_VEN_C2_CKE5_GALS				2
+#define CLK_VEN_C2_CKE29_VENC_XPC_CTRL			3
+#define CLK_VEN_C2_CKE6_GALS_SRAM			4
+#define CLK_VEN_C2_RES_FLAT				5
+
+/* MDPSYS_CONFIG */
+#define CLK_MDP_MDP_MUTEX0				0
+#define CLK_MDP_SMI0					1
+#define CLK_MDP_SMI0_SMI				2
+#define CLK_MDP_APB_BUS					3
+#define CLK_MDP_MDP_RDMA0				4
+#define CLK_MDP_MDP_RDMA1				5
+#define CLK_MDP_MDP_RDMA2				6
+#define CLK_MDP_MDP_BIRSZ0				7
+#define CLK_MDP_MDP_HDR0				8
+#define CLK_MDP_MDP_AAL0				9
+#define CLK_MDP_MDP_RSZ0				10
+#define CLK_MDP_MDP_RSZ2				11
+#define CLK_MDP_MDP_TDSHP0				12
+#define CLK_MDP_MDP_COLOR0				13
+#define CLK_MDP_MDP_WROT0				14
+#define CLK_MDP_MDP_WROT1				15
+#define CLK_MDP_MDP_WROT2				16
+#define CLK_MDP_MDP_FAKE_ENG0				17
+#define CLK_MDP_APB_DB					18
+#define CLK_MDP_MDP_DLI_ASYNC0				19
+#define CLK_MDP_MDP_DLI_ASYNC1				20
+#define CLK_MDP_MDP_DLO_ASYNC0				21
+#define CLK_MDP_MDP_DLO_ASYNC1				22
+#define CLK_MDP_MDP_DLI_ASYNC2				23
+#define CLK_MDP_MDP_DLO_ASYNC2				24
+#define CLK_MDP_MDP_DLO_ASYNC3				25
+#define CLK_MDP_IMG_DL_ASYNC0				26
+#define CLK_MDP_MDP_RROT0				27
+#define CLK_MDP_MDP_MERGE0				28
+#define CLK_MDP_MDP_C3D0				29
+#define CLK_MDP_MDP_FG0					30
+#define CLK_MDP_MDP_CLA2				31
+#define CLK_MDP_MDP_DLO_ASYNC4				32
+#define CLK_MDP_VPP_RSZ0				33
+#define CLK_MDP_VPP_RSZ1				34
+#define CLK_MDP_MDP_DLO_ASYNC5				35
+#define CLK_MDP_IMG0					36
+#define CLK_MDP_F26M					37
+#define CLK_MDP_IMG_DL_RELAY0				38
+#define CLK_MDP_IMG_DL_RELAY1				39
+
+/* MDPSYS1_CONFIG */
+#define CLK_MDP1_MDP_MUTEX0				0
+#define CLK_MDP1_SMI0					1
+#define CLK_MDP1_SMI0_SMI				2
+#define CLK_MDP1_APB_BUS				3
+#define CLK_MDP1_MDP_RDMA0				4
+#define CLK_MDP1_MDP_RDMA1				5
+#define CLK_MDP1_MDP_RDMA2				6
+#define CLK_MDP1_MDP_BIRSZ0				7
+#define CLK_MDP1_MDP_HDR0				8
+#define CLK_MDP1_MDP_AAL0				9
+#define CLK_MDP1_MDP_RSZ0				10
+#define CLK_MDP1_MDP_RSZ2				11
+#define CLK_MDP1_MDP_TDSHP0				12
+#define CLK_MDP1_MDP_COLOR0				13
+#define CLK_MDP1_MDP_WROT0				14
+#define CLK_MDP1_MDP_WROT1				15
+#define CLK_MDP1_MDP_WROT2				16
+#define CLK_MDP1_MDP_FAKE_ENG0				17
+#define CLK_MDP1_APB_DB					18
+#define CLK_MDP1_MDP_DLI_ASYNC0				19
+#define CLK_MDP1_MDP_DLI_ASYNC1				20
+#define CLK_MDP1_MDP_DLO_ASYNC0				21
+#define CLK_MDP1_MDP_DLO_ASYNC1				22
+#define CLK_MDP1_MDP_DLI_ASYNC2				23
+#define CLK_MDP1_MDP_DLO_ASYNC2				24
+#define CLK_MDP1_MDP_DLO_ASYNC3				25
+#define CLK_MDP1_IMG_DL_ASYNC0				26
+#define CLK_MDP1_MDP_RROT0				27
+#define CLK_MDP1_MDP_MERGE0				28
+#define CLK_MDP1_MDP_C3D0				29
+#define CLK_MDP1_MDP_FG0				30
+#define CLK_MDP1_MDP_CLA2				31
+#define CLK_MDP1_MDP_DLO_ASYNC4				32
+#define CLK_MDP1_VPP_RSZ0				33
+#define CLK_MDP1_VPP_RSZ1				34
+#define CLK_MDP1_MDP_DLO_ASYNC5				35
+#define CLK_MDP1_IMG0					36
+#define CLK_MDP1_F26M					37
+#define CLK_MDP1_IMG_DL_RELAY0				38
+#define CLK_MDP1_IMG_DL_RELAY1				39
+
+/* DISP_VDISP_AO_CONFIG */
+#define CLK_MM_V_DISP_VDISP_AO_CONFIG			0
+#define CLK_MM_V_DISP_DPC				1
+#define CLK_MM_V_SMI_SUB_SOMM0				2
+
+/* MFGPLL_PLL_CTRL */
+#define CLK_MFG_AO_MFGPLL				0
+
+/* MFGPLL_SC0_PLL_CTRL */
+#define CLK_MFGSC0_AO_MFGPLL_SC0			0
+
+/* MFGPLL_SC1_PLL_CTRL */
+#define CLK_MFGSC1_AO_MFGPLL_SC1			0
+
+/* CCIPLL_PLL_CTRL */
+#define CLK_CCIPLL					0
+
+/* ARMPLL_LL_PLL_CTRL */
+#define CLK_CPLL_ARMPLL_LL				0
+
+/* ARMPLL_BL_PLL_CTRL */
+#define CLK_CPBL_ARMPLL_BL				0
+
+/* ARMPLL_B_PLL_CTRL */
+#define CLK_CPB_ARMPLL_B				0
+
+/* PTPPLL_PLL_CTRL */
+#define CLK_PTPPLL					0
+
+#endif /* _DT_BINDINGS_CLK_MT8196_H */
diff --git a/include/dt-bindings/reset/mediatek,mt8196-resets.h b/include/dt-bindings/reset/mediatek,mt8196-resets.h
new file mode 100644
index 000000000000..46ced0850d91
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8196-resets.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8196
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8196
+
+/* PEXTP0 resets */
+#define MT8196_PEXTP0_RST0_PCIE0_MAC		0
+#define MT8196_PEXTP0_RST0_PCIE0_PHY		1
+
+/* PEXTP1 resets */
+#define MT8196_PEXTP1_RST0_PCIE1_MAC		0
+#define MT8196_PEXTP1_RST0_PCIE1_PHY		1
+#define MT8196_PEXTP1_RST0_PCIE2_MAC		2
+#define MT8196_PEXTP1_RST0_PCIE2_PHY		3
+
+/* UFS resets */
+#define MT8196_UFSAO_RST0_UFS_MPHY		0
+#define MT8196_UFSAO_RST1_UFS_UNIPRO		1
+#define MT8196_UFSAO_RST1_UFS_CRYPTO		2
+#define MT8196_UFSAO_RST1_UFSHCI		3
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8196 */
-- 
2.39.5


