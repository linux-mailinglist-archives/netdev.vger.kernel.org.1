Return-Path: <netdev+bounces-156647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD3A073A4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497F53A570C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD815204C3C;
	Thu,  9 Jan 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWzjDjC8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9642594BA
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419575; cv=none; b=gltNcUBXIYfTJqtzbo9Q4Oc+R7RjAP+8pIao+y+P2Sz5MvT8RKHpeP6q+BvP1wk+tsnT/nL49UyiR1rUgEP00sTBZ/QhGkoOhB8nOObbjjbPklY6NoD7H6k/1ixAhynrzC3omMVku2LqgyXcrHmeiJBr370eBHL+8tFo2GJpsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419575; c=relaxed/simple;
	bh=ximbtAUwJR7jZa+BpiHI5ZiCSMfIizcjU7aeh29wekY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7P/JuXp4qU59cHw49fVmRspWC8HDlmR6U5OqS8UbTkDfVVqNtVv6bpGSHwpu6ZmR4ZJIBuYGeNb3i9gIjaWsHwwEYGaj+btwhAYM4dAT2yJmO0ztc0+OKSahadnZAhbk2ZvCEJxPEkbpv8lW6luSm4h6PjSKpxIIdb5zH1pLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWzjDjC8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736419572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ODZ7Mw/IPxuJJXv6/DpD9mSnnSx7QDhpUfClTuqggc=;
	b=iWzjDjC8c4huQE2mXUWRmyKZncVTsxRYWgpCZOdbejJpsp7M5Cg9kXI7pnk272lJ4boOTn
	EbpXFF763P7++bqPODSaAwdFaNYYgQdj+MqyTfOPjcqrgJAbgx6kYfVrnVL7C93uzUued5
	FWrgnrVzr0VPfLgwWZsMNGe1C68Top0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-vMqO0_nwPQCd25uh9mjkRg-1; Thu, 09 Jan 2025 05:46:11 -0500
X-MC-Unique: vMqO0_nwPQCd25uh9mjkRg-1
X-Mimecast-MFC-AGG-ID: vMqO0_nwPQCd25uh9mjkRg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6dcccc8b035so13842116d6.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 02:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419571; x=1737024371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ODZ7Mw/IPxuJJXv6/DpD9mSnnSx7QDhpUfClTuqggc=;
        b=Qgudn0cH3PJIWhl2Vb7xMpey8yHAk7IxLwd3kkE/iK7VhwHNu+ZYWil0HfYimCkFjp
         iaINcRMC/34KdPDRjmHKhGIBsbHYhhZ31pjUweC9DtiQz6jl4fmX0bvXJlQ60d/hwi2Z
         uGKJx49FedYlerT2Y5/6U/YvwBfZyw8IQPuwhw8cEG92CJsbqYW0/RFPZyI03xH8eEkk
         ELzRDH1vYnjFJtP56OJFewATkvQQ/eAqLar4pKyoeuiijMrMUaTH115DegT6H5RTDSH/
         bRtE7cdSFFtOEAxWRXmTvJB7PahmR0djBugHasCa8KCgxDslORC0w6pFi4nZFDmlzpAG
         36xA==
X-Forwarded-Encrypted: i=1; AJvYcCVAXcY6XNHABwb/tkrL9Hds35vShZaxMzHFZQNfzZMiqhoU2pMTZtoqAB2O3viuGXZ0Y0U+Mi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwkgIco0dZMufIQSrupDYPJIEHO+pPHRscpYS0iJ+mzpdlVcd
	NDmmf+eA66lN+hGh8bwJwWGxwaMvRvi+nQpAtrrtoczmZw1LvFB4WUZZNyiQZm98vyAJSxf73eM
	4xxr4pbMW0dzeVpM1WiGBTEaqbX6VOe6pn3LQmknRbSyX4CRukh08iw==
X-Gm-Gg: ASbGncu4NCF8HEHkWRLZr13VneR5egyDOtCdqDCF3po5/iYhkg+80Z4jZAo4FqozR3/
	kDHqwbrZwnIXFelXnYMzOezGdJsWnPJd8vxYcCvV40zxcGl66xa+0X1jBvg5sVaarv1eG+pAhsU
	gfFOOrDy83KF+JwViHwO52zK0T/62q1k4AYs1PKwhs2M+68701FMop93fYAWDi4IGQJnAoOJF8u
	3y8exBNxAJ+zXgaUelGu76TQoAX96KpPogxaT/t83wBm4+JhenOwiu7LMMXxF39UITNVivRflG7
	jio0msEO
X-Received: by 2002:a05:6214:5502:b0:6d8:9bfa:76dc with SMTP id 6a1803df08f44-6dfa3a7773emr31918856d6.7.1736419570726;
        Thu, 09 Jan 2025 02:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtFYrj4ng0BpyKdjkT+FbJc67Ck9X/xo+Y37ggyn21e4M1QbVxckUPpvibLq/85Tx9x6jbgQ==
X-Received: by 2002:a05:6214:5502:b0:6d8:9bfa:76dc with SMTP id 6a1803df08f44-6dfa3a7773emr31918646d6.7.1736419570389;
        Thu, 09 Jan 2025 02:46:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810d5d5sm200246736d6.43.2025.01.09.02.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 02:46:10 -0800 (PST)
Message-ID: <e20ce5c1-9cd4-4719-9c3b-93ca8a947298@redhat.com>
Date: Thu, 9 Jan 2025 11:46:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: refine software bypass handling in tc_run
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, ast@fiberby.net,
 Shuang Li <shuali@redhat.com>
References: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 4:08 PM, Xin Long wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.
> 
> Previously, filtercnt and skipswcnt were introduced by:
> 
>   Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
>   Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")
> 
>   filtercnt tracked all tp (tcf_proto) objects added to a block, and
>   skipswcnt counted tp objects with the skipsw attribute set.
> 
> The problem is: a single tp can contain multiple filters, some with skipsw
> and others without. The current implementation fails in the case:
> 
>   When the first filter in a tp has skipsw, both skipswcnt and filtercnt
>   are incremented, then adding a second filter without skipsw to the same
>   tp does not modify these counters because tp->counted is already set.
> 
>   This results in bypass software behavior based solely on skipswcnt
>   equaling filtercnt, even when the block includes filters without
>   skipsw. Consequently, filters without skipsw are inadvertently bypassed.
> 
> To address this, the patch introduces useswcnt in block to explicitly count
> tp objects containing at least one filter without skipsw. Key changes
> include:
> 
>   Whenever a filter without skipsw is added, its tp is marked with usesw
>   and counted in useswcnt. tc_run() now uses useswcnt to determine software
>   bypass, eliminating reliance on filtercnt and skipswcnt.
> 
>   This refined approach prevents software bypass for blocks containing
>   mixed filters, ensuring correct behavior in tc_run().
> 
> Additionally, as atomic operations on useswcnt ensure thread safety and
> tp->lock guards access to tp->usesw and tp->counted, the broader lock
> down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
> and this resolves a performance regression caused by the filter counting
> mechanism during parallel filter insertions.
> 
>   The improvement can be demonstrated using the following script:
> 
>   # cat insert_tc_rules.sh
> 
>     tc qdisc add dev ens1f0np0 ingress
>     for i in $(seq 16); do
>         taskset -c $i tc -b rules_$i.txt &
>     done
>     wait
> 
>   Each of rules_$i.txt files above includes 100000 tc filter rules to a
>   mlx5 driver NIC ens1f0np0.
> 
>   Without this patch:
> 
>   # time sh insert_tc_rules.sh
> 
>     real    0m50.780s
>     user    0m23.556s
>     sys	    4m13.032s
> 
>   With this patch:
> 
>   # time sh insert_tc_rules.sh
> 
>     real    0m17.718s
>     user    0m7.807s
>     sys     3m45.050s
> 
> Fixes: 047f340b36fc ("net: sched: make skip_sw actually skip software")
> Reported-by: Shuang Li <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Given the quite large scope of this change and the functional and
performance implications, I think it's more suited for net-next.

> ---
>  include/net/pkt_cls.h     | 18 +++++++-------
>  include/net/sch_generic.h |  5 ++--
>  net/core/dev.c            | 11 ++-------
>  net/sched/cls_api.c       | 52 +++++++++------------------------------
>  net/sched/cls_bpf.c       |  2 ++
>  net/sched/cls_flower.c    |  2 ++
>  net/sched/cls_matchall.c  |  2 ++
>  net/sched/cls_u32.c       |  2 ++
>  8 files changed, 32 insertions(+), 62 deletions(-)
> 
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index cf199af85c52..d66cb315a6b5 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -74,15 +74,6 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
>  	return block && block->index;
>  }
>  
> -#ifdef CONFIG_NET_CLS_ACT
> -DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);

I think it would be better, if possible, to preserve this static key;
will reduce the delta and avoid additional tests in fast-path for S/W
only setup.

> -
> -static inline bool tcf_block_bypass_sw(struct tcf_block *block)
> -{
> -	return block && block->bypass_wanted;
> -}
> -#endif
> -
>  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>  {
>  	WARN_ON(tcf_block_shared(block));
> @@ -760,6 +751,15 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
>  		cls_common->extack = extack;
>  }
>  
> +static inline void tcf_proto_update_usesw(struct tcf_proto *tp, u32 flags)
> +{
> +	if (tp->usesw)
> +		return;
> +	if (tc_skip_sw(flags) && tc_in_hw(flags))
> +		return;
> +	tp->usesw = true;
> +}

It looks like 'usesw' is never cleared. Can't user-space change the
skipsw flag for an existing tp?

[...]
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index d3a03c57545b..5e8f191fd820 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1164,6 +1164,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  		if (!tc_in_hw(n->flags))
>  			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
>  
> +		tcf_proto_update_usesw(tp, n->flags);

Why don't you need to hook also in the 'key existing' branch on line 909?

Thanks!

Paolo


