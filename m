Return-Path: <netdev+bounces-160875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F6A1BF28
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 00:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F78188FFBC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D31EE7AC;
	Fri, 24 Jan 2025 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="HFBnYpPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEED1E9905
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762875; cv=none; b=bIlYY+CqwMR+5Bqmi4a/eKB8HzIb/DCIYv1Cxkf6apaPQvVHNCG3CrJs2Qj/BI0c1jmFCpO4p53TDIptpWbLx4jB1ZbyR1jVDs5QqHED0NQ/XHxGxcA2rbuE8+FHvSoSwtOnvb332mbuJTtk6rAEC8S4R9wxAyH73KuNnQY3mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762875; c=relaxed/simple;
	bh=TCFtiLFUeFjYVSLTGrIp9sm76ghm4+vRkdvtAeO7fUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhNVGLRIXW+cp8pBZZJLwebi0LcEs8nrOWxCas4f51wpc5p5MQ7rVEQG9q+Fze2KD36TXIMsIoDo8O4u1BO1R70kJcj0FyOzejG5tzQmKKlvo4WK91rEybbFcXThdPc3xtOQtb66/5jjMs8D8YI+oKaLmXXctxkeDZTm7KEV4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=HFBnYpPo; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FKQokx9/i4ckbVNuQBO4Kjq4nQtdT5wilBH8xjE42+s=; t=1737762873; x=1738626873; 
	b=HFBnYpPoGIfO0Sd1jYMkQlTKKFq6WWHAVCDq3kgZNU5uCWSqpMpNTSiR6wf+4jZ1x3kRpUstgs8
	p6jXBca7F7+oamGxzImRWiHWzcbB6J9c3nakxxQuUVn9B//+aN7XsGF64GA/TL8N6H0rV+hKfRKNn
	RVBhRrIsYts6s9aa8o+ErQxz56obX2xvUeGf3LGG9KVZVYYqzyWMuDeiftCtzOcZt2Sp+srZugdM0
	g+PGPQgwUVfvigOheZ4r7sYN+ArrJr/5YteNCAL6PCNO8HHdrdV4OLS3aaWQ7NF1qOGinvnGPy+Ay
	spP19NVZs6tMan6DRDSpgRJItL1FS2A3QwVg==;
Received: from mail-oa1-f49.google.com ([209.85.160.49]:57728)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tbTVP-0004yT-FK
	for netdev@vger.kernel.org; Fri, 24 Jan 2025 15:54:33 -0800
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2aa17010cbcso1170373fac.3
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 15:54:31 -0800 (PST)
X-Gm-Message-State: AOJu0YziqhfZ/Q1vDpD8gDL1dDYSprrs3FXaajsHWIr8dpeiRGghCKBL
	dxg278Uj0AP1T1IABRsdXE2p/A/ygeU3FMBltvkT3guqMFm0XDbTEEQXwR/MmKukBzDiiXw1eEp
	OUtswVQZhwSCEXHF9Ry1ICvXtE5M=
X-Google-Smtp-Source: AGHT+IFmjVzxjsbmIAFm518gfVnTgPLwW6Q6PeFlxPaJwgS//QZGOpPeR63yLJm9MMFt+E9an8FTMe0KMWtoWlAEbE0=
X-Received: by 2002:a05:6871:36c2:b0:29e:5eb9:fd22 with SMTP id
 586e51a60fabf-2b1c0c553b2mr17896794fac.25.1737762870839; Fri, 24 Jan 2025
 15:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
In-Reply-To: <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 24 Jan 2025 15:53:55 -0800
X-Gmail-Original-Message-ID: <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
X-Gm-Features: AWEUYZn7fGP-lxa5xuMPWzsAFBUwSZdD9dserVVcvFjwQG2-PeoH8e7mLCz85Dw
Message-ID: <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: bf2d39bfc2650c7e8471b46ddb5f48c6

On Thu, Jan 23, 2025 at 4:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
...
> > +     pool->descriptors =3D kmalloc_array(pool->num_bpages,
> > +                                       sizeof(struct homa_bpage),
> > +                                       GFP_ATOMIC);
>
> Possibly wort adding '| __GFP_ZERO' and avoid zeroing some fields later.

I prefer to do all the initialization explicitly (this makes it
totally clear that a zero value is intended, as opposed to accidental
omission of an initializer). If you still think I should use
__GFP_ZERO, let me know and I'll add it.

> > +
> > +     /* Allocate and initialize core-specific data. */
> > +     pool->cores =3D kmalloc_array(nr_cpu_ids, sizeof(struct homa_pool=
_core),
> > +                                 GFP_ATOMIC);
>
> Uhm... on large system this could be an order-3 allocation, which in
> turn could fail quite easily under memory pressure, and it looks
> contradictory with WRT the cover letter statement about reducing the
> amount of per socket status.
>
> Why don't you use alloc_percpu_gfp() here?

I have now switched to alloc_percpu_gfp. On the issue of per-socket
memory requirements, Homa doesn't significantly reduce the amount of
memory allocated for any given socket. Its memory savings come about
because a single Homa socket can be used to communicate with any
number of peers simultaneously, whereas TCP requires a separate socket
for each peer-to-peer connection. I have added a bit more to the cover
letter to clarify this.

> > +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, __u32 *=
pages,
> > +                     int set_owner)
> > +{
> > +     int core_num =3D raw_smp_processor_id();
>
> Why the 'raw' variant? If this code is pre-emptible it means another
> process could be scheduled on the same core...

My understanding is that raw_smp_processor_id is faster.
homa_pool_get_pages is invoked with a spinlock held, so there is no
risk of a core switch while it is executing. Is there some other
problem I have missed?

> > +
> > +             cur =3D core->next_candidate;
> > +             core->next_candidate++;
>
> ... here, making this increment racy.

Because this code always runs in atomic mode, I don't believe there is
any danger of racing: no other thread can run on the same core
concurrently.

> > +             if (cur >=3D limit) {
> > +                     core->next_candidate =3D 0;
> > +
> > +                     /* Must recompute the limit for each new loop thr=
ough
> > +                      * the bpage array: we may need to consider a lar=
ger
> > +                      * range of pages because of concurrent allocatio=
ns.
> > +                      */
> > +                     limit =3D 0;
> > +                     continue;
> > +             }
> > +             bpage =3D &pool->descriptors[cur];
> > +
> > +             /* Figure out whether this candidate is free (or can be
> > +              * stolen). Do a quick check without locking the page, an=
d
> > +              * if the page looks promising, then lock it and check ag=
ain
> > +              * (must check again in case someone else snuck in and
> > +              * grabbed the page).
> > +              */
> > +             ref_count =3D atomic_read(&bpage->refs);
> > +             if (ref_count >=3D 2 || (ref_count =3D=3D 1 && (bpage->ow=
ner < 0 ||
> > +                             bpage->expiration > now)))
>
> The above conditions could be place in separate helper, making the code
> more easy to follow and avoiding some duplications.

Done; I've created a new function homa_bpage_available.

> > +     /* First allocate any full bpages that are needed. */
> > +     full_pages =3D rpc->msgin.length >> HOMA_BPAGE_SHIFT;
> > +     if (unlikely(full_pages)) {
> > +             if (homa_pool_get_pages(pool, full_pages, pages, 0) !=3D =
0)
>
> full_pages must be less than HOMA_MAX_BPAGES, but I don't see any check
> on incoming message length to be somewhat limited ?!?

Oops, good catch. There was a check in the outbound path, but not in
the inbound path. I have added one now (in homa_message_in_init in
homa_incoming.c).

> > +
> > +     /* We get here if there wasn't enough buffer space for this
> > +      * message; add the RPC to hsk->waiting_for_bufs.
> > +      */
> > +out_of_space:
> > +     homa_sock_lock(pool->hsk, "homa_pool_allocate");
>
> There is some chicken-egg issue, with homa_sock_lock() being defined
> only later in the series, but it looks like the string argument is never
> used.

Right: in normal usage this argument is ignored. It exists because
there are occasionally deadlocks involving socket locks; when that
happens I temporarily add code to homa_sock_lock that uses this
argument to help track them down. I'd prefer to keep it, even though
it isn't normally used, because otherwise when a new deadlock arises
I'd have to modify every call to homa_sock_lock in order to add the
information back in again. I added a few more words to the comment for
homa_sock_lock to make this more clear.


> > +             if (!homa_rpc_try_lock(rpc, "homa_pool_check_waiting")) {
> > +                     /* Can't just spin on the RPC lock because we're
> > +                      * holding the socket lock (see sync.txt). Instea=
d,
>
> Stray reference to sync.txt. It would be nice to have the locking schema
> described somewhere start to finish in this series.

sync.txt will be part of the next revision of this series.

> > +struct homa_bpage {
> > +     union {
> > +             /**
> > +              * @cache_line: Ensures that each homa_bpage object
> > +              * is exactly one cache line long.
> > +              */
> > +             char cache_line[L1_CACHE_BYTES];
> > +             struct {
> > +                     /** @lock: to synchronize shared access. */
> > +                     spinlock_t lock;
> > +
> > +                     /**
> > +                      * @refs: Counts number of distinct uses of this
> > +                      * bpage (1 tick for each message that is using
> > +                      * this page, plus an additional tick if the @own=
er
> > +                      * field is set).
> > +                      */
> > +                     atomic_t refs;
> > +
> > +                     /**
> > +                      * @owner: kernel core that currently owns this p=
age
> > +                      * (< 0 if none).
> > +                      */
> > +                     int owner;
> > +
> > +                     /**
> > +                      * @expiration: time (in sched_clock() units) aft=
er
> > +                      * which it's OK to steal this page from its curr=
ent
> > +                      * owner (if @refs is 1).
> > +                      */
> > +                     __u64 expiration;
> > +             };
>
> ____cacheline_aligned instead of inserting the struct into an union
> should suffice.

Done (but now that alloc_percpu_gfp is being used I'm not sure this is
needed to ensure alignment?).

-John-

