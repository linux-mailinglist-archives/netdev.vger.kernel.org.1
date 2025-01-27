Return-Path: <netdev+bounces-161169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F8A1DBCE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C751886899
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E515ADA6;
	Mon, 27 Jan 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="cMxYFPxy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073D18A6A9
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001058; cv=none; b=K1O2CbG2LAFG5ueIYqvN+qqwd3/6SEozeUil5W603BAGE1veVQPrMGT73E7fdwAjOpZMAS4lW35yegIuB6GKKxZZR4q6jbFkGuwEf13/swmWLBxdHSIf6KYpoGRHk+D9xOvpXtj1/cFUVKcqHVFMYlnnpVg+gO/iFsiREgie07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001058; c=relaxed/simple;
	bh=kQDdEYfwMuxmpqxasJ7UXnb04BVqze4oMzKeiebPB0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtNRctXhbWZNlpHEWAsXdJVAe9bs3B3VMzDm8f7XDEWjnnKmIrKzvNAZgxooAK/YVglpJTGjc0fa0W93Df7wFk0QGNPpb/w8V0fRSCJ532bOhGCf1vyXMQ/BtWZCJofnQkutf+CwCoBO3Cr13/aTRq/9XFfCTuO6fhVDnFv4RwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=cMxYFPxy; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DPGFeD/9iKVFQlrW9z4H/ZDgG65wWXs1y48qkQaEYPI=; t=1738001057; x=1738865057; 
	b=cMxYFPxyZUtwu3CKAozKc72w7eYRYhKxIs0qzEXy2nrYCpZPbHA7ByAl5gvtbJi9z7Tnw+eTtQy
	qwfQUbMZ9z4POfzWxuS8afU/aroONRkIwi4VxOY7EWrJ6lspioCUc10o1W/bPEgp8VylJtRMgHVbg
	+Hh7r5uhJPwlt4vdhrhT0Gdpq4Gsvel6t2WfQQ74x+r8y4gjhufxgq7EVIhCMUK1amdEkjker9cNt
	G2MI6/94OiC2lbvxmXSAMo/EQs/VjQ6q/DjBfv6OWGSvBLaTNz3a0y3CZ1g+iQ4uP0NK8PUAXOBHH
	qwMeDvbWQ/C3A1MTSpjEEeW5dQSEA7qfDH9w==;
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46390)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcTT3-0007gy-IH
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 10:04:14 -0800
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb9ba53f90so1248776b6e.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:04:13 -0800 (PST)
X-Gm-Message-State: AOJu0YwyAAKh6tLchWQ/HhOs99fyOQlnt9A9JtREGwuT1F7fVMqCaH7t
	QwJomPZ5eGaKniqcA23X6HisyUlaY/O/t4zh3y96cbTUPeX4wTMevLH8cPprfnp56FAdjzOIyRc
	gCKgHsJVUX7sKplk1XRN8Ffgt1XI=
X-Google-Smtp-Source: AGHT+IHBevr1ayXKdaDcLG3Q6qsCY8oOFgQ84wBVPGKDTELhf+gKloTQcvYq62wDkuDDuzrlOKOf48F0sg9SJ7hVDBs=
X-Received: by 2002:a05:6871:4608:b0:2b1:8a87:a0e5 with SMTP id
 586e51a60fabf-2b1c0927f09mr22319156fac.16.1738001052997; Mon, 27 Jan 2025
 10:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com>
In-Reply-To: <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 10:03:37 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
X-Gm-Features: AWEUYZl-8h6N68WIrJUKRinyo2AUNIJrQ-oY9FOL1P7Rt26dtTUBbDSArmkAR1o
Message-ID: <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: a2fe995cb7ed4309b2d212c2bd713a7d

On Mon, Jan 27, 2025 at 2:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/27/25 6:22 AM, John Ousterhout wrote:
> > On Thu, Jan 23, 2025 at 6:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> ...
> >> How many RPCs should concurrently exist in a real server? with 1024
> >> buckets there could be a lot of them on each/some list and linear sear=
ch
> >> could be very expansive. And this happens with BH disabled.
> >
> > Server RPCs tend to be short-lived, so my best guess is that the
> > number of concurrent server RPCs will be relatively small (maybe a few
> > hundred?). But this is just a guess: I won't know for sure until I can
> > measure Homa in production use. If the number of concurrent RPCs turns
> > out to be huge then we'll have to find a different solution.
> >
> >>> +
> >>> +     /* Initialize fields that don't require the socket lock. */
> >>> +     srpc =3D kmalloc(sizeof(*srpc), GFP_ATOMIC);
> >>
> >> You could do the allocation outside the bucket lock, too and avoid the
> >> ATOMIC flag.
> >
> > In many cases this function will return an existing RPC so there won't
> > be any need to allocate; I wouldn't want to pay the allocation
> > overhead in that case. I could conceivably check the offset in the
> > packet and pre-allocate if the offset is zero (in this case it's
> > highly unlikely that there will be an existing RPC).
>
> If you use RCU properly here, you could do a lockless lookup. If such
> lookup fail, you could do the allocation still outside the lock and
> avoiding it in most of cases.

I think that might work, but it would suffer from the slow reclamation
problem I mentioned with RCU. It would also create more complexity in
the code (e.g. the allocation might still turn out to be redundant, so
there would need to be additional code to check for that: the lookup
would essentially have to be done twice in the case of creating a new
RPC). I'd rather not incur this complexity until there's evidence that
GFP_ATOMIC is causing problems.

> > Homa needs to handle a very high rate of RPCs, so this would result in
> > too much accumulated memory  (in particular, skbs don't get reclaimed
> > until the RPC is reclaimed).
>
> For the RPC struct, that above is a fair point, but why skbs need to be
> freed together with the RCP struct? if you have skbs i.e. sitting in a
> RX queue, you can flush such queue when the RPC goes out of scope,
> without any additional delay.

Reclaiming the skbs inline would be too expensive; this is the reason
for the reaping mechanism. It's conceivable that the reaping could be
done in two stages: reap skb's ASAP, but wait to reap homa_rpc structs
until RCU gives the OK . However, once again, this would add more
complexity: it's simpler to have a single reaper that handles
everything.

> > The caller must have a lock on the homa_rpc anyway, so RCU wouldn't
> > save the overhead of acquiring a lock. The reason for putting the lock
> > in the hash table instead of the homa_rpc is that this makes RPC
> > creation/deletion atomic with respect to lookups. The lock was
> > initially in the homa_rpc, but that led to complex races with hash
> > table insertion/deletion. This is explained in sync.txt, but of course
> > you don't have that (yet).
>
> The per bucket RPC lock is prone to contention, a per RPC lock will
> avoid such problem.

There are a lot of buckets (1024); this was done intentionally to
reduce the likelihood of contention between different RPCs  trying to
acquire the same bucket lock.  I was concerned about the potential for
contention, but I have measured it under heavy (admittedly synthetic)
workloads and found that contention for the bucket locks is not a
significant problem.

Note that the bucket locks would be needed even with RCU usage, in
order to permit concurrent RPC creation in different buckets. Thus
Homa's locking scheme doesn't introduce additional locks; it
eliminates locks that would otherwise be needed on individual RPCs and
uses the bucket locks for 2 purposes.

> > This approach is unusual, but it has worked out really well. Before
> > implementing this approach I had what seemed like a never-ending
> > stream of synchronization problems over the socket hash tables; each
> > "fix" introduced new problems. Once I implemented this, all the
> > problems went away and the code has been very stable ever since
> > (several years now).
>
> Have you tried running a fuzzer on this code? I bet syzkaller will give
> a lot of interesting results, if you teach it about the homa APIs.

I haven't done that yet; I'll put it on my "to do" list. I do have
synthetic workloads for Homa that are randomly driven, and so far they
seem to have been pretty effective at finding races.

-John-

