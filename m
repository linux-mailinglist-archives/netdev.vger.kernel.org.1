Return-Path: <netdev+bounces-184032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED5A92FAC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E3816ADA4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF8267AE9;
	Fri, 18 Apr 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Avm0KI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46449267736;
	Fri, 18 Apr 2025 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941824; cv=none; b=YeA+TKDkDfeG9aTqrScPgZEhcP1b+XXAUKiMcGQeEEWopHfZGbmT88gW0Sz3I37Xzpw22h96iwKRDy221GfE/DF2hfVqBlwJFFpfWQZaZTB+FktOf7W+aiqLpQ0wC16ENESBMQoV7vAZTjhlX/w6CS51LWE8KUgYeeubwIHN5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941824; c=relaxed/simple;
	bh=mwvwCmjbiXsu4nTgB43Qm+rnuOE7u8ttf2dzCpNyCIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaB+nDSbNMYDWJLNTTgICDGGnKdaGkPYYKx7wIGaz5wrebicUdKOPsmXaFPowd+2hYOdz5s82JKEQPnpTsJkDgJCpz1DFknB4D9SiCBdlnfG/gPpXppBATYxAD2GhAw+i2pidcDFOFzeEYw59ErJyKVih/Pu8jyX5xg1gJ+q83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Avm0KI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5f720c717so260882985a.0;
        Thu, 17 Apr 2025 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744941820; x=1745546620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDDlTSs/VGwQH9+y0CG3BqQMPXKKQfsmBI197rBvmx8=;
        b=K7Avm0KIqs+TeZmw8CmlWoGEZptM3hmChUhLHtH+WOzzN9IBHbvNJOuMspTnY5hPrN
         wwtKxA/fxmoKesnf5tfoQiPEjnzrmvzNA43tYZpjEz2fkfIe2HHMhqXp1gmSr2Dsv7cC
         K37/zXcol0RokR0eBx/n8LlUVwox2Fz5PeFa81z6DK01JsL0SqlElAwaHFlVIjchzLqm
         KRbLPa/Ot4v1Vv4ypn8+g3dVYk8KvFef6dQX5cmNYwI1NNeA6oC+1J2/C4w2IaqO+EC3
         G+VocG5O4LHw7/P54KuWvpteKaDbZQF+oNgJSv3wkl2grn0RYORDRgT8Z31BagNV/pF3
         66Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744941820; x=1745546620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDDlTSs/VGwQH9+y0CG3BqQMPXKKQfsmBI197rBvmx8=;
        b=mhUMoFVIPUa+zZkvRlnELxPA1sQxF5hLgYFdrrOP+64N3wecrkvjlGbwqQyvxQ7WDl
         /qpJ/FNJf62PhT+X8E/1CY+Ff4hVXDjmlgrGKylU5J9MbMSxxLsFtFGwso/7GN3rA4bA
         0TSEq2gxx7E2NUzWbcT/SUSXM5tK1eaFmfSF94z813MFbDABVUBJBUZ5nBffkgSbHkcx
         FNHJj5yR0pP2EmUdywKfO86Nb4hk53E8S/M32wju0zwL4KVKzDPzIdt1Z8y6a7lGg0ml
         5YoA9FGjUBxcCspI+QIiDAZEJD1IyOCg5bT7BaIN4Ec7/2tNo6iiPdBa6ffPH6/KrIfj
         48wg==
X-Forwarded-Encrypted: i=1; AJvYcCUGlCJHiaJiDFnD6v0GsyEDpmEwe3lOD9rE5aM62xrvqTLBfwROuj1/XX0qXHOqgjU3TcxSl7JIdpyS@vger.kernel.org, AJvYcCUbMZ3TV2EksQiIDAhS/YGS/wQk4M8u70XhcilSUZu8JDz+bV3BqwMOR/pytx0XqK+aKOhV1NlAlhyfSoTm@vger.kernel.org, AJvYcCXu56I5zPNtD0worh1AYSX3o71r1+eKvV9DpvmD4/IdsDsBp/CU3euw8ISGpXrEMcMxQdSMEYQO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QcrThZSGjamQEcOoqWF+8tfd6e0u6zcX0ryAnPnUZ0EWqUpV
	rxMuZ1caZRWtUK5mbRaqgPVUyqWnMLFeEwetDRcpwH0Hzp1O8SvV
X-Gm-Gg: ASbGncuXC6Yrz4P6C3OZRIS1NRVPpjB0avoSlIFNomKTmG1/KejRAsbt+wtmgsdvxRI
	7ncvgC3usS30duBAOVbGKd6f7IZqnQlZ7ishci4bh+4l8IDX34sJ40Rdqx/jVEBiOEualbLBpu/
	81CIJPMijyHNmQrHYrSf7CnsiwhpJOOWo+nWdirPfaQT9Xz8wHC5ci+/0+mdNA2SF+38r+YakUT
	9DnzDn1SIqDHMewmKjS6tMRENQXpJRokHrYne6qn0j2UFi+iv+SF3+zR0t7Fmvwn3EXlaqLcEma
	EbLOw3lrAhiX5ryXUN2Wof58xEo=
X-Google-Smtp-Source: AGHT+IFEjFny3a1X7qchHh6Dw4aN7uSJF2fHi9A/vFITik3oyjvzgZhup5MWE3SKXRVhwqPvt9BWGw==
X-Received: by 2002:a05:620a:2585:b0:7c5:9566:83dc with SMTP id af79cd13be357-7c928304215mr139063485a.25.1744941820021;
        Thu, 17 Apr 2025 19:03:40 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a8c9d9sm56741485a.27.2025.04.17.19.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:03:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/5] dt-bindings: clock: sophgo: add clock controller for SG2044
Date: Fri, 18 Apr 2025 10:03:22 +0800
Message-ID: <20250418020325.421257-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>
References: <20250418020325.421257-1-inochiama@gmail.com>
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
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/sophgo,sg2044-clk.yaml     |  99 ++++++++++++
 include/dt-bindings/clock/sophgo,sg2044-clk.h | 153 ++++++++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
new file mode 100644
index 000000000000..272e58bdb62c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
@@ -0,0 +1,99 @@
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
+description: |
+  The Sophgo SG2044 clock controller requires an external oscillator
+  as input clock.
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/sophgo,sg2044-clk.h
+
+properties:
+  compatible:
+    const: sophgo,sg2044-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: fpll0
+      - description: fpll1
+      - description: fpll2
+      - description: dpll0
+      - description: dpll1
+      - description: dpll2
+      - description: dpll3
+      - description: dpll4
+      - description: dpll5
+      - description: dpll6
+      - description: dpll7
+      - description: mpll0
+      - description: mpll1
+      - description: mpll2
+      - description: mpll3
+      - description: mpll4
+      - description: mpll5
+
+  clock-names:
+    items:
+      - const: fpll0
+      - const: fpll1
+      - const: fpll2
+      - const: dpll0
+      - const: dpll1
+      - const: dpll2
+      - const: dpll3
+      - const: dpll4
+      - const: dpll5
+      - const: dpll6
+      - const: dpll7
+      - const: mpll0
+      - const: mpll1
+      - const: mpll2
+      - const: mpll3
+      - const: mpll4
+      - const: mpll5
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
+    #include <dt-bindings/clock/sophgo,sg2044-pll.h>
+
+    clock-controller@50002000 {
+      compatible = "sophgo,sg2044-clk";
+      reg = <0x50002000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&syscon CLK_FPLL0>, <&syscon CLK_FPLL1>,
+               <&syscon CLK_FPLL2>, <&syscon CLK_DPLL0>,
+               <&syscon CLK_DPLL1>, <&syscon CLK_DPLL2>,
+               <&syscon CLK_DPLL3>, <&syscon CLK_DPLL4>,
+               <&syscon CLK_DPLL5>, <&syscon CLK_DPLL6>,
+               <&syscon CLK_DPLL7>, <&syscon CLK_MPLL0>,
+               <&syscon CLK_MPLL1>, <&syscon CLK_MPLL2>,
+               <&syscon CLK_MPLL3>, <&syscon CLK_MPLL4>,
+               <&syscon CLK_MPLL5>;
+      clock-names = "fpll0", "fpll1", "fpll2", "dpll0",
+                    "dpll1", "dpll2", "dpll3", "dpll4",
+                    "dpll5", "dpll6", "dpll7", "mpll0",
+                    "mpll1", "mpll2", "mpll3", "mpll4",
+                    "mpll5";
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2044-clk.h b/include/dt-bindings/clock/sophgo,sg2044-clk.h
new file mode 100644
index 000000000000..d9adca42548e
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2044-clk.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
+#define __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
+
+#define CLK_DIV_AP_SYS_FIXED		0
+#define CLK_DIV_AP_SYS_MAIN		1
+#define CLK_DIV_RP_SYS_FIXED		2
+#define CLK_DIV_RP_SYS_MAIN		3
+#define CLK_DIV_TPU_SYS_FIXED		4
+#define CLK_DIV_TPU_SYS_MAIN		5
+#define CLK_DIV_NOC_SYS_FIXED		6
+#define CLK_DIV_NOC_SYS_MAIN		7
+#define CLK_DIV_VC_SRC0_FIXED		8
+#define CLK_DIV_VC_SRC0_MAIN		9
+#define CLK_DIV_VC_SRC1_FIXED		10
+#define CLK_DIV_VC_SRC1_MAIN		11
+#define CLK_DIV_CXP_MAC_FIXED		12
+#define CLK_DIV_CXP_MAC_MAIN		13
+#define CLK_DIV_DDR0_FIXED		14
+#define CLK_DIV_DDR0_MAIN		15
+#define CLK_DIV_DDR1_FIXED		16
+#define CLK_DIV_DDR1_MAIN		17
+#define CLK_DIV_DDR2_FIXED		18
+#define CLK_DIV_DDR2_MAIN		19
+#define CLK_DIV_DDR3_FIXED		20
+#define CLK_DIV_DDR3_MAIN		21
+#define CLK_DIV_DDR4_FIXED		22
+#define CLK_DIV_DDR4_MAIN		23
+#define CLK_DIV_DDR5_FIXED		24
+#define CLK_DIV_DDR5_MAIN		25
+#define CLK_DIV_DDR6_FIXED		26
+#define CLK_DIV_DDR6_MAIN		27
+#define CLK_DIV_DDR7_FIXED		28
+#define CLK_DIV_DDR7_MAIN		29
+#define CLK_DIV_TOP_50M			30
+#define CLK_DIV_TOP_AXI0		31
+#define CLK_DIV_TOP_AXI_HSPERI		32
+#define CLK_DIV_TIMER0			33
+#define CLK_DIV_TIMER1			34
+#define CLK_DIV_TIMER2			35
+#define CLK_DIV_TIMER3			36
+#define CLK_DIV_TIMER4			37
+#define CLK_DIV_TIMER5			38
+#define CLK_DIV_TIMER6			39
+#define CLK_DIV_TIMER7			40
+#define CLK_DIV_CXP_TEST_PHY		41
+#define CLK_DIV_CXP_TEST_ETH_PHY	42
+#define CLK_DIV_C2C0_TEST_PHY		43
+#define CLK_DIV_C2C1_TEST_PHY		44
+#define CLK_DIV_PCIE_1G			45
+#define CLK_DIV_UART_500M		46
+#define CLK_DIV_GPIO_DB			47
+#define CLK_DIV_SD			48
+#define CLK_DIV_SD_100K			49
+#define CLK_DIV_EMMC			50
+#define CLK_DIV_EMMC_100K		51
+#define CLK_DIV_EFUSE			52
+#define CLK_DIV_TX_ETH0			53
+#define CLK_DIV_PTP_REF_I_ETH0		54
+#define CLK_DIV_REF_ETH0		55
+#define CLK_DIV_PKA			56
+#define CLK_MUX_DDR0			57
+#define CLK_MUX_DDR1			58
+#define CLK_MUX_DDR2			59
+#define CLK_MUX_DDR3			60
+#define CLK_MUX_DDR4			61
+#define CLK_MUX_DDR5			62
+#define CLK_MUX_DDR6			63
+#define CLK_MUX_DDR7			64
+#define CLK_MUX_NOC_SYS			65
+#define CLK_MUX_TPU_SYS			66
+#define CLK_MUX_RP_SYS			67
+#define CLK_MUX_AP_SYS			68
+#define CLK_MUX_VC_SRC0			69
+#define CLK_MUX_VC_SRC1			70
+#define CLK_MUX_CXP_MAC			71
+#define CLK_GATE_AP_SYS			72
+#define CLK_GATE_RP_SYS			73
+#define CLK_GATE_TPU_SYS		74
+#define CLK_GATE_NOC_SYS		75
+#define CLK_GATE_VC_SRC0		76
+#define CLK_GATE_VC_SRC1		77
+#define CLK_GATE_DDR0			78
+#define CLK_GATE_DDR1			79
+#define CLK_GATE_DDR2			80
+#define CLK_GATE_DDR3			81
+#define CLK_GATE_DDR4			82
+#define CLK_GATE_DDR5			83
+#define CLK_GATE_DDR6			84
+#define CLK_GATE_DDR7			85
+#define CLK_GATE_TOP_50M		86
+#define CLK_GATE_SC_RX			87
+#define CLK_GATE_SC_RX_X0Y1		88
+#define CLK_GATE_TOP_AXI0		89
+#define CLK_GATE_INTC0			90
+#define CLK_GATE_INTC1			91
+#define CLK_GATE_INTC2			92
+#define CLK_GATE_INTC3			93
+#define CLK_GATE_MAILBOX0		94
+#define CLK_GATE_MAILBOX1		95
+#define CLK_GATE_MAILBOX2		96
+#define CLK_GATE_MAILBOX3		97
+#define CLK_GATE_TOP_AXI_HSPERI		98
+#define CLK_GATE_APB_TIMER		99
+#define CLK_GATE_TIMER0			100
+#define CLK_GATE_TIMER1			101
+#define CLK_GATE_TIMER2			102
+#define CLK_GATE_TIMER3			103
+#define CLK_GATE_TIMER4			104
+#define CLK_GATE_TIMER5			105
+#define CLK_GATE_TIMER6			106
+#define CLK_GATE_TIMER7			107
+#define CLK_GATE_CXP_CFG		108
+#define CLK_GATE_CXP_MAC		109
+#define CLK_GATE_CXP_TEST_PHY		110
+#define CLK_GATE_CXP_TEST_ETH_PHY	111
+#define CLK_GATE_PCIE_1G		112
+#define CLK_GATE_C2C0_TEST_PHY		113
+#define CLK_GATE_C2C1_TEST_PHY		114
+#define CLK_GATE_UART_500M		115
+#define CLK_GATE_APB_UART		116
+#define CLK_GATE_APB_SPI		117
+#define CLK_GATE_AHB_SPIFMC		118
+#define CLK_GATE_APB_I2C		119
+#define CLK_GATE_AXI_DBG_I2C		120
+#define CLK_GATE_GPIO_DB		121
+#define CLK_GATE_APB_GPIO_INTR		122
+#define CLK_GATE_APB_GPIO		123
+#define CLK_GATE_SD			124
+#define CLK_GATE_AXI_SD			125
+#define CLK_GATE_SD_100K		126
+#define CLK_GATE_EMMC			127
+#define CLK_GATE_AXI_EMMC		128
+#define CLK_GATE_EMMC_100K		129
+#define CLK_GATE_EFUSE			130
+#define CLK_GATE_APB_EFUSE		131
+#define CLK_GATE_SYSDMA_AXI		132
+#define CLK_GATE_TX_ETH0		133
+#define CLK_GATE_AXI_ETH0		134
+#define CLK_GATE_PTP_REF_I_ETH0		135
+#define CLK_GATE_REF_ETH0		136
+#define CLK_GATE_APB_RTC		137
+#define CLK_GATE_APB_PWM		138
+#define CLK_GATE_APB_WDT		139
+#define CLK_GATE_AXI_SRAM		140
+#define CLK_GATE_AHB_ROM		141
+#define CLK_GATE_PKA			142
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2044_CLK_H__ */
-- 
2.49.0


