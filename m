Return-Path: <netdev+bounces-110468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A092C845
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357821F232D4
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A78847B;
	Wed, 10 Jul 2024 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D08XuWPk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFB8C1E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577413; cv=none; b=o0+xC7gebR0EryV1e4XOxWE2UCZCP1KZAz6ZoQk2+l5kqpzn0VS2tJpHUcVbjlszn7/alYGrwFgCwDw4dEjIWM4Wxaa7B91XKypT5Quo/O7S3AfTx3AEpXBrV3ZU91FmaUF7/CFwXIeqUEgcUuSBvHt3itnkodZRNLgdJtnzsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577413; c=relaxed/simple;
	bh=GX0piPL1MhZFWw68yikqzdDPxogqYxYWm4WTbQUMit8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfW5PTym+hWHt/vOqX5KCvo1fPDdJObw2K2Uo+a1jYzkS6pY2I71v1+t0JAqG6pb6HgTdpNyTqXTTc9AP7/quIxcg/vKx4dfxP9o02fct6fcvva/LFTKDWJv8O/DUKj6+W4SnJ49obnTB0NOhck4sKWcL5RS6TVb30IaMK+y1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D08XuWPk; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so239391739f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720577411; x=1721182211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFdAWBWmRXyhXvst2JC/tMDmpEOZUJN/A6nE2DsG/0s=;
        b=D08XuWPk23Lj1IvnILnsqRJ+n1uAdtUJzFu66201KsNcUvELlZ8cMvba3zE451/dAA
         TO7JycuIMCWjEV6xRhxIKuoEjt2hhBN7EjFsOAEVVOSEbs3cKo+CFubnVSB2ad/DvA9Q
         ekGnbNPSqrPF3UqAP2bH/SUbV7MKGORzztYR/V/UmdQ4bquMvjihg8nsqaGqt0XWF7fN
         rBgmtW0J7OZMkKJ34W27dZD26otRV/Ajx58S639US77I52LBufgd1TCc1CgAiaIJfBJ9
         iJ5BgrdNX0E5nCnqy5RYAOZt+FbF2MJuAqchM6FkZ8sbchLfLdrNrxgE65rpfvpSTh3/
         S/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720577411; x=1721182211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFdAWBWmRXyhXvst2JC/tMDmpEOZUJN/A6nE2DsG/0s=;
        b=R2xyTB/Iid5t/VhkPvy7LV3nJ2+gM4InFGbU+X5Buu7mpFCDA0BRtBeReaCtVV8tLi
         c3E8helGBJUPRx2ETnVmHC3p9R4aTuPDQi/1xBH1AnL0NZQBpEfAkZv/fIM8jj3AUYjl
         rSb2Kkmf9dReFrYNtxE2+CeOL72eUrj5Zt93QXPQqhet7MnbPRoYYDDl16r2ZdsWY20y
         6rk2ryBjuUvowMKxasiwoinT/9ZkbzO9lNpezgdjphGmaMK7MXyEDIt8o+YuVxkZuUhv
         z4SC+vpLYu2kzQoIwgNE4NGZLjif7hkPlSZPy9zOSf67lUfRWPD/oDhZNzDmVI5vRnU3
         KGSg==
X-Forwarded-Encrypted: i=1; AJvYcCUGkag8eZOll6jFcpVGrbND+H/XhcYGk5c5bpH4REneCfL1T/bTW9KmUYZ7aQDAz0VP2impNu+6qT3vXUsmgKrjNYRvmAZ+
X-Gm-Message-State: AOJu0YwY8rc47Ls71wutBv6T/DbLBSuq3/8SvGlOfQe8jFQJO3G0i+Ln
	g8rbYQTKgrPwf9TrX1sob7U7DtmQt7RjcmVmjoV17MQDzl6cJ38m
X-Google-Smtp-Source: AGHT+IEm34C0OKzHyyhlivQ9xREA7QrGM616BdLXbo497xpDmI36AARulFJyb6f93jGsL7JeklNSIQ==
X-Received: by 2002:a05:6602:6d13:b0:7f6:8282:f4a9 with SMTP id ca18e2360f4ac-80002e40f62mr513825339f.20.1720577411354;
        Tue, 09 Jul 2024 19:10:11 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8da3:78f8:d573:7ac? ([2601:282:1e02:1040:8da3:78f8:d573:7ac])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf7b73sm842084173.101.2024.07.09.19.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 19:10:10 -0700 (PDT)
Message-ID: <5efc180e-b719-4945-bd11-2ca392bde4a8@gmail.com>
Date: Tue, 9 Jul 2024 20:10:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
Content-Language: en-US
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Ido Schimmel <idosch@nvidia.com>
References: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 9:37 AM, Omid Ehtemam-Haghighi wrote:
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 83e4f9855ae1..6202575b2c20 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -540,10 +540,16 @@ static int fib6_dump_node(struct fib6_walker *w)
>  		 * last sibling of this route (no need to dump the
>  		 * sibling routes again)
>  		 */
> -		if (rt->fib6_nsiblings)
> -			rt = list_last_entry(&rt->fib6_siblings,
> -					     struct fib6_info,
> -					     fib6_siblings);
> +		rcu_read_lock();
> +		if (rt->fib6_nsiblings) {
> +			last_sibling = rt;
> +			list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
> +						fib6_siblings)
> +				last_sibling = sibling;
> +
> +			rt = last_sibling;
> +		}
> +		rcu_read_unlock();

as Eric noted fib6_dump_node is already called under rcu_read_lock().

>  	}
>  	w->leaf = NULL;
>  	return 0;


> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 8d72ca0b086d..4bca06dce176 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -415,7 +415,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *sibling, *next_sibling;
> +	struct fib6_info *sibling;
>  	struct fib6_info *match = res->f6i;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -442,8 +442,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
>  		goto out;
>  
> -	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
> -				 fib6_siblings) {
> +	rcu_read_lock();

put a newline after rcu_read_lock() and before _unlock(). Personally, I
like locking calls to 'pop' in the sense they are separate with
whitespace and not run together with other logic. Comment applies here
and other places since you need to respin.

overall, nothing else caught my eye. Added Ido to put this patch on his
radar as well.

> diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh

thanks for the test case.


