Return-Path: <netdev+bounces-224558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44525B8643D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A0E7BE5CF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576D3164CB;
	Thu, 18 Sep 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g7Yy7x5n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FF314D28
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217147; cv=none; b=WPt3p8Z7NIOnVIDi00XRQo/xU2jhoY12g2zL6htRj8tz0y2cdyx8sygMHThGHxrseFzsqr7b0M5RnB+g7nawrkibPyLAac/xbqYtXqp2f7XeMOwsIuZUH5vFaP1rMH/Qia2kIaOUBHRMtkFnM9Q55mKeCOIw+LGMsVMxlBHCr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217147; c=relaxed/simple;
	bh=acfT5ZAK/lAml/OZfvcMthjaDYxBltwRWJ51G1g7L4Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JF1JziXNSDOrR3BnVaUxaFu7o0t8+vWF4/0sE7lEnoTgmQYCBHffBfgL/YFPfg1dfVsmUhaqUxLKREZGl8Bnp1wphEpYjKr9eJDRtzgPlXwDnLDPAWNE/Vk5xNk4x5FJmiE5WB0shmfoYq+HkNnwexIYFExaThCXnbj4zOJCIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g7Yy7x5n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x9QXpGR0V2KEBiWewogOyOzrYZ+YiL10XLzeZmkvppc=; b=g7Yy7x5n4UOPue50cSykDZ5ZMW
	1SJ7qdBRxsQpA+/OgDmq6pNVEJoT6l0XiK89H0/tqf7ODYvomt/uy5KF4r++mAs3oi3kNIz3ZCKDZ
	L36v5AWn3A5msI8cdzbENvoIWbyYW89RmINzKIP+SvrMgVi2kZ6bF4MVKZaQhXjoWeecVD0OG1c8Q
	FiVUk0DwTo2Q0Q4vWKncfYaYqUQICKdNACZxNEGxi7Xm4+Acr83P/NYQjDDilzvnwjTg7jzhKB84g
	o9Q7ubrqsS8Iuo6nrIO/b/2fDGtEnD9gZULagI76EsPFpaGHtf1ySs8WS3QuQral31LO/zAgEp564
	a3EFyHBg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39686 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIav-000000001aE-2rcz;
	Thu, 18 Sep 2025 18:38:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIau-00000006mz8-3a19;
	Thu, 18 Sep 2025 18:38:56 +0100
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
Subject: [PATCH RFC net-next 01/20] ptp: marvell: add core support for Marvell
 PTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIau-00000006mz8-3a19@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:38:56 +0100

Provide core support for the Marvell PTP implementations, which
consist of a TAI (time application interface) and timestamping blocks.
This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
Armada 37xx (mvneta), as well as Marvell DSA devices.

Support for both arrival timestamps is supported, we use arrival 1 for
PTP peer delay messages, and arrival 0 for all other messages, which
is the same as the Marvell DSA implementation.

External event capture is also supported.

PPS output and trigger generation is not supported.

This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
code and DP83640 drivers. Like the original 88E6xxx DSA code, we
use a delayed work to keep the cycle counter updated, and a separate
delayed work for event capture.

We expose the ptp clock aux work to allow users to support single and
multi-port designs. A multi-port design will have a single Marvell TAI
instance and one Marvell TS instance per port.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/ptp/Kconfig           |   4 +
 drivers/ptp/Makefile          |   2 +
 drivers/ptp/ptp_marvell_tai.c | 445 +++++++++++++++++++
 drivers/ptp/ptp_marvell_ts.c  | 778 ++++++++++++++++++++++++++++++++++
 include/linux/marvell_ptp.h   | 159 +++++++
 5 files changed, 1388 insertions(+)
 create mode 100644 drivers/ptp/ptp_marvell_tai.c
 create mode 100644 drivers/ptp/ptp_marvell_ts.c
 create mode 100644 include/linux/marvell_ptp.h

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5f8ea34d11d6..a01b1531d83e 100644
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
index bdc47e284f14..0327a97a7277 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
 obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
+obj-$(CONFIG_PTP_1588_CLOCK_MARVELL)	+= ptp-marvell.o
+ptp-marvell-y				:= ptp_marvell_tai.o ptp_marvell_ts.o
 obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
 obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
diff --git a/drivers/ptp/ptp_marvell_tai.c b/drivers/ptp/ptp_marvell_tai.c
new file mode 100644
index 000000000000..2802b72f54f1
--- /dev/null
+++ b/drivers/ptp/ptp_marvell_tai.c
@@ -0,0 +1,445 @@
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
+/* TAI Global status register
+ * 15  EventInt (A38x, 88E151x) - Event capture interrupt
+ * 14  Capture (88E6393) - Capture trigger (0=extts 1=PTP_TRIG internal event)
+ * 9   EventCapErr - Event capture error (overflow)
+ * 8   EventCapValid - Event capture valid
+ * 7:0 EventCapCtr - Event capture counter
+ */
+#define TAI_CONFIG_9				9
+#define TAI_CONFIG_9_EVENTCAPERR		BIT(9)
+#define TAI_CONFIG_9_EVENTCAPVALID		BIT(8)
+
+#define TAI_EVENT_POLL_INTERVAL msecs_to_jiffies(100)
+
+struct marvell_tai {
+	const struct marvell_tai_ops *ops;
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
+	struct delayed_work event_work;
+
+	/* Used while reading the TAI */
+	struct ptp_system_timestamp *sts;
+};
+
+static struct marvell_tai *cc_to_tai(struct cyclecounter *cc)
+{
+	return container_of(cc, struct marvell_tai, cyclecounter);
+}
+
+/* Read the global time registers using the readplus command */
+static u64 marvell_tai_clock_read(struct cyclecounter *cc)
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
+	if (err < 0) {
+		dev_err(tai->dev, "failed to read TAI event capture\n");
+		return;
+	}
+
+	if (extts.status & TAI_CONFIG_9_EVENTCAPERR) {
+		dev_warn(tai->dev, "extts timestamp overrun (%x)\n",
+			 extts.status);
+		return;
+	}
+
+	if (extts.status & TAI_CONFIG_9_EVENTCAPVALID) {
+		ev.type = PTP_CLOCK_EXTTS;
+		ev.index = 0;
+		ev.timestamp = marvell_tai_cyc2time(tai, extts.time);
+
+		ptp_clock_event(tai->ptp_clock, &ev);
+	}
+}
+
+static int marvell_tai_enable_extts(struct marvell_tai *tai,
+				    struct ptp_extts_request *req, int enable)
+{
+	int err, pin;
+	u16 cfg0;
+
+	/* Reject requests to enable timestamping on both edges if
+	 * userspace requests strict mode.
+	 */
+	if (req->flags & PTP_ENABLE_FEATURE &&
+	    req->flags & PTP_STRICT_FLAGS &&
+	    (req->flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EINVAL;
+
+	pin = ptp_find_pin(tai->ptp_clock, PTP_PF_EXTTS, req->index);
+	if (pin < 0)
+		return -EBUSY;
+
+	/* Setup this pin */
+	err = tai->ops->tai_pin_setup(tai->dev, pin, PTP_PF_EXTTS, enable);
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
+		 * than for falling. Marvell PHYs (88E151x) doesn't have
+		 * this.
+		 */
+		if (!(req->flags & PTP_RISING_EDGE))
+			cfg0 |= TAI_CONFIG_0_EVENTPHASE;
+
+		/* Enable the event interrupt and counter */
+		err = tai->ops->tai_modify(tai->dev, TAI_CONFIG_0,
+					   TAI_CONFIG_0_EVENTCAPOV |
+					   TAI_CONFIG_0_EVENTCTRSTART |
+					   TAI_CONFIG_0_EVENTCAPINTEN |
+					   TAI_CONFIG_0_EVENTPHASE, cfg0);
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
+	if (req->type != PTP_CLK_REQ_EXTTS)
+		return -EOPNOTSUPP;
+
+	return marvell_tai_enable_extts(ptp_to_tai(ptp), &req->extts, enable);
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
+	/* This driver only supports PTP_PF_EXTTS */
+	if (func != PTP_PF_EXTTS)
+		return -EOPNOTSUPP;
+
+	if (!tai->ops->tai_pin_verify)
+		return -EOPNOTSUPP;
+
+	return tai->ops->tai_pin_verify(tai->dev, pin, func, chan);
+}
+
+static long marvell_tai_aux_work(struct ptp_clock_info *ptp)
+{
+	struct marvell_tai *tai = ptp_to_tai(ptp);
+	long ret = -1;
+
+	if (tai->ops->tai_aux_work)
+		ret = tai->ops->tai_aux_work(tai->dev);
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
+	marvell_tai_extts(tai);
+
+	schedule_delayed_work(&tai->event_work, TAI_EVENT_POLL_INTERVAL);
+}
+
+/* Periodically read the timecounter to keep the time refreshed. */
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
+static int marvell_tai_hw_enable(struct marvell_tai *tai)
+{
+	return tai->ops->tai_hw_enable(tai->dev);
+}
+
+static void marvell_tai_hw_disable(struct marvell_tai *tai)
+{
+	tai->ops->tai_hw_disable(tai->dev);
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
+void marvell_tai_remove(struct marvell_tai *tai)
+{
+	ptp_clock_unregister(tai->ptp_clock);
+
+	/* tai->event_work will be disabled by ptp_clock_unregister()
+	 * disabling the pins, so there's no need call
+	 * cancel_delayed_work_sync(&tai->event_work) here.
+	 */
+
+	cancel_delayed_work_sync(&tai->overflow_work);
+
+	marvell_tai_hw_disable(tai);
+}
+EXPORT_SYMBOL_GPL(marvell_tai_remove);
+
+int marvell_tai_probe(struct marvell_tai **taip,
+		      const struct marvell_tai_ops *ops,
+		      const struct marvell_tai_param *param,
+		      const struct marvell_tai_pins *pins,
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
+	err = marvell_tai_hw_enable(tai);
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
+	tai->caps.adjfine = marvell_tai_adjfine;
+	tai->caps.adjtime = marvell_tai_adjtime;
+	tai->caps.gettimex64 = marvell_tai_gettimex64;
+	tai->caps.settime64 = marvell_tai_settime64;
+	tai->caps.do_aux_work = marvell_tai_aux_work;
+
+	if (pins) {
+		tai->caps.n_ext_ts = pins->n_ext_ts;
+		tai->caps.n_pins = pins->n_pins;
+		tai->caps.pin_config = pins->pins;
+		tai->caps.enable = marvell_tai_enable;
+		tai->caps.verify = marvell_tai_verify;
+
+		tai->caps.supported_extts_flags = PTP_STRICT_FLAGS |
+						  pins->supported_extts_flags;
+	}
+
+	INIT_DELAYED_WORK(&tai->overflow_work, marvell_tai_overflow_work);
+	INIT_DELAYED_WORK(&tai->event_work, marvell_tai_event_work);
+
+	tai->ptp_clock = ptp_clock_register(&tai->caps, dev);
+	if (IS_ERR(tai->ptp_clock)) {
+		marvell_tai_hw_disable(tai);
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
+static void marvell_tai_devm_remove(void *data)
+{
+	marvell_tai_remove(data);
+}
+
+int devm_marvell_tai_probe(struct marvell_tai **taip,
+			   const struct marvell_tai_ops *ops,
+			   const struct marvell_tai_param *param,
+			   const struct marvell_tai_pins *pins,
+			   const char *name, struct device *dev)
+{
+	int ret = marvell_tai_probe(taip, ops, param, pins, name, dev);
+
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, marvell_tai_devm_remove, *taip);
+}
+EXPORT_SYMBOL_GPL(devm_marvell_tai_probe);
diff --git a/drivers/ptp/ptp_marvell_ts.c b/drivers/ptp/ptp_marvell_ts.c
new file mode 100644
index 000000000000..46c82d4a490d
--- /dev/null
+++ b/drivers/ptp/ptp_marvell_ts.c
@@ -0,0 +1,778 @@
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
+/* Global configuration */
+
+/* This defines which incoming or outgoing PTP frames are timestamped.
+ * MV88E6xxx DSA sets messages types 0-3 (sync, delay request, pdelay
+ * request and pdelay response.)
+ *
+ * We need to timestamp `t1' the departure of Sync (0) messages so that
+ * timestamp can be sent in the Follow_Up message. We also need to
+ * timestamp the arrival of these messages to give `t2'.
+ *
+ * We need to timestamp the transmission of the Delay_Req (1) messages
+ * for `t3' and the arrival of this mssage for `t4'.
+ *
+ * For IEEE1588 v2, we also need to timestamp the PDelay_Req (3) and
+ * PDelay_Resp (4) messages.
+ *
+ * The Follow_Up (8) and Delay_Resp (9) messages do not need to be
+ * timestamped.
+ *
+ * PTP_MSGTYPE_PDELAY_REQ, PTP_MSGTYPE_PDELAY_RESP
+ */
+#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
+				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
+				 BIT(PTP_MSGTYPE_PDELAY_REQ) | \
+				 BIT(PTP_MSGTYPE_PDELAY_RESP))
+
+/* Direct Sync messages to Arr0 and delay messages to Arr1. MV88E6xxx
+ * DSA sets message type 3 (pdelay response.)
+ *
+ * Putting Delay_Req (1) arrival into Arr1 means that if we have a busy
+ * network with Sync (0) messages also being received, we still get a
+ * hardware timestamp for the Delay_Req message.
+ *
+ * PTP_MSGTYPE_PDELAY_RESP
+ */
+#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
+				 BIT(PTP_MSGTYPE_PDELAY_RESP))
+
+/* Armada 38x and 88e151x calls this PTP Global Configuration 0:
+ * 15:0 PTPEType - Ethernet type
+ */
+#define PTPG_ETYPE			0
+
+/* Armada 38x and 88e151x calls this PTP Global Configuration1
+ * 15:0 MsgIDTSEn - Message Identifier Time Stamp Enable
+ * 15:0 MsgType (88E6393x) Message Type Time Stamp Enable
+ */
+#define PTPG_MSGIDTSEN			1
+
+/* Armada 38x and 88e151x calls this PTP Global Configuration2
+ * 15:0 TSArrPtr - Time Stamp Arrival Time Pointer
+ */
+#define PTPG_TSARRPTR			2
+
+/* Armada 38x calls this PTP Global Status0. 88E151x "PTP Global Status".
+ * Armada 38x: 5:0 PTPInt - Port interrupt
+ * 88E151x   : 0: PTPInt - Interrupt
+ */
+#define PTPG_STATUS				8
+
+#define TX_TIMEOUT_MS	40
+#define RX_TIMEOUT_MS	40
+
+#define PTP_PORT_CONFIG_0			0
+#define PTP_PORT_CONFIG_0_DISTSPECCHECK		BIT(11)
+#define PTP_PORT_CONFIG_0_DISTSOVERWRITE	BIT(1)
+#define PTP_PORT_CONFIG_0_DISPTP		BIT(0)
+#define PTP_PORT_CONFIG_1			1
+#define PTP_PORT_CONFIG_1_IPJUMP		GENMASK(13, 8)
+#define PTP_PORT_CONFIG_1_ETJUMP		GENMASK(4, 0)
+#define PTP_PORT_CONFIG_2			2
+#define PTP_PORT_CONFIG_2_DEPINTEN		BIT(1)
+#define PTP_PORT_CONFIG_2_ARRINTEN		BIT(0)
+
+struct marvell_ts_cb {
+	const struct ptp_header *hdr;
+	unsigned long timeout;
+	u16 seq;
+};
+#define MARVELL_TS_CB(skb)	((struct marvell_ts_cb *)(skb)->cb)
+
+/* RX queue support */
+
+/* Deliver a skb with its timestamp back to the networking core */
+static void marvell_rxq_rx(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+
+	pr_debug("rx: seq %u delivering timestamp\n", MARVELL_TS_CB(skb)->seq);
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
+		if (MARVELL_TS_CB(skb)->seq == seq) {
+			__skb_unlink(skb, &rxq->rx_queue);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_debug("rx: seq %u skb not found, pending\n", seq);
+
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
+				 u16 seq, const struct ptp_header *hdr)
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
+		pr_debug("rx: seq %u pending ts not found, queueing\n", seq);
+
+		/* Store the seqid and queue the skb. Do this under the lock
+		 * to ensure we don't miss any timestamps appended to the
+		 * rx_pend list.
+		 */
+		MARVELL_TS_CB(skb)->hdr = hdr;
+		MARVELL_TS_CB(skb)->seq = seq;
+		MARVELL_TS_CB(skb)->timeout = jiffies +
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
+		 * and return "false" from marvell_ts_rxtstamp() instead?
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
+		if (!time_is_before_jiffies(MARVELL_TS_CB(skb)->timeout)) {
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
+static void marvell_ts_schedule(struct marvell_ts *ts)
+{
+	marvell_tai_schedule(ts->tai, 0);
+}
+
+/* Check for a rx timestamp entry, try to find the corresponding skb and
+ * deliver it, otherwise add the rx timestamp to the queue of pending
+ * timestamps.
+ */
+static int marvell_ts_rx_ts(struct marvell_ts *ts, int q)
+{
+	enum marvell_ts_reg reg;
+	struct marvell_hwts hwts;
+	int err;
+	u64 ns;
+
+	if (q)
+		reg = MARVELL_TS_ARR1;
+	else
+		reg = MARVELL_TS_ARR0;
+
+	err = ts->ops->ts_port_read_ts(ts->dev, &hwts, ts->port, reg);
+	dev_dbg(ts->dev, "p%uq%u: rx: read_ts %d\n", ts->port, q, err);
+	if (err <= 0)
+		return 0;
+
+	dev_dbg(ts->dev, "p%uq%u: tx: stat=0x%x seq=%u ts=%u\n",
+		ts->port, q, hwts.stat, hwts.seq, hwts.time);
+
+	if ((hwts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL)
+		dev_warn(ts->dev,
+			 "p%uq%u: rx: timestamp overrun (stat=0x%x seq=%u)\n",
+			 ts->port, q, hwts.stat, hwts.seq);
+
+	ns = marvell_tai_cyc2time(ts->tai, hwts.time);
+
+	marvell_rxq_rx_ts(&ts->rxq[q], hwts.seq, ns);
+
+	return 1;
+}
+
+/* Check whether the packet is suitable for timestamping, and if so,
+ * try to find a pending timestamp for it. If no timestamp is found,
+ * queue the packet with a timeout.
+ */
+bool marvell_ts_rxtstamp(struct marvell_ts *ts, struct sk_buff *skb, int type)
+{
+	const struct ptp_header *ptp_hdr;
+	u16 msgidvec, seq;
+	unsigned int q;
+	u8 msgid;
+
+	if (ts->rx_filter == HWTSTAMP_FILTER_NONE)
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
+		dev_dbg(ts->dev, "p%u: rx: not timestamping msgid %u seq %u\n",
+			ts->port, msgid, seq);
+		return false;
+	}
+
+	/* Determine the queue which the timestamp for this message ID will
+	 * appear. This is part of the global configuration and is therefore
+	 * fixed.
+	 */
+	q = !!(msgidvec & MV_PTP_TS_ARR_PTR);
+
+	dev_dbg(ts->dev, "p%uq%u: rx: timestamping msgid %u seq %u\n",
+		ts->port, q, msgid, seq);
+
+	if (!marvell_rxq_rxtstamp(&ts->rxq[q], skb, seq, ptp_hdr))
+		marvell_ts_schedule(ts);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_rxtstamp);
+
+/* Move any expired skbs on to our own list, and then hand the contents of
+ * our list to netif_rx() - this avoids calling netif_rx() with our
+ * mutex held.
+ */
+static void marvell_ts_rx_expire(struct marvell_ts *ts)
+{
+	const struct ptp_header *ptp_hdr;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int i;
+
+	__skb_queue_head_init(&list);
+
+	for (i = 0; i < ARRAY_SIZE(ts->rxq); i++)
+		marvell_rxq_expire(&ts->rxq[i], &list);
+
+	while ((skb = __skb_dequeue(&list)) != NULL) {
+		ptp_hdr = MARVELL_TS_CB(skb)->hdr;
+		dev_warn(ts->dev, "p%u: rx: expiring skb: seq=%u msgid=%u\n",
+			 ts->port, MARVELL_TS_CB(skb)->seq,
+			 ptp_msgid(ptp_hdr));
+		netif_rx(skb);
+	}
+}
+
+/* Complete the transmit timestamping; this is called to read the transmit
+ * timestamp from the PHY, and report back the transmitted timestamp.
+ */
+static int marvell_ts_txtstamp_complete(struct marvell_ts *ts)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb = ts->tx_skb;
+	struct marvell_hwts hwts;
+	int err;
+	u64 ns;
+
+	err = ts->ops->ts_port_read_ts(ts->dev, &hwts, ts->port,
+				       MARVELL_TS_DEP);
+	dev_dbg(ts->dev, "p%u: tx: read_ts %d\n", ts->port, err);
+	if (err < 0)
+		goto fail;
+
+	if (err == 0) {
+		if (time_is_before_jiffies(MARVELL_TS_CB(skb)->timeout)) {
+			dev_warn(ts->dev, "p%u: tx: timestamp timeout\n",
+				 ts->port);
+			goto free;
+		}
+		return 0;
+	}
+
+	dev_dbg(ts->dev, "p%u: tx: stat=0x%x seq=%u ts=%u\n", ts->port,
+		hwts.stat, hwts.seq, hwts.time);
+
+	/* Check the status */
+	if ((hwts.stat & MV_STATUS_INTSTATUS_MASK) !=
+	    MV_STATUS_INTSTATUS_NORMAL) {
+		dev_warn(ts->dev,
+			 "p%u: tx: timestamp overrun (stat=0x%x seq=%u)\n",
+			 ts->port, hwts.stat, hwts.seq);
+		goto free;
+	}
+
+	/* Reject if the sequence number doesn't match */
+	if (hwts.seq != MARVELL_TS_CB(skb)->seq) {
+		dev_warn(ts->dev,
+			 "p%u: tx: timestamp unexpected sequence id\n",
+			 ts->port);
+		goto free;
+	}
+
+	ts->tx_skb = NULL;
+
+	/* Set the timestamp */
+	ns = marvell_tai_cyc2time(ts->tai, hwts.time);
+	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+	shhwtstamps.hwtstamp = ns_to_ktime(ns);
+	skb_complete_tx_timestamp(skb, &shhwtstamps);
+	return 1;
+
+fail:
+	dev_err_ratelimited(ts->dev, "p%u: failed reading PTP: %pe\n",
+			    ts->port, ERR_PTR(err));
+free:
+	dev_kfree_skb_any(skb);
+	ts->tx_skb = NULL;
+	return -1;
+}
+
+/* Check whether the skb will be timestamped on transmit; we only support
+ * a single outstanding skb. Add it if the slot is available. It is the
+ * responsibility of the caller to check tx_flags.
+ */
+bool marvell_ts_txtstamp(struct marvell_ts *ts, struct sk_buff *skb, int type)
+{
+	const struct ptp_header *ptp_hdr;
+	u8 msgid;
+
+	if (ts->tx_type != HWTSTAMP_TX_ON)
+		return false;
+
+	ptp_hdr = ptp_parse_header(skb, type);
+	if (!ptp_hdr)
+		return false;
+
+	msgid = ptp_msgid(ptp_hdr);
+	if (BIT(msgid) & ~MV_PTP_MSD_ID_TS_EN) {
+		dev_dbg(ts->dev, "p%u: tx: not timestamping msgid %u seq %u\n",
+			ts->port, msgid, ptp_seqid(ptp_hdr));
+		return false;
+	}
+
+	MARVELL_TS_CB(skb)->seq = ptp_seqid(ptp_hdr);
+	MARVELL_TS_CB(skb)->timeout = jiffies +
+		msecs_to_jiffies(TX_TIMEOUT_MS);
+
+	dev_dbg(ts->dev, "p%u: tx: new, msgid=%u seq=%u\n", ts->port,
+		msgid, MARVELL_TS_CB(skb)->seq);
+
+	if (cmpxchg(&ts->tx_skb, NULL, skb) != NULL)
+		return false;
+
+	/* DP83640 marks the skb for hw timestamping. Since the MAC driver
+	 * may call skb_tx_timestamp() but may not support timestamping
+	 * itself, it may not set this flag. So, we need to do this here.
+	 */
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+	/* Only schedule the aux_work if we haven't seen an interrupt. */
+	if (!ts->irq_handler_called)
+		marvell_ts_schedule(ts);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_txtstamp);
+
+int marvell_ts_hwtstamp_get(struct marvell_ts *ts,
+			    struct kernel_hwtstamp_config *kcfg)
+{
+	kcfg->flags = 0;
+	kcfg->tx_type = ts->tx_type;
+	kcfg->rx_filter = ts->rx_filter;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_hwtstamp_get);
+
+int marvell_ts_hwtstamp_set(struct marvell_ts *ts,
+			    struct kernel_hwtstamp_config *kcfg,
+			    struct netlink_ext_ack *ack)
+{
+	u16 cfg0 = PTP_PORT_CONFIG_0_DISPTP;
+	bool enabled = false;
+	bool old_enabled;
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
+		enabled = true;
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
+
+	/* UDPv4/IP PTP v2*/
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+
+	/* 802.1AS PTP v2 */
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+
+	/* 802.1AS and/or UDPv4/IP PTP v2 */
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
+		enabled = true;
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	old_enabled = ts->tx_type != HWTSTAMP_TX_OFF ||
+		      ts->rx_filter != HWTSTAMP_FILTER_NONE;
+	if (ts->ops->ts_port_enable && enabled && !old_enabled) {
+		err = ts->ops->ts_port_enable(ts->dev, ts->port);
+		if (err)
+			return err;
+	}
+
+	err = ts->ops->ts_port_modify(ts->dev, ts->port, PTP_PORT_CONFIG_0,
+				      PTP_PORT_CONFIG_0_DISPTP, cfg0);
+	if (err)
+		return err;
+
+	err = ts->ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_2,
+				     cfg2);
+	if (err)
+		return err;
+
+	if (ts->ops->ts_port_disable && !enabled && old_enabled)
+		ts->ops->ts_port_disable(ts->dev, ts->port);
+
+	ts->tx_type = kcfg->tx_type;
+	ts->rx_filter = kcfg->rx_filter;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_hwtstamp_set);
+
+int marvell_ts_info(struct marvell_ts *ts,
+		    struct kernel_ethtool_ts_info *ts_info)
+{
+	if (!ts->tai)
+		return 0;
+
+	ts_info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				    SOF_TIMESTAMPING_RX_HARDWARE |
+				    SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	ts_info->phc_index = marvell_tai_ptp_clock_index(ts->tai);
+
+	ts_info->tx_types = BIT(HWTSTAMP_TX_OFF) |
+			    BIT(HWTSTAMP_TX_ON);
+
+	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			      ts->caps->rx_filters;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_info);
+
+static int marvell_ts_port_config(struct marvell_ts *ts)
+{
+	const struct marvell_ts_ops *ops = ts->ops;
+	int err;
+
+	/* Disable transport specific check (if the PTP common header)
+	 * Disable timestamp overwriting (so we can read a stable entry.)
+	 * Disable PTP
+	 */
+	err = ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_0,
+				 PTP_PORT_CONFIG_0_DISTSPECCHECK |
+				 PTP_PORT_CONFIG_0_DISTSOVERWRITE |
+				 PTP_PORT_CONFIG_0_DISPTP);
+	if (err < 0)
+		return err;
+
+	/* Set ether-type jump to 12 (to ether protocol)
+	 * Set IP jump to 2 (to skip over ether protocol)
+	 * Does this mean it won't pick up on VLAN packets?
+	 */
+	err = ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_1,
+				 FIELD_PREP(PTP_PORT_CONFIG_1_IPJUMP, 2) |
+				 FIELD_PREP(PTP_PORT_CONFIG_1_ETJUMP, 12));
+	if (err < 0)
+		return err;
+
+	/* Disable all interrupts */
+	ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_2, 0);
+
+	return 0;
+}
+
+static void marvell_ts_port_disable(struct marvell_ts *ts)
+{
+	/* Disable PTP */
+	ts->ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_0,
+			       PTP_PORT_CONFIG_0_DISPTP);
+
+	/* Disable interrupts */
+	ts->ops->ts_port_write(ts->dev, ts->port, PTP_PORT_CONFIG_2, 0);
+
+	/* Disable the port */
+	if (ts->ops->ts_port_disable &&
+	    (ts->tx_type != HWTSTAMP_TX_OFF ||
+	     ts->rx_filter != HWTSTAMP_FILTER_NONE))
+		ts->ops->ts_port_disable(ts->dev, ts->port);
+}
+
+long marvell_ts_aux_work(struct marvell_ts *ts)
+{
+	if (!ts->irq_handler_called) {
+		if (ts->rx_filter != HWTSTAMP_FILTER_NONE) {
+			marvell_ts_rx_ts(ts, 0);
+			marvell_ts_rx_ts(ts, 1);
+		}
+
+		if (ts->tx_skb)
+			marvell_ts_txtstamp_complete(ts);
+	}
+
+	marvell_ts_rx_expire(ts);
+
+	if (ts->tx_skb)
+		return 0;
+	else if (!skb_queue_empty(&ts->rxq[0].rx_queue) ||
+		 !skb_queue_empty(&ts->rxq[1].rx_queue))
+		return 1;
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_aux_work);
+
+irqreturn_t marvell_ts_irq(struct marvell_ts *ts)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ts->irq_handler_called = true;
+
+	if (marvell_ts_rx_ts(ts, 0))
+		ret = IRQ_HANDLED;
+
+	if (marvell_ts_rx_ts(ts, 1))
+		ret = IRQ_HANDLED;
+
+	if (ts->tx_skb && marvell_ts_txtstamp_complete(ts))
+		ret = IRQ_HANDLED;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_irq);
+
+/* Configure the global (shared between ports) configuration for the PHY. */
+int marvell_ts_global_config(struct device *dev,
+			     const struct marvell_ts_ops *ops)
+{
+	int err;
+
+	/* Set ether-type for IEEE1588 packets */
+	err = ops->ts_global_write(dev, PTPG_ETYPE, ETH_P_1588);
+	if (err < 0)
+		return err;
+
+	/* MsdIDTSEn - Enable timestamping on all PTP MessageIDs */
+	err = ops->ts_global_write(dev, PTPG_MSGIDTSEN, MV_PTP_MSD_ID_TS_EN);
+	if (err < 0)
+		return err;
+
+	/* TSArrPtr - Point to Arr0 registers */
+	err = ops->ts_global_write(dev, PTPG_TSARRPTR, MV_PTP_TS_ARR_PTR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_ts_global_config);
+
+void marvell_ts_remove(struct marvell_ts *ts)
+{
+	int i;
+
+	if (!ts->tai)
+		return;
+
+	/* Ensure that the port is disabled */
+	marvell_ts_port_disable(ts);
+
+	/* Free or dequeue all pending skbs */
+	if (ts->tx_skb)
+		kfree_skb(ts->tx_skb);
+
+	for (i = 0; i < ARRAY_SIZE(ts->rxq); i++)
+		marvell_rxq_purge(&ts->rxq[i]);
+}
+EXPORT_SYMBOL_GPL(marvell_ts_remove);
+
+int marvell_ts_probe(struct marvell_ts *ts, struct device *dev,
+		     struct marvell_tai *tai,
+		     const struct marvell_ts_caps *caps,
+		     const struct marvell_ts_ops *ops, u8 port)
+{
+	int i;
+
+	ts->ops = ops;
+	ts->dev = dev;
+	ts->tai = tai;
+	ts->caps = caps;
+	ts->port = port;
+
+	for (i = 0; i < ARRAY_SIZE(ts->rxq); i++)
+		marvell_rxq_init(&ts->rxq[i]);
+
+	/* Configure this PTP port */
+	return marvell_ts_port_config(ts);
+}
+EXPORT_SYMBOL_GPL(marvell_ts_probe);
+
+static void marvell_ts_devm_remove(void *data)
+{
+	marvell_ts_remove(data);
+}
+
+int devm_marvell_ts_probe(struct marvell_ts *ts, struct device *dev,
+			  struct marvell_tai *tai,
+			  const struct marvell_ts_caps *caps,
+			  const struct marvell_ts_ops *ops, u8 port)
+{
+	int ret = marvell_ts_probe(ts, dev, tai, caps, ops, port);
+
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, marvell_ts_devm_remove, ts);
+}
+EXPORT_SYMBOL_GPL(devm_marvell_ts_probe);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Marvell PTP library");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/marvell_ptp.h b/include/linux/marvell_ptp.h
new file mode 100644
index 000000000000..8d70392b820c
--- /dev/null
+++ b/include/linux/marvell_ptp.h
@@ -0,0 +1,159 @@
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
+struct marvell_extts {
+	u32 time;
+	u8 status;
+#define MV_STATUS_EVENTCAPVALID	BIT(8)
+};
+
+struct marvell_tai_ops {
+	int (*tai_hw_enable)(struct device *dev);
+	void (*tai_hw_disable)(struct device *dev);
+	u64 (*tai_clock_read)(struct device *dev,
+			      struct ptp_system_timestamp *sts);
+	int (*tai_extts_read)(struct device *dev, int reg,
+			      struct marvell_extts *extts);
+	int (*tai_pin_verify)(struct device *dev, int pin,
+			      enum ptp_pin_function func, unsigned int chan);
+	int (*tai_pin_setup)(struct device *dev, int pin,
+			     enum ptp_pin_function func, int enable);
+	int (*tai_write)(struct device *dev, u8 reg, u16 val);
+	int (*tai_modify)(struct device *dev, u8 reg, u16 mask, u16 val);
+	long (*tai_aux_work)(struct device *dev);
+};
+
+/* TAI module */
+struct marvell_tai_param {
+	u32 cc_mult_num;
+	u32 cc_mult_den;
+	u32 cc_mult;
+	int cc_shift;
+};
+
+struct marvell_tai_pins {
+	struct ptp_pin_desc *pins;
+	int n_pins;
+	int n_ext_ts;
+	unsigned int supported_extts_flags;
+};
+
+u64 marvell_tai_cyc2time(struct marvell_tai *tai, u32 cyc);
+int marvell_tai_ptp_clock_index(struct marvell_tai *tai);
+int marvell_tai_schedule(struct marvell_tai *tai, unsigned long delay);
+void marvell_tai_remove(struct marvell_tai *tai);
+int marvell_tai_probe(struct marvell_tai **taip,
+		      const struct marvell_tai_ops *ops,
+		      const struct marvell_tai_param *param,
+		      const struct marvell_tai_pins *pins,
+		      const char *name, struct device *dev);
+int devm_marvell_tai_probe(struct marvell_tai **taip,
+			   const struct marvell_tai_ops *ops,
+			   const struct marvell_tai_param *param,
+			   const struct marvell_tai_pins *pins,
+			   const char *name, struct device *dev);
+
+/* Timestamping module */
+struct marvell_hwts {
+	u32 time;
+	u16 stat;
+#define MV_STATUS_INTSTATUS_MASK	0x0006
+#define MV_STATUS_INTSTATUS_NORMAL	0x0000
+#define MV_STATUS_VALID			BIT(0)
+	u16 seq;
+};
+
+enum marvell_ts_reg {
+	MARVELL_TS_ARR0,
+	MARVELL_TS_ARR1,
+	MARVELL_TS_DEP,
+};
+
+struct marvell_ts_ops {
+	int (*ts_global_write)(struct device *dev, u8 reg, u16 val);
+	int (*ts_port_enable)(struct device *dev, u8 port);
+	void (*ts_port_disable)(struct device *dev, u8 port);
+	int (*ts_port_read_ts)(struct device *dev, struct marvell_hwts *ts,
+			        u8 port, enum marvell_ts_reg ts_reg);
+	int (*ts_port_write)(struct device *dev, u8 port, u8 reg, u16 val);
+	int (*ts_port_modify)(struct device *dev, u8 port, u8 reg, u16 mask,
+			       u16 val);
+};
+
+struct marvell_ts_caps {
+	u32 rx_filters;
+};
+
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
+struct marvell_ts {
+	struct marvell_tai *tai;
+	const struct marvell_ts_ops *ops;
+	struct device *dev;
+
+	/* We only support one outstanding transmit skb */
+	struct sk_buff *tx_skb;
+	enum hwtstamp_tx_types tx_type;
+
+	struct marvell_rxq rxq[2];
+	enum hwtstamp_rx_filters rx_filter;
+
+	const struct marvell_ts_caps *caps;
+	u8 port;
+
+	bool irq_handler_called;
+};
+
+bool marvell_ts_rxtstamp(struct marvell_ts *ts, struct sk_buff *skb, int type);
+bool marvell_ts_txtstamp(struct marvell_ts *ts, struct sk_buff *skb, int type);
+int marvell_ts_hwtstamp_get(struct marvell_ts *ts,
+			    struct kernel_hwtstamp_config *kcfg);
+int marvell_ts_hwtstamp_set(struct marvell_ts *ts,
+			    struct kernel_hwtstamp_config *kcfg,
+			    struct netlink_ext_ack *ack);
+int marvell_ts_info(struct marvell_ts *ts,
+		    struct kernel_ethtool_ts_info *ts_info);
+long marvell_ts_aux_work(struct marvell_ts *ts);
+irqreturn_t marvell_ts_irq(struct marvell_ts *ts);
+int marvell_ts_global_config(struct device *dev,
+			     const struct marvell_ts_ops *ops);
+
+void marvell_ts_remove(struct marvell_ts *ts);
+int marvell_ts_probe(struct marvell_ts *ts, struct device *dev,
+		     struct marvell_tai *tai,
+		     const struct marvell_ts_caps *caps,
+		     const struct marvell_ts_ops *ops, u8 port);
+int devm_marvell_ts_probe(struct marvell_ts *ts, struct device *dev,
+			  struct marvell_tai *tai,
+			  const struct marvell_ts_caps *caps,
+			  const struct marvell_ts_ops *ops, u8 port);
+
+#endif
-- 
2.47.3


