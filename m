Return-Path: <netdev+bounces-149730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B569E6F5E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928D1280D3A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7221FCCFB;
	Fri,  6 Dec 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/T9W2/1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E563224EA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492143; cv=none; b=qlUTKgUO1CFtT4z0GEjfcsq+hgyKsSyTYIBqkI8q0E+XYjW6JtpYu4RhvOXWAK33FG4tBpNdabPIFRnHNXMhDK+JST6oXduw8rhe+j1iBO7GZ9U3srn77BXi/ESefgx41WJIk4dkcTSNOclbrOm2yIYLKlwFW7bBsSRrqcdxxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492143; c=relaxed/simple;
	bh=095siAejmxAOs+GUJv7fh487ksLNwTgmHhIX038Ewkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pmuqn+huStcm4E0vQKBKDjjYDW4TZO6yLc0AuycAC0eCs36lnK6ob2uv7GoOIWLGO7z4+cxZzC6Z0fWLGrfhrOMd2q5FoMfAPG8YBFNh1kgnCovK9HTCZB/F8xRBXm6k6xt9mSmbwTjNuJdDMdWFCyKeYtrWETU4Ur7RA9crKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/T9W2/1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733492140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9t7/gJ7TNAIQYMhwtJpuhL9l6ovQ83J3J+6uZ1t9mMk=;
	b=P/T9W2/1svRkfD8wsz8Qf1mlZHMIMPowphv8FoFWqsg6vzwYlGRESsWoBepIP4ZWc2GGD+
	bCoagz/dKzyKJlgT/fTeoZAhA4cX8UZJA7oe4DxqM+Vfapjri0drqz6wvM9pYvQPaALqWv
	dc9/15jsh1XY4bfuP9MUdnNYds++zvw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-KK1WLorrMjeX8c_5DPkyQg-1; Fri, 06 Dec 2024 08:35:39 -0500
X-MC-Unique: KK1WLorrMjeX8c_5DPkyQg-1
X-Mimecast-MFC-AGG-ID: KK1WLorrMjeX8c_5DPkyQg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a0bf9914so954005e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733492138; x=1734096938;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9t7/gJ7TNAIQYMhwtJpuhL9l6ovQ83J3J+6uZ1t9mMk=;
        b=rbWrcLFUyiT7r/G+FzVuVdwXONTSnMq0F6iacjpsgzD+hmizE4QQbxG9Q0SOXZSKby
         699t0di34mL7OTgDRi1VDGwYPOWbVZksX1lmiXC1sB5r5FivjNmutHDFi3dwWHDw4KpT
         Ri+BfW5MnVXNBLToxrxxQzNSQua4kMEk3o3PORvOBRTT2wl5DdQyPBGBd/6JKVBPuBGu
         zAJ9D/VBRdwq9CW8YVMcZ6SQO+5sHPKKvSWPHtkI59C5cZpGld5Ps5BpV+l2nRFsa27Y
         BDTbHlwH/sabCQcHFiDkkk6pL8C76NbL4/oUwNnRl9g2BHEkblDVkK+KyeWbTTZiUmXu
         TyEw==
X-Forwarded-Encrypted: i=1; AJvYcCUinbI963SGzDzmCt8pd5k4vTGClT6GbllwGpDf06+7SccBdGA+mefAIZ3O7b5BhYo0sj13j/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ilFmdJm2yWKlAFlFBthgwkByVoyz1Kr3uS3EpWDadBzL0dcg
	8kdNzBiqLrcSWcxPHwHi/ceN7TyeWdhI22zKINbEk1BncDEN06NukJXgIlKws9cGcR6xs4dCCym
	yBPgZSTrJjpo07yYQ2QYHF5FyQ5y8jKv6SNFR3bUdfhGWimrfjJq1Vw==
X-Gm-Gg: ASbGncswi5IFynOnXnt7CmKW2PAWi3dEfMOjDxyB2LOubCJOJJ9Z4/s/rAPTpH0CGLr
	qVeD/P1luknSwsW04m1uQ5bduyjjROl4R0Wcs/6n9PweAf2Sh0Vn5tGbre9u8VhBdB8KQAh9o/Y
	y6x1HqIUkBVjblxudozW9U22i/HJ4+Vj4TAc1TggunlMqqfyyw/YLi/cl8zZRyS6/0rO8Oeg7iX
	BbAHOHGubc/8CW3W9KX4gH/fywrOIu2VVcPD2bMDBIxkRX3zSod5Zk8hXYYWw==
X-Received: by 2002:a05:600c:3c9c:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-434ddeb49bcmr28198795e9.9.1733492137733;
        Fri, 06 Dec 2024 05:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdIJbkb1TqsLLPVhWngKIQPuIxDxtq/eOVhZPA4w6YunCgXTMsLiWMamG6QEPM5tmaTJIctA==
X-Received: by 2002:a05:600c:3c9c:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-434ddeb49bcmr28198545e9.9.1733492137380;
        Fri, 06 Dec 2024 05:35:37 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cad51sm92807595e9.36.2024.12.06.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:35:36 -0800 (PST)
Date: Fri, 6 Dec 2024 14:35:35 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Paul Holzinger <pholzing@redhat.com>, Philo
 Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, Fred
 Chen <fred.cc@alibaba-inc.com>, Yubing Qiu
 <yubing.qiuyubing@alibaba-inc.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and
 rehash socket atomically against lookup
Message-ID: <20241206143535.3e095320@elisabeth>
In-Reply-To: <e02911ae-3561-48be-af92-c3580091015f@redhat.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
	<20241204221254.3537932-3-sbrivio@redhat.com>
	<fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
	<20241205165830.64da6fd7@elisabeth>
	<c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
	<20241206115042.4e98ff8b@elisabeth>
	<e02911ae-3561-48be-af92-c3580091015f@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 13:36:47 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/6/24 11:50, Stefano Brivio wrote:
> > On Thu, 5 Dec 2024 17:53:33 +0100 Paolo Abeni <pabeni@redhat.com> wrote:  
> >> I'm wondering if the issue could be solved (almost) entirely in the
> >> rehash callback?!? if the rehash happens on connect and the the socket
> >> does not have hash4 yet (it's not a reconnect) do the l4 hashing before
> >> everything else.  
> > 
> > So, yes, that's actually the first thing I tried: do the hashing (any
> > hash) before setting the address (I guess that's what you mean by
> > "everything else").
> > 
> > If you take this series, and drop the changes in __udp4_lib_lookup(), I
> > guess that would match what you suggest.  
> 
> I mean something slightly different. Just to explain the idea something
> alike the following (completely untested):
> 
> ---
> diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> index cc6d0bd7b0a9..e9cc6edbcdc6 100644
> --- a/net/ipv4/datagram.c
> +++ b/net/ipv4/datagram.c
> @@ -61,6 +61,10 @@ int __ip4_datagram_connect(struct sock *sk, struct
> sockaddr *uaddr, int addr_len
>  		err = -EACCES;
>  		goto out;
>  	}
> +
> +	sk->sk_state = TCP_ESTABLISHED;
> +	inet->inet_daddr = fl4->daddr;
> +	inet->inet_dport = usin->sin_port;
>  	if (!inet->inet_saddr)
>  		inet->inet_saddr = fl4->saddr;	/* Update source address */
>  	if (!inet->inet_rcv_saddr) {
> @@ -68,10 +72,7 @@ int __ip4_datagram_connect(struct sock *sk, struct
> sockaddr *uaddr, int addr_len
>  		if (sk->sk_prot->rehash)
>  			sk->sk_prot->rehash(sk);
>  	}
> -	inet->inet_daddr = fl4->daddr;
> -	inet->inet_dport = usin->sin_port;
>  	reuseport_has_conns_set(sk);
> -	sk->sk_state = TCP_ESTABLISHED;
>  	sk_set_txhash(sk);
>  	atomic_set(&inet->inet_id, get_random_u16());
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 6a01905d379f..c6c58b0a6b7b 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2194,6 +2194,21 @@ void udp_lib_rehash(struct sock *sk, u16 newhash,
> u16 newhash4)
>  			if (rcu_access_pointer(sk->sk_reuseport_cb))
>  				reuseport_detach_sock(sk);
> 
> +			if (sk->sk_state == TCP_ESTABLISHED && !udp_hashed4(sk)) {
> +				struct udp_hslot * hslot4 = udp_hashslot4(udptable, newhash4);
> +
> +				udp_sk(sk)->udp_lrpa_hash = newhash4;
> +				spin_lock(&hslot4->lock);
> +				hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
> +							 &hslot4->nulls_head);
> +				hslot4->count++;
> +				spin_unlock(&hslot4->lock);
> +
> +				spin_lock(&hslot2->lock);
> +				udp_hash4_inc(hslot2);
> +				spin_unlock(&hslot2->lock);
> +			}
> +
>  			if (hslot2 != nhslot2) {
>  				spin_lock(&hslot2->lock);
>  				hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
> ---
> 
> Basically the idea is to leverage the hash4 - which should be not yet
> initialized when rehash is invoked due to connect().

That assumption seems to be correct from my tests.

> In such a case, before touching hash{,2}, do hash4.

Brilliant, thanks. I'll give that a try.

-- 
Stefano


