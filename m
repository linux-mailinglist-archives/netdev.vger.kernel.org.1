Return-Path: <netdev+bounces-253393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBvGXcyd2mrdAEAu9opvQ
	(envelope-from <netdev+bounces-253393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A971185F4D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59386300847C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9953093C0;
	Mon, 26 Jan 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvPufoni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225633081A2
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419328; cv=none; b=Wu2NIntkiGqd0ztU+sKloQMQyf0gWklTcCcQNEy/HIIKOUolI9xLPZe/RH8gYDsC9SsUSQnZqMkNLC4aU8ksaHeEgN0PtZBw9Cmx3R/iWzKhEzcDxuz3MtjcJuYDPcv7G7ULqJT1GmHoUpQqIxG8BR2oVlNwL05vWGZyb/ltlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419328; c=relaxed/simple;
	bh=Nj5xoIHsFwz4mwN35mQYGJFp7jFOthXPcVMX2Svf5Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRPBvsuapsFABPpU5aVcuF/5XRK122AtiKL7NN3fR658XBNw8xG+3Djug9VdbuDG3tJWgMh4abP1ZJbx4eziq8wONNPl4xde+2n7QR+3mOFpmmlBQkqgyUwCPFFNbJC6zaGLD9IDVQiO0EvKi3HtQyWLsRPufubiY6NCNGB4bdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvPufoni; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so34673145e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769419324; x=1770024124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTHA/4uN9KLXd+UFlDqR2tTJgWE1rHWO6ROsUhtjyd0=;
        b=rvPufonipOKGGezOLhRnSJmz2Msnb2QVeSDazVJLBzQ+hd94Q9dCk4L3Utx7gTFhGh
         SdReeNe2Ws68cDqKsr3KvgWbQONEw+R5u1v6QWrN1v8C9nNzLyvDXIKole7uPUGY135/
         tPLOxuc/gUrGUpFDUOyDAmVDhh6rLGXtYHbZip7oZu65heM6H1C/Tckq6ehaux+qRW3Y
         6o8T4J7Hqs1odRjm6cYoOFLF6vlMFxben/P1Dazatw+hxb7M973gV0lkTzoQ7ugq7C6O
         OgrXK02Mu9SITz2TXQFSmCeJf63j3rpr3ipbl2NI7YlcDbVfLJ7yTtEwDjr60gyI4FG5
         r3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419324; x=1770024124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTHA/4uN9KLXd+UFlDqR2tTJgWE1rHWO6ROsUhtjyd0=;
        b=thATPZgEJHie4TdH6sUtHpB87guyDjTSXqmDJaeXp2cAMuUm4PtxKlBn9IB8scqZYq
         4fi7QhUJpfJWhb6Y7ElWXR55DiafuNHislL5byaTMrxA/V44rFX1sCGJB5qDp+bSuFLl
         Y4HwdhCkF7VFygH7Fkk7wWw342VjPzzh1FYX/rFz4knhc2BoyKmyKznWlDyH/CL86q+0
         gwpQZVM3jV8TvAgH2ZCTPWb1zYTBZDoIZ4FFJIPUHRnjxWi3G6qxwghXPakC5SloI9yu
         I0BsvHERWgSa4wSyHyPdW632gu8UOhaWuU1UEY3qDmXfYkFa1A4JHhgCYs4C2XVxZWkE
         pgjw==
X-Forwarded-Encrypted: i=1; AJvYcCVKyMO2M3un+WtyUu+NnfFQ/ZmOsG5lqAXAf1VdTwn5DnL39MRRuG7XPe+wWC02m3oKluE8Qps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLr6E6+L9Pgbh3ZmJdb+cOmhlV8/HlefR3Xx7V5qW+o8NNCsS
	/OMaB+owTMTge1lSRqj90ZvIh3zqARbp1v6UvFlBB47zDzVk00KxRUj1g3VSFB0/07M=
X-Gm-Gg: AZuq6aJwZctbfOvx+DzQfmcse724Xk2HEENwYXMC9fdvZ143jNtmHROalHD8gkdDmdZ
	WD38FmSlVNlZXaM1Vp0e5SSJg2VCJwUBxRsMnzJfm7SvlI4JAewHeVjmqX9VNA8smxbcinjxUYD
	OVcYFcNYw0zXLRqs2G2/RzsDzd8y0Gx7I2C9lQIqO7vW0dZ3a0q2YMax5uOJVFszmByvmDbl7Oj
	Wssi+PyzdbMoxAe8VaGNVaOHilfVe+/9urSxJDDyG/HNAt9NYsgCex8poYqbqTtQMGQqtkJN6nU
	qlZMe4PTo9N1CMEknGPHnV5O2v/gs/WhllFsGjrAFN/DzDabg5iQ1QIx/g8noNoLYnxmZX6Q3T0
	kvkdFSNtDbknXOjLRKCGjNMiYmNnMC3GVRHoKi8xvVWSTfcWBMQjBmhmfV0kvTA3JA8ceILBgGb
	tBCb8/LZtjVlZks29R7Xw=
X-Received: by 2002:a05:600c:1e2a:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-4805ccd1198mr65140045e9.0.1769419324298;
        Mon, 26 Jan 2026 01:22:04 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:e270:a43a:f2fa:900a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm346669855e9.14.2026.01.26.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:22:03 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	p.zabel@pengutronix.de,
	linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com,
	bogdan-gabriel.roman@nxp.com,
	Ionut.Vicovan@nxp.com,
	alexandru-catalin.ionita@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Frank.li@nxp.com
Subject: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Date: Mon, 26 Jan 2026 10:21:57 +0100
Message-ID: <20260126092159.815968-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126092159.815968-1-vincent.guittot@linaro.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253393-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A971185F4D
X-Rspamd-Action: no action

s32g SoC family includes 2 serdes subsystems which are made of one PCIe
controller, 2 XPCS and one Phy. The Phy got 2 lanes that can be configure
to output PCIe lanes and/or SGMII.

Implement PCIe phy support

Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/phy/freescale/Kconfig               |   9 +
 drivers/phy/freescale/Makefile              |   1 +
 drivers/phy/freescale/phy-nxp-s32g-serdes.c | 569 ++++++++++++++++++++
 3 files changed, 579 insertions(+)
 create mode 100644 drivers/phy/freescale/phy-nxp-s32g-serdes.c

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 81f53564ee15..45184a3cdd69 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -61,3 +61,12 @@ config PHY_FSL_LYNX_28G
 	  found on NXP's Layerscape platforms such as LX2160A.
 	  Used to change the protocol running on SerDes lanes at runtime.
 	  Only useful for a restricted set of Ethernet protocols.
+
+config PHY_S32G_SERDES
+	tristate "NXP S32G SERDES support"
+	depends on ARCH_S32 || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  This option enables support for S23G SerDes PHY used for
+	  PCIe & Ethernet
+
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index 658eac7d0a62..86d948417252 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
 obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
 obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)	+= phy-fsl-samsung-hdmi.o
+obj-$(CONFIG_PHY_S32G_SERDES)		+= phy-nxp-s32g-serdes.o
diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
new file mode 100644
index 000000000000..8336c868c8dc
--- /dev/null
+++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * SerDes driver for S32G SoCs
+ *
+ * Copyright 2021-2026 NXP
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/processor.h>
+#include <linux/reset.h>
+#include <linux/units.h>
+
+#define S32G_SERDES_MODE_MAX			5
+
+#define EXTERNAL_CLK_NAME			"ext"
+#define INTERNAL_CLK_NAME			"ref"
+
+/* Serdes Sub system registers */
+
+#define S32G_PCIE_PHY_GEN_CTRL			0x0
+#define  REF_USE_PAD				BIT(17)
+#define  RX_SRIS_MODE				BIT(9)
+
+#define S32G_PCIE_PHY_MPLLA_CTRL		0x10
+#define  MPLL_STATE				BIT(30)
+
+#define S32G_SS_RW_REG_0			0xF0
+#define  SUBMODE_MASK				GENMASK(3, 0)
+#define  CLKEN_MASK				BIT(23)
+#define  PHY0_CR_PARA_SEL			BIT(9)
+
+/* PCIe phy subsystem registers */
+
+#define S32G_PHY_REG_ADDR			0x0
+#define  PHY_REG_EN				BIT(31)
+
+#define S32G_PHY_REG_DATA			0x4
+
+#define RAWLANE0_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN	0x3019
+#define RAWLANE1_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN	0x3119
+
+/*
+ * Until now, there is no generic way to describe and set PCIe clock mode.
+ * PCIe controller uses the default CRNS = 0 mode.
+ */
+enum pcie_phy_mode {
+	CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
+	CRSS = 1, /* Common Reference Clock, Spread Spectrum */
+	SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
+	SRIS = 3  /* Separate Reference Clock, Spread Spectrum */
+};
+
+struct s32g_serdes_ctrl {
+	void __iomem *ss_base;
+	struct reset_control *rst;
+	struct clk_bulk_data *clks;
+	int nclks;
+	u32 ss_mode;
+	unsigned long ref_clk_rate;
+	bool ext_clk;
+};
+
+struct s32g_pcie_ctrl {
+	void __iomem *phy_base;
+	struct reset_control *rst;
+	struct phy *phy;
+	enum pcie_phy_mode phy_mode;
+	bool powered_on;
+};
+
+struct s32g_serdes {
+	struct s32g_serdes_ctrl ctrl;
+	struct s32g_pcie_ctrl pcie;
+	struct device *dev;
+};
+
+/* PCIe phy subsystem */
+
+#define S32G_SERDES_PCIE_FREQ			(100 * HZ_PER_MHZ)
+
+static int s32g_pcie_check_clk(struct s32g_serdes *serdes)
+{
+	struct s32g_serdes_ctrl *sctrl = &serdes->ctrl;
+	unsigned long rate = sctrl->ref_clk_rate;
+
+	if (rate != S32G_SERDES_PCIE_FREQ) {
+		dev_err(serdes->dev, "PCIe PHY cannot operate at %lu HZ\n", rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool s32g_pcie_phy_is_locked(struct s32g_serdes *serdes)
+{
+	u32 mplla = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_MPLLA_CTRL);
+	const u32 mask = MPLL_STATE;
+
+	return (mplla & mask) == mask;
+}
+
+/* Serdes RFM says between 3.4 and 5.2ms depending of pll */
+#define S32G_SERDES_LOCK_TIMEOUT_MS		6
+
+static int s32g_pcie_phy_power_on_common(struct s32g_serdes *serdes)
+{
+	struct s32g_serdes_ctrl *sctrl = &serdes->ctrl;
+	struct s32g_pcie_ctrl *pcie = &serdes->pcie;
+	u32 reg;
+	int val, ret = 0;
+
+	ret = s32g_pcie_check_clk(serdes);
+	if (ret)
+		return ret;
+
+	reg = readl(sctrl->ss_base + S32G_PCIE_PHY_GEN_CTRL);
+
+	/* if PCIE PHY is in SRIS mode */
+	if (pcie->phy_mode == SRIS)
+		reg |= RX_SRIS_MODE;
+
+	if (sctrl->ext_clk)
+		reg |= REF_USE_PAD;
+	else
+		reg &= ~REF_USE_PAD;
+
+	writel(reg, sctrl->ss_base + S32G_PCIE_PHY_GEN_CTRL);
+
+	/* Monitor Serdes MPLL state */
+	ret = read_poll_timeout(s32g_pcie_phy_is_locked, val,
+				(val),
+				0,
+				S32G_SERDES_LOCK_TIMEOUT_MS, false, serdes);
+	if (ret) {
+		dev_err(serdes->dev, "Failed to lock PCIE phy\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Set PHY register access to CR interface */
+	reg = readl(sctrl->ss_base + S32G_SS_RW_REG_0);
+	reg |=  PHY0_CR_PARA_SEL;
+	writel(reg, sctrl->ss_base + S32G_SS_RW_REG_0);
+
+	return ret;
+}
+
+static void s32g_pcie_phy_write(struct s32g_serdes *serdes, u32 reg, u32 val)
+{
+	writel(PHY_REG_EN, serdes->pcie.phy_base + S32G_PHY_REG_ADDR);
+	writel(reg | PHY_REG_EN, serdes->pcie.phy_base + S32G_PHY_REG_ADDR);
+	usleep_range(100, 110);
+	writel(val, serdes->pcie.phy_base + S32G_PHY_REG_DATA);
+	usleep_range(100, 110);
+	writel(0, serdes->pcie.phy_base + S32G_PHY_REG_ADDR);
+}
+
+static int s32g_pcie_phy_power_on(struct s32g_serdes *serdes)
+{
+	struct s32g_pcie_ctrl *pcie = &serdes->pcie;
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	u32 iq_ovrd_in;
+	int ret = 0;
+
+	ret = s32g_pcie_phy_power_on_common(serdes);
+	if (ret)
+		return ret;
+
+	/* RX_EQ_DELTA_IQ_OVRD enable and override value for PCIe lanes */
+	iq_ovrd_in = RAWLANE0_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN;
+
+	s32g_pcie_phy_write(serdes, iq_ovrd_in, 0x3);
+	s32g_pcie_phy_write(serdes, iq_ovrd_in, 0x13);
+
+	if (ctrl->ss_mode == 0) {
+		iq_ovrd_in = RAWLANE1_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN;
+
+		s32g_pcie_phy_write(serdes, iq_ovrd_in, 0x3);
+		s32g_pcie_phy_write(serdes, iq_ovrd_in, 0x13);
+	}
+
+	pcie->powered_on = true;
+
+	return 0;
+}
+
+/* PCIe phy ops function */
+
+static int s32g_serdes_phy_power_on(struct phy *p)
+{
+	struct s32g_serdes *serdes = phy_get_drvdata(p);
+
+	return s32g_pcie_phy_power_on(serdes);
+}
+
+static inline bool is_pcie_phy_mode_valid(int mode)
+{
+	switch (mode) {
+	case CRNS:
+	case CRSS:
+	case SRNS:
+	case SRIS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int s32g_serdes_phy_set_mode_ext(struct phy *p,
+					enum phy_mode mode, int submode)
+{
+	struct s32g_serdes *serdes = phy_get_drvdata(p);
+
+	if (mode == PHY_MODE_PCIE)
+		return -EINVAL;
+
+	if (!is_pcie_phy_mode_valid(submode))
+		return -EINVAL;
+
+	/*
+	 * Do not configure SRIS or CRSS PHY MODE in conjunction
+	 * with any SGMII mode on the same SerDes subsystem
+	 */
+	if ((submode == CRSS || submode == SRIS) &&
+	    serdes->ctrl.ss_mode != 0)
+		return -EINVAL;
+
+	/*
+	 * Internal reference clock cannot be used with either Common clock
+	 * or Spread spectrum, leaving only SRNSS
+	 */
+	if (submode != SRNS &&  !serdes->ctrl.ext_clk)
+		return -EINVAL;
+
+	serdes->pcie.phy_mode = submode;
+
+	return 0;
+}
+
+static const struct phy_ops serdes_pcie_ops = {
+	.power_on	= s32g_serdes_phy_power_on,
+	.set_mode	= s32g_serdes_phy_set_mode_ext,
+};
+
+static struct phy *s32g_serdes_phy_xlate(struct device *dev,
+					 const struct of_phandle_args *args)
+{
+	struct s32g_serdes *serdes;
+	struct phy *phy;
+
+	serdes = dev_get_drvdata(dev);
+	if (!serdes)
+		return ERR_PTR(-EINVAL);
+
+	phy = serdes->pcie.phy;
+
+	return phy;
+}
+
+/* Serdes subsystem */
+
+static int s32g_serdes_assert_reset(struct s32g_serdes *serdes)
+{
+	struct device *dev = serdes->dev;
+	int ret;
+
+	ret = reset_control_assert(serdes->pcie.rst);
+	if (ret) {
+		dev_err(dev, "Failed to assert PCIE reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_assert(serdes->ctrl.rst);
+	if (ret) {
+		dev_err(dev, "Failed to assert SerDes reset: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int s32g_serdes_deassert_reset(struct s32g_serdes *serdes)
+{
+	struct device *dev = serdes->dev;
+	int ret;
+
+	ret = reset_control_deassert(serdes->pcie.rst);
+	if (ret) {
+		dev_err(dev, "Failed to assert PCIE reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(serdes->ctrl.rst);
+	if (ret) {
+		dev_err(dev, "Failed to assert SerDes reset: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int s32g_serdes_init(struct s32g_serdes *serdes)
+{
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	u32 reg0;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(ctrl->nclks, ctrl->clks);
+	if (ret) {
+		dev_err(serdes->dev, "Failed to enable SerDes clocks\n");
+		return ret;
+	}
+
+	ret = s32g_serdes_assert_reset(serdes);
+	if (ret)
+		goto disable_clks;
+
+	/* Set serdes mode */
+	reg0 = readl(ctrl->ss_base + S32G_SS_RW_REG_0);
+	reg0 &= ~SUBMODE_MASK;
+	if (ctrl->ss_mode == 5)
+		reg0 |= 2;
+	else
+		reg0 |= ctrl->ss_mode;
+	writel(reg0, ctrl->ss_base + S32G_SS_RW_REG_0);
+
+	/* Set Clock source: internal or external */
+	reg0 = readl(ctrl->ss_base + S32G_SS_RW_REG_0);
+	if (ctrl->ext_clk)
+		reg0 &= ~CLKEN_MASK;
+	else
+		reg0 |= CLKEN_MASK;
+
+	writel(reg0, ctrl->ss_base + S32G_SS_RW_REG_0);
+
+	/* Wait for the selection of working mode (as per the manual specs) */
+	usleep_range(100, 110);
+
+	ret = s32g_serdes_deassert_reset(serdes);
+	if (ret)
+		goto disable_clks;
+
+	dev_info(serdes->dev, "Using mode %d for SerDes subsystem\n",
+		 ctrl->ss_mode);
+
+	return 0;
+
+disable_clks:
+	clk_bulk_disable_unprepare(serdes->ctrl.nclks,
+				   serdes->ctrl.clks);
+
+	return ret;
+}
+
+static int s32g_serdes_get_ctrl_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
+{
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	struct device *dev = &pdev->dev;
+	int ret, idx;
+
+	ret = of_property_read_u32(dev->of_node, "nxp,sys-mode",
+				   &ctrl->ss_mode);
+	if (ret) {
+		dev_err(dev, "Failed to get SerDes subsystem mode\n");
+		return -EINVAL;
+	}
+
+	if (ctrl->ss_mode > S32G_SERDES_MODE_MAX) {
+		dev_err(dev, "Invalid SerDes subsystem mode %u\n",
+			ctrl->ss_mode);
+		return -EINVAL;
+	}
+
+	ctrl->ss_base = devm_platform_ioremap_resource_byname(pdev, "ss_pcie");
+	if (IS_ERR(ctrl->ss_base)) {
+		dev_err(dev, "Failed to map 'ss_pcie'\n");
+		return PTR_ERR(ctrl->ss_base);
+	}
+
+	ctrl->rst = devm_reset_control_get(dev, "serdes");
+	if (IS_ERR(ctrl->rst))
+		return dev_err_probe(dev, PTR_ERR(ctrl->rst),
+				     "Failed to get 'serdes' reset control\n");
+
+	ctrl->nclks = devm_clk_bulk_get_all(dev, &ctrl->clks);
+	if (ctrl->nclks < 1)
+		return dev_err_probe(dev, ctrl->nclks,
+				     "Failed to get SerDes clocks\n");
+
+	idx = of_property_match_string(dev->of_node, "clock-names", EXTERNAL_CLK_NAME);
+	if (idx < 0)
+		idx = of_property_match_string(dev->of_node, "clock-names", INTERNAL_CLK_NAME);
+	else
+		ctrl->ext_clk = true;
+
+	if (idx < 0) {
+		dev_err(dev, "Failed to get Phy reference clock source\n");
+		return -EINVAL;
+	}
+
+	ctrl->ref_clk_rate = clk_get_rate(ctrl->clks[idx].clk);
+	if (!ctrl->ref_clk_rate) {
+		dev_err(dev, "Failed to get Phy reference clock rate\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int s32g_serdes_get_pcie_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
+{
+	struct s32g_pcie_ctrl *pcie = &serdes->pcie;
+	struct device *dev = &pdev->dev;
+
+	pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
+							       "pcie_phy");
+	if (IS_ERR(pcie->phy_base)) {
+		dev_err(dev, "Failed to map 'pcie_phy'\n");
+		return PTR_ERR(pcie->phy_base);
+	}
+
+	pcie->rst = devm_reset_control_get(dev, "pcie");
+	if (IS_ERR(pcie->rst))
+		return dev_err_probe(dev, IS_ERR(pcie->rst),
+				     "Failed to get 'pcie' reset control\n");
+
+	return 0;
+}
+
+static int s32g2_serdes_create_phy(struct s32g_serdes *serdes, struct device_node *child_node)
+{
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	struct phy_provider *phy_provider;
+	struct device *dev = serdes->dev;
+	int ss_mode = ctrl->ss_mode;
+	struct phy *phy;
+
+	if (of_device_is_compatible(child_node, "nxp,s32g2-serdes-pcie-phy")) {
+		/* no PCIe phy lane */
+		if (ss_mode > 2)
+			return 0;
+
+		phy = devm_phy_create(dev, child_node, &serdes_pcie_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		phy_set_drvdata(phy, serdes);
+
+		phy->attrs.mode = PHY_MODE_PCIE;
+		phy->id = 0;
+		serdes->pcie.phy = phy;
+
+		phy_provider = devm_of_phy_provider_register(&phy->dev, s32g_serdes_phy_xlate);
+		if (IS_ERR(phy_provider))
+			return PTR_ERR(phy_provider);
+
+	} else {
+		dev_warn(dev, "Skipping unknown child node %pOFn\n", child_node);
+	}
+
+	return 0;
+}
+
+static int s32g_serdes_parse_lanes(struct device *dev, struct s32g_serdes *serdes)
+{
+	int ret;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		ret = s32g2_serdes_create_phy(serdes, of_port);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int s32g_serdes_probe(struct platform_device *pdev)
+{
+	struct s32g_serdes *serdes;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	serdes = devm_kzalloc(dev, sizeof(*serdes), GFP_KERNEL);
+	if (!serdes)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, serdes);
+	serdes->dev = dev;
+
+	ret = s32g_serdes_get_ctrl_resources(pdev, serdes);
+	if (ret)
+		return ret;
+
+	ret = s32g_serdes_get_pcie_resources(pdev, serdes);
+	if (ret)
+		return ret;
+
+	ret = s32g_serdes_parse_lanes(dev, serdes);
+	if (ret)
+		return ret;
+
+	ret = s32g_serdes_init(serdes);
+
+	return ret;
+}
+
+static int __maybe_unused s32g_serdes_suspend(struct device *device)
+{
+	struct s32g_serdes *serdes = dev_get_drvdata(device);
+
+	clk_bulk_disable_unprepare(serdes->ctrl.nclks, serdes->ctrl.clks);
+
+	return 0;
+}
+
+static int __maybe_unused s32g_serdes_resume(struct device *device)
+{
+	struct s32g_serdes *serdes = dev_get_drvdata(device);
+	struct s32g_pcie_ctrl *pcie = &serdes->pcie;
+	int ret;
+
+	ret = s32g_serdes_init(serdes);
+	if (ret) {
+		dev_err(device, "Failed to initialize\n");
+		return ret;
+	}
+
+	/* Restore PCIe phy power */
+	if (pcie->powered_on) {
+		ret = s32g_pcie_phy_power_on(serdes);
+		if (ret)
+			dev_err(device, "Failed to power-on PCIe phy\n");
+	}
+
+	return ret;
+}
+
+static const struct of_device_id s32g_serdes_match[] = {
+	{
+		.compatible = "nxp,s32g2-serdes",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s32g_serdes_match);
+
+static const struct dev_pm_ops s32g_serdes_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_serdes_suspend,
+				  s32g_serdes_resume)
+};
+
+static struct platform_driver s32g_serdes_driver = {
+	.probe		= s32g_serdes_probe,
+	.driver		= {
+		.name	= "phy-s32g-serdes",
+		.of_match_table = s32g_serdes_match,
+		.pm = &s32g_serdes_pm_ops,
+	},
+};
+module_platform_driver(s32g_serdes_driver);
+
+MODULE_AUTHOR("Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>");
+MODULE_DESCRIPTION("S32CC SerDes driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


