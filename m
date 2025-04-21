Return-Path: <netdev+bounces-184380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC9A95206
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E593B27BB
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560FD26560B;
	Mon, 21 Apr 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4618cAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2926657C
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243649; cv=none; b=fkb9U6MLE1I09lHPdaotC+D97Vz0LOEqAG+Q9CYm1F6cTZ/NzqRDDT4wBNpbkS1AUbioFBFReZMHtt4B2mpw1NTnU5Q9NKqda6ddqV08LsJXpBSknsEakIHSAeWQoQX0IbR5thLGhD6Lim6PZjAd57z4X0RPO4bM7VN1Wb8dOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243649; c=relaxed/simple;
	bh=Bw+mh5x1d66eHJ3eWvFJFlI7KhtJ9T4KYqhE6JDEdOM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VD2+iEgogAFZL4y1r6nS5h39cJJdbNIfCzLg2J8h+PA66bLfiT4ahsad0baWSH0hfgKW/66KYQfnQ6XSVKdpHVBG3yCaVLkFcY6BsLV1njVeGKHWkL8rDTZYXO8emu8WAf7sFuaKmg4xwFaP2wh4ZWCGAbLOk2TDQTwyjLWEAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4618cAB; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47690a4ec97so42844221cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243646; x=1745848446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=choG9lHCXqU5TlVnJ5m8z33yTbfQv3jZp/5uvguC1BA=;
        b=f4618cABqXK8fsH+MzGppZP6AWBSEHA9wkGZs/T4nKLraFV9hxGXnDR6Gi09UtrwWi
         WCkf7iU6ByIMkLUH1ibwEuQrriOcwvTjuw8mGe1FsYFxztFQmxGAs7Top3UI+9Imez3d
         2rsV4clN233Cm7op+nX3HSqSzgovdIPn1uhZRU8SB3r9uWEJLxSiQkwI3r+NVfDioR4h
         nNo7HNAKidS36oTR6a9oniWIP1t5835+rDtVg8WOzOy6jHJT6Hzg+N9sTAL9YoiEZTow
         M4YkbZwICtCcSf+QDrCSkc8pIe5Bs7ybDzrCvJYr9PsZf+CKyI5KOiiGzgrxA3OUYC2b
         8r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243646; x=1745848446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=choG9lHCXqU5TlVnJ5m8z33yTbfQv3jZp/5uvguC1BA=;
        b=FItVSGBGCZcxTMix9gCKNqphpE5ddtSEt0Dp31Z5tJkAT50zK225ZnICyUtM0pPeo3
         TRAZg+yA0zOVHgYDtfkqQ07GBbQhUQ/Q+x4ldIZU1+pt2NeT0sEycnuHZJpnBVcvvAn3
         YbhUKSMACOUrj0KBwRwPURrVYoBbrs860T3YVRwFEh5fjjU4SDSKhM9WTqlWSjv+ESZs
         lo+L+ngR1yfK7ZQ0eYNIRWmN0Fz0tRu9nTjbsxeQBeHR6gmgH0bC720KgLhKMNSTqK8t
         A7T1WDEqgYjBvWu8YvZTzeAPtGXIoyzmhVyzODv6YJRjHRzwsU97mTFXwUNdOc+Ed1g5
         96VA==
X-Forwarded-Encrypted: i=1; AJvYcCVDt2PnJHiH6bzW7UvPf6cLCcOB0E6W5OPDkBC1fBqpLVoj9M/iywAoUsm+KHKEXLkzVzRLSf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBJJ9NI2dwgsZia01Q/U+Zc58Yc3ObAM7CqiDpP++ApZ6HGbR
	jDHoc6400VgTocbpcHWhctVFJQGAjAxQX1agk7EGVgCK5q1PNbm8
X-Gm-Gg: ASbGncuF32f+4hwviIO0uzmbRUquIvsRabDq3JSvUAeH01Fn6UIVU5n1JIlaltKWXhw
	IbU4uTfZ8+qAI0U/Akb5RVUgBhw4OvlQkaITyzRg8xICG4HEyzYb3rzyipY+fAQhpUqa9mCM9oM
	xEb4ySFz5DxHM0bUzAv8QFhDvFFFcRd0kVOgexpmxQZW5p9DCMb6/vw0fuBpnDomcktB0DN2H+t
	3SjTl+uwOuBBpcg4qZ3Ef4m/mrqMVGpl/SLsAGNJ6J1uKdrEIHedkBPa8vUhS3a5uQrfeXCF0as
	0+JSPsQ46jmAviOS5/7qEf8/wXhtNgm/eumLO/b9FPFDP4xbssqNXmfvfoeCpkVJfNcNeWE2a3U
	PkbYLU0K4XDS48wXR6uPXZPMyYUAx1w0=
X-Google-Smtp-Source: AGHT+IEpBIueYd61qqAtvxQ90Aglgzj5SwQp3fkqRCOjQY59e/LrW0HB97agQaoKegNVu+2MSiP4zQ==
X-Received: by 2002:ac8:5f53:0:b0:472:801:3e74 with SMTP id d75a77b69052e-47aec4b72b0mr185786211cf.41.1745243646319;
        Mon, 21 Apr 2025 06:54:06 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c16dd2sm42149771cf.14.2025.04.21.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:54:05 -0700 (PDT)
Date: Mon, 21 Apr 2025 09:54:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 idosch@nvidia.com, 
 kuniyu@amazon.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <68064dfd68775_32bae8294e1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 2/3] ip: load balance tcp connections to single
 dst addr and port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Load balance new TCP connections across nexthops also when they
> connect to the same service at a single remote address and port.
> 
> This affects only port-based multipath hashing:
> fib_multipath_hash_policy 1 or 3.
> 
> Local connections must choose both a source address and port when
> connecting to a remote service, in ip_route_connect. This
> "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> simplify ip_route_{connect,newports}()")) is resolved by first
> selecting a source address, by looking up a route using the zero
> wildcard source port and address.
> 
> As a result multiple connections to the same destination address and
> port have no entropy in fib_multipath_hash.
> 
> This is not a problem when forwarding, as skb-based hashing has a
> 4-tuple. Nor when establishing UDP connections, as autobind there
> selects a port before reaching ip_route_connect.
> 
> Load balance also TCP, by using a random port in fib_multipath_hash.
> Port assignment in inet_hash_connect is not atomic with
> ip_route_connect. Thus ports are unpredictable, effectively random.
> 
> Implementation details:
> 
> Do not actually pass a random fl4_sport, as that affects not only
> hashing, but routing more broadly, and can match a source port based
> policy route, which existing wildcard port 0 will not. Instead,
> define a new wildcard flowi flag that is used only for hashing.
> 
> Selecting a random source is equivalent to just selecting a random
> hash entirely. But for code clarity, follow the normal 4-tuple hash
> process and only update this field.
> 
> fib_multipath_hash can be reached with zero sport from other code
> paths, so explicitly pass this flowi flag, rather than trying to infer
> this case in the function itself.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/net/flow.h  |  1 +
>  include/net/route.h |  3 +++
>  net/ipv4/route.c    | 13 ++++++++++---
>  net/ipv6/route.c    | 13 ++++++++++---
>  net/ipv6/tcp_ipv6.c |  2 ++
>  5 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/flow.h b/include/net/flow.h
> index 2a3f0c42f092..a1839c278d87 100644
> --- a/include/net/flow.h
> +++ b/include/net/flow.h
> @@ -39,6 +39,7 @@ struct flowi_common {
>  #define FLOWI_FLAG_ANYSRC		0x01
>  #define FLOWI_FLAG_KNOWN_NH		0x02
>  #define FLOWI_FLAG_L3MDEV_OIF		0x04
> +#define FLOWI_FLAG_ANY_SPORT		0x08
>  	__u32	flowic_secid;
>  	kuid_t  flowic_uid;
>  	__u32		flowic_multipath_hash;
> diff --git a/include/net/route.h b/include/net/route.h
> index c605fd5ec0c0..8e39aa822cf9 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -326,6 +326,9 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
>  	if (inet_test_bit(TRANSPARENT, sk))
>  		flow_flags |= FLOWI_FLAG_ANYSRC;
>  
> +	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !sport)
> +		flow_flags |= FLOWI_FLAG_ANY_SPORT;
> +
>  	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
>  			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
>  			   src, dport, sport, sk->sk_uid);
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index e5e4c71be3af..685e8d3b4f5d 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2037,8 +2037,12 @@ static u32 fib_multipath_custom_hash_fl4(const struct net *net,
>  		hash_keys.addrs.v4addrs.dst = fl4->daddr;
>  	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_IP_PROTO)
>  		hash_keys.basic.ip_proto = fl4->flowi4_proto;
> -	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT)
> -		hash_keys.ports.src = fl4->fl4_sport;
> +	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT) {
> +		if (fl4->flowi4_flags & FLOWI_FLAG_ANY_SPORT)
> +			hash_keys.ports.src = get_random_u16();
> +		else
> +			hash_keys.ports.src = fl4->fl4_sport;
> +	}
>  	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
>  		hash_keys.ports.dst = fl4->fl4_dport;
>  
> @@ -2093,7 +2097,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
>  			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
>  			hash_keys.addrs.v4addrs.src = fl4->saddr;
>  			hash_keys.addrs.v4addrs.dst = fl4->daddr;
> -			hash_keys.ports.src = fl4->fl4_sport;
> +			if (fl4->flowi4_flags & FLOWI_FLAG_ANY_SPORT)
> +				hash_keys.ports.src = get_random_u16();
> +			else
> +				hash_keys.ports.src = fl4->fl4_sport;
>  			hash_keys.ports.dst = fl4->fl4_dport;
>  			hash_keys.basic.ip_proto = fl4->flowi4_proto;
>  		}
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 945857a8bfe3..39f07cdbbc64 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2492,8 +2492,12 @@ static u32 rt6_multipath_custom_hash_fl6(const struct net *net,
>  		hash_keys.basic.ip_proto = fl6->flowi6_proto;
>  	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_FLOWLABEL)
>  		hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
> -	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT)
> -		hash_keys.ports.src = fl6->fl6_sport;
> +	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT) {
> +		if (fl6->flowi6_flags & FLOWI_FLAG_ANY_SPORT)
> +			hash_keys.ports.src = get_random_u16();
> +		else
> +			hash_keys.ports.src = fl6->fl6_sport;
> +	}
>  	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
>  		hash_keys.ports.dst = fl6->fl6_dport;
>  
> @@ -2547,7 +2551,10 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
>  			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
>  			hash_keys.addrs.v6addrs.src = fl6->saddr;
>  			hash_keys.addrs.v6addrs.dst = fl6->daddr;
> -			hash_keys.ports.src = fl6->fl6_sport;
> +			if (fl6->flowi6_flags & FLOWI_FLAG_ANY_SPORT)
> +				hash_keys.ports.src = get_random_u16();

I missed the __be16 endianness here and in the related cases

That'll teach me to forget running

    make C=2 CF=-D__CHECK_ENDIAN__ net/ipv4/route.o [...]


> +			else
> +				hash_keys.ports.src = fl6->fl6_sport;

