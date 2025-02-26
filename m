Return-Path: <netdev+bounces-170033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E081A46F57
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 00:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771A816AD40
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936A25E81D;
	Wed, 26 Feb 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv9FKHaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540C25DD1A;
	Wed, 26 Feb 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612231; cv=none; b=dpUkzUEH4yq/0SuhF0/6nF52oUXP31i216TsLm98/X0Be9mfga1pMFFRpAxudpF6fBn3MZe1BrOc+0ucKkAA15wZLPBsW8dI/qF7K2aLzh8/Om1MTmh337fahLCo9dexem/7oMTPWu4LM0JEjERmi+W43hNBCnl+AzVNcZ+r9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612231; c=relaxed/simple;
	bh=W9UOtlGwWIK3N2S4o4LjNzuK9cGXGZBDY5zm6seyjXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8J0Z0Lrzpej5H+nngCsU2Z0b1kYitiS7pfxNZAbvRJa4lRMqYMBu5ndjDcDzmNM9SrIjo3eLFRonc9pBbmTBpNol0bg4bYKDhURLzGgDO9Sr8aCQksSq9DAFdm8BekS2XM6Er0y2IsK+scsGpjCCUg4rvDdapdDe4iY/WpmXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv9FKHaN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c089b2e239so42164585a.0;
        Wed, 26 Feb 2025 15:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740612229; x=1741217029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohwwvHcdRfCz5Tmjdrotz9z6I/5PmjKMye5D/1vf6F0=;
        b=Hv9FKHaNPs+wnHRve3bfu6fpXo2vWm/VeymY7FjnRA0At3iPyvQ9kBPgVUYIvnvC+I
         Ymwjbq0C4TjvWBijwc7hrMeCJIi+wXDdlr6ocrprD0vH94aJTi23x9b6ydElo5Jmmwge
         rqUs0SvUYUcIJZYmnrtinmPah6VxVg7B9k0jUK5AE2tzvn3cbl1VhO8E6r+d4JgzweGL
         p3E4UwBc64r5/rkyvKvAPiqav/ph8200n9U1049VuDIgU5C9jC3yH0cMhstPhW+ofrcI
         0EZtxC1fkXAdzaGyR/z085DZbXkhuC6bjHd85uJjHYZnQLHNd5AurZoyp/NKXo2nZt9t
         jjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740612229; x=1741217029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohwwvHcdRfCz5Tmjdrotz9z6I/5PmjKMye5D/1vf6F0=;
        b=VUT3A3Nr25CTPCqfcHTTPa6UN30JUfDrRDjtHs1PBdtMV3hIOdCQ1Fb2OphxcaWw6k
         HsGr938zs1tbLXEUc4gzwPdqqAu1SzWMRHJjCDVG+FeWjZoKPqWnlzS0QYicxHbRs858
         MWmv0EBc9+jz+wTqsJXDQ8xyyScZCelC95B7pY4zyigBgQTL7KQexHp+3U0KlO9Sjdqc
         WRMW3Feb//G2dy2O+alh/kUFhCS7+btj1rb9MLvV2k9z1YviYXkai3I58rznEpaMlFHl
         V0qGylTnoQdKL0eisB2SV6wfrmC8aVF9Z9JExdg8pFPe2dKfqtUNYkRhBUlOwrzJqLaO
         wxnA==
X-Forwarded-Encrypted: i=1; AJvYcCUGsC7u7ml0nVWUZyuwaRsaS6ZS49y6XakGjoMAGrO3Ws7zzjliedeAr90iOnJZx7jCPtLQxUFKOs0N@vger.kernel.org, AJvYcCWpDV/aXdUsoQvkJ834l58+9fpsWkDylOddXP+po2+sGzauv0Or2Y33fCs9dTVxwiE2eKvBIDmUJ9zVwd3T@vger.kernel.org, AJvYcCXKO/Cj0pZxqQOFFCC+ools2AYvnAkwLMGAy/Xq5ej4O7147Sg+mqe/W/Gq1ZMqjiCw++a9yRu/@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFuQCKfz/7Or2Jb5N6QhK2rhFbxVNFvq3BYdOKB0EDBho4VjD
	yg5lgReN5wS+VFFAJ1nSYulE1eDDgHJ/JQH3aYsdh19X5ea+By58
X-Gm-Gg: ASbGncuZ23fyC5q0kTmnxTOXThd3WgYvf7DY8r2zvaqTWaFQiKAEtg/8+3+hMDgE/Sy
	e8ZKaUug3bj2UMyP+6+89Eo/P5NftZMXAP4cOBaI8G2UcfejkAKZdOswRV+pUunqfgXQXYpTbkm
	B/S310GBKF/3S16Tv7s7ChiIiL/jl1ui2xqTtqSj2SsSHKJwu9QRaQfp4EnkAJQAg8Az6P6wWeD
	XRumc/nbsTM8f2R4llY8hVcYIJKlmANwn5J6ZKTigF99MnWv4DwTmYv4ppPKieMsP9aUQCCqBJs
	Gw==
X-Google-Smtp-Source: AGHT+IHikxm+nmCYj8S8OUriXacgBcvC8EgA2lwQ61Z7MkJBuTeYR2oL7y5t4ggjNNiEj8M6XAba3w==
X-Received: by 2002:a05:620a:3913:b0:7be:513c:3371 with SMTP id af79cd13be357-7c29f441232mr152429085a.14.1740612228604;
        Wed, 26 Feb 2025 15:23:48 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c378d9fec4sm20672085a.67.2025.02.26.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:23:48 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
Date: Thu, 27 Feb 2025 07:23:18 +0800
Message-ID: <20250226232320.93791-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226232320.93791-1-inochiama@gmail.com>
References: <20250226232320.93791-1-inochiama@gmail.com>
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
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
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


