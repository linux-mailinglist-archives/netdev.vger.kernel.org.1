Return-Path: <netdev+bounces-47229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E97E8F7A
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825B21C204F3
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B837461;
	Sun, 12 Nov 2023 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obpAjzkP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F72154AB
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 10:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC18FC433C7;
	Sun, 12 Nov 2023 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699785082;
	bh=TxX4txCL/uRk/fD1yN7nT9Vlx5JaDrUWP488dS697wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obpAjzkPT6C0OAAwzG+ymbOcFqzz9sP9aMtBCXnvx1iHXamYbX7dkLMFH0At4iOge
	 dDjhxG4mmk+aQt78IEymeXwuoVrVwbNhgUcuVXn713qbmMHDdIOdsHK6/+/XlH9+FU
	 uIg9CD1HG13zt+gn5o+DhS7ouCki1IC/XnuI5leZTBtHbImzXwcYfRDHCLL77qaA5t
	 pawUMGWf6txMPVV5whqoed3b8Tym6xZNgwrjdmtMg/2uqaAfBfEkhv4sx3729TbUrq
	 G4HZySOv4h9k7u35sAOkfyDQqcwAyYiWwwHJWn6cp55CZiyQFRl3rm7RGj5WATEwc4
	 1dZVCzh/1izDA==
Date: Sun, 12 Nov 2023 10:31:12 +0000
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules
 switching
Message-ID: <20231112103112.GK705326@kernel.org>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>

On Tue, Nov 07, 2023 at 06:20:17AM -0500, Faizal Rahim wrote:
> In the current taprio code for dynamic schedule change,
> admin/oper schedule switching happens immediately when
> should_change_schedules() is true. Then the last entry of
> the old admin schedule stops being valid anymore from
> taprio_dequeue_from_txq’s perspective.
> 
> To solve this, we have to delay the switch_schedules() call via
> the new cycle_time_correction variable. The variable serves 2
> purposes:
> 1. Upon entering advance_sched(), if the value is set to a
> non-initialized value, it indicates that we need to change
> schedule.
> 2. Store the cycle time correction value which will be used for
> negative or positive correction.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2e1949de4171..dee103647823 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
>  #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
>  #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>  #define TAPRIO_FLAGS_INVALID U32_MAX
> +#define INIT_CYCLE_TIME_CORRECTION S64_MIN
>  
>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
> @@ -75,6 +76,7 @@ struct sched_gate_list {
>  	ktime_t cycle_end_time;
>  	s64 cycle_time;
>  	s64 cycle_time_extension;
> +	s64 cycle_time_correction;
>  	s64 base_time;
>  };
>  
> @@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	admin = rcu_dereference_protected(q->admin_sched,
>  					  lockdep_is_held(&q->current_entry_lock));
>  
> -	if (!oper)
> +	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {

Hi Faizal,

The first condition above expects that oper may be NULL, but the line below
dereferences it unconditionally. This doesn't seem correct, one way or the
other.

As flagged by Smatch and Coccinelle.

> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>  		switch_schedules(q, &admin, &oper);
> +	}
>  
>  	/* This can happen in two cases: 1. this is the very first run
>  	 * of this function (i.e. we weren't running any schedule

...

