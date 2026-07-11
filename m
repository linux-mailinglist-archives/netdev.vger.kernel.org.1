Return-Path: <netdev+bounces-306763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2nifIor7UWpELAMAu9opvQ
	(envelope-from <netdev+bounces-306763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C845E740DFB
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b=NYRwLF7E;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306763-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306763-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7367E302BE27
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FB3815F0;
	Sat, 11 Jul 2026 08:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041E371D13;
	Sat, 11 Jul 2026 08:12:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757545; cv=pass; b=S857q4RH+ooyAkVlBFeBqJLQtzbi1de/b7QxEXUcCy9FfqnrQD4uxBseuAsOKu7G3wgec8kMT5rC6sCyBEbGaEZiH1iMX+YRUgD5kRqfd0yNN/DUXY50nWZpp5nq2npWHxPKZzIxF10Bj6O1MnnLcboimcaQ0K/YwS0B47DkG8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757545; c=relaxed/simple;
	bh=GOZSdvZ0QOXViH7vW17myvfMX3idmefcRmwpx/SaQHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+XYP+azC/clVvsyKtCa8SXwr4axTWQ66zrJ/Oaj4ro90Wyb4bJnKdHdKMKH7G9rZMpen3CKXhPQdnBem0pIVFbZXdJ3oARB9EkUFcuXk+/+2684gmrVpVuvS6g4lE83ajmRDXaqQfagTN52XREgRXMeuleBXuD9M5zaFgcBCAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=NYRwLF7E; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal: i=1; a=rsa-sha256; t=1783757520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UeywxGNjySLZAEXoSn6zSQV9BsiUeE37JKbhApjSlz+6T9uJbRvSt3lnY8PRZj5c56wqYOLVNVUdWmamDBkxXOEj/Or3loAUMBgQWbFBsEp1hR9PXWYwS0wKkOICeMUyqCdohZgELDmJ91IQ+f+RaD3TpL2z7doUpg288/7ScII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783757520; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xz/aGjNuRnYA+ZWsqIc7JQ5KeBBkSRQvkWxtR/cpbHQ=; 
	b=mzuNni7cZtZuyGX4TaA0hsgD0ZsAvXURDA/LEcOMAvunWQsz6Sbcpv+C0IIi1clw+qPdjjcjSPy+D6LmLdnQ1TwlWTu96gKFb3gnu4EYAzQJIAO63/AQn5Ra4cYQ9bnlzw+FZG7S98C5oW0HNVx6b4VHjHkaXN6C8Txwzh2or9s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783757520;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Xz/aGjNuRnYA+ZWsqIc7JQ5KeBBkSRQvkWxtR/cpbHQ=;
	b=NYRwLF7EOgt/sxidM7noapUse4fzNSUNIcBWAQ0o6dS0fq7HIew2CZHTvH2Jd8c5
	DUy2lGGo4WQuzWv4caXMiXCPqdNux4oANy8raAFrSeeFdNkvntGQ+yoVts2IfHYgbcg
	nLuQimqBywsqFJWEY2I0oOPHayPs5dcGmtQXaK0g=
Received: by mx.zohomail.com with SMTPS id 1783757519066382.70390156569795;
	Sat, 11 Jul 2026 01:11:59 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 11 Jul 2026 16:10:30 +0800
Subject: [PATCH v2 4/8] clk: sunxi-ng: a733: Add PLL clocks support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-a733-clk-v2-4-974d188cbe0c@pigmoral.tech>
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
In-Reply-To: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783757449; l=21705;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=GOZSdvZ0QOXViH7vW17myvfMX3idmefcRmwpx/SaQHA=;
 b=L9K4Re+kgDYKs331eSVppV6WVGZ3FkezxxsCoLZG3y7qbb3pLdX7HcjQrmg6ZSaq7weODu+/6
 1qqnjyO6HKqCAgrN56G8DNyUhwG04Ul/DiCgxQpCvNh4NFYRYT4UnHY
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:junhui.liu@pigmoral.tech,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pigmoral.tech];
	FORGED_SENDER(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306763-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[allwinnertech.com:email,baylibre.com:email,pigmoral.tech:from_mime,pigmoral.tech:email,pigmoral.tech:mid,pigmoral.tech:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C845E740DFB

Add PLL clock support for the main CCU of the Allwinner A733 SoC. The
structure is mostly similar to the sun55i, with the addition of a
PLL_REF clock that normalizes the hardware-detected DCXO/hosc frequency
(19.2MHz, 24MHz, or 26MHz) into a consistent 24MHz reference for all
subsequent PLLs.

The behaviors of PLL_AUDIO0 and PLL_AUDIO1 are ported from the vendor
driver. Specifically, PLL_AUDIO0 is configured with SDM parameters to
provide a 22.5792MHz * 4 output, while PLL_AUDIO1 is integrated into
the main CCU without using SDM.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/Kconfig           |   5 +
 drivers/clk/sunxi-ng/Makefile          |   2 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 539 +++++++++++++++++++++++++++++++++
 3 files changed, 546 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 202e793dc754..cffa83056934 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -67,6 +67,11 @@ config SUN55I_A523_R_CCU
 	default ARCH_SUNXI
 	depends on ARM64 || COMPILE_TEST
 
+config SUN60I_A733_CCU
+	tristate "Support for the Allwinner A733 CCU"
+	default ARCH_SUNXI
+	depends on ARM64 || COMPILE_TEST
+
 config SUN60I_A733_R_CCU
 	tristate "Support for the Allwinner A733 PRCM CCU"
 	default ARCH_SUNXI
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index d3702bdb7a23..3a39eb9287da 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
 obj-$(CONFIG_SUN55I_A523_CCU)	+= sun55i-a523-ccu.o
 obj-$(CONFIG_SUN55I_A523_MCU_CCU)	+= sun55i-a523-mcu-ccu.o
 obj-$(CONFIG_SUN55I_A523_R_CCU)	+= sun55i-a523-r-ccu.o
+obj-$(CONFIG_SUN60I_A733_CCU)	+= sun60i-a733-ccu.o
 obj-$(CONFIG_SUN60I_A733_R_CCU)	+= sun60i-a733-r-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
@@ -65,6 +66,7 @@ sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
 sun55i-a523-ccu-y		+= ccu-sun55i-a523.o
 sun55i-a523-mcu-ccu-y		+= ccu-sun55i-a523-mcu.o
 sun55i-a523-r-ccu-y		+= ccu-sun55i-a523-r.o
+sun60i-a733-ccu-y		+= ccu-sun60i-a733.o
 sun60i-a733-r-ccu-y		+= ccu-sun60i-a733-r.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
new file mode 100644
index 000000000000..f80db6ab1a98
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 rengaomin@allwinnertech.com
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Based on the A523 CCU driver:
+ *   Copyright (C) 2023-2024 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/sun60i-a733-ccu.h>
+#include <dt-bindings/reset/sun60i-a733-ccu.h>
+
+#include "../clk.h"
+
+#include "ccu_common.h"
+
+#include "ccu_div.h"
+#include "ccu_mult.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+/*
+ * The DCXO oscillator, the root of most of the clock tree, which may be
+ * 19.2MHz, 24MHz, or 26MHz.
+ */
+static const struct clk_parent_data hosc[] = {
+	{ .fw_name = "hosc" }
+};
+
+/**************************************************************************
+ *                              PLLs                                      *
+ **************************************************************************/
+
+/*
+ * Undocumented, taken from the vendor kernel.
+ * PLL_REF normalizes the DCXO frequency to a 24MHz reference for downstream
+ * PLLs.
+ */
+#define SUN60I_A733_PLL_REF_REG		0x000
+static struct ccu_nkmp pll_ref_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT(8, 8),
+	.m		= _SUNXI_CCU_DIV(16, 7), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_REF_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-ref", hosc,
+							   &ccu_nkmp_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+/*
+ * Most clock-defining macros expect an *array* of parent clocks, even if
+ * they do not contain a muxer to select between different parents.
+ * The macros ending in just _HW take a simple clock pointer, but then create
+ * a single-entry array out of that. The macros using _HWS take such an
+ * array (even when it is a single entry one), this avoids having those
+ * helper arrays created inside *every* clock definition.
+ * This means for every clock that is referenced more than once it is
+ * useful to create such a dummy array and use _HWS.
+ */
+static const struct clk_hw *pll_ref_hws[] = {
+	&pll_ref_clk.common.hw
+};
+
+#define SUN60I_A733_PLL_DDR_REG		0x020
+static struct ccu_nkmp pll_ddr_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_DDR_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ddr", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE |
+							 CLK_IS_CRITICAL),
+	},
+};
+
+/*
+ * There is no actual clock output with that frequency (2.4 GHz), instead it
+ * has multiple outputs with adjustable dividers from that base frequency.
+ * Model them separately as divider clocks based on that parent here.
+ */
+#define SUN60I_A733_PLL_PERIPH0_REG	0x0a0
+static struct ccu_nm pll_periph0_4x_clk = {
+	.enable		= BIT(25) | BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_PERIPH0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-periph0-4x",
+							 pll_ref_hws, &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_periph0_4x_hws[] = {
+	&pll_periph0_4x_clk.common.hw
+};
+
+static SUNXI_CCU_M_HWS(pll_periph0_2x_clk, "pll-periph0-2x", pll_periph0_4x_hws,
+		       SUN60I_A733_PLL_PERIPH0_REG, 20, 3, 0);
+static const struct clk_hw *pll_periph0_2x_hws[] = {
+	&pll_periph0_2x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_periph0_800M_clk, "pll-periph0-800M", pll_periph0_4x_hws,
+		       SUN60I_A733_PLL_PERIPH0_REG, 16, 3, 0);
+static SUNXI_CCU_M_HWS(pll_periph0_480M_clk, "pll-periph0-480M", pll_periph0_4x_hws,
+		       SUN60I_A733_PLL_PERIPH0_REG, 2, 3, 0);
+static const struct clk_hw *pll_periph0_480M_hws[] = {
+	&pll_periph0_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_600M_clk, "pll-periph0-600M",
+			    pll_periph0_2x_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_400M_clk, "pll-periph0-400M",
+			    pll_periph0_2x_hws, 3, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_300M_clk, "pll-periph0-300M",
+			    pll_periph0_2x_hws, 4, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
+			    pll_periph0_2x_hws, 6, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
+			    pll_periph0_2x_hws, 8, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
+			    pll_periph0_480M_hws, 3, 1, 0);
+
+#define SUN60I_A733_PLL_PERIPH1_REG	0x0c0
+static struct ccu_nm pll_periph1_4x_clk = {
+	.enable		= BIT(25) | BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_PERIPH1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-periph1-4x",
+							 pll_ref_hws, &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_periph1_4x_hws[] = {
+	&pll_periph1_4x_clk.common.hw
+};
+
+static SUNXI_CCU_M_HWS(pll_periph1_2x_clk, "pll-periph1-2x", pll_periph1_4x_hws,
+		       SUN60I_A733_PLL_PERIPH1_REG, 20, 3, 0);
+static const struct clk_hw *pll_periph1_2x_hws[] = {
+	&pll_periph1_2x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_periph1_800M_clk, "pll-periph1-800M", pll_periph1_4x_hws,
+		       SUN60I_A733_PLL_PERIPH1_REG, 16, 3, 0);
+static SUNXI_CCU_M_HWS(pll_periph1_480M_clk, "pll-periph1-480M", pll_periph1_4x_hws,
+		       SUN60I_A733_PLL_PERIPH1_REG, 2, 3, 0);
+static const struct clk_hw *pll_periph1_480M_hws[] = {
+	&pll_periph1_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_600M_clk, "pll-periph1-600M",
+			    pll_periph1_2x_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_400M_clk, "pll-periph1-400M",
+			    pll_periph1_2x_hws, 3, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_300M_clk, "pll-periph1-300M",
+			    pll_periph1_2x_hws, 4, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_200M_clk, "pll-periph1-200M",
+			    pll_periph1_2x_hws, 6, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_150M_clk, "pll-periph1-150M",
+			    pll_periph1_2x_hws, 8, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_160M_clk, "pll-periph1-160M",
+			    pll_periph1_480M_hws, 3, 1, 0);
+
+#define SUN60I_A733_PLL_GPU_REG		0x0e0
+static struct ccu_nkmp pll_gpu0_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_GPU_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-gpu0", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_VIDEO0_REG	0x120
+static struct ccu_nm pll_video0_12x_clk = {
+	.enable		= BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video0-12x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video0_12x_hws[] = {
+	&pll_video0_12x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video0_4x_clk, "pll-video0-4x", pll_video0_12x_hws,
+		       SUN60I_A733_PLL_VIDEO0_REG, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_video0_3x_clk, "pll-video0-3x", pll_video0_12x_hws,
+		       SUN60I_A733_PLL_VIDEO0_REG, 16, 3, 0);
+
+#define SUN60I_A733_PLL_VIDEO1_REG	0x140
+static struct ccu_nm pll_video1_12x_clk = {
+	.enable		= BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video1-12x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video1_12x_hws[] = {
+	&pll_video1_12x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video1_4x_clk, "pll-video1-4x", pll_video1_12x_hws,
+		       SUN60I_A733_PLL_VIDEO1_REG, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_video1_3x_clk, "pll-video1-3x", pll_video1_12x_hws,
+		       SUN60I_A733_PLL_VIDEO1_REG, 16, 3, 0);
+
+#define SUN60I_A733_PLL_VIDEO2_REG	0x160
+static struct ccu_nm pll_video2_12x_clk = {
+	.enable		= BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO2_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video2-12x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video2_12x_hws[] = {
+	&pll_video2_12x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video2_4x_clk, "pll-video2-4x", pll_video2_12x_hws,
+		       SUN60I_A733_PLL_VIDEO2_REG, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_video2_3x_clk, "pll-video2-3x", pll_video2_12x_hws,
+		       SUN60I_A733_PLL_VIDEO2_REG, 16, 3, 0);
+
+#define SUN60I_A733_PLL_VE0_REG		0x220
+static struct ccu_nkmp pll_ve0_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VE0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ve0", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_VE1_REG		0x240
+static struct ccu_nkmp pll_ve1_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VE1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ve1", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+/*
+ * PLL_AUDIO0 has a m1 divider in addition to the usual N, M factors.
+ * Since we only need some fixed frequency from this PLL (22.5792MHz x 4),
+ * ignore the divider and force it to 1 (encoded as 0), in the probe function
+ * below.
+ * The M factor must be an even number to produce a 50% duty cycle output.
+ */
+#define SUN60I_A733_PLL_AUDIO0_REG	0x260
+static struct ccu_sdm_setting pll_audio0_sdm_table[] = {
+	{ .rate = 90316800, .pattern = 0xa002872b, .m = 20, .n = 75 }, /* 22.5792 * 4 */
+};
+
+static struct ccu_nm pll_audio0_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(16, 7),
+	.sdm		= _SUNXI_CCU_SDM_DUAL_PAT(pll_audio0_sdm_table, 0,
+						  0x268, BIT(31),
+						  0x26c, BIT(27) | BIT(31)),
+	.common		= {
+		.reg		= SUN60I_A733_PLL_AUDIO0_REG,
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-audio0-4x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_AUDIO1_REG	0x280
+static struct ccu_nm pll_audio1_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1),	/* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_AUDIO1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-audio1", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_audio1_hws[] = {
+	&pll_audio1_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_audio1_div2_clk, "pll-audio1-div2", pll_audio1_hws,
+		       SUN60I_A733_PLL_AUDIO1_REG, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_audio1_div5_clk, "pll-audio1-div5", pll_audio1_hws,
+		       SUN60I_A733_PLL_AUDIO1_REG, 16, 3, 0);
+
+#define SUN60I_A733_PLL_NPU_REG		0x2a0
+static struct ccu_nkmp pll_npu_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_NPU_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-npu", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_DE_REG		0x2e0
+static struct ccu_nm pll_de_12x_clk = {
+	.enable		= BIT(26) | BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_DE_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-de-12x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_de_hws[] = {
+	&pll_de_12x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_de_4x_clk, "pll-de-4x", pll_de_hws,
+		       SUN60I_A733_PLL_DE_REG, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
+		       SUN60I_A733_PLL_DE_REG, 16, 3, 0);
+
+/*
+ * Contains all clocks that are controlled by a hardware register. They
+ * have a (sunxi) .common member, which needs to be initialised by the common
+ * sunxi CCU code, to be filled with the MMIO base address and the shared lock.
+ */
+static struct ccu_common *sun60i_a733_ccu_clks[] = {
+	&pll_ref_clk.common,
+	&pll_ddr_clk.common,
+	&pll_periph0_4x_clk.common,
+	&pll_periph0_2x_clk.common,
+	&pll_periph0_800M_clk.common,
+	&pll_periph0_480M_clk.common,
+	&pll_periph1_4x_clk.common,
+	&pll_periph1_2x_clk.common,
+	&pll_periph1_800M_clk.common,
+	&pll_periph1_480M_clk.common,
+	&pll_gpu0_clk.common,
+	&pll_video0_12x_clk.common,
+	&pll_video0_4x_clk.common,
+	&pll_video0_3x_clk.common,
+	&pll_video1_12x_clk.common,
+	&pll_video1_4x_clk.common,
+	&pll_video1_3x_clk.common,
+	&pll_video2_12x_clk.common,
+	&pll_video2_4x_clk.common,
+	&pll_video2_3x_clk.common,
+	&pll_ve0_clk.common,
+	&pll_ve1_clk.common,
+	&pll_audio0_4x_clk.common,
+	&pll_audio1_clk.common,
+	&pll_audio1_div2_clk.common,
+	&pll_audio1_div5_clk.common,
+	&pll_npu_clk.common,
+	&pll_de_12x_clk.common,
+	&pll_de_4x_clk.common,
+	&pll_de_3x_clk.common,
+};
+
+static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
+	.hws	= {
+		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
+		[CLK_PLL_PERIPH0_800M]	= &pll_periph0_800M_clk.common.hw,
+		[CLK_PLL_PERIPH0_480M]	= &pll_periph0_480M_clk.common.hw,
+		[CLK_PLL_PERIPH0_600M]	= &pll_periph0_600M_clk.hw,
+		[CLK_PLL_PERIPH0_400M]	= &pll_periph0_400M_clk.hw,
+		[CLK_PLL_PERIPH0_300M]	= &pll_periph0_300M_clk.hw,
+		[CLK_PLL_PERIPH0_200M]	= &pll_periph0_200M_clk.hw,
+		[CLK_PLL_PERIPH0_160M]	= &pll_periph0_160M_clk.hw,
+		[CLK_PLL_PERIPH0_150M]	= &pll_periph0_150M_clk.hw,
+		[CLK_PLL_PERIPH1_4X]	= &pll_periph1_4x_clk.common.hw,
+		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.common.hw,
+		[CLK_PLL_PERIPH1_800M]	= &pll_periph1_800M_clk.common.hw,
+		[CLK_PLL_PERIPH1_480M]	= &pll_periph1_480M_clk.common.hw,
+		[CLK_PLL_PERIPH1_600M]	= &pll_periph1_600M_clk.hw,
+		[CLK_PLL_PERIPH1_400M]	= &pll_periph1_400M_clk.hw,
+		[CLK_PLL_PERIPH1_300M]	= &pll_periph1_300M_clk.hw,
+		[CLK_PLL_PERIPH1_200M]	= &pll_periph1_200M_clk.hw,
+		[CLK_PLL_PERIPH1_160M]	= &pll_periph1_160M_clk.hw,
+		[CLK_PLL_PERIPH1_150M]	= &pll_periph1_150M_clk.hw,
+		[CLK_PLL_GPU0]		= &pll_gpu0_clk.common.hw,
+		[CLK_PLL_VIDEO0_12X]	= &pll_video0_12x_clk.common.hw,
+		[CLK_PLL_VIDEO0_4X]	= &pll_video0_4x_clk.common.hw,
+		[CLK_PLL_VIDEO0_3X]	= &pll_video0_3x_clk.common.hw,
+		[CLK_PLL_VIDEO1_12X]	= &pll_video1_12x_clk.common.hw,
+		[CLK_PLL_VIDEO1_4X]	= &pll_video1_4x_clk.common.hw,
+		[CLK_PLL_VIDEO1_3X]	= &pll_video1_3x_clk.common.hw,
+		[CLK_PLL_VIDEO2_12X]	= &pll_video2_12x_clk.common.hw,
+		[CLK_PLL_VIDEO2_4X]	= &pll_video2_4x_clk.common.hw,
+		[CLK_PLL_VIDEO2_3X]	= &pll_video2_3x_clk.common.hw,
+		[CLK_PLL_VE0]		= &pll_ve0_clk.common.hw,
+		[CLK_PLL_VE1]		= &pll_ve1_clk.common.hw,
+		[CLK_PLL_AUDIO0_4X]	= &pll_audio0_4x_clk.common.hw,
+		[CLK_PLL_AUDIO1]	= &pll_audio1_clk.common.hw,
+		[CLK_PLL_AUDIO1_DIV2]	= &pll_audio1_div2_clk.common.hw,
+		[CLK_PLL_AUDIO1_DIV5]	= &pll_audio1_div5_clk.common.hw,
+		[CLK_PLL_NPU]		= &pll_npu_clk.common.hw,
+		[CLK_PLL_DE_12X]	= &pll_de_12x_clk.common.hw,
+		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
+		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
+	},
+	.num	= CLK_FANOUT3 + 1,
+};
+
+static const struct sunxi_ccu_desc sun60i_a733_ccu_desc = {
+	.ccu_clks	= sun60i_a733_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun60i_a733_ccu_clks),
+
+	.hw_clks	= &sun60i_a733_hw_clks,
+};
+
+static const u32 pll_regs[] = {
+	SUN60I_A733_PLL_REF_REG,
+	SUN60I_A733_PLL_DDR_REG,
+	SUN60I_A733_PLL_PERIPH0_REG,
+	SUN60I_A733_PLL_PERIPH1_REG,
+	SUN60I_A733_PLL_GPU_REG,
+	SUN60I_A733_PLL_VIDEO0_REG,
+	SUN60I_A733_PLL_VIDEO1_REG,
+	SUN60I_A733_PLL_VIDEO2_REG,
+	SUN60I_A733_PLL_VE0_REG,
+	SUN60I_A733_PLL_VE1_REG,
+	SUN60I_A733_PLL_AUDIO0_REG,
+	SUN60I_A733_PLL_AUDIO1_REG,
+	SUN60I_A733_PLL_NPU_REG,
+	SUN60I_A733_PLL_DE_REG,
+};
+
+static int sun60i_a733_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	u32 val;
+	int i, ret;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/*
+	 * The PLL clock code does not model all bits, for instance it does
+	 * not support a separate enable and gate bit. We present the
+	 * gate bit(27) as the enable bit, but then have to set the
+	 * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs here.
+	 */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(31) | BIT(30) | BIT(29);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/* Enforce m1 = 0 for PLL_AUDIO0 */
+	val = readl(reg + SUN60I_A733_PLL_AUDIO0_REG);
+	val &= ~BIT(1);
+	writel(val, reg + SUN60I_A733_PLL_AUDIO0_REG);
+
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun60i_a733_ccu_desc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id sun60i_a733_ccu_ids[] = {
+	{ .compatible = "allwinner,sun60i-a733-ccu" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sun60i_a733_ccu_driver = {
+	.probe	= sun60i_a733_ccu_probe,
+	.driver	= {
+		.name			= "sun60i-a733-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun60i_a733_ccu_ids,
+	},
+};
+module_platform_driver(sun60i_a733_ccu_driver);
+
+MODULE_IMPORT_NS("SUNXI_CCU");
+MODULE_DESCRIPTION("Support for the Allwinner A733 CCU");
+MODULE_LICENSE("GPL");

-- 
2.54.0


