Return-Path: <netdev+bounces-54078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC9805F44
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9C281DC9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D36DCFF;
	Tue,  5 Dec 2023 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wx0cOuTr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB34C0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:19:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-286c01bff06so1802699a91.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701807567; x=1702412367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJYAeW1apCiktMr0odilav+laAl32KXPzgpCGhXiRGE=;
        b=wx0cOuTrSzuUoOnH22hcEtdxEDaR/ud5oIAVUaVg8ISxi62wuITez28/T9yVvXvQgm
         u5Gb55Q7t0UEU4jbaxIAhGnRrKS7vbhYqkaQgjWk7Gd+faqwZbdab+E9bzo1YxI8jArd
         sgHfhjBszC6VRZdjVMgIJ0RtFEK5DDuuos5PP9RletFwGB/D1ULSf5qetPbA6LUC20qo
         ejvM2q0TyC+YTIvPm9KQta4o/G0QnBA/JnuB83lsgfpCpzdnAo4q9ZhAxTBxYSQAgl42
         L6Wvzd1F8oCf4fJ28De7nRlEWPz9MwIwCmiQKhUypQgd4pcNkYB0Aycm8+bET2Ulz+wG
         mA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807567; x=1702412367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJYAeW1apCiktMr0odilav+laAl32KXPzgpCGhXiRGE=;
        b=M1wxdGWNspcaeMr+GYDcjqaVXGeF5MLGTAxzgQAQIlbcEAVkru8JN0XVBQW2jEtyrK
         VSwRMIQuvC1V2vJ+zYPetytwHFvztZsbO1B1FIprIMs9FUcPxVT+jL5ivtqT/7K28x79
         y4TC3NSkOig+XuiiGnOffACuvDSgP3k1C5wClOa0dud4IpqMRYhJzQLMG0+Us+38rJZv
         I7GvJ4zqgvJIcU94Un1EmJO6ffEp6dGuW7OldMj4I4pmjOopuRJDsDRPNS7guwjmprbh
         1ySO8/Bd6MDcVudCHvvnJRL4wPQOuwwcrRHtHk4jiaIbd56bFzXTJEOegPxfRTZ+jLf9
         ZNrg==
X-Gm-Message-State: AOJu0YxJPR90fbEAMdotb5olMxpowK+jg/vTGrFczVzkAhvNG6CGCc74
	rQ/QB5v0CBj+vk/C8RKyV5kmek3La4x0KbJRihE=
X-Google-Smtp-Source: AGHT+IF1Dip7Qzwmpx54kV/226FZ+PJRT2zluwyJQxs/1207k76iXCs50tdgUH79FZM5QKV+Wm7M6Q==
X-Received: by 2002:a17:90b:1a81:b0:286:a708:cd2c with SMTP id ng1-20020a17090b1a8100b00286a708cd2cmr1549483pjb.9.1701807566970;
        Tue, 05 Dec 2023 12:19:26 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id fw24-20020a17090b129800b002868abc0e6dsm5092857pjb.11.2023.12.05.12.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:19:26 -0800 (PST)
Message-ID: <77b8d1d8-4ad9-49c7-9c42-612e9de29881@mojatatu.com>
Date: Tue, 5 Dec 2023 17:19:21 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in
 tcf_idr_check_alloc
Content-Language: en-US
To: Vlad Buslov <vladbu@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com
References: <20231205153012.484687-1-pctammela@mojatatu.com>
 <20231205153012.484687-2-pctammela@mojatatu.com> <87jzpso53a.fsf@nvidia.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <87jzpso53a.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2023 15:34, Vlad Buslov wrote:
> On Tue 05 Dec 2023 at 12:30, Pedro Tammela <pctammela@mojatatu.com> wrote:
>> Instead of relying only on the idrinfo->lock mutex for
>> bind/alloc logic, rely on a combination of rcu + mutex + atomics
>> to better scale the case where multiple rtnl-less filters are
>> binding to the same action object.
>>
>> Action binding happens when an action index is specified explicitly and
>> an action exists which such index exists. Example:
> 
> Nit: the first sentence looks mangled, extra 'exists' word and probably
> 'which' should be 'with'.
> 
>>    tc actions add action drop index 1
>>    tc filter add ... matchall action drop index 1
>>    tc filter add ... matchall action drop index 1
>>    tc filter add ... matchall action drop index 1
>>    tc filter ls ...
>>       filter protocol all pref 49150 matchall chain 0 filter protocol all pref 49150 matchall chain 0 handle 0x1
>>       not_in_hw
>>             action order 1: gact action drop
>>              random type none pass val 0
>>              index 1 ref 4 bind 3
>>
>>     filter protocol all pref 49151 matchall chain 0 filter protocol all pref 49151 matchall chain 0 handle 0x1
>>       not_in_hw
>>             action order 1: gact action drop
>>              random type none pass val 0
>>              index 1 ref 4 bind 3
>>
>>     filter protocol all pref 49152 matchall chain 0 filter protocol all pref 49152 matchall chain 0 handle 0x1
>>       not_in_hw
>>             action order 1: gact action drop
>>              random type none pass val 0
>>              index 1 ref 4 bind 3
>>
>> When no index is specified, as before, grab the mutex and allocate
>> in the idr the next available id. In this version, as opposed to before,
>> it's simplified to store the -EBUSY pointer instead of the previous
>> alloc + replace combination.
>>
>> When an index is specified, rely on rcu to find if there's an object in
>> such index. If there's none, fallback to the above, serializing on the
>> mutex and reserving the specified id. If there's one, it can be an -EBUSY
>> pointer, in which case we just try again until it's an action, or an action.
>> Given the rcu guarantees, the action found could be dead and therefore
>> we need to bump the refcount if it's not 0, handling the case it's
>> in fact 0.
>>
>> As bind and the action refcount are already atomics, these increments can
>> happen without the mutex protection while many tcf_idr_check_alloc race
>> to bind to the same action instance.
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   net/sched/act_api.c | 56 +++++++++++++++++++++++++++------------------
>>   1 file changed, 34 insertions(+), 22 deletions(-)
>>
>> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>> index abec5c45b5a4..79a044d2ae02 100644
>> --- a/net/sched/act_api.c
>> +++ b/net/sched/act_api.c
>> @@ -824,43 +824,55 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>>   	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>   	struct tc_action *p;
>>   	int ret;
>> +	u32 max;
>>   
>> -again:
>> -	mutex_lock(&idrinfo->lock);
>>   	if (*index) {
>> +again:
>> +		rcu_read_lock();
>>   		p = idr_find(&idrinfo->action_idr, *index);
>> +
>>   		if (IS_ERR(p)) {
>>   			/* This means that another process allocated
>>   			 * index but did not assign the pointer yet.
>>   			 */
>> -			mutex_unlock(&idrinfo->lock);
>> +			rcu_read_unlock();
>>   			goto again;
>>   		}
>>   
>> -		if (p) {
>> -			refcount_inc(&p->tcfa_refcnt);
>> -			if (bind)
>> -				atomic_inc(&p->tcfa_bindcnt);
>> -			*a = p;
>> -			ret = 1;
>> -		} else {
>> -			*a = NULL;
>> -			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
>> -					    *index, GFP_KERNEL);
>> -			if (!ret)
>> -				idr_replace(&idrinfo->action_idr,
>> -					    ERR_PTR(-EBUSY), *index);
>> +		if (!p) {
>> +			/* Empty slot, try to allocate it */
>> +			max = *index;
>> +			rcu_read_unlock();
>> +			goto new;
>> +		}
>> +
>> +		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
>> +			/* Action was deleted in parallel */
>> +			rcu_read_unlock();
>> +			return -ENOENT;
> 
> Current version doesn't return ENOENT since it is synchronous. You are
> now introducing basically a change to UAPI since users of this function
> (individual actions) are not prepared to retry on ENOENT and will
> propagate the error up the call chain. I guess you need to try to create
> a new action with specified index instead.

I see.
So you are saying that in the case where action foo is deleted and a 
binding in parallel observes the deleted action, it should fallback into 
trying to allocate the index.

We could goto again and hope that idr_find will observe the idr index 
being freed, in which case it would fall back into action allocation if 
it does or simply go via the same path as before (jumping to 'again').

I don't see much problems here, it seems to converge in this scenario
as it eventually transforms into race for action allocation (more below) 
if you have an unfortunate delete with many bindings in flight.

> 
>>   		}
>> +
>> +		if (bind)
>> +			atomic_inc(&p->tcfa_bindcnt);
>> +		*a = p;
>> +
>> +		rcu_read_unlock();
>> +
>> +		return 1;
>>   	} else {
>> +		/* Find a slot */
>>   		*index = 1;
>> -		*a = NULL;
>> -		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
>> -				    UINT_MAX, GFP_KERNEL);
>> -		if (!ret)
>> -			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
>> -				    *index);
>> +		max = UINT_MAX;
>>   	}
>> +
>> +new:
>> +	*a = NULL;
>> +
>> +	mutex_lock(&idrinfo->lock);
>> +	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
>> +			    GFP_KERNEL);
> 
> What if multiple concurrent tasks didn't find the action by index with
> rcu and get here, synchronizing on the idrinfo->lock? It looks like
> after the one who got the lock first successfully allocates the index
> everyone else will fail (also propagating ENOSPACE to the user). 

Correct

> I guess you need some mechanism to account for such case and retry.

Ok, so if I'm binding and it's observed a free index, which means "try 
to allocate" and I get a ENOSPC after jumping to new, try again but this 
time binding into the allocated action.

In this scenario when we come back to 'again' we will wait until -EBUSY 
is replaced with the real pointer. Seems like a big enough window that 
any race for allocating from binding would most probably end up in this 
contention loop.

However I think when we have these two retry mechanisms there's a 
extremely small window for an infinite loop if an action delete is timed 
just right, in between the action pointer is found and when we grab the 
tcfa_refcnt.

	idr_find (pointer)
	tcfa_refcnt (0)  <-------|
	again:                   |
	idr_find (free index!)   |
	new:                     |
	idr_alloc_u32 (ENOSPC)   |
	again:                   |
	idr_find (EBUSY)         |
	again:                   |
	idr_find (pointer)       |
	<evil delete happens>    |
	------->>>>--------------|

Another potential problem, is that this will race with non binding 
actions. So if the ENOSPC was actually from another unrelated action. A 
practical example would be a race between a binding to an 'action drop 
index 1' and an 'action ok' allocation. Actually it's a general problem 
and not particular to this case here but it seems like we could be 
amplifying it.

I'm conflicted here. If I were to choose one of the two, I would pick 
the action respawing as to me it seems to converge much quicker and 
removes the uapi change (my bad! :).

As for usability, if all of a sudden there's a huge influx of ENOSPC 
errors because users are abusing 'tc filter add ... action index 1 ...' 
in parallel _before_ actually creating the action object the fix is to just:
tc actions add action index 1 ...
tc filter add ...

As tc has always supported

