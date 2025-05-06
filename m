Return-Path: <netdev+bounces-188497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634DAAD18C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC7B4C20B4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E221CC45;
	Tue,  6 May 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="H6puJc2P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92821CA13
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574169; cv=none; b=hjsBMYSX1s4lnp3NY8q4yxaaMxw7lBgF1WtX7ezNbziaANtCvJAkK/G38fvKtTfRxgCQITEongYwzhAK5GIzeKLIHZsgCEJVoPqt3rN/cw13fLRasPOHFMcyIFuY0heJ9aPN9WepHrli7dN4Bicy3IzLEhQ/V3RFxi9VFcEC23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574169; c=relaxed/simple;
	bh=CzRfEycE8St/H8jiikmRHP9ZHIgFKaRBy78XxdH4pus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bafFh8TAKs0f4Kqrtyafk90p2/AU/P8dJMCFFyGApS8J2TAVy3wZN5a8aJw10gUn4HyAe54CxPGWo4+3pM3sKJw+0Si2YEoOtZz4jlYIT+OBkXymE03ZIAd4OGizSRi9Ccx8vszS/x+bvN4ElW4ZcFN3Vp1vIJMxGx1rKWZqn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=H6puJc2P; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=urZOLOK3hGp0X8ehBzjC8CxIMlGG4rRlhh5lkdEqVPQ=; t=1746574167; x=1747438167; 
	b=H6puJc2Pwq0z8/MUKCHgZ9wXOwb4P8Ik/GZ5wUXlefiHUgg/FMZkh81O5j7GbvmDLFSXYpvqcyE
	kKg4lrtzLfusrlnsc0EDBVe9fm0UN0bby8CX45MOtZL6JFJCg3vk0uW1Sjl3J9O2WDppM5dxmgNBk
	M8uQWIidgf+vyD5hviLNkX/uNzFsWukgMSTOZ3nXnjY7xHtKJeg+bxGjeHR8IXrzGXCgh27kt3PpW
	e/NQ07CGuzCiKhdk94BLcOg4hqlefTd2b++l4ka0FP79nWyPDJe7vHvtcBc3EvplNa88Ul2cktC1K
	I1op4W4naxQXiuTQyncAR94BCIVx6WHCgkwA==;
Received: from mail-il1-f177.google.com ([209.85.166.177]:52681)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCRj3-0004JL-R3
	for netdev@vger.kernel.org; Tue, 06 May 2025 16:29:27 -0700
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d57143ee39so55809185ab.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 16:29:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJhrrUThblXYdbcgJoxWOzh8qvPsPD7g1N7djfajN0UYwXo8aB
	4my7OdulUyF8cYZi/v2dma4Ij6az2aIlEO/9vIxW62pEJ+/DFVfjaI/kRNlX3Hd3z+2LguBle1P
	vaMH2l456mk20S5JUSOhGlfwOtSQ=
X-Google-Smtp-Source: AGHT+IG9Gly1goecGsjK0mpOyoyL5HdM5yhJEbPXriD3Ocm91zzkUXAZlz9bSWW4VtYvxjlw33Rw2JvQ4yWUiB9rsRI=
X-Received: by 2002:a05:6820:1793:b0:608:271a:8d7a with SMTP id
 006d021491bc7-60828d75860mr1067081eaf.7.1746574155116; Tue, 06 May 2025
 16:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-5-ouster@cs.stanford.edu> <1d7a6230-5ece-48f8-9b7d-ec19d6189677@redhat.com>
In-Reply-To: <1d7a6230-5ece-48f8-9b7d-ec19d6189677@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 6 May 2025 16:28:38 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyizsc1Jk9VytJJ8OcCOTHoqUrgzGZUc1WDeanGyEV6pg@mail.gmail.com>
X-Gm-Features: ATxdqUF7DLt07fgj_8SipOtTfRg_h3BTpcmadqDh55IgId83TXnlcv_xS_YVS8A
Message-ID: <CAGXJAmyizsc1Jk9VytJJ8OcCOTHoqUrgzGZUc1WDeanGyEV6pg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 04/15] net: homa: create homa_pool.h and homa_pool.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 1f26ecfccd24954124942d3c02091509

On Mon, May 5, 2025 at 2:51=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> [...]
> > +/**
> > + * set_bpages_needed() - Set the bpages_needed field of @pool based
> > + * on the length of the first RPC that's waiting for buffer space.
> > + * The caller must own the lock for @pool->hsk.
> > + * @pool: Pool to update.
> > + */
> > +static void set_bpages_needed(struct homa_pool *pool)
> > +{
> > +     struct homa_rpc *rpc =3D list_first_entry(&pool->hsk->waiting_for=
_bufs,
> > +                     struct homa_rpc, buf_links);
>
> Minor nit: please insert an empty line between variable declaration and
> code.

Done. For some reason checkpatch.pl doesn't complain about this (or
the next comment below). Until yesterday I wasn't aware of the
--strict argument to checkpatch.pl, which may explain why patchwork
was finding checkpatch errors even though I was running checkpatch. I
have now made a pass over all the Homa code to clean up --strict
issues. But even with --strict, checkpatch.pl doesn't complain about
the indentation problem above. Are there additional switches I should
be giving to checkpatch.pl in addition to --strict?

> > +     pool->bpages_needed =3D (rpc->msgin.length + HOMA_BPAGE_SIZE - 1)
> > +                     >> HOMA_BPAGE_SHIFT;
>
> Minor nit: please fix the indentation above

Fixed.

> > +/**
> > + * homa_pool_new() - Allocate and initialize a new homa_pool (it will =
have
> > + * no region associated with it until homa_pool_set_region is invoked)=
.
> > + * @hsk:          Socket the pool will be associated with.
> > + * Return: A pointer to the new pool or a negative errno.
> > + */
> > +struct homa_pool *homa_pool_new(struct homa_sock *hsk)
>
> The proferrend name includes for an allocator includes 'alloc', not 'new'=
.

Got it. I have scanned the code base and replaced 'new' everywhere
with 'alloc'. I also replaced 'destroy' with 'free'.

> > +{
> > +     struct homa_pool *pool;
> > +
> > +     pool =3D kzalloc(sizeof(*pool), GFP_ATOMIC);
>
> You should try to use GFP_KERNEL allocation as much as you can, and use
> GFP_ATOMIC only in atomic context. If needed, try to move the function
> outside the atomic scope doing the allocation before acquiring the
> lock/rcu.

Will do. I was able to refactor the homa_pool code so that it doesn't
need GFP_ATOMIC.

> > +     pool->num_cores =3D nr_cpu_ids;
>
> The 'num_cores' field is likely not needed, and it's never used in this
> series.

Yep, that field is no longer used. I have deleted it.

> > +     pool->check_waiting_invoked =3D 0;
> > +
> > +     return 0;
> > +
> > +error:
> > +     kfree(pool->descriptors);
> > +     free_percpu(pool->cores);
>
> The above assumes that 'pool' will be zeroed at allocation time, but the
> allocator does not do that. You should probably add the __GFP_ZERO flag
> to the pool allocator.

The pool is allocated with kzalloc; that zeroes it, no?

> > +bool homa_bpage_available(struct homa_bpage *bpage, u64 now)
> > +{
> > +     int ref_count =3D atomic_read(&bpage->refs);
> > +
> > +     return ref_count =3D=3D 0 || (ref_count =3D=3D 1 && bpage->owner =
>=3D 0 &&
> > +                     bpage->expiration <=3D now);
>
> Minor nit: please fix the indentation above. Other cases below. Please
> validate your patch with the checkpatch.pl script.

I have been running checkpatch.pl, but as I mentioned above it doesn't
seem to be reporting everything.

> > +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, u32 *pa=
ges,
> > +                     int set_owner)
> > +{
> > +     int core_num =3D smp_processor_id();
> > +     struct homa_pool_core *core;
> > +     u64 now =3D sched_clock();
>
> From sched_clock() documentation:
>
> sched_clock() has no promise of monotonicity or bounded drift between
> CPUs, use (which you should not) requires disabling IRQs.
>
> Can't be used for an expiration time. You could use 'jiffies' instead,

Jiffies are *really* coarse grain (4 ms on my servers). It's possible
that I could make them work in this situation, but in general jiffies
won't work for Homa. Homa needs to make decisions at
microsecond-scale, and an RPC that takes one jiffy to complete is
completely unacceptable. Homa needs a fine-grain (e.g. cycle level)
clock that is monotonic and synchronous across cores, and as far as I
know, such a clock is available on every server where Homa is likely
to run. For example, I believe that the TSC counters on both Intel and
AMD chips have had the right properties for at least 10-15 years. And
isn't sched_clock based on TSC where it's available? So even though
sched_clock makes no official promises, isn't the reality actually
fine? Can I simply stipulate that Homa is not appropriate for any
machine where sched_clock doesn't have the properties Homa needs (this
won't be a significant limitation in practice)?

Ultimately I think Linux needs to bite the bullet and provide an
official fine-grain clock with ns precision.

> > +
> > +                     limit =3D pool->num_bpages
> > +                                     - atomic_read(&pool->free_bpages)=
;
>
> Nit: indentation above, the operator should stay on the first line.

Fixed but, again, checkpatch.pl didn't report it.

> > +
> > +             /* Figure out whether this candidate is free (or can be
> > +              * stolen). Do a quick check without locking the page, an=
d
> > +              * if the page looks promising, then lock it and check ag=
ain
> > +              * (must check again in case someone else snuck in and
> > +              * grabbed the page).
> > +              */
> > +             if (!homa_bpage_available(bpage, now))
> > +                     continue;
>
> homa_bpage_available() accesses bpage without lock, so needs READ_ONCE()
> annotations on the relevant fields and you needed to add paied
> WRITE_ONCE() when updating them.

I think the code is safe as is. Even though some of the fields
accessed by homa_bpage_accessible are not atomic, it's not a disaster
if they return stale values, since homa_bpage_available is invoked
again after acquiring the lock before making any final decisions. The
worst that can happen is (a) skipping over a bpage that's actually
available or (b) acquiring the lock only to discover the bpage wasn't
actually available (and then skipping it). Neither of these is
problematic.

Also, I'm not sure what you mean by "READ_ONCE() annotations on the
relevant fields". Do I need something additional in the field
declaration, in addition to using READ_ONCE() and WRITE_ONCE() to
access the field?

>
> > +             if (!spin_trylock_bh(&bpage->lock))
>
> Why only trylock? I have a vague memory on some discussion on this point
> in a previous revision. You should at least add a comment here on in the
> commit message explaning why a plain spin_lock does not fit.

I think the reasoning is different here than in other situations we
may have discussed. I have added the following comment:
"Rather than wait for a locked page to become free, just go on to the
next page. If the page is locked, it probably won't turn out to be
available anyway."

> > +     /* The last chunk may be less than a full bpage; for this we use
> > +      * the bpage that we own (and reuse it for multiple messages).
> > +      */
> > +     partial =3D rpc->msgin.length & (HOMA_BPAGE_SIZE - 1);
> > +     if (unlikely(partial =3D=3D 0))
> > +             goto success;
> > +     core_id =3D smp_processor_id();
>
> Is this code running in non-preemptible scope? otherwise you need to use
> get_cpu() here and put_cpu() when you are done with 'core_id'.

Yes, it's non-preemptible since a spinlock is being held on the RPC.

>
> > +     (pool->cores);
> > +     bpage =3D &pool->descriptors[core->page_hint];
> > +     if (!spin_trylock_bh(&bpage->lock))
> > +             spin_lock_bh(&bpage->lock);
>
> I think I already commented on this pattern. Please don't use it.

Sorry, this is not intentional. It came about because the patches for
upstreaming are generated by extracting code from the "full" version
of Homa, removing things such as instrumentation code and
functionality that is not part of this patch series. The stripper is
not smart enough to recognize situations like this where the stripped
code, though technically correct, is nonsensical. I have to go in by
hand and add extra annotations to the source code so that the output
looks reasonable. I have now done that for this situation.

> > +
> > +     /* We get here if there wasn't enough buffer space for this
> > +      * message; add the RPC to hsk->waiting_for_bufs.
>
> Please also add a comment describing why waiting RPCs are sorted by
> message size.

Done. The list is sorted in order to implement the SRPT policy (give
priority to the shortest messages).

> > +             rpc =3D list_first_entry(&pool->hsk->waiting_for_bufs,
> > +                                    struct homa_rpc, buf_links);
> > +             if (!homa_rpc_try_lock(rpc)) {
> > +                     /* Can't just spin on the RPC lock because we're
> > +                      * holding the socket lock (see sync.txt). Instea=
d,
>
> The documentation should live under:
>
> Documentation/networking/
>
> likely in its own subdir, and must be in restructured format.
>
> Here you should just mention that the lock acquiring order is rpc ->
> home sock lock.

I have updated the comment as you requested, and I'll reformat the
.txt files and move them to Documentation/networking/homa.

>
> > +                      * release the socket lock and try the entire
> > +                      * operation again.
> > +                      */
> > +                     homa_sock_unlock(pool->hsk);
> > +                     continue;
> > +             }
> > +             list_del_init(&rpc->buf_links);
> > +             if (list_empty(&pool->hsk->waiting_for_bufs))
> > +                     pool->bpages_needed =3D INT_MAX;
> > +             else
> > +                     set_bpages_needed(pool);
> > +             homa_sock_unlock(pool->hsk);
> > +             homa_pool_allocate(rpc);
>
> Why you don't need to check the allocation return value here?

There's no need to check the return value because if the allocation
couldn't be made, homa_pool_allocate automatically requeues the RPC.
The only time it returns an "error" is if there is no allocation
region. This should never happen in the first place, and if it does
the right response is simply to ignore the error and continue.

> > + * struct homa_bpage - Contains information about a single page in
> > + * a buffer pool.
> > + */
> > +struct homa_bpage {
> > +     union {
> > +             /**
> > +              * @cache_line: Ensures that each homa_bpage object
> > +              * is exactly one cache line long.
> > +              */
> > +             char cache_line[L1_CACHE_BYTES];
>
> Instead of the struct/union nesting just use ____cacheline_aligned

Done.

> [...]
> > +* Homa's approach means that socket shutdown and deletion can potentia=
lly
> > +  occur while operations are underway that hold RPC locks but not the =
socket
> > +  lock. This creates several potential problems:
> > +  * A socket might be deleted and its memory reclaimed while an RPC st=
ill
> > +    has access to it. Homa assumes that Linux will prevent socket dele=
tion
> > +    while the kernel call is executing.
>
> This last sentence is not clear to me. Do you mean that the kernel
> ensures that the socket is freed after the close() syscall?

Apologies... this text is no longer accurate. A socket cannot have its
memory reclaimed until all RPCs associated with the socket have been
ended and reaped. I've revised that documentation so it now looks like
this:

* Homa's approach means that socket shutdown and deletion can potentially
  begin while operations are underway that hold RPC locks but not the socke=
t
  lock. For example, a new RPC creation might be underway when a socket
  is shut down, which could attempt to add the new RPC after homa_sock_shut=
down
  thinks it has deleted all RPCs. Handling this requires careful checking
  of hsk->shutdown. For example, during new RPC creation the socket lock
  must be acquired to add the new RPC to those for the socket; after acquir=
ing
  the lock, it must check hsk->shutdown and abort the RPC creation if the
  socket has been shutdown.

A question for you: do socket-related kernel calls such as recvmsg
automatically take a reference on the socket or do something else to
protect it? I've been assuming that sockets can't go away during
callbacks such as those for recvmsg and sendmsg.

-John-

