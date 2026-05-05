Return-Path: <netdev+bounces-284251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIX5ELKl+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:09:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CB4C8746
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57420301C3F3
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB153E9582;
	Tue,  5 May 2026 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNwhsqDz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5TVJJG0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CA3E929B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968515; cv=none; b=n+klA+Bi6vE01loIhqI9xMccWXIfOvCDA+EoT0aaClGJzC9VivmJlq60TEd01OQOXKOewZ0DRdn1e9doNmqugZAtD1oLwdeDD/1QlKcWNOHs3+yDBvFPWQMr8RVdo4rZaWDsG+PfQoQl0b1jkQU3ip+oMZ8CaK1UfnaFWKCkD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968515; c=relaxed/simple;
	bh=+M41ukbFxlWMNF0/F2vKnDTIgT3DYcuX0YMl/RC7VLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vplou4JAfrg7sYMx7lydusWwXN3qCMfT7ZPkCLw1Bo+d+fy6PdVXnTEayuwFuhyRJzUQNc/qwJN4NqHrVVrfz9lVqOsweVwnh9RD0W7sndMe1QM14QWLmD+VDHiaJcGwTnff+VoFsZjX4BAnzPe+vNdgdlcRqzjvaqJSoIG/pBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNwhsqDz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5TVJJG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777968512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpUdZfp1VEBYtg0oqeNGg7ARY/QUQgpr9RpkldFSMkM=;
	b=HNwhsqDzLj3n6cwIN4wkmxLrW3cs/hFGDQmhtvOaIwOLiiK9pVx1cecMATOuk5oAbl/AU2
	kE3jgtSIwsACtNaWSxmAE6lTgM6oxZVuaenY3Q9kEBa+4vLHQZvTq0A472WfFemaLti+Sa
	tESIiwTzS86CxEwf4YIqKP6lgaAnXv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-cpBtHnuROSe5y4sgIRkd2Q-1; Tue, 05 May 2026 04:08:31 -0400
X-MC-Unique: cpBtHnuROSe5y4sgIRkd2Q-1
X-Mimecast-MFC-AGG-ID: cpBtHnuROSe5y4sgIRkd2Q_1777968510
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so51167455e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777968510; x=1778573310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpUdZfp1VEBYtg0oqeNGg7ARY/QUQgpr9RpkldFSMkM=;
        b=K5TVJJG08wt5/854P2eZ0yjr/nfHcB3GwvyOVCiBrm5cQA/9v3+mbpBNrc+7vhLkxf
         RcxjZS6D2H7qujO0v3sgf3rppo7p+7wRA2cCJaFjbmgNoKHdkenPltbw31I5FV4KIefu
         xMwuXncA1IB1jLyFnGYqqxDEYnmDG4tyMxo54lJx3a6CC6uZQs3EKB/U8HhzlQN3TY0/
         H6t+sH0yHH+359Y+2QYCJN6R6Oe8rxatL8/Bm85ZH3MGr4T4yV1Uu8Vxa2usLnleKSqK
         Rtd/qXrRR3v9MGvOc4fYewhTJ3ZipKrOtQKfkCXY2+R7akHKslnBvZN+k1L+RW7BN71I
         RglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968510; x=1778573310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpUdZfp1VEBYtg0oqeNGg7ARY/QUQgpr9RpkldFSMkM=;
        b=rtojZEZ2J+Xa9yaJ6AoHID7B4G/36xsNwbFxUHbTRrj2+rgGgo8GKyHSu0lLQie7ey
         srmoU0iPT6KShbyi4WBvMo8mbMZ7BuD8acC3s0GxiYakqHdFawTSDOJg3ug0qZ0WjOAI
         2+HU6RxHJGgImRdPyQzQmRqiJCHVuu+tEraiLG5Xfp48JTDM+Q2egVPPsqnPAA1Q09K0
         9yqZ+M2aKz7C6+xUFmiUZ2N9ClEzztvekpYxrzj2I+C//DR5vERIdotoFolrp3i8iYBR
         8fuCFxvozJy2oFukhA3/jmOVLdmQBB7CTeyJJqKWRU3eeWRaw/ZJirM1PJWI3veOHJ90
         FMuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XRIHwhfplXWpX6+SXx5koSutCpiL3SwehEoplHHh6WAjQJXwBM0IsoPepgVcLIjvDzl5TGko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0TckheuyE9ikzq0g7KfOjJdEFjRbBSNQMgTysC8RJstPPE83
	D3wUYjMDadMRl22sP7yCwrgExpCnlMcwwDTpIOcQfBro9br30aTF7FRQ6Z79Z3udrfIsdshIizU
	50pyw+KWosP7Ovkey+sQPOB9gK5Rz9J65/7SAjgotTfU1OXqre3TD2Vo3rA==
X-Gm-Gg: AeBDievEBT+zb/x+cJv/rAQMCKXvG2kqHVQgeVeeJoylTzrlcTjq9Kg43dtsbIw1uUC
	dp7ZqZKpObyULyIJcpMR9ToapOIHP5o4DbT4nPYhJCzOw29q/R3sIqvIXYspy2Is1Wy2kzb3kBX
	ZG2k84XmE9vTcJrnKA/irK/oP4zBarVEE4FZK2T+nE0xXCeMS4wT2F15ReW8mrw6KUs4hkt6oQ+
	RBKyHsW8LPQGSxh+Pcksxj+MX9ftVRd3m0g0/rjDy7w6et8yKmj+Ao3rpHJieBJ1Ju5cD9ZKlhw
	CN7V2kN194L1Fr7UvhC3yrkvB8R+Iu2qegeR7KbRtusiuWo5We0Z7+qnZO/yIZv9IJaR9RHY+P7
	UyCYXhpnp8v7/HqxEtN7bOGObHajlwAfD7xM69/Q1LsnUeAmIDdjwyL066HVb3CxlJ1E=
X-Received: by 2002:a05:600c:444c:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48a9866aa1amr221239505e9.21.1777968509796;
        Tue, 05 May 2026 01:08:29 -0700 (PDT)
X-Received: by 2002:a05:600c:444c:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48a9866aa1amr221238575e9.21.1777968509228;
        Tue, 05 May 2026 01:08:29 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm333699925e9.5.2026.05.05.01.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:08:28 -0700 (PDT)
Message-ID: <6259cf59-b054-42bb-9dad-5f62a54a2bc0@redhat.com>
Date: Tue, 5 May 2026 10:08:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] gve: implement PTP gettimex64
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 jstultz@google.com, tglx@kernel.org, sboyd@kernel.org, willemb@google.com,
 nktgrg@google.com, jfraker@google.com, ziweixiao@google.com,
 maolson@google.com, jordanrhee@google.com, thostet@google.com,
 alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org,
 dwmw2@infradead.org, jacob.e.keller@intel.com, yyd@google.com,
 linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
References: <20260429012819.3102675-1-hramamurthy@google.com>
 <20260429012819.3102675-4-hramamurthy@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260429012819.3102675-4-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 936CB4C8746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284251-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/29/26 3:28 AM, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
> 
> The system cycle counters are sampled by the device to minimize the
> uncertainty window. If the system times are sampled in the host, the
> delta between pre and post readings is 100us or more due to AQ command
> latency. The system times returned by the device have a delta of ~1us,
> which enables significantly more accurate clock synchronization.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v5:
> - Reformulate retry loop in terms of total timeout (Jakub Kicinski)
> 
> Changes in v3:
> - Take system time snapshot inside the mutex
> - Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
>   than x86 or arm64
> 
> Changes in v2:
>  - fix compilation warning on ARM by casting cycles_t to u64
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
>  drivers/net/ethernet/google/gve/gve_ptp.c    | 196 ++++++++++++++++++-
>  2 files changed, 191 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index 22a74b6aa17e..e6dcf6da9091 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic_ts) == 16);
>  
>  struct gve_nic_ts_report {
>  	__be64 nic_timestamp; /* NIC clock in nanoseconds */
> -	__be64 reserved1;
> -	__be64 reserved2;
> +	__be64 pre_cycles; /* System cycle counter before NIC clock read */
> +	__be64 post_cycles; /* System cycle counter after NIC clock read */
>  	__be64 reserved3;
>  	__be64 reserved4;
>  };
> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
> index ad15f1209a83..c6c98ef825aa 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> @@ -10,28 +10,210 @@
>  /* Interval to schedule a nic timestamp calibration, 250ms. */
>  #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
>  
> +/*
> + * Stores cycle counter samples in get_cycles() units from a
> + * sandwiched NIC clock read
> + */
> +struct gve_sysclock_sample {
> +	/* system time snapshot taken just before issuing AdminQ command */
> +	struct system_time_snapshot snapshot;
> +	/* Cycle counter from NIC before clock read */
> +	u64 nic_pre_cycles;
> +	/* Cycle counter from NIC after clock read */
> +	u64 nic_post_cycles;
> +	/* Cycle counter from host before issuing AQ command */
> +	cycles_t host_pre_cycles;
> +	/* Cycle counter from host after AQ command returns */
> +	cycles_t host_post_cycles;
> +};
> +
> +/*
> + * Read NIC clock by issuing the AQ command. The command is subject to
> + * rate limiting and may need to be retried. Requires nic_ts_read_lock
> + * to be held.
> + */
> +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cycles,
> +				  cycles_t *post_cycles,
> +				  struct system_time_snapshot *snap)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(100);
> +	unsigned long delay_us = 1000;
> +	int err;
> +
> +	lockdep_assert_held(&ptp->nic_ts_read_lock);
> +
> +	do {
> +		if (snap)
> +			ktime_get_snapshot(snap);
> +
> +		*pre_cycles = get_cycles();
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
> -	err = gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bus);
> -	if (err)
> +	err = gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_cycles,
> +				     sysclock ? &sysclock->snapshot : NULL);
> +	if (err) {
> +		dev_err_ratelimited(&ptp->priv->pdev->dev,
> +				    "AdminQ timestamp read failed: %d\n", err);
>  		goto out;
> +	}
>  
> -	*nic_raw = be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
> +	ts_report = ptp->nic_ts_report;
> +	*nic_raw = be64_to_cpu(ts_report->nic_timestamp);
> +
> +	if (sysclock) {
> +		sysclock->nic_pre_cycles = be64_to_cpu(ts_report->pre_cycles);
> +		sysclock->nic_post_cycles = be64_to_cpu(ts_report->post_cycles);
> +		sysclock->host_pre_cycles = host_pre_cycles;
> +		sysclock->host_post_cycles = host_post_cycles;
> +	}
>  
>  out:
>  	mutex_unlock(&ptp->nic_ts_read_lock);
>  	return err;
>  }
>  
> +struct gve_cycles_to_clock_callback_ctx {
> +	u64 cycles;
> +};
> +
> +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> +				  struct system_counterval_t *system_counterval,
> +				  void *ctx)
> +{
> +	struct gve_cycles_to_clock_callback_ctx *context = ctx;
> +
> +	*device_time = 0;
> +
> +	system_counterval->cycles = context->cycles;
> +	system_counterval->use_nsecs = false;
> +
> +	if (IS_ENABLED(CONFIG_X86))
> +		system_counterval->cs_id = CSID_X86_TSC;
> +	else if (IS_ENABLED(CONFIG_ARM64))
> +		system_counterval->cs_id = CSID_ARM_ARCH_COUNTER;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +/*
> + * Convert a raw cycle count (e.g. from get_cycles()) to the system clock
> + * type specified by clockid. The system_time_snapshot must be taken before
> + * the cycle counter is sampled.
> + */
> +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t clockid,
> +				    struct system_time_snapshot *snap,
> +				    u64 cycles, struct timespec64 *ts)
> +{
> +	struct gve_cycles_to_clock_callback_ctx ctx = {0};
> +	struct system_device_crosststamp xtstamp;
> +	int err;
> +
> +	ctx.cycles = cycles;
> +	err = get_device_system_crosststamp(gve_cycles_to_clock_fn, &ctx, snap,
> +					    &xtstamp);
> +	if (err) {
> +		dev_err_ratelimited(&priv->pdev->dev,
> +				    "get_device_system_crosststamp() failed to convert %lld cycles to system time: %d\n",
> +				    cycles,
> +				    err);
> +		return err;
> +	}
> +
> +	switch (clockid) {
> +	case CLOCK_REALTIME:
> +		*ts = ktime_to_timespec64(xtstamp.sys_realtime);
> +		break;
> +	case CLOCK_MONOTONIC_RAW:
> +		*ts = ktime_to_timespec64(xtstamp.sys_monoraw);
> +		break;
> +	default:
> +		dev_err_ratelimited(&priv->pdev->dev,
> +				    "Cycle count conversion to clockid %d not supported\n",
> +				    clockid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
>  			      struct timespec64 *ts,
>  			      struct ptp_system_timestamp *sts)
>  {
> -	return -EOPNOTSUPP;
> +	struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
> +	struct gve_sysclock_sample sysclock = {0};
> +	struct gve_priv *priv = ptp->priv;
> +	u64 nic_ts;
> +	int err;
> +
> +	if (sts && !(IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_ARM64)))
> +		return -EOPNOTSUPP;
> +
> +	err = gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : NULL);
> +	if (err)
> +		return err;
> +
> +	if (sts) {
> +		/* Reject samples with out of order system clock values */
> +		if (!(sysclock.host_pre_cycles <= sysclock.nic_pre_cycles &&
> +		      sysclock.nic_pre_cycles  <= sysclock.nic_post_cycles &&
> +		      sysclock.nic_post_cycles <= sysclock.host_post_cycles)) {
> +			dev_err_ratelimited(&priv->pdev->dev,
> +					    "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
> +					    (u64)sysclock.host_pre_cycles,
> +					    sysclock.nic_pre_cycles,
> +					    sysclock.nic_post_cycles,
> +					    (u64)sysclock.host_post_cycles);
> +			return -EBADMSG;

Sashiko/gemini is reporting the following:

---
If older firmware does not support this feature and returns 0 for the
pre_cycles and post_cycles fields, won't host_pre_cycles <=
nic_pre_cycles evaluate to false since get_cycles() will be greater than
0? If this occurs, the driver returns -EBADMSG instead of -EOPNOTSUPP.
Does returning -EBADMSG prevent userspace tools from gracefully falling
back to legacy PTP ioctls like PTP_SYS_OFFSET, causing PTP
synchronization to fail completely on older firmwares?
---

which looks legit to me, or am I missing something? Note that
proactively triaging sashiko comments would help maintainers a lot.

Thanks,

Paolo


