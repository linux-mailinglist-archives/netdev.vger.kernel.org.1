Return-Path: <netdev+bounces-55314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26D80A553
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DA3281628
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F1D1DDD5;
	Fri,  8 Dec 2023 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DjFSojTN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43D1994
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 06:21:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce95e387e5so1575529b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702045308; x=1702650108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TH4HL8+c0WGLjAl1r8XINHiO7LrLKBkg7/yAHlVMMi4=;
        b=DjFSojTNKl7jx5ySKJkGiJ38CKD7sRc7l3q/+s+NzsMukr9KV1HGXgJD7CWb7/0LQj
         tjV/e2A1FCo8jkxIsw14xdby+X0qAVNjiUQCkL+tqKA08NhekELHpkobj8B59YDof7er
         GE1fOt/xZ1UZ+Fm5yYUzAvbW6eKt6SZ/CcKkJxG20nvzhTDsy8qUAXtYwH1+LWWiaoSL
         JNQ1YGO1ydmGayu/uf3+1N6zFfynd8OpndIp2jquJ7GdJZ9RSS4XA+FNGQvYAMdeZ+bQ
         y27Nm83L97qJv//6pmwjIdQIkPGpiRVDTOhH68ifCNny7oOIgid4EvZQN1zqCz3tM/rY
         d7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045308; x=1702650108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH4HL8+c0WGLjAl1r8XINHiO7LrLKBkg7/yAHlVMMi4=;
        b=iKOH6Zm8BT2XUz1tzc3o69IO3U/Bxr17rgB2MArOb7u38Tdren/C8V93axFOz2lptv
         mXE3QDPX/QBlCwT494S44KYfODkpuHSPrBOOdJwN6bNtheTfD88jDp5OxqBzQHZG1wKU
         1WzXCFR/jG5ivVlO6opAlqHn7AOWFvfQEYjNnGYR1M5tDi/f0y76RGPpFo3CjTbW3OgQ
         S6tKELxPx02GEMAO17UvGobGdOXgSw+28h143stH4txapq5B/49tNe4tdJlKcIt0Ir+c
         2uFbzG+JqsvoigZ5UxnFl65KvBIDUj22XgRce+QSe78+9wzINYMHrEyqai8vscShMt95
         Hlcw==
X-Gm-Message-State: AOJu0YzmAumKr7g1WZ4Rz3sVfmUgdheOoyGXE2ws5+tQqVIyXka+Zggr
	wk4a9iAXFzWBt9UkqR9e44TODw==
X-Google-Smtp-Source: AGHT+IGZwuxdUEG/mFfLpTtE+CxFcyeXnEHg7rVfV/jx4/I+kzjdmXWEVnE9NGmNcEGm4PQgR9wK9w==
X-Received: by 2002:a05:6a20:9694:b0:18f:97c:925c with SMTP id hp20-20020a056a20969400b0018f097c925cmr77335pzc.65.1702045308180;
        Fri, 08 Dec 2023 06:21:48 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id m12-20020a056a00080c00b006ce54e08b6asm1612846pfk.203.2023.12.08.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 06:21:47 -0800 (PST)
Message-ID: <9c6e3d86-a283-4c88-9293-613bd4de3d11@mojatatu.com>
Date: Fri, 8 Dec 2023 11:21:43 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net/sched: act_api: conditional
 notification of events
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 vladbu@nvidia.com
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-5-pctammela@mojatatu.com>
 <20231207205650.GH50400@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231207205650.GH50400@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/12/2023 17:56, Simon Horman wrote:
> On Wed, Dec 06, 2023 at 01:44:15PM -0300, Pedro Tammela wrote:
>> As of today tc-action events are unconditionally built and sent to
>> RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
>> before-hand if they are really needed.
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> Hi Pedro,
> 
> a nice optimisation :)
> 
> ...
> 
>> +static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>> +{
>> +	const struct tc_action_ops *ops = action->ops;
>> +	struct sk_buff *skb = NULL;
>> +	int ret;
>> +
>> +	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC))
>> +		goto skip_msg;
> 
> Is there a reason (performance?) to use a goto here
> rather than putting the tcf_reoffload_del_notify_msg() call inside
> an if condition?

Not really, seems like the goto mosquito bit me on this one.
I will move to your suggestion and do the change Jiri asked which I 
totally forgot in v3.

> 
> Completely untested!
> 
> 	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
> 		skb = NULL;
> 	} else {
> 		skb = tcf_reoffload_del_notify_msg(net, action);
> 		if (IS_ERR(skb))
> 			return PTR_ERR(skb);
> 	}
> 
> Or perhaps a helper, as this pattern seems to also appear in tcf_add_notify() >
> 
>> +
>> +	skb = tcf_reoffload_del_notify_msg(net, action);
>> +	if (IS_ERR(skb))
>> +		return PTR_ERR(skb);
>> +
>> +skip_msg:
>>   	ret = tcf_idr_release_unsafe(action);
>>   	if (ret == ACT_P_DELETED) {
>>   		module_put(ops->owner);
>> -		ret = rtnetlink_send(skb, net, 0, RTNLGRP_TC, 0);
>> +		ret = rtnetlink_maybe_send(skb, net, 0, RTNLGRP_TC, 0);
>>   	} else {
>>   		kfree_skb(skb);
>>   	}
> 
> ...
> 
>> +static int tcf_add_notify(struct net *net, struct nlmsghdr *n,
>> +			  struct tc_action *actions[], u32 portid,
>> +			  size_t attr_size, struct netlink_ext_ack *extack)
>> +{
>> +	struct sk_buff *skb = NULL;
>> +
>> +	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
>> +		goto skip_msg;
>> +
>> +	skb = tcf_add_notify_msg(net, n, actions, portid, attr_size, extack);
>> +	if (IS_ERR(skb))
>> +		return PTR_ERR(skb);
>> +
>> +skip_msg:
>> +	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
>> +				    n->nlmsg_flags & NLM_F_ECHO);
>>   }
>>   
>>   static int tcf_action_add(struct net *net, struct nlattr *nla,
>> -- 
>> 2.40.1
>>


