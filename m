Return-Path: <netdev+bounces-187477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF0AA7504
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC39C7A38D3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA514A09C;
	Fri,  2 May 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQFyrPZH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F323398B
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196401; cv=none; b=oY3f4h1HeiirhJfqLcdJ/e/SCs25TJbLEhKkgTq/Hh301oGR296DJ5Qr2x0eDaHMP1RBYXMW/NXXO5OXETH8M5eUARbYOK9IlHTQas2rx0+/tEmX9MtAhFjNOvTHkTeyI45WyjATdWqsZ/VozMTJL+hYwsiKc72xJlsC3ANrBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196401; c=relaxed/simple;
	bh=TvWlx5W+GGzj7SDWOR6MsmWMEYm7BfLlsYVqm6fsW+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpGli4TjLXzEHV2YDjxtSyhW/zR8ijvnHQWQs0qXFYSHtceaGnrJm3w+8kgltYFFDyfseUZIClUOGuPttXGYx/qYbVVRcWQPpnAApLXofXkyzXom6Qvuf6OvrDFFFnwCKCA+Mz5ydO4V46XCRbp6fx+5XtOCkHn7A/jmubMDEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQFyrPZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746196398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iidq5caE2qrMnaUyfRtrVUdIHj/SGDnk/ds3ljYLCTU=;
	b=LQFyrPZHkNMWH1Ak3A0djTrAvc9QMLyQ2cfHww3GK8VbQL8z9bcCtZnjWOLzXiJzfVyzQs
	/QTCJL3Lxe4IHIhWIKWoyZd5j40JqWJ3kCyRJ9kQnf+h2YGn2MbQRRW4YJHbxu+/i6KVNL
	zir+6kdETPYjSeMyjuMOsofp+hSkxHU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-xQo8amZsN2254lySuSjgEA-1; Fri, 02 May 2025 10:33:15 -0400
X-MC-Unique: xQo8amZsN2254lySuSjgEA-1
X-Mimecast-MFC-AGG-ID: xQo8amZsN2254lySuSjgEA_1746196393
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3108149df63so10008381fa.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 07:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196393; x=1746801193;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iidq5caE2qrMnaUyfRtrVUdIHj/SGDnk/ds3ljYLCTU=;
        b=D2dcmbVeeRH2T7jPWyblxOb7oy9FYpikXkCkMoUkO0pMFuTf8x9l2e2SCAkIfCHq1v
         XgCOGj4NH91J9rMCXzg8wGg7CEZ6tjGuTzrtI6qkm9YNQTchVKJ7mLfdkI8/hlitdCeO
         kKaBk2LuyUIIZA9ViE7OCiDsnm9GfYXwWaPiot7mXJ7DSkDMynEeTsiDYWCTDfd6lsrs
         1lt8zTIs8Sae/qKhh4v46TF6GSPJse4vuonEVoKFdN+L/ONT0gRZiTkv8iED2y3p44Jz
         qtMCaYnOlKZ1SX7ZiBgwtkRWOMTz3kGk8UHGmkLb4Fc+w90lyoqXVqfFbmXgHoPSV3q7
         1+yg==
X-Gm-Message-State: AOJu0Yytdnx0fIQ0ocaDvDDhejBLVyo73FH+mWCvUmtJuvk1w9UOvHp4
	rLTvTHgcM79JW1z/3gKifyW4f0V0y3dzmLKBGJvsygtHnhAysUbPUAnRdIy7stVR4uY+2hrE5c0
	ARSbDICY6Pbth7KfxboFV92QMFSOWQwk97T6NkShbY8SbuJn86Plb7A==
X-Gm-Gg: ASbGncvVK5aXsf3H04qXxjwTR6AzcmGD2JKJhmnHN7UdSHePZLIYDrek6ClGx/Hbtvv
	FPo+pz6h1GJFhAYGo9TEBWak5BwuLJGFe+ZMKxR5c+bQMJ5j98sUdYeMRr4isjSupeaJea++r6F
	HCENUtw3yCXfNMQOAISpbWewYYqaUrgHjGcKCPotw/S8CdhjjN7Q8SD01ny8caW9hppyCugSt7Q
	1FCS9APxT2MiL16mEJXa0R8WJ8VN7PC5BObXxkCkC+7F/GHHz0wEU7K2h2/tC/BykzqoQ4DFtFa
	NpNsfRFe3C64+2Axo25Eee9rRJlnzZw1VW6K
X-Received: by 2002:a05:6512:b22:b0:54a:cc11:b558 with SMTP id 2adb3069b0e04-54eac20ce44mr844942e87.33.1746196393304;
        Fri, 02 May 2025 07:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZP3x8CctExY8BKU1Krhhw8vg7FGAq7GpbD015fqIistJw782m5FQTvV2H/OW0LrIz3wBow==
X-Received: by 2002:a05:6512:b22:b0:54a:cc11:b558 with SMTP id 2adb3069b0e04-54eac20ce44mr844927e87.33.1746196392826;
        Fri, 02 May 2025 07:33:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b17d6sm364278e87.6.2025.05.02.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:33:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DDB061A0851B; Fri, 02 May 2025 16:33:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250502133231.lS281-FN@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 May 2025 16:33:10 +0200
Message-ID: <87ikmj5bh5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-01 12:13:24 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>> >   * PP consumers must pay attention to run APIs in the appropriate con=
text
>> >   * (e.g. NAPI context).
>> >   */
>> > -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
>> > +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
>> > +	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
>> > +};
>>=20
>> I'm a little fuzzy on how DEFINE_PER_CPU() works, but does this
>> initialisation automatically do the right thing with the multiple
>> per-CPU instances?
>
> It sets the "first" per-CPU data which is then copied to all
> "possible-CPUs" during early boot when the per-CPU data is made
> available. You can initialize almost everything like that. Pointer based
> structures (such as LIST_HEAD_INIT()) is something that obviously won't
> work.

Right, I see. Cool, thanks for explaining :)

>> >  #ifdef CONFIG_LOCKDEP
>> >  /*
>> > --- a/net/core/xdp.c
>> > +++ b/net/core/xdp.c
>> > @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(stru=
ct sk_buff *skb,
>> >   */
>> >  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>> >  {
>> > -	struct page_pool *pp =3D this_cpu_read(system_page_pool);
>> >  	const struct xdp_rxq_info *rxq =3D xdp->rxq;
>> >  	u32 len =3D xdp->data_end - xdp->data_meta;
>> >  	u32 truesize =3D xdp->frame_sz;
>> > +	struct page_pool *pp;
>> >  	struct sk_buff *skb;
>> >  	int metalen;
>> >  	void *data;
>> > @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> >  	if (!IS_ENABLED(CONFIG_PAGE_POOL))
>> >  		return NULL;
>> >=20=20
>> > +	local_lock_nested_bh(&system_page_pool.bh_lock);
>> > +	pp =3D this_cpu_read(system_page_pool.pool);
>> >  	data =3D page_pool_dev_alloc_va(pp, &truesize);
>> > -	if (unlikely(!data))
>> > +	if (unlikely(!data)) {
>> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  		return NULL;
>> > +	}
>> >=20=20
>> >  	skb =3D napi_build_skb(data, truesize);
>> >  	if (unlikely(!skb)) {
>> >  		page_pool_free_va(pp, data, true);
>> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  		return NULL;
>> >  	}
>> >=20=20
>> > @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_=
buff *xdp)
>> >=20=20
>> >  	if (unlikely(xdp_buff_has_frags(xdp)) &&
>> >  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
>> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  		napi_consume_skb(skb, true);
>> >  		return NULL;
>> >  	}
>> > +	local_unlock_nested_bh(&system_page_pool.bh_lock);
>>=20
>> Hmm, instead of having four separate unlock calls in this function, how
>> about initialising skb =3D NULL, and having the unlock call just above
>> 'return skb' with an out: label?
>>=20
>> Then the three topmost 'return NULL' can just straight-forwardly be
>> replaced with 'goto out', while the last one becomes 'skb =3D NULL; goto
>> out;'. I think that would be more readable than this repetition.
>
> Something like the following maybe? We would keep the lock during
> napi_consume_skb() which should work.
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index b2a5c934fe7b7..1ff0bc328305d 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -740,8 +740,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  	const struct xdp_rxq_info *rxq =3D xdp->rxq;
>  	u32 len =3D xdp->data_end - xdp->data_meta;
>  	u32 truesize =3D xdp->frame_sz;
> +	struct sk_buff *skb =3D NULL;
>  	struct page_pool *pp;
> -	struct sk_buff *skb;
>  	int metalen;
>  	void *data;
>=20=20
> @@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
>  	local_lock_nested_bh(&system_page_pool.bh_lock);
>  	pp =3D this_cpu_read(system_page_pool.pool);
>  	data =3D page_pool_dev_alloc_va(pp, &truesize);
> -	if (unlikely(!data)) {
> -		local_unlock_nested_bh(&system_page_pool.bh_lock);
> -		return NULL;
> -	}
> +	if (unlikely(!data))
> +		goto out;
>=20=20
>  	skb =3D napi_build_skb(data, truesize);
>  	if (unlikely(!skb)) {
>  		page_pool_free_va(pp, data, true);
> -		local_unlock_nested_bh(&system_page_pool.bh_lock);
> -		return NULL;
> +		goto out;
>  	}
>=20=20
>  	skb_mark_for_recycle(skb);
> @@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
>=20=20
>  	if (unlikely(xdp_buff_has_frags(xdp)) &&
>  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> -		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		napi_consume_skb(skb, true);
> -		return NULL;
> +		skb =3D NULL;
>  	}
> +
> +out:
>  	local_unlock_nested_bh(&system_page_pool.bh_lock);
> -
> -	xsk_buff_free(xdp);
> -
> -	skb->protocol =3D eth_type_trans(skb, rxq->dev);
> +	if (skb) {
> +		xsk_buff_free(xdp);
> +		skb->protocol =3D eth_type_trans(skb, rxq->dev);
> +	}

I had in mind moving the out: label (and the unlock) below the
skb->protocol assignment, which would save the if(skb) check; any reason
we can't call xsk_buff_free() while holding the lock?

-Toke


