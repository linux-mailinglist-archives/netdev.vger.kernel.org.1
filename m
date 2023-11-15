Return-Path: <netdev+bounces-47960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16757EC1B2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4E01C20364
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA571772D;
	Wed, 15 Nov 2023 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/0AoeKf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA744171D7
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:54:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762C11F;
	Wed, 15 Nov 2023 03:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049263; x=1731585263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CClELL9LLuLCO+dtt7JeMTwmCFDzy2RDUpcpu7ziq0U=;
  b=V/0AoeKfW4HvVdVUpiOosSJsYzdnUv5z6eDe+wGo+BsVnIDYTHA08qJu
   5HxbNGOrvsXHrkzPDrdAPhy4wb4n7EXmR5WX7mzq/C9F7jK3WH9F4Z64X
   68qBLIzfAz9moI5XjaHWS0/t2pbRX6aqMe9BqENubsHDBm5srxB7oYEfu
   pm19/RlIEot9iWiSFSvSuDvxmKioXmug83CtdgBvZHQG1goqlGWzy6nZv
   W3b9x5EjOZk2mZvwWgYBbCovvhGC57LOLe971UzEjMNvDq74en84FrPWG
   fJ1eAPUOuS0R3zaqJEYotUugtaEzGXaLw4qAvjBZnkbtuwhtADqU/s/S2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393719915"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393719915"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753243"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753243"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:54:18 -0800
Message-ID: <227b82b5-7e05-4eaf-acc2-a979d53e893f@linux.intel.com>
Date: Wed, 15 Nov 2023 19:54:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules
 switching
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
 <20231108222756.l3u6h6gllxnbypyn@skbuf>
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231108222756.l3u6h6gllxnbypyn@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/2023 6:27 am, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:17AM -0500, Faizal Rahim wrote:
>> In the current taprio code for dynamic schedule change,
>> admin/oper schedule switching happens immediately when
>> should_change_schedules() is true. Then the last entry of
>> the old admin schedule stops being valid anymore from
>> taprio_dequeue_from_txq’s perspective.
> 
> Admittedly, I may have become a bit detached from this code base in the
> past months, but I don't understand the reasoning here.
> 
> Could you please explain what makes the last entry of the old admin
> schedule be invalid from taprio_dequeue_from_txq()'s perspective?
> 
> What I see is that when should_change_schedules() is true, we change
> q->oper_sched and q->admin_sched through the switch_schedules() call,
> but we don't change q->current_entry, so I fail to understand the
> connection you are implying.

My bad – I used part of the explanation from the original author without 
thoroughly checking it. I have some guesses about 
taprio_dequeue_from_txq(), but they're not solid without more testing.

So, I'll swap it with your suggestion below, which highlights the obvious 
issue.

> On the other hand (and I see I did mention this in the other thread),
> it seems that taprio_skb_exceeds_queue_max_sdu() - called from the
> enqueue() path - looks at q->oper_sched, and that's a valid reason why
> we'd want to delay the schedule switch until admin's actual base time,
> rather than the current oper's cycle_end_time.

Agree, observed this too.


> But please, let's spare no expense in providing a proper problem
> description, justification for the change and Fixes: tag. This is not
> optional.
> 
>> To solve this, we have to delay the switch_schedules() call via
>> the new cycle_time_correction variable. The variable serves 2
>> purposes:
>> 1. Upon entering advance_sched(), if the value is set to a
>> non-initialized value, it indicates that we need to change
>> schedule.
>> 2. Store the cycle time correction value which will be used for
>> negative or positive correction.
> 
> It needs to be stated much more clearly that only purpose 1 is relevant
> here (I would even go as far as to omit its secondary purpose here).
> The only reason we are using the correction variable is because it
> happens that we'll need that in later changes.

Got it.

> 
>>
>> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> 
> I believe that since the only observable problem has to do with
> taprio_skb_exceeds_queue_max_sdu(), the Fixes: tag should be the commit
> which added that logic. Which is:
> 
> Fixes: a878fd46fe43 ("net/sched: keep the max_frm_len information inside struct sched_gate_list")

Will replace the patch explanation with this. Thanks.

>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index 2e1949de4171..dee103647823 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
>>   #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
>>   #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>>   #define TAPRIO_FLAGS_INVALID U32_MAX
>> +#define INIT_CYCLE_TIME_CORRECTION S64_MIN
> 
> I would prefer naming it CYCLE_TIME_CORRECTION_INVALID or _UNSPEC.
> It is not just used as the "initial" value.
> 
>>   
>>   struct sched_entry {
>>   	/* Durations between this GCL entry and the GCL entry where the
>> @@ -75,6 +76,7 @@ struct sched_gate_list {
>>   	ktime_t cycle_end_time;
>>   	s64 cycle_time;
>>   	s64 cycle_time_extension;
>> +	s64 cycle_time_correction;
>>   	s64 base_time;
>>   };
>>   
>> @@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   	admin = rcu_dereference_protected(q->admin_sched,
>>   					  lockdep_is_held(&q->current_entry_lock));
>>   
>> -	if (!oper)
>> +	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
> 
> You could introduce even as early as this change a "static bool
> sched_switch_pending(struct sched_gate_list *oper)" function, which
> incorporates the entire body of this "if" expression.
> 
>> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>>   		switch_schedules(q, &admin, &oper);
>> +	}
>>   
>>   	/* This can happen in two cases: 1. this is the very first run
>>   	 * of this function (i.e. we weren't running any schedule
>> @@ -981,7 +985,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   		 * schedule runs.
>>   		 */
>>   		end_time = sched_base_time(admin);
>> -		switch_schedules(q, &admin, &oper);
>> +		oper->cycle_time_correction = 0;
>>   	}
>>   
>>   	next->end_time = end_time;
>> @@ -1174,6 +1178,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
>>   	}
>>   
>>   	taprio_calculate_gate_durations(q, new);
>> +	new->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.25.1
>>

