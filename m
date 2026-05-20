Return-Path: <netdev+bounces-290107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NXDCOMiDmr26QUAu9opvQ
	(envelope-from <netdev+bounces-290107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:08:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 952D459A7DB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5F8301C6F0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4B37AA77;
	Wed, 20 May 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqdqhYBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF04374721;
	Wed, 20 May 2026 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311327; cv=none; b=rjmmvVPaFTl7Yc3/eRlSrUwLFqVEztEMGu2+BsyVud17gK0nmCNiVuiXkM5fJr3YylqIxk3qeTSvSCDruQZoD76vr+QEUpxwQ/ehgzbMi4j5MYyZoNQjrjvZi4yKmXtUAQyQjpKjYZ0nKZJNgiOacxQA5wUKOO6jRZe6VWD3EKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311327; c=relaxed/simple;
	bh=Ipv9L2oY2ZKvCKuBrESr6hIXmrYLVtmJWQQqoo5YJJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqlqKOYXQ6gTRQc1R70XixO9sXYTksP4m0JAUGtDrjb5EfObdAArbeEOxkO72/XPW5nX+0NRBLCOa9uz7eiVZBejah1cBNKgkmqKGl3WAwxjx6C8C4gJ870Hsk5PwHfn95SZnXBqQr1oNE1EKcAVzgVWD6RuZLBec0t6jVHhDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqdqhYBQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6486A1F00A39;
	Wed, 20 May 2026 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779311326;
	bh=oLNLi08itDX7jR+qOyWa8710Li0EKz+b0ONR4MNoKgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RqdqhYBQ56nQHSQTqimZ8o0JAqysXNys3c28ivdp3OIccaktMzHeSr1/j/JQo7k2b
	 Bf3JxK9NhGDMrxsyUJ2msHy4dLs2rT2zJoAiX/YjlLwjuCE8JlosXdJpgv/bMx3nPt
	 FLvhWjUdpxgiIxdZeLRE68NqQUA3chSj1+IJ4ZfF69iOifUDl8AGJ8mJrWAKfRtHwi
	 24aoLxD7S7+4UyhVCwxYVeIWPybTf5iVi4r8mzJKGIKAVC+ElejQR7EnzOGbuBn5D6
	 bvgG25SJAuIREqzDKZcgBghHEsnzS7lQbbjiQG1ajfjEHdP9PIggTdlpTveREhITJi
	 0kagzgvW07pqQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, jstultz@google.com,
 sboyd@kernel.org, willemb@google.com, nktgrg@google.com,
 jfraker@google.com, ziweixiao@google.com, maolson@google.com,
 jordanrhee@google.com, thostet@google.com, alok.a.tiwari@oracle.com,
 pkaligineedi@google.com, horms@kernel.org, dwmw2@infradead.org,
 jacob.e.keller@intel.com, yyd@google.com, jefrogers@google.com,
 linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
In-Reply-To: <20260514225842.110706-4-hramamurthy@google.com>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
Date: Wed, 20 May 2026 23:08:42 +0200
Message-ID: <87mrxtwzz9.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-290107-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 952D459A7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14 2026 at 22:58, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
>
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
>
> Two paths are implemented: a precise path using system counter values
> sampled by the device, and a fallback path using system counter values
> sampled in the driver using ptp_read_system_prets()/postts().
>
> To use the precise path, the current system clocksource must match the
> units returned by the device, which on x86 is X86_TSC and on ARM64 is
> ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
> by default on GCP VMs using Chrony, so we expect the precise path to be
> used the vast majority of the time. If the system clocksource is changed
> to kvm-clock, it activates the fallback path. Ethtool counters have been
> added to count how many times each path is used.
>
> The uncertainty window in the precise path is typically around 1-2us,
> while in the fallback path is around 60-80us.
>
> Stub implementions of adjfine and adjtime are added to avoid NULL
> dereference when phc2sys tries to adjust the clock.

Sorry that I did not react to this earlier, but I was burried in
regressions and allowed myself to take a few days off.

> +/*
> + * Read NIC clock by issuing the AQ command. The command is subject to
> + * rate limiting and may need to be retried. Requires nic_ts_read_lock
> + * to be held.
> + */
> +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cycles,
> +				  cycles_t *post_cycles)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(100);
> +	unsigned long delay_us = 1000;
> +	int err;
> +
> +	lockdep_assert_held(&ptp->nic_ts_read_lock);
> +
> +	do {
> +		*pre_cycles = get_cycles();

This is a completely non-sensical hack. Why do you need get_cycles()
here, which is a horrible and ill-defined interface that others are
trying to get rid of?

Just because it's still there is not a good answer and it's actually not
required at all. See below.

> +		err = gve_adminq_report_nic_ts(ptp->priv,
> +					       ptp->nic_ts_report_bus);
> +
> +		/* Prevent get_cycles() from being speculatively executed
> +		 * before the AdminQ command
> +		 */
> +		rmb();
> +		*post_cycles = get_cycles();
> +		if (likely(err != -EAGAIN))
> +			return err;
> +
> +		fsleep(delay_us);
> +
> +		/* Exponential backoff */
> +		delay_us *= 2;
> +	} while (time_before(jiffies, deadline));
> +
> +	return -ETIMEDOUT;
> +}
> +
>  /* Read the nic timestamp from hardware via the admin queue. */
> -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> +				 struct gve_sysclock_sample *sysclock)
>  {
> +	cycles_t host_pre_cycles, host_post_cycles;
> +	struct gve_nic_ts_report *ts_report;
>  	int err;
>  
>  	mutex_lock(&ptp->nic_ts_read_lock);

Why is this lock taken _after_ the regular (fallback) pre/post
timestamps are aquired?

What's wrong with doing:

       do {
         	guard(mutex)(&ptp->nic_ts_read_lock);

                ptp_read_system_prets(sts);
                err = read_nic_timestamp(...);
                ptp_read_system_postts(sts);
       } while (err && !timeout(...));

       return err;

which moves the "fallback" timestamp right next to the actual hardware
readout?

That would make the "fallback" case too precise, right?

After noticing the obvious, I just checked what our new AI review
overlord "sashiko" has to say about this:

     "Does wrapping the timestamp read outside the locks and retry loops skew the
      measurements?

      In the fallback path, ptp_read_system_prets() is captured before calling
      gve_clock_nic_ts_read(), and postts() is captured after it returns. However,
      gve_clock_nic_ts_read() acquires ptp->nic_ts_read_lock and calls
      gve_ptp_read_timestamp(), which can sleep using fsleep() during retries. This
      means the prets/postts window could include mutex wait times and sleep
      durations."

It _IS_ actually on spot. So why the heck did this garbage get merged
without addressing this obvious fail?

What "sashiko" actually saw aside of that, which I didn't see myself when
looking at this, is:

   "Similarly, in gve_ptp_read_timestamp(), the get_cycles() bounds are taken
    outside the gve_adminq_report_nic_ts() call, which acquires the shared
    priv->adminq_lock. If there is lock contention, the cycle bounds could become
    extremely wide."

Oh well.

So what you really want is:

       do {
         	guard(mutex)(&ptp->nic_ts_read_lock);
         	guard(mutex)(&gpe_priv->adminq_lock);

                ptp_read_system_prets(sts);
                err = read_nic_timestamp(...) {
                   	...
                   	return gve_adminq_execute_cmd_locked(....);
                      }
                ptp_read_system_postts(sts);
       } while (err && !timeout(...));

       return err;

Or just rely on gpe_priv->adminq_lock in the first place. No?

But what's worse and escaped the AI scrutiny is:

  Your attempt to convert these 'get_cycles()' time stamps after the
  fact and outside of the timekeeping core protection is fundamentally
  wrong.

get_device_system_crosststamp() does

      do {
      		seq = read_seqcount_begin(&tk_core.seq);
                take_timestamps(...);
                convert_timestamps(...)
      } while (read_seqcount_retry(&tk_core.seq, seq));

which covers the whole sequence of taking the snapshots from the
hardware and the conversion.

Your abuse of this is completely out of spec. Just because it did not
blow up in your face yet does not make it in any way correct. You do not
even get bonus points for creative abuse.


Now let me look at the "firmware" provided timestamps.

That's the poor mans emulation of actual hardware timestamps aka PTM.

Why do you need all this pre_nic/post_nic muck there? Fix your firmware
to actually honor PTM and not provide some made up version of it.

Also the whole debug mechanism of comparing the time stamps of
get_cycles() with the timestamps provided by firmware tells me that your
firmware is a hacked together piece of garbage.

If you want to use "hardware" timestamps then populate the
ptp.info.getcrosststamp() callback.

If your firmware really can't do PTM and only provides pre and post
values, then you simply can take the midpoint in your getcrosststamp()
callback:

      do {
         	guard(mutex)(&ptp->nic_ts_read_lock);
                err = read_nic_timestamp(...);
                system_counterval->cycles = (nic_pre + nic_post) / 2;
      } while (err && !timeout(...));

If you do not even trust your firmware then you still can validate it
easily without creating horrible hacks:

      do {
         	guard(mutex)(...);

                ptp_read_system_prets(&ctx->sts);
                err = read_nic_timestamp(...);
                system_counterval->cycles = (nic_pre + nic_post) / 2;
                ptp_read_system_postts(&ctx->sts);
      } while (err && !timeout(...));

and then check the ctx->sts timestamps against the results provided by
get_device_system_crosststamp() after conversion in your
ptp.info.getcrosststamp() callback:

        err = get_device_system_crosststamp(..., &ctx);
        if (err)
           return err;
        if (ctx.sts.pre_ts > xtstamp.sys... || ctx.sts.post_ts < xtstamp.sys...)
           return -EBROKENFIRMWARE;        

no?

Jakub, please back out this hackery before it makes a precedence for others
to copy from.

Thanks,

        tglx

