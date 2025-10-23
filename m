Return-Path: <netdev+bounces-232184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EECC022E7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27EBB508E90
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18733B97E;
	Thu, 23 Oct 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Ly6rUpVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F233C504
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233955; cv=none; b=adHWNR5I3TGvmiKsmuoyfvK+UrWETpb+0iMbyx2l0CAGLv65W0smgHGxZstLT+g1FauNvd9372KCjar7rKeZdp5wSSJvnBBQUNWzLHVa9lMMjhsWBbTnuhGb27E8+0upc9a6aZFm4o1V8SeiKSlNf0k7n+xhskOOYS1mtAwHbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233955; c=relaxed/simple;
	bh=m48FPyq3hS5hTCmbr8c8h/LHH2v+gSJH4SwXZ6Zsgeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbpPjke6AAx/pn8Lwk4NMld6JvUi5z6i6OVRAPj1zKyKHAOLG8ATOfe6JPsP+Fqd9lRIHsCcq5xGTaWdszBYe+6f+KFH+hQ1CmEF1GfECL2BYvSJMdB2D25mopsTcV0rXfVVwzDwTc5ShHoPsDn8NZFrzakKFo6aO74kkJgp+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Ly6rUpVw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426ff579fbeso136076f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761233951; x=1761838751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm3nq9zl8vSP9OQckXLMLZC8gBiYgr978W9DuCmvOUw=;
        b=Ly6rUpVwZqT9BiCA8oyv1CXYwaenFYkmLRQFuMS+pKs/O/AP7s6Ek5vJsiMWR97/kO
         qsNAxfVbUpd9ZmzrzO8RWoFxbDpxy8qCCtKAmrbjPk/XUlKW4EiOr+CwLr+qyQA+Rz76
         32JeP3erTDEOvBVGMGgZFcAZ6RdFoIfoawsvBsfkq/0UqXcsml5vVSCnGKTyHrWVvjZZ
         qZ/DZoMhClMDvm9GTRptGX9wuIfQxe8fnXEl2gCIbW2hgOinfo09tpntonoEaz7n4zeF
         KtxW+drv6qGJrP50LpdKiishyGumgvgSFja+XuuABmRMLhvE+3DCH8CXPfFU3+uQvuoI
         CwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233951; x=1761838751;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm3nq9zl8vSP9OQckXLMLZC8gBiYgr978W9DuCmvOUw=;
        b=FPjsDWzMnqalT8LxK/Tf+ffKJWi8hGMNjGIVcZKYZbZChRmwCAZ8pKVVuYStaAocOQ
         WgcWszwWHD64rDQF2itZMENjAGPJNx8Zs9RrRk5LlGHozEkepZCHBqXTlClSTXYA8sxC
         w//VGPOgCVNF182X6FQyrpD7zpTZqp4Y2ZxdL2mZ2S1Q92wMp6zGKhf9xXH0i4XczpUQ
         /y4R+hkTYwkqnO+OksOn1lUOrMBFKnj/i0Z6+v0HENVhIXKktYvOzNPw7/j8QNLoLQ+2
         b8Hqkxgv8IPrGCnQcK4R5eJCnFwldutWUuVl3B7FaKDUUUTZrQB10FDq3cDpXnGuwUm/
         ImDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhp2Of6CBlpoUPifoDiqhni2fqcTpZ3S2BALpjnnyieJ5irDNlomV38Wtld20JppTxxmtD2Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrzRVtE66ilsXxmwpV47RZwvVYrflPGvHnZdXeLUntXbSKVPJ
	RWEB70gulhnzrGc81JQH90xDh/d2d5iAlaru2yPWGLM4Tk/+oT/7aTag0X9i+hWjh5g=
X-Gm-Gg: ASbGncvOMdqHXkQWHEjZhbUJpBwKBpaPad1MvGoppx0mQe5FNcwTqmUoaxqP0X0Ypxp
	y9R8itcbi/fsTe5VPYeoSK/6mugt4gBttG5CJBmiXgi3Pb8HpdbAB33rMqgHHr5lGyIeKOT4lQ8
	LYcILaxWEKOQs5zAMuD6aD4l/rnxBYdm3gSU1rhCJDDoMkP2ZmzDYdTdGHBLXywAMMeRF5Tar54
	BxY3+s3WUldCD5RqFUyESW23QqFkKTob/SBL0voO5nZRXmhLbjbn++R60oi2kZUSPvZmEzLhmve
	M10WR0Qe4RhTQ7NdCPpmFBuT4GmtKmqL9XDqUsJJdyrKL36MuFIyAFUm+mr2IOsy4WseKK+27cZ
	yIJ5ZBQ6ijSKRqRtZnZ9ZeXMSUMnkuLG07j6kCKfwoijjqrqJUip4pTmQ5uO5TyY64X4Aq95Ukv
	Vlx7EaECCy8qGJ/FlsU1F+76SRL9krn/DarN88segcadme6s/xiL8S
X-Google-Smtp-Source: AGHT+IFW67sl60in/eMiQDWOwc8lfrPy3RIhmCwSEmLiHSpg5obyZG5HeVxylRoaEHdc7vld3nqL3A==
X-Received: by 2002:a05:6000:220b:b0:429:8d46:fc5e with SMTP id ffacd0b85a97d-4298d46fdffmr263763f8f.4.1761233951243;
        Thu, 23 Oct 2025 08:39:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm4522926f8f.30.2025.10.23.08.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:39:10 -0700 (PDT)
Message-ID: <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Date: Thu, 23 Oct 2025 17:39:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: toke@redhat.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
References: <20251023083450.1215111-1-amorenoz@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251023083450.1215111-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/10/2025 à 10:34, Adrian Moreno a écrit :
> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
> 
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
> 
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
> 
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/core/rtnetlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8040ff7c356e..88d52157ef1c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	if (rtnl_phys_switch_id_fill(skb, dev))
>  		goto nla_put_failure;
>  
> -	if (rtnl_fill_stats(skb, dev))
> +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
Maybe parentheses around this first condition?

The size could be adjusted accordingly in if_nlmsg_size().

> +	    rtnl_fill_stats(skb, dev))
>  		goto nla_put_failure;
>  
>  	if (rtnl_fill_vf(skb, dev, ext_filter_mask))


