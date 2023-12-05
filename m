Return-Path: <netdev+bounces-53972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 705C18057B5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E2A1F21727
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFA5FEEF;
	Tue,  5 Dec 2023 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qFxoDvmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF20194
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:45:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c5f0e325a6so2014517a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701787557; x=1702392357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLmtUpUh4LlW0YxmDYtUdclS77QvzijPoi2Qj71a3iQ=;
        b=qFxoDvmkdcFPsd94KS7xee9U1YK0cezhN+swzdNAxBRHncWW6pPYyjYIyRmxvvd88s
         3gyNyXDffTYcilofMi1WgIiM3HhiVIgnAnLB/FboHmFnLoa+vPNUmsLPebrHdsrIP3qe
         tGUovBOVEt0igWkaEaufBMevZKPFnv7WErjMmbuuuINlmN66786c/0/1b4+Z0QoKcuRL
         WgnflOn9j16VTtJiAvb+W64YsA+7geFwZwajSp08wgmq5bjZ1dG/QuxlBiu5AkSIFbwY
         VSuzC82VIRkyBX2eblidJxFvQ+icb9NUfki8piEou+ooxLmOWVv5FNJUiK0+4IRJDtlM
         OPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787557; x=1702392357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLmtUpUh4LlW0YxmDYtUdclS77QvzijPoi2Qj71a3iQ=;
        b=NEn2zCP8ZCUOlmW0FOur8ZBJpPMl+c8BO1rE8mCYgjY2SdClm5uLa987aQse6JnSdx
         vjuQYELejKoQ/V2o/aOOQfMRXjWD/KNhKCwBE5btU13pvNHwnw8OVfNQpOLlTYuX4j1T
         0XqSYbOKOdX5ulrhCQASfO4L57+bsS0fNwzbpVTsDZcB4rnKQcUSwR8yU1rUyTkjI/3g
         Fcn/1nSp/tRVyqFVO14Gg9LrQim33iPckhQ/L3YtmjJUuuijDKcfTA9ZONW1G/BSHa6G
         /7memSdi+WJlxP2VbALhf4k3dah/FCT0Ff8Rwj8Rp8ontjWCec4etT+N7zG6Gg7ciSyW
         IRFw==
X-Gm-Message-State: AOJu0YyD/G118I4+69bM/O92CODIN85mmmIy+yrw+I0xRr6sngc/0TGM
	1Flpa6Kc4tFXiD2/RzUm6aZfWQ==
X-Google-Smtp-Source: AGHT+IFVEq5UyVnUx4+riF7OYOxdFvbMBc5o7kuSkLE+0SOnnm6zHvM+A2JYPkQu1JHX4FnJcMzJAg==
X-Received: by 2002:a17:903:1110:b0:1d0:90cb:5adb with SMTP id n16-20020a170903111000b001d090cb5adbmr2868512plh.52.1701787557389;
        Tue, 05 Dec 2023 06:45:57 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001d087f68ef8sm1420726plk.37.2023.12.05.06.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:45:56 -0800 (PST)
Message-ID: <6a70805b-953d-494e-a9b9-a2cb0e0aff18@mojatatu.com>
Date: Tue, 5 Dec 2023 11:45:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net/sched: act_api: conditional
 notification of events
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com, vladbu@nvidia.com
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-5-pctammela@mojatatu.com>
 <ZW8KaANgu0DpryWV@nanopsycho>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <ZW8KaANgu0DpryWV@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2023 08:32, Jiri Pirko wrote:
> Mon, Dec 04, 2023 at 09:39:06PM CET, pctammela@mojatatu.com wrote:
>> As of today tc-action events are unconditionally built and sent to
>> RTNLGRP_TC. As with the introduction of tc_should_notify we can check
>> before-hand if they are really needed.
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>> net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
>> 1 file changed, 76 insertions(+), 29 deletions(-)
>>
>> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>> index c39252d61ebb..55c62a8e8803 100644
>> --- a/net/sched/act_api.c
>> +++ b/net/sched/act_api.c
>> @@ -1780,31 +1780,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
>> 	return 0;
>> }
>>
>> -static int
>> -tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>> +static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
> 
> I wonder, why this new function is needed? If I'm reading things
> correctly, tcf_reoffload_del_notify() with added check would be just ok,
> woundn't it?
> 
> Same for others.

In V1 we had it like what you are suggesting[1].
Jakub suggested to refactor the functions a bit more. The main argument 
was the code duplication introduced for the delete routines.
Note that for the case that no notification is needed, we still need to 
do the action delete etc...
I agree that code duplication is bad in the long term, so I did the 
changes, but I don't have a strong opinion here (either way is fine for me).
Let's see what he has to say, perhaps I overdid what he was suggesting :)

[1] 
https://lore.kernel.org/all/20231201204314.220543-4-pctammela@mojatatu.com/

> 
>> +						    struct tc_action *action)
>> {
>> 	size_t attr_size = tcf_action_fill_size(action);
>> 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
>> 		[0] = action,
>> 	};
>> -	const struct tc_action_ops *ops = action->ops;
>> 	struct sk_buff *skb;
>> -	int ret;
>>
>> -	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>> -			GFP_KERNEL);
>> +	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
> 
> I don't see how this is related to this patch. Can't you do it in separate
> patch?
> 
> Same for others.

Sure, will split it out.

> 
>> 	if (!skb)
>> -		return -ENOBUFS;
>> +		return ERR_PTR(-ENOBUFS);
>>
>> 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
>> 		kfree_skb(skb);
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>> 	}
>>
>> +	return skb;
>> +}
>> +
> 
> [...]


