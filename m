Return-Path: <netdev+bounces-181819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE14A86839
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CE61BA5A9F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553929AB04;
	Fri, 11 Apr 2025 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V8IgTea/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184E29B237
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406856; cv=none; b=VtGvHljlhOSVM3KWSj35I+5Ytv1CtdkPZO/brW/9mb5dfdvtQUoVI2sXLgDhvoaBvwSJE+4UkLJzRKHiYL/C0mHWJVtZksNA6qHeKg3m3BskpN6CSZL+82RKiT69IqLskyZeUjSZa8iOKbKa7okQHNtFNWxRF87CDddOFp7YjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406856; c=relaxed/simple;
	bh=zrnAM4vy9zKJFGFiH3+vRRQXZNDKedtnIbCMEb9J5Uc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aNp8MTWlRda3oWJS7k2ZCBOTU33Iz7rCf09epV9f1ZsQqUXZ1v+C8e8xnIoY0GCC7Id5SLlx7BYaoeQomMi6GxqoZkQcxG9VOXgVrwVNbY/SOALqxdSqZ04OBrfyAo+28EYetLGQY50ayrsGZ0sETZ+O4MZjqaHyS2Ohp8N35wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V8IgTea/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KvKExFLX5HM1Ak7vf07Ip9qP1OgXg6pG7ou5IdxrjkI=; b=V8IgTea/UmEMvhpDLjv35qNgXy
	fHl7Y/EkNG9049OmWKaNJjGvHEBaxsNagzTleQRTenE5aeoEdgbeLlkfEa4/O23sxp9ei9zp+d4g+
	wyVxnZezfkmj6PWIxqV3QH4XaJBsPAEPCF5eflnqpRKzCbapW9bhJfXIRn6uGbwN5E61VC1Q48+0E
	A0dGU627cKRD4Thpk2pqRXTvB3nYLzUhjd9jR1l+2Ow679qknxbtvzY3eahoiQf7567GIST5O89ba
	9QmWs5at4K+y2aHGfUsB+9GUICYWkHt5Nab8c5sx4LxpEcjWqPPjsdHNT30Wt1coazVWPdqI5denv
	gxQ/ue+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40408 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3LuL-0003sX-22;
	Fri, 11 Apr 2025 22:27:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Ltk-000CPJ-GN; Fri, 11 Apr 2025 22:26:52 +0100
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
Subject: [PATCH RFC net-next 5/5] mv88e6xxx: cleanup ptp tai
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Ltk-000CPJ-GN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 22:26:52 +0100

---
 drivers/net/dsa/mv88e6xxx/chip.h     |  22 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c |  24 --
 drivers/net/dsa/mv88e6xxx/ptp.c      | 417 +--------------------------
 3 files changed, 12 insertions(+), 451 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 6fb7d0fa0180..a509cb34a167 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -7,7 +7,7 @@
 
 #ifndef _MV88E6XXX_CHIP_H
 #define _MV88E6XXX_CHIP_H
-#define USE_MARVELL_TAI
+
 #include <linux/idr.h>
 #include <linux/if_vlan.h>
 #include <linux/irq.h>
@@ -413,29 +413,9 @@ struct mv88e6xxx_chip {
 	/* GPIO resources */
 	u8 gpio_data[2];
 
-#ifdef USE_MARVELL_TAI
 	struct marvell_tai	*tai;
-#else
 
-	/* This cyclecounter abstracts the switch PTP time.
-	 * reg_lock must be held for any operation that read()s.
-	 */
-	struct cyclecounter	tstamp_cc;
-	struct timecounter	tstamp_tc;
-	struct delayed_work	overflow_work;
-#endif
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
-
-#ifndef USE_MARVELL_TAI
-	struct ptp_clock	*ptp_clock;
-	struct ptp_clock_info	ptp_clock_info;
-	struct delayed_work	tai_event_work;
-#endif
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-#ifndef USE_MARVELL_TAI
-	u16 trig_config;
-	u16 evcap_config;
-#endif
 	u16 enable_count;
 
 	/* Current ingress and egress monitor ports */
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 232deff1b2ba..942ea77921f9 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -79,11 +79,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-#ifdef USE_MARVELL_TAI
 	info->phc_index = marvell_tai_ptp_clock_index(chip->tai);
-#else
-	info->phc_index = ptp_clock_index(chip->ptp_clock);
-#endif
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
 		(1 << HWTSTAMP_TX_ON);
@@ -297,13 +293,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
-#ifdef USE_MARVELL_TAI
 			ns = marvell_tai_cyc2time(chip->tai, ns);
-#else
-			mv88e6xxx_reg_lock(chip);
-			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-			mv88e6xxx_reg_unlock(chip);
-#endif
 			shwt = skb_hwtstamps(skb);
 			memset(shwt, 0, sizeof(*shwt));
 			shwt->hwtstamp = ns_to_ktime(ns);
@@ -360,11 +350,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
 
-#ifdef USE_MARVELL_TAI
 	marvell_tai_schedule(chip->tai, 0);
-#else
-	ptp_schedule_worker(chip->ptp_clock, 0);
-#endif
 
 	return true;
 }
@@ -425,13 +411,7 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
-#ifdef USE_MARVELL_TAI
 	ns = marvell_tai_cyc2time(chip->tai, time_raw);
-#else
-	mv88e6xxx_reg_lock(chip);
-	ns = timecounter_cyc2time(&chip->tstamp_tc, time_raw);
-	mv88e6xxx_reg_unlock(chip);
-#endif
 	shhwtstamps.hwtstamp = ns_to_ktime(ns);
 
 	dev_dbg(chip->dev,
@@ -510,11 +490,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 	ps->tx_tstamp_start = jiffies;
 	ps->tx_seq_id = be16_to_cpu(hdr->sequence_id);
 
-#ifdef USE_MARVELL_TAI
 	marvell_tai_schedule(chip->tai, 0);
-#else
-	ptp_schedule_worker(chip->ptp_clock, 0);
-#endif
 }
 
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 9d6f880b2430..d8d7412fa755 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -87,16 +87,6 @@ static int mv88e6xxx_tai_read(struct mv88e6xxx_chip *chip, int addr,
 	return chip->info->ops->avb_ops->tai_read(chip, addr, data, len);
 }
 
-#ifndef USE_MARVELL_TAI
-static int mv88e6xxx_tai_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
-{
-	if (!chip->info->ops->avb_ops->tai_write)
-		return -EOPNOTSUPP;
-
-	return chip->info->ops->avb_ops->tai_write(chip, addr, data);
-}
-#endif
-
 /* TODO: places where this are called should be using pinctrl */
 static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
 				   int func, int input)
@@ -166,265 +156,6 @@ static u64 mv88e6165_ptp_clock_read(struct mv88e6xxx_chip *chip)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
-#ifndef USE_MARVELL_TAI
-/* mv88e6352_config_eventcap - configure TAI event capture
- * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
- * @rising: zero for falling-edge trigger, else rising-edge trigger
- *
- * This will also reset the capture sequence counter.
- */
-static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
-				     int rising)
-{
-	u16 global_config;
-	u16 cap_config;
-	int err;
-
-	chip->evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
-			     MV88E6XXX_TAI_CFG_CAP_CTR_START;
-	if (!rising)
-		chip->evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
-
-	global_config = (chip->evcap_config | chip->trig_config);
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, global_config);
-	if (err)
-		return err;
-
-	if (event == PTP_CLOCK_PPS) {
-		cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;
-	} else if (event == PTP_CLOCK_EXTTS) {
-		/* if STATUS_CAP_TRIG is unset we capture PTP_EVREQ events */
-		cap_config = 0;
-	} else {
-		return -EINVAL;
-	}
-
-	/* Write the capture config; this also clears the capture counter */
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS,
-				  cap_config);
-
-	return err;
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
-	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_EVENT_STATUS,
-				 status, ARRAY_SIZE(status));
-	mv88e6xxx_reg_unlock(chip);
-
-	if (err) {
-		dev_err(chip->dev, "failed to read TAI status register\n");
-		return;
-	}
-	if (status[0] & MV88E6XXX_TAI_EVENT_STATUS_ERROR) {
-		dev_warn(chip->dev, "missed event capture\n");
-		return;
-	}
-	if (!(status[0] & MV88E6XXX_TAI_EVENT_STATUS_VALID))
-		goto out;
-
-	raw_ts = ((u32)status[2] << 16) | status[1];
-
-	/* Clear the valid bit so the next timestamp can come in */
-	status[0] &= ~MV88E6XXX_TAI_EVENT_STATUS_VALID;
-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, status[0]);
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
-static int mv88e6xxx_ptp_enable_extts(struct mv88e6xxx_chip *chip,
-				      struct ptp_extts_request *req, int on)
-{
-	int pin;
-
-	/* Reject requests with unsupported flags */
-	if (req->flags & ~(PTP_ENABLE_FEATURE |
-			   PTP_RISING_EDGE |
-			   PTP_FALLING_EDGE |
-			   PTP_STRICT_FLAGS))
-		return -EOPNOTSUPP;
-
-	if (!chip->info->ops->ptp_ops->ptp_enable_extts)
-		return -EOPNOTSUPP;
-
-	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, req->index);
-	if (pin < 0)
-		return -EBUSY;
-
-	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, rq, on);
-}
-
-static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
-				struct ptp_clock_request *rq, int on)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-
-	switch (rq->type) {
-	case PTP_CLK_REQ_EXTTS:
-		return mv88e6xxx_ptp_enable_extts(chip, &rq->extts, on);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
-				enum ptp_pin_function func, unsigned int chan)
-{
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-
-	if (!chip->info->ops->ptp_ops->ptp_verify)
-		return -EOPNOTSUPP;
-
-	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
-}
-
-static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
-				      struct ptp_clock_request *rq, int on)
-{
-	int rising = (rq->extts.flags & PTP_RISING_EDGE);
-	int func;
-	int pin;
-	int err;
-
-	/* Reject requests with unsupported flags */
-	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
-				PTP_RISING_EDGE |
-				PTP_FALLING_EDGE |
-				PTP_STRICT_FLAGS))
-		return -EOPNOTSUPP;
-
-	/* Reject requests to enable time stamping on both edges. */
-	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
-	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
-	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
-		return -EOPNOTSUPP;
-
-	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, rq->extts.index);
-
-	if (pin < 0)
-		return -EBUSY;
-
-	mv88e6xxx_reg_lock(chip);
-
-	if (on) {
-		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
-
-		err = mv88e6352_set_gpio_func(chip, pin, func, true);
-		if (err)
-			goto out;
-
-		schedule_delayed_work(&chip->tai_event_work,
-				      TAI_EVENT_WORK_INTERVAL);
-
-		err = mv88e6352_config_eventcap(chip, PTP_CLOCK_EXTTS, rising);
-	} else {
-		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
-
-		err = mv88e6352_set_gpio_func(chip, pin, func, true);
-
-		cancel_delayed_work_sync(&chip->tai_event_work);
-	}
-
-out:
-	mv88e6xxx_reg_unlock(chip);
-
-	return err;
-}
-#endif
-
 static int mv88e6352_ptp_pin_setup(struct mv88e6xxx_chip *chip,
 				   int pin, unsigned int flags, int enable)
 {
@@ -478,13 +209,8 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_verify = mv88e6352_ptp_verify,
-#ifndef USE_MARVELL_TAI
-	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
-	.event_work = mv88e6352_tai_event_work,
-#else
 	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
-#endif
+	.ptp_verify = mv88e6352_ptp_verify,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.n_ext_ts = 1,
@@ -505,13 +231,8 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_verify = mv88e6352_ptp_verify,
-#ifndef USE_MARVELL_TAI
-	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
-	.event_work = mv88e6352_tai_event_work,
-#else
 	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
-#endif
+	.ptp_verify = mv88e6352_ptp_verify,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.n_ext_ts = 1,
@@ -532,13 +253,8 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_verify = mv88e6352_ptp_verify,
-#ifndef USE_MARVELL_TAI
-	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
-	.event_work = mv88e6352_tai_event_work,
-#else
 	.ptp_pin_setup = mv88e6352_ptp_pin_setup,
-#endif
+	.ptp_verify = mv88e6352_ptp_verify,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
 	.port_disable = mv88e6352_hwtstamp_port_disable,
 	.set_ptp_cpu_port = mv88e6390_g1_set_ptp_cpu_port,
@@ -577,117 +293,6 @@ static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
 	return err;
 }
 
-#ifndef USE_MARVELL_TAI
-static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
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
-int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
-{
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	int i;
-
-	/* Set up the cycle counter */
-	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
-	if (IS_ERR(chip->cc_coeffs))
-		return PTR_ERR(chip->cc_coeffs);
-
-	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
-	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
-	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
-	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
-	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
-
-	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
-
-	INIT_DELAYED_WORK(&chip->overflow_work, mv88e6xxx_ptp_overflow_check);
-	if (ptp_ops->event_work)
-		INIT_DELAYED_WORK(&chip->tai_event_work, ptp_ops->event_work);
-
-	chip->ptp_clock_info.owner = THIS_MODULE;
-	snprintf(chip->ptp_clock_info.name, sizeof(chip->ptp_clock_info.name),
-		 "%s", dev_name(chip->dev));
-
-	chip->ptp_clock_info.n_ext_ts	= ptp_ops->n_ext_ts;
-	chip->ptp_clock_info.n_per_out	= 0;
-	chip->ptp_clock_info.n_pins	= mv88e6xxx_num_gpio(chip);
-	chip->ptp_clock_info.pps	= 0;
-
-	for (i = 0; i < chip->ptp_clock_info.n_pins; ++i) {
-		struct ptp_pin_desc *ppd = &chip->pin_config[i];
-
-		snprintf(ppd->name, sizeof(ppd->name), "mv88e6xxx_gpio%d", i);
-		ppd->index = i;
-		ppd->func = PTP_PF_NONE;
-	}
-
-	chip->ptp_clock_info.pin_config = chip->pin_config;
-
-	chip->ptp_clock_info.max_adj    = MV88E6XXX_MAX_ADJ_PPB;
-	chip->ptp_clock_info.adjfine	= mv88e6xxx_ptp_adjfine;
-	chip->ptp_clock_info.adjtime	= mv88e6xxx_ptp_adjtime;
-	chip->ptp_clock_info.gettime64	= mv88e6xxx_ptp_gettime;
-	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
-	chip->ptp_clock_info.enable	= mv88e6xxx_ptp_enable;
-	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
-	chip->ptp_clock_info.do_aux_work = mv88e6xxx_ptp_aux_work;
-
-	if (ptp_ops->set_ptp_cpu_port) {
-		err = mv88e6xxx_set_ptp_cpu_port(chip);
-		if (err)
-			return err;
-	}
-
-	chip->ptp_clock = ptp_clock_register(&chip->ptp_clock_info, chip->dev);
-	if (IS_ERR(chip->ptp_clock))
-		return PTR_ERR(chip->ptp_clock);
-
-	schedule_delayed_work(&chip->overflow_work,
-			      MV88E6XXX_TAI_OVERFLOW_PERIOD);
-
-	return 0;
-}
-
-void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
-{
-	if (chip->ptp_clock) {
-		cancel_delayed_work_sync(&chip->overflow_work);
-		if (chip->info->ops->ptp_ops->event_work)
-			cancel_delayed_work_sync(&chip->tai_event_work);
-
-		ptp_clock_unregister(chip->ptp_clock);
-		chip->ptp_clock = NULL;
-	}
-}
-#else
 static struct mv88e6xxx_chip *dev_to_chip(struct device *dev)
 {
 	struct dsa_switch *ds = dev_get_drvdata(dev);
@@ -847,13 +452,14 @@ static const struct marvell_ptp_ops mv88e6xxx_ptp_ops = {
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 	struct marvell_tai_param tai_param;
 	int i, n_pins, err;
 
 	/* Set up the cycle counter */
-	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
-	if (IS_ERR(chip->cc_coeffs))
-		return PTR_ERR(chip->cc_coeffs);
+	cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
+	if (IS_ERR(cc_coeffs))
+		return PTR_ERR(cc_coeffs);
 
 	if (ptp_ops->set_ptp_cpu_port) {
 		err = mv88e6xxx_set_ptp_cpu_port(chip);
@@ -862,10 +468,10 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	}
 
 	memset(&tai_param, 0, sizeof(tai_param));
-	tai_param.cc_mult_num = chip->cc_coeffs->cc_mult_num;
-	tai_param.cc_mult_den = chip->cc_coeffs->cc_mult_dem;
-	tai_param.cc_mult = chip->cc_coeffs->cc_mult;
-	tai_param.cc_shift = chip->cc_coeffs->cc_shift;
+	tai_param.cc_mult_num = cc_coeffs->cc_mult_num;
+	tai_param.cc_mult_den = cc_coeffs->cc_mult_dem;
+	tai_param.cc_mult = cc_coeffs->cc_mult;
+	tai_param.cc_shift = cc_coeffs->cc_shift;
 	tai_param.n_ext_ts = ptp_ops->n_ext_ts;
 
 	n_pins = mv88e6xxx_num_gpio(chip);
@@ -891,4 +497,3 @@ void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 	if (chip->tai)
 		marvell_tai_remove(chip->tai);
 }
-#endif
-- 
2.30.2


