Return-Path: <netdev+bounces-188726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024EAAE62A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7016F75A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C828B7E1;
	Wed,  7 May 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ERyfMmEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510728A706
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634313; cv=none; b=J3DGFa8vFeGtbm2OgdNz7e1xhF9MsL7/A+jX6txF+fSjDhdNKxJ25DKoJznipZhCfd2r7aFysvOTIC/8RFujogalSfbVRo+I48uAHcywZRWEAoOzWjJpQ6XARPMC0nFiRa4y9iCHj/1qVV01apfGgd44nxi1RDB1SqRR9wAgc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634313; c=relaxed/simple;
	bh=zWfyjRXzukjdv9iB2p7z26XPLY1UKZppGq67sNOzr3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0X2dId6LDX8S/NON8YOWYrcI5RPCiuOHOOJ0SihWAwKwcyQxeM8d6Eu/bNs9Jd+oi2DTg+N8kuN/g5DrxOSk2KK8U0eqX4n74CBJ7/KQtM1VEztNV0gWkfVuRTm67NGoNAXTtel9iJok2KbSeMaoD6Y7/G9XWZ43FRuBsHOLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ERyfMmEl; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8V8AOPgOgIIlyJCUklRkjFVvylF2doR05GxKcisJJS4=; t=1746634311; x=1747498311; 
	b=ERyfMmElGyvDTifAEA9UBtss3N6Frc6EvmachUXpV69EQbyYHGPheQsge8XqAy4P578ZxktrKFi
	KAUA8MVTsRJ81rj1jhUQEsJBDH7MGO6CuwXvSZ3xd6mGRubC+aG+EQzGsQTQ19yeSkwN0FZ8IIC9e
	djegbPz5/LunHMSOY2ZpwCl9Myl++Z0tWHhEnLrBw5ndjp0H9IYx1vvDeYrBd0zXAtCEpOIWgSTna
	S1FBiU++cBS+qRbay+v9vV/9y+/vVF3Ga54/NBTGtRaDFKPKzk9KyIivTWUlD48CGrA8a5qSXvr/U
	9txkefjMwhWLvlz4c2gTyWjzmORU5xWqd/IA==;
Received: from mail-qv1-f48.google.com ([209.85.219.48]:42451)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uChN8-0003Lx-4d
	for netdev@vger.kernel.org; Wed, 07 May 2025 09:11:50 -0700
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so1149896d6.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 09:11:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyd3jbLOil1r9FEkL9CZ5YxJWE5GPJ70K/SjBtdSVwflhH/uPB5
	4VJxwny0L3ISigNAz12kyXyKKmeugE22KGXeEDABmGCfv98SmSn7vzYxo/hJfVKrXTXqjDWOyKz
	Js0YlyvxwoShNBdTTktgHPr79uu8=
X-Google-Smtp-Source: AGHT+IE6mxMwr8h4rPaQRbQPgYxPuYMF+kYHWNFMRh9d5Ikzv7AxDK768ZGLboE70QBv2TVmk+Vwo2OcGg3cukXwBNA=
X-Received: by 2002:a05:6808:d53:b0:3f9:176a:3958 with SMTP id
 5614622812f47-40377983b84mr54545b6e.11.1746634298466; Wed, 07 May 2025
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-6-ouster@cs.stanford.edu> <4350bd09-9aad-491c-a38d-08249f082b6d@redhat.com>
In-Reply-To: <4350bd09-9aad-491c-a38d-08249f082b6d@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 7 May 2025 09:11:01 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>
X-Gm-Features: ATxdqUGCL-z2zLup6GS34xfPfoADdTHVoC6LlitTbBAFQJVo4-m2xEWiBQbXW28
Message-ID: <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 05/15] net: homa: create homa_peer.h and homa_peer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 0ea9888c921c024d7a70b5fc6384e66b

On Mon, May 5, 2025 at 4:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:

> On 5/3/25 1:37 AM, John Ousterhout wrote:
> [...]
> > +{
> > +     /* Note: when we return, the object must be initialized so it's
> > +      * safe to call homa_peertab_destroy, even if this function retur=
ns
> > +      * an error.
> > +      */
> > +     int i;
> > +
> > +     spin_lock_init(&peertab->write_lock);
> > +     INIT_LIST_HEAD(&peertab->dead_dsts);
> > +     peertab->buckets =3D vmalloc(HOMA_PEERTAB_BUCKETS *
> > +                                sizeof(*peertab->buckets));
>
> This struct looks way too big to be allocated on per netns basis. You
> should use a global table and include the netns in the lookup key.

Are there likely to be lots of netns's in a system? I thought I read
someplace that a hardware NIC must belong exclusively to a single
netns, so from that I assumed there couldn't be more than a few
netns's. Can there be virtual NICs, leading to lots of netns's? Can
you give me a ballpark number for how many netns's there might be in a
system with "lots" of them? This will be useful in making design
tradeoffs.

> > +     /* No existing entry; create a new one.
> > +      *
> > +      * Note: after we acquire the lock, we have to check again to
> > +      * make sure the entry still doesn't exist (it might have been
> > +      * created by a concurrent invocation of this function).
> > +      */
> > +     spin_lock_bh(&peertab->write_lock);
> > +     hlist_for_each_entry(peer, &peertab->buckets[bucket],
> > +                          peertab_links) {
> > +             if (ipv6_addr_equal(&peer->addr, addr))
> > +                     goto done;
> > +     }
> > +     peer =3D kmalloc(sizeof(*peer), GFP_ATOMIC | __GFP_ZERO);
>
> Please, move the allocation outside the atomic scope and use GFP_KERNEL.

I don't think I can do that because homa_peer_find is invoked in
softirq code, which is atomic, no? It's not disastrous if the
allocation fails; the worst that happens is that an incoming packet
must be discarded (it will be retried later).

> > +     if (!peer) {
> > +             peer =3D (struct homa_peer *)ERR_PTR(-ENOMEM);
> > +             goto done;
> > +     }
> > +     peer->addr =3D *addr;
> > +     dst =3D homa_peer_get_dst(peer, inet);
> > +     if (IS_ERR(dst)) {
> > +             kfree(peer);
> > +             peer =3D (struct homa_peer *)PTR_ERR(dst);
> > +             goto done;
> > +     }
> > +     peer->dst =3D dst;
> > +     hlist_add_head_rcu(&peer->peertab_links, &peertab->buckets[bucket=
]);
>
> At this point another CPU can lookup 'peer'. Since there are no memory
> barriers it could observe a NULL peer->dst.

Oops, good catch. I need to add 'smp_wmb()' just before the
hlist_add_head_rcu line?

> Also AFAICS new peers are always added when lookup for a different
> address fail and deleted only at netns shutdown time (never for the initn=
s).

Correct.

> You need to:
> - account the memory used for peer
> - enforce an upper bound for the total number of peers (per netns),
> eventually freeing existing old ones.

OK, will do.

> Note that freeing the peer at 'runtime' will require additional changes:
> i.e. likely refcounting will be beeded or the at lookup time, after the
> rcu unlock the code could hit HaF while accessing the looked-up peer.

I understand about reference counting, but I couldn't parse the last
1.5 lines above. What is HaF?

> > +     dst =3D homa_peer_get_dst(peer, &hsk->inet);
> > +     if (IS_ERR(dst)) {
> > +             kfree(save_dead);
> /> +            return;
> > +     }
> > +
> > +     spin_lock_bh(&peertab->write_lock);
> > +     now =3D sched_clock();
>
> Use jiffies instead.

Will do, but this code will probably go away with the refactor to
manage homa_peer memory usage.

> > +     save_dead->dst =3D peer->dst;
> > +     save_dead->gc_time =3D now + 100000000;   /* 100 ms */
> > +     list_add_tail(&save_dead->dst_links, &peertab->dead_dsts);
> > +     homa_peertab_gc_dsts(peertab, now);
> > +     peer->dst =3D dst;
> > +     spin_unlock_bh(&peertab->write_lock);
>
> It's unclear to me why you need this additional GC layer on top's of the
> core one.

Now that you mention it, it's unclear to me as well. I think this will
go away in the refactor.

> [...]
> > +static inline struct dst_entry *homa_get_dst(struct homa_peer *peer,
> > +                                          struct homa_sock *hsk)
> > +{
> > +     if (unlikely(peer->dst->obsolete > 0))
>
> you need to additionally call dst->ops->check

I wasn't aware of dst->ops->check, and I'm a little confused by it
(usage in the kernel doesn't seem totally consistent):
* If I call dst->ops->check(), do I also need to check obsolete
(perhaps only call check if obsolete is true?)?
* What is the 'cookie' argument to dst->ops->check? Can I just use 0 safely=
?
* It looks like dst->ops->check now returns a struct dst_entry
pointer. What is the meaning of this? ChatGPT suggests that it is a
replacement dst_entry, if the original is no longer valid. If so, did
the check function release a reference on the original dst_entry
and/or take a reference on the new one? It looks like the return value
is just ignored in many cases, which would suggest that no references
have been taken or released.

-John-

