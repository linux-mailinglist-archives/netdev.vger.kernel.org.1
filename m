Return-Path: <netdev+bounces-107488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D591B2BA
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB3B2843D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077E1A2FAA;
	Thu, 27 Jun 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXu77rx2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2D1A2FA4;
	Thu, 27 Jun 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531034; cv=none; b=IiyCFUn/HTvWi88uEMMzbythObY0ipmp1HCemC+C0fUNrYp8fR1bq4dDpVzMW7U02ZfPWPY0NTRuHToh2L3TmMoKuhtci2/ppoRHrBAp2pJGXXiF1ORvtQ6pKgTRpo7oGlO2usvWET/BAM/XHT6LpugD8BD9DVeHBer2ebMnm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531034; c=relaxed/simple;
	bh=XA+S08vABJGqRbATpwXPVYZgtdZeKQPyXesLekPlISE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vqq7Qi+80haJGU0SrS/ZRZD0kqYfQ/iqfE0NAQgzMK7zGwcVf7EAAPxvjUwk73+1qFJR36796oslFs06ni7NFzZ0M2FCUEVtpI4hPOJ6YbG90GGFk9cwmXGhbPivGgwD4z54a4phKbrSHF7w2vQQ70EuFmjzbu6ocEpr8KF3ZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXu77rx2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719531032; x=1751067032;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XA+S08vABJGqRbATpwXPVYZgtdZeKQPyXesLekPlISE=;
  b=kXu77rx2wtpr1rl9kqG4rwHLb92EmstyNEjSDrDsgW0/H8oJQG8hqD8V
   klbjS3FwDGX/XRSdr7wJZPyqod0VTLaEi8XhHcAZskPyO7R7haXta5HTd
   UsJQ71VADkPStNpjUGykktS6zYpCZdE16USFJc98FFc6DvY6I1hJzLT2L
   ubVbY0I8xMstUCIrq+b8EoZRhMrCZ1vzMGHsjNpaesTZnIxXUAfTj1ySt
   b36JEM9xESpeK/qMfV9NUZgnD67jk5enRTj9qIUY2eWym3szBPkWIrc3a
   O+pvv+R9km35SiizTQhgvzFM6Qx4/u6J86EwLdyRAIbAGRACFth7THWMM
   A==;
X-CSE-ConnectionGUID: LgVLJl8YQlS2TTlHWfmjEw==
X-CSE-MsgGUID: FJfecn66Q7GMxl08Vdrbfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16828247"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16828247"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:30:31 -0700
X-CSE-ConnectionGUID: Bqdl1xBoTTaTv4KYzKzf3A==
X-CSE-MsgGUID: V/+azdD1QPCicW8l/CDIiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44641863"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:30:31 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yun Lu <luyun@kylinos.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPU stuck due to the taprio hrtimer
In-Reply-To: <20240627055338.2186255-1-luyun@kylinos.cn>
References: <20240627055338.2186255-1-luyun@kylinos.cn>
Date: Thu, 27 Jun 2024 16:30:30 -0700
Message-ID: <87sewy55gp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yun Lu <luyun@kylinos.cn> writes:

> Hello,
>
> When I run a taprio test program on the latest kernel(v6.10-rc4), CPU stuck
> is detected immediately, and the stack shows that CPU is stuck on taprio
> hrtimer.
>
> The reproducer program link:
> https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
> gcc taprio_test.c -static -o taprio_test
>
> In this program, start the taprio hrtimer which clockid is set to REALTIME, and
> then adjust the system time by a significant value backwards. Thus, CPU will enter
> an infinite loop in the__hrtimer_run_queues function, getting stuck and unable to
> exit or respond to any interrupts.
>
> I have tried to avoid this problem by apllying the following patch, and it does work.
> But I am not sure if this can be the final solution?
>
> Thanks.
>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>  net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index a0d54b422186..2ff8d34bdbac 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -104,6 +104,7 @@ struct taprio_sched {
>  	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
>  	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
>  	u32 txtime_delay;
> +	ktime_t offset;
>  };
>  
>  struct __tc_taprio_qopt_offload {
> @@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched_gate_list *sched)
>  	return ns_to_ktime(sched->base_time);
>  }
>  
> +static ktime_t taprio_get_offset(const struct taprio_sched *q)
> +{
> +	enum tk_offsets tk_offset = READ_ONCE(q->tk_offset);
> +	ktime_t time = ktime_get();
> +
> +	switch (tk_offset) {
> +	case TK_OFFS_MAX:
> +		return 0;
> +	default:
> +		return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
> +	}
> +}
> +
>  static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t mono)
>  {
>  	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
> @@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	int num_tc = netdev_get_num_tc(dev);
>  	struct sched_entry *entry, *next;
>  	struct Qdisc *sch = q->root;
> +	ktime_t now_offset = taprio_get_offset(q);
>  	ktime_t end_time;
>  	int tc;
>  
> @@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	end_time = ktime_add_ns(entry->end_time, next->interval);
>  	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
>  
> +	if (q->offset != now_offset) {
> +		ktime_t diff = ktime_sub_ns(now_offset, q->offset);
> +
> +		end_time = ktime_add_ns(end_time, diff);
> +		oper->cycle_end_time = ktime_add_ns(oper->cycle_end_time, diff);
> +		q->offset = now_offset;
> +	}
> +

I think what we should do here is a bit different. Let me try to explain
what I have in mind with some context.

A bit of context: The idea of taprio is to enforce "TSN" traffic
schedules, these schedules require time synchronization, for example via
PTP, and in those cases, time jumps are not expected or a sign that
something is wrong.

In my mind, a time jump, specially a big one, kind of invalidates the
schedule, as the schedule is based on an absolute time value (the
base_time), and when time jumps that reference in time is lost.

BUT making the user's system unresponsive is a bug, a big one, as if
this happens in the real world, the user will be unable to investigate
what made the system have so big a time correction.

So my idea is to warn the user that the time jumped, say that the user
needs to reconfigure the schedule, as it is now invalid, and disable the
schedule.

Does this make sense?

Ah, and thanks for the report.

>  	for (tc = 0; tc < num_tc; tc++) {
>  		if (next->gate_duration[tc] == oper->cycle_time)
>  			next->gate_close_time[tc] = KTIME_MAX;
> @@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
>  
>  	base = sched_base_time(sched);
>  	now = taprio_get_time(q);
> +	q->offset = taprio_get_offset(q);
>  
>  	if (ktime_after(base, now)) {
>  		*start = base;
> -- 
> 2.34.1
>


Cheers,
-- 
Vinicius

