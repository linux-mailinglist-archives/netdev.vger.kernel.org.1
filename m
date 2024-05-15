Return-Path: <netdev+bounces-96634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32638C6CCC
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D9AB20ADB
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B3159575;
	Wed, 15 May 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGg//A2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF503C466
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801203; cv=none; b=P/rY2YTvxg/9lQVXMdL5KAKIADRfI9EpwE41HlbbFYO/n9mbDI60lvhUntHXVJJIEixTHfQPCpDBE2rjqesMz9fxMLGGdQDYyp/YoSpr/1fHPUPSpuE6mDnPalNi5NzmDYZZeJ4oJUc9bUv0A2P+uLi8NA+pqe4EM3srTDgEs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801203; c=relaxed/simple;
	bh=cSQVTv2d9BXPFda8vob3Un13SPavHfyDxWtocFcP/BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmexe6fWkLkWTV/gRfM92pSy29yD0v+e8I/ZyDJptWaEB256XZQ1jCqsqhNZ2ntxroazIVqS+ee+5DY3XzNm2Npe8DFJ8vqbpYbVfNMuA34Or1zFFbNXHdbDo53CHcT97mlSClWRdjNjRdRlIUkAdot7k1+dX3/XNwU1L4/rzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGg//A2m; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e1b5173ddcso311306939f.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715801201; x=1716406001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh1X4wxl6umafgg1entrLFlRyYMICGJ0KakJDXOUNEk=;
        b=JGg//A2ms1YCcRs6BfL4xaLBYGZZDvF3MYypCGlnGRSGeGSSoP6aQq212+yzvvMf5w
         0l4OsppgAFNRK1JrIc1SL//OFtoQrBNVJowMVFgRwTiQxIbYSQC0NTLpeFoBl5Oo9S2/
         tFXJYJJhnU3bQPwk2j8tYQRtkgZzttDbBCGlCMdGrco+5BCJKzn/C6/TThENuY1UKzSH
         AZA9/cAFShP9TLlp0RCj482iva38l4PXXwPQhtG2aV+RwT0jFlwfatB9QAv38OUW1B3j
         1cAE1SD/tY3QkZDEPv5oFbAyoenLdAgb7AXkdpuPtJ7fAV1N2kXAzdJLbgaYtP1Ujlo6
         dQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801201; x=1716406001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh1X4wxl6umafgg1entrLFlRyYMICGJ0KakJDXOUNEk=;
        b=DEKXjjF7qjzkN88ZzJvdchcdWJf2Hl5QVMpvVdkPP513ouAALrqLPid/Ay5WEIQ0YS
         WdRZXBHcOP4jPNYUnOdo5vqq/72gbs4c3EBho43VZhZ16+mGK77FOkGUij3wcBcaThA5
         I7ZsG+qhscnJvrKNoT1Ifol/AZzrBNi19UVGXk4nnpg8xE9fnaK2DKnObn5UdTkxPiGI
         rddDTzeEYYMAEEZ/H0YEbA8GbM58W7GctoqONzS+yjXhnFGQ1KVoU93Liaf6xGmP8sy7
         U/Isq9fZq5oLrO6+0hHx3izR5gofs5JuSSWxfU6XcDrZH2BWCxDt8NqdhfAMCXR4Raam
         F49g==
X-Forwarded-Encrypted: i=1; AJvYcCWJhxS9T6Qu6DgB8TRCVeIJrxYWHAMIkaeJI8JlPMyyaJeOE+r/ZJBCg0kBJXyPPfbEyfrar+wF67nnpHOwCvBIRd+OXMLa
X-Gm-Message-State: AOJu0YxbPU/XKPY+RlyRsKzoz136YcRtsW7IA5cvkxjp6xYUneTPeWHP
	3YUmMVTNbdr+jUNZwOO19Fs4yePiD9pSrKmJGulZFHWbfk5nEzvg
X-Google-Smtp-Source: AGHT+IHNGUcUOcu4YNorNPqCQ4+qhMeprgUlUD5T+DCXWk3I5FwJU4bW1CgSnxzwKuo5fv2647Aiow==
X-Received: by 2002:a5e:a507:0:b0:7da:a00d:8b55 with SMTP id ca18e2360f4ac-7e1b521e4d4mr1970933939f.17.1715801200823;
        Wed, 15 May 2024 12:26:40 -0700 (PDT)
Received: from ?IPV6:2601:282:1e81:c7a0:9589:ebc6:34a5:b5f0? ([2601:282:1e81:c7a0:9589:ebc6:34a5:b5f0])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893714d7a7sm3666299173.74.2024.05.15.12.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:26:40 -0700 (PDT)
Message-ID: <a21b8fb8-6615-47a2-89a4-4ba97922bd46@gmail.com>
Date: Wed, 15 May 2024 13:26:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: Fix kernel soft lockup in fib6_select_path
 under high next hop churn
Content-Language: en-US
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Ido Schimmel <idosch@nvidia.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20240514040757.1957761-1-omid.ehtemamhaghighi@menlosecurity.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240514040757.1957761-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 10:07 PM, Omid Ehtemam-Haghighi wrote:
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index c1f62352a481..b4f3627dd045 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1037,7 +1037,7 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
>  	fib6_drop_pcpu_from(rt, table);
>  
>  	if (rt->nh && !list_empty(&rt->nh_list))
> -		list_del_init(&rt->nh_list);
> +		list_del_rcu(&rt->nh_list);

This path is only for the separate nexthop objects (the rt->nh check),
while you seem to be dependent on the legacy IPv6 multipath code.


>  
>  	if (refcount_read(&rt->fib6_ref) != 1) {
>  		/* This route is used as dummy address holder in some split
> @@ -1247,7 +1247,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  							 fib6_siblings)
>  					sibling->fib6_nsiblings--;
>  				rt->fib6_nsiblings = 0;
> -				list_del_init(&rt->fib6_siblings);
> +				list_del_rcu(&rt->fib6_siblings);

If using rcu for fib6_siblings fixes your problem, then all references
should be updated to annotate or use the rcu apis.


>  				rt6_multipath_rebalance(next_sibling);
>  				return err;
>  			}
> @@ -1965,7 +1965,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
>  					 &rt->fib6_siblings, fib6_siblings)
>  			sibling->fib6_nsiblings--;
>  		rt->fib6_nsiblings = 0;
> -		list_del_init(&rt->fib6_siblings);
> +		list_del_rcu(&rt->fib6_siblings);
>  		rt6_multipath_rebalance(next_sibling);
>  	}
>  
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 1f4b935a0e57..485a14098958 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -414,7 +414,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *sibling, *next_sibling;
> +	struct fib6_info *sibling;
>  	struct fib6_info *match = res->f6i;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -441,8 +441,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
>  		goto out;
>  
> -	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
> -				 fib6_siblings) {
> +	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> +				fib6_siblings) {
>  		const struct fib6_nh *nh = sibling->fib6_nh;
>  		int nh_upper_bound;
>  


