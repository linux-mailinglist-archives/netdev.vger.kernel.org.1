Return-Path: <netdev+bounces-224570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC559B86476
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396281CC4375
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586430FC09;
	Thu, 18 Sep 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LBrr5G+N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582832D2381
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217207; cv=none; b=JW3xq1TUYPFmuEMVfrl//6L+EjdTbb+uLZUyjTyyzQl2/u+KK8jpiB1Pum0ow9NwcA158WjQa+KqAsnecZvi8wQx6ZMY17vFk+vdg55K/Wka+rheO45zyidk2czCbnuwsEJo69YrXPrD5K+vWVa1mbCck7P96D1u4ImBDmPmZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217207; c=relaxed/simple;
	bh=aFzatK6Oa9yrkdG/42CZrpQ3H8tJVAMpqOQW5kGQEzc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OLPU5HjJlPSxBo4Bkbq6ZzUHwmO2L9oa3clxL4mjq8b07xQcSwh7/LnmPbKVuEaGa+jKFwjUzvOxAFUBv3IXWz0tQYmoKS4BFFspfnsJbLsUT3oKjV9l+82xslkleo7fLFoDa3cdYQ7iv4DfqUS8yW31CPuVdVr2K0zLQZ72Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LBrr5G+N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELi1e7vX08JaVyTtqjVR6ltqFLOKGpPHxqBkclGpHTQ=; b=LBrr5G+NMxGGYSilf9xmo9f8JO
	tiE+wlH+LQLjfzp7npTK4jlnTTERrMIBPSD5LwVJnVNW9lGrfQM+h+oQXkEYOGCcGIaT1sOzUtjOe
	wEezgyDdoqDzXkq8BO0fqJQA56yVUq1a+TNDFFKgrhc/dO9JgQ0MPna2QQFhw7mcnDNDDRSD2qzCA
	GkW3zbBQEQuhwIHOlz4pibgcqJSo3NA4FcHNPijMSkiJOLb/SHL9jyzdzCSq8hrNt/KQhyq8Le5Q8
	Mw+FBjx0qjuwXPRCc/cMeZ8C4SXGD63DdYDDN0zAL1CsLTsVTyO36QDlj+FZcKe+qCtdBlZRu9/VX
	4jQt4nEQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48424 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbv-000000001ct-0lTr;
	Thu, 18 Sep 2025 18:39:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbu-00000006n0T-1TyP;
	Thu, 18 Sep 2025 18:39:58 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH RFC net-next 13/20] net: dsa: mv88e6xxx: convert to marvell
 TAI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbu-00000006n0T-1TyP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:58 +0100

Convert Marvell PTP timekeeping to use the Marvell PTP library TAI
implementation which is functionally identical (and was derived from
the mv88e6xxx code.)

Unfortunately, there is no progressive way to switch this over.

Note that the Marvell PTP TAI library has to be initialised without
the mv88e6xxx lock held, so we split the initialisation into two
parts.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/Kconfig    |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c     |   6 +
 drivers/net/dsa/mv88e6xxx/chip.h     |  26 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c |  14 +-
 drivers/net/dsa/mv88e6xxx/ptp.c      | 473 ++++++++++-----------------
 drivers/net/dsa/mv88e6xxx/ptp.h      |  30 +-
 6 files changed, 194 insertions(+), 356 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
index 64ae3882d17c..595ca6cd6075 100644
--- a/drivers/net/dsa/mv88e6xxx/Kconfig
+++ b/drivers/net/dsa/mv88e6xxx/Kconfig
@@ -14,6 +14,7 @@ config NET_DSA_MV88E6XXX_PTP
 	default n
 	depends on (NET_DSA_MV88E6XXX = y && PTP_1588_CLOCK = y) || \
 	           (NET_DSA_MV88E6XXX = m && PTP_1588_CLOCK)
+	select PTP_1588_CLOCK_MARVELL
 	help
 	  Say Y to enable PTP hardware timestamping on Marvell 88E6xxx switch
 	  chips that support it.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b4d48997bf46..ed170a6b0672 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4109,6 +4109,12 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto out_hwtstamp;
 
+	if (chip->info->ptp_support) {
+		err = mv88e6xxx_ptp_setup_unlocked(chip);
+		if (err)
+			goto out_hwtstamp;
+	}
+
 	/* Have to be called without holding the register lock, since
 	 * they take the devlink lock, and we later take the locks in
 	 * the reverse order when getting/setting parameters or
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index fe4a618c8ddd..29543f9312bd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -14,6 +14,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
 #include <linux/leds.h>
+#include <linux/marvell_ptp.h>
 #include <linux/phy.h>
 #include <linux/property.h>
 #include <linux/ptp_clock_kernel.h>
@@ -412,17 +413,8 @@ struct mv88e6xxx_chip {
 	/* GPIO resources */
 	u8 gpio_data[2];
 
-	/* This cyclecounter abstracts the switch PTP time.
-	 * reg_lock must be held for any operation that read()s.
-	 */
-	struct cyclecounter	tstamp_cc;
-	struct timecounter	tstamp_tc;
-	struct delayed_work	overflow_work;
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
-
-	struct ptp_clock	*ptp_clock;
-	struct ptp_clock_info	ptp_clock_info;
-	struct delayed_work	tai_event_work;
+	struct marvell_tai	*tai;
+
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
 	u16 enable_count;
 
@@ -446,6 +438,13 @@ struct mv88e6xxx_chip {
 	DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
 };
 
+static inline struct mv88e6xxx_chip *dev_to_chip(struct device *dev)
+{
+	struct dsa_switch *ds = dev_get_drvdata(dev);
+
+	return ds->priv;
+}
+
 struct mv88e6xxx_bus_ops {
 	int (*read)(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val);
 	int (*write)(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val);
@@ -731,11 +730,10 @@ struct mv88e6xxx_avb_ops {
 
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
-	int (*ptp_enable_extts)(struct mv88e6xxx_chip *chip,
-				struct ptp_clock_request *rq, int pin, int on);
+	int (*ptp_pin_setup)(struct mv88e6xxx_chip *chip, int pin,
+			     enum ptp_pin_function func, int enable);
 	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
-	void (*event_work)(struct work_struct *ugly);
 	int (*port_enable)(struct mv88e6xxx_chip *chip, int port);
 	int (*port_disable)(struct mv88e6xxx_chip *chip, int port);
 	int (*global_enable)(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index ba989d699113..0a56e7bcbcd9 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -79,7 +79,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = ptp_clock_index(chip->ptp_clock);
+	info->phc_index = marvell_tai_ptp_clock_index(chip->tai);
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
 		(1 << HWTSTAMP_TX_ON);
@@ -289,9 +289,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
-			mv88e6xxx_reg_lock(chip);
-			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-			mv88e6xxx_reg_unlock(chip);
+			ns = marvell_tai_cyc2time(chip->tai, ns);
 			shwt = skb_hwtstamps(skb);
 			memset(shwt, 0, sizeof(*shwt));
 			shwt->hwtstamp = ns_to_ktime(ns);
@@ -348,7 +346,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
 
-	ptp_schedule_worker(chip->ptp_clock, 0);
+	marvell_tai_schedule(chip->tai, 0);
 
 	return true;
 }
@@ -409,9 +407,7 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
-	mv88e6xxx_reg_lock(chip);
-	ns = timecounter_cyc2time(&chip->tstamp_tc, time_raw);
-	mv88e6xxx_reg_unlock(chip);
+	ns = marvell_tai_cyc2time(chip->tai, time_raw);
 	shhwtstamps.hwtstamp = ns_to_ktime(ns);
 
 	dev_dbg(chip->dev,
@@ -490,7 +486,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 	ps->tx_tstamp_start = jiffies;
 	ps->tx_seq_id = be16_to_cpu(hdr->sequence_id);
 
-	ptp_schedule_worker(chip->ptp_clock, 0);
+	marvell_tai_schedule(chip->tai, 0);
 }
 
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index efaefca1eef1..87a45dc6b811 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -16,8 +16,6 @@
 #include "hwtstamp.h"
 #include "ptp.h"
 
-#define MV88E6XXX_MAX_ADJ_PPB	1000000
-
 struct mv88e6xxx_cc_coeffs {
 	u32 cc_shift;
 	u32 cc_mult;
@@ -70,14 +68,6 @@ static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_4ns_coeffs = {
 	.cc_mult_dem = 15625ULL
 };
 
-#define TAI_EVENT_WORK_INTERVAL msecs_to_jiffies(100)
-
-#define cc_to_chip(cc) container_of(cc, struct mv88e6xxx_chip, tstamp_cc)
-#define dw_overflow_to_chip(dw) container_of(dw, struct mv88e6xxx_chip, \
-					     overflow_work)
-#define dw_tai_event_to_chip(dw) container_of(dw, struct mv88e6xxx_chip, \
-					      tai_event_work)
-
 static int mv88e6xxx_tai_read(struct mv88e6xxx_chip *chip, int addr,
 			      u16 *data, int len)
 {
@@ -87,14 +77,141 @@ static int mv88e6xxx_tai_read(struct mv88e6xxx_chip *chip, int addr,
 	return chip->info->ops->avb_ops->tai_read(chip, addr, data, len);
 }
 
-static int mv88e6xxx_tai_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
+static int mv88e6xxx_tai_hw_enable(struct device *dev)
 {
-	if (!chip->info->ops->avb_ops->tai_write)
-		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void mv88e6xxx_tai_hw_disable(struct device *dev)
+{
+}
+
+static u64 mv88e6xxx_tai_clock_read(struct device *dev,
+				    struct ptp_system_timestamp *sts)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_ptp_ops *ptp_ops;
+	u64 val = 0;
+
+	ptp_ops = chip->info->ops->ptp_ops;
+
+	if (chip->info->ops->ptp_ops->clock_read) {
+		mv88e6xxx_reg_lock(chip);
+		ptp_read_system_prets(sts);
+		val = ptp_ops->clock_read(chip);
+		ptp_read_system_postts(sts);
+		mv88e6xxx_reg_unlock(chip);
+	}
+
+	return val;
+}
+
+static int mv88e6xxx_tai_extts_read(struct device *dev, int reg,
+				    struct marvell_extts *extts)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_avb_ops *avb_ops;
+	u16 regs[3];
+	int ret;
+
+	avb_ops = chip->info->ops->avb_ops;
+
+	mv88e6xxx_reg_lock(chip);
+	ret = avb_ops->tai_read(chip, reg, regs, 3);
+	if (ret < 0)
+		goto unlock;
+
+	extts->status = regs[0];
+	extts->time = regs[1] | regs[2] << 16;
+
+	/* Clear valid if set */
+	if (regs[0] & MV_STATUS_EVENTCAPVALID) {
+		avb_ops->tai_write(chip, reg, 0);
+		ret = 1;
+	} else {
+		ret = 0;
+	}
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+
+	return ret;
+}
+
+static int mv88e6xxx_tai_pin_verify(struct device *dev, int pin,
+				    enum ptp_pin_function func,
+				    unsigned int chan)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
 
-	return chip->info->ops->avb_ops->tai_write(chip, addr, data);
+	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
 }
 
+static int mv88e6xxx_tai_pin_setup(struct device *dev, int pin,
+				   enum ptp_pin_function func, int enable)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = chip->info->ops->ptp_ops->ptp_pin_setup(chip, pin, func, enable);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+static int mv88e6xxx_tai_write(struct device *dev, u8 reg, u16 val)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = chip->info->ops->avb_ops->tai_write(chip, reg, val);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+static int mv88e6xxx_tai_modify(struct device *dev, u8 reg, u16 mask, u16 val)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_avb_ops *avb_ops;
+	u16 old, new;
+	int err;
+
+	avb_ops = chip->info->ops->avb_ops;
+
+	mv88e6xxx_reg_lock(chip);
+	err = avb_ops->tai_read(chip, reg, &old, 1);
+	if (err < 0)
+		goto unlock;
+
+	new = (old & ~mask) | val;
+	if (new != old)
+		err = avb_ops->tai_write(chip, reg, new);
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+	return err;
+}
+
+static long mv88e6xxx_tai_aux_work(struct device *dev)
+{
+	return mv88e6xxx_hwtstamp_work(dev_to_chip(dev));
+}
+
+static const struct marvell_tai_ops mv88e6xxx_tai_ops = {
+	.tai_hw_enable = mv88e6xxx_tai_hw_enable,
+	.tai_hw_disable = mv88e6xxx_tai_hw_disable,
+	.tai_clock_read = mv88e6xxx_tai_clock_read,
+	.tai_extts_read = mv88e6xxx_tai_extts_read,
+	.tai_pin_verify = mv88e6xxx_tai_pin_verify,
+	.tai_pin_setup = mv88e6xxx_tai_pin_setup,
+	.tai_write = mv88e6xxx_tai_write,
+	.tai_modify = mv88e6xxx_tai_modify,
+	.tai_aux_work = mv88e6xxx_tai_aux_work,
+};
+
 /* TODO: places where this are called should be using pinctrl */
 static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
 				   int func, int input)
@@ -178,212 +295,6 @@ static u64 mv88e6165_ptp_clock_read(struct mv88e6xxx_chip *chip)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
-/* mv88e6352_config_eventcap - configure TAI event capture
- * @rising: zero for falling-edge trigger, else rising-edge trigger
- *
- * This will also reset the capture sequence counter.
- */
-static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int rising)
-{
-	u16 evcap_config;
-	int err;
-
-	evcap_config = MV88E6352_TAI_CFG_CAP_OVERWRITE |
-		       MV88E6352_TAI_CFG_CAP_CTR_START;
-	if (!rising)
-		evcap_config |= MV88E6352_TAI_CFG_EVREQ_FALLING;
-
-	err = mv88e6xxx_tai_write(chip, MV88E6352_TAI_CFG, evcap_config);
-	if (err)
-		return err;
-
-	/* Write the capture config; this also clears the capture counter */
-	return mv88e6xxx_tai_write(chip, MV88E6352_TAI_EVENT_STATUS, 0);
-}
-
-static void mv88e6352_tai_event_work(struct work_struct *ugly)
-{
-	struct delayed_work *dw = to_delayed_work(ugly);
-	struct mv88e6xxx_chip *chip = dw_tai_event_to_chip(dw);
-	struct ptp_clock_event ev;
-	u16 status[4];
-	u32 raw_ts;
-	int err;
-
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_tai_read(chip, MV88E6352_TAI_EVENT_STATUS,
-				 status, ARRAY_SIZE(status));
-	mv88e6xxx_reg_unlock(chip);
-
-	if (err) {
-		dev_err(chip->dev, "failed to read TAI status register\n");
-		return;
-	}
-	if (status[0] & MV88E6352_TAI_EVENT_STATUS_ERROR) {
-		dev_warn(chip->dev, "missed event capture\n");
-		return;
-	}
-	if (!(status[0] & MV88E6352_TAI_EVENT_STATUS_VALID))
-		goto out;
-
-	raw_ts = ((u32)status[2] << 16) | status[1];
-
-	/* Clear the valid bit so the next timestamp can come in */
-	status[0] &= ~MV88E6352_TAI_EVENT_STATUS_VALID;
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_tai_write(chip, MV88E6352_TAI_EVENT_STATUS, status[0]);
-	mv88e6xxx_reg_unlock(chip);
-	if (err) {
-		dev_err(chip->dev, "failed to write TAI status register\n");
-		return;
-	}
-
-	/* This is an external timestamp */
-	ev.type = PTP_CLOCK_EXTTS;
-
-	/* We only have one timestamping channel. */
-	ev.index = 0;
-	mv88e6xxx_reg_lock(chip);
-	ev.timestamp = timecounter_cyc2time(&chip->tstamp_tc, raw_ts);
-	mv88e6xxx_reg_unlock(chip);
-
-	ptp_clock_event(chip->ptp_clock, &ev);
-out:
-	schedule_delayed_work(&chip->tai_event_work, TAI_EVENT_WORK_INTERVAL);
-}
-
-static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	int neg_adj = 0;
-	u32 diff, mult;
-	u64 adj;
-
-	if (scaled_ppm < 0) {
-		neg_adj = 1;
-		scaled_ppm = -scaled_ppm;
-	}
-
-	mult = chip->cc_coeffs->cc_mult;
-	adj = chip->cc_coeffs->cc_mult_num;
-	adj *= scaled_ppm;
-	diff = div_u64(adj, chip->cc_coeffs->cc_mult_dem);
-
-	mv88e6xxx_reg_lock(chip);
-
-	timecounter_read(&chip->tstamp_tc);
-	chip->tstamp_cc.mult = neg_adj ? mult - diff : mult + diff;
-
-	mv88e6xxx_reg_unlock(chip);
-
-	return 0;
-}
-
-static int mv88e6xxx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-
-	mv88e6xxx_reg_lock(chip);
-	timecounter_adjtime(&chip->tstamp_tc, delta);
-	mv88e6xxx_reg_unlock(chip);
-
-	return 0;
-}
-
-static int mv88e6xxx_ptp_gettime(struct ptp_clock_info *ptp,
-				 struct timespec64 *ts)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	u64 ns;
-
-	mv88e6xxx_reg_lock(chip);
-	ns = timecounter_read(&chip->tstamp_tc);
-	mv88e6xxx_reg_unlock(chip);
-
-	*ts = ns_to_timespec64(ns);
-
-	return 0;
-}
-
-static int mv88e6xxx_ptp_settime(struct ptp_clock_info *ptp,
-				 const struct timespec64 *ts)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	u64 ns;
-
-	ns = timespec64_to_ns(ts);
-
-	mv88e6xxx_reg_lock(chip);
-	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc, ns);
-	mv88e6xxx_reg_unlock(chip);
-
-	return 0;
-}
-
-static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
-				struct ptp_clock_request *req, int enable)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	int pin;
-
-	if (req->type != PTP_CLK_REQ_EXTTS)
-		return -EOPNOTSUPP;
-
-	/* Reject requests to enable time stamping on both edges. */
-	if (req->extts.flags & PTP_STRICT_FLAGS &&
-	    req->extts.flags & PTP_ENABLE_FEATURE &&
-	    (req->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
-		return -EOPNOTSUPP;
-
-	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, req->extts.index);
-	if (pin < 0)
-		return -EBUSY;
-
-	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, req, pin,
-							  enable);
-}
-
-static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
-				enum ptp_pin_function func, unsigned int chan)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-
-	/* Always allow a pin to be set to no function */
-	if (func == PTP_PF_NONE)
-		return 0;
-
-	if (func != PTP_PF_EXTTS)
-		return -EOPNOTSUPP;
-
-	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
-}
-
-static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
-				      struct ptp_clock_request *rq, int pin,
-				      int on)
-{
-	int rising = (rq->extts.flags & PTP_RISING_EDGE);
-	int func;
-	int err;
-
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6352_ptp_pin_setup(chip, pin, PTP_PF_EXTTS, on);
-
-	if (!on) {
-		/* Always cancel the work, even if an error occurs */
-		cancel_delayed_work_sync(&chip->tai_event_work);
-	} else if (!err) {
-		schedule_delayed_work(&chip->tai_event_work,
-				      TAI_EVENT_WORK_INTERVAL);
-
-		err = mv88e6352_config_eventcap(chip, rising);
-	}
-
-	mv88e6xxx_reg_unlock(chip);
-
-	return err;
-}
-
 static int mv88e6352_ptp_verify(struct mv88e6xxx_chip *chip, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
@@ -408,9 +319,8 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
+	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
 	.ptp_verify = mv88e6352_ptp_verify,
-	.event_work = mv88e6352_tai_event_work,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.n_ext_ts = 1,
@@ -431,9 +341,8 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
+	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
 	.ptp_verify = mv88e6352_ptp_verify,
-	.event_work = mv88e6352_tai_event_work,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.set_ptp_cpu_port = mv88e6390_g1_set_ptp_cpu_port,
@@ -474,114 +383,60 @@ static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
 	return err;
 }
 
-static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
-{
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
-
-	if (chip->info->ops->ptp_ops->clock_read)
-		return chip->info->ops->ptp_ops->clock_read(chip);
-
-	return 0;
-}
-
-/* With a 250MHz input clock, the 32-bit timestamp counter overflows in ~17.2
- * seconds; this task forces periodic reads so that we don't miss any.
- */
-#define MV88E6XXX_TAI_OVERFLOW_PERIOD (HZ * 8)
-static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
-{
-	struct delayed_work *dw = to_delayed_work(work);
-	struct mv88e6xxx_chip *chip = dw_overflow_to_chip(dw);
-	struct timespec64 ts;
-
-	mv88e6xxx_ptp_gettime(&chip->ptp_clock_info, &ts);
-
-	schedule_delayed_work(&chip->overflow_work,
-			      MV88E6XXX_TAI_OVERFLOW_PERIOD);
-}
-
-static long mv88e6xxx_ptp_aux_work(struct ptp_clock_info *ptp)
-{
-	return mv88e6xxx_hwtstamp_work(ptp_to_chip(ptp));
-}
-
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	int err, i;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
+	struct marvell_tai_param tai_param;
+	struct marvell_tai_pins pins;
+	int i, err;
 
 	/* Set up the cycle counter */
-	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
-	if (IS_ERR(chip->cc_coeffs))
-		return PTR_ERR(chip->cc_coeffs);
-
-	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
-	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
-	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
-	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
-	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
+	cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
+	if (IS_ERR(cc_coeffs))
+		return PTR_ERR(cc_coeffs);
 
-	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
+	err = mv88e6xxx_set_ptp_cpu_port(chip);
+	if (err)
+		return err;
 
-	INIT_DELAYED_WORK(&chip->overflow_work, mv88e6xxx_ptp_overflow_check);
-	if (ptp_ops->event_work)
-		INIT_DELAYED_WORK(&chip->tai_event_work, ptp_ops->event_work);
+	mv88e6xxx_reg_unlock(chip);
 
-	chip->ptp_clock_info.owner = THIS_MODULE;
-	snprintf(chip->ptp_clock_info.name, sizeof(chip->ptp_clock_info.name),
-		 "%s", dev_name(chip->dev));
+	memset(&tai_param, 0, sizeof(tai_param));
+	tai_param.cc_mult_num = cc_coeffs->cc_mult_num;
+	tai_param.cc_mult_den = cc_coeffs->cc_mult_dem;
+	tai_param.cc_mult = cc_coeffs->cc_mult;
+	tai_param.cc_shift = cc_coeffs->cc_shift;
 
-	chip->ptp_clock_info.n_ext_ts	= ptp_ops->n_ext_ts;
-	chip->ptp_clock_info.n_per_out	= 0;
-	chip->ptp_clock_info.n_pins	= mv88e6xxx_num_gpio(chip);
-	chip->ptp_clock_info.pps	= 0;
+	memset(&pins, 0, sizeof(pins));
+	pins.n_ext_ts = ptp_ops->n_ext_ts;
+	pins.n_pins = mv88e6xxx_num_gpio(chip);
+	pins.pins = chip->pin_config;
+	pins.supported_extts_flags = PTP_EXTTS_EDGES;
 
-	for (i = 0; i < chip->ptp_clock_info.n_pins; ++i) {
+	for (i = 0; i < pins.n_pins; ++i) {
 		struct ptp_pin_desc *ppd = &chip->pin_config[i];
 
 		snprintf(ppd->name, sizeof(ppd->name), "mv88e6xxx_gpio%d", i);
 		ppd->index = i;
 		ppd->func = PTP_PF_NONE;
 	}
-	chip->ptp_clock_info.pin_config = chip->pin_config;
 
-	chip->ptp_clock_info.max_adj    = MV88E6XXX_MAX_ADJ_PPB;
-	chip->ptp_clock_info.adjfine	= mv88e6xxx_ptp_adjfine;
-	chip->ptp_clock_info.adjtime	= mv88e6xxx_ptp_adjtime;
-	chip->ptp_clock_info.gettime64	= mv88e6xxx_ptp_gettime;
-	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
-	chip->ptp_clock_info.enable	= mv88e6xxx_ptp_enable;
-	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
-	chip->ptp_clock_info.do_aux_work = mv88e6xxx_ptp_aux_work;
-
-	chip->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
-						     PTP_FALLING_EDGE |
-						     PTP_STRICT_FLAGS;
-
-	err = mv88e6xxx_set_ptp_cpu_port(chip);
-	if (err)
-		return err;
-
-	chip->ptp_clock = ptp_clock_register(&chip->ptp_clock_info, chip->dev);
-	if (IS_ERR(chip->ptp_clock))
-		return PTR_ERR(chip->ptp_clock);
+	err = marvell_tai_probe(&chip->tai, &mv88e6xxx_tai_ops, &tai_param,
+				&pins, dev_name(chip->dev), chip->dev);
+	mv88e6xxx_reg_lock(chip);
 
-	schedule_delayed_work(&chip->overflow_work,
-			      MV88E6XXX_TAI_OVERFLOW_PERIOD);
+	return err;
+}
 
+int mv88e6xxx_ptp_setup_unlocked(struct mv88e6xxx_chip *chip)
+{
 	return 0;
 }
 
 /* This must never be called holding the register lock */
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 {
-	if (chip->ptp_clock) {
-		cancel_delayed_work_sync(&chip->overflow_work);
-		if (chip->info->ops->ptp_ops->event_work)
-			cancel_delayed_work_sync(&chip->tai_event_work);
-
-		ptp_clock_unregister(chip->ptp_clock);
-		chip->ptp_clock = NULL;
-	}
+	if (chip->tai)
+		marvell_tai_remove(chip->tai);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 95bdddb0bf39..1e598038acf1 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -15,39 +15,15 @@
 
 #include "chip.h"
 
-/* Offset 0x00: TAI Global Config */
-#define MV88E6352_TAI_CFG			0x00
-#define MV88E6352_TAI_CFG_CAP_OVERWRITE		0x8000
-#define MV88E6352_TAI_CFG_CAP_CTR_START		0x4000
-#define MV88E6352_TAI_CFG_EVREQ_FALLING		0x2000
-#define MV88E6352_TAI_CFG_TRIG_ACTIVE_LO	0x1000
-#define MV88E6352_TAI_CFG_IRL_ENABLE		0x0400
-#define MV88E6352_TAI_CFG_TRIG_IRQ_EN		0x0200
-#define MV88E6352_TAI_CFG_EVREQ_IRQ_EN		0x0100
-#define MV88E6352_TAI_CFG_TRIG_LOCK		0x0080
-#define MV88E6352_TAI_CFG_BLOCK_UPDATE		0x0008
-#define MV88E6352_TAI_CFG_MULTI_PTP		0x0004
-#define MV88E6352_TAI_CFG_TRIG_MODE_ONESHOT	0x0002
-#define MV88E6352_TAI_CFG_TRIG_ENABLE		0x0001
-
 /* Offset 0x01: Timestamp Clock Period (ps) */
 #define MV88E6XXX_TAI_CLOCK_PERIOD		0x01
 
-/* Offset 0x09: Event Status */
-#define MV88E6352_TAI_EVENT_STATUS		0x09
-#define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
-#define MV88E6352_TAI_EVENT_STATUS_VALID	0x0100
-#define MV88E6352_TAI_EVENT_STATUS_CTR_MASK	0x00ff
-/* Offset 0x0A/0x0B: Event Time Lo/Hi. Always read with Event Status. */
-
 /* Offset 0x0E/0x0F: PTP Global Time */
 #define MV88E6352_TAI_TIME_LO			0x0e
-#define MV88E6352_TAI_TIME_HI			0x0f
 
 /* 6165 Global Control Registers */
 /* Offset 0x9/0xa: Global Time */
 #define MV88E6165_PTP_GC_TIME_LO		0x09
-#define MV88E6165_PTP_GC_TIME_HI		0x0A
 
 /* 6165 Per Port Registers. The arrival and departure registers are a
  * common block consisting of status, two time registers and the sequence ID
@@ -67,6 +43,7 @@
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_ptp_setup_unlocked(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 
 #define ptp_to_chip(ptp) container_of(ptp, struct mv88e6xxx_chip,	\
@@ -83,6 +60,11 @@ static inline int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static inline int mv88e6xxx_ptp_setup_unlocked(struct mv88e6xxx_chip *chip)
+{
+	return 0;
+}
+
 static inline void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 {
 }
-- 
2.47.3


