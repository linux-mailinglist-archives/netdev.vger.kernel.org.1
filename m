Return-Path: <netdev+bounces-161110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB7A1D6D6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0579B16214F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5881FFC57;
	Mon, 27 Jan 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrKONCBI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E61FF7DD
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984678; cv=none; b=VTRf51xPCLp7F0LnCfuKthEdZ57L043BWnX1kFt71qLYcZoqomtkni13idCWCqHaj+kqNk9oYKSiszVklGI2b98Nou/IJU/hovJGyxLBMhFc4dYvKVjrYR/1kfRRrayKnwmlFgBSfxvvElHj2Gq3YY7BZwPJqWYsZmW2vufEBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984678; c=relaxed/simple;
	bh=xdQIqpy+FKqy0AlW4QMtn7nvVsTCgNAwO/r9HOC9XO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GUu7pUSkP3BJtRkLTdtsa04D/LQVK/gQEiUq6vDELxEaZSITH+m3grEgfplcXCxMJX1k144xhdUeGOuSx4RLsFceoNwtJuTqcOWjgf+RUUhIMXR/D2u3+V2co1Efnl9JfZ+GP3d2+cBow/XZ69DhGtSqZBYrmnUY3b1CZuDgn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrKONCBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737984675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BiMIZClPATtzyOxdSengJQIH9yeWvqFFhr5iuZB3y8=;
	b=FrKONCBIxgT9mN0nVJrf2wJ0IHnTvwYXZN61BvGmGwaNDeUga8DhqriDAUoS4ZrjIqraLi
	CSPO6xtFeFy8CMddtEpiJSAU3Wi0i0ldgPvB4H6zk5Vg9QabeUbrB1VSAKOfviO6uR1Yd8
	13zwWM4eRr6dcW6VAqkcyvarwFd1u7c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-q-gU1Yc6NWawmkacWGoyvQ-1; Mon, 27 Jan 2025 08:31:14 -0500
X-MC-Unique: q-gU1Yc6NWawmkacWGoyvQ-1
X-Mimecast-MFC-AGG-ID: q-gU1Yc6NWawmkacWGoyvQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab547c18515so511821866b.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737984673; x=1738589473;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BiMIZClPATtzyOxdSengJQIH9yeWvqFFhr5iuZB3y8=;
        b=w1TiKUuDDe7hGlAVf4H0dy26Ypq//RSX/Qey0t7BmRN/xcMJ/9Gr0fFFoa6ARQyVTR
         qJ2fBG+vBjTWJOTsCAtNSZA3QCFtgoZZ54Y+lQLb1N1p6uqrUesCl8ddUCaXXNoQFine
         nf3lGDsV+DNQHM6DrZNeP0p6oNh5l91/6mHxKPO589CTdeJvrWJFbxDjF92r+XtBq4W1
         Gcit+SzO5hg0POuIdNvdrf4kx+f7CXqk1FoW54odqF9MoxkgKUmo/rbvUgzxeYcb6FoD
         wvi2fDZak6lCGcJBubDkxC6kfOUF3xCxhNAmV1OTv9c7HZHc7CJNDCuiITVyuLhHcaui
         UFuw==
X-Forwarded-Encrypted: i=1; AJvYcCVthQKwY8z1V3Gp9RqUcJnqgdwyxM/ogtieuzVy9hy91BSjwXbdwfPQojOCejosYR9Pi3uXckU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+/fX8GxB5TZO1z2To7U3nnHSA8J6apKb5/2c6TqNg5L44/wM
	6qeWAvC23agV+t6SLHMBWBcbajNuuN33HItN7DlvMZcfFrWYPDk5hil+K24onXz2IfH6//w+2y6
	3U6MUo+DbDSJIqH2arqyofpbhtqpIaeZ92n8vnIkNRAYVnvZ6M3//FA==
X-Gm-Gg: ASbGncsDZju0SnueY7TWMe01mey6ttEGEyO5wCaeLD/VBmQpzwLdggrIeFhfBP2Xbuc
	t6g3hBnNJQulAk8ZlW9Nwmwnuh4EQse5C+DFD4jnCHoyxh6SXbzSdq6RmUnoW5WwzPlWrsYNOfb
	cI0q49yuEoInNvBzyqKYIr8U0Ve/WVHnskow4h9n6y0Tnfa6CDGsysH08aA64u4dr0rp6EoOyNF
	/h0uOj53h4FIG4xyZb2+btlq65p6KLoeer/P0sRjdpm+ZWWmVNuR0puses/xkBEBDy8mHVcI16b
	Eg==
X-Received: by 2002:a17:906:dac2:b0:ab6:71cd:36f5 with SMTP id a640c23a62f3a-ab671cd42ecmr1481430566b.25.1737984672730;
        Mon, 27 Jan 2025 05:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkQMEvSiJwZJciMKMtripfp3tvFxy9J8ObspHmpXetwyudhJqFoS9a1zrx2hDmkVxac5UPBg==
X-Received: by 2002:a17:906:dac2:b0:ab6:71cd:36f5 with SMTP id a640c23a62f3a-ab671cd42ecmr1481426666b.25.1737984672265;
        Mon, 27 Jan 2025 05:31:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12ddcsm595125966b.13.2025.01.27.05.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:31:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B3023180AEC1; Mon, 27 Jan 2025 14:31:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, asml.silence@gmail.com, kaiyuanz@google.com,
 willemb@google.com, mkarsten@uwaterloo.ca, jdamato@fastly.com
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
In-Reply-To: <CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com>
References: <20250123231620.1086401-1-kuba@kernel.org>
 <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
 <87r04rq2jj.fsf@toke.dk>
 <CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Jan 2025 14:31:10 +0100
Message-ID: <877c6gpen5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Fri, Jan 24, 2025 at 2:18=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > On Thu, Jan 23, 2025 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
>> >>
>> >> Page ppol tried to cache the NAPI ID in page pool info to avoid
>> >
>> > Page pool
>> >
>> >> having a dependency on the life cycle of the NAPI instance.
>> >> Since commit under Fixes the NAPI ID is not populated until
>> >> napi_enable() and there's a good chance that page pool is
>> >> created before NAPI gets enabled.
>> >>
>> >> Protect the NAPI pointer with the existing page pool mutex,
>> >> the reading path already holds it. napi_id itself we need
>> >
>> > The reading paths in page_pool.c don't hold the lock, no? Only the
>> > reading paths in page_pool_user.c seem to do.
>> >
>> > I could not immediately wrap my head around why pool->p.napi can be
>> > accessed in page_pool_napi_local with no lock, but needs to be
>> > protected in the code in page_pool_user.c. It seems
>> > READ_ONCE/WRITE_ONCE protection is good enough to make sure
>> > page_pool_napi_local doesn't race with
>> > page_pool_disable_direct_recycling in a way that can crash (the
>> > reading code either sees a valid pointer or NULL). Why is that not
>> > good enough to also synchronize the accesses between
>> > page_pool_disable_direct_recycling and page_pool_nl_fill? I.e., drop
>> > the locking?
>>
>> It actually seems that this is *not* currently the case. See the
>> discussion here:
>>
>> https://lore.kernel.org/all/8734h8qgmz.fsf@toke.dk/
>>
>> IMO (as indicated in the message linked above), we should require users
>> to destroy the page pool before freeing the NAPI memory, rather than add
>> additional synchronisation.
>>
>
> Ah, I see. I wonder if we should make this part of the API via comment
> and/or add DEBUG_NET_WARN_ON to catch misuse, something like:
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index ed4cd114180a..3919ca302e95 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -257,6 +257,10 @@ struct xdp_mem_info;
>
>  #ifdef CONFIG_PAGE_POOL
>  void page_pool_disable_direct_recycling(struct page_pool *pool);
> +
> +/* page_pool_destroy or page_pool_disable_direct_recycling must be
> called before
> + * netif_napi_del if pool->p.napi is set.
> + */
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(vo=
id *),
>                            const struct xdp_mem_info *mem);
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 5c4b788b811b..dc82767b2516 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1161,6 +1161,8 @@ void page_pool_destroy(struct page_pool *pool)
>         if (!page_pool_put(pool))
>                 return;
>
> +       DEBUG_NET_WARN_ON(pool->p.napi && !napi_is_valid(pool->p.napi));
> +
>         page_pool_disable_direct_recycling(pool);
>         page_pool_free_frag(pool);

Yeah, good idea; care to send a proper patch? :)

> I also took a quick spot check - which could be wrong - but it seems
> to me both gve and bnxt free the napi before destroying the pool :(

Right, that fits with what Yunsheng found over in that other thread, at
least (for bnxt).

> But I think this entire discussion is unrelated to this patch, so and
> the mutex sync in this patch seems necessary for the page_pool_user.c
> code which runs outside of softirq context:
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Yeah, didn't really mean this comment to have anything to do with this
patch, just mentioned it since you were talking about the data path :)

For this patch, I agree, the mutex seems fine:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


