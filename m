Return-Path: <netdev+bounces-181816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21EAA86835
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D71BA599A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AF298CDC;
	Fri, 11 Apr 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Akcu6VCZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD529AB16
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406843; cv=none; b=GvpvyvheGuohOdisfSBOKRyZQr06199fBu69AYkOJhEF3M2Im+6La3EGfEUkUSg+Gr5S8vja7eY+gDi7HDvwqyCnBYSMx0ZTuN7sxntKIFsRZ3MTGYXAXb2pvxXmGBBCLt+Jl3Anh3YXGRxPP2FxUcxGHr9TLoR795JcPekLqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406843; c=relaxed/simple;
	bh=3r2E0S4Y+IYgAicCoxPNuuOCCgJ3sdn3FB+iI2DO5tM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qPJc33QR40CdENEtbmMwpzDxGYCnVLhEl2ebSHrzYzvi/oxAnc2bdE3eKkGq+Xd9VAFK28yzUus+u+WeVpXbE+vm87uYBsqa3uuyirWTcR94yVf6J13QkxGErvx7SQmBe/hibPofE+GPoPwJO4X2nP7utZfft4oVFcETeRSvrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Akcu6VCZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LEi7+Y1gvJpruKf4Jg5Prh4Mj8XOUWRTkA6wF1Haac8=; b=Akcu6VCZ1Bu9BHZPh9hkmak8GI
	H1kehVGli0pB+y6ANlwX2nsjnG2t1Ny0by7CBLQlzkBO/MNTjGv6wyCF3belllqL2xZq/yIJ82ok2
	3/kowl1LYDNOAznpxcKlsfVvr4euWoiIUuVzayH8mrfmYB8/G7ngy8rjQjD5qEL8Nzej3QtitAzzW
	0ZcpYNE04ZUlzhekLneD1/QPKejveDSfku+pVJikeOZ9spfN1WV3ySURMjZVTiC3FaDZxEQMNb3Vc
	tZUXiHrfB2H2RVdr7DR5xKkhpzkC/YDwp6EHdlgHbzaW+7OKiU2Tb7YUygqHdU9njp/Kc1bQmctJR
	YW2rYJhw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42460 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3Lu6-0003rw-0n;
	Fri, 11 Apr 2025 22:27:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3LtV-000CP1-2C; Fri, 11 Apr 2025 22:26:37 +0100
In-Reply-To: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH RFC net-next 2/5] ptp: marvell: add core support for Marvell
 PTP v2.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 22:26:37 +0100

Provide core support for the Marvell PTP v2.1 implementations, which
consist of a TAI (time application interface) and timestamping blocks.
This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
Armada 37xx (mvneta), as well as Marvell DSA devices.

Support for both arrival timestamps is supported, we use arrival 1 for
PTP peer delay messages, and arrival 0 for all other messages.

External event capture is also supported.

PPS output and trigger generation is not supported.

This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
code and DP83640 drivers. Like the original 88E6xxx DSA code, we
use a delayed work to keep the cycle counter updated, and a separate
delayed work for event capture.

We expose the ptp clock aux work to allow users to support single and
multi-port designs - where there is one Marvell TAI instance and a
number of Marvell TS instances.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/ptp/Kconfig           |   4 +
 drivers/ptp/Makefile          |   2 +
 drivers/ptp/ptp_marvell_tai.c | 449 +++++++++++++++++++++++++
 drivers/ptp/ptp_marvell_ts.c  | 593 ++++++++++++++++++++++++++++++++++
 include/linux/marvell_ptp.h   | 129 ++++++++
 5 files changed, 1177 insertions(+)
 create mode 100644 drivers/ptp/ptp_marvell_tai.c
 create mode 100644 drivers/ptp/ptp_marvell_ts.c
 create mode 100644 include/linux/marvell_ptp.h

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 07bf7f9aae01..27b54f37b9ab 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -184,6 +184,10 @@ config PTP_1588_CLOCK_FC3W
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_fc3.
 
+config PTP_1588_CLOCK_MARVELL
+	tristate
+	depends on PTP_1588_CLOCK
+
 config PTP_1588_CLOCK_MOCK
 	tristate "Mock-up PTP clock"
 	depends on PTP_1588_CLOCK
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..6248f75d9335 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
 obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
+obj-$(CONFIG_PTP_1588_CLOCK_MARVELL)	+= ptp-marvell.o
+ptp-marvell-y				:= ptp_marvell_tai.o ptp_marvell_ts.o
 obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp-qoriq.o
 ptp-qoriq-y				+= ptp_qoriq.o
 ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
diff --git a/drivers/ptp/ptp_marvell_tai.c b/drivers/ptp/ptp_marvell_tai.c
new file mode 100644
index 000000000000..eea7ccdce729
--- /dev/null
+++ b/drivers/ptp/ptp_marvell_tai.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TAI (time application interface) driver for Marvell PHYs and Marvell NETA.
+ *
+ * This file implements TAI support as a PTP clock. Timecounter/cyclecounter
+ * representation taken from Marvell 88E6xxx DSA driver. We may need to share
+ * the TAI between multiple PHYs in a multiport PHY.
+ */
+#include <linux/if_ether.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/marvell_ptp.h>
+
+#define TAI_CONFIG_0				0
+#define TAI_CONFIG_0_EVENTCAPOV			BIT(15)
+#define TAI_CONFIG_0_EVENTCTRSTART		BIT(14)
+#define TAI_CONFIG_0_EVENTPHASE			BIT(13)
+#define TAI_CONFIG_0_TRIGGENINTEN		BIT(9)
+#define TAI_CONFIG_0_EVENTCAPINTEN		BIT(8)
+
+#define TAI_CONFIG_9				9
+#define TAI_CONFIG_9_EVENTCAPERR		BIT(9)
+#define TAI_CONFIG_9_EVENTCAPVALID		BIT(8)
+
+#define TAI_EVENT_CAPTURE_TIME_LO		10
+#define TAI_EVENT_CAPTURE_TIME_HI		11
+
+#define PTPG_CONFIG_0				0
+#define PTPG_CONFIG_1				1
+#define PTPG_CONFIG_2				2
+#define PTPG_CONFIG_3				3
+#define PTPG_CONFIG_3_TSATSFD			BIT(0)
+#define PTPG_STATUS				8
+
+#define TAI_EVENT_POLL_INTERVAL msecs_to_jiffies(100)
+
+struct marvell_tai {
+	const struct marvell_ptp_ops *ops;
+	struct device *dev;
+
+	struct ptp_clock_info caps;
+	struct ptp_clock *ptp_clock;
+
+	u32 cc_mult_num;
+	u32 cc_mult_den;
+	u32 cc_mult;
+
+	struct mutex mutex;
+	struct timecounter timecounter;
+	struct cyclecounter cyclecounter;
+
+	long half_overflow_period;
+	struct delayed_work overflow_work;
+
+	bool defunct;
+	bool extts_poll;
+	struct delayed_work event_work;
+
+	/* Used while reading the TAI */
+	struct ptp_system_timestamp *sts;
+};
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
+
+	return tai->ops->tai_clock_read(tai->dev, tai->sts);
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
+EXPORT_SYMBOL_GPL(marvell_tai_cyc2time);
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
+static void marvell_tai_extts(struct marvell_tai *tai)
+{
+	struct marvell_extts extts;
+	struct ptp_clock_event ev;
+	int err;
+
+	err = tai->ops->tai_extts_read(tai->dev, TAI_CONFIG_9, &extts);
+	if (err <= 0)
+		return;
+
+	if (extts.status & TAI_CONFIG_9_EVENTCAPERR) {
+		dev_warn(tai->dev, "extts timestamp overrun (%x)\n",
+			 extts.status);
+		return;
+	}
+
+	ev.type = PTP_CLOCK_EXTTS;
+	ev.index = 0;
+	ev.timestamp = marvell_tai_cyc2time(tai, extts.time);
+
+	ptp_clock_event(tai->ptp_clock, &ev);
+}
+
+static int marvell_tai_enable_extts(struct marvell_tai *tai,
+				    struct ptp_extts_request *req, int enable)
+{
+	int err, pin;
+	u16 cfg0;
+
+	if (req->flags & ~(PTP_ENABLE_FEATURE | PTP_RISING_EDGE |
+			   PTP_FALLING_EDGE | PTP_STRICT_FLAGS))
+		return -EINVAL;
+
+	pin = ptp_find_pin(tai->ptp_clock, PTP_PF_EXTTS, req->index);
+	if (pin < 0)
+		return -EBUSY;
+
+	/* Setup this pin, validating flags as appropriate */
+	err = tai->ops->tai_pin_setup(tai->dev, pin, req->flags, enable);
+	if (err < 0)
+		return err;
+
+	if (enable) {
+		/* Clear the status */
+		err = tai->ops->tai_write(tai->dev, TAI_CONFIG_9, 0);
+		if (err < 0)
+			return err;
+
+		cfg0 = TAI_CONFIG_0_EVENTCAPINTEN |
+		       TAI_CONFIG_0_EVENTCTRSTART;
+
+		/*
+		 * For compatibility with DSA, we test for !rising rather
+		 * than for falling.
+		 */
+		if (!(req->flags & PTP_RISING_EDGE))
+			cfg0 |= TAI_CONFIG_0_EVENTPHASE;
+
+		/* Enable the event interrupt and counter */
+		err = tai->ops->tai_modify(tai->dev, TAI_CONFIG_0,
+					   TAI_CONFIG_0_EVENTCAPOV |
+					   TAI_CONFIG_0_EVENTCTRSTART |
+					   TAI_CONFIG_0_EVENTCAPINTEN, cfg0);
+		if (err < 0)
+			return err;
+
+		schedule_delayed_work(&tai->event_work,
+				      TAI_EVENT_POLL_INTERVAL);
+	} else {
+		/* Disable the event interrupt and counter */
+		err = tai->ops->tai_modify(tai->dev, TAI_CONFIG_0,
+					   TAI_CONFIG_0_EVENTCTRSTART |
+					   TAI_CONFIG_0_EVENTCAPINTEN, 0);
+		if (err < 0)
+			return err;
+
+		cancel_delayed_work_sync(&tai->event_work);
+	}
+
+	return 0;
+}
+
+static int marvell_tai_enable(struct ptp_clock_info *ptp,
+			      struct ptp_clock_request *req, int enable)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	int err;
+
+	switch (req->type) {
+	case PTP_PF_EXTTS:
+		err = marvell_tai_enable_extts(tai, &req->extts, enable);
+		break;
+
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int marvell_tai_verify(struct ptp_clock_info *ptp, unsigned int pin,
+			      enum ptp_pin_function func, unsigned int chan)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+
+	/* Always allow a pin to be set to no function */
+	if (func == PTP_PF_NONE)
+		return 0;
+
+	if (!tai->ops->tai_pin_verify)
+		return -EOPNOTSUPP;
+
+	return tai->ops->tai_pin_verify(tai->dev, pin, func, chan);
+}
+
+/* Periodically read the timecounter to keep the time refreshed. */
+static long marvell_tai_aux_work(struct ptp_clock_info *ptp)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	long ret = -1;
+
+	if (tai->ops->ptp_aux_work)
+		ret = tai->ops->ptp_aux_work(tai->dev);
+
+	return ret;
+}
+
+#define event_work_to_tai(w) \
+	container_of(to_delayed_work(w), struct marvell_tai, event_work)
+static void marvell_tai_event_work(struct work_struct *w)
+{
+	struct marvell_tai *tai = event_work_to_tai(w);
+
+	if (tai->defunct)
+		return;
+
+	marvell_tai_extts(tai);
+
+	schedule_delayed_work(&tai->event_work, TAI_EVENT_POLL_INTERVAL);
+}
+
+#define overflow_work_to_tai(w) \
+	container_of(to_delayed_work(w), struct marvell_tai, overflow_work)
+static void marvell_tai_overflow_work(struct work_struct *w)
+{
+	struct marvell_tai *tai = overflow_work_to_tai(w);
+
+	/* Read the timecounter to update */
+	mutex_lock(&tai->mutex);
+	timecounter_read(&tai->timecounter);
+	mutex_unlock(&tai->mutex);
+
+	schedule_delayed_work(&tai->overflow_work, tai->half_overflow_period);
+}
+
+/* Configure the global (shared between ports) configuration for the PHY. */
+static int marvell_tai_global_config(struct marvell_tai *tai)
+{
+	int err;
+
+	/* Enable TAI */
+	err = tai->ops->tai_enable(tai->dev);
+	if (err)
+		return err;
+
+	/* Set ether-type for IEEE1588 packets */
+	err = tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_0, ETH_P_1588);
+	if (err < 0)
+		return err;
+
+	/* MsdIDTSEn - Enable timestamping on all PTP MessageIDs */
+	err = tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_1,
+					 MV_PTP_MSD_ID_TS_EN);
+	if (err < 0)
+		return err;
+
+	/* TSArrPtr - Point to Arr0 registers */
+	err = tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_2,
+					 MV_PTP_TS_ARR_PTR);
+	if (err < 0)
+		return err;
+
+	/* TSAtSFD - timestamp at SFD */
+	err = tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_3,
+					 PTPG_CONFIG_3_TSATSFD);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int marvell_tai_ptp_clock_index(struct marvell_tai *tai)
+{
+	return ptp_clock_index(tai->ptp_clock);
+}
+EXPORT_SYMBOL_GPL(marvell_tai_ptp_clock_index);
+
+int marvell_tai_schedule(struct marvell_tai *tai, unsigned long delay)
+{
+	return ptp_schedule_worker(tai->ptp_clock, delay);
+}
+EXPORT_SYMBOL_GPL(marvell_tai_schedule);
+
+int marvell_tai_probe(struct marvell_tai **taip,
+		      const struct marvell_ptp_ops *ops,
+		      const struct marvell_tai_param *param,
+		      struct ptp_pin_desc *pin_config, int n_pins,
+		      const char *name, struct device *dev)
+{
+	struct marvell_tai *tai;
+	u64 overflow_ns;
+	int err;
+
+	tai = devm_kzalloc(dev, sizeof(*tai), GFP_KERNEL);
+	if (!tai)
+		return -ENOMEM;
+
+	mutex_init(&tai->mutex);
+
+	tai->dev = dev;
+	tai->ops = ops;
+	tai->cc_mult_num = param->cc_mult_num;
+	tai->cc_mult_den = param->cc_mult_den;
+	tai->cc_mult = param->cc_mult;
+
+	err = marvell_tai_global_config(tai);
+	if (err < 0)
+		return err;
+
+	tai->cyclecounter.read = marvell_tai_clock_read;
+	tai->cyclecounter.mask = CYCLECOUNTER_MASK(32);
+	tai->cyclecounter.mult = param->cc_mult;
+	tai->cyclecounter.shift = param->cc_shift;
+
+	overflow_ns = BIT_ULL(32) * param->cc_mult;
+	overflow_ns >>= param->cc_shift;
+	tai->half_overflow_period = nsecs_to_jiffies64(overflow_ns / 2);
+
+	timecounter_init(&tai->timecounter, &tai->cyclecounter,
+			 ktime_to_ns(ktime_get_real()));
+
+	tai->caps.owner = THIS_MODULE;
+	strscpy(tai->caps.name, name, sizeof(tai->caps.name));
+	/* max_adj of 1000000 is what MV88E6xxx DSA uses */
+	tai->caps.max_adj = 1000000;
+	tai->caps.n_ext_ts = param->n_ext_ts;
+	tai->caps.n_pins = n_pins;
+	tai->caps.pin_config = pin_config;
+	tai->caps.adjfine = marvell_tai_adjfine;
+	tai->caps.adjtime = marvell_tai_adjtime;
+	tai->caps.gettimex64 = marvell_tai_gettimex64;
+	tai->caps.settime64 = marvell_tai_settime64;
+	tai->caps.enable = marvell_tai_enable;
+	tai->caps.verify = marvell_tai_verify;
+	tai->caps.do_aux_work = marvell_tai_aux_work;
+
+	INIT_DELAYED_WORK(&tai->overflow_work, marvell_tai_overflow_work);
+	INIT_DELAYED_WORK(&tai->event_work, marvell_tai_event_work);
+
+	tai->ptp_clock = ptp_clock_register(&tai->caps, dev);
+	if (IS_ERR(tai->ptp_clock)) {
+		kfree(tai);
+		return PTR_ERR(tai->ptp_clock);
+	}
+
+	/*
+	 * Kick off the auxiliary worker to run once every half-overflow
+	 * period to keep the timecounter properly updated.
+	 */
+	schedule_delayed_work(&tai->overflow_work, tai->half_overflow_period);
+
+	*taip = tai;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_tai_probe);
+
+void marvell_tai_remove(struct marvell_tai *tai)
+{
+	/* Avoid races with the event work - mark defunct before
+	 * unregistering, which goes against "unpublish then tear down"
+	 */
+	tai->defunct = true;
+	cancel_delayed_work_sync(&tai->event_work);
+
+	ptp_clock_unregister(tai->ptp_clock);
+
+	cancel_delayed_work_sync(&tai->overflow_work);
+}
+EXPORT_SYMBOL_GPL(marvell_tai_remove);
diff --git a/drivers/ptp/ptp_marvell_ts.c b/drivers/ptp/ptp_marvell_ts.c
new file mode 100644
index 000000000000..a2e1ae9e4acc
--- /dev/null
+++ b/drivers/ptp/ptp_marvell_ts.c
@@ -0,0 +1,593 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell PTP driver for 88E1510, 88E1512, 88E1514 and 88E1518 PHYs
+ *
+ * Ideas taken from 88E6xxx DSA and DP83640 drivers. This file
+ * implements the packet timestamping support only (PTP).  TAI
+ * support is separate.
+ */
+#include <linux/ethtool.h>
+#include <linux/if_vlan.h>
+#include <linux/interrupt.h>
+#include <linux/marvell_ptp.h>
+#include <linux/netdevice.h>
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/uaccess.h>
+
+#define TX_TIMEOUT_MS	40
+#define RX_TIMEOUT_MS	40
+
+#define PTP_PORT_CONFIG_0			0
+#define PTP_PORT_CONFIG_0_DISTSPECCHECK		BIT(11)
+#define PTP_PORT_CONFIG_0_DISTSOVERWRITE	BIT(1)
+#define PTP_PORT_CONFIG_0_DISPTP		BIT(0)
+#define PTP_PORT_CONFIG_1			1
+#define PTP_PORT_CONFIG_1_IPJUMP(x)		(((x) & 0x3f) << 8)
+#define PTP_PORT_CONFIG_1_ETJUMP(x)		((x) & 0x1f)
+#define PTP_PORT_CONFIG_2			2
+#define PTP_PORT_CONFIG_2_DEPINTEN		BIT(1)
+#define PTP_PORT_CONFIG_2_ARRINTEN		BIT(0)
+#define PTP_ARR_STATUS0				8
+#define PTP_ARR_STATUS1				12
+#define PTP_DEP_STATUS				16
+
+struct marvell_ptp_cb {
+	unsigned long timeout;
+	u16 seq;
+};
+#define MARVELL_PTP_CB(skb)	((struct marvell_ptp_cb *)(skb)->cb)
+
+/* RX queue support */
+
+/* Deliver a skb with its timestamp back to the networking core */
+static void marvell_rxq_rx(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+
+	memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+	shhwtstamps->hwtstamp = ns_to_ktime(ns);
+	netif_rx(skb);
+}
+
+/* Get a rx timestamp entry. Try the free list, and if that fails,
+ * steal the oldest off the pending list.
+ */
+static struct marvell_rxts *marvell_rxq_get_rxts(struct marvell_rxq *rxq)
+{
+	if (!list_empty(&rxq->rx_free))
+		return list_first_entry(&rxq->rx_free, struct marvell_rxts,
+					node);
+
+	return list_last_entry(&rxq->rx_pend, struct marvell_rxts, node);
+}
+
+static void marvell_rxq_init(struct marvell_rxq *rxq)
+{
+	int i;
+
+	mutex_init(&rxq->rx_mutex);
+	INIT_LIST_HEAD(&rxq->rx_free);
+	INIT_LIST_HEAD(&rxq->rx_pend);
+	skb_queue_head_init(&rxq->rx_queue);
+
+	for (i = 0; i < ARRAY_SIZE(rxq->rx_ts); i++)
+		list_add_tail(&rxq->rx_ts[i].node, &rxq->rx_free);
+}
+
+static void marvell_rxq_purge(struct marvell_rxq *rxq)
+{
+	skb_queue_purge(&rxq->rx_queue);
+}
+
+static void marvell_rxq_rx_ts(struct marvell_rxq *rxq, u16 seq, u64 ns)
+{
+	struct marvell_rxts *rxts;
+	struct sk_buff *skb;
+	bool found = false;
+
+	mutex_lock(&rxq->rx_mutex);
+
+	/* Search the rx queue for a matching skb */
+	skb_queue_walk(&rxq->rx_queue, skb) {
+		if (MARVELL_PTP_CB(skb)->seq == seq) {
+			__skb_unlink(skb, &rxq->rx_queue);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		rxts = marvell_rxq_get_rxts(rxq);
+		rxts->ns = ns;
+		rxts->seq = seq;
+		list_move(&rxts->node, &rxq->rx_pend);
+	}
+
+	mutex_unlock(&rxq->rx_mutex);
+
+	if (found)
+		marvell_rxq_rx(skb, ns);
+}
+
+static bool marvell_rxq_rxtstamp(struct marvell_rxq *rxq, struct sk_buff *skb,
+				 u16 seq)
+{
+	struct marvell_rxts *rxts;
+	bool found = false;
+	u64 ns;
+
+	mutex_lock(&rxq->rx_mutex);
+
+	/* Search the pending receive timestamps for a matching seqid */
+	list_for_each_entry(rxts, &rxq->rx_pend, node) {
+		if (rxts->seq == seq) {
+			found = true;
+			ns = rxts->ns;
+			/* Move this timestamp entry to the free list */
+			list_move_tail(&rxts->node, &rxq->rx_free);
+			break;
+		}
+	}
+
+	if (!found) {
+		/* Store the seqid and queue the skb. Do this under the lock
+		 * to ensure we don't miss any timestamps appended to the
+		 * rx_pend list.
+		 */
+		MARVELL_PTP_CB(skb)->seq = seq;
+		MARVELL_PTP_CB(skb)->timeout = jiffies +
+			msecs_to_jiffies(RX_TIMEOUT_MS);
+		__skb_queue_tail(&rxq->rx_queue, skb);
+	}
+
+	mutex_unlock(&rxq->rx_mutex);
+
+	if (found)
+		/* We found the corresponding timestamp. If we can add the
+		 * timestamp, do we need to go through the netif_rx_ni()
+		 * path, or would it be more efficient to add the timestamp
+		 * and return "false" from marvell_ptp_rxtstamp() instead?
+		 */
+		marvell_rxq_rx(skb, ns);
+
+	return found;
+}
+
+static void marvell_rxq_expire(struct marvell_rxq *rxq,
+			       struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	mutex_lock(&rxq->rx_mutex);
+	while ((skb = skb_dequeue(&rxq->rx_queue)) != NULL) {
+		if (!time_is_before_jiffies(MARVELL_PTP_CB(skb)->timeout)) {
+			__skb_queue_head(&rxq->rx_queue, skb);
+			break;
+		}
+		__skb_queue_tail(list, skb);
+	}
+	mutex_unlock(&rxq->rx_mutex);
+}
+
+/* Extract the sequence ID */
+static u16 ptp_seqid(const struct ptp_header *ptp_hdr)
+{
+	const __be16 *seqp = &ptp_hdr->sequence_id;
+
+	return be16_to_cpup(seqp);
+}
+
+static u8 ptp_msgid(const struct ptp_header *ptp_hdr)
+{
+	return ptp_hdr->tsmt & 15;
+}
+
+static void marvell_ptp_schedule(struct marvell_ptp *ptp)
+{
+	marvell_tai_schedule(ptp->tai, 0);
+}
+
+/* Check for a rx timestamp entry, try to find the corresponding skb and
+ * deliver it, otherwise add the rx timestamp to the queue of pending
+ * timestamps.
+ */
+static int marvell_ptp_rx_ts(struct marvell_ptp *ptp, int q)
+{
+	struct marvell_ts ts;
+	u16 reg;
+	int err;
+	u64 ns;
+
+	if (q)
+		reg = PTP_ARR_STATUS1;
+	else
+		reg = PTP_ARR_STATUS0;
+
+	err = ptp->ops->ptp_port_read_ts(ptp->dev, &ts, reg);
+	if (err <= 0)
+		return 0;
+
+	if ((ts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL)
+		dev_warn(ptp->dev,
+			 "rx timestamp overrun (q=%u stat=0x%x seq=%u)\n",
+			 q, ts.stat, ts.seq);
+
+	ns = marvell_tai_cyc2time(ptp->tai, ts.time);
+
+	marvell_rxq_rx_ts(&ptp->rxq[q], ts.seq, ns);
+
+	return 1;
+}
+
+/* Check whether the packet is suitable for timestamping, and if so,
+ * try to find a pending timestamp for it. If no timestamp is found,
+ * queue the packet with a timeout.
+ */
+bool marvell_ptp_rxtstamp(struct marvell_ptp *ptp, struct sk_buff *skb,
+			  int type)
+{
+	const struct ptp_header *ptp_hdr;
+	u16 msgidvec, seq;
+	u8 msgid;
+	int q;
+
+	if (ptp->rx_filter == HWTSTAMP_FILTER_NONE)
+		return false;
+
+	ptp_hdr = ptp_parse_header(skb, type);
+	if (!ptp_hdr)
+		return false;
+
+	msgid = ptp_msgid(ptp_hdr);
+	seq = ptp_seqid(ptp_hdr);
+
+	/* Only check for timestamps for PTP packets whose message ID value
+	 * is one that we are capturing timestamps for. This is part of the
+	 * global configuration and is therefore fixed.
+	 */
+	msgidvec = BIT(msgid);
+	if (msgidvec & ~MV_PTP_MSD_ID_TS_EN) {
+		dev_dbg(ptp->dev, "not timestamping rx msgid %u seq %u\n",
+			msgid, seq);
+		return false;
+	}
+
+	/* Determine the queue which the timestamp for this message ID will
+	 * appear. This is part of the global configuration and is therefore
+	 * fixed.
+	 */
+	q = !!(msgidvec & MV_PTP_TS_ARR_PTR);
+
+	if (!marvell_rxq_rxtstamp(&ptp->rxq[q], skb, seq))
+		marvell_ptp_schedule(ptp);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_rxtstamp);
+
+/* Move any expired skbs on to our own list, and then hand the contents of
+ * our list to netif_rx() - this avoids calling netif_rx() with our
+ * mutex held.
+ */
+static void marvell_ptp_rx_expire(struct marvell_ptp *ptp)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int i;
+
+	__skb_queue_head_init(&list);
+
+	for (i = 0; i < ARRAY_SIZE(ptp->rxq); i++)
+		marvell_rxq_expire(&ptp->rxq[i], &list);
+
+	while ((skb = __skb_dequeue(&list)) != NULL)
+		netif_rx(skb);
+}
+
+/* Complete the transmit timestamping; this is called to read the transmit
+ * timestamp from the PHY, and report back the transmitted timestamp.
+ */
+static int marvell_ptp_txtstamp_complete(struct marvell_ptp *ptp)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb = ptp->tx_skb;
+	struct marvell_ts ts;
+	int err;
+	u64 ns;
+
+	err = ptp->ops->ptp_port_read_ts(ptp->dev, &ts, PTP_DEP_STATUS);
+	if (err < 0)
+		goto fail;
+
+	if (err == 0) {
+		if (time_is_before_jiffies(MARVELL_PTP_CB(skb)->timeout)) {
+			dev_warn(ptp->dev, "tx timestamp timeout\n");
+			goto free;
+		}
+		return 0;
+	}
+
+	/* Check the status */
+	if ((ts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL) {
+		dev_warn(ptp->dev, "tx timestamp overrun (stat=0x%x seq=%u)\n",
+			 ts.stat, ts.seq);
+		goto free;
+	}
+
+	/* Reject if the sequence number doesn't match */
+	if (ts.seq != MARVELL_PTP_CB(skb)->seq) {
+		dev_warn(ptp->dev, "tx timestamp unexpected sequence id\n");
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
+	dev_err_ratelimited(ptp->dev, "failed reading PTP: %pe\n",
+			    ERR_PTR(err));
+free:
+	dev_kfree_skb_any(skb);
+	ptp->tx_skb = NULL;
+	return -1;
+}
+
+/* Check whether the skb will be timestamped on transmit; we only support
+ * a single outstanding skb. Add it if the slot is available.
+ */
+static bool marvell_ptp_do_txtstamp(struct marvell_ptp *ptp,
+				    struct sk_buff *skb, int type)
+{
+	const struct ptp_header *ptp_hdr;
+	u8 msgid;
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
+	msgid = ptp_msgid(ptp_hdr);
+	if (BIT(msgid) & ~MV_PTP_MSD_ID_TS_EN) {
+		dev_dbg(ptp->dev, "not timestamping tx msgid %u seq %u\n",
+			msgid, ptp_seqid(ptp_hdr));
+		return false;
+	}
+
+	MARVELL_PTP_CB(skb)->seq = ptp_seqid(ptp_hdr);
+	MARVELL_PTP_CB(skb)->timeout = jiffies +
+		msecs_to_jiffies(TX_TIMEOUT_MS);
+
+	if (cmpxchg(&ptp->tx_skb, NULL, skb) != NULL)
+		return false;
+
+	/* DP83640 marks the skb for hw timestamping. Since the MAC driver
+	 * may call skb_tx_timestamp() but may not support timestamping
+	 * itself, it may not set this flag. So, we need to do this here.
+	 */
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	marvell_ptp_schedule(ptp);
+
+	return true;
+}
+
+void marvell_ptp_txtstamp(struct marvell_ptp *ptp, struct sk_buff *skb,
+			  int type)
+{
+	if (!marvell_ptp_do_txtstamp(ptp, skb, type))
+		kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_txtstamp);
+
+int marvell_ptp_hwtstamp(struct marvell_ptp *ptp,
+			 struct kernel_hwtstamp_config *kcfg,
+			 struct netlink_ext_ack *ack)
+{
+	u16 cfg0 = PTP_PORT_CONFIG_0_DISPTP;
+	u16 cfg2 = 0;
+	int err;
+
+	if (kcfg->flags)
+		return -EINVAL;
+
+	switch (kcfg->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+
+	case HWTSTAMP_TX_ON:
+		cfg0 = 0;
+		cfg2 |= PTP_PORT_CONFIG_2_DEPINTEN;
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	switch (kcfg->rx_filter) {
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
+		kcfg->rx_filter = HWTSTAMP_FILTER_SOME;
+		cfg0 = 0;
+		cfg2 |= PTP_PORT_CONFIG_2_ARRINTEN;
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	err = ptp->ops->ptp_port_modify(ptp->dev, PTP_PORT_CONFIG_0,
+					PTP_PORT_CONFIG_0_DISPTP, cfg0);
+	if (err)
+		return err;
+
+	err = ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_2, cfg2);
+	if (err)
+		return err;
+
+	ptp->tx_type = kcfg->tx_type;
+	ptp->rx_filter = kcfg->rx_filter;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_hwtstamp);
+
+int marvell_ptp_ts_info(struct marvell_ptp *ptp,
+			struct kernel_ethtool_ts_info *ts_info)
+{
+	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				   SOF_TIMESTAMPING_RX_HARDWARE |
+				   SOF_TIMESTAMPING_RAW_HARDWARE;
+	ts_info->phc_index = marvell_tai_ptp_clock_index(ptp->tai);
+	ts_info->tx_types = BIT(HWTSTAMP_TX_OFF) |
+			    BIT(HWTSTAMP_TX_ON);
+	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			      BIT(HWTSTAMP_FILTER_SOME);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_ts_info);
+
+static int marvell_ptp_port_config(struct marvell_ptp *ptp)
+{
+	int err;
+
+	/* Disable transport specific check (if the PTP common header)
+	 * Disable timestamp overwriting (so we can read a stable entry.)
+	 * Disable PTP
+	 */
+	err = ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_0,
+				       PTP_PORT_CONFIG_0_DISTSPECCHECK |
+				       PTP_PORT_CONFIG_0_DISTSOVERWRITE |
+				       PTP_PORT_CONFIG_0_DISPTP);
+	if (err < 0)
+		return err;
+
+	/* Set ether-type jump to 12 (to ether protocol)
+	 * Set IP jump to 2 (to skip over ether protocol)
+	 * Does this mean it won't pick up on VLAN packets?
+	 */
+	err = ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_1,
+				       PTP_PORT_CONFIG_1_ETJUMP(12) |
+				       PTP_PORT_CONFIG_1_IPJUMP(2));
+	if (err < 0)
+		return err;
+
+	/* Disable all interrupts */
+	ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_2, 0);
+
+	return 0;
+}
+
+static void marvell_ptp_port_disable(struct marvell_ptp *ptp)
+{
+	/* Disable PTP */
+	ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_0,
+				 PTP_PORT_CONFIG_0_DISPTP);
+
+	/* Disable interrupts */
+	ptp->ops->ptp_port_write(ptp->dev, PTP_PORT_CONFIG_2, 0);
+}
+
+long marvell_ptp_aux_work(struct marvell_ptp *ptp)
+{
+	if (ptp->tx_skb)
+		marvell_ptp_txtstamp_complete(ptp);
+
+	marvell_ptp_rx_ts(ptp, 0);
+	marvell_ptp_rx_ts(ptp, 1);
+	marvell_ptp_rx_expire(ptp);
+
+	if (ptp->tx_skb)
+		return 0;
+	else if (!skb_queue_empty(&ptp->rxq[0].rx_queue) ||
+		 !skb_queue_empty(&ptp->rxq[1].rx_queue))
+		return 1;
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_aux_work);
+
+irqreturn_t marvell_ptp_irq(struct marvell_ptp *ptp)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	if (marvell_ptp_rx_ts(ptp, 0))
+		ret = IRQ_HANDLED;
+
+	if (marvell_ptp_rx_ts(ptp, 1))
+		ret = IRQ_HANDLED;
+
+	if (ptp->tx_skb && marvell_ptp_txtstamp_complete(ptp))
+		ret = IRQ_HANDLED;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_irq);
+
+int marvell_ptp_probe(struct marvell_ptp *ptp, struct device *dev,
+		      struct marvell_tai *tai,
+		      const struct marvell_ptp_ops *ops)
+{
+	int i;
+
+	ptp->ops = ops;
+	ptp->dev = dev;
+	ptp->tai = tai;
+
+	for (i = 0; i < ARRAY_SIZE(ptp->rxq); i++)
+		marvell_rxq_init(&ptp->rxq[i]);
+
+	/* Configure this PTP port */
+	return marvell_ptp_port_config(ptp);
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_probe);
+
+void marvell_ptp_remove(struct marvell_ptp *ptp)
+{
+	int i;
+
+	/* Free or dequeue all pending skbs */
+	if (ptp->tx_skb)
+		kfree_skb(ptp->tx_skb);
+
+	for (i = 0; i < ARRAY_SIZE(ptp->rxq); i++)
+		marvell_rxq_purge(&ptp->rxq[i]);
+
+	/* Ensure that the port is disabled */
+	marvell_ptp_port_disable(ptp);
+}
+EXPORT_SYMBOL_GPL(marvell_ptp_remove);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Marvell PTP library");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/marvell_ptp.h b/include/linux/marvell_ptp.h
new file mode 100644
index 000000000000..6e515648abaa
--- /dev/null
+++ b/include/linux/marvell_ptp.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_MARVELL_PTP_H
+#define LINUX_MARVELL_PTP_H
+
+#include <linux/irqreturn.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/skbuff.h>
+#include <linux/timecounter.h>
+
+struct device;
+struct ifreq;
+struct kernel_ethtool_ts_info;
+struct marvell_tai;
+struct netlink_ext_ack;
+
+#define MV_PTP_MSGTYPE_DELAY_RESP	9
+
+/* This defines which incoming or outgoing PTP frames are timestampped */
+#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
+				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
+				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
+/* Direct Sync messages to Arr0 and delay messages to Arr1 */
+#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
+				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
+
+struct marvell_extts {
+	u32 time;
+	u8 status;
+#define MV_STATUS_EVENTCAPVALID	BIT(8)
+};
+
+struct marvell_ts {
+	u32 time;
+	u16 stat;
+#define MV_STATUS_INTSTATUS_MASK	0x0006
+#define MV_STATUS_INTSTATUS_NORMAL	0x0000
+#define MV_STATUS_VALID			BIT(0)
+	u16 seq;
+};
+
+struct marvell_ptp_ops {
+	int (*tai_enable)(struct device *dev);
+	u64 (*tai_clock_read)(struct device *dev,
+			      struct ptp_system_timestamp *sts);
+	int (*tai_extts_read)(struct device *dev, int reg,
+			      struct marvell_extts *extts);
+	int (*tai_pin_verify)(struct device *dev, int pin,
+			      enum ptp_pin_function func, unsigned int chan);
+	int (*tai_pin_setup)(struct device *dev, int pin, unsigned int flags,
+			     int enable);
+	int (*tai_write)(struct device *dev, u8 reg, u16 val);
+	int (*tai_modify)(struct device *dev, u8 reg, u16 mask, u16 val);
+	int (*ptp_global_write)(struct device *dev, u8 reg, u16 val);
+	int (*ptp_port_read_ts)(struct device *dev, struct marvell_ts *ts,
+			        u8 reg);
+	int (*ptp_port_write)(struct device *dev, u8 reg, u16 val);
+	int (*ptp_port_modify)(struct device *dev, u8 reg, u16 mask, u16 val);
+	long (*ptp_aux_work)(struct device *dev);
+};
+
+/* TAI module */
+struct marvell_tai_param {
+	u32 cc_mult_num;
+	u32 cc_mult_den;
+	u32 cc_mult;
+	int cc_shift;
+
+	int n_ext_ts;
+};
+
+u64 marvell_tai_cyc2time(struct marvell_tai *tai, u32 cyc);
+int marvell_tai_ptp_clock_index(struct marvell_tai *tai);
+int marvell_tai_schedule(struct marvell_tai *tai, unsigned long delay);
+int marvell_tai_probe(struct marvell_tai **taip,
+		      const struct marvell_ptp_ops *ops,
+		      const struct marvell_tai_param *param,
+		      struct ptp_pin_desc *pin_config, int n_pins,
+		      const char *name, struct device *dev);
+void marvell_tai_remove(struct marvell_tai *tai);
+
+/* Timestamping module */
+struct marvell_rxts {
+	struct list_head node;
+	u64 ns;
+	u16 seq;
+};
+
+struct marvell_rxq {
+	struct mutex rx_mutex;
+	struct list_head rx_free;
+	struct list_head rx_pend;
+	struct sk_buff_head rx_queue;
+	struct marvell_rxts rx_ts[64];
+};
+
+struct marvell_ptp {
+	struct marvell_tai *tai;
+	const struct marvell_ptp_ops *ops;
+	struct device *dev;
+
+	/* We only support one outstanding transmit skb */
+	struct sk_buff *tx_skb;
+	enum hwtstamp_tx_types tx_type;
+
+	struct marvell_rxq rxq[2];
+	enum hwtstamp_rx_filters rx_filter;
+};
+
+bool marvell_ptp_rxtstamp(struct marvell_ptp *ptp, struct sk_buff *skb,
+			  int type);
+void marvell_ptp_txtstamp(struct marvell_ptp *ptp, struct sk_buff *skb,
+			  int type);
+int marvell_ptp_hwtstamp(struct marvell_ptp *ptp,
+			 struct kernel_hwtstamp_config *kcfg,
+			 struct netlink_ext_ack *ack);
+int marvell_ptp_ts_info(struct marvell_ptp *ptp,
+			struct kernel_ethtool_ts_info *ts_info);
+long marvell_ptp_aux_work(struct marvell_ptp *ptp);
+irqreturn_t marvell_ptp_irq(struct marvell_ptp *ptp);
+int marvell_ptp_probe(struct marvell_ptp *ptp, struct device *dev,
+		      struct marvell_tai *tai,
+		      const struct marvell_ptp_ops *ops);
+void marvell_ptp_remove(struct marvell_ptp *ptp);
+
+#endif
-- 
2.30.2


