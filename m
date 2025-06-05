Return-Path: <netdev+bounces-195326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0DACF8D6
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C3E178152
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FD27E1AB;
	Thu,  5 Jun 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fA3EasR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3227C854
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155682; cv=none; b=UxfIjL5rnlUsCZR0YOuMChnpqdURIT+7foOw+feZ7m2B4ssPsOVxb12ryPXBrFgbIhrw5hH0KI17YIKttagEhkp8wHAX6SPAiG2czfSeGWdVFeQJWSdmGwScuURzXFvEWETlkXMz38XydSwcb4Q2qIupAwMHWW/RcP228boNI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155682; c=relaxed/simple;
	bh=0QII3GWTrtGjkUbjZoP+Vf2mHDWYUvjDCDt2cueIiOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCE7tWpouLkAhU9qAhK+PfyUmGyoSjFjiQjG8v22KOAzBNN93GI+7okPUzHdBd1wtgUTdMY8/lr1qPJkrToLg7UCsZI2Lh02WhZ3U6maJ2NlO5rEU3LlkU5FWkZ8WS1ufi6/UKhbjoRtepgMQza/ZQanSUlIcefhMiquUQVrNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fA3EasR9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2348ac8e0b4so19435ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749155680; x=1749760480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZoLre5WJXzZI3tRwkyLjsbHGJ2C1Pcu+Ob2SlEJwY0=;
        b=fA3EasR9DfNX2l8GwvcaT0MvZ7Aq938G5NX2vSzkm9JV0bUQL0daiUSzQFdmjjYXrc
         KpH3ZVGuZoyFQ9dfZ8nHCf8UplLDYvkDfM8+6cMFPoXL+/Am9RgiKUfceEwmpnT9XVbF
         lLc8/7mOUzCJv0zrO0uvzSNgpul5XRrZxFbUotDU+3qD/jZs/1QjZrJwTOl6VinxpHRC
         kYyDpKqwBbuLfVWv4YureLecupPHUK9QLpthWcNBqLQ0PEM3X6SgKZ2AiQshJD6j/59O
         KRB5oP+owa7iHToZIippsRv442PPbF6z3n0GPUpHELvthLJ6QL1vqeQuteCCh1Iq93Ud
         KwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749155680; x=1749760480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZoLre5WJXzZI3tRwkyLjsbHGJ2C1Pcu+Ob2SlEJwY0=;
        b=ZsrAG8m+ZAN2B9diG8PLSHUTlsiolsrd1xtIxov6j5OAurUPeBoE0SDlkZjQqwMmB1
         jmD7eyE1Ilf5gcwsHRBWbSRMjXdkOVoi0bJgGBKLM0E00BSFmVxXH5SOj+cD1HgMlhpI
         orWEuVVfKX0oNfitAFOA3hy/Xc+DVSgKSIduUAGsyacaML9qMQyhw59HTUnFsRrQpZKF
         bMkQyBHvn9VTDlJFvvMavh8i9pf28LjiGY06rXaGanAMt6n9MPQmCHTC1PFMbVr8I0b+
         AVuSaiZfZEGlMPSxSAuLKI0boEjPhOW5B/PhTTEzkUAbOsB50lvXnq7zLC5fv/Dj43Uf
         Pbmw==
X-Forwarded-Encrypted: i=1; AJvYcCWdZAcsZW/xCmnB/I381F3DIhqDNW5QwaIzpF4nObbxJwR3e1FRsbEXxs4wI+RFtPout4WDkqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6Ee9bGicJ/iyA9yzhj3ZGPT5TRz8tnNkfbOoq36ZJ6BUFHOX
	KdnvKAknsLtNVTLvy+UHu6MNLTHiACwgv57sKYhNFQEArdy8tZKoI/VtOfL5j6KOMLRhKI5LU1M
	QKvYjbJk45LX7FYsHDbuF9Rgvz4AeeCU5ssjL2BAd
X-Gm-Gg: ASbGncsLYKwFevyTrFTi+LUMdUZp7KldGzeWNyWEpGHBgJ0N8P7A7NK1pcPfWFsGRKw
	pHMhF2W9uG5LGxnnSlRM/JjSMIhvj9DBBS/v0SFmU12t4/vmcgtjU7UBUF0fZXiDzAHyp2rI1+5
	8yg6I6v9UoA1os3rTAKTgLn2MnlYaNsgxgy3jVtC4ffEuv
X-Google-Smtp-Source: AGHT+IEz65fw6eX6HnqKD1lGuCRGB/lwbhJS2C0P8T2RK/ATRMV91beDaRjDj92IaN4e2RiyHUifHQ+O8l0xyf76AkM=
X-Received: by 2002:a17:902:f60b:b0:234:8eeb:d81a with SMTP id
 d9443c01a7336-236021e505cmr754845ad.16.1749155679795; Thu, 05 Jun 2025
 13:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-4-byungchul@sk.com>
 <29f2c375-65e3-4d22-8274-552653222f8d@gmail.com> <CAHS8izMb23eaav-Fz50sefuS8BhF7as7=BX+Sv1wj01+0n6tMg@mail.gmail.com>
 <ec924af7-1330-4220-97be-1171ef6ffc75@gmail.com>
In-Reply-To: <ec924af7-1330-4220-97be-1171ef6ffc75@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 13:34:25 -0700
X-Gm-Features: AX0GCFsZcj1hI7C7EPh1g4w7_P54Ew1pJG_c13sE__2Bloq-K4EM8uiIisV8cik
Message-ID: <CAHS8izND_JonvNqJm4XpXm-sk9+v6KCGqeKb7ZUSAWoyckUY6A@mail.gmail.com>
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:26=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 6/5/25 20:39, Mina Almasry wrote:
> > On Thu, Jun 5, 2025 at 3:25=E2=80=AFAM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> On 6/4/25 03:52, Byungchul Park wrote:
> >>> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> >>> return netmem_ref instead of struct page * in
> >>> __page_pool_alloc_page_order().
> >>>
> >>> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >>> Reviewed-by: Mina Almasry <almasrymina@google.com>
> >>> ---
> >>>    net/core/page_pool.c | 26 +++++++++++++-------------
> >>>    1 file changed, 13 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >>> index 4011eb305cee..523354f2db1c 100644
> >>> --- a/net/core/page_pool.c
> >>> +++ b/net/core/page_pool.c
> >>> @@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool =
*pool, netmem_ref netmem, gfp_t g
> >>>        return false;
> >>>    }
> >>>
> >>> -static struct page *__page_pool_alloc_page_order(struct page_pool *p=
ool,
> >>> -                                              gfp_t gfp)
> >>> +static netmem_ref __page_pool_alloc_page_order(struct page_pool *poo=
l,
> >>> +                                            gfp_t gfp)
> >>>    {
> >>> -     struct page *page;
> >>> +     netmem_ref netmem;
> >>>
> >>>        gfp |=3D __GFP_COMP;
> >>> -     page =3D alloc_pages_node(pool->p.nid, gfp, pool->p.order);
> >>> -     if (unlikely(!page))
> >>> -             return NULL;
> >>> +     netmem =3D alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
> >>> +     if (unlikely(!netmem))
> >>> +             return 0;
> >>>
> >>> -     if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_=
netmem(page), gfp))) {
> >>> -             put_page(page);
> >>> -             return NULL;
> >>> +     if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem, =
gfp))) {
> >>> +             put_netmem(netmem);
> >>
> >> It's a bad idea to have {put,get}_netmem in page pool's code, it has a
> >> different semantics from what page pool expects for net_iov. I.e.
> >> instead of releasing the netmem and allowing it to be reallocated by
> >> page pool, put_netmem(niov) will drop a memory provider reference and
> >> leak the net_iov. Depending on implementation it might even underflow
> >> mp refs if a net_iov is ever passed here.
> >>
> >
> > Hmm, put_netmem (I hope) is designed and implemented to do the right
> > thing no matter what netmem you pass it (and it needs to, because we
> > can't predict what netmem will be passed to it):
> >
> > - For non-pp pages, it drops a page ref.
> > - For pp pages, it drops a pp ref.
> > - For non-pp net_iovs (devmem TX), it drops a net_iov ref (which for
> > devmem net_iovs is a binding ref)
> > - For pp net_iovs, it drops a niov->pp ref (the same for both iouring
> > and devmem).
>
> void put_netmem(netmem_ref netmem)
> {
>         struct net_iov *niov;
>
>         if (netmem_is_net_iov(netmem)) {
>                 niov =3D netmem_to_net_iov(netmem);
>                 if (net_is_devmem_iov(niov))
>                         net_devmem_put_net_iov(netmem_to_net_iov(netmem))=
;
>                 return;
>         }
>
>         put_page(netmem_to_page(netmem));
> }
> EXPORT_SYMBOL(put_netmem);
>
> void net_devmem_put_net_iov(struct net_iov *niov)
> {
>         net_devmem_dmabuf_binding_put(net_devmem_iov_binding(niov));
> }
>
> Am I looking at an outdated version? for devmem net_iov it always puts
> the binding and not niov refs, and it's always does put_page for pages.
> And it'd also silently ignore io_uring. And we're also patching early
> alloc/init failures in this series, so gauging if it's pp or non-pp
> originated struct page might be dangerous and depend on init order. We
> don't even need to think about all that if we continue to use put_page,
> which is why I think it's a much better option.
>

Oh, my bad. I was thinking of skb_page_unref, which actually handles
all net_iov/page types correctly. You're right, put_netmem doesn't
actually do that.

In that case reverting to put_page would be better here indeed.

--=20
Thanks,
Mina

