Return-Path: <netdev+bounces-190342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3AAB654D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C151B61196
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D9F21ABC5;
	Wed, 14 May 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC91pTGh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD221FF35;
	Wed, 14 May 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210035; cv=none; b=thWBTlRw2HxWY1RIEB2f4kbuNo35pLpToNsreixUa4mIvpRT8/RhoIG3dsitMz5xtirb1EPisrXPiMLLeBzvpFY/WjCjuPQmM6iRlKS6EhhrGJrYsO2IgbPlFWGHupEs4+gSjz/LKSctbN/mq156FuwFNzvPswk4V7Sr+SCLPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210035; c=relaxed/simple;
	bh=fOEZFM2FyPnab4TgEDY8lrYsnLTj0SuNcr34p3JVdik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjzoCwK2PIzfUTRmC4ilvFkunkv6awSsnLctO3IGt8P4oyHG2J+0eOA4UAc+U2Dgg7qpEgDHTPrihlcyEXziqpDnLTAPmghqqRYa/5tAuSIgHFnavHJr6EFz7D/FGoKbK8AbDavSD5e7dGfcqYLSzsQdqsdW7YEikpphV6A3HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC91pTGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4190FC4CEF2;
	Wed, 14 May 2025 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747210034;
	bh=fOEZFM2FyPnab4TgEDY8lrYsnLTj0SuNcr34p3JVdik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kC91pTGhB2njr5VNoOkir8Gc5DhgyU3qcb00RmqUp17fIvZUAQuXZpVZUJLrJmMwV
	 Asr0jn30tAYTcuDhrggfk4PRBAtPo1DI/qECLY0gbi68TBFlpJYl9Uv7JgVhKcbxx4
	 MrWIsN+bXx4dNFVCBTB22t5aHciF4JGPm4GpMwgR1NUsPwK+wInYII2EPmcu7jNckj
	 g2TZTTpZW3zcvXDC0/EaQLagFzA5Wj4RzaFij96/e8Vk1u3bg1nHnP9u7XGLpjPDEL
	 M8Is7OMW80/rv9oH2ijItbxvo2cvnRa4AsKfE8Rt9WBioR9XkbOLHLxngJUfqamQL0
	 Zj8bVbw/bVVvA==
Date: Wed, 14 May 2025 10:07:11 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	David Zage <david.zage@intel.com>, John Stultz <jstultz@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Alex Gieringer <gieri@linutronix.de>
Subject: Re: [patch 26/26] timekeeping: Provide interface to control
 independent PTP clocks
Message-ID: <htnwor46q3435pddkafm7flmx4m2bs4553gq3mx4jzevtfgg2l@h4abniqo4dzf>
References: <20250513144615.252881431@linutronix.de>
 <20250513145138.212062332@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513145138.212062332@linutronix.de>

On Tue, May 13, 2025 at 05:13:44PM +0200, Thomas Gleixner wrote:
> Independent PTP clocks are disabled by default and attempts to access them
> fail.
> 
> Provide an interface to enable/disable them at run-time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/ABI/stable/sysfs-kernel-time-ptp |    6 +
>  kernel/time/timekeeping.c                      |  125 +++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
> 
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-kernel-time-ptp
> @@ -0,0 +1,6 @@
> +What:		/sys/kernel/time/ptp/<ID>/enable

The path added below is /sys/kernel/time/ptp_clocks/<ID>/enable.

> +Date:		May 2025
> +Contact:	Thomas Gleixner <tglx@linutronix.de>
> +Description:
> +		Controls the enablement of independent PTP clock
> +		timekeepers.
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/loadavg.h>
>  #include <linux/sched/clock.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/sysfs.h>
>  #include <linux/clocksource.h>
>  #include <linux/jiffies.h>
>  #include <linux/time.h>
> @@ -2900,6 +2901,130 @@ const struct k_clock clock_ptp = {
>  	.clock_adj		= ptp_clock_adj,
>  };
>  
> +static void ptp_clock_enable(unsigned int id)
> +{
> +	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
> +	struct tk_data *tkd = ptp_get_tk_data(id);
> +	struct timekeeper *tks = &tkd->shadow_timekeeper;
> +
> +	/* Prevent the core timekeeper from changing. */
> +	guard(raw_spinlock_irq)(&tk_core.lock);
> +
> +	/*
> +	 * Setup the PTP clock assuming that the raw core timekeeper clock
> +	 * frequency conversion is close enough. PTP userspace has to
> +	 * adjust for the deviation via clock_adjtime(2).
> +	 */
> +	guard(raw_spinlock_nested)(&tkd->lock);
> +
> +	/* Remove leftovers of a previous registration */
> +	memset(tks, 0, sizeof(*tks));
> +	/* Restore the timekeeper id */
> +	tks->id = tkd->timekeeper.id;
> +	/* Setup the timekeeper based on the current system clocksource */
> +	tk_setup_internals(tks, tkr_raw->clock);
> +
> +	/* Mark it valid and set it live */
> +	tks->clock_valid = true;
> +	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
> +}
> +
> +static void ptp_clock_disable(unsigned int id)
> +{
> +	struct tk_data *tkd = ptp_get_tk_data(id);
> +
> +	guard(raw_spinlock_irq)(&tkd->lock);
> +	tkd->shadow_timekeeper.clock_valid = false;
> +	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
> +}
> +
> +static DEFINE_MUTEX(ptp_clock_mutex);
> +
> +static ssize_t ptp_clock_enable_store(struct kobject *kobj, struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	/* Lazy atoi() as name is "0..7" */
> +	int id = kobj->name[0] & 0x7;
> +	bool enable;
> +
> +	if (!capable(CAP_SYS_TIME))
> +		return -EPERM;
> +
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	guard(mutex)(&ptp_clock_mutex);
> +	if (enable == test_bit(id, &ptp_timekeepers))
> +		return count;
> +
> +	if (enable) {
> +		ptp_clock_enable(CLOCK_PTP + id);
> +		set_bit(id, &ptp_timekeepers);
> +	} else {
> +		ptp_clock_disable(CLOCK_PTP + id);
> +		clear_bit(id, &ptp_timekeepers);
> +	}
> +	return count;
> +}
> +
> +static ssize_t ptp_clock_enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	unsigned long active = READ_ONCE(ptp_timekeepers);
> +	/* Lazy atoi() as name is "0..7" */
> +	int id = kobj->name[0] & 0x7;
> +
> +	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
> +}
> +
> +static struct kobj_attribute ptp_clock_enable_attr = __ATTR_RW(ptp_clock_enable);
> +
> +static struct attribute *ptp_clock_enable_attrs[] = {
> +	&ptp_clock_enable_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ptp_clock_enable_attr_group = {
> +	.attrs = ptp_clock_enable_attrs,
> +};
> +
> +static int __init tk_ptp_sysfs_init(void)
> +{
> +	struct kobject *ptpo, *tko = kobject_create_and_add("time", kernel_kobj);
> +
> +	if (!tko) {
> +		pr_warn("Unable to create /sys/kernel/time/. POSIX PTP clocks disabled.\n");
> +		return -ENOMEM;
> +	}
> +
> +	ptpo = kobject_create_and_add("ptp_clocks", tko);
> +	if (!ptpo) {
> +		pr_warn("Unable to create /sys/kernel/time/ptp_clocks. POSIX PTP clocks disabled.\n");
> +		kobject_put(tko);
> +		return -ENOMEM;
> +	}
> +
> +	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++) {
> +		char id[2] = { [0] = '0' + (i - TIMEKEEPER_PTP), };
> +		struct kobject *clk = kobject_create_and_add(id, ptpo);
> +
> +		if (!clk) {
> +			pr_warn("Unable to create /sys/kernel/time/ptp_clocks/%d\n",
> +				i - TIMEKEEPER_PTP);
> +			return -ENOMEM;
> +		}
> +
> +		int ret = sysfs_create_group(clk, &ptp_clock_enable_attr_group);
> +
> +		if (ret) {
> +			pr_warn("Unable to create /sys/kernel/time/ptp_clocks/%d/enable\n",
> +				i - TIMEKEEPER_PTP);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +late_initcall(tk_ptp_sysfs_init);
> +
>  static __init void tk_ptp_setup(void)
>  {
>  	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)
> 
> 

