Return-Path: <netdev+bounces-224560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C64B86446
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0751E565FDC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB331A564;
	Thu, 18 Sep 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RMr9ZeE4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49B2BE051
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217158; cv=none; b=u4z8Ipta1el2SiLE1i6x+PRdSOchHp3NEoQhHb2aJ3Gi8tVRt2NJcA5xN3Oy87+r/r2L3izyqD9B3XXPI6Gw8EO1fFH9PfaOk8El1flO7qkYWB/WKW5xpP1uvj+FIxeVc6YNjLZxLFTdeH2zZE8gYCcPx2iRdSiV37n8Y/QqibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217158; c=relaxed/simple;
	bh=iMGdYkKFOawXClyJfwWvPBvNvI9b7v9Tzz8QpS60KuU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KWwQbFGjITbL9SFA1+nHn7SDdM5B4pMLGcdLGUvA2z8HIgjuPNWrsqG9rkBbOulO0O/ggYPAyVbrpdUyBCyDOnxBZuQBBqSdWm7fUrdUijp9mX8tDNRxyomiVDeQ2asWi9N1fQ0HsveysUpqTujvLEfkzcwouxnenIqCKe2YDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RMr9ZeE4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Old9cr2Q1IpiWpPbzwfu+lxZS7hTw7259vyVserGbSA=; b=RMr9ZeE4pIFrhPBXjncnh+OVUG
	4P4oXQsOryaQLaJsas15P82eKQPMmpwxPZx+6iU/KFQ7G9M+hpSWvQ6XMt2jQYxGTd4LA/Ktf8VPQ
	R+6tw5T4n6Ab0VWXlecgp7gn4BhSpzIy1nYxxnaa7yLdIiOR7i1xg6d6h2+8aBOKuJlWTLjnQT9qZ
	iqGy1REkW3n1NmnDzv2ay8Xh+Iswan4ya+3xY7JqVGv5+zJ5jujUmdtEr6Ec/AB2QFuPc//RoKNhO
	uixriEQ40yXdfevuFkjR0sEsrZ3RCO/MKWe3kAabU0PCRQqgMjVQg58YZJ4KT23Jg8zWqJnuYykEV
	4cOdQ49w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52216 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIb5-000000001ae-3w3w;
	Thu, 18 Sep 2025 18:39:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIb5-00000006mzK-0aob;
	Thu, 18 Sep 2025 18:39:07 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 03/20] net: phy: marvell: add PHY PTP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIb5-00000006mzK-0aob@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:07 +0100

Add PTP basic support for Marvell 88E151x PHYs.  These PHYs support
timestamping the egress and ingress of packets, but does not support
any packet modification, nor do we support any filtering beyond
selecting packets that the hardware recognises as PTP/802.1AS.

The PHYs support hardware pins for providing an external clock for the
TAI counter, and a separate pin that can be used for event capture or
generation of a trigger (either a pulse or periodic).  This code does
not support either of these modes.

We currently use a delayed work to poll for the timestamps which is
far from ideal, but we also provide a function that can be called from
an interrupt handler - which would be good to tie into the main Marvell
PHY driver.

The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
drivers.  The hardware is very similar to the implementation found in
the 88E6xxx DSA driver, but the access methods are very different,
although it may be possible to create a library that both can use
along with accessor functions.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/Kconfig       |  13 ++
 drivers/net/phy/Makefile      |   1 +
 drivers/net/phy/marvell.c     |  15 +-
 drivers/net/phy/marvell_ptp.c | 369 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/marvell_ptp.h |  17 ++
 5 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/marvell_ptp.c
 create mode 100644 drivers/net/phy/marvell_ptp.h

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ca05166ae605..ac29dc94a575 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -253,6 +253,19 @@ config MARVELL_PHY
 	help
 	  Currently has a driver for the 88E1XXX
 
+config MARVELL_PHY_PTP
+	bool "Marvell PHY PTP support"
+	depends on NETWORK_PHY_TIMESTAMPING
+	depends on (MARVELL_PHY = y && PTP_1588_CLOCK = y) || \
+		   (MARVELL_PHY = m && PTP_1588_CLOCK)
+	select PTP_1588_CLOCK_MARVELL
+	help
+	  Support PHY timestamping on Marvell 88E1510, 88E1512, 88E1514
+	  and 88E1518 PHYs.
+
+	  N.B. In order for this to be fully functional, your MAC driver
+	  must call the skb_tx_timestamp() function.
+
 config MARVELL_10G_PHY
 	tristate "Marvell Alaska 10Gbit PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 76e0db40f879..113eee38f253 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
+obj-$(CONFIG_MARVELL_PHY_PTP)	+= marvell_ptp.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 0ea366c1217e..745f95a71fc0 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -38,6 +38,8 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
+#include "marvell_ptp.h"
+
 #define MII_MARVELL_PHY_PAGE		22
 #define MII_MARVELL_COPPER_PAGE		0x00
 #define MII_MARVELL_FIBER_PAGE		0x01
@@ -3684,7 +3686,7 @@ static const struct sfp_upstream_ops m88e1510_sfp_ops = {
 	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
-static int m88e1510_probe(struct phy_device *phydev)
+static int m88e15xx_probe(struct phy_device *phydev)
 {
 	int err;
 
@@ -3695,6 +3697,17 @@ static int m88e1510_probe(struct phy_device *phydev)
 	return phy_sfp_probe(phydev, &m88e1510_sfp_ops);
 }
 
+static int m88e1510_probe(struct phy_device *phydev)
+{
+	int err;
+
+	err = m88e15xx_probe(phydev);
+	if (err)
+		return err;
+
+	return devm_marvell_phy_ptp_probe(phydev);
+}
+
 static struct phy_driver marvell_drivers[] = {
 	{
 		.phy_id = MARVELL_PHY_ID_88E1101,
diff --git a/drivers/net/phy/marvell_ptp.c b/drivers/net/phy/marvell_ptp.c
new file mode 100644
index 000000000000..662881df7fdf
--- /dev/null
+++ b/drivers/net/phy/marvell_ptp.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell PTP driver for 88E1510, 88E1512, 88E1514 and 88E1518 PHYs
+ *
+ * Ideas taken from 88E6xxx DSA and DP83640 drivers. This file
+ * implements the packet timestamping support only (PTP).  TAI
+ * support is separate.
+ */
+#include <linux/marvell_ptp.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+
+#include "marvell_ptp.h"
+
+#define MARVELL_PAGE_MISC			6
+#define GCR					20
+#define GCR_PTP_POWER_DOWN			BIT(9)
+#define GCR_PTP_REF_CLOCK_SOURCE		BIT(8)
+#define GCR_PTP_INPUT_SOURCE			BIT(7)
+#define GCR_PTP_OUTPUT				BIT(6)
+
+#define MARVELL_PAGE_PTP_PORT_1			8
+#define PTPP1_ARR0_STATUS			8
+#define PTPP1_ARR1_STATUS			12
+#define MARVELL_PAGE_PTP_PORT_2			9
+#define PTPP2_DEP_STATUS			0
+
+#define MARVELL_PAGE_TAI_GLOBAL			12
+#define MARVELL_PAGE_PTP_GLOBAL			14
+#define PTPG_READPLUS_COMMAND			14
+#define PTPG_READPLUS_DATA			15
+
+/* 88E151x has PTP Global Configuration 3
+ * 0 TSAtSFD - Timestamp at start of frame delimiter
+ */
+#define PTPG_CONFIG_3				3
+#define PTPG_CONFIG_3_TSATSFD			BIT(0)
+
+struct marvell_phy_ptp {
+	struct mii_timestamper mii_ts;
+	struct marvell_ts ts;
+};
+
+static struct marvell_phy_ptp *mii_ts_to_phy_ptp(struct mii_timestamper *mii_ts)
+{
+	return container_of(mii_ts, struct marvell_phy_ptp, mii_ts);
+}
+
+static bool marvell_phy_ptp_rxtstamp(struct mii_timestamper *mii_ts,
+				     struct sk_buff *skb, int type)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ts_rxtstamp(&phy_ptp->ts, skb, type);
+}
+
+static void marvell_phy_ptp_txtstamp(struct mii_timestamper *mii_ts,
+				     struct sk_buff *skb, int type)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) ||
+	    !marvell_ts_txtstamp(&phy_ptp->ts, skb, type))
+		kfree_skb(skb);
+}
+
+static int marvell_phy_ptp_hwtstamp(struct mii_timestamper *mii_ts,
+				    struct kernel_hwtstamp_config *kcfg,
+				    struct netlink_ext_ack *ack)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ts_hwtstamp_set(&phy_ptp->ts, kcfg, ack);
+}
+
+static int marvell_phy_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
+					struct kernel_hwtstamp_config *kcfg)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ts_hwtstamp_get(&phy_ptp->ts, kcfg);
+}
+
+static int marvell_phy_ptp_ts_info(struct mii_timestamper *mii_ts,
+				   struct kernel_ethtool_ts_info *ts_info)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ts_info(&phy_ptp->ts, ts_info);
+}
+
+/* TAI accessor functions */
+static int marvell_phy_tai_hw_enable(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_MISC, GCR,
+				GCR_PTP_POWER_DOWN, 0);
+}
+
+static void marvell_phy_tai_hw_disable(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	phy_modify_paged(phydev, MARVELL_PAGE_MISC, GCR,
+			 GCR_PTP_POWER_DOWN, GCR_PTP_POWER_DOWN);
+}
+
+static u64 marvell_phy_tai_clock_read(struct device *dev,
+				      struct ptp_system_timestamp *sts)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int err, oldpage, lo, hi;
+
+	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
+	if (oldpage >= 0) {
+		/* 88e151x says to write 0x8e0e */
+		ptp_read_system_prets(sts);
+		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
+		ptp_read_system_postts(sts);
+		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
+		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
+	}
+	err = phy_restore_page(phydev, oldpage, err);
+
+	if (err || lo < 0 || hi < 0)
+		return 0;
+
+	return lo | hi << 16;
+}
+
+static int marvell_phy_tai_write(struct device *dev, u8 reg, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_TAI_GLOBAL, reg, val);
+}
+
+static int marvell_phy_tai_modify(struct device *dev, u8 reg, u16 mask, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_TAI_GLOBAL,
+				reg, mask, val);
+}
+
+static long marvell_phy_tai_aux_work(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	struct marvell_phy_ptp *phy_ptp;
+
+	phy_ptp = mii_ts_to_phy_ptp(phydev->mii_ts);
+
+	return marvell_ts_aux_work(&phy_ptp->ts);
+}
+
+static const struct marvell_tai_ops marvell_phy_tai_ops = {
+	.tai_hw_enable = marvell_phy_tai_hw_enable,
+	.tai_hw_disable = marvell_phy_tai_hw_disable,
+	.tai_clock_read = marvell_phy_tai_clock_read,
+	.tai_write = marvell_phy_tai_write,
+	.tai_modify = marvell_phy_tai_modify,
+	.tai_aux_work = marvell_phy_tai_aux_work,
+};
+
+static const struct marvell_tai_param marvell_phy_tai_param = {
+	/* This assumes a 125MHz clock */
+	.cc_mult_num = 1 << 9,
+	.cc_mult_den = 15625U,
+	.cc_mult = 8 << 28,
+	.cc_shift = 28,
+};
+
+static int marvell_phy_ts_global_write(struct device *dev, u8 reg, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL, reg, val);
+}
+
+static const struct {
+	u8 page;
+	u8 reg;
+} marvell_phy_ts_ts_reg[] = {
+	[MARVELL_TS_ARR0] = {
+		.page = MARVELL_PAGE_PTP_PORT_1,
+		.reg = PTPP1_ARR0_STATUS,
+	},
+	[MARVELL_TS_ARR1] = {
+		.page = MARVELL_PAGE_PTP_PORT_1,
+		.reg = PTPP1_ARR1_STATUS,
+	},
+	[MARVELL_TS_DEP] = {
+		.page = MARVELL_PAGE_PTP_PORT_2,
+		.reg = PTPP2_DEP_STATUS,
+	},
+};
+
+/* Read the status, timestamp and PTP common header sequence from the PHY.
+ * Apparently, reading these are atomic, but there is no mention how the
+ * PHY treats this access as atomic. So, we set the DisTSOverwrite bit
+ * when configuring the PHY.
+ */
+static int marvell_phy_ts_port_read_ts(struct device *dev,
+				       struct marvell_hwts *hwts, u8 port,
+				       enum marvell_ts_reg ts_reg)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int oldpage, page, reg;
+	int ret;
+
+	page = marvell_phy_ts_ts_reg[ts_reg].page;
+	reg = marvell_phy_ts_ts_reg[ts_reg].reg;
+
+	/* Read status register */
+	oldpage = phy_select_page(phydev, page);
+	if (oldpage >= 0) {
+		ret = __phy_read(phydev, reg);
+		if (ret < 0)
+			goto restore;
+
+		hwts->stat = ret;
+		if (!(hwts->stat & MV_STATUS_VALID)) {
+			ret = 0;
+			goto restore;
+		}
+
+		/* Read low timestamp */
+		ret = __phy_read(phydev, reg + 1);
+		if (ret < 0)
+			goto restore;
+
+		hwts->time = ret;
+
+		/* Read high timestamp */
+		ret = __phy_read(phydev, reg + 2);
+		if (ret < 0)
+			goto restore;
+
+		hwts->time |= ret << 16;
+
+		/* Read sequence */
+		ret = __phy_read(phydev, reg + 3);
+		if (ret < 0)
+			goto restore;
+
+		hwts->seq = ret;
+
+		/* Clear valid */
+		__phy_write(phydev, reg, 0);
+
+		ret = 1;
+	}
+restore:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int marvell_phy_ts_port_write(struct device *dev, u8 port, u8 reg,
+				     u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1 + (reg >> 4),
+			       reg & 15, val);
+}
+
+static int marvell_phy_ts_port_modify(struct device *dev, u8 port, u8 reg,
+				      u16 mask, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_PTP_PORT_1 + (reg >> 4),
+				reg & 15, mask, val);
+}
+
+static const struct marvell_ts_ops marvell_phy_ts_ops = {
+	.ts_global_write = marvell_phy_ts_global_write,
+	.ts_port_read_ts = marvell_phy_ts_port_read_ts,
+	.ts_port_write = marvell_phy_ts_port_write,
+	.ts_port_modify = marvell_phy_ts_port_modify,
+};
+
+/* This function should be called from the PHY threaded interrupt
+ * handler to process any stored timestamps in a timely manner.
+ * The presence of an interrupt has an effect on how quickly a
+ * timestamp requiring received packet will be processed.
+ */
+irqreturn_t marvell_phy_ptp_irq(struct phy_device *phydev)
+{
+	struct marvell_phy_ptp *phy_ptp;
+
+	if (!phydev->mii_ts)
+		return IRQ_NONE;
+
+	phy_ptp = mii_ts_to_phy_ptp(phydev->mii_ts);
+
+	return marvell_ts_irq(&phy_ptp->ts);
+}
+EXPORT_SYMBOL_GPL(marvell_phy_ptp_irq);
+
+static void marvell_phy_ptp_remove(void *_data)
+{
+	struct phy_device *phydev = _data;
+
+	/* Disconnect from the net subsystem - we assume there is no
+	 * packet activity at this point.
+	 */
+	phydev->mii_ts = NULL;
+}
+
+/* 88e1510 can filter on 802.1AS frames, IEEE1588v1/v2 frames or both.
+ *   802.1AS frames can be matched by TransSpec = 1
+ */
+static const struct marvell_ts_caps marvell_phy_ts_caps = {
+	.rx_filters = BIT(HWTSTAMP_FILTER_SOME),
+};
+
+int devm_marvell_phy_ptp_probe(struct phy_device *phydev)
+{
+	struct marvell_phy_ptp *phy_ptp;
+	struct marvell_tai *tai;
+	struct device *dev;
+	int err;
+
+	dev = &phydev->mdio.dev;
+
+	phy_ptp = devm_kzalloc(dev, sizeof(*phy_ptp), GFP_KERNEL);
+	if (!phy_ptp)
+		return -ENOMEM;
+
+	phy_ptp->mii_ts.rxtstamp = marvell_phy_ptp_rxtstamp;
+	phy_ptp->mii_ts.txtstamp = marvell_phy_ptp_txtstamp;
+	phy_ptp->mii_ts.hwtstamp = marvell_phy_ptp_hwtstamp;
+	phy_ptp->mii_ts.hwtstamp_get = marvell_phy_ptp_hwtstamp_get;
+	phy_ptp->mii_ts.ts_info = marvell_phy_ptp_ts_info;
+
+	/* Get the TAI for this PHY. */
+	err = devm_marvell_tai_probe(&tai, &marvell_phy_tai_ops,
+				     &marvell_phy_tai_param, NULL,
+				     "Marvell PHY", dev);
+	if (err)
+		return err;
+
+	/* Setup the global PTP configuration */
+	err = marvell_ts_global_config(dev, &marvell_phy_ts_ops);
+	if (err)
+		return err;
+
+	/* PHY specific global configuration - set TSAtSFD, timestamp at SFD */
+	err = marvell_phy_ts_global_write(dev, PTPG_CONFIG_3,
+					  PTPG_CONFIG_3_TSATSFD);
+	if (err < 0)
+		return err;
+
+	err = devm_marvell_ts_probe(&phy_ptp->ts, dev, tai,
+				    &marvell_phy_ts_caps,
+				    &marvell_phy_ts_ops, 0);
+	if (err)
+		return err;
+
+	phydev->mii_ts = &phy_ptp->mii_ts;
+
+	return devm_add_action_or_reset(dev, marvell_phy_ptp_remove, phydev);
+}
+EXPORT_SYMBOL_GPL(devm_marvell_phy_ptp_probe);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Marvell PHY PTP library");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/phy/marvell_ptp.h b/drivers/net/phy/marvell_ptp.h
new file mode 100644
index 000000000000..7e712aed2eaa
--- /dev/null
+++ b/drivers/net/phy/marvell_ptp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MARVELL_PTP_H
+#define MARVELL_PTP_H
+
+#if IS_ENABLED(CONFIG_MARVELL_PHY_PTP)
+irqreturn_t marvell_phy_ptp_irq(struct phy_device *phydev);
+int devm_marvell_phy_ptp_probe(struct phy_device *phydev);
+#else
+static inline int marvell_phy_ptp_dummy_probe(void)
+{
+	return 0;
+}
+#define devm_marvell_phy_ptp_probe(x...) marvell_phy_ptp_dummy_probe()
+
+#endif
+
+#endif
-- 
2.47.3


