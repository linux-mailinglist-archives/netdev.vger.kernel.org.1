Return-Path: <netdev+bounces-253395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFcACLUyd2mrdAEAu9opvQ
	(envelope-from <netdev+bounces-253395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:24:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED985FB8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9462F302084D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1330ACF1;
	Mon, 26 Jan 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JObhvvjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325E3093B6
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419332; cv=none; b=oQrx98d+ROl7cgbNknPiFliSnp8MNKb/oCZIDf57dckou4u3XYUI7UFJApEt+lVwJhfnB3klgvD499blVPTmSaU65LQaafhwQBOFBOxtbx8Gt8ObcFSGjnsA1NJ6j382gzxpEcjK6Ya7uamevqWYijByl6B3GeD1vdObNMCcKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419332; c=relaxed/simple;
	bh=FGgH6X95XdSgyz1tkvVLK6j6gwCyVERhZRDVHgjgKxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cjh+mhykrxPO/fX7l1IolfNdYlxiewUtZGQ333zPdIfVI/5z4aolkwlhVV/r9H8Xz9sgcfL2amntMaUSF+E0e+uYvaWKm7OVcoTOlN79nk6DqOCrVircTl3UER24taX+5wyojbxpETpLOS7G2qjYfq9QoXy8CUdfrAu5RUavskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JObhvvjz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso33276475e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769419327; x=1770024127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSce4mO8UziDynZb3AXNH2TtP9oKk4P3oblHDyCxtXs=;
        b=JObhvvjzT6ycvqAsWEVUtqEkUB5tWROrBmHBLxW7nxpZt5CISbgSrRji+0RuecZMLU
         juSBIfo2Tyc3lF7vapILkQuUtTPce0nCzFd2A6+tAW3geOS89G+2NirmEmyAOzjaCwm0
         yPxKeTvyPTlZRP8G7mWY8uTq0OEOaaPNApOVOWzAWor/F4zAUMY/DHMHf7c7HmIXyw/3
         KlNlKATytkwsb0cGw3xWmp0tFONehE0zBXDs4nvu0MioMsRrqxwUSZn5pqajhg2bMoeg
         4ujRBbfVhdGW74KTs8tJXH42XoMgYjHzLWLEu0XjJaFMkovvd3QsRnCC5GayAwr3RNlC
         RlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419327; x=1770024127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSce4mO8UziDynZb3AXNH2TtP9oKk4P3oblHDyCxtXs=;
        b=O+Cxu90BGQd37nfH4o4CA506AEdfYBblVhNppfi3fVAS13G3YEjiCEP06fVqyDlkSo
         Ce9RPyMpAUVE8tQiimWcwI9WTT5IuW24k7QBJ+q0ivRkUh5sNvcvTwD9igtS3MZNbMhl
         VSKjrk5wfAs0y4f+FjiOze+94hwS3Pu+IoZpWuA0MDN8RTpoEeqAPsZ9arnnwVd6Swvh
         yTnvcVNQcI/PgDWwBi8prUSaXz164yXQ7zvDHzJztoLU7jzMiAN5cJ5baI6tS5/KM75e
         VQ4PgqhWlP0qJ4CnR/pNDP5/nzjthWQx8qE/a9QYVpMNXX7kyTYV6lW6C3ZbfaYgU6tK
         ErQw==
X-Forwarded-Encrypted: i=1; AJvYcCVXa2LnoaJ18zsFFQreH8XK4OVhXb5YX6WDiZ97CEdxw7UsudUoZxHQojMSW0Fgnn6D49AVgmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiUnXQNFdLPzWlOdMXT6Z6GdvdL1NhmMkOKhyervxVWndMKJR
	x/5P3Jd3zwv5Sq1Rc7Lq65CXmPaWBfZ9wkc+ZpjwyqfGbpVAuiHUn8ZZUdHVJeI1Ui8=
X-Gm-Gg: AZuq6aIpzF4j2CLVfWKuXnRJWHqFCud2v8bvS1hZDaaY8br9/D5bULGeOmtyXNLyPP3
	9szJjwuum6P/EWlGDglrOukFFEBmW2JvRnDyUzG9V1TcEwpS6O0wLjJT6/N6AZy2od8ZyBT2umC
	rNR++1O3DAM+O05D6Wwc4n2z7BKjYOdG2aBP1CZ80bPPq+8pRlLXmi5BQ07vSB1Ef4GICSbYbN5
	ryk9ZRKuyjg3XKzgbuEG534S+0rUfFC6Sd+jW/wFAdiiZmpdKDXJzIJunXTp4D78cGdbtXdMJFb
	6Pb0KVGUBS5QO+SE1EiuqB9g4s8mowcWtQpt1n/jAB9U6cea5BsArdSmwq2SrSzqh7ZUkRJhMe2
	oqC/HQwT6ABRBkn+VxOlEQFYqfOQgT6nxfAkWNCpyt9MVWutAg0AxIudIMN9QwnqiKpR6FsYoT+
	n1kFF2LOQz943+JBKtRF8=
X-Received: by 2002:a05:600c:8287:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4805cd407edmr60213865e9.8.1769419326481;
        Mon, 26 Jan 2026 01:22:06 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:e270:a43a:f2fa:900a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm346669855e9.14.2026.01.26.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:22:04 -0800 (PST)
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
Subject: [PATCH 3/4] phy: s32g: Add serdes xpcs subsystem
Date: Mon, 26 Jan 2026 10:21:58 +0100
Message-ID: <20260126092159.815968-4-vincent.guittot@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253395-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 66ED985FB8
X-Rspamd-Action: no action

s32g SoC family includes 2 serdes subsystems which are made of one PCIe
controller, 2 XPCS and one Phy. The Phy got 2 lanes that can be configure
to output PCIe lanes and/or SGMII.

Add XPCS and SGMII support.

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
 drivers/phy/freescale/Kconfig               |    1 +
 drivers/phy/freescale/Makefile              |    2 +-
 drivers/phy/freescale/phy-nxp-s32g-serdes.c |  361 ++++++-
 drivers/phy/freescale/phy-nxp-s32g-xpcs.c   | 1082 +++++++++++++++++++
 drivers/phy/freescale/phy-nxp-s32g-xpcs.h   |   47 +
 include/linux/pcs/pcs-nxp-xpcs.h            |   13 +
 6 files changed, 1503 insertions(+), 3 deletions(-)
 create mode 100644 drivers/phy/freescale/phy-nxp-s32g-xpcs.c
 create mode 100644 drivers/phy/freescale/phy-nxp-s32g-xpcs.h
 create mode 100644 include/linux/pcs/pcs-nxp-xpcs.h

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 45184a3cdd69..bb7f59897faf 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -66,6 +66,7 @@ config PHY_S32G_SERDES
 	tristate "NXP S32G SERDES support"
 	depends on ARCH_S32 || COMPILE_TEST
 	select GENERIC_PHY
+	select REGMAP
 	help
 	  This option enables support for S23G SerDes PHY used for
 	  PCIe & Ethernet
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index 86d948417252..2a1231cd466b 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
 obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
 obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)	+= phy-fsl-samsung-hdmi.o
-obj-$(CONFIG_PHY_S32G_SERDES)		+= phy-nxp-s32g-serdes.o
+obj-$(CONFIG_PHY_S32G_SERDES)		+= phy-nxp-s32g-serdes.o phy-nxp-s32g-xpcs.o
diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
index 8336c868c8dc..e0065c61a994 100644
--- a/drivers/phy/freescale/phy-nxp-s32g-serdes.c
+++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
@@ -11,12 +11,16 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/pcs/pcs-nxp-xpcs.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/processor.h>
 #include <linux/reset.h>
 #include <linux/units.h>
 
+#include "phy-nxp-s32g-xpcs.h"
+
+#define S32G_SERDES_XPCS_MAX			2
 #define S32G_SERDES_MODE_MAX			5
 
 #define EXTERNAL_CLK_NAME			"ext"
@@ -31,6 +35,52 @@
 #define S32G_PCIE_PHY_MPLLA_CTRL		0x10
 #define  MPLL_STATE				BIT(30)
 
+#define S32G_PCIE_PHY_MPLLB_CTRL		0x14
+#define  MPLLB_SSC_EN				BIT(1)
+
+#define S32G_PCIE_PHY_EXT_CTRL_SEL		0x18
+#define  EXT_PHY_CTRL_SEL			BIT(0)
+
+#define S32G_PCIE_PHY_EXT_BS_CTRL		0x1C
+#define  EXT_BS_TX_LOWSWING			BIT(6)
+#define  EXT_BS_RX_BIGSWING			BIT(5)
+#define  EXT_BS_RX_LEVEL_MASK			GENMASK(4, 0)
+
+#define S32G_PCIE_PHY_REF_CLK_CTRL		0x20
+#define  EXT_REF_RANGE_MASK			GENMASK(5, 3)
+#define  REF_CLK_DIV2_EN			BIT(2)
+#define  REF_CLK_MPLLB_DIV2_EN			BIT(1)
+
+#define S32G_PCIE_PHY_EXT_MPLLA_CTRL_1		0x30
+#define  EXT_MPLLA_BANDWIDTH_MASK		GENMASK(15, 0)
+
+#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_1		0x40
+#define  EXT_MPLLB_DIV_MULTIPLIER_MASK		GENMASK(31, 24)
+#define  EXT_MPLLB_DIV_CLK_EN			BIT(19)
+#define  EXT_MPLLB_DIV8_CLK_EN			BIT(18)
+#define  EXT_MPLLB_DIV10_CLK_EN			BIT(16)
+#define  EXT_MPLLB_BANDWIDTH_MASK		GENMASK(15, 0)
+
+#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_2		0x44
+#define  EXT_MPLLB_FRACN_CTRL_MASK		GENMASK(22, 12)
+#define  MPLLB_MULTIPLIER_MASK			GENMASK(8, 0)
+
+#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_3		0x48
+#define  EXT_MPLLB_WORD_DIV2_EN			BIT(31)
+#define  EXT_MPLLB_TX_CLK_DIV_MASK		GENMASK(30, 28)
+
+#define S32G_PCIE_PHY_EXT_MISC_CTRL_1		0xA0
+#define  EXT_RX_LOS_THRESHOLD_MASK		GENMASK(7, 1)
+#define  EXT_RX_VREF_CTRL_MASK			GENMASK(28, 24)
+
+#define S32G_PCIE_PHY_EXT_MISC_CTRL_2		0xA4
+#define  EXT_TX_VBOOST_LVL_MASK			GENMASK(18, 16)
+#define  EXT_TX_TERM_CTRL_MASK			GENMASK(26, 24)
+
+#define S32G_PCIE_PHY_XPCS1_RX_OVRD_CTRL	0xD0
+#define  XPCS1_RX_VCO_LD_VAL_MASK		GENMASK(28, 16)
+#define  XPCS1_RX_REF_LD_VAL_MASK		GENMASK(14, 8)
+
 #define S32G_SS_RW_REG_0			0xF0
 #define  SUBMODE_MASK				GENMASK(3, 0)
 #define  CLKEN_MASK				BIT(23)
@@ -43,6 +93,9 @@
 
 #define S32G_PHY_REG_DATA			0x4
 
+#define S32G_PHY_RST_CTRL			0x8
+#define  WARM_RST				BIT(1)
+
 #define RAWLANE0_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN	0x3019
 #define RAWLANE1_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN	0x3119
 
@@ -75,16 +128,33 @@ struct s32g_pcie_ctrl {
 	bool powered_on;
 };
 
+struct s32g_xpcs_ctrl {
+	struct s32g_xpcs *phys[2];
+	void __iomem *base0, *base1;
+};
+
 struct s32g_serdes {
 	struct s32g_serdes_ctrl ctrl;
 	struct s32g_pcie_ctrl pcie;
+	struct s32g_xpcs_ctrl xpcs;
 	struct device *dev;
+	u8 lanes_status;
 };
 
 /* PCIe phy subsystem */
 
 #define S32G_SERDES_PCIE_FREQ			(100 * HZ_PER_MHZ)
 
+static void s32g_pcie_phy_reset(struct s32g_serdes *serdes)
+{
+	u32 val;
+
+	val = readl(serdes->pcie.phy_base + S32G_PHY_RST_CTRL);
+	writel(val | WARM_RST, serdes->pcie.phy_base + S32G_PHY_RST_CTRL);
+	usleep_range(1000, 1100);
+	writel(val, serdes->pcie.phy_base + S32G_PHY_RST_CTRL);
+}
+
 static int s32g_pcie_check_clk(struct s32g_serdes *serdes)
 {
 	struct s32g_serdes_ctrl *sctrl = &serdes->ctrl;
@@ -263,6 +333,187 @@ static struct phy *s32g_serdes_phy_xlate(struct device *dev,
 	return phy;
 }
 
+/* XPCS subsystem */
+
+static int s32g_serdes_xpcs_init(struct s32g_serdes *serdes, int id)
+{
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	struct s32g_xpcs_ctrl *xpcs = &serdes->xpcs;
+	enum pcie_xpcs_mode shared = NOT_SHARED;
+	unsigned long rate = ctrl->ref_clk_rate;
+	struct device *dev = serdes->dev;
+	void __iomem *base;
+
+	if (!id)
+		base = xpcs->base0;
+	else
+		base = xpcs->base1;
+
+	if (ctrl->ss_mode == 1 || ctrl->ss_mode == 2)
+		shared = PCIE_XPCS_1G;
+	else if (ctrl->ss_mode == 5)
+		shared = PCIE_XPCS_2G5;
+
+	return s32g_xpcs_init(xpcs->phys[id], dev, id, base,
+			       ctrl->ext_clk, rate, shared);
+}
+
+static void s32g_serdes_prepare_pma_mode5(struct s32g_serdes *serdes)
+{
+	u32 val;
+	/* Configure TX_VBOOST_LVL and TX_TERM_CTRL */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);
+	val &= ~(EXT_TX_VBOOST_LVL_MASK | EXT_TX_TERM_CTRL_MASK);
+	val |= FIELD_PREP(EXT_TX_VBOOST_LVL_MASK, 0x3) |
+		FIELD_PREP(EXT_TX_TERM_CTRL_MASK, 0x4);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);
+
+	/* Enable phy external control */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_CTRL_SEL);
+	val |= EXT_PHY_CTRL_SEL;
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_CTRL_SEL);
+
+	/* Configure ref range, disable PLLB/ref div2 */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_REF_CLK_CTRL);
+	val &= ~(REF_CLK_DIV2_EN | REF_CLK_MPLLB_DIV2_EN | EXT_REF_RANGE_MASK);
+	val |= FIELD_PREP(EXT_REF_RANGE_MASK, 0x3);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_REF_CLK_CTRL);
+
+	/* Configure multiplier */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_2);
+	val &= ~(MPLLB_MULTIPLIER_MASK | EXT_MPLLB_FRACN_CTRL_MASK | BIT(24) | BIT(28));
+	val |= FIELD_PREP(MPLLB_MULTIPLIER_MASK, 0x27U) |
+		FIELD_PREP(EXT_MPLLB_FRACN_CTRL_MASK, 0x414);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_2);
+
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_MPLLB_CTRL);
+	val &= ~MPLLB_SSC_EN;
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_MPLLB_CTRL);
+
+	/* Configure tx lane division, disable word clock div2*/
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_3);
+	val &= ~(EXT_MPLLB_WORD_DIV2_EN | EXT_MPLLB_TX_CLK_DIV_MASK);
+	val |= FIELD_PREP(EXT_MPLLB_TX_CLK_DIV_MASK, 0x5);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_3);
+
+	/* Configure bandwidth for filtering and div10*/
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_1);
+	val &= ~(EXT_MPLLB_BANDWIDTH_MASK | EXT_MPLLB_DIV_CLK_EN |
+		 EXT_MPLLB_DIV8_CLK_EN | EXT_MPLLB_DIV_MULTIPLIER_MASK);
+	val |= FIELD_PREP(EXT_MPLLB_BANDWIDTH_MASK, 0x5f) | EXT_MPLLB_DIV10_CLK_EN;
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL_1);
+
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLA_CTRL_1);
+	val &= ~(EXT_MPLLA_BANDWIDTH_MASK);
+	val |= FIELD_PREP(EXT_MPLLA_BANDWIDTH_MASK, 0xc5);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLA_CTRL_1);
+
+	/* Configure VCO */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_XPCS1_RX_OVRD_CTRL);
+	val &= ~(XPCS1_RX_VCO_LD_VAL_MASK | XPCS1_RX_REF_LD_VAL_MASK);
+	val |= FIELD_PREP(XPCS1_RX_VCO_LD_VAL_MASK, 0x540) |
+		FIELD_PREP(XPCS1_RX_REF_LD_VAL_MASK, 0x2b);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_XPCS1_RX_OVRD_CTRL);
+
+	/* Boundary scan control */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_BS_CTRL);
+	val &= ~(EXT_BS_RX_LEVEL_MASK | EXT_BS_TX_LOWSWING);
+	val |= FIELD_PREP(EXT_BS_RX_LEVEL_MASK, 0xB) | EXT_BS_RX_BIGSWING;
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_BS_CTRL);
+
+	/* Rx loss threshold */
+	val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_1);
+	val &= ~(EXT_RX_LOS_THRESHOLD_MASK | EXT_RX_VREF_CTRL_MASK);
+	val |= FIELD_PREP(EXT_RX_LOS_THRESHOLD_MASK, 0x3U) |
+		FIELD_PREP(EXT_RX_VREF_CTRL_MASK, 0x11U);
+	writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_1);
+}
+
+#define XPCS_DISABLED	-1
+
+static int s32g_serdes_init_clks(struct s32g_serdes *serdes)
+{
+	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
+	struct s32g_xpcs_ctrl *xpcs = &serdes->xpcs;
+	int ret, order[2], xpcs_id;
+	size_t i;
+
+	switch (ctrl->ss_mode) {
+	case 0:
+		return 0;
+	case 1:
+		order[0] = 0;
+		order[1] = XPCS_DISABLED;
+		break;
+	case 2:
+	case 5:
+		order[0] = 1;
+		order[1] = XPCS_DISABLED;
+		break;
+	case 3:
+		order[0] = 1;
+		order[1] = 0;
+		break;
+	case 4:
+		order[0] = 0;
+		order[1] = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(order); i++) {
+		xpcs_id = order[i];
+
+		if (xpcs_id == XPCS_DISABLED)
+			continue;
+
+		ret = s32g_xpcs_init_plls(xpcs->phys[xpcs_id]);
+		if (ret)
+			return ret;
+	}
+
+	if (ctrl->ss_mode == 5) {
+		s32g_serdes_prepare_pma_mode5(serdes);
+
+		ret = s32g_xpcs_pre_pcie_2g5(xpcs->phys[1]);
+		if (ret) {
+			dev_err(serdes->dev,
+				"Failed to prepare SerDes for PCIE & XPCS @ 2G5 mode\n");
+			return ret;
+		}
+
+		s32g_pcie_phy_reset(serdes);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(order); i++) {
+			xpcs_id = order[i];
+
+			if (xpcs_id == XPCS_DISABLED)
+				continue;
+
+			ret = s32g_xpcs_vreset(xpcs->phys[xpcs_id]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(order); i++) {
+		xpcs_id = order[i];
+
+		if (xpcs_id == XPCS_DISABLED)
+			continue;
+
+		ret = s32g_xpcs_wait_vreset(xpcs->phys[xpcs_id]);
+		if (ret)
+			return ret;
+
+		s32g_xpcs_reset_rx(xpcs->phys[xpcs_id]);
+		s32g_xpcs_disable_an(xpcs->phys[xpcs_id]);
+	}
+
+	return 0;
+}
+
 /* Serdes subsystem */
 
 static int s32g_serdes_assert_reset(struct s32g_serdes *serdes)
@@ -317,6 +568,10 @@ static int s32g_serdes_init(struct s32g_serdes *serdes)
 		return ret;
 	}
 
+	/*
+	 * We have a tight timing for the init sequence and any delay linked to
+	 * printk as an example can fail the init after reset
+	 */
 	ret = s32g_serdes_assert_reset(serdes);
 	if (ret)
 		goto disable_clks;
@@ -349,7 +604,13 @@ static int s32g_serdes_init(struct s32g_serdes *serdes)
 	dev_info(serdes->dev, "Using mode %d for SerDes subsystem\n",
 		 ctrl->ss_mode);
 
-	return 0;
+	ret = s32g_serdes_init_clks(serdes);
+	if (ret) {
+		dev_err(serdes->dev, "XPCS init failed\n");
+		goto disable_clks;
+	}
+
+	return ret;
 
 disable_clks:
 	clk_bulk_disable_unprepare(serdes->ctrl.nclks,
@@ -433,12 +694,32 @@ static int s32g_serdes_get_pcie_resources(struct platform_device *pdev, struct s
 	return 0;
 }
 
+static int s32g_serdes_get_xpcs_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
+{
+	struct s32g_xpcs_ctrl *xpcs = &serdes->xpcs;
+	struct device *dev = &pdev->dev;
+
+	xpcs->base0 = devm_platform_ioremap_resource_byname(pdev, "xpcs0");
+	if (IS_ERR(xpcs->base0)) {
+		dev_err(dev, "Failed to map 'xpcs0'\n");
+		return PTR_ERR(xpcs->base0);
+	}
+
+	xpcs->base1 = devm_platform_ioremap_resource_byname(pdev, "xpcs1");
+	if (IS_ERR(xpcs->base1)) {
+		dev_err(dev, "Failed to map 'xpcs1'\n");
+		return PTR_ERR(xpcs->base1);
+	}
+
+	return 0;
+}
+
 static int s32g2_serdes_create_phy(struct s32g_serdes *serdes, struct device_node *child_node)
 {
 	struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
 	struct phy_provider *phy_provider;
 	struct device *dev = serdes->dev;
-	int ss_mode = ctrl->ss_mode;
+	int ret, ss_mode = ctrl->ss_mode;
 	struct phy *phy;
 
 	if (of_device_is_compatible(child_node, "nxp,s32g2-serdes-pcie-phy")) {
@@ -460,6 +741,41 @@ static int s32g2_serdes_create_phy(struct s32g_serdes *serdes, struct device_nod
 		if (IS_ERR(phy_provider))
 			return PTR_ERR(phy_provider);
 
+	} else if (of_device_is_compatible(child_node, "nxp,s32g2-serdes-xpcs")) {
+		struct s32g_xpcs_ctrl *xpcs_ctrl = &serdes->xpcs;
+		struct s32g_xpcs *xpcs;
+		int port;
+
+		/* no Ethernet phy lane */
+		if (ss_mode == 0)
+			return 0;
+
+		/* Get XPCS port number connected to the lane */
+		if (of_property_read_u32(child_node, "reg", &port))
+			return -EINVAL;
+
+		/* XPCS1 is not used */
+		if (ss_mode == 1 && port == 1)
+			return -EINVAL;
+
+		/* XPCS0 is not used */
+		if (ss_mode == 2 && port == 0)
+			return -EINVAL;
+
+		xpcs = devm_kmalloc(dev, sizeof(*xpcs), GFP_KERNEL);
+		if (IS_ERR(xpcs)) {
+			dev_err(dev, "Failed to allocate xpcs\n");
+			return -ENOMEM;
+		}
+
+		xpcs_ctrl->phys[port] = xpcs;
+
+		xpcs->an = of_property_read_bool(dev->of_node, "nxp,xpcs_an");
+
+		ret = s32g_serdes_xpcs_init(serdes, port);
+		if (ret)
+			return ret;
+
 	} else {
 		dev_warn(dev, "Skipping unknown child node %pOFn\n", child_node);
 	}
@@ -501,6 +817,10 @@ static int s32g_serdes_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = s32g_serdes_get_xpcs_resources(pdev, serdes);
+	if (ret)
+		return ret;
+
 	ret = s32g_serdes_parse_lanes(dev, serdes);
 	if (ret)
 		return ret;
@@ -541,6 +861,43 @@ static int __maybe_unused s32g_serdes_resume(struct device *device)
 	return ret;
 }
 
+struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev, struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct device_node *pcs_np;
+	struct s32g_serdes *serdes;
+	u32 port;
+
+	if (of_property_read_u32(np, "reg", &port))
+		return ERR_PTR(-EINVAL);
+
+	if (port > S32G_SERDES_XPCS_MAX)
+		return ERR_PTR(-EINVAL);
+
+	/* The PCS pdev is attached to the parent node */
+	pcs_np = of_get_parent(np);
+	if (!pcs_np)
+		return ERR_PTR(-ENODEV);
+
+	if (!of_device_is_available(pcs_np)) {
+		of_node_put(pcs_np);
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdev = of_find_device_by_node(pcs_np);
+	of_node_put(pcs_np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	serdes = platform_get_drvdata(pdev);
+
+	return &serdes->xpcs.phys[port]->pcs;
+}
+EXPORT_SYMBOL(s32g_serdes_pcs_create);
+
 static const struct of_device_id s32g_serdes_match[] = {
 	{
 		.compatible = "nxp,s32g2-serdes",
diff --git a/drivers/phy/freescale/phy-nxp-s32g-xpcs.c b/drivers/phy/freescale/phy-nxp-s32g-xpcs.c
new file mode 100644
index 000000000000..c49bdaecc034
--- /dev/null
+++ b/drivers/phy/freescale/phy-nxp-s32g-xpcs.c
@@ -0,0 +1,1082 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Copyright 2021-2026 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/units.h>
+#include <linux/io.h>
+#include <linux/processor.h>
+#include <linux/regmap.h>
+#include "phy-nxp-s32g-xpcs.h"
+
+#define XPCS_TIMEOUT_MS				300
+
+#define ADDR1_OFS				0x3FC
+
+#define SR_MII_CTRL				0x1F0000
+#define   SR_RST				BIT(15)
+#define   SS13					BIT(13)
+#define   AN_ENABLE				BIT(12)
+#define   RESTART_AN				BIT(9)
+#define   DUPLEX_MODE				BIT(8)
+#define   SS6					BIT(6)
+#define SR_MII_STS				0x1F0001
+#define   LINK_STS				BIT(2)
+#define   AN_ABL				BIT(3)
+#define   AN_CMPL				BIT(5)
+#define SR_MII_DEV_ID1				0x1F0002
+#define SR_MII_DEV_ID2				0x1F0003
+#define SR_MII_EXT_STS				0x1F000F
+#define   CAP_1G_T_FD				BIT(13)
+#define   CAP_1G_T_HD				BIT(12)
+#define VR_MII_DIG_CTRL1			0x1F8000
+#define   BYP_PWRUP				BIT(1)
+#define   EN_2_5G_MODE				BIT(2)
+#define   CL37_TMR_OVRRIDE			BIT(3)
+#define   INIT					BIT(8)
+#define   MAC_AUTO_SW				BIT(9)
+#define   CS_EN					BIT(10)
+#define   PWRSV					BIT(11)
+#define   EN_VSMMD1				BIT(13)
+#define   R2TLBE				BIT(14)
+#define   VR_RST				BIT(15)
+#define VR_MII_AN_CTRL				0x1F8001
+#define   MII_AN_INTR_EN			BIT(0)
+#define   PCS_MODE_MASK				GENMASK(2, 1)
+#define    PCS_MODE_SGMII			2
+#define   MII_CTRL				BIT(8)
+#define VR_MII_AN_INTR_STS			0x1F8002
+#define  CL37_ANCMPLT_INTR			BIT(0)
+#define  CL37_ANSGM_STS_DUPLEX			BIT(1)
+#define  CL37_ANSGM_STS_SPEED_MASK		GENMASK(3, 2)
+#define   CL37_ANSGM_10MBPS			0
+#define   CL37_ANSGM_100MBPS			1
+#define   CL37_ANSGM_1000MBPS			2
+#define  CL37_ANSGM_STS_LINK			BIT(4)
+#define VR_MII_DBG_CTRL				0x1F8005
+#define   SUPPRESS_LOS_DET			BIT(4)
+#define   RX_DT_EN_CTL				BIT(6)
+#define VR_MII_LINK_TIMER_CTRL			0x1F800A
+#define VR_MII_DIG_STS				0x1F8010
+#define   PSEQ_STATE_MASK			GENMASK(4, 2)
+#define     POWER_GOOD_STATE			0x4
+#define VR_MII_GEN5_12G_16G_TX_GENCTRL1		0x1F8031
+#define   VBOOST_EN_0				BIT(4)
+#define   TX_CLK_RDY_0				BIT(12)
+#define	VR_MII_GEN5_12G_16G_TX_GENCTRL2		0x1F8032
+#define	  TX_REQ_0				BIT(0)
+#define VR_MII_GEN5_12G_16G_TX_RATE_CTRL	0x1F8034
+#define   TX0_RATE_MASK				GENMASK(2, 0)
+#define     TX0_BAUD_DIV_1			0
+#define     TX0_BAUD_DIV_4			2
+#define VR_MII_GEN5_12G_16G_TX_EQ_CTRL0		0x1F8036
+#define   TX_EQ_MAIN_MASK			GENMASK(13, 8)
+#define VR_MII_GEN5_12G_16G_TX_EQ_CTRL1		0x1F8037
+#define   TX_EQ_OVR_RIDE			BIT(6)
+#define VR_MII_CONSUMER_10G_TX_TERM_CTRL	0x1F803C
+#define   TX0_TERM_MASK				GENMASK(2, 0)
+#define VR_MII_GEN5_12G_16G_RX_GENCTRL1		0x1F8051
+#define   RX_RST_0				BIT(4)
+#define VR_MII_GEN5_12G_16G_RX_GENCTRL2		0x1F8052
+#define   RX_REQ_0				BIT(0)
+#define VR_MII_GEN5_12G_16G_RX_RATE_CTRL	0x1F8054
+#define   RX0_RATE_MASK				GENMASK(1, 0)
+#define     RX0_BAUD_DIV_2			0x1
+#define     RX0_BAUD_DIV_8			0x3
+#define VR_MII_GEN5_12G_16G_CDR_CTRL		0x1F8056
+#define   CDR_SSC_EN_0				BIT(4)
+#define   VCO_LOW_FREQ_0			BIT(8)
+#define VR_MII_GEN5_12G_16G_MPLL_CMN_CTRL	0x1F8070
+#define   MPLLB_SEL_0				BIT(4)
+#define VR_MII_GEN5_12G_16G_MPLLA_CTRL0		0x1F8071
+#define   MPLLA_CAL_DISABLE			BIT(15)
+#define   MLLA_MULTIPLIER_MASK			GENMASK(7, 0)
+#define VR_MII_GEN5_12G_MPLLA_CTRL1		0x1F8072
+#define   MPLLA_FRACN_CTRL_MASK			GENMASK(15, 5)
+#define VR_MII_GEN5_12G_16G_MPLLA_CTRL2		0x1F8073
+#define   MPLLA_TX_CLK_DIV_MASK			GENMASK(13, 11)
+#define   MPLLA_DIV10_CLK_EN			BIT(9)
+#define VR_MII_GEN5_12G_16G_MPLLB_CTRL0		0x1F8074
+#define   MPLLB_CAL_DISABLE			BIT(15)
+#define   MLLB_MULTIPLIER_OFF			0
+#define   MLLB_MULTIPLIER_MASK			0xFF
+#define VR_MII_GEN5_12G_MPLLB_CTRL1		0x1F8075
+#define   MPLLB_FRACN_CTRL_MASK			GENMASK(15, 5)
+#define VR_MII_GEN5_12G_16G_MPLLB_CTRL2		0x1F8076
+#define   MPLLB_TX_CLK_DIV_MASK			GENMASK(13, 11)
+#define   MPLLB_DIV10_CLK_EN			BIT(9)
+#define VR_MII_RX_LSTS				0x1F8020
+#define   RX_VALID_0				BIT(12)
+#define VR_MII_GEN5_12G_MPLLA_CTRL3		0x1F8077
+#define   MPLLA_BANDWIDTH_MASK			GENMASK(15, 0)
+#define VR_MII_GEN5_12G_MPLLB_CTRL3		0x1F8078
+#define   MPLLB_BANDWIDTH_MASK			GENMASK(15, 0)
+#define VR_MII_GEN5_12G_16G_MISC_CTRL0		0x1F8090
+#define   PLL_CTRL				BIT(15)
+#define VR_MII_GEN5_12G_16G_REF_CLK_CTRL	0x1F8091
+#define   REF_CLK_EN				BIT(0)
+#define   REF_USE_PAD				BIT(1)
+#define   REF_CLK_DIV2				BIT(2)
+#define   REF_RANGE_MASK			GENMASK(5, 3)
+#define     RANGE_26_53_MHZ			0x1
+#define     RANGE_52_78_MHZ			0x2
+#define     RANGE_78_104_MHZ			0x3
+#define   REF_MPLLA_DIV2			BIT(6)
+#define   REF_MPLLB_DIV2			BIT(7)
+#define   REF_RPT_CLK_EN			BIT(8)
+#define VR_MII_GEN5_12G_16G_VCO_CAL_LD0		0x1F8092
+#define   VCO_LD_VAL_0_MASK			GENMASK(12, 0)
+#define VR_MII_GEN5_12G_VCO_CAL_REF0		0x1F8096
+#define   VCO_REF_LD_0_MASK			GENMASK(5, 0)
+
+#define phylink_pcs_to_s32g_xpcs(pl_pcs) \
+	container_of((pl_pcs), struct s32g_xpcs, pcs)
+
+typedef bool (*xpcs_poll_func_t)(struct s32g_xpcs *);
+
+/*
+ * XPCS registers can't be access directly and an indirect address method
+ * must be used instead.
+ */
+
+static const struct regmap_range s32g_xpcs_wr_ranges[] = {
+	regmap_reg_range(0x1F0000, 0x1F0000),
+	regmap_reg_range(0x1F0004, 0x1F0004),
+	regmap_reg_range(0x1F8000, 0x1F8003),
+	regmap_reg_range(0x1F8005, 0x1F8005),
+	regmap_reg_range(0x1F800A, 0x1F800A),
+	regmap_reg_range(0x1F8012, 0x1F8012),
+	regmap_reg_range(0x1F8015, 0x1F8015),
+	regmap_reg_range(0x1F8030, 0x1F8037),
+	regmap_reg_range(0x1F803C, 0x1F803E),
+	regmap_reg_range(0x1F8050, 0x1F8058),
+	regmap_reg_range(0x1F805C, 0x1F805E),
+	regmap_reg_range(0x1F8064, 0x1F8064),
+	regmap_reg_range(0x1F806B, 0x1F806B),
+	regmap_reg_range(0x1F8070, 0x1F8078),
+	regmap_reg_range(0x1F8090, 0x1F8092),
+	regmap_reg_range(0x1F8096, 0x1F8096),
+	regmap_reg_range(0x1F8099, 0x1F8099),
+	regmap_reg_range(0x1F80A0, 0x1F80A2),
+	regmap_reg_range(0x1F80E1, 0x1F80E1),
+};
+
+static const struct regmap_access_table s32g_xpcs_wr_table = {
+	.yes_ranges = s32g_xpcs_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(s32g_xpcs_wr_ranges),
+};
+
+static const struct regmap_range s32g_xpcs_rd_ranges[] = {
+	regmap_reg_range(0x1F0000, 0x1F0006),
+	regmap_reg_range(0x1F000F, 0x1F000F),
+	regmap_reg_range(0x1F0708, 0x1F0710),
+	regmap_reg_range(0x1F8000, 0x1F8003),
+	regmap_reg_range(0x1F8005, 0x1F8005),
+	regmap_reg_range(0x1F800A, 0x1F800A),
+	regmap_reg_range(0x1F8010, 0x1F8012),
+	regmap_reg_range(0x1F8015, 0x1F8015),
+	regmap_reg_range(0x1F8018, 0x1F8018),
+	regmap_reg_range(0x1F8020, 0x1F8020),
+	regmap_reg_range(0x1F8030, 0x1F8037),
+	regmap_reg_range(0x1F803C, 0x1F803C),
+	regmap_reg_range(0x1F8040, 0x1F8040),
+	regmap_reg_range(0x1F8050, 0x1F8058),
+	regmap_reg_range(0x1F805C, 0x1F805E),
+	regmap_reg_range(0x1F8060, 0x1F8060),
+	regmap_reg_range(0x1F8064, 0x1F8064),
+	regmap_reg_range(0x1F806B, 0x1F806B),
+	regmap_reg_range(0x1F8070, 0x1F8078),
+	regmap_reg_range(0x1F8090, 0x1F8092),
+	regmap_reg_range(0x1F8096, 0x1F8096),
+	regmap_reg_range(0x1F8098, 0x1F8099),
+	regmap_reg_range(0x1F80A0, 0x1F80A2),
+	regmap_reg_range(0x1F80E1, 0x1F80E1),
+};
+
+static const struct regmap_access_table s32g_xpcs_rd_table = {
+	.yes_ranges = s32g_xpcs_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(s32g_xpcs_rd_ranges),
+};
+
+static int s32g_xpcs_regmap_reg_read(void *context, unsigned int reg,
+				     unsigned int *result)
+{
+	struct s32g_xpcs *xpcs = context;
+	u16 ofsleft = (reg >> 8) & 0xffffU;
+	u16 ofsright = (reg & 0xffU);
+
+	writew(ofsleft, xpcs->base + ADDR1_OFS);
+	*result = readw(xpcs->base + (ofsright * 4));
+
+	return 0;
+}
+
+static int s32g_xpcs_regmap_reg_write(void *context, unsigned int reg,
+				      unsigned int val)
+{
+	struct s32g_xpcs *xpcs = context;
+	u16 ofsleft = (reg >> 8) & 0xffffU;
+	u16 ofsright = (reg & 0xffU);
+
+	writew(ofsleft, xpcs->base + ADDR1_OFS);
+	writew(val, xpcs->base + (ofsright * 4));
+
+	return 0;
+}
+
+static const struct regmap_config s32g_xpcs_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_read = s32g_xpcs_regmap_reg_read,
+	.reg_write = s32g_xpcs_regmap_reg_write,
+	.wr_table = &s32g_xpcs_wr_table,
+	.rd_table = &s32g_xpcs_rd_table,
+	.max_register = 0x1F80E1,
+};
+
+static void s32g_xpcs_write_bits(struct s32g_xpcs *xpcs, unsigned int reg,
+				 unsigned int mask, unsigned int value)
+{
+	int ret = regmap_write_bits(xpcs->regmap, reg, mask, value);
+
+	if (ret)
+		dev_err(xpcs->dev, "Failed to write bits of XPCS reg: 0x%x\n", reg);
+}
+
+static void s32g_xpcs_write(struct s32g_xpcs *xpcs, unsigned int reg,
+			    unsigned int value)
+{
+	int ret = regmap_write(xpcs->regmap, reg, value);
+
+	if (ret)
+		dev_err(xpcs->dev, "Failed to write XPCS reg: 0x%x\n", reg);
+}
+
+static unsigned int s32g_xpcs_read(struct s32g_xpcs *xpcs, unsigned int reg)
+{
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(xpcs->regmap, reg, &val);
+	if (ret)
+		dev_err(xpcs->dev, "Failed to read XPCS reg: 0x%x\n", reg);
+
+	return val;
+}
+
+/*
+ * Internal XPCS function
+ */
+
+static unsigned int s32g_xpcs_get_an(struct s32g_xpcs *xpcs)
+{
+	unsigned int val = s32g_xpcs_read(xpcs, VR_MII_AN_INTR_STS);
+
+	return !!(val & CL37_ANCMPLT_INTR);
+};
+
+static int s32g_xpcs_wait_an_done(struct s32g_xpcs *xpcs)
+{
+	unsigned int val;
+
+	return read_poll_timeout(s32g_xpcs_get_an, val,
+				 !!(val & CL37_ANCMPLT_INTR),
+				 0,
+				 XPCS_TIMEOUT_MS, false, xpcs);
+};
+
+static bool s32g_xpcs_poll_timeout(struct s32g_xpcs *xpcs, xpcs_poll_func_t func,
+				   ktime_t timeout)
+{
+	ktime_t cur = ktime_get();
+
+	return func(xpcs) || ktime_after(cur, timeout);
+}
+
+static int s32g_xpcs_wait(struct s32g_xpcs *xpcs, xpcs_poll_func_t func)
+{
+	ktime_t timeout = ktime_add_ms(ktime_get(), XPCS_TIMEOUT_MS);
+
+	spin_until_cond(s32g_xpcs_poll_timeout(xpcs, func, timeout));
+	if (!func(xpcs))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int s32g_xpcs_wait_bits(struct s32g_xpcs *xpcs, unsigned int reg,
+			       unsigned int mask, unsigned int bits)
+{
+	ktime_t cur;
+	ktime_t timeout = ktime_add_ms(ktime_get(), XPCS_TIMEOUT_MS);
+
+	spin_until_cond((cur = ktime_get(),
+			 (s32g_xpcs_read(xpcs, reg) & mask) == bits ||
+			 ktime_after(cur, timeout)));
+	if ((s32g_xpcs_read(xpcs, reg) & mask) != bits)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static unsigned int s32g_xpcs_digital_status(struct s32g_xpcs *xpcs)
+{
+	return s32g_xpcs_read(xpcs, VR_MII_DIG_STS);
+}
+
+static int s32g_xpcs_wait_power_good_state(struct s32g_xpcs *xpcs)
+{
+	unsigned int val;
+
+	return read_poll_timeout(s32g_xpcs_digital_status, val,
+				 FIELD_GET(PSEQ_STATE_MASK, val) == POWER_GOOD_STATE,
+				 0,
+				 XPCS_TIMEOUT_MS, false, xpcs);
+}
+
+int s32g_xpcs_vreset(struct s32g_xpcs *xpcs)
+{
+	if (!xpcs)
+		return -EINVAL;
+
+	/* Step 19 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, VR_RST, VR_RST);
+
+	return 0;
+}
+
+static bool s32g_xpcs_is_not_in_reset(struct s32g_xpcs *xpcs)
+{
+	unsigned int val;
+
+	val = s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
+
+	return !(val & VR_RST);
+}
+
+int s32g_xpcs_wait_vreset(struct s32g_xpcs *xpcs)
+{
+	int ret;
+
+	/* Step 20 */
+	ret = s32g_xpcs_wait(xpcs, s32g_xpcs_is_not_in_reset);
+	if (ret)
+		dev_err(xpcs->dev, "XPCS%d is in reset\n", xpcs->id);
+
+	return ret;
+}
+
+int s32g_xpcs_reset_rx(struct s32g_xpcs *xpcs)
+{
+	int ret = 0;
+
+	ret = s32g_xpcs_wait_power_good_state(xpcs);
+	if (ret) {
+		dev_err(xpcs->dev, "Failed to enter in PGOOD state after vendor reset\n");
+		return ret;
+	}
+
+	/* Step 21 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL1,
+			     RX_RST_0, RX_RST_0);
+
+	/* Step 22 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL1,
+			     RX_RST_0, 0);
+
+	/* Step 23 */
+	/* Wait until SR_MII_STS[LINK_STS] = 1 */
+
+	return ret;
+}
+
+static int s32g_xpcs_ref_clk_sel(struct s32g_xpcs *xpcs,
+				 enum s32g_xpcs_pll ref_pll)
+{
+	switch (ref_pll) {
+	case XPCS_PLLA:
+		s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLL_CMN_CTRL,
+				     MPLLB_SEL_0, 0);
+		xpcs->ref = XPCS_PLLA;
+		break;
+	case XPCS_PLLB:
+		s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLL_CMN_CTRL,
+				     MPLLB_SEL_0, MPLLB_SEL_0);
+		xpcs->ref = XPCS_PLLB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void s32g_xpcs_electrical_configure(struct s32g_xpcs *xpcs)
+{
+	/* Step 2 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_EQ_CTRL0,
+			     TX_EQ_MAIN_MASK, FIELD_PREP(TX_EQ_MAIN_MASK, 0xC));
+
+	/* Step 3 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_CONSUMER_10G_TX_TERM_CTRL,
+			     TX0_TERM_MASK, FIELD_PREP(TX0_TERM_MASK, 0x4));
+}
+
+static int s32g_xpcs_vco_cfg(struct s32g_xpcs *xpcs, enum s32g_xpcs_pll vco_pll)
+{
+	unsigned int vco_ld = 0;
+	unsigned int vco_ref = 0;
+	unsigned int rx_baud = 0;
+	unsigned int tx_baud = 0;
+
+	switch (vco_pll) {
+	case XPCS_PLLA:
+		if (xpcs->mhz125) {
+			vco_ld = FIELD_PREP(VCO_LD_VAL_0_MASK, 1360);
+			vco_ref = FIELD_PREP(VCO_REF_LD_0_MASK, 17);
+		} else {
+			vco_ld = FIELD_PREP(VCO_LD_VAL_0_MASK, 1350);
+			vco_ref = FIELD_PREP(VCO_REF_LD_0_MASK, 27);
+		}
+
+		rx_baud = FIELD_PREP(RX0_RATE_MASK, RX0_BAUD_DIV_8);
+		tx_baud = FIELD_PREP(TX0_RATE_MASK, TX0_BAUD_DIV_4);
+		break;
+	case XPCS_PLLB:
+		if (xpcs->mhz125) {
+			vco_ld = FIELD_PREP(VCO_LD_VAL_0_MASK, 1350);
+			vco_ref = FIELD_PREP(VCO_REF_LD_0_MASK, 27);
+		} else {
+			vco_ld = FIELD_PREP(VCO_LD_VAL_0_MASK, 1344);
+			vco_ref = FIELD_PREP(VCO_REF_LD_0_MASK, 43);
+		}
+
+		rx_baud = FIELD_PREP(RX0_RATE_MASK, RX0_BAUD_DIV_2);
+		tx_baud = FIELD_PREP(TX0_RATE_MASK, TX0_BAUD_DIV_1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_VCO_CAL_LD0,
+			     VCO_LD_VAL_0_MASK, vco_ld);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_VCO_CAL_REF0,
+			     VCO_REF_LD_0_MASK, vco_ref);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_RATE_CTRL,
+			     TX0_RATE_MASK, tx_baud);
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_RATE_CTRL,
+			     RX0_RATE_MASK, rx_baud);
+
+	if (vco_pll == XPCS_PLLB) {
+		s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL,
+				     VCO_LOW_FREQ_0, VCO_LOW_FREQ_0);
+	} else {
+		s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL,
+				     VCO_LOW_FREQ_0, 0);
+	}
+
+	return 0;
+}
+
+static int s32g_xpcs_init_mplla(struct s32g_xpcs *xpcs)
+{
+	unsigned int val;
+
+	if (!xpcs)
+		return -EINVAL;
+
+	/* Step 7 */
+	val = 0;
+	if (xpcs->ext_clk)
+		val |= REF_USE_PAD;
+
+	if (xpcs->mhz125) {
+		val |= REF_MPLLA_DIV2;
+		val |= REF_CLK_DIV2;
+		val |= FIELD_PREP(REF_RANGE_MASK, RANGE_52_78_MHZ);
+	} else {
+		val |= FIELD_PREP(REF_RANGE_MASK, RANGE_26_53_MHZ);
+	}
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_REF_CLK_CTRL,
+			     REF_MPLLA_DIV2 | REF_USE_PAD | REF_RANGE_MASK |
+			     REF_CLK_DIV2, val);
+
+	/* Step 8 */
+	if (xpcs->mhz125)
+		val = FIELD_PREP(MLLA_MULTIPLIER_MASK, 80);
+	else
+		val = FIELD_PREP(MLLA_MULTIPLIER_MASK, 25);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLA_CTRL0,
+			     MPLLA_CAL_DISABLE | MLLA_MULTIPLIER_MASK,
+			     val);
+
+	/* Step 9 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLA_CTRL1,
+			     MPLLA_FRACN_CTRL_MASK, 0);
+
+	/* Step 10 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLA_CTRL2,
+			     MPLLA_TX_CLK_DIV_MASK | MPLLA_DIV10_CLK_EN,
+			     FIELD_PREP(MPLLA_TX_CLK_DIV_MASK, 1) | MPLLA_DIV10_CLK_EN);
+
+	/* Step 11 */
+	if (xpcs->mhz125)
+		val = FIELD_PREP(MPLLA_BANDWIDTH_MASK, 43);
+	else
+		val = FIELD_PREP(MPLLA_BANDWIDTH_MASK, 357);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLA_CTRL3,
+			     MPLLA_BANDWIDTH_MASK, val);
+
+	return 0;
+}
+
+static int s32g_xpcs_init_mpllb(struct s32g_xpcs *xpcs)
+{
+	unsigned int val;
+
+	if (!xpcs)
+		return -EINVAL;
+
+	/* Step 7 */
+	val = 0;
+	if (xpcs->ext_clk)
+		val |= REF_USE_PAD;
+
+	if (xpcs->mhz125) {
+		val |= REF_MPLLB_DIV2;
+		val |= REF_CLK_DIV2;
+		val |= FIELD_PREP(REF_RANGE_MASK, RANGE_52_78_MHZ);
+	} else {
+		val |= FIELD_PREP(REF_RANGE_MASK, RANGE_26_53_MHZ);
+	}
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_REF_CLK_CTRL,
+			     REF_MPLLB_DIV2 | REF_USE_PAD | REF_RANGE_MASK |
+			     REF_CLK_DIV2, val);
+
+	/* Step 8 */
+	if (xpcs->mhz125)
+		val = 125 << MLLB_MULTIPLIER_OFF;
+	else
+		val = 39 << MLLB_MULTIPLIER_OFF;
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLB_CTRL0,
+			     MPLLB_CAL_DISABLE | MLLB_MULTIPLIER_MASK,
+			     val);
+
+	/* Step 9 */
+	if (xpcs->mhz125)
+		val = FIELD_PREP(MPLLB_FRACN_CTRL_MASK, 0);
+	else
+		val = FIELD_PREP(MPLLB_FRACN_CTRL_MASK, 1044);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLB_CTRL1,
+			     MPLLB_FRACN_CTRL_MASK, val);
+
+	/* Step 10 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLB_CTRL2,
+			     MPLLB_TX_CLK_DIV_MASK | MPLLB_DIV10_CLK_EN,
+			     FIELD_PREP(MPLLB_TX_CLK_DIV_MASK, 5) | MPLLB_DIV10_CLK_EN);
+
+	/* Step 11 */
+	if (xpcs->mhz125)
+		val = FIELD_PREP(MPLLB_BANDWIDTH_MASK, 68);
+	else
+		val = FIELD_PREP(MPLLB_BANDWIDTH_MASK, 102);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLB_CTRL3,
+			     MPLLB_BANDWIDTH_MASK, val);
+
+	return 0;
+}
+
+static void s32g_serdes_pma_high_freq_recovery(struct s32g_xpcs *xpcs)
+{
+	/* PCS signal protection, PLL railout recovery */
+	s32g_xpcs_write_bits(xpcs, VR_MII_DBG_CTRL, SUPPRESS_LOS_DET | RX_DT_EN_CTL,
+			     SUPPRESS_LOS_DET | RX_DT_EN_CTL);
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MISC_CTRL0,
+			     PLL_CTRL, PLL_CTRL);
+}
+
+static void s32g_serdes_pma_configure_tx_eq_post(struct s32g_xpcs *xpcs)
+{
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_EQ_CTRL1,
+			     TX_EQ_OVR_RIDE, TX_EQ_OVR_RIDE);
+}
+
+static int s32g_serdes_bifurcation_pll_transit(struct s32g_xpcs *xpcs,
+					       enum s32g_xpcs_pll target_pll)
+{
+	int ret = 0;
+	struct device *dev = xpcs->dev;
+
+	/* Configure XPCS speed and VCO */
+	if (target_pll == XPCS_PLLA) {
+		s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, EN_2_5G_MODE, 0);
+		s32g_xpcs_vco_cfg(xpcs, XPCS_PLLA);
+	} else {
+		s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
+				     EN_2_5G_MODE, EN_2_5G_MODE);
+		s32g_xpcs_vco_cfg(xpcs, XPCS_PLLB);
+	}
+
+	/* Signal that clock are not available */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1,
+			     TX_CLK_RDY_0, 0);
+
+	/* Select PLL reference */
+	if (target_pll == XPCS_PLLA)
+		s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLA);
+	else
+		s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLB);
+
+	/* Initiate transmitter TX reconfiguration request */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL2,
+			     TX_REQ_0, TX_REQ_0);
+
+	/* Wait for transmitter to reconfigure */
+	ret = s32g_xpcs_wait_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL2,
+				  TX_REQ_0, 0);
+	if (ret) {
+		dev_err(dev, "Switch to TX_REQ_0 failed\n");
+		return ret;
+	}
+
+	/* Initiate transmitter RX reconfiguration request */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL2,
+			     RX_REQ_0, RX_REQ_0);
+
+	/* Wait for receiver to reconfigure */
+	ret = s32g_xpcs_wait_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL2,
+				  RX_REQ_0, 0);
+	if (ret) {
+		dev_err(dev, "Switch to RX_REQ_0 failed\n");
+		return ret;
+	}
+
+	/* Signal that clock are available */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1,
+			     TX_CLK_RDY_0, TX_CLK_RDY_0);
+
+	/* Flush internal logic */
+	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, INIT, INIT);
+
+	/* Wait for init */
+	ret = s32g_xpcs_wait_bits(xpcs, VR_MII_DIG_CTRL1, INIT, 0);
+	if (ret) {
+		dev_err(dev, "XPCS INIT failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+/*
+ * Note: This function should be compatible with phylink.
+ * That means it should only modify link, duplex, speed
+ * an_complete, pause.
+ */
+static int s32g_xpcs_get_state(struct s32g_xpcs *xpcs,
+			       struct phylink_link_state *state)
+{
+	struct device *dev = xpcs->dev;
+	unsigned int mii_ctrl, val, ss;
+	bool ss6, ss13, an_enabled, intr_en;
+
+	mii_ctrl = s32g_xpcs_read(xpcs, SR_MII_CTRL);
+	an_enabled = !!(mii_ctrl & AN_ENABLE);
+	intr_en = !!(s32g_xpcs_read(xpcs, VR_MII_AN_CTRL) & MII_AN_INTR_EN);
+
+	/* Check this important condition */
+	if (an_enabled && !intr_en) {
+		dev_err(dev, "Invalid SGMII AN config interrupt is disabled\n");
+		return -EINVAL;
+	}
+
+	if (an_enabled) {
+		/* MLO_AN_INBAND */
+		state->speed = SPEED_UNKNOWN;
+		state->link = 0;
+		state->duplex =  DUPLEX_UNKNOWN;
+		state->an_complete = 0;
+		state->pause = MLO_PAUSE_NONE;
+		val = s32g_xpcs_read(xpcs, VR_MII_AN_INTR_STS);
+
+		/* Interrupt is raised with each SGMII AN that is in cases
+		 * Link down - Every SGMII link timer expire
+		 * Link up - Once before link goes up
+		 * So either linkup or raised interrupt mean AN was completed
+		 */
+		if ((val & CL37_ANCMPLT_INTR) || (val & CL37_ANSGM_STS_LINK)) {
+			state->an_complete = 1;
+			if (val & CL37_ANSGM_STS_LINK)
+				state->link = 1;
+			else
+				return 0;
+			if (val & CL37_ANSGM_STS_DUPLEX)
+				state->duplex = DUPLEX_FULL;
+			else
+				state->duplex = DUPLEX_HALF;
+			ss = FIELD_GET(CL37_ANSGM_STS_SPEED_MASK, val);
+		} else {
+			return 0;
+		}
+
+	} else {
+		/* MLO_AN_FIXED, MLO_AN_PHY */
+		val = s32g_xpcs_read(xpcs, SR_MII_STS);
+		state->link = !!(val & LINK_STS);
+		state->an_complete = 0;
+		state->pause = MLO_PAUSE_NONE;
+
+		if (mii_ctrl & DUPLEX_MODE)
+			state->duplex = DUPLEX_FULL;
+		else
+			state->duplex = DUPLEX_HALF;
+
+		/*
+		 * Build similar value as CL37_ANSGM_STS_SPEED with
+		 * SS6 and SS13 of SR_MII_CTRL:
+		 *   - 0 for 10 Mbps
+		 *   - 1 for 100 Mbps
+		 *   - 2 for 1000 Mbps
+		 */
+		ss6 = !!(mii_ctrl & SS6);
+		ss13 = !!(mii_ctrl & SS13);
+		ss = ss6 << 1 | ss13;
+	}
+
+	switch (ss) {
+	case CL37_ANSGM_10MBPS:
+		state->speed = SPEED_10;
+		break;
+	case CL37_ANSGM_100MBPS:
+		state->speed = SPEED_100;
+		break;
+	case CL37_ANSGM_1000MBPS:
+		state->speed = SPEED_1000;
+		break;
+	default:
+		dev_err(dev, "Failed to interpret the value of SR_MII_CTRL\n");
+		break;
+	}
+
+	val = s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
+	if ((val & EN_2_5G_MODE) && state->speed == SPEED_1000)
+		state->speed = SPEED_2500;
+
+	/* Cover SGMII AN inability to distigunish between 1G and 2.5G */
+	if ((val & EN_2_5G_MODE) &&
+	    state->speed != SPEED_2500 && an_enabled) {
+		dev_err(dev, "Speed not supported in SGMII AN mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s32g_xpcs_config_an(struct s32g_xpcs *xpcs,
+			       const struct phylink_link_state state)
+{
+	bool an_enabled = false;
+
+	an_enabled = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				       state.advertising);
+	if (!an_enabled)
+		return 0;
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
+			     CL37_TMR_OVRRIDE, CL37_TMR_OVRRIDE);
+
+	s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
+			     PCS_MODE_MASK | MII_AN_INTR_EN,
+			     FIELD_PREP(PCS_MODE_MASK, PCS_MODE_SGMII) | MII_AN_INTR_EN);
+	/* Enable SGMII AN */
+	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, AN_ENABLE);
+	/* Enable SGMII AUTO SW */
+	s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
+			     MAC_AUTO_SW, MAC_AUTO_SW);
+
+	return 0;
+}
+
+static int s32g_xpcs_config(struct s32g_xpcs *xpcs,
+			    const struct phylink_link_state state)
+{
+	struct device *dev = xpcs->dev;
+	unsigned int val = 0, duplex = 0;
+	int ret = 0;
+	int speed = state.speed;
+	bool an_enabled;
+
+	/* Configure adaptive MII width */
+	s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_CTRL, 0);
+
+	an_enabled = !!(s32g_xpcs_read(xpcs, SR_MII_CTRL) & AN_ENABLE);
+
+	dev_dbg(dev, "xpcs_%d: speed=%u duplex=%d an=%d\n", xpcs->id,
+		speed, state.duplex, an_enabled);
+
+	if (an_enabled) {
+		switch (speed) {
+		case SPEED_10:
+		case SPEED_100:
+		case SPEED_1000:
+			s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x2faf);
+			break;
+		case SPEED_2500:
+			s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x7a1);
+			s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, MAC_AUTO_SW, 0);
+			break;
+		default:
+			dev_err(dev, "Speed not recognized. Can't setup xpcs\n");
+			return -EINVAL;
+		}
+
+		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, RESTART_AN, RESTART_AN);
+
+		ret = s32g_xpcs_wait_an_done(xpcs);
+		if (ret)
+			dev_warn(dev, "AN did not finish for XPCS%d", xpcs->id);
+
+		/* Clear the AN CMPL intr */
+		s32g_xpcs_write_bits(xpcs, VR_MII_AN_INTR_STS, CL37_ANCMPLT_INTR, 0);
+	} else {
+		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
+		s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_AN_INTR_EN, 0);
+
+		switch (speed) {
+		case SPEED_10:
+			break;
+		case SPEED_100:
+			val = SS13;
+			break;
+		case SPEED_1000:
+			val = SS6;
+			break;
+		case SPEED_2500:
+			val = SS6;
+			break;
+		default:
+			dev_err(dev, "Speed not supported\n");
+			break;
+		}
+
+		if (state.duplex == DUPLEX_FULL)
+			duplex = DUPLEX_MODE;
+
+		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, duplex);
+
+		if (speed == SPEED_2500) {
+			ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLB);
+			if (ret)
+				dev_err(dev, "Switch to PLLB failed\n");
+		} else {
+			ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLA);
+			if (ret)
+				dev_err(dev, "Switch to PLLA failed\n");
+		}
+
+		s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, SS6 | SS13, val);
+	}
+
+	return 0;
+}
+
+/*
+ * phylink_pcs_ops fops
+ */
+
+static void s32cc_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+					struct phylink_link_state *state)
+{
+	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
+
+	s32g_xpcs_get_state(xpcs, state);
+}
+
+static int s32cc_phylink_pcs_config(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising,
+				    bool permit_pause_to_mac)
+{
+	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
+	struct phylink_link_state state  = { 0 };
+
+	if (!(neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED))
+		return 0;
+
+	linkmode_copy(state.advertising, advertising);
+
+	return s32g_xpcs_config_an(xpcs, state);
+}
+
+static void s32cc_phylink_pcs_restart_an(struct phylink_pcs *pcs)
+{
+	/* Not yet */
+}
+
+static void s32cc_phylink_pcs_link_up(struct phylink_pcs *pcs,
+				      unsigned int neg_mode,
+				      phy_interface_t interface, int speed,
+				      int duplex)
+{
+	struct s32g_xpcs *xpcs = phylink_pcs_to_s32g_xpcs(pcs);
+	struct phylink_link_state state = { 0 };
+
+	state.speed = speed;
+	state.duplex = duplex;
+	state.an_complete = false;
+
+	s32g_xpcs_config(xpcs, state);
+}
+
+static const struct phylink_pcs_ops s32cc_phylink_pcs_ops = {
+	.pcs_get_state = s32cc_phylink_pcs_get_state,
+	.pcs_config = s32cc_phylink_pcs_config,
+	.pcs_an_restart = s32cc_phylink_pcs_restart_an,
+	.pcs_link_up = s32cc_phylink_pcs_link_up,
+};
+
+/*
+ * Serdes functions for initializing/configuring/releasing the xpcs
+ */
+
+int s32g_xpcs_pre_pcie_2g5(struct s32g_xpcs *xpcs)
+{
+	int ret;
+
+	/* Enable voltage boost */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1, VBOOST_EN_0,
+			     VBOOST_EN_0);
+
+	/* TX rate baud  */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_RATE_CTRL, 0x7, 0x0U);
+
+	/* Rx rate baud/2 */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_RATE_CTRL, 0x3U, 0x1U);
+
+	/* Set low-frequency operating band */
+	s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL, CDR_SSC_EN_0,
+			     VCO_LOW_FREQ_0);
+
+	ret = s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLB);
+	if (ret)
+		dev_err(xpcs->dev, "Switch to PLLB failed\n");
+
+	return ret;
+}
+
+int s32g_xpcs_init_plls(struct s32g_xpcs *xpcs)
+{
+	int ret;
+	struct device *dev = xpcs->dev;
+
+	if (!xpcs->ext_clk) {
+		/* Step 1 */
+		s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, BYP_PWRUP, BYP_PWRUP);
+	} else if (xpcs->pcie_shared == NOT_SHARED) {
+		ret = s32g_xpcs_wait_power_good_state(xpcs);
+		if (ret)
+			return ret;
+	} else if (xpcs->pcie_shared == PCIE_XPCS_2G5) {
+		ret = s32g_xpcs_wait_power_good_state(xpcs);
+		if (ret)
+			return ret;
+		/* Configure equalization */
+		s32g_serdes_pma_configure_tx_eq_post(xpcs);
+		s32g_xpcs_electrical_configure(xpcs);
+
+		/* Enable receiver recover */
+		s32g_serdes_pma_high_freq_recovery(xpcs);
+		return 0;
+	}
+
+	s32g_xpcs_electrical_configure(xpcs);
+
+	s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLA);
+	ret = s32g_xpcs_init_mplla(xpcs);
+	if (ret) {
+		dev_err(dev, "Failed to initialize PLLA\n");
+		return ret;
+	}
+	ret = s32g_xpcs_init_mpllb(xpcs);
+	if (ret) {
+		dev_err(dev, "Failed to initialize PLLB\n");
+		return ret;
+	}
+	s32g_xpcs_vco_cfg(xpcs, XPCS_PLLA);
+
+	/* Step 18 */
+	if (!xpcs->ext_clk)
+		s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, BYP_PWRUP, 0);
+
+	/* Will be cleared by Step 19 Vreset ??? */
+	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
+	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, DUPLEX_MODE);
+
+	return ret;
+}
+
+int s32g_xpcs_disable_an(struct s32g_xpcs *xpcs)
+{
+	int ret;
+
+	ret = (s32g_xpcs_read(xpcs, SR_MII_CTRL) & AN_ENABLE);
+
+	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, DUPLEX_MODE);
+	s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
+
+	return ret;
+}
+
+int s32g_xpcs_init(struct s32g_xpcs *xpcs, struct device *dev,
+		   unsigned char id, void __iomem *base, bool ext_clk,
+		   unsigned long rate, enum pcie_xpcs_mode pcie_shared)
+{
+	struct regmap_config conf;
+
+	if (rate != (125 * HZ_PER_MHZ) && rate != (100 * HZ_PER_MHZ)) {
+		dev_err(dev, "XPCS cannot operate @%lu HZ\n", rate);
+		return -EINVAL;
+	}
+
+	xpcs->base = base;
+	xpcs->ext_clk = ext_clk;
+	xpcs->id = id;
+	xpcs->dev = dev;
+	xpcs->pcie_shared = pcie_shared;
+
+	if (rate == (125 * HZ_PER_MHZ))
+		xpcs->mhz125 = true;
+	else
+		xpcs->mhz125 = false;
+
+	conf = s32g_xpcs_regmap_config;
+
+	if (!id)
+		conf.name = "xpcs0";
+	else
+		conf.name = "xpcs1";
+
+	xpcs->regmap = devm_regmap_init(dev, NULL, xpcs, &conf);
+	if (IS_ERR(xpcs->regmap))
+		return dev_err_probe(dev, PTR_ERR(xpcs->regmap),
+				     "Failed to init register amp\n");
+
+	/* Phylink PCS */
+	xpcs->pcs.ops = &s32cc_phylink_pcs_ops;
+	xpcs->pcs.poll = true;
+	__set_bit(PHY_INTERFACE_MODE_SGMII, xpcs->pcs.supported_interfaces);
+
+	return 0;
+}
diff --git a/drivers/phy/freescale/phy-nxp-s32g-xpcs.h b/drivers/phy/freescale/phy-nxp-s32g-xpcs.h
new file mode 100644
index 000000000000..07cdd292fd5e
--- /dev/null
+++ b/drivers/phy/freescale/phy-nxp-s32g-xpcs.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Copyright 2021-2026 NXP
+ */
+#ifndef NXP_S32G_XPCS_H
+#define NXP_S32G_XPCS_H
+
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/types.h>
+#include <linux/phylink.h>
+
+enum pcie_xpcs_mode {
+	NOT_SHARED,
+	PCIE_XPCS_1G,
+	PCIE_XPCS_2G5,
+};
+
+enum s32g_xpcs_pll {
+	XPCS_PLLA,	/* Slow PLL */
+	XPCS_PLLB,	/* Fast PLL */
+};
+
+struct s32g_xpcs {
+	void __iomem *base;
+	struct device *dev;
+	unsigned char id;
+	struct regmap *regmap;
+	enum s32g_xpcs_pll ref;
+	bool ext_clk;
+	bool mhz125;
+	bool an;
+	enum pcie_xpcs_mode pcie_shared;
+	struct phylink_pcs pcs;
+};
+
+int s32g_xpcs_init(struct s32g_xpcs *xpcs, struct device *dev,
+		   unsigned char id, void __iomem *base, bool ext_clk,
+		   unsigned long rate, enum pcie_xpcs_mode pcie_shared);
+int s32g_xpcs_init_plls(struct s32g_xpcs *xpcs);
+int s32g_xpcs_pre_pcie_2g5(struct s32g_xpcs *xpcs);
+int s32g_xpcs_vreset(struct s32g_xpcs *xpcs);
+int s32g_xpcs_wait_vreset(struct s32g_xpcs *xpcs);
+int s32g_xpcs_reset_rx(struct s32g_xpcs *xpcs);
+int s32g_xpcs_disable_an(struct s32g_xpcs *xpcs);
+#endif
+
diff --git a/include/linux/pcs/pcs-nxp-xpcs.h b/include/linux/pcs/pcs-nxp-xpcs.h
new file mode 100644
index 000000000000..41f424e8ff5b
--- /dev/null
+++ b/include/linux/pcs/pcs-nxp-xpcs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Copyright 2026 NXP
+ */
+
+#ifndef __LINUX_PCS_NXP_XPCS_H
+#define __LINUX_PCS_NXP_XPCS_H
+
+#include <linux/phylink.h>
+
+struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev, struct device_node *np);
+
+#endif /* __LINUX_PCS_XPCS_H */
-- 
2.43.0


