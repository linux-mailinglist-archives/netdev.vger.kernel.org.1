Return-Path: <netdev+bounces-179666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E5A7E096
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E378F16FD3D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59C1C84D3;
	Mon,  7 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmPn5kqY"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B731C3029;
	Mon,  7 Apr 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034594; cv=none; b=sSNyGZy/IzoAY9vK/oQDdIS/uX0XZkk4lPFeuxzY/JBt4OPaADh+7nFIE/jarrceMsEzFwE1uhNvXNmfmypDt9XrXgyVINPeoVpcmc+Wkan8mt9Mv/3JoYolfCIrVyuqn05kzCWYTiX4FJiFPYQpc/saEaJqvU8Ttg8dUa7hst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034594; c=relaxed/simple;
	bh=kaYpzNsG3nR8AQCttap1yDOaudRg+bkn0jZuzuEAAoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irE3nRbCjA8UH6USTXgO1WmRmgL+Pv1kjB5kMcJ8ZAUkqxbDpIM7LaXOlsdeVJdmsHW2NekExZiCMQLYEZIFMs0MFvZ2wle66KmWRaebgjUxrAWTchXw9sdxVPVn7lWludCqXFMTvNAgy+XdjMRu9hwW8+BRLA+EYDdBm0g4Vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmPn5kqY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A9CE442A3;
	Mon,  7 Apr 2025 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744034588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIY4dZAejMvdW8qH3Q1lX0brXRrS2sl8ykVMu3IeiCQ=;
	b=kmPn5kqYZOhGVfUZZ3TYMFUrwuCHE/x7yD7ESBlXpq0fR/i8Qt8oQtB2CnySPMoj1VlBTE
	spCfQVmVl9Oi0uorGFIBcLrx43N4g96V2Tb+TAacHJZl++0JVxuuiAWq9BSbbuVyMbwlTP
	qcpbzjkqQSEOewZiN3kD2nhe9R6JUzEHU4lSPQNDSGaWiorhqJjlUWMuzLF5Cy8zC8qeD6
	pSdOk7H/SZVzk7kzhIpXrOjd69THXXDN/IL3Uq4/LtJtGtgdE09dsDyE9TdJMcktqyrTrE
	88c7p0+J+zE5vtVqHnh2gMHxdeRMVoh/mDGQKIf4hk4MwmjtpCTd0D1ZSkCKyw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 07 Apr 2025 16:03:01 +0200
Subject: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
In-Reply-To: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpt
 hhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

From: Russell King <rmk+kernel@armlinux.org.uk>

From: Russell King <rmk+kernel@armlinux.org.uk>

Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
timestamping the egress and ingress of packets, but does not support
any packet modification.

The PHYs support hardware pins for providing an external clock for the
TAI counter, and a separate pin that can be used for event capture or
generation of a trigger (either a pulse or periodic).  This code does
not support either of these modes.

The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
drivers.  The hardware is very similar to the implementation found in
the 88E6xxx DSA driver, but the access methods are very different,
although it may be possible to create a library that both can use
along with accessor functions.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Add support for interruption.
Fix L2 PTP encapsulation frame detection.
Fix first PTP timestamp being dropped.
Fix Kconfig to depends on MARVELL_PHY.
Update comments to use kdoc.

Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Russell I don't know which email I should use, so I keep your old SOB.
---
 drivers/net/phy/marvell/Kconfig        |  12 +
 drivers/net/phy/marvell/Makefile       |   1 +
 drivers/net/phy/marvell/marvell_main.c |  18 +-
 drivers/net/phy/marvell/marvell_ptp.c  | 725 +++++++++++++++++++++++++++++++++
 drivers/net/phy/marvell/marvell_ptp.h  |  26 ++
 drivers/net/phy/marvell/marvell_tai.c  | 279 +++++++++++++
 drivers/net/phy/marvell/marvell_tai.h  |  36 ++
 7 files changed, 1096 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell/Kconfig b/drivers/net/phy/marvell/Kconfig
index a85bc9e4311e6bedd4a89db9527aca82d55a0762..2e4f42cfed9d1dfa16c1140e244c63b484e98ff9 100644
--- a/drivers/net/phy/marvell/Kconfig
+++ b/drivers/net/phy/marvell/Kconfig
@@ -4,6 +4,18 @@ config MARVELL_PHY
 	help
 	  Currently has a driver for the 88E1XXX
 
+config MARVELL_PHY_PTP
+	bool "Marvell PHY PTP support"
+	depends on NETWORK_PHY_TIMESTAMPING
+	depends on PTP_1588_CLOCK
+	depends on MARVELL_PHY
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
diff --git a/drivers/net/phy/marvell/Makefile b/drivers/net/phy/marvell/Makefile
index 2c3622b053d1f54eba518b06730b797fb103ee06..ec0540376d6dae09fd25e8c562eda72bb572a752 100644
--- a/drivers/net/phy/marvell/Makefile
+++ b/drivers/net/phy/marvell/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 marvell-y			:= marvell_main.o
+marvell-$(CONFIG_MARVELL_PHY_PTP)	+= marvell_ptp.o marvell_tai.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
diff --git a/drivers/net/phy/marvell/marvell_main.c b/drivers/net/phy/marvell/marvell_main.c
index 623292948fa706a2b0d8b98919ead8b609bbd949..7b52c153d78a2e8de081922d1eb6a097e6c595c1 100644
--- a/drivers/net/phy/marvell/marvell_main.c
+++ b/drivers/net/phy/marvell/marvell_main.c
@@ -38,6 +38,8 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
+#include "marvell_ptp.h"
+
 #define MII_MARVELL_PHY_PAGE		22
 #define MII_MARVELL_COPPER_PAGE		0x00
 #define MII_MARVELL_FIBER_PAGE		0x01
@@ -425,6 +427,15 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t m88e1510_handle_interrupt(struct phy_device *phydev)
+{
+	irqreturn_t handled;
+
+	handled = marvell_ptp_irq(phydev);
+	handled |= marvell_handle_interrupt(phydev);
+	return handled;
+}
+
 static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 {
 	u16 val;
@@ -3655,6 +3666,10 @@ static int m88e1510_probe(struct phy_device *phydev)
 	if (err)
 		return err;
 
+	err = marvell_ptp_probe(phydev);
+	if (err)
+		return err;
+
 	return phy_sfp_probe(phydev, &m88e1510_sfp_ops);
 }
 
@@ -3916,11 +3931,12 @@ static struct phy_driver marvell_drivers[] = {
 		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = m88e1510_probe,
+		.remove = marvell_ptp_remove,
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
 		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.handle_interrupt = m88e1510_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = marvell_resume,
diff --git a/drivers/net/phy/marvell/marvell_ptp.c b/drivers/net/phy/marvell/marvell_ptp.c
new file mode 100644
index 0000000000000000000000000000000000000000..e5d0378a97c4daaae9ad574a46de6b3afa82cbca
--- /dev/null
+++ b/drivers/net/phy/marvell/marvell_ptp.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell PTP driver for 88E1510, 88E1512, 88E1514 and 88E1518 PHYs
+ *
+ * Ideas taken from 88E6xxx DSA and DP83640 drivers. This file
+ * implements the packet timestamping support only (PTP).  TAI
+ * support is separate.
+ */
+#include <linux/if_vlan.h>
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
+#include <linux/phy.h>
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/uaccess.h>
+
+#include "marvell_ptp.h"
+#include "marvell_tai.h"
+
+#define TX_TIMEOUT_MS	40
+#define RX_TIMEOUT_MS	40
+
+#define MARVELL_PAGE_PTP_PORT_1			8
+#define PTP1_PORT_CONFIG_0			0
+#define PTP1_PORT_CONFIG_0_DISTSPECCHECK	BIT(11)
+#define PTP1_PORT_CONFIG_0_DISTSOVERWRITE	BIT(1)
+#define PTP1_PORT_CONFIG_0_DISPTP		BIT(0)
+#define PTP1_PORT_CONFIG_1			1
+#define PTP1_PORT_CONFIG_1_IPJUMP(x)		(((x) & 0x3f) << 8)
+#define PTP1_PORT_CONFIG_1_ETJUMP(x)		((x) & 0x1f)
+#define PTP1_PORT_CONFIG_2			2
+#define PTP1_PORT_CONFIG_2_DEPINTEN		BIT(1)
+#define PTP1_PORT_CONFIG_2_ARRINTEN		BIT(0)
+#define PTP1_ARR_STATUS0			8
+#define PTP1_ARR_STATUS1			12
+
+#define MARVELL_PAGE_PTP_PORT_2			9
+#define PTP2_DEP_STATUS				0
+
+#define MARVELL_PAGE_PTP_GLOBAL_CONFIG		14
+#define PTP_GLOBAL_CONFIG1			1
+
+struct marvell_ptp_cb {
+	unsigned long timeout;
+	u16 seq;
+};
+
+#define MARVELL_PTP_CB(skb)	((struct marvell_ptp_cb *)(skb)->cb)
+
+struct marvell_rxts {
+	struct list_head node;
+	u64 ns;
+	u16 seq;
+};
+
+struct marvell_ptp {
+	struct marvell_tai *tai;
+	struct list_head tai_node;
+	struct phy_device *phydev;
+	struct mii_timestamper mii_ts;
+
+	/* We only support one outstanding transmit skb */
+	struct sk_buff *tx_skb;
+	enum hwtstamp_tx_types tx_type;
+
+	struct mutex rx_mutex; /* Protect rx_queue, rx_pend and rx_free */
+	struct list_head rx_free;
+	struct list_head rx_pend;
+	struct sk_buff_head rx_queue;
+	enum hwtstamp_rx_filters rx_filter;
+	struct marvell_rxts rx_ts[64];
+
+	struct delayed_work ts_work;
+};
+
+struct marvell_ts {
+	u32 time;
+	u16 stat;
+#define MV_STATUS_INTSTATUS_MASK		0x0006
+#define MV_STATUS_INTSTATUS_NORMAL		0x0000
+#define MV_STATUS_VALID				BIT(0)
+	u16 seq;
+};
+
+/**
+ * marvell_read_tstamp - read the status, timestamp and sequence
+ * @phydev: Pointer to the phy_device structure
+ * @ts: Pointer to marvell_ts structure
+ * @page: Registers page number
+ * @reg: Register index
+ *
+ * Read the status, timestamp and PTP common header sequence from the PHY.
+ * Apparently, reading these are atomic, but there is no mention how the
+ * PHY treats this access as atomic. So, we set the DisTSOverwrite bit
+ * when configuring the PHY.
+ *
+ * Return: 1 on success, 0 for invalid status, failure value on error
+ */
+static int marvell_read_tstamp(struct phy_device *phydev,
+			       struct marvell_ts *ts,
+			       u8 page, u8 reg)
+{
+	int oldpage;
+	int ret = 0;
+
+	/* Read status register */
+	oldpage = phy_select_page(phydev, page);
+	if (oldpage >= 0) {
+		ret = __phy_read(phydev, reg);
+		if (ret < 0)
+			goto restore;
+
+		ts->stat = ret;
+		if (!(ts->stat & MV_STATUS_VALID)) {
+			ret = 0;
+			goto restore;
+		}
+
+		/* Read low timestamp */
+		ret = __phy_read(phydev, reg + 1);
+		if (ret < 0)
+			goto restore;
+
+		ts->time = ret;
+
+		/* Read high timestamp */
+		ret = __phy_read(phydev, reg + 2);
+		if (ret < 0)
+			goto restore;
+
+		ts->time |= ret << 16;
+
+		/* Read sequence */
+		ret = __phy_read(phydev, reg + 3);
+		if (ret < 0)
+			goto restore;
+
+		ts->seq = ret;
+
+		/* Clear valid */
+		__phy_write(phydev, reg, 0);
+
+		/* Return 1 as 0 is for invalid status */
+		ret = 1;
+	}
+restore:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static struct marvell_ptp *mii_ts_to_ptp(struct mii_timestamper *mii_ts)
+{
+	return container_of(mii_ts, struct marvell_ptp, mii_ts);
+}
+
+/**
+ * marvell_ptp_rx - Deliver skb with timestamp
+ * @skb: rx socket buffer
+ * @ns: Timestamp in ns
+ *
+ * Deliver a skb with its timestamp back to the networking core
+ */
+static void marvell_ptp_rx(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+
+	memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+	shhwtstamps->hwtstamp = ns_to_ktime(ns);
+	netif_rx(skb);
+}
+
+/**
+ * marvell_ptp_get_rxts - Get a rx timestamp entry
+ * @ptp: Pointer to marvell_ptp structure
+ *
+ * Get a rx timestamp entry. Try the free list, and if that fails,
+ * steal the oldest off the pending list.
+ *
+ * Return: marvell_rxts list element or zero
+ */
+static struct marvell_rxts *marvell_ptp_get_rxts(struct marvell_ptp *ptp)
+{
+	if (!list_empty(&ptp->rx_free))
+		return list_first_entry(&ptp->rx_free, struct marvell_rxts,
+					node);
+
+	return list_last_entry(&ptp->rx_pend, struct marvell_rxts, node);
+}
+
+/**
+ * marvell_ptp_rx_ts - Check for a rx timestamp entry
+ * @ptp: Pointer to marvell_ptp structure
+ *
+ * Check for a rx timestamp entry, try to find the corresponding skb and
+ * deliver it, otherwise add the rx timestamp to the queue of pending
+ * timestamps.
+ *
+ * Return: 1 if found, 0 if no rx timestamp, -1 in case of timestamp overrun
+ */
+static int marvell_ptp_rx_ts(struct marvell_ptp *ptp)
+{
+	struct marvell_rxts *rxts;
+	struct marvell_ts ts;
+	struct sk_buff *skb;
+	bool found = false;
+	u64 ns;
+	int err;
+
+	err = marvell_read_tstamp(ptp->phydev, &ts, MARVELL_PAGE_PTP_PORT_1,
+				  PTP1_ARR_STATUS0);
+	if (err <= 0)
+		return 0;
+
+	if ((ts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL) {
+		dev_warn(&ptp->phydev->mdio.dev,
+			 "rx timestamp overrun (%x)\n", ts.stat);
+		return -1;
+	}
+
+	ns = marvell_tai_cyc2time(ptp->tai, ts.time);
+
+	mutex_lock(&ptp->rx_mutex);
+
+	/* Search the rx queue for a matching skb */
+	skb_queue_walk(&ptp->rx_queue, skb) {
+		if (MARVELL_PTP_CB(skb)->seq == ts.seq) {
+			__skb_unlink(skb, &ptp->rx_queue);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		rxts = marvell_ptp_get_rxts(ptp);
+		rxts->ns = ns;
+		rxts->seq = ts.seq;
+		list_move(&rxts->node, &ptp->rx_pend);
+	}
+
+	mutex_unlock(&ptp->rx_mutex);
+
+	if (found)
+		marvell_ptp_rx(skb, ns);
+
+	return 1;
+}
+
+/**
+ * marvell_ptp_rxtstamp - Validate rx packet
+ * @mii_ts: Pointer to mii_timestamper structure
+ * @skb: rx socket buffer
+ * @type: PTP class type
+ *
+ * Check whether the packet is suitable for timestamping, and if so,
+ * try to find a pending timestamp for it. If no timestamp is found,
+ * queue the packet with a timeout.
+ *
+ * Return: true if a ptp packet detected and rx filter is enabled false
+ *	   otherwise.
+ */
+static bool marvell_ptp_rxtstamp(struct mii_timestamper *mii_ts,
+				 struct sk_buff *skb, int type)
+{
+	struct marvell_ptp *ptp = mii_ts_to_ptp(mii_ts);
+	struct ptp_header *ptp_hdr;
+	struct marvell_rxts *rxts;
+	bool found = false;
+	u16 seqid;
+	u64 ns;
+
+	if (ptp->rx_filter == HWTSTAMP_FILTER_NONE)
+		return false;
+
+	ptp_hdr = ptp_parse_header(skb, type);
+	if (!ptp_hdr)
+		return false;
+
+	seqid = ntohs(ptp_hdr->sequence_id);
+
+	mutex_lock(&ptp->rx_mutex);
+
+	/* Search the pending receive timestamps for a matching seqid */
+	list_for_each_entry(rxts, &ptp->rx_pend, node) {
+		if (rxts->seq == seqid) {
+			found = true;
+			ns = rxts->ns;
+			/* Move this timestamp entry to the free list */
+			list_move_tail(&rxts->node, &ptp->rx_free);
+			break;
+		}
+	}
+
+	if (!found) {
+		/* Store the seqid and queue the skb. Do this under the lock
+		 * to ensure we don't miss any timestamps appended to the
+		 * rx_pend list.
+		 */
+		MARVELL_PTP_CB(skb)->seq = seqid;
+		MARVELL_PTP_CB(skb)->timeout = jiffies +
+			msecs_to_jiffies(RX_TIMEOUT_MS);
+		__skb_queue_tail(&ptp->rx_queue, skb);
+	}
+
+	mutex_unlock(&ptp->rx_mutex);
+
+	if (found) {
+		/* We found the corresponding timestamp. If we can add the
+		 * timestamp, do we need to go through the netif_rx()
+		 * path, or would it be more efficient to add the timestamp
+		 * and return "false" here?
+		 */
+		marvell_ptp_rx(skb, ns);
+	} else {
+		if (ptp->phydev->irq < 0)
+			schedule_delayed_work(&ptp->ts_work, 2);
+	}
+
+	return true;
+}
+
+/**
+ * marvell_ptp_rx_expire - Manage expired socket
+ * @ptp: Pointer to marvell_ptp structure
+ *
+ * Move any expired skbs on to our own list, and then hand the contents of
+ * our list to netif_rx() - this avoids calling netif_rx() with our
+ * mutex held.
+ */
+static void marvell_ptp_rx_expire(struct marvell_ptp *ptp)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&list);
+
+	mutex_lock(&ptp->rx_mutex);
+	while ((skb = skb_dequeue(&ptp->rx_queue)) != NULL) {
+		if (!time_is_before_jiffies(MARVELL_PTP_CB(skb)->timeout)) {
+			__skb_queue_head(&ptp->rx_queue, skb);
+			break;
+		}
+		__skb_queue_tail(&list, skb);
+	}
+	mutex_unlock(&ptp->rx_mutex);
+
+	while ((skb = __skb_dequeue(&list)) != NULL)
+		netif_rx(skb);
+}
+
+/**
+ * marvell_ptp_txtstamp_complete - Complete tx timestamp
+ * @ptp: Pointer to marvell_ptp structure
+ *
+ * Complete the transmit timestamping. This is called to read the transmit
+ * timestamp from the PHY, and report back the transmitted timestamp.
+ *
+ * Return: 1 on success, 0 on tx timestamp timeout case, -1 on error
+ */
+static int marvell_ptp_txtstamp_complete(struct marvell_ptp *ptp)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb = ptp->tx_skb;
+	struct marvell_ts ts;
+	int err;
+	u64 ns;
+
+	err = marvell_read_tstamp(ptp->phydev, &ts, MARVELL_PAGE_PTP_PORT_2,
+				  PTP2_DEP_STATUS);
+	if (err < 0)
+		goto fail;
+
+	if (err == 0) {
+		if (time_is_before_jiffies(MARVELL_PTP_CB(skb)->timeout)) {
+			dev_warn(&ptp->phydev->mdio.dev,
+				 "tx timestamp timeout\n");
+			goto free;
+		}
+		return 0;
+	}
+
+	/* Check the status */
+	if ((ts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL) {
+		dev_warn(&ptp->phydev->mdio.dev,
+			 "tx timestamp overrun (%x)\n", ts.stat);
+		goto free;
+	}
+
+	/* Reject if the sequence number doesn't match */
+	if (ts.seq != MARVELL_PTP_CB(skb)->seq) {
+		dev_warn(&ptp->phydev->mdio.dev,
+			 "tx timestamp unexpected sequence id\n");
+		goto free;
+	}
+
+	ptp->tx_skb = NULL;
+
+	/* Set the timestamp */
+	ns = marvell_tai_cyc2time(ptp->tai, ts.time);
+	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+	shhwtstamps.hwtstamp = ns_to_ktime(ns);
+	skb_complete_tx_timestamp(skb, &shhwtstamps);
+	return 1;
+
+fail:
+	dev_err_ratelimited(&ptp->phydev->mdio.dev,
+			    "failed reading PTP: %pe\n", ERR_PTR(err));
+free:
+	dev_kfree_skb_any(skb);
+	ptp->tx_skb = NULL;
+	return -1;
+}
+
+/**
+ * marvell_ptp_do_txtstamp - Prepared tx socket with timestamping
+ * @mii_ts: Pointer to mii_timestamper structure
+ * @skb: tx socket buffer
+ * @type: PTP class type
+ *
+ * Check whether the skb will be timestamped on transmit. We only support
+ * a single outstanding skb. Add it if the slot is available.
+ *
+ * Return: True if packet can be transmitted false otherwise
+ */
+static bool marvell_ptp_do_txtstamp(struct mii_timestamper *mii_ts,
+				    struct sk_buff *skb, int type)
+{
+	struct marvell_ptp *ptp = mii_ts_to_ptp(mii_ts);
+	struct ptp_header *ptp_hdr;
+
+	if (ptp->tx_type != HWTSTAMP_TX_ON)
+		return false;
+
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		return false;
+
+	ptp_hdr = ptp_parse_header(skb, type);
+	if (!ptp_hdr)
+		return false;
+
+	MARVELL_PTP_CB(skb)->seq = ntohs(ptp_hdr->sequence_id);
+	MARVELL_PTP_CB(skb)->timeout = jiffies +
+		msecs_to_jiffies(TX_TIMEOUT_MS);
+
+	if (cmpxchg(&ptp->tx_skb, NULL, skb))
+		return false;
+
+	/* DP83640 marks the skb for hw timestamping. Since the MAC driver
+	 * may call skb_tx_timestamp() but may not support timestamping
+	 * itself, it may not set this flag. So, we need to do this here.
+	 */
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	if (ptp->phydev->irq < 0)
+		schedule_delayed_work(&ptp->ts_work, 2);
+
+	return true;
+}
+
+static void marvell_ptp_txtstamp(struct mii_timestamper *mii_ts,
+				 struct sk_buff *skb, int type)
+{
+	if (!marvell_ptp_do_txtstamp(mii_ts, skb, type))
+		kfree_skb(skb);
+}
+
+static int marvell_ptp_hwtstamp(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
+{
+	struct marvell_ptp *ptp = mii_ts_to_ptp(mii_ts);
+	u16 cfg0 = PTP1_PORT_CONFIG_0_DISPTP;
+	u16 cfg2 = 0;
+	int err;
+
+	if (config->flags)
+		return -EINVAL;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+
+	case HWTSTAMP_TX_ON:
+		cfg0 = 0;
+		if (ptp->phydev->irq >= 0)
+			cfg2 |= PTP1_PORT_CONFIG_2_DEPINTEN;
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		/* We accept 802.1AS, IEEE 1588v1 and IEEE 1588v2. We could
+		 * filter on 802.1AS using the transportSpecific field, but
+		 * that affects the transmit path too.
+		 */
+		config->rx_filter = HWTSTAMP_FILTER_SOME;
+		cfg0 = 0;
+		if (ptp->phydev->irq >= 0)
+			cfg2 |= PTP1_PORT_CONFIG_2_ARRINTEN;
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	err = phy_modify_paged(ptp->phydev, MARVELL_PAGE_PTP_PORT_1,
+			       PTP1_PORT_CONFIG_0,
+			       PTP1_PORT_CONFIG_0_DISPTP, cfg0);
+	if (err)
+		return err;
+
+	err = phy_write_paged(ptp->phydev, MARVELL_PAGE_PTP_PORT_1,
+			      PTP1_PORT_CONFIG_2, cfg2);
+	if (err)
+		return err;
+
+	ptp->tx_type = config->tx_type;
+	ptp->rx_filter = config->rx_filter;
+
+	return 0;
+}
+
+static int marvell_ptp_ts_info(struct mii_timestamper *mii_ts,
+			       struct kernel_ethtool_ts_info *ts_info)
+{
+	struct marvell_ptp *ptp = mii_ts_to_ptp(mii_ts);
+
+	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				   SOF_TIMESTAMPING_RX_HARDWARE |
+				   SOF_TIMESTAMPING_RAW_HARDWARE;
+	ts_info->phc_index = ptp_clock_index(ptp->tai->ptp_clock);
+	ts_info->tx_types = BIT(HWTSTAMP_TX_OFF) |
+			    BIT(HWTSTAMP_TX_ON);
+	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			      BIT(HWTSTAMP_FILTER_SOME);
+
+	return 0;
+}
+
+static int marvell_ptp_port_config(struct phy_device *phydev)
+{
+	int err;
+
+	/* Disable transport specific check (if the PTP common header)
+	 * Disable timestamp overwriting (so we can read a stable entry.)
+	 * Disable PTP
+	 */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1,
+			      PTP1_PORT_CONFIG_0,
+			      PTP1_PORT_CONFIG_0_DISTSPECCHECK |
+			      PTP1_PORT_CONFIG_0_DISTSOVERWRITE |
+			      PTP1_PORT_CONFIG_0_DISPTP);
+	if (err < 0)
+		return err;
+
+	/* Set ether-type jump to 12 (to ether protocol)
+	 * Set IP jump to 2 (to skip over ether protocol)
+	 * Does this mean it won't pick up on VLAN packets?
+	 */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1,
+			      PTP1_PORT_CONFIG_1,
+			      PTP1_PORT_CONFIG_1_ETJUMP(12) |
+			      PTP1_PORT_CONFIG_1_IPJUMP(2));
+	if (err < 0)
+		return err;
+
+	/* Timestamp only sync (MessageID 1) and delay_req (MessageID 2)
+	 * PTP frames
+	 */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL_CONFIG,
+			      PTP_GLOBAL_CONFIG1, 0x3);
+	if (err < 0)
+		return err;
+
+	/* Disable all interrupts */
+	phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1,
+			PTP1_PORT_CONFIG_2, 0);
+
+	return 0;
+}
+
+static void marvell_ptp_port_disable(struct phy_device *phydev)
+{
+	/* Disable PTP */
+	phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1,
+			PTP1_PORT_CONFIG_0, PTP1_PORT_CONFIG_0_DISPTP);
+
+	/* Disable interrupts */
+	phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1,
+			PTP1_PORT_CONFIG_2, 0);
+}
+
+/**
+ * marvell_ptp_irq - PTP IRQ handler
+ * @phydev: Pointer to phy_device structure
+ *
+ * Return: IRQ_HANDLED/IRQ_NONE
+ */
+irqreturn_t marvell_ptp_irq(struct phy_device *phydev)
+{
+	struct marvell_ptp *ptp;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!phydev->mii_ts)
+		return ret;
+
+	ptp = mii_ts_to_ptp(phydev->mii_ts);
+	if (marvell_ptp_rx_ts(ptp))
+		ret = IRQ_HANDLED;
+
+	if (ptp->tx_skb && marvell_ptp_txtstamp_complete(ptp))
+		ret = IRQ_HANDLED;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_irq);
+
+static void marvell_ptp_worker(struct work_struct *work)
+{
+	struct marvell_ptp *ptp = container_of(work, struct marvell_ptp,
+					       ts_work.work);
+
+	if (ptp->tx_skb)
+		marvell_ptp_txtstamp_complete(ptp);
+
+	marvell_ptp_rx_ts(ptp);
+
+	marvell_ptp_rx_expire(ptp);
+
+	if (!skb_queue_empty(&ptp->rx_queue) || ptp->tx_skb)
+		schedule_delayed_work(&ptp->ts_work, 2);
+}
+
+int marvell_ptp_probe(struct phy_device *phydev)
+{
+	struct marvell_ptp *ptp;
+	int err, i;
+
+	ptp = devm_kzalloc(&phydev->mdio.dev, sizeof(*ptp), GFP_KERNEL);
+	if (!ptp)
+		return -ENOMEM;
+
+	ptp->phydev = phydev;
+	ptp->mii_ts.rxtstamp = marvell_ptp_rxtstamp;
+	ptp->mii_ts.txtstamp = marvell_ptp_txtstamp;
+	ptp->mii_ts.hwtstamp = marvell_ptp_hwtstamp;
+	ptp->mii_ts.ts_info = marvell_ptp_ts_info;
+
+	/* No phy interrupt */
+	if (phydev->irq < 0)
+		INIT_DELAYED_WORK(&ptp->ts_work, marvell_ptp_worker);
+	mutex_init(&ptp->rx_mutex);
+	INIT_LIST_HEAD(&ptp->rx_free);
+	INIT_LIST_HEAD(&ptp->rx_pend);
+	skb_queue_head_init(&ptp->rx_queue);
+
+	for (i = 0; i < ARRAY_SIZE(ptp->rx_ts); i++)
+		list_add_tail(&ptp->rx_ts[i].node, &ptp->rx_free);
+
+	/* Get the TAI for this PHY. */
+	err = marvell_tai_get(&ptp->tai, phydev);
+	if (err)
+		return err;
+
+	/* Configure this PTP port */
+	err = marvell_ptp_port_config(phydev);
+	if (err) {
+		marvell_tai_put(ptp->tai);
+		return err;
+	}
+
+	phydev->mii_ts = &ptp->mii_ts;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_probe);
+
+void marvell_ptp_remove(struct phy_device *phydev)
+{
+	struct marvell_ptp *ptp;
+
+	if (!phydev->mii_ts)
+		return;
+
+	/* Disconnect from the net subsystem - we assume there is no
+	 * packet activity at this point.
+	 */
+	ptp = mii_ts_to_ptp(phydev->mii_ts);
+	phydev->mii_ts = NULL;
+
+	if (phydev->irq < 0)
+		cancel_delayed_work_sync(&ptp->ts_work);
+
+	/* Free or dequeue all pending skbs */
+	if (ptp->tx_skb)
+		kfree_skb(ptp->tx_skb);
+
+	skb_queue_purge(&ptp->rx_queue);
+
+	/* Ensure that the port is disabled */
+	marvell_ptp_port_disable(phydev);
+	marvell_tai_put(ptp->tai);
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_remove);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Marvell PHY PTP library");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/marvell/marvell_ptp.h b/drivers/net/phy/marvell/marvell_ptp.h
new file mode 100644
index 0000000000000000000000000000000000000000..678f7a499a19eafc8d5b8de32a3dfbdc3094acf8
--- /dev/null
+++ b/drivers/net/phy/marvell/marvell_ptp.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MARVELL_PTP_H
+#define MARVELL_PTP_H
+
+#if IS_ENABLED(CONFIG_MARVELL_PHY_PTP)
+void marvell_ptp_check(struct phy_device *phydev);
+int marvell_ptp_probe(struct phy_device *phydev);
+void marvell_ptp_remove(struct phy_device *phydev);
+irqreturn_t marvell_ptp_irq(struct phy_device *phydev);
+#else
+static inline int marvell_ptp_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline void marvell_ptp_remove(struct phy_device *phydev)
+{
+}
+
+static inline irqreturn_t marvell_ptp_irq(struct phy_device *phydev)
+{
+	return IRQ_NONE;
+}
+#endif
+
+#endif
diff --git a/drivers/net/phy/marvell/marvell_tai.c b/drivers/net/phy/marvell/marvell_tai.c
new file mode 100644
index 0000000000000000000000000000000000000000..f6608a0986ca7edd297b4de6699114109e5e6d4c
--- /dev/null
+++ b/drivers/net/phy/marvell/marvell_tai.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell PTP driver for 88E1510, 88E1512, 88E1514 and 88E1518 PHYs
+ *
+ * This file implements TAI support as a PTP clock. Timecounter/cyclecounter
+ * representation taken from Marvell 88E6xxx DSA driver. We may need to share
+ * the TAI between multiple PHYs in a multiport PHY.
+ */
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/phy.h>
+#include "marvell_tai.h"
+
+#define MARVELL_PAGE_MISC			6
+#define GCR					20
+#define GCR_PTP_POWER_DOWN			BIT(9)
+#define GCR_PTP_REF_CLOCK_SOURCE		BIT(8)
+#define GCR_PTP_INPUT_SOURCE			BIT(7)
+#define GCR_PTP_OUTPUT				BIT(6)
+
+#define MARVELL_PAGE_TAI_GLOBAL			12
+#define TAI_CONFIG_0				0
+#define TAI_CONFIG_0_EVENTCAPOV			BIT(15)
+#define TAI_CONFIG_0_TRIGGENINTEN		BIT(9)
+#define TAI_CONFIG_0_EVENTCAPINTEN		BIT(8)
+
+#define TAI_CONFIG_9				9
+#define TAI_CONFIG_9_EVENTERR			BIT(9)
+#define TAI_CONFIG_9_EVENTCAPVALID		BIT(8)
+
+#define TAI_EVENT_CAPTURE_TIME_LO		10
+#define TAI_EVENT_CAPTURE_TIME_HI		11
+
+#define MARVELL_PAGE_PTP_GLOBAL			14
+#define PTPG_CONFIG_0				0
+#define PTPG_CONFIG_1				1
+#define PTPG_CONFIG_2				2
+#define PTPG_CONFIG_3				3
+#define PTPG_CONFIG_3_TSATSFD			BIT(0)
+#define PTPG_STATUS				8
+#define PTPG_READPLUS_COMMAND			14
+#define PTPG_READPLUS_DATA			15
+
+static DEFINE_SPINLOCK(tai_list_lock);
+static LIST_HEAD(tai_list);
+
+static struct marvell_tai *cc_to_tai(const struct cyclecounter *cc)
+{
+	return container_of(cc, struct marvell_tai, cyclecounter);
+}
+
+/* Read the global time registers using the readplus command */
+static u64 marvell_tai_clock_read(const struct cyclecounter *cc)
+{
+	struct marvell_tai *tai = cc_to_tai(cc);
+	struct phy_device *phydev = tai->phydev;
+	int err, oldpage, lo, hi;
+
+	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
+	if (oldpage >= 0) {
+		/* 88e151x says to write 0x8e0e */
+		ptp_read_system_prets(tai->sts);
+		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
+		ptp_read_system_postts(tai->sts);
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
+u64 marvell_tai_cyc2time(struct marvell_tai *tai, u32 cyc)
+{
+	u64 ns;
+
+	mutex_lock(&tai->mutex);
+	ns = timecounter_cyc2time(&tai->timecounter, cyc);
+	mutex_unlock(&tai->mutex);
+
+	return ns;
+}
+
+static struct marvell_tai *ptp_to_tai(struct ptp_clock_info *ptp)
+{
+	return container_of(ptp, struct marvell_tai, caps);
+}
+
+static int marvell_tai_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	bool neg;
+	u32 diff;
+	u64 adj;
+
+	neg = scaled_ppm < 0;
+	if (neg)
+		scaled_ppm = -scaled_ppm;
+
+	adj = tai->cc_mult_num;
+	adj *= scaled_ppm;
+	diff = div_u64(adj, tai->cc_mult_den);
+
+	mutex_lock(&tai->mutex);
+	timecounter_read(&tai->timecounter);
+	tai->cyclecounter.mult = neg ? tai->cc_mult - diff :
+				       tai->cc_mult + diff;
+	mutex_unlock(&tai->mutex);
+
+	return 0;
+}
+
+static int marvell_tai_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+
+	mutex_lock(&tai->mutex);
+	timecounter_adjtime(&tai->timecounter, delta);
+	mutex_unlock(&tai->mutex);
+
+	return 0;
+}
+
+static int marvell_tai_gettimex64(struct ptp_clock_info *ptp,
+				  struct timespec64 *ts,
+				  struct ptp_system_timestamp *sts)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	u64 ns;
+
+	mutex_lock(&tai->mutex);
+	tai->sts = sts;
+	ns = timecounter_read(&tai->timecounter);
+	tai->sts = NULL;
+	mutex_unlock(&tai->mutex);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int marvell_tai_settime64(struct ptp_clock_info *ptp,
+				 const struct timespec64 *ts)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	u64 ns = timespec64_to_ns(ts);
+
+	mutex_lock(&tai->mutex);
+	timecounter_init(&tai->timecounter, &tai->cyclecounter, ns);
+	mutex_unlock(&tai->mutex);
+
+	return 0;
+}
+
+/* Periodically read the timecounter to keep the time refreshed. */
+static long marvell_tai_aux_work(struct ptp_clock_info *ptp)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+
+	mutex_lock(&tai->mutex);
+	timecounter_read(&tai->timecounter);
+	mutex_unlock(&tai->mutex);
+
+	return tai->half_overflow_period;
+}
+
+/* Configure the global (shared between ports) configuration for the PHY. */
+static int marvell_tai_global_config(struct phy_device *phydev)
+{
+	int err;
+
+	/* Power up PTP */
+	err = phy_modify_paged(phydev, MARVELL_PAGE_MISC, GCR,
+			       GCR_PTP_POWER_DOWN, 0);
+	if (err)
+		return err;
+
+	/* Set ether-type for IEEE1588 packets */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL,
+			      PTPG_CONFIG_0, ETH_P_1588);
+	if (err < 0)
+		return err;
+
+	/* MsdIDTSEn - Enable timestamping on all PTP MessageIDs */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL,
+			      PTPG_CONFIG_1, ~0);
+	if (err < 0)
+		return err;
+
+	/* TSArrPtr - Point to Arr0 registers */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL,
+			      PTPG_CONFIG_2, 0);
+	if (err < 0)
+		return err;
+
+	/* TSAtSFD - timestamp at SFD */
+	err = phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL,
+			      PTPG_CONFIG_3, PTPG_CONFIG_3_TSATSFD);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int marvell_tai_get(struct marvell_tai **taip, struct phy_device *phydev)
+{
+	struct marvell_tai *tai;
+	unsigned long overflow_ms;
+	int err;
+
+	err = marvell_tai_global_config(phydev);
+	if (err < 0)
+		return err;
+
+	tai = kzalloc(sizeof(*tai), GFP_KERNEL);
+	if (!tai)
+		return -ENOMEM;
+
+	mutex_init(&tai->mutex);
+
+	tai->phydev = phydev;
+
+	/* This assumes a 125MHz clock */
+	tai->cc_mult = 8 << 28;
+	tai->cc_mult_num = 1 << 9;
+	tai->cc_mult_den = 15625U;
+
+	tai->cyclecounter.read = marvell_tai_clock_read;
+	tai->cyclecounter.mask = CYCLECOUNTER_MASK(32);
+	tai->cyclecounter.mult = tai->cc_mult;
+	tai->cyclecounter.shift = 28;
+
+	overflow_ms = (1ULL << 32 * tai->cc_mult * 1000) >>
+			tai->cyclecounter.shift;
+	tai->half_overflow_period = msecs_to_jiffies(overflow_ms / 2);
+
+	timecounter_init(&tai->timecounter, &tai->cyclecounter,
+			 ktime_to_ns(ktime_get_real()));
+
+	tai->caps.owner = THIS_MODULE;
+	snprintf(tai->caps.name, sizeof(tai->caps.name), "Marvell PHY");
+	/* max_adj of 1000000 is what MV88E6xxx DSA uses */
+	tai->caps.max_adj = 1000000;
+	tai->caps.adjfine = marvell_tai_adjfine;
+	tai->caps.adjtime = marvell_tai_adjtime;
+	tai->caps.gettimex64 = marvell_tai_gettimex64;
+	tai->caps.settime64 = marvell_tai_settime64;
+	tai->caps.do_aux_work = marvell_tai_aux_work;
+
+	tai->ptp_clock = ptp_clock_register(&tai->caps, &phydev->mdio.dev);
+	if (IS_ERR(tai->ptp_clock)) {
+		kfree(tai);
+		return PTR_ERR(tai->ptp_clock);
+	}
+
+	ptp_schedule_worker(tai->ptp_clock, tai->half_overflow_period);
+
+	spin_lock(&tai_list_lock);
+	list_add_tail(&tai->tai_node, &tai_list);
+	spin_unlock(&tai_list_lock);
+
+	*taip = tai;
+
+	return 0;
+}
+
+void marvell_tai_put(struct marvell_tai *tai)
+{
+	ptp_clock_unregister(tai->ptp_clock);
+
+	spin_lock(&tai_list_lock);
+	list_del(&tai->tai_node);
+	spin_unlock(&tai_list_lock);
+
+	kfree(tai);
+}
diff --git a/drivers/net/phy/marvell/marvell_tai.h b/drivers/net/phy/marvell/marvell_tai.h
new file mode 100644
index 0000000000000000000000000000000000000000..bab8b430bcdd4db685b1025187d793ec3091fed8
--- /dev/null
+++ b/drivers/net/phy/marvell/marvell_tai.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MARVELL_TAI_H
+#define MARVELL_TAI_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+
+struct phy_device;
+
+struct marvell_tai {
+	struct list_head tai_node;
+	struct phy_device *phydev;
+
+	struct ptp_clock_info caps;
+	struct ptp_clock *ptp_clock;
+
+	u32 cc_mult_num;
+	u32 cc_mult_den;
+	u32 cc_mult;
+
+	struct mutex mutex; /* Portect timecouter and cyclecounter */
+	struct timecounter timecounter;
+	struct cyclecounter cyclecounter;
+	long half_overflow_period;
+
+	/* Used while reading the TAI */
+	struct ptp_system_timestamp *sts;
+};
+
+u64 marvell_tai_cyc2time(struct marvell_tai *tai, u32 cyc);
+int marvell_tai_get(struct marvell_tai **taip, struct phy_device *phydev);
+void marvell_tai_put(struct marvell_tai *tai);
+
+#endif

-- 
2.34.1


