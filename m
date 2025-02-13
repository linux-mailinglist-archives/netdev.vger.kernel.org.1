Return-Path: <netdev+bounces-166229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1409A35170
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B5F188F9A1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D226FA42;
	Thu, 13 Feb 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URzWE3z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC68212B3B
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486823; cv=none; b=DMjAPjm2JZbNiCvkFHZct+O4DJc9BiUYfeBu/Gkq54KhSbQLN0HAwMjxKpBvbuR9IJgir++QgBOGXol/KD84FCsk7RnVVwt5n0RV39ZapYw88pCqN4qIYZaPv9ZiXcIA1+Sno/1Y2KPQT6PoTwyh2g3cVsFBjQGAi6rVhw5m93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486823; c=relaxed/simple;
	bh=9wEbiTqNJR7iyq/E6TK4T0vJkGTyykiw0e8ovav+7YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NguxxQ22CHsGlKnd3IwmdVLHnenrxrux7LryYUTOaUsnrecrDU+hj0mNZi1YRtadBgys6YWk7PEDhPupA8Zt8NhiiFir3FQ4Ejw2Pt8vkc6ntRjL8l+ZSo7VvP6e4fRmH36UkM+mz+5hhOsFydL+0ZZsd8lAvvraoHsD0j5uRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URzWE3z0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f8c280472so23655ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486821; x=1740091621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx0AAmYFWOIOPkUrIn1UTQgQkHNEUq6Qa9DLBmG3uS8=;
        b=URzWE3z039IJFediXJ/x5DIGmz8hogS9Ee3eenaxvbgTHPH0ARmhoN5q602siQCoqC
         vxHPLAj8lnAEWTQfgHPprRF5XHWUw71KNqKYt1Apb6kiydHnVKazleH4Wh1PczkHQfDu
         bjTh499luKIJghncpiKllJ3zLzMSt8RrKLZHUy0WVUx6g91IBFcnCLhC8ksbG7WXowFY
         fJ2auaNXyDbYbamStvWElhlko00BRaVUiiNcWcBBfrLZv6JW/L92a907Y4JuhqSHgPWa
         HyGxjLRHtIjXZ5La8hMbBb/2ehxmu0a17Ok01BO1OlTk2aHSfGavrxsSyViP15NibOtR
         8FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486821; x=1740091621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx0AAmYFWOIOPkUrIn1UTQgQkHNEUq6Qa9DLBmG3uS8=;
        b=qk34Qz4gciKleHBhNXPvmyxqYVRlUkAWqxgC0w2740nP9Z2wyt/1lC2HBiwaNW57fy
         KFOsuDy9McV/euQLXMCguuF3J+udmv1FBudPsPuYU9BHo0Exmt7YtXjBETaacBrZoLV0
         aqtFKDMTuMu7RZhfGS1fgiyVOcA7zgjAxLNXJpbogkg4fnNFfssrAYOGOCAoyZgViG9X
         0NWPpn3V70DHq3LuDoJtz56EhONvwSQTt1AF6Awt3FYQkSqiv7hGWz/LfTDHD7HUfQ2I
         LDOfFiAZmMoaydVg7OBktEIvUGxfh57uCJ4m/PeMgWTAVg+Ex/2GviOy/KD1eCJ9+aSY
         7dTw==
X-Forwarded-Encrypted: i=1; AJvYcCWRBfSJzpGNUNQBtgjVpkFuyNoE/2Vp58c7IhsPdOeVDOgC5lHVpGFng3HKNl8vN8liY3MA12E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0nkwNzc+nf3hEdr1BSqbFLQUbbHu420/Jp4eYHRCKG/2lQaz
	44eYDTBlLC+M0tcqi/xKptSGcoXnxdPXC4TX5cH+dzkrZHQBhu8aL2/zcVzrM2+L7u60vq8w1JC
	jOsz6AzWjEjmS2BiM5wZBBbqDihf2jxE+38QB
X-Gm-Gg: ASbGncsV76A/7cWe+893+azMHID/uam5jN4TAGQCDySDSNLxF3bMDULxzILMEezvjwk
	y7VCZ/SqOPnfoKPpEXd/Puts7rzXX1GbN5zj04Q1ViR+UHgl4M2SnJiT4mc6SEIFSPgaM3l1vxe
	t9Mj1iBOyZNjoJAHT0GDl3iFojTlk=
X-Google-Smtp-Source: AGHT+IFS8xwaxb+AlgeMnuf14wEQAgaZmUywYmLiX30wpV1Zwce7C5K+AZ1kBqxijWAodj7qdnwFWSjbKa7KYWETzPQ=
X-Received: by 2002:a17:903:18a:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-220ed9fb82cmr278795ad.5.1739486820598; Thu, 13 Feb 2025
 14:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212185859.3509616-1-dw@davidwei.uk> <20250212185859.3509616-5-dw@davidwei.uk>
 <CAHS8izMOrPWx5X_i+xxjJ8XJyP0Kn-WEcgvK096-WEw1afQ75w@mail.gmail.com> <7565219f-cdbc-4ea4-9122-fe81b5363375@gmail.com>
In-Reply-To: <7565219f-cdbc-4ea4-9122-fe81b5363375@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Feb 2025 14:46:47 -0800
X-Gm-Features: AWEUYZn1_kLsIMmoowNpvZykywf8k4vbEC_M_4PGoUaPlEcgnOQ_zpw6UTCq_Vc
Message-ID: <CAHS8izMXU_QEbd11rY8Dpd+Rr=jvy4F5LSey4AstMPRShsCHxg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/11] io_uring/zcrx: implement zerocopy
 receive pp memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:36=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/13/25 20:57, Mina Almasry wrote:
> ...
> >> +static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
> >> +{
> >> +       struct io_zcrx_area *area =3D ifq->area;
> >> +       int i;
> >> +
> >> +       if (!area)
> >> +               return;
> >> +
> >> +       /* Reclaim back all buffers given to the user space. */
> >> +       for (i =3D 0; i < area->nia.num_niovs; i++) {
> >> +               struct net_iov *niov =3D &area->nia.niovs[i];
> >> +               int nr;
> >> +
> >> +               if (!atomic_read(io_get_user_counter(niov)))
> >> +                       continue;
> >> +               nr =3D atomic_xchg(io_get_user_counter(niov), 0);
> >> +               if (nr && !page_pool_unref_netmem(net_iov_to_netmem(ni=
ov), nr))
> >> +                       io_zcrx_return_niov(niov);
> >
> > I assume nr can be > 1?
>
> Right
>
> If it's always 1, then page_pool_put_netmem()
> > does the page_pool_unref_netmem() + page_pool_put_unrefed_netmem() a
> > bit more succinctly.
> ...
> >> +       entries =3D io_zcrx_rqring_entries(ifq);
> >> +       entries =3D min_t(unsigned, entries, PP_ALLOC_CACHE_REFILL - p=
p->alloc.count);
> >> +       if (unlikely(!entries)) {
> >> +               spin_unlock_bh(&ifq->rq_lock);
> >> +               return;
> >> +       }
> >> +
> >> +       do {
> >> +               struct io_uring_zcrx_rqe *rqe =3D io_zcrx_get_rqe(ifq,=
 mask);
> >> +               struct io_zcrx_area *area;
> >> +               struct net_iov *niov;
> >> +               unsigned niov_idx, area_idx;
> >> +
> >> +               area_idx =3D rqe->off >> IORING_ZCRX_AREA_SHIFT;
> >> +               niov_idx =3D (rqe->off & ~IORING_ZCRX_AREA_MASK) >> PA=
GE_SHIFT;
> >> +
> >> +               if (unlikely(rqe->__pad || area_idx))
> >> +                       continue;
> >
> > nit: I believe a lot of the unlikely in the file are redundant. AFAIU
> > the compiler always treats the condition inside the if as unlikely by
> > default if there is no else statement.
>
> That'd be too presumptious of the compiler. Sections can be reshuffled,
> but even without that, the code generation often looks different. The
> annotation is in the right place.
>
> ...
> >> +static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t =
gfp)
> >> +{
> >> +       struct io_zcrx_ifq *ifq =3D pp->mp_priv;
> >> +
> >> +       /* pp should already be ensuring that */
> >> +       if (unlikely(pp->alloc.count))
> >> +               goto out_return;
> >> +
> >
> > As the comment notes, this is a very defensive check that can be
> > removed. We pp should never invoke alloc_netmems if it has items in
> > the cache.
>
> Maybe I'll kill it in the future, but it might be a good idea to
> leave it be as even page_pool.c itself doesn't trust it too much,
> see __page_pool_alloc_pages_slow().
>
> >> +       io_zcrx_ring_refill(pp, ifq);
> >> +       if (likely(pp->alloc.count))
> >> +               goto out_return;
> >> +
> >> +       io_zcrx_refill_slow(pp, ifq);
> >> +       if (!pp->alloc.count)
> >> +               return 0;
> >> +out_return:
> >> +       return pp->alloc.cache[--pp->alloc.count];
> >> +}
> >> +
> >> +static bool io_pp_zc_release_netmem(struct page_pool *pp, netmem_ref =
netmem)
> >> +{
> >> +       struct net_iov *niov;
> >> +
> >> +       if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> >> +               return false;
> >> +
> >
> > Also a very defensive check that can be removed. There should be no
> > way for the pp to release a netmem to the provider that didn't come
>
> Agree, but it's a warning and I don't care about performance
> of this chunk to that extent. Maybe we'll remove it later.
>
> > from this provider. netmem should be guaranteed to be a net_iov, and
>
> Not like it matters for now, but I wouldn't say it should be
> net_iov, those callback were initially proposed for huge pages.
>
> > also an io_uring net_iov (not dma-buf one), and specifically be a
> > net_iov from this particular memory provider.
> >
> >> +       niov =3D netmem_to_net_iov(netmem);
> >> +       net_mp_niov_clear_page_pool(niov);
> >> +       io_zcrx_return_niov_freelist(niov);
> >> +       return false;
> >> +}
> >> +
> >> +static int io_pp_zc_init(struct page_pool *pp)
> >> +{
> >> +       struct io_zcrx_ifq *ifq =3D pp->mp_priv;
> >> +
> >> +       if (WARN_ON_ONCE(!ifq))
> >> +               return -EINVAL;
> >> +       if (pp->dma_map)
> >> +               return -EOPNOTSUPP;
> >
> > This condition should be flipped actually. pp->dma_map should be true,
> > otherwise the provider isn't supported.
>
> It's not implemented in this patch, which is why rejected.
> You can think of it as an unconditional failure, even though
> io_pp_zc_init is not reachable just yet.
>

Ah, I see in the follow up patch you flip the condition, that's fine then.

I usually see defensive checks get rejected but I don't see that
blocking this series, so FWIW:

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

