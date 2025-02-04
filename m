Return-Path: <netdev+bounces-162425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD6A26D8A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21091642A6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA8207A08;
	Tue,  4 Feb 2025 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYNDOBQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A613D8A4;
	Tue,  4 Feb 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658787; cv=none; b=FCkZyPpRDde8UZ11gvKNNdcb2cMjhzKlSfEKz8g5QuAdo+GkAMH2LMdf9EmUO+0FhV0RfpDZ2d3EBD9DRm7+yCuvWOaJSqIZdeDk8Y/Ho6SLCQciUrfncmPmaAImUsAFlMTKdGrfPfVtayQY7rHSQ8xITdNR1+NBWXkwkgT2nvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658787; c=relaxed/simple;
	bh=tr73zpG9wMvJDJEfNndPpHPh4zJJAvZWh/Eok2CIUKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQBj4TF1Ra1xldFWa150VD0Mn4JiccxnK5q3J2R/Nij5fMcl/THWpTRf5q1BHrxkAaYbyJzLQfhbqCDPX1E5MqtSRxsjCJzIvtCka2AldD6v+1GQXgZ+rIyH7iRPG2Q23tjaJQuua/RNnMzei8beKlcr7K7YzDxxJ3qTPUczz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYNDOBQv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ef047e9bso476367385a.1;
        Tue, 04 Feb 2025 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738658784; x=1739263584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkxNcDUZCLc17ZHC7CeqgZT5DUm+0/ssYjOEWkLi8Qc=;
        b=ZYNDOBQvTh0b5urO2vGshTiv+9q/r4IMEjFnZpEaMZhEXzgPOxUYSVF9zx2xLXKQ0g
         jQ37g+wZZ+PXVlkDqSHXVLU6Xwh0y0r1NOzjweeDGOnItX2UYYJrkJdp+KzEzri1W9t3
         XUmE1xqnszhAZaKPuKrtY0cQ+x0jyG7lzaJR/nK29FOvm8eAlmGRcs6dfEFt1t6mJVEb
         GD7gPc4+GN3UwAJ7MQVGxN6VWjhWrfI0Xw8RLkix5NPnyVeGQHVWKxfD4vk3oCOZv9n2
         68MOijhAel5g3RNj5e+ZmCckx584WLeyyka0l0rWTcHS8scEniGdDE9Zx1nCUAEf6mBX
         YbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658784; x=1739263584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkxNcDUZCLc17ZHC7CeqgZT5DUm+0/ssYjOEWkLi8Qc=;
        b=ka6iVBD3r5vthMK2KsZ5avSOk62vqlV5SizR94Yc6Negjbj/FDFsuLbVmChVr4QcPG
         ZvdLG/DIqmFBVo7St6HCIKvmmIsiFsfSXPTaEKB2eZmqJBikrpAVesJQDt8Bb2/r0YN/
         OHZUrURNfLiM8EAqLBGT06DB8Vy2hFj+koZ/uMmXoNcZhBBv+ctv+8HfRK0ip8n/6xHL
         yfEuS/F8RA9eSwcC5SHLU7m+bYXd9EisfDy0K75OAbO30iLyMu2XHVLWlJN3X5YFa/WO
         ESp5XW6G+alq0umdkgORZYLzl6C4vuIoFqvE7WoMW1/dN2rFPcJlO8pjwXlU9+hWULGP
         CTLg==
X-Forwarded-Encrypted: i=1; AJvYcCU9pHayZwfkl6HHaZ+ODcVsZEm/3svF2/mrAdVI+ZcG9WT7eL7tN9UmnbUVVcUwwPXyqrr9rzoC@vger.kernel.org, AJvYcCUAweSuFnpFJg5/inQgetiejrWCkfbFaHeNI0Utp0eZsq68vW9kETT02Q+Hrvvb745gtRy0Hc/SMJmf@vger.kernel.org, AJvYcCUnLH63WCaFdP1xVGTHjBBLvcPEkB90i58Ac6DzijtV+C6tuZn21fsF8Ggk8Ko8KOT3NJILvFgVheen@vger.kernel.org, AJvYcCW3aljsvZD61G5oxCPmk08ZI6YtP43OFKbS6MacUVtpCIh/3nbrIWxu5VRnWhHp6ij8eXW7vhV1x8o7Ha+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8GEdZG77YMXTzD1VvAq1lbG8FFTqbzn+7qt+r661U6+EHMll
	po2pWp7Jsju7MTVoKZy/GQ5Z92hBmMnQNtk9mJEV4HyLHCEomvay
X-Gm-Gg: ASbGncvDP0Nd7Z4ZenlbKXgmttsHGyNeVry9Gq7kRbZeBUox46BCSjLZclt4IJJijSL
	rDog+7OEIbhSfsF/qD5jRHpV/1jnKWj2ZV1sPSHx4AloA46+7DsaS6arO8AQRJmL5M2oz4YXek3
	uLoOxiMJqA7mFBKcP5ZNXj2PWpXrs9TONQXCsURVUCkb7cRoNS8vVARXEnae+QqfTyJTApmnOse
	OehGRSHRmH0O58gPPb2QAEN68x1CN80t1POgi+wSN6GfT6aHN0BNd84+IGT9PWDZr0=
X-Google-Smtp-Source: AGHT+IFwKJrdt/0/5/WdQImU+E5MBvNv8OP4XLyfq1l724IpjhR4dNMQpTRrEdprH3ibuG8gxflfVQ==
X-Received: by 2002:a05:620a:25d2:b0:7b8:5511:f72d with SMTP id af79cd13be357-7c02ec4a30emr386163485a.17.1738658782367;
        Tue, 04 Feb 2025 00:46:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c00a90d0b4sm620046085a.105.2025.02.04.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:46:21 -0800 (PST)
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
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
Date: Tue,  4 Feb 2025 16:44:34 +0800
Message-ID: <20250204084439.1602440-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204084439.1602440-1-inochiama@gmail.com>
References: <20250204084439.1602440-1-inochiama@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.48.1


