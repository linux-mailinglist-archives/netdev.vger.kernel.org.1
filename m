Return-Path: <netdev+bounces-183349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B71A9077E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705B84461D4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50811C5486;
	Wed, 16 Apr 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7OiyDPh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F88A55
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816640; cv=none; b=Gkh/p/gn7XJrbUjX6RirJWP3HlUpbPM7+GAeoJz4RxLboKyecdjeAExqFKx/sQk/U45JyuoRlOwhDeF0yZun3oTqtN8Qt86k3OWfJqa+q2SJ23JT3iS3j2PM+9uiZQhKVUZYAwFSco4q95/rfdSqwcXVqWBY/lQFDHaEtxMDDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816640; c=relaxed/simple;
	bh=E9m39VpjaoO2UK89HpuCoDZc4DqD8OIffnhZl3iF5NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyLqEw5wb/LfybdM41bXH802YOiCzsRdxoDkjFE2/7Xi3CFb6IYdjEUzfvuxUmOIaeSoXy4XGHtJndsuoaRTLqUJL7s5ON2TNKN/yGfLElBWGiYtt3YxT8FRp1MzUcJzDxyhByQ0XHhR9ySFjMxyddkBQQjcpPsIMtZKUo7WcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7OiyDPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744816638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyb6IT/GlLTLyFS4PSRCQTLwmKqQCN/qULSTHgegFvc=;
	b=O7OiyDPhLx7EvUr2ma0HDbVRUywtOtZVX70s5hZFZzr9u7Jl6sz3qg/uXyYfqSHumkGXfM
	Nj1nwFmr8uVndFhXVyNnnCC/kSKTgcs3/Y9IzZ2sPmtz0sOjD4mfj8LdeF+JS6i8Bg+PVw
	FU+LndaWIyuOk2i+UrTk//aNG9Qb8Pk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-i6sNkrkVPF2XaUuCtwtD1w-1; Wed, 16 Apr 2025 11:17:17 -0400
X-MC-Unique: i6sNkrkVPF2XaUuCtwtD1w-1
X-Mimecast-MFC-AGG-ID: i6sNkrkVPF2XaUuCtwtD1w_1744816636
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d22c304adso3943245e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816636; x=1745421436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyb6IT/GlLTLyFS4PSRCQTLwmKqQCN/qULSTHgegFvc=;
        b=XfqWyiRtXz4cO9FE9nPv43963aR14IVerbqAjtX62Z3aEKuFKNVFrkBStrzYm0kIUv
         82eTu7I46k0eowp8PVWeQdJXBepdDPsVQnE2cm10KelxPlSlLHSGn9MVCQ6mnVjnu8zx
         fvzDpu7LAq4QMXRlkNPXQ6/EzSOG65D4+THTZRrkQ8IslQhTjEAiyJ2cnmtwvQpgDSJa
         G/NorhsC2iddUd7QtKSuxiM2Q8pZ5xfDgFBIkNFI39G1JJAIkKqPseHdqCSbLfgyQl4p
         RP1m2/jRp+JknIyavtCyd4vrQ1aLtkUW4h9DLv5dmT+v5S8ijRXDBs/bTwznaPHmjWeo
         qaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVSXFslpE5l2y6z7YaKWA6tuho9/zWfQX5GgpzEK2KvXJiQYjtdaMguaYWOZVbfyTI6U6Fw89k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgjMlCAnO5IU023+PkwtHoOATqWTRRQGA+JeDzTtjo9dF9Khi
	wCGX4aDs14kbo8zcf6ny5ox52i+WvKwlPqh668NX5l1XF27cHfETBj/p58xTRbWj882CMjyLnvA
	ejsgx4jKgnClezjolrW2HwK+4C+vgSBC24Agv/z6/TW8ZHltvX/zO9g==
X-Gm-Gg: ASbGncuZw2obS+TVk+e+vdpuZmoHFodHZc+y0Vn1hEbZDluoZVyVgSm03ozqaCAx62l
	JI7ftqtgNSXErAuQ1h+0RWTPxdO4Bnc5izt9DCw8+qymrIySGKFBQ1IWOniRPQrNEYtljauctgZ
	7qTog8EcrtK38gv4spsFxy2Ws69r5j0tShJtX6B5SIRNcEPLM5WvTERrGzyFSVUfa2bGT/JZQ/z
	d5YRDli170b9lGJqO9JBk/eTVrkEY1VOqB0FueIcot/5NayQuoIvQss3W+3G8UM54vrqRJ0xe/r
	SAwwJGOumkJitWzZzMVzx5GJ+mU2g+fjwLr0fKc=
X-Received: by 2002:a05:6000:2d05:b0:39c:e0e:b7ea with SMTP id ffacd0b85a97d-39ee5ee252emr1994818f8f.20.1744816635837;
        Wed, 16 Apr 2025 08:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7sy4HeTf3I+4G20lNHIE4gYzW8syJq/82FLKaR2otxRPzgDr6Wg/EaOYMz6OLmcINBHP2bw==
X-Received: by 2002:a05:6000:2d05:b0:39c:e0e:b7ea with SMTP id ffacd0b85a97d-39ee5ee252emr1994787f8f.20.1744816635431;
        Wed, 16 Apr 2025 08:17:15 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963c15sm17868947f8f.13.2025.04.16.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:17:15 -0700 (PDT)
Message-ID: <36c2a487-4f74-4be3-af66-0dadd1538c64@redhat.com>
Date: Wed, 16 Apr 2025 17:17:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 13/14] ipv6: Protect nh->f6i_list with
 spinlock and flag.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-14-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-14-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:15 PM, Kuniyuki Iwashima wrote:
> @@ -1498,7 +1504,23 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
>  	}
>  #endif
>  
> -	err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
> +	if (rt->nh) {
> +		spin_lock(&rt->nh->lock);
> +
> +		if (rt->nh->dead) {
> +			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
> +			err = -EINVAL;
> +		} else {
> +			err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
> +			if (!err)
> +				list_add(&rt->nh_list, &rt->nh->f6i_list);
> +		}

Maybe move the new check and list_add inside fib6_add_rt2node() or
bundle all the above in a new helper?

/P


