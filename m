Return-Path: <netdev+bounces-55387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5280AB26
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A552814BE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132E3B286;
	Fri,  8 Dec 2023 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GuBrx1EV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3D1985
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:48:58 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d1e1edb10bso21871175ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702057738; x=1702662538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTVMTw7G6k3bFJUrRXADtJlFUG9lF8i5JNaghbpxSL4=;
        b=GuBrx1EVHR04P0kk0z+hIjCeLZg3VFxVPvt9Cy6bSdhWpHRmTT9XmR/ZJ+2zL0bekW
         RXTP6EOPLs1kuo/2rGfAFx2cJRgOFoevaj9wgyaVfvKSeBfMRwIaE6M6REvowIMPkRNr
         eTCy2sJCxZxt8UyKiOYyd+FrkFNbikOYo+QJms5qA+I6kmRP7amwkJ4CzEmTAzsWemL7
         1j5izoJkKzfXJi6aPp1mrBBSMnNFsn3vll12DwOX8v4ILNFII6Yd9QtfSrvYSbm2LAaO
         OB0v6W9b4NOkCN5iB76VPMVhYfjSvBMpVW/HepzBfiGBZW3SsW6pZK579FrYEkZK1b2V
         oFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057738; x=1702662538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTVMTw7G6k3bFJUrRXADtJlFUG9lF8i5JNaghbpxSL4=;
        b=HeuwAOPp5Jn6y11C8mC98Bl3Yml4wfSulSYkR29l0Hjhj6HKrGqekSYUHeuiLz9LnS
         6i8D2TpnNqQxHI60KwpmN1871lRh5k1qZKPvSC95v+GLRNyh8XVQGAthuXe/0aeYrAcc
         rsiw4bIZwgUKnxMzGKhkxUtVyfXeXZ2kqcC46e+3vKtlo2yV6UPD+z0fKVhb+GELlElM
         M6uQ+bTS+xLT7N9/usXX0gh2kXVuDGiZKZ6vPxKCqfoOFUbwM3krIKmlQMwU0iunhQgz
         CFdq6AuufD3MjiBe0pi2fIE1qUtPD/bVom3fKaNrTtyefrIff9a/c8l48Gzn+oO0Mauo
         ZfOg==
X-Gm-Message-State: AOJu0YyWiwpgARwNPpJR0MX/87i//2kiDzKL7y51Z4SmCgE3dS4rWvVv
	M6g+ZAWE2QhrvpvmZWLGTepHkQ==
X-Google-Smtp-Source: AGHT+IF2IedF5khzSjWIdq9WdGnrZ4lGHls0+/nNVyfAItE6mVU692/esFE6K3zaUERbjQR9pfYQFQ==
X-Received: by 2002:a17:902:8694:b0:1d0:bcb2:b914 with SMTP id g20-20020a170902869400b001d0bcb2b914mr428871plo.129.1702057738204;
        Fri, 08 Dec 2023 09:48:58 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001d1d5fb96f9sm1971537pls.27.2023.12.08.09.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:48:57 -0800 (PST)
Message-ID: <e4b660af-5122-4621-918e-252e481adf54@mojatatu.com>
Date: Fri, 8 Dec 2023 14:48:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] net/sched: cls_api: conditional
 notification of events
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 vladbu@nvidia.com, Jiri Pirko <jiri@nvidia.com>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-6-pctammela@mojatatu.com>
 <20231207205939.GI50400@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231207205939.GI50400@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/12/2023 17:59, Simon Horman wrote:
> On Wed, Dec 06, 2023 at 01:44:16PM -0300, Pedro Tammela wrote:
>> As of today tc-filter/chain events are unconditionally built and sent to
>> RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
>> before-hand if they are really needed. This will help to alleviate
>> system pressure when filters are concurrently added without the rtnl
>> lock as in tc-flower.
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> Thanks Pedro,
> 
> my comment below notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>   net/sched/cls_api.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index 1976bd163986..123185907ebd 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -2053,6 +2053,9 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
>>   	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
>>   	int err = 0;
>>   
>> +	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
> 
> I don't feel strongly about this, but
> as the above condition appears 3 times in this patch,
> perhaps it could be a helper?

I noticed that some of these functions will never call with unicast set 
to true (delete routines). So I will append a patch that removes it.
So this pattern will hopefully bet not repeating enough for a macro :)

> 
>> +		return 0;
>> +
>>   	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>>   	if (!skb)
>>   		return -ENOBUFS;
>> @@ -2082,6 +2085,9 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
>>   	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
>>   	int err;
>>   
>> +	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
>> +		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
>> +
>>   	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>>   	if (!skb)
>>   		return -ENOBUFS;
>> @@ -2906,6 +2912,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
>>   	struct sk_buff *skb;
>>   	int err = 0;
>>   
>> +	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
>> +		return 0;
>> +
>>   	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>>   	if (!skb)
>>   		return -ENOBUFS;
>> @@ -2935,6 +2944,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
>>   	struct net *net = block->net;
>>   	struct sk_buff *skb;
>>   
>> +	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
>> +		return 0;
>> +
>>   	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>>   	if (!skb)
>>   		return -ENOBUFS;
>> -- 
>> 2.40.1
>>


