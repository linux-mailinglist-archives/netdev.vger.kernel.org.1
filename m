Return-Path: <netdev+bounces-161238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD487A2027E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385AC163D3C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA71FA4;
	Tue, 28 Jan 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ooxBXc0H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60951373
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022841; cv=none; b=mubHJ7uSkitT4ByJcFhI3nZfKCG33EA3I1FbkCdXoGq6hL2SjSnYtJ8p/+K2VaFNtgflYxUm10q3o6BM/ihhwDZPAkCJq9GJhL9oeIhmBVdYnDQP+ZFr4joDJ7SOlj9RNRnvaKcDRbzKL6dtdO/57mnmauXXyfHxRSlbWG5ufOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022841; c=relaxed/simple;
	bh=3H84YXLOODsBpttYCzimmFUsK4PQRGITvsRxFtFASI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYPSkFDqGP7buQ1iN5baXveZgzhPquwdBM1x/KqnL4h44X/1MPDUUVdAUnLeLUUHIDLLMXs1z9636vS53U5muEO/9A7Q8NRBw1Wmr5Lhjmz5RoXSLQlh81otgvdw7DkhrayTJnCNyXZFXTZlYrCRNC7HccVauwCraYd36CITiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ooxBXc0H; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hFp1bU5AgtDW3538qtiFBMqlcVx55gDJ3/nu6HNjymc=; t=1738022839; x=1738886839; 
	b=ooxBXc0Hf4GWj0V24+Vclu88j8IYYwn49ibHmo/Xopw1owWHpq8/kUPi/INXhAylJdn+2LkCP4E
	NXNhkhImiNjn4ukjCtuhXJbug7ZhfVaIm6om2/1WwzPlK0PGqL7l4urHwtF3Z41wzq2ALg8ViDbaK
	HMx9UMEs/A8D+nWe7WEaKJ0pMILEvlCSr/2GptgSEOSvbJBZP38qW4l6IrLEdb15YIxYQgPK+tvIC
	p+6uOb5ydRNq1xcJQbhtBvA2E1rier/ybba3/axLi0UzxDIb1nhba+o5L2qxs/4L4paVjy/UBC5u0
	wUkfyS1RDRTGx8fOVbbdBdah7dSQhplTnlSw==;
Received: from mail-oa1-f46.google.com ([209.85.160.46]:49183)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcZ8Q-0003R3-3J
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 16:07:19 -0800
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29f87f1152cso2631059fac.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:07:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yye6IGPQFXoQss3xAw+qc7XVXPeb4N1tglI2CE6/M0btyXR97Ms
	qU9LgZVduAi23tEC57eoOpI21C4xvHRK8nSB242/8FzN3+xRVhoE9ygrb8RuNljZu1MEWLAUgAf
	Vs7uM/seBUXefINREchDyOzwI1G8=
X-Google-Smtp-Source: AGHT+IHP3cVe/xomJH52nBKVY3IxlHfzxsrkHvex2qFfoPNMzSmzeLiBnD/9/vDDi75BbWLFJZzSR18H2Z6vuiOtDdQ=
X-Received: by 2002:a05:6871:331d:b0:29e:7f5b:b003 with SMTP id
 586e51a60fabf-2b1c0b02791mr22034247fac.22.1738022837467; Mon, 27 Jan 2025
 16:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-7-ouster@cs.stanford.edu>
 <8faebc20-2b79-4b5f-aed6-b403d5b0f33d@redhat.com>
In-Reply-To: <8faebc20-2b79-4b5f-aed6-b403d5b0f33d@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 16:06:40 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzY3UQg01ehF1gmnRom_8FzwQHLfKk7EQk1G=RnTzMJnA@mail.gmail.com>
X-Gm-Features: AWEUYZmJ5EjQJBOUSozI_pUg2zU6h71xVZEETmQ1lC7cIl1Uovrz3TYaRw-7LQ8
Message-ID: <CAGXJAmzY3UQg01ehF1gmnRom_8FzwQHLfKk7EQk1G=RnTzMJnA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/12] net: homa: create homa_peer.h and homa_peer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: bf2d39bfc2650c7e8471b46ddb5f48c6

On Thu, Jan 23, 2025 at 9:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/25 7:59 PM, John Ousterhout wrote:
> > +/**
> > + * homa_peertab_get_peers() - Return information about all of the peer=
s
> > + * currently known
> > + * @peertab:    The table to search for peers.
> > + * @num_peers:  Modified to hold the number of peers returned.
> > + * Return:      kmalloced array holding pointers to all known peers. T=
he
> > + *           caller must free this. If there is an error, or if there
> > + *           are no peers, NULL is returned.
> > + */
> > +struct homa_peer **homa_peertab_get_peers(struct homa_peertab *peertab=
,
> > +                                       int *num_peers)
>
> Look like this function is unsed in the current series. Please don't
> introduce unused code.

Sorry about that. This patch series only contains about half of Homa's
full functionality. I didn't notice that this function had become
orphaned during the trimming process. I've removed it now (but not
before fixing the issues below).

> > +{
> > +     struct homa_peer **result;
> > +     struct hlist_node *next;
> > +     struct homa_peer *peer;
> > +     int i, count;
> > +
> > +     *num_peers =3D 0;
> > +     if (!peertab->buckets)
> > +             return NULL;
> > +
> > +     /* Figure out how many peers there are. */
> > +     count =3D 0;
> > +     for (i =3D 0; i < HOMA_PEERTAB_BUCKETS; i++) {
> > +             hlist_for_each_entry_safe(peer, next, &peertab->buckets[i=
],
> > +                                       peertab_links)
>
> No lock acquired, so others process could concurrently modify the list;
> hlist_for_each_entry_safe() is not the correct helper to use. You should
> probably use hlist_for_each_entry_rcu(), adding rcu protection. Assuming
> the thing is actually under an RCU schema, which is not entirely clear.

Looks like I misunderstood what "safe" means when I wrote this code.
As I understand it now, hlist_for_each_entry_safe is only "safe"
against deletion of the current entry by the thread that is iterating:
it is not safe against insertions or deletions by other threads, or
even deleting elements other than the current one. Is that correct?

I have switched to use hlist_for_each_entry_rcu instead, but this
raises questions. If I use hlist_for_each_entry_rcu, will I need to
use rcu_read_lock/unlock also in order to avoid complaints from the
RCU validator? Technically, I don't think rcu_read_lock and unlock
are necessary, because this code only needs protection against
concurrent modifications to the list structure, and I think that the
rcu iterators provide that. If I understand correctly, rcu_read_lock
and unlock are only needed to prevent an object from being deleted
while it is being used, but that can't happen here because peers are
not deleted. For now I have added calls to rcu_read_lock and unlock;
is there a way to annotate this usage so that I can skip the calls to
rcu_read_lock/unlock without complaints from the RCU validator?

> > +/**
> > + * homa_peertab_gc_dsts() - Invoked to free unused dst_entries, if it =
is
> > + * safe to do so.
> > + * @peertab:       The table in which to free entries.
> > + * @now:           Current time, in sched_clock() units; entries with =
expiration
> > + *                 dates no later than this will be freed. Specify ~0 =
to
> > + *                 free all entries.
> > + */
> > +void homa_peertab_gc_dsts(struct homa_peertab *peertab, __u64 now)
> > +{
>
> Apparently this is called under (and need) peertab lock, an annotation
> or a comment would be helpful.

I have now added a __must_hold(&peer_tab->write_lock) annotation to
this function.

> > +     hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
> > +                              peertab_links) {
> > +             if (ipv6_addr_equal(&peer->addr, addr))
>
> The caller does not acquire the RCU read lock, so this looks buggy.

I have added rcu_read_lock/unlock calls, but I don't think they are
technically necessary, for the same reason discussed above.

> AFAICS UaF is not possible because peers are removed only by
> homa_peertab_destroy(), at unload time. That in turn looks
> dangerous/wrong. What about memory utilization for peers over time?
> apparently bucket list could grow in an unlimited way.

Correct: peers are only freed at unload time. I have deferred trying
to reclaim peer data earlier because it's unclear to me that that is
either necessary or good. Homa is intended for use only within a
particular datacenter so the number of peers is limited to the number
of hosts in the datacenter (100K?). The amount of information for each
peer is relatively small (about 300 bytes) so even in the worst case I
don't think it would be completely intolerable to have them all loaded
in memory at once. I would expect the actual number to be less than
that, due to locality of host-host access patterns. Anyhow, if
possible I'd prefer to defer the implementation of peer data until
there are measurements to indicate that it is necessary.  BTW, the
bucket array currently has 64K entries, so the bucket lists shouldn't
become very long even with 100K peers.

> [...]
> > +/**
> > + * homa_peer_lock_slow() - This function implements the slow path for
> > + * acquiring a peer's @unacked_lock. It is invoked when the lock isn't
> > + * immediately available. It waits for the lock, but also records stat=
istics
> > + * about the waiting time.
> > + * @peer:    Peer to  lock.
> > + */
> > +void homa_peer_lock_slow(struct homa_peer *peer)
> > +     __acquires(&peer->ack_lock)
> > +{
> > +     spin_lock_bh(&peer->ack_lock);
>
> Is this just a placeholder for future changes?!? I don't see any stats
> update here, and currently homa_peer_lock() is really:
>
>         if (!spin_trylock_bh(&peer->ack_lock))
>                 spin_lock_bh(&peer->ack_lock);
>
> which does not make much sense to me. Either document this is going to
> change very soon (possibly even how and why) or use a plain spin_lock_bh(=
)

The "full" Homa uses the "lock_slow" functions to report statistics on
lock conflicts all of Homa's metrics were removed for this patch
series, leaving the "lock_slow" functions as hollow shells. You aren't
the first reviewer to have been confused by this, so I will remove the
"lock_slow" functions for now.

> > +struct homa_peertab {
> > +     /**
> > +      * @write_lock: Synchronizes addition of new entries; not needed
> > +      * for lookups (RCU is used instead).
> > +      */
> > +     spinlock_t write_lock;
>
> This look looks potentially heavily contended on add, why don't you use a
> per bucket lock?

Peers aren't added very often so I don't expect contention for this
lock; if it turns out to be contended then I'll switch to per-bucket
locks.

> > +     /**
> > +      * @grantable_rpcs: Contains all homa_rpcs (both requests and
> > +      * responses) involving this peer whose msgins require (or requir=
ed
> > +      * them in the past) and have not been fully received. The list i=
s
> > +      * sorted in priority order (head has fewest bytes_remaining).
> > +      * Locked with homa->grantable_lock.
> > +      */
> > +     struct list_head grantable_rpcs;
>
> Apparently not used in this patch series. More field below with similar
> problem. Please introduce such fields in the same series that will
> actualy use them.

Oops, fixed. Several of the following fields are not even used in the
full Homa.... somehow they didn't get deleted once all of the usages
were removed.

-John-

