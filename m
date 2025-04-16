Return-Path: <netdev+bounces-183189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22540A8B527
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390871733BB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2891CAA85;
	Wed, 16 Apr 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBl+vxJS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462221AA1E0
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795298; cv=none; b=eyJrvU6IQDgCg8OQymnP97wAVZx/WK3JpQaMJ6IpMuvCtmsU+Two0Ohi06f3s/KihygGdSj6DIbGfJvLPc3tDQnAZgXNpYlbqUPdoTkGnGqWVva6sTsp7T5mtrTBbIaT0z/WV1BrcIOL+cfVVXPSYZpDKA6YFT/RyJnkTwCyvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795298; c=relaxed/simple;
	bh=/SSJvKIPBQ10smRFeiPRHBNbunQD7dq5ztRzrf71eW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQSvOyxml0gaCKdqhRfZLe6Q15yO1hLbPcUEO1BnTTm7qLBd/o/ymzzmRd/7tr77QBB9M6P4NYm5BsSsgNk2ekPfPdZxs6vLgVb0Hdtn0yznLUtSa85fPMpmZ6oJNR8NiS0Wsnn2JInoPDieKbZniTmNx+oR3vb0/uRzsmi+lIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBl+vxJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744795296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5b7GU9O0bA/HACZHdfM4Fc22r3ufPNmp0aeBLlgbfw=;
	b=LBl+vxJS5+Hm/YB5pYL+Oq86cDlNOXBpMbRnOyZWCgx2EAnNJ8w5Jea9laYsDx6I2QdCtY
	W7d8tn/am6tZBWmN/8ND6gypBTGJftomEblZA1qHd0FtYYG+H716eUGkKjtetWHj82KZmM
	c7cDjV9Jt+WXDk+si4SHXSOywl9Bhxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-5UxvnSEBPoWD6ZQLlfSbZw-1; Wed, 16 Apr 2025 05:21:34 -0400
X-MC-Unique: 5UxvnSEBPoWD6ZQLlfSbZw-1
X-Mimecast-MFC-AGG-ID: 5UxvnSEBPoWD6ZQLlfSbZw_1744795293
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso4055888f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795293; x=1745400093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5b7GU9O0bA/HACZHdfM4Fc22r3ufPNmp0aeBLlgbfw=;
        b=cH6xDwAX/NHw1LbGtlvbHyNHbknxImWWFxgY1ZkhzgxynQbjtS2SgcYjaOo+Sj82Hx
         FT5ADoyd5nnSpC3pwxua0DnA0ncyOtP0vRwb7zxWWCBvbqHFGws9BUT+4ez9FcEjbVnv
         fWoa/omvSnqt/MLxL7wpYlwj04m2Nml4FJaHrGC4JVU5Vblg07pgZkaSbiYag49eqHYT
         iTc4dMIO95I0q6zwOUPIopVRhiSuJ952ReufLsoFMNEG8ek55LR3lBRXrEnP6piVO3ya
         VyFKN/ApXI+ztEnLs81AOSV/v/Q6EJyNJXMfs+OlpvjmLVYuQx7xuGI+4ilP3Q8A/SRC
         ssNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnpBsDkUQA6o+ogZ8QuDm5jixk9Fln/ERQB/pqKBxcr2I52Nk9YL38lCXtH/bEuFomx37MN/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0x8AzkeMLPiT4iO5ZopvJ7BdrwHnYF/Aifn09zyVmL0g9sAnC
	GVzmwLh9LD45N80Uem+XJ2IFsxqIYHPOVBmh2gxj9VbPG/w90wYgJ2j7nv7hfwMrVKwZk3TJvPw
	iTxDMEjJi++zioStLtxmLBLsxD5L4wfV8yh4q1jL2VCtNroaKsR2vYg==
X-Gm-Gg: ASbGncsLQUYY3envfeHQ/glbxKBRQCEZVHSj/gF88ZB3CWApFgbc1whvYqkToeoXDLS
	x9P9tdu4t+woXulm9yUx0ybqCEarFiWqX48Kkhk47haKrJQUM0RRiWDY5fv9f7E5/TvxPZ2M5n3
	L1RBqLRAYDNVn6B1I1xSb9esOyouIRv34onQ0FWHRM0eIGxQ1BOpLZftjpM357iDUb+3GnY7W2j
	nCDarjsy8ITZdaGhsFqHzW8q3DKr+DfFfMnfqGpumMJxeaO3cmtBPAmSdprq6ilvGVuvdDZiqQT
	NPaMFt2L+tuZcheXTpjl83PDsO3s/v0dcr9xOKo=
X-Received: by 2002:a05:6000:1445:b0:39c:30c9:815 with SMTP id ffacd0b85a97d-39ee5b160famr974776f8f.21.1744795293456;
        Wed, 16 Apr 2025 02:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn9rDR0ZW4iJG4gfrFHoZcjQh8J9dMUy0TnHnFkBK+xCzm0+qh4RUm81ieWRC5/bvdZU6F0A==
X-Received: by 2002:a05:6000:1445:b0:39c:30c9:815 with SMTP id ffacd0b85a97d-39ee5b160famr974755f8f.21.1744795293154;
        Wed, 16 Apr 2025 02:21:33 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae97751fsm16431883f8f.41.2025.04.16.02.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:21:32 -0700 (PDT)
Message-ID: <def2c29d-3226-4a64-a7d5-6e03c8d26804@redhat.com>
Date: Wed, 16 Apr 2025 11:21:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 07/14] ipv6: Preallocate
 rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-8-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index ce060b59d41a..404da01a7502 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3664,10 +3664,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>  		goto out;
>  
>  pcpu_alloc:
> -	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
>  	if (!fib6_nh->rt6i_pcpu) {
> -		err = -ENOMEM;
> -		goto out;
> +		fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);

'rt6i_pcpu' has just been pre-allocated, why we need to try again the
allocation here? And if it's really needed why don't rename the new
helper to something more generic and re-use it here?

Thanks,

Paolo


