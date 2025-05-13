Return-Path: <netdev+bounces-190210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1DAB585A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01977B3AE7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D932D0286;
	Tue, 13 May 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMkNnoqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrsEkRGd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241982BE7B8;
	Tue, 13 May 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149228; cv=none; b=uqyCArUmZUgWeylJFasH1J1HHUgN/oU2rRp3eyuBB/k9WJIDEbeoHZtF6j77fQ0rXGyciJBp5yKmwIQXTCqn147fxpV3V2jjgaGvxAZDaRcOon9UjZ2k8YTFUiYPh8VJViNUe6lxn+SNt5DavYWHcajKQjBWQl4baYr7AeAj/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149228; c=relaxed/simple;
	bh=41v7R615ZjWO7LUc2GvrJB6a77p2xlm3SbRtu9DjoEY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hGKr7TGIp+Nr3Z5mtFmLcbbQ2HNTsK2/CP9f+LylTDHp35DNcJ+BR9csnaoJBvYbKcBPguRjSx/GFM8BeC6nt80hCGMaXPbWsB3C8DDpDDE16Zw44+wakte5zNqGkGdulS3R/xlEBnrGdq/JSUCj0aUea9PNSk6axe+qfFAoLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMkNnoqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrsEkRGd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145138.212062332@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C/nM/U5FRwaKrJBXZ75yUzC1wtA3Or236TCJmRmP5DU=;
	b=DMkNnoqYgQEe1rVzPnNkHzukFoOaWhepgv0FcX74b4P36xUtV+Eb5v9vP0FoQRMP3fTWM4
	mV19RLhrPko7tTfxeWlmWWLEGJu09p8dAujukhwBD6rwQHTENp2MtERfhqo5TIJKCUlxoS
	KPtS+9TzG9Ta6BTETVSDcMIxuNfa+1vdkcfddQBkhOXfC0qTUpWbKSXeZDiTMqeFq81Xkh
	N31QvJwh79fsLD88R68Aft3FDIlov7Djo0Tw8luodFdU2RBExF2RWNNYPNSfHWDZKA0SXa
	XSxFhYjn69vk+TVln+Mr1wGPTH7xiizuqpfGACaf7F/FnBwbEDSpd9PL8RQj1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C/nM/U5FRwaKrJBXZ75yUzC1wtA3Or236TCJmRmP5DU=;
	b=wrsEkRGdB5n8wpG+GCkszFKbZ6zRdPejuIf7pcn9CK8JiiB3kGQCvImxMAAmYONUvDeJVv
	m3qjrLzbgAdbvaCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 26/26] timekeeping: Provide interface to control independent
 PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:44 +0200 (CEST)

Independent PTP clocks are disabled by default and attempts to access them
fail.

Provide an interface to enable/disable them at run-time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/ABI/stable/sysfs-kernel-time-ptp |    6 +
 kernel/time/timekeeping.c                      |  125 +++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-time-ptp
@@ -0,0 +1,6 @@
+What:		/sys/kernel/time/ptp/<ID>/enable
+Date:		May 2025
+Contact:	Thomas Gleixner <tglx@linutronix.de>
+Description:
+		Controls the enablement of independent PTP clock
+		timekeepers.
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/sched/loadavg.h>
 #include <linux/sched/clock.h>
 #include <linux/syscore_ops.h>
+#include <linux/sysfs.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
@@ -2900,6 +2901,130 @@ const struct k_clock clock_ptp = {
 	.clock_adj		= ptp_clock_adj,
 };
 
+static void ptp_clock_enable(unsigned int id)
+{
+	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
+	struct tk_data *tkd = ptp_get_tk_data(id);
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
+
+	/* Prevent the core timekeeper from changing. */
+	guard(raw_spinlock_irq)(&tk_core.lock);
+
+	/*
+	 * Setup the PTP clock assuming that the raw core timekeeper clock
+	 * frequency conversion is close enough. PTP userspace has to
+	 * adjust for the deviation via clock_adjtime(2).
+	 */
+	guard(raw_spinlock_nested)(&tkd->lock);
+
+	/* Remove leftovers of a previous registration */
+	memset(tks, 0, sizeof(*tks));
+	/* Restore the timekeeper id */
+	tks->id = tkd->timekeeper.id;
+	/* Setup the timekeeper based on the current system clocksource */
+	tk_setup_internals(tks, tkr_raw->clock);
+
+	/* Mark it valid and set it live */
+	tks->clock_valid = true;
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+}
+
+static void ptp_clock_disable(unsigned int id)
+{
+	struct tk_data *tkd = ptp_get_tk_data(id);
+
+	guard(raw_spinlock_irq)(&tkd->lock);
+	tkd->shadow_timekeeper.clock_valid = false;
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+}
+
+static DEFINE_MUTEX(ptp_clock_mutex);
+
+static ssize_t ptp_clock_enable_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+	bool enable;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	guard(mutex)(&ptp_clock_mutex);
+	if (enable == test_bit(id, &ptp_timekeepers))
+		return count;
+
+	if (enable) {
+		ptp_clock_enable(CLOCK_PTP + id);
+		set_bit(id, &ptp_timekeepers);
+	} else {
+		ptp_clock_disable(CLOCK_PTP + id);
+		clear_bit(id, &ptp_timekeepers);
+	}
+	return count;
+}
+
+static ssize_t ptp_clock_enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	unsigned long active = READ_ONCE(ptp_timekeepers);
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+
+	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
+}
+
+static struct kobj_attribute ptp_clock_enable_attr = __ATTR_RW(ptp_clock_enable);
+
+static struct attribute *ptp_clock_enable_attrs[] = {
+	&ptp_clock_enable_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ptp_clock_enable_attr_group = {
+	.attrs = ptp_clock_enable_attrs,
+};
+
+static int __init tk_ptp_sysfs_init(void)
+{
+	struct kobject *ptpo, *tko = kobject_create_and_add("time", kernel_kobj);
+
+	if (!tko) {
+		pr_warn("Unable to create /sys/kernel/time/. POSIX PTP clocks disabled.\n");
+		return -ENOMEM;
+	}
+
+	ptpo = kobject_create_and_add("ptp_clocks", tko);
+	if (!ptpo) {
+		pr_warn("Unable to create /sys/kernel/time/ptp_clocks. POSIX PTP clocks disabled.\n");
+		kobject_put(tko);
+		return -ENOMEM;
+	}
+
+	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++) {
+		char id[2] = { [0] = '0' + (i - TIMEKEEPER_PTP), };
+		struct kobject *clk = kobject_create_and_add(id, ptpo);
+
+		if (!clk) {
+			pr_warn("Unable to create /sys/kernel/time/ptp_clocks/%d\n",
+				i - TIMEKEEPER_PTP);
+			return -ENOMEM;
+		}
+
+		int ret = sysfs_create_group(clk, &ptp_clock_enable_attr_group);
+
+		if (ret) {
+			pr_warn("Unable to create /sys/kernel/time/ptp_clocks/%d/enable\n",
+				i - TIMEKEEPER_PTP);
+			return ret;
+		}
+	}
+	return 0;
+}
+late_initcall(tk_ptp_sysfs_init);
+
 static __init void tk_ptp_setup(void)
 {
 	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)


