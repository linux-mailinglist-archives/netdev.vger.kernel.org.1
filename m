Return-Path: <netdev+bounces-161241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2FA2029B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EEF164C81
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63EEAF6;
	Tue, 28 Jan 2025 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7tqGuRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51FE2B9BF
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024365; cv=none; b=ikUA0dngjT9dVpa5nYOX9L9KSmisDO47uSlR/8JB5Q2fLaX8dyvDHeW59Z4qneLmrmzep3J1LrZomkx/cICtD3Ln0HPe6ioFwlCLCCTZbgDGD7HOQecQ4Dd4gd6Lw0YaCoFQErskMEFPXGJTeg0eIQGhWlukN1R+sFJx1bGjnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024365; c=relaxed/simple;
	bh=O+ho3y079HA/YttfwwlC0Yym4BKP4AFb4n1PV/o1wsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV/Wu3Jr0vTcUznEs8RbB8QJJ/YPzn56xwB4gWEoo9EOPmM18XrPbmg/HuSX/xxTTGllCeYUDnBT9pgDiKMxhG7i1Ud2mnWMmbZK7oOSPirSmud7saSoMBGwcFaVG973ouzZDjvpmFhCsgbnrjAFpTUehcMVs4UFTkiH1G8RZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7tqGuRZ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so35151985ab.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738024363; x=1738629163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hy6elYtm//IeUrMlOxCEXBqX4RXeQgD/28B2ErPulo=;
        b=d7tqGuRZDhnlhm8+go1L2Mbm+UGmFylTLq1zCNL65kU+5+rJ8DxUuiP/mSh2JAUEFH
         SZM90QRsN8EQ3gJIikDeYr2lT/xy+SYVQIbCKog1ogQs0C6JiI+ZKtdv9YgsJ+eldp7V
         8Uk+/R846/oeg7X7zjyneqgB4eqm7rP/aGbe+BGLdre5PpaHaOEASBSOMMGaV845BLbm
         QmbT3hRRns3vnRk7rB9KPmY3gq1tfqi9l7b2YmGeRxCX1M5bV0OtS9wcrI577KweF93a
         Prr1PzBvsUqhkKftVhZ1J8bo+DaojZweKj33NDvYBV07AX2/wexvXji5njCYRwDkQYE7
         G9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738024363; x=1738629163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hy6elYtm//IeUrMlOxCEXBqX4RXeQgD/28B2ErPulo=;
        b=PrSMgRNpEAdYIwj3/88/YRQ1KgMA5uysVAIuP3gBOhTY9YoSjzy4vN4rV3A+ZIIAK2
         Mr8PtMdKl7ZMKjtaKZ4RWcYKwigdBw/4J14BCWcauqjzs8L08YoCQF6w2/0iJNukgmK2
         mbtd6B7RtJCWWXHccajY/yh4u77/GNrnAYG67zhQy8wuevXv294bTgXa14uhrzqcAhbP
         vJn1WIjQZ0Oa4pEYfwlEwcl0bfZPmlPSz6fhXCKpjN1gyss34USxZi8A8ZpXrZ/8w9V4
         cKJVgphr/xVcS75CXs29qkUF7oijSaIk4qnQ+dF9INbZ+H7QCANOiOOilSileUlFPIqI
         7nOg==
X-Forwarded-Encrypted: i=1; AJvYcCXlckRQva/MW9SfJV/QZ7yZfghMFd6DlkgU7IkuWxZvc45GxtkJazXSbY9GJpnbVtk8nORqGmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuSH2Rs+6m3aPelsInVtilCDTG+buo2oq9Y1FYGMGvcVnm7Ep
	lBSlcPOXzNyzEbkkpqTDZyd3fVOcxi9BJEHVCKrBUnHZXvlddxA00hzMWYakBwlyghvayZW/Mku
	vjMnbwsAR7OZmg9T0zmYKY8iTBwQ=
X-Gm-Gg: ASbGncuW/lmjCeQkSjAb+xN52gCLAruD6j9Ll07ckKi4HN0H5IAgnpha3UD5AM/XqRj
	z3ZLwV1oWfWZT8aUOHAOgErF89wr5hbqHVA6QUrttbT2AhJvwcZYNrHpSU8kc
X-Google-Smtp-Source: AGHT+IH4BQbx3+u0vBtV0qdfwsBbUoSqE389x4Df57qGjMVI6WqywT6c5aSgrOrGLiUflkH6YmG/SeRt8ojSF3rZD8w=
X-Received: by 2002:a05:6e02:460d:b0:3cf:a0fc:5388 with SMTP id
 e9e14a558f8ab-3cfa0fc5ae8mr261132855ab.19.1738024362793; Mon, 27 Jan 2025
 16:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-7-ouster@cs.stanford.edu>
 <8faebc20-2b79-4b5f-aed6-b403d5b0f33d@redhat.com> <CAGXJAmzY3UQg01ehF1gmnRom_8FzwQHLfKk7EQk1G=RnTzMJnA@mail.gmail.com>
In-Reply-To: <CAGXJAmzY3UQg01ehF1gmnRom_8FzwQHLfKk7EQk1G=RnTzMJnA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jan 2025 08:32:06 +0800
X-Gm-Features: AWEUYZlSJZd7qqg_P0N-scgJ7MZ5BA_qm0oI8tbpa1FEb9ktNPwRDHG1ROj1N-k
Message-ID: <CAL+tcoDRa3+Rz7jxZFAE79=TygBGu-b4=NQS7xU7WK3V9PuzLw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/12] net: homa: create homa_peer.h and homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:16=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Thu, Jan 23, 2025 at 9:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 1/15/25 7:59 PM, John Ousterhout wrote:
> > > +/**
> > > + * homa_peertab_get_peers() - Return information about all of the pe=
ers
> > > + * currently known
> > > + * @peertab:    The table to search for peers.
> > > + * @num_peers:  Modified to hold the number of peers returned.
> > > + * Return:      kmalloced array holding pointers to all known peers.=
 The
> > > + *           caller must free this. If there is an error, or if ther=
e
> > > + *           are no peers, NULL is returned.
> > > + */
> > > +struct homa_peer **homa_peertab_get_peers(struct homa_peertab *peert=
ab,
> > > +                                       int *num_peers)
> >
> > Look like this function is unsed in the current series. Please don't
> > introduce unused code.
>
> Sorry about that. This patch series only contains about half of Homa's
> full functionality. I didn't notice that this function had become
> orphaned during the trimming process. I've removed it now (but not
> before fixing the issues below).
>
> > > +{
> > > +     struct homa_peer **result;
> > > +     struct hlist_node *next;
> > > +     struct homa_peer *peer;
> > > +     int i, count;
> > > +
> > > +     *num_peers =3D 0;
> > > +     if (!peertab->buckets)
> > > +             return NULL;
> > > +
> > > +     /* Figure out how many peers there are. */
> > > +     count =3D 0;
> > > +     for (i =3D 0; i < HOMA_PEERTAB_BUCKETS; i++) {
> > > +             hlist_for_each_entry_safe(peer, next, &peertab->buckets=
[i],
> > > +                                       peertab_links)
> >
> > No lock acquired, so others process could concurrently modify the list;
> > hlist_for_each_entry_safe() is not the correct helper to use. You shoul=
d
> > probably use hlist_for_each_entry_rcu(), adding rcu protection. Assumin=
g
> > the thing is actually under an RCU schema, which is not entirely clear.
>
> Looks like I misunderstood what "safe" means when I wrote this code.
> As I understand it now, hlist_for_each_entry_safe is only "safe"
> against deletion of the current entry by the thread that is iterating:
> it is not safe against insertions or deletions by other threads, or
> even deleting elements other than the current one. Is that correct?

I'm not Paolo. From what I've known, your understanding is correct.
RCU mechanism guarantees that the deletion process is safe.

>
> I have switched to use hlist_for_each_entry_rcu instead, but this
> raises questions. If I use hlist_for_each_entry_rcu, will I need to
> use rcu_read_lock/unlock also in order to avoid complaints from the

rcu_read_lock/unlock() should be used correspondingly. If without, the
deletion would not be safe.

> RCU validator? Technically, I don't think rcu_read_lock and unlock
> are necessary, because this code only needs protection against
> concurrent modifications to the list structure, and I think that the
> rcu iterators provide that. If I understand correctly, rcu_read_lock

RCU would not be helpful if multiple threads are trying to write in
the same buckets at the same time. spin_lock() is a common approach, I
would recommend. Please see __inet_lookup_established() as a good
example.

Thanks,
Jason

> and unlock are only needed to prevent an object from being deleted
> while it is being used, but that can't happen here because peers are
> not deleted. For now I have added calls to rcu_read_lock and unlock;
> is there a way to annotate this usage so that I can skip the calls to
> rcu_read_lock/unlock without complaints from the RCU validator?
>
> > > +/**
> > > + * homa_peertab_gc_dsts() - Invoked to free unused dst_entries, if i=
t is
> > > + * safe to do so.
> > > + * @peertab:       The table in which to free entries.
> > > + * @now:           Current time, in sched_clock() units; entries wit=
h expiration
> > > + *                 dates no later than this will be freed. Specify ~=
0 to
> > > + *                 free all entries.
> > > + */
> > > +void homa_peertab_gc_dsts(struct homa_peertab *peertab, __u64 now)
> > > +{
> >
> > Apparently this is called under (and need) peertab lock, an annotation
> > or a comment would be helpful.
>
> I have now added a __must_hold(&peer_tab->write_lock) annotation to
> this function.
>
> > > +     hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
> > > +                              peertab_links) {
> > > +             if (ipv6_addr_equal(&peer->addr, addr))
> >
> > The caller does not acquire the RCU read lock, so this looks buggy.
>
> I have added rcu_read_lock/unlock calls, but I don't think they are
> technically necessary, for the same reason discussed above.
>
> > AFAICS UaF is not possible because peers are removed only by
> > homa_peertab_destroy(), at unload time. That in turn looks
> > dangerous/wrong. What about memory utilization for peers over time?
> > apparently bucket list could grow in an unlimited way.
>
> Correct: peers are only freed at unload time. I have deferred trying
> to reclaim peer data earlier because it's unclear to me that that is
> either necessary or good. Homa is intended for use only within a
> particular datacenter so the number of peers is limited to the number
> of hosts in the datacenter (100K?). The amount of information for each
> peer is relatively small (about 300 bytes) so even in the worst case I
> don't think it would be completely intolerable to have them all loaded
> in memory at once. I would expect the actual number to be less than
> that, due to locality of host-host access patterns. Anyhow, if
> possible I'd prefer to defer the implementation of peer data until
> there are measurements to indicate that it is necessary.  BTW, the
> bucket array currently has 64K entries, so the bucket lists shouldn't
> become very long even with 100K peers.
>
> > [...]
> > > +/**
> > > + * homa_peer_lock_slow() - This function implements the slow path fo=
r
> > > + * acquiring a peer's @unacked_lock. It is invoked when the lock isn=
't
> > > + * immediately available. It waits for the lock, but also records st=
atistics
> > > + * about the waiting time.
> > > + * @peer:    Peer to  lock.
> > > + */
> > > +void homa_peer_lock_slow(struct homa_peer *peer)
> > > +     __acquires(&peer->ack_lock)
> > > +{
> > > +     spin_lock_bh(&peer->ack_lock);
> >
> > Is this just a placeholder for future changes?!? I don't see any stats
> > update here, and currently homa_peer_lock() is really:
> >
> >         if (!spin_trylock_bh(&peer->ack_lock))
> >                 spin_lock_bh(&peer->ack_lock);
> >
> > which does not make much sense to me. Either document this is going to
> > change very soon (possibly even how and why) or use a plain spin_lock_b=
h()
>
> The "full" Homa uses the "lock_slow" functions to report statistics on
> lock conflicts all of Homa's metrics were removed for this patch
> series, leaving the "lock_slow" functions as hollow shells. You aren't
> the first reviewer to have been confused by this, so I will remove the
> "lock_slow" functions for now.
>
> > > +struct homa_peertab {
> > > +     /**
> > > +      * @write_lock: Synchronizes addition of new entries; not neede=
d
> > > +      * for lookups (RCU is used instead).
> > > +      */
> > > +     spinlock_t write_lock;
> >
> > This look looks potentially heavily contended on add, why don't you use=
 a
> > per bucket lock?
>
> Peers aren't added very often so I don't expect contention for this
> lock; if it turns out to be contended then I'll switch to per-bucket
> locks.
>
> > > +     /**
> > > +      * @grantable_rpcs: Contains all homa_rpcs (both requests and
> > > +      * responses) involving this peer whose msgins require (or requ=
ired
> > > +      * them in the past) and have not been fully received. The list=
 is
> > > +      * sorted in priority order (head has fewest bytes_remaining).
> > > +      * Locked with homa->grantable_lock.
> > > +      */
> > > +     struct list_head grantable_rpcs;
> >
> > Apparently not used in this patch series. More field below with similar
> > problem. Please introduce such fields in the same series that will
> > actualy use them.
>
> Oops, fixed. Several of the following fields are not even used in the
> full Homa.... somehow they didn't get deleted once all of the usages
> were removed.
>
> -John-
>

