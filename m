Return-Path: <netdev+bounces-150072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92C09E8D41
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC09164B98
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0B215711;
	Mon,  9 Dec 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQhauB6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9021570F;
	Mon,  9 Dec 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732515; cv=none; b=ZOY7/6VA4HZwoM0lvRMRmULFwCGHclm3oFQr+JMsQxioMaUxMo0c7wnM4pcNYQxCbDOkZwUFjLC0qBNsxWcWgoccmQTaT+45OX59+FRktzR+IETZFdvjaWeiHgJEUykcivUeFEitDX2WI4uuvGFPjitsTCHwTVxRFbra4YZjOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732515; c=relaxed/simple;
	bh=fkyQotEH0I2OZbG3T6phqqOo8zuk5vtoj2Rys2IcIP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j30eHcBxJS5MOgKKNfU2i3l5EJiFbbdgu38OpnsLaqQnR2dqNOdkTmyhiZSpDZI18CClM82gPqUSUnvH8eQ1QLJy4keJCvhrC1DpAvUeQL28yk5JVE+dIa9Mj5r/KL97t/KpUXn6Apcy5OL/m2VOkMk3L138F+cpfV7LStplIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQhauB6Z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4676b7ee622so2771091cf.2;
        Mon, 09 Dec 2024 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733732513; x=1734337313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHyFhw8FNH5GUJVsOUJLYB3Q5momgCn7/xctoi3dazM=;
        b=FQhauB6ZBIGaFLtKGp2Fj9uoN7EtrXDyxWU4irCtU3JVXHiFsPP1sqVEyuDfVelF7c
         2xDeyHpMJwe3/cOCCayMb5Gc7q+26/H8G379rHlkU1UitPfgrMBT+eXr/Pzb56j2byrJ
         iaqTbRYzwLvjHCqMJahIY6xALi8TCh/qgFrAoBKWeknm8BWI+JMSkEeUmoaW5F1HyT+G
         TG0zZcnJ85cTN6VKKMC4jbhyICHVS6sol11ltBpt8RnSMRssu83dupyBM6K2LXru10ac
         BhXUE1yEn2Cc+vBFQlMtyeNCSwqi8Af/FQt/Km29/0fLBjuGy8T1dz5LhXX28TTgjLfa
         xaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733732513; x=1734337313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHyFhw8FNH5GUJVsOUJLYB3Q5momgCn7/xctoi3dazM=;
        b=Erlq42r7HLMYOEvMrAmcJh11ILeaakSoi07URIpeLEUP/Zi3kT43hDZeZODspMfr6w
         dB2EU8NzWNGI2iubk2Bc5U6/x3amJWXyHqmQiB1k4Jvbh1yx/v1w9pktn2/lP9XPYg59
         LN+TnRdgVhBP+UFAbh/OXiktbaUZ2CvoLnNvDBdAL8OqYELAjjIuw6uhjJEh5T8w12DY
         FxK8ej20LyyrVR31JOVyYBLIIZtwuqrL6spVXuzvyqsRKhzyeLFM147qNQ6/kmU1x7Ae
         fX93g7Oh6wz+hkdE4nKEKyMdgbpzWrnnlC1wEC2yF4/1Z24vmjXFFHGzkHhd/7bcTp+G
         wSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvOEcS1cM+OA+yrUCs9dOJK3rPIwDjicrmR3e5jEn+DrL+Eqn+4LXic66UFuam40JNCf2X0KT@vger.kernel.org, AJvYcCUmS+U6+J3EgEPlLRnvZAeEM6XouGKQHjysOyBHsdBaUpS6mWeWdEV07/XNTln7G0AObssGAG+S/4xPmxEe@vger.kernel.org, AJvYcCVSgema2nTuuFa7LZX+oaeSMUYAwlKnfMsB20OoYJv98OMvq59pQWUCXYob3r6pyPXvKduub/Lv1o3F@vger.kernel.org, AJvYcCXBlSADNV44UCzHQMJR1iuQeM+kC38rODP/AxsdCCcG8q6TnYwhfprQqdkcJld9xVAmXP1ilFQwHUyg@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZ6mYlNmd6E+IV3MOuJgTHoca580SWVIId+6TCrztK21XjGtZ
	fsF0Rm8JZbj9avlqC0VTTRaivaHo/ZuKxbdeZCZ0KD2+xiWSlvnF
X-Gm-Gg: ASbGnct5GJg6r29UELd98ydMYNhmREM/19/Diiz0k7z4BPIhQoMw1GIq65gOQbuZxzd
	eFvDu9g4MaSzoyPEJPv8BxYaJ0VDL3SZwpCa7vPsr1kTLvBEx6024EUZFi9I5unufILBtPF7p9V
	t9TjgfIklEQaK8pEN4tNAc2DzuYbATGROMBhHFjrYCwN4RnwPdhrg8rQSe1FnIESPYm8WmIViwh
	4k4EP0OGnBlKOeeURzf4G0/qg==
X-Google-Smtp-Source: AGHT+IErwkTb2U9Efp5mCCdhsG6WdY8uJNeNNmeH8rkm8IfjhzGl/5H0Bw1tGMv0fmFpUOT7L0GXHA==
X-Received: by 2002:a05:622a:1b0a:b0:460:77d0:c5c2 with SMTP id d75a77b69052e-46734f8556dmr237483571cf.36.1733732512903;
        Mon, 09 Dec 2024 00:21:52 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4676ba6eb1dsm3011151cf.1.2024.12.09.00.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:21:52 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
Date: Mon,  9 Dec 2024 16:21:30 +0800
Message-ID: <20241209082132.752775-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209082132.752775-1-inochiama@gmail.com>
References: <20241209082132.752775-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock controller on the SG2044 provides common clock function
for all IPs on the SoC. This device requires PLL clock to function
normally.

Add definition for the clock controller of the SG2044 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/clock/sophgo,sg2044-clk.yaml     |  40 +++++
 include/dt-bindings/clock/sophgo,sg2044-clk.h | 170 ++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
new file mode 100644
index 000000000000..d55c5d32e206
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2044 Clock Controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2044-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@50002000 {
+      compatible = "sophgo,sg2044-clk";
+      reg = <0x50002000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&osc>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2044-clk.h b/include/dt-bindings/clock/sophgo,sg2044-clk.h
new file mode 100644
index 000000000000..1da54354e5c3
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2044-clk.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
+#define __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
+
+#define CLK_FPLL0			0
+#define CLK_FPLL1			1
+#define CLK_FPLL2			2
+#define CLK_DPLL0			3
+#define CLK_DPLL1			4
+#define CLK_DPLL2			5
+#define CLK_DPLL3			6
+#define CLK_DPLL4			7
+#define CLK_DPLL5			8
+#define CLK_DPLL6			9
+#define CLK_DPLL7			10
+#define CLK_MPLL0			11
+#define CLK_MPLL1			12
+#define CLK_MPLL2			13
+#define CLK_MPLL3			14
+#define CLK_MPLL4			15
+#define CLK_MPLL5			16
+#define CLK_DIV_AP_SYS_FIXED		17
+#define CLK_DIV_AP_SYS_MAIN		18
+#define CLK_DIV_RP_SYS_FIXED		19
+#define CLK_DIV_RP_SYS_MAIN		20
+#define CLK_DIV_TPU_SYS_FIXED		21
+#define CLK_DIV_TPU_SYS_MAIN		22
+#define CLK_DIV_NOC_SYS_FIXED		23
+#define CLK_DIV_NOC_SYS_MAIN		24
+#define CLK_DIV_VC_SRC0_FIXED		25
+#define CLK_DIV_VC_SRC0_MAIN		26
+#define CLK_DIV_VC_SRC1_FIXED		27
+#define CLK_DIV_VC_SRC1_MAIN		28
+#define CLK_DIV_CXP_MAC_FIXED		29
+#define CLK_DIV_CXP_MAC_MAIN		30
+#define CLK_DIV_DDR0_FIXED		31
+#define CLK_DIV_DDR0_MAIN		32
+#define CLK_DIV_DDR1_FIXED		33
+#define CLK_DIV_DDR1_MAIN		34
+#define CLK_DIV_DDR2_FIXED		35
+#define CLK_DIV_DDR2_MAIN		36
+#define CLK_DIV_DDR3_FIXED		37
+#define CLK_DIV_DDR3_MAIN		38
+#define CLK_DIV_DDR4_FIXED		39
+#define CLK_DIV_DDR4_MAIN		40
+#define CLK_DIV_DDR5_FIXED		41
+#define CLK_DIV_DDR5_MAIN		42
+#define CLK_DIV_DDR6_FIXED		43
+#define CLK_DIV_DDR6_MAIN		44
+#define CLK_DIV_DDR7_FIXED		45
+#define CLK_DIV_DDR7_MAIN		46
+#define CLK_DIV_TOP_50M			47
+#define CLK_DIV_TOP_AXI0		48
+#define CLK_DIV_TOP_AXI_HSPERI		49
+#define CLK_DIV_TIMER0			50
+#define CLK_DIV_TIMER1			51
+#define CLK_DIV_TIMER2			52
+#define CLK_DIV_TIMER3			53
+#define CLK_DIV_TIMER4			54
+#define CLK_DIV_TIMER5			55
+#define CLK_DIV_TIMER6			56
+#define CLK_DIV_TIMER7			57
+#define CLK_DIV_CXP_TEST_PHY		58
+#define CLK_DIV_CXP_TEST_ETH_PHY	59
+#define CLK_DIV_C2C0_TEST_PHY		60
+#define CLK_DIV_C2C1_TEST_PHY		61
+#define CLK_DIV_PCIE_1G			62
+#define CLK_DIV_UART_500M		63
+#define CLK_DIV_GPIO_DB			64
+#define CLK_DIV_SD			65
+#define CLK_DIV_SD_100K			66
+#define CLK_DIV_EMMC			67
+#define CLK_DIV_EMMC_100K		68
+#define CLK_DIV_EFUSE			69
+#define CLK_DIV_TX_ETH0			70
+#define CLK_DIV_PTP_REF_I_ETH0		71
+#define CLK_DIV_REF_ETH0		72
+#define CLK_DIV_PKA			73
+#define CLK_MUX_DDR0			74
+#define CLK_MUX_DDR1			75
+#define CLK_MUX_DDR2			76
+#define CLK_MUX_DDR3			77
+#define CLK_MUX_DDR4			78
+#define CLK_MUX_DDR5			79
+#define CLK_MUX_DDR6			80
+#define CLK_MUX_DDR7			81
+#define CLK_MUX_NOC_SYS			82
+#define CLK_MUX_TPU_SYS			83
+#define CLK_MUX_RP_SYS			84
+#define CLK_MUX_AP_SYS			85
+#define CLK_MUX_VC_SRC0			86
+#define CLK_MUX_VC_SRC1			87
+#define CLK_MUX_CXP_MAC			88
+#define CLK_GATE_AP_SYS			89
+#define CLK_GATE_RP_SYS			90
+#define CLK_GATE_TPU_SYS		91
+#define CLK_GATE_NOC_SYS		92
+#define CLK_GATE_VC_SRC0		93
+#define CLK_GATE_VC_SRC1		94
+#define CLK_GATE_DDR0			95
+#define CLK_GATE_DDR1			96
+#define CLK_GATE_DDR2			97
+#define CLK_GATE_DDR3			98
+#define CLK_GATE_DDR4			99
+#define CLK_GATE_DDR5			100
+#define CLK_GATE_DDR6			101
+#define CLK_GATE_DDR7			102
+#define CLK_GATE_TOP_50M		103
+#define CLK_GATE_SC_RX			104
+#define CLK_GATE_SC_RX_X0Y1		105
+#define CLK_GATE_TOP_AXI0		106
+#define CLK_GATE_INTC0			107
+#define CLK_GATE_INTC1			108
+#define CLK_GATE_INTC2			109
+#define CLK_GATE_INTC3			110
+#define CLK_GATE_MAILBOX0		111
+#define CLK_GATE_MAILBOX1		112
+#define CLK_GATE_MAILBOX2		113
+#define CLK_GATE_MAILBOX3		114
+#define CLK_GATE_TOP_AXI_HSPERI		115
+#define CLK_GATE_APB_TIMER		116
+#define CLK_GATE_TIMER0			117
+#define CLK_GATE_TIMER1			118
+#define CLK_GATE_TIMER2			119
+#define CLK_GATE_TIMER3			120
+#define CLK_GATE_TIMER4			121
+#define CLK_GATE_TIMER5			122
+#define CLK_GATE_TIMER6			123
+#define CLK_GATE_TIMER7			124
+#define CLK_GATE_CXP_CFG		125
+#define CLK_GATE_CXP_MAC		126
+#define CLK_GATE_CXP_TEST_PHY		127
+#define CLK_GATE_CXP_TEST_ETH_PHY	128
+#define CLK_GATE_PCIE_1G		129
+#define CLK_GATE_C2C0_TEST_PHY		130
+#define CLK_GATE_C2C1_TEST_PHY		131
+#define CLK_GATE_UART_500M		132
+#define CLK_GATE_APB_UART		133
+#define CLK_GATE_APB_SPI		134
+#define CLK_GATE_AHB_SPIFMC		135
+#define CLK_GATE_APB_I2C		136
+#define CLK_GATE_AXI_DBG_I2C		137
+#define CLK_GATE_GPIO_DB		138
+#define CLK_GATE_APB_GPIO_INTR		139
+#define CLK_GATE_APB_GPIO		140
+#define CLK_GATE_SD			141
+#define CLK_GATE_AXI_SD			142
+#define CLK_GATE_SD_100K		143
+#define CLK_GATE_EMMC			144
+#define CLK_GATE_AXI_EMMC		145
+#define CLK_GATE_EMMC_100K		146
+#define CLK_GATE_EFUSE			147
+#define CLK_GATE_APB_EFUSE		148
+#define CLK_GATE_SYSDMA_AXI		149
+#define CLK_GATE_TX_ETH0		150
+#define CLK_GATE_AXI_ETH0		151
+#define CLK_GATE_PTP_REF_I_ETH0		152
+#define CLK_GATE_REF_ETH0		153
+#define CLK_GATE_APB_RTC		154
+#define CLK_GATE_APB_PWM		155
+#define CLK_GATE_APB_WDT		156
+#define CLK_GATE_AXI_SRAM		157
+#define CLK_GATE_AHB_ROM		158
+#define CLK_GATE_PKA			159
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2044_CLK_H__ */
-- 
2.47.1


