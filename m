Return-Path: <netdev+bounces-201304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A80AE8CC1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8E47B79AC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DF2E6D3D;
	Wed, 25 Jun 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxx0I5CV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RK72PhBQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836552E3388;
	Wed, 25 Jun 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876733; cv=none; b=XkDHtyZB4qZKhI2zcuQLZfEL11+Bjs3nxTosmfne34tVZ8QjqPw2bKHWIPInrgSwmOvutLEuyx9qUpDO+vmHFP6y/j/+VFTyTJwauT7Vf3X+vj7wnrGiU6H9lfN4po0uPWPrW11Qlqn91RXeLJaJEAcZayh56q2ddZiQYy/AiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876733; c=relaxed/simple;
	bh=NMUMEIPyHxhekNIC8s3B1N0LZPU2VVuPf954wipIkD0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JPeUYibI79mrDIHbeffAOLB14JPJVhpv/adO89W9hL5YKc4pvrPLNQGJKCPlMQc95mxdviXmRnbLS7JjLdXlLDjXegY4UHF3+YqFtTF6YfZ5DOEGNZC5M3XGjh1DY6u1jeQlkU/G+YOooQdvuyZ1Xm52S1dGjh81xcpcrHmB2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxx0I5CV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RK72PhBQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.444626478@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=axrrptkM5cruK2olPk9Gk1fVUzCj5KYtyRuWYLFYvKQ=;
	b=mxx0I5CVfeoVVNk9fVWTtn4P3rh9PgOkLRKcy+7vlXPqs27TvzI2gO8me9rk42I6mLdtFm
	8Cwxtw/AOCs/hFR8JS1z1ilJdtQHNxFRekZi6dt1gWXRK7B7CZV8PE+QYWfdZ83fSTi6Il
	iTQx1KTjFdW9yDWoxYnwFla2RwVgIpskQU3VAIvcpZMU3fdsQ01Og7eLzfQNi7fjCtAzpQ
	WiFLaUCF8XrM72y90v7hSwtTT28GADH8FIWXGBmGY9Koa5Vn0qjfrIq4lA/NiheLGN3c0q
	Xlz/bUyZgCwb8xtuonJJ59uzcNZxSDuiVUUQDjsGvnLUQEUUqghouSLcR4F+1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=axrrptkM5cruK2olPk9Gk1fVUzCj5KYtyRuWYLFYvKQ=;
	b=RK72PhBQNXBtURVlOhWZ2ndQ+Hbg/Bi5BAtTuYLbud3nZvU1PrXx/ejYR6LQXLNzkDSwdz
	mw/QRAqCxx9zyqDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
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
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V3 11/11] timekeeping: Provide interface to control auxiliary
 clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:49 +0200 (CEST)

Auxiliary clocks are disabled by default and attempts to access them
fail.

Provide an interface to enable/disable them at run-time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Use kobject.h, clockid_t and cleanup the sysfs init - Thomas W.
    Use aux_tkd, aux_tks for clarity - John
---
 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |    5 
 kernel/time/timekeeping.c                             |  116 ++++++++++++++++++
 2 files changed, 121 insertions(+)

--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
@@ -0,0 +1,5 @@
+What:		/sys/kernel/time/aux_clocks/<ID>/enable
+Date:		May 2025
+Contact:	Thomas Gleixner <tglx@linutronix.de>
+Description:
+		Controls the enablement of auxiliary clock timekeepers.
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -6,6 +6,7 @@
 #include <linux/timekeeper_internal.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -2903,6 +2904,121 @@ const struct k_clock clock_aux = {
 	.clock_adj		= aux_clock_adj,
 };
 
+static void aux_clock_enable(clockid_t id)
+{
+	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct timekeeper *aux_tks = &aux_tkd->shadow_timekeeper;
+
+	/* Prevent the core timekeeper from changing. */
+	guard(raw_spinlock_irq)(&tk_core.lock);
+
+	/*
+	 * Setup the auxiliary clock assuming that the raw core timekeeper
+	 * clock frequency conversion is close enough. Userspace has to
+	 * adjust for the deviation via clock_adjtime(2).
+	 */
+	guard(raw_spinlock_nested)(&aux_tkd->lock);
+
+	/* Remove leftovers of a previous registration */
+	memset(aux_tks, 0, sizeof(*aux_tks));
+	/* Restore the timekeeper id */
+	aux_tks->id = aux_tkd->timekeeper.id;
+	/* Setup the timekeeper based on the current system clocksource */
+	tk_setup_internals(aux_tks, tkr_raw->clock);
+
+	/* Mark it valid and set it live */
+	aux_tks->clock_valid = true;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static void aux_clock_disable(clockid_t id)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+
+	guard(raw_spinlock_irq)(&aux_tkd->lock);
+	aux_tkd->shadow_timekeeper.clock_valid = false;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static DEFINE_MUTEX(aux_clock_mutex);
+
+static ssize_t aux_clock_enable_store(struct kobject *kobj, struct kobj_attribute *attr,
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
+	guard(mutex)(&aux_clock_mutex);
+	if (enable == test_bit(id, &aux_timekeepers))
+		return count;
+
+	if (enable) {
+		aux_clock_enable(CLOCK_AUX + id);
+		set_bit(id, &aux_timekeepers);
+	} else {
+		aux_clock_disable(CLOCK_AUX + id);
+		clear_bit(id, &aux_timekeepers);
+	}
+	return count;
+}
+
+static ssize_t aux_clock_enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+
+	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
+}
+
+static struct kobj_attribute aux_clock_enable_attr = __ATTR_RW(aux_clock_enable);
+
+static struct attribute *aux_clock_enable_attrs[] = {
+	&aux_clock_enable_attr.attr,
+	NULL
+};
+
+static const struct attribute_group aux_clock_enable_attr_group = {
+	.attrs = aux_clock_enable_attrs,
+};
+
+static int __init tk_aux_sysfs_init(void)
+{
+	struct kobject *auxo, *tko = kobject_create_and_add("time", kernel_kobj);
+
+	if (!tko)
+		return -ENOMEM;
+
+	auxo = kobject_create_and_add("aux_clocks", tko);
+	if (!auxo) {
+		kobject_put(tko);
+		return -ENOMEM;
+	}
+
+	for (int i = 0; i <= MAX_AUX_CLOCKS; i++) {
+		char id[2] = { [0] = '0' + i, };
+		struct kobject *clk = kobject_create_and_add(id, auxo);
+
+		if (!clk)
+			return -ENOMEM;
+
+		int ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+late_initcall(tk_aux_sysfs_init);
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)


