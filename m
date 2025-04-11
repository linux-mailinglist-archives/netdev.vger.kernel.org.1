Return-Path: <netdev+bounces-181818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA729A8683F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A521617E77C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E529AB00;
	Fri, 11 Apr 2025 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AW9jLY1M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24122298CCF
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406852; cv=none; b=QsOasJsoJRGzlb/LNUTtjrwo4HZSZXuE/LoUsbVY5RCRicdqfQagFDBclbtUrosuoTz1lhvaoZVPUr8o8l7JZLb2EF9cXcYO9MJvWlnEMvO2W724PNaB4dCkCJH9n+J89Km1cWVehMwM5O9nmcgBhqeO7UFROBvjIBUVCay155M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406852; c=relaxed/simple;
	bh=xbacJu86isXygfTLStyILXXVZpu1E6aPUKojJJ4BLYY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VOuG2z0JBMtXos7UHUvvxWTRdzXBqKTH6t/QtUfuuVXERpWaK8nTugBeqaZ3Uqq+dt/KuNSSMU4m+p/vHfuo4mv9MaZfpQ9kaR1SoZYvjal1re/aagMZrR25VfGkpmcr9Pp67yL7nAkxtm0b5n25SFmNLjvhj9kgzofstjHNyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AW9jLY1M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=94j1aJ29/EYFmTNkzZEHtBWmF7155NeOtPV9Ag+4YlQ=; b=AW9jLY1MPul16YvDAifohS++hr
	RfoMkfx04+NdplLeqHQipTlbj/WO598/KiM2QkI9sUoroIrZe9Gk5totWjha651uPwhqyin88MzTM
	Pt3xCgpOYSj5URe4sM0Rx9rN0zPR3y/ZlUQf+9BuprhGqTO2ggoWlipbxHacl9GF8ukvdAx2GKj9L
	zFNziNZkVpekxZlyCH/xz73wfdh7eRnIMqlUgTdK5Xt1OBa3h+CeuMMH0ft9cgStPkYJznyuuIJXU
	JSRnUsmixX3zx5hwE5Oq9VcDSkfgupcfgIUvn/7J5qTBgpmzMWPAf+f4ybePIoiYuWWjU5qY3HjGK
	TiyRw85g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43836 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3LuG-0003sL-1v;
	Fri, 11 Apr 2025 22:27:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Ltf-000CPD-C4; Fri, 11 Apr 2025 22:26:47 +0100
In-Reply-To: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 4/5] mv88e6xxx: convert to marvell TAI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Ltf-000CPD-C4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 22:26:47 +0100

---
 drivers/net/dsa/mv88e6xxx/Kconfig    |   1 +
 drivers/net/dsa/mv88e6xxx/chip.h     |  22 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c |  23 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c      | 354 ++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/ptp.h      |   1 -
 6 files changed, 361 insertions(+), 41 deletions(-)

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
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 86bf113c9bfa..6fb7d0fa0180 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -7,13 +7,14 @@
 
 #ifndef _MV88E6XXX_CHIP_H
 #define _MV88E6XXX_CHIP_H
-
+#define USE_MARVELL_TAI
 #include <linux/idr.h>
 #include <linux/if_vlan.h>
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
 #include <linux/leds.h>
+#include <linux/marvell_ptp.h>
 #include <linux/phy.h>
 #include <linux/property.h>
 #include <linux/ptp_clock_kernel.h>
@@ -412,20 +413,29 @@ struct mv88e6xxx_chip {
 	/* GPIO resources */
 	u8 gpio_data[2];
 
+#ifdef USE_MARVELL_TAI
+	struct marvell_tai	*tai;
+#else
+
 	/* This cyclecounter abstracts the switch PTP time.
 	 * reg_lock must be held for any operation that read()s.
 	 */
 	struct cyclecounter	tstamp_cc;
 	struct timecounter	tstamp_tc;
 	struct delayed_work	overflow_work;
+#endif
 	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 
+#ifndef USE_MARVELL_TAI
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
 	struct delayed_work	tai_event_work;
+#endif
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
+#ifndef USE_MARVELL_TAI
 	u16 trig_config;
 	u16 evcap_config;
+#endif
 	u16 enable_count;
 
 	/* Current ingress and egress monitor ports */
@@ -732,10 +742,12 @@ struct mv88e6xxx_avb_ops {
 };
 
 struct mv88e6xxx_ptp_ops {
-	u64 (*clock_read)(const struct cyclecounter *cc);
-	int (*ptp_enable)(struct ptp_clock_info *ptp,
-			  struct ptp_clock_request *rq, int on);
-	int (*ptp_verify)(struct ptp_clock_info *ptp, unsigned int pin,
+	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
+	int (*ptp_enable_extts)(struct mv88e6xxx_chip *chip,
+			        struct ptp_clock_request *rq, int on);
+	int (*ptp_pin_setup)(struct mv88e6xxx_chip *chip, int pin,
+			     unsigned int flags, int enable);
+	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
 	void (*event_work)(struct work_struct *ugly);
 	int (*port_enable)(struct mv88e6xxx_chip *chip, int port);
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 49e6e1355142..232deff1b2ba 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -79,7 +79,11 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
+#ifdef USE_MARVELL_TAI
+	info->phc_index = marvell_tai_ptp_clock_index(chip->tai);
+#else
 	info->phc_index = ptp_clock_index(chip->ptp_clock);
+#endif
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
 		(1 << HWTSTAMP_TX_ON);
@@ -293,9 +297,13 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
+#ifdef USE_MARVELL_TAI
+			ns = marvell_tai_cyc2time(chip->tai, ns);
+#else
 			mv88e6xxx_reg_lock(chip);
 			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
 			mv88e6xxx_reg_unlock(chip);
+#endif
 			shwt = skb_hwtstamps(skb);
 			memset(shwt, 0, sizeof(*shwt));
 			shwt->hwtstamp = ns_to_ktime(ns);
@@ -352,7 +360,11 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
 
+#ifdef USE_MARVELL_TAI
+	marvell_tai_schedule(chip->tai, 0);
+#else
 	ptp_schedule_worker(chip->ptp_clock, 0);
+#endif
 
 	return true;
 }
@@ -413,9 +425,13 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
+#ifdef USE_MARVELL_TAI
+	ns = marvell_tai_cyc2time(chip->tai, time_raw);
+#else
 	mv88e6xxx_reg_lock(chip);
 	ns = timecounter_cyc2time(&chip->tstamp_tc, time_raw);
 	mv88e6xxx_reg_unlock(chip);
+#endif
 	shhwtstamps.hwtstamp = ns_to_ktime(ns);
 
 	dev_dbg(chip->dev,
@@ -443,9 +459,8 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
+long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
 	struct dsa_switch *ds = chip->ds;
 	struct mv88e6xxx_port_hwtstamp *ps;
 	int i, restart = 0;
@@ -495,7 +510,11 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 	ps->tx_tstamp_start = jiffies;
 	ps->tx_seq_id = be16_to_cpu(hdr->sequence_id);
 
+#ifdef USE_MARVELL_TAI
+	marvell_tai_schedule(chip->tai, 0);
+#else
 	ptp_schedule_worker(chip->ptp_clock, 0);
+#endif
 }
 
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index 85acc758e3eb..6013d7edbf73 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -129,6 +129,7 @@ int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_hwtstamp_port_disable(struct mv88e6xxx_chip *chip, int port);
 int mv88e6165_global_enable(struct mv88e6xxx_chip *chip);
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip);
+long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip);
 
 #else /* !CONFIG_NET_DSA_MV88E6XXX_PTP */
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index aed4a4b07f34..9d6f880b2430 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -87,6 +87,7 @@ static int mv88e6xxx_tai_read(struct mv88e6xxx_chip *chip, int addr,
 	return chip->info->ops->avb_ops->tai_read(chip, addr, data, len);
 }
 
+#ifndef USE_MARVELL_TAI
 static int mv88e6xxx_tai_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
 {
 	if (!chip->info->ops->avb_ops->tai_write)
@@ -94,6 +95,7 @@ static int mv88e6xxx_tai_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
 
 	return chip->info->ops->avb_ops->tai_write(chip, addr, data);
 }
+#endif
 
 /* TODO: places where this are called should be using pinctrl */
 static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
@@ -138,9 +140,8 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 }
 
-static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6352_ptp_clock_read(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
 	int err;
 
@@ -152,9 +153,8 @@ static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
-static u64 mv88e6165_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6165_ptp_clock_read(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
 	int err;
 
@@ -166,6 +166,7 @@ static u64 mv88e6165_ptp_clock_read(const struct cyclecounter *cc)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
+#ifndef USE_MARVELL_TAI
 /* mv88e6352_config_eventcap - configure TAI event capture
  * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
  * @rising: zero for falling-edge trigger, else rising-edge trigger
@@ -324,6 +325,52 @@ static int mv88e6xxx_ptp_settime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int mv88e6xxx_ptp_enable_extts(struct mv88e6xxx_chip *chip,
+				      struct ptp_extts_request *req, int on)
+{
+	int pin;
+
+	/* Reject requests with unsupported flags */
+	if (req->flags & ~(PTP_ENABLE_FEATURE |
+			   PTP_RISING_EDGE |
+			   PTP_FALLING_EDGE |
+			   PTP_STRICT_FLAGS))
+		return -EOPNOTSUPP;
+
+	if (!chip->info->ops->ptp_ops->ptp_enable_extts)
+		return -EOPNOTSUPP;
+
+	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, req->index);
+	if (pin < 0)
+		return -EBUSY;
+
+	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, rq, on);
+}
+
+static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
+				struct ptp_clock_request *rq, int on)
+{
+	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_EXTTS:
+		return mv88e6xxx_ptp_enable_extts(chip, &rq->extts, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
+				enum ptp_pin_function func, unsigned int chan)
+{
+	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+
+	if (!chip->info->ops->ptp_ops->ptp_verify)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
+}
+
 static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 				      struct ptp_clock_request *rq, int on)
 {
@@ -376,21 +423,30 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 
 	return err;
 }
+#endif
 
-static int mv88e6352_ptp_enable(struct ptp_clock_info *ptp,
-				struct ptp_clock_request *rq, int on)
+static int mv88e6352_ptp_pin_setup(struct mv88e6xxx_chip *chip,
+				   int pin, unsigned int flags, int enable)
 {
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+	int func, err;
 
-	switch (rq->type) {
-	case PTP_CLK_REQ_EXTTS:
-		return mv88e6352_ptp_enable_extts(chip, rq, on);
-	default:
+	/* Reject requests to enable time stamping on both edges. */
+	if (flags & PTP_STRICT_FLAGS &&
+	    flags & PTP_ENABLE_FEATURE &&
+	    (flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
 		return -EOPNOTSUPP;
-	}
+
+	if (enable)
+		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
+	else
+		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
+
+	err = mv88e6352_set_gpio_func(chip, pin, func, true);
+
+	return enable ? err : 0;
 }
 
-static int mv88e6352_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
+static int mv88e6352_ptp_verify(struct mv88e6xxx_chip *chip, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
 	switch (func) {
@@ -422,9 +478,13 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
 	.ptp_verify = mv88e6352_ptp_verify,
+#ifndef USE_MARVELL_TAI
+	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
 	.event_work = mv88e6352_tai_event_work,
+#else
+	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
+#endif
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.n_ext_ts = 1,
@@ -445,9 +505,13 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
 	.ptp_verify = mv88e6352_ptp_verify,
+#ifndef USE_MARVELL_TAI
+	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
 	.event_work = mv88e6352_tai_event_work,
+#else
+	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
+#endif
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.n_ext_ts = 1,
@@ -468,9 +532,13 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
 	.ptp_verify = mv88e6352_ptp_verify,
+#ifndef USE_MARVELL_TAI
+	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
 	.event_work = mv88e6352_tai_event_work,
+#else
+	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
+#endif
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.set_ptp_cpu_port = mv88e6390_g1_set_ptp_cpu_port,
@@ -490,12 +558,32 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
 
+static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
+{
+	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+	struct dsa_port *dp;
+	int upstream = 0;
+	int err;
+
+	dsa_switch_for_each_user_port(dp, chip->ds) {
+		upstream = dsa_upstream_port(chip->ds, dp->index);
+		break;
+	}
+
+	err = ptp_ops->set_ptp_cpu_port(chip, upstream);
+	if (err)
+		dev_err(chip->dev, "Failed to set PTP CPU destination port!\n");
+
+	return err;
+}
+
+#ifndef USE_MARVELL_TAI
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 
 	if (chip->info->ops->ptp_ops->clock_read)
-		return chip->info->ops->ptp_ops->clock_read(cc);
+		return chip->info->ops->ptp_ops->clock_read(chip);
 
 	return 0;
 }
@@ -516,6 +604,11 @@ static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
 			      MV88E6XXX_TAI_OVERFLOW_PERIOD);
 }
 
+static long mv88e6xxx_ptp_aux_work(struct ptp_clock_info *ptp)
+{
+	return mv88e6xxx_hwtstamp_work(ptp_to_chip(ptp));
+}
+
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
@@ -555,6 +648,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 		ppd->index = i;
 		ppd->func = PTP_PF_NONE;
 	}
+
 	chip->ptp_clock_info.pin_config = chip->pin_config;
 
 	chip->ptp_clock_info.max_adj    = MV88E6XXX_MAX_ADJ_PPB;
@@ -562,25 +656,14 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	chip->ptp_clock_info.adjtime	= mv88e6xxx_ptp_adjtime;
 	chip->ptp_clock_info.gettime64	= mv88e6xxx_ptp_gettime;
 	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
-	chip->ptp_clock_info.enable	= ptp_ops->ptp_enable;
-	chip->ptp_clock_info.verify	= ptp_ops->ptp_verify;
-	chip->ptp_clock_info.do_aux_work = mv88e6xxx_hwtstamp_work;
+	chip->ptp_clock_info.enable	= mv88e6xxx_ptp_enable;
+	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
+	chip->ptp_clock_info.do_aux_work = mv88e6xxx_ptp_aux_work;
 
 	if (ptp_ops->set_ptp_cpu_port) {
-		struct dsa_port *dp;
-		int upstream = 0;
-		int err;
-
-		dsa_switch_for_each_user_port(dp, chip->ds) {
-			upstream = dsa_upstream_port(chip->ds, dp->index);
-			break;
-		}
-
-		err = ptp_ops->set_ptp_cpu_port(chip, upstream);
-		if (err) {
-			dev_err(chip->dev, "Failed to set PTP CPU destination port!\n");
+		err = mv88e6xxx_set_ptp_cpu_port(chip);
+		if (err)
 			return err;
-		}
 	}
 
 	chip->ptp_clock = ptp_clock_register(&chip->ptp_clock_info, chip->dev);
@@ -604,3 +687,208 @@ void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 		chip->ptp_clock = NULL;
 	}
 }
+#else
+static struct mv88e6xxx_chip *dev_to_chip(struct device *dev)
+{
+	struct dsa_switch *ds = dev_get_drvdata(dev);
+
+	return ds->priv;
+}
+
+static int mv88e6xxx_tai_enable(struct device *dev)
+{
+	return 0;
+}
+
+static u64 mv88e6xxx_tai_clock_read(struct device *dev,
+				    struct ptp_system_timestamp *sts)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	int err = 0;
+
+	if (chip->info->ops->ptp_ops->clock_read) {
+		mv88e6xxx_reg_lock(chip);
+		ptp_read_system_prets(sts);
+		err = chip->info->ops->ptp_ops->clock_read(chip);
+		ptp_read_system_postts(sts);
+		mv88e6xxx_reg_unlock(chip);
+	}
+
+	return err;
+}
+
+static int mv88e6xxx_tai_extts_read(struct device *dev, int reg,
+				    struct marvell_extts *extts)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	u16 regs[3];
+	int ret;
+
+	mv88e6xxx_reg_lock(chip);
+	ret = chip->info->ops->avb_ops->tai_read(chip, reg, regs, 3);
+	if (ret < 0)
+		goto unlock;
+
+	extts->status = regs[0];
+	extts->time = regs[1] | regs[2] << 16;
+
+	/* Clear valid if set */
+	if (regs[0] & MV_STATUS_EVENTCAPVALID) {
+		chip->info->ops->avb_ops->tai_write(chip, reg, 0);
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
+
+	if (!chip->info->ops->ptp_ops->ptp_verify)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
+}
+
+static int mv88e6xxx_tai_pin_setup(struct device *dev, int pin,
+				   unsigned int flags, int enable)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+
+	if (!chip->info->ops->ptp_ops->ptp_pin_setup)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->ptp_ops->ptp_pin_setup(chip, pin, flags,
+						       enable);
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
+	u16 old, new;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = chip->info->ops->avb_ops->tai_read(chip, reg, &old, 1);
+	if (err < 0)
+		goto unlock;
+
+	new = (old & ~mask) | val;
+	if (new != old)
+		err = chip->info->ops->avb_ops->tai_write(chip, reg, new);
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+	return err;
+}
+
+static int mv88e6xxx_ptp_global_write(struct device *dev, u8 reg, u16 val)
+{
+	return 0;
+}
+
+static int mv88e6xxx_ptp_port_read_ts(struct device *dev, struct marvell_ts *ts,
+				      u8 reg)
+{
+	return 0;
+}
+
+static int mv88e6xxx_ptp_port_write(struct device *dev, u8 reg, u16 val)
+{
+	return 0;
+}
+
+static int mv88e6xxx_ptp_port_modify(struct device *dev, u8 reg, u16 mask,
+				     u16 val)
+{
+	return 0;
+}
+
+static long mv88e6xxx_ptp_aux_work(struct device *dev)
+{
+	return mv88e6xxx_hwtstamp_work(dev_to_chip(dev));
+}
+
+static const struct marvell_ptp_ops mv88e6xxx_ptp_ops = {
+	.tai_enable = mv88e6xxx_tai_enable,
+	.tai_clock_read = mv88e6xxx_tai_clock_read,
+	.tai_extts_read = mv88e6xxx_tai_extts_read,
+	.tai_pin_verify = mv88e6xxx_tai_pin_verify,
+	.tai_pin_setup = mv88e6xxx_tai_pin_setup,
+	.tai_write = mv88e6xxx_tai_write,
+	.tai_modify = mv88e6xxx_tai_modify,
+	.ptp_global_write = mv88e6xxx_ptp_global_write,
+	.ptp_port_read_ts = mv88e6xxx_ptp_port_read_ts,
+	.ptp_port_write = mv88e6xxx_ptp_port_write,
+	.ptp_port_modify = mv88e6xxx_ptp_port_modify,
+	.ptp_aux_work = mv88e6xxx_ptp_aux_work,
+};
+
+int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
+{
+	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+	struct marvell_tai_param tai_param;
+	int i, n_pins, err;
+
+	/* Set up the cycle counter */
+	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
+	if (IS_ERR(chip->cc_coeffs))
+		return PTR_ERR(chip->cc_coeffs);
+
+	if (ptp_ops->set_ptp_cpu_port) {
+		err = mv88e6xxx_set_ptp_cpu_port(chip);
+		if (err)
+			return err;
+	}
+
+	memset(&tai_param, 0, sizeof(tai_param));
+	tai_param.cc_mult_num = chip->cc_coeffs->cc_mult_num;
+	tai_param.cc_mult_den = chip->cc_coeffs->cc_mult_dem;
+	tai_param.cc_mult = chip->cc_coeffs->cc_mult;
+	tai_param.cc_shift = chip->cc_coeffs->cc_shift;
+	tai_param.n_ext_ts = ptp_ops->n_ext_ts;
+
+	n_pins = mv88e6xxx_num_gpio(chip);
+	for (i = 0; i < n_pins; ++i) {
+		struct ptp_pin_desc *ppd = &chip->pin_config[i];
+
+		snprintf(ppd->name, sizeof(ppd->name), "mv88e6xxx_gpio%d", i);
+		ppd->index = i;
+		ppd->func = PTP_PF_NONE;
+	}
+
+	mv88e6xxx_reg_unlock(chip);
+	err = marvell_tai_probe(&chip->tai, &mv88e6xxx_ptp_ops, &tai_param,
+				chip->pin_config, n_pins,
+				dev_name(chip->dev), chip->dev);
+	mv88e6xxx_reg_lock(chip);
+
+	return err;
+}
+
+void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
+{
+	if (chip->tai)
+		marvell_tai_remove(chip->tai);
+}
+#endif
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 6c4d09adc93c..f10ca6e91fe4 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -141,7 +141,6 @@
 
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 
-- 
2.30.2


