Return-Path: <netdev+bounces-197356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F911AD83F3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B224D3A6124
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64D2C2ACE;
	Fri, 13 Jun 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRur5C/X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r91IW4PC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C692C1780;
	Fri, 13 Jun 2025 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799103; cv=none; b=YcSLp/b8IpHomyr9JyDn+JdURZ5FeOiDFkjq3kWMJKJYNGFc/rE68DvW8idHGbRviqVaqmZgbEAbkU3LK0cI5N1WraJEqmP7Yn7RtHmIMFdsfJoyy3JY6ulYaOK7s2erbPjVBfxOFqOclDUpVkwwvgUdZYfQpCvXnBoMO+AB44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799103; c=relaxed/simple;
	bh=b1TH0pBAHA4l6ksFhPq0KMWofIveyzTRlJwcCJOHSgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAHi1ZIqHyUxoiLjhn+ZrZK/KRcytvsP9PRbP2OI6Z81SDjrxjWVXXtiiX0/ehr2uRAI1uPI7Ve/H+kzIC2kXGicuN2RoI+CNbCyAOrHNnem3xJnYti0r9ZfmWb61IYNI4/tAfHm8ZUT8MNXmECQX5/NmzXomWortijev0XgI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cRur5C/X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r91IW4PC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 09:18:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749799100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01/G+GPT96bJOUWgFH1yRp4RIEAyJuEv6ZoK2XgM5wY=;
	b=cRur5C/XrKB9u9N1MRoo0uxF4WypLzGNE8OEdpE4jSqQkhpqw7t35gb1uJqmjgdqPPey26
	2zeqMAnqUx5HP5ZYwTglm0ZN7Dukv2UQPYkVp+IR9A28gU7g9808eqWlB/JF3Q31Y6D8lt
	mIdyd4NMXzheXj05sKvRS5zA5bOyTnjlgGP0attu1OW9kv6m+24ESbz+tS1sNy4jUJL1X9
	IoMa42qg4gdONcdizBKQNYsZ/7xgHNWPY8pDD/SFA5IAUmLzjZje11HAzE1UK5HQAPqAWV
	dbV4Nz8RJAal6EFQPzOMKnENXJqltyg6m6LeLEIyKzTbayMryat05hU+5GbJlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749799100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01/G+GPT96bJOUWgFH1yRp4RIEAyJuEv6ZoK2XgM5wY=;
	b=r91IW4PCDs6KEdmf0Hk9AZ21bRcxqwcaIX5SBpsGtGVjlON+YrJIyzV7OdLWM8G0VAlPlG
	H73NrPKtEMP7TRDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, 
	Stephen Boyd <sboyd@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [patch V2 26/26] timekeeping: Provide interface to control
 auxiliary clocks
Message-ID: <20250613083529-510f21e5-1c61-4320-afb0-863666b0f590@linutronix.de>
References: <20250519082042.742926976@linutronix.de>
 <20250519083027.209080298@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519083027.209080298@linutronix.de>

On Mon, May 19, 2025 at 10:33:46AM +0200, Thomas Gleixner wrote:
> Auxiliary clocks are disabled by default and attempts to access them
> fail.
> 
> Provide an interface to enable/disable them at run-time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |    5 
>  kernel/time/timekeeping.c                             |  125 ++++++++++++++++++
>  2 files changed, 130 insertions(+)

<snip>

> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/loadavg.h>
>  #include <linux/sched/clock.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/sysfs.h>

#include <linux/kobject.h>

>  #include <linux/clocksource.h>
>  #include <linux/jiffies.h>
>  #include <linux/time.h>
> @@ -2900,6 +2901,130 @@ const struct k_clock clock_aux = {
>  	.clock_adj		= aux_clock_adj,
>  };
>  
> +static void aux_clock_enable(unsigned int id)

"clockid_t id".

> +{
> +	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
> +	struct tk_data *tkd = aux_get_tk_data(id);
> +	struct timekeeper *tks = &tkd->shadow_timekeeper;
> +
> +	/* Prevent the core timekeeper from changing. */
> +	guard(raw_spinlock_irq)(&tk_core.lock);
> +
> +	/*
> +	 * Setup the auxiliary clock assuming that the raw core timekeeper
> +	 * clock frequency conversion is close enough. Userspace has to
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

<snip>

> +static struct kobj_attribute aux_clock_enable_attr = __ATTR_RW(aux_clock_enable);
> +
> +static struct attribute *aux_clock_enable_attrs[] = {
> +	&aux_clock_enable_attr.attr,
> +	NULL,

There should be no comma after sentinel values.

> +};
> +
> +static const struct attribute_group aux_clock_enable_attr_group = {
> +	.attrs = aux_clock_enable_attrs,
> +};
> +
> +static int __init tk_aux_sysfs_init(void)
> +{
> +	struct kobject *auxo, *tko = kobject_create_and_add("time", kernel_kobj);
> +
> +	if (!tko) {
> +		pr_warn("Unable to create /sys/kernel/time/. POSIX AUX clocks disabled.\n");

The other timer code does not log details on failed initcalls.
To me the strings look like wasted memory.
If failure is really intended to be handled gracefully then some cleanup logic
may be necessary, too.

> +		return -ENOMEM;
> +	}
> +
> +	auxo = kobject_create_and_add("aux_clocks", tko);
> +	if (!auxo) {
> +		pr_warn("Unable to create /sys/kernel/time/aux_clocks. POSIX AUX clocks disabled.\n");
> +		kobject_put(tko);
> +		return -ENOMEM;
> +	}
> +
> +	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++) {

for (int i = 0; i < MAX_AUX_CLOCKS; i++)

This avoids the need for the repeated calculations below and also better
matches the actual semantics.

> +		char id[2] = { [0] = '0' + (i - TIMEKEEPER_AUX), };
> +		struct kobject *clk = kobject_create_and_add(id, auxo);
> +
> +		if (!clk) {
> +			pr_warn("Unable to create /sys/kernel/time/aux_clocks/%d\n",
> +				i - TIMEKEEPER_AUX);
> +			return -ENOMEM;
> +		}
> +
> +		int ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
> +
> +		if (ret) {
> +			pr_warn("Unable to create /sys/kernel/time/aux_clocks/%d/enable\n",
> +				i - TIMEKEEPER_AUX);


> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +late_initcall(tk_aux_sysfs_init);
> +
>  static __init void tk_aux_setup(void)
>  {
>  	For (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)
> 

