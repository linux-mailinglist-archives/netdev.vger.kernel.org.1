Return-Path: <netdev+bounces-183205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A3EA8B648
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B845A355C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2705241681;
	Wed, 16 Apr 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3JO/kKc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D6237186
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797450; cv=none; b=DfLo5G6BFCogcWOkE6pfVSO3t1EAnb6AHAAWQUb2WtHrZeXCD39MLBy8cIlC6NeAZj9+235WWyGyU78q3KLvgAoXtHD5TErKwyVabJ517A99ZLbF6KR9s47PMs8Lvja/QcQ3dpCDkACbD20ueTTTYYH1ev4MGtlUmGKrGL3nFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797450; c=relaxed/simple;
	bh=IGYhZNRAwMnjGB4VmCpjX141Ek5+hdy6KimBsGTC2ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyre7KB41I+ix20kRk+Q/agF6F8lWlkeUOxEZCDGjgkDBQj24sFZEkQY/CCY0M69r+tEd70tOL3skCFgZ1Wd1nd5l8a2kVIxE9uL4rR5Hj5HSzhVDtktHoOMSMBRmcB0HndDNrff93jJYcKh8+iwPkmJ4VaYl+BhnihSzHcYGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3JO/kKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744797447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/xc/nuTCCFwa/m4E/cXK10OwMX3zR6vXhX1Jh7hiL8=;
	b=O3JO/kKc7jjHtLxEsTkxyU8CNi/NNJ+rnZumS7gkyyqBlywxeFnyKnlk1+7xltaudVX2/P
	jhoEx0jlN2tvK6wWzRqv6ilh6QHvxllOBGd8aJCrLgwl1m83vjwFExgvOtaGUsCtDyX2o7
	UTQr9AebRbqfxpTG7Kp+vCdPNzxO5nU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-MGV5hjS8OeCP8qsNFCAp4w-1; Wed, 16 Apr 2025 05:57:26 -0400
X-MC-Unique: MGV5hjS8OeCP8qsNFCAp4w-1
X-Mimecast-MFC-AGG-ID: MGV5hjS8OeCP8qsNFCAp4w_1744797445
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d08915f61so38539235e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797445; x=1745402245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/xc/nuTCCFwa/m4E/cXK10OwMX3zR6vXhX1Jh7hiL8=;
        b=Ln+tZABEYczccyWcXDX2QsUOlYGNq66Kk65vmEuZXNEksq8Zdxrmup0AfjWi22He10
         dHGyqd1nLJt5HT9DG+NVtbdewtDx1USaK7LKpviwUiet6ym9CiJ6nhHv2P4gPEIK6Hdc
         1QtAR3DPfw5EI0JLQsasjfP2NyxOTks+7A+v9R1F/eYI2GbBokrnFplMTYy/SiFhCl2e
         KJCPnkFMkrtqkAscvAzuLDhxGjMfgum8XDob1sJ9XmzP9mk7bK9b6il9BBLLDnhF3gXQ
         ztdwjrHSMwGecXmBpyZfWnX9fUqZpK2fjW87pXH5eGLKLnw5HaTGnUdOgDUbN59ofNPI
         U69w==
X-Forwarded-Encrypted: i=1; AJvYcCX7OMlkClwb4+nGcTVZPo6PMCo2PLAy4YMyTHKi944l4EBPAIV24Xr7LBT2whq+hQwFxkcMWa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlO90q5YdNc6nbeGYZUir3pzoKZCgoaubeNp84FCwfRm4hP1J
	eMI/m/PdmxegfnWYyHbyxSpBVPLSsamHMjAySatkhk9DouVRgh2npCl6DO3ISZ2nns6syAm2GYv
	JZbT7jSbDgITKd9Ux2RFPGurWMWCuWGnwg/ogWDKH9HhShu1MzOMtIQ==
X-Gm-Gg: ASbGncvizw/lW34anxymhAtjrxBC/Oza7jd7GWiXWKwYIb7DKuQKkIUpRIfhrIXssao
	IEhh799uWjnpV/lmYqoejuVjP5r4PWYrkmWfREXlEP8Byt1NzbdDwW6gryM4znTxDzC/AjAuAke
	mo232d1OvXG0c11h+L8Dy6uMmEh+19PQuUGR6HjIsVe0okMxVw0H2KQRq9CPy7nvrQZ1snLA9Ty
	+jhHL5iM19dLePcAbhHm52MoPjPUmthvY/ahLuetCoLgvwfNYYH5fHtp9ANOkF2y+mKpCSUiZ6M
	sNN/XFo5Ojq2IDIwMjRTnredG40PDXzfNFWYASA=
X-Received: by 2002:a05:600c:3d0a:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-4405d62773dmr14071595e9.15.1744797444937;
        Wed, 16 Apr 2025 02:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEu5aphSLSLjKUkLkOfXLho1fHF8HQeDhk0u+Agx4Eqc7CCJUXdai4sWV9MvJWlocFoBC/lg==
X-Received: by 2002:a05:600c:3d0a:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-4405d62773dmr14071245e9.15.1744797444546;
        Wed, 16 Apr 2025 02:57:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b50b964sm16015505e9.27.2025.04.16.02.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:57:24 -0700 (PDT)
Message-ID: <c9bee472-c94e-4878-8cc2-1512b2c54db5@redhat.com>
Date: Wed, 16 Apr 2025 11:57:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 10/14] ipv6: Factorise
 ip6_route_multipath_add().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-11-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-11-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 49eea7e1e2da..c026f8fe5f78 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -5315,29 +5315,131 @@ struct rt6_nh {
>  	struct fib6_info *fib6_info;
>  	struct fib6_config r_cfg;
>  	struct list_head next;
> +	int weight;
>  };
>  
> -static int ip6_route_info_append(struct list_head *rt6_nh_list,
> -				 struct fib6_info *rt,
> -				 struct fib6_config *r_cfg)
> +static void ip6_route_mpath_info_cleanup(struct list_head *rt6_nh_list)
>  {
> -	struct rt6_nh *nh;
> -	int err = -EEXIST;
> +	struct rt6_nh *nh, *nh_next;
>  
> -	list_for_each_entry(nh, rt6_nh_list, next) {
> -		/* check if fib6_info already exists */
> -		if (rt6_duplicate_nexthop(nh->fib6_info, rt))
> -			return err;
> +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> +		struct fib6_info *rt = nh->fib6_info;
> +
> +		if (rt) {
> +			free_percpu(rt->fib6_nh->nh_common.nhc_pcpu_rth_output);
> +			free_percpu(rt->fib6_nh->rt6i_pcpu);
> +			ip_fib_metrics_put(rt->fib6_metrics);
> +			kfree(rt);
> +		}
> +
> +		list_del(&nh->next);

Somewhat unrelated, but the field 'next' has IMHO a quite misleading
name, and it would be great to rename it to something else ('list'),
could you please consider including such change?

Thanks,

Paolo



