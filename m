Return-Path: <netdev+bounces-157322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE4A09F29
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9E3A4454
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE79137E;
	Sat, 11 Jan 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="P/8RE/2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEC1114
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554811; cv=none; b=Obwz2ZqynFvre6b9pL5aIEO0rCL/f/nbOgFP11n1RUcjqIC0GNf2UCqwXkOgEHm/U//TXTfPQqDz14d3KO+y/mnUVmnYm99d2MfuDBAoDanD/67t8ztOdxKpuhP9m+UaiUGOQg634U7ulvM3A6Ud3bCZtxTBETMzTw3uied19NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554811; c=relaxed/simple;
	bh=Cl8Ogfern4wjXGSfcZ/r6eG1mSxL+gg3/GkgwlSLk2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX9d5WMEBS5KcFW6vliJj8+SwtTVymGjKUh68wpm46ra0vqEd55O1kr53Xz4A2JucpaNreapqvWTpv2i2pD1DmP5pp2FmfBKGvOWwvy2S10TpCJ6U69fFSDFzdncoaTnB//0gHsXaoni6kbqJPtiOJj9x85RstkfRsqijZxxuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=P/8RE/2M; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4TJ5EI9Ns4xdgpHQ1UN8fTXBwekslWQFsYrLSt5XhKQ=; t=1736554809; x=1737418809; 
	b=P/8RE/2M0Q5ebX61QTRLJS6JYKvluZzywZO8D42aeAc3YH2SBUTeAV/+yOJPVbIHD3aVwc11P2Z
	AzFgB66/p4owsuhd8EevjWWIjBulwP3QYLdn9dXE0+GYRUUEQYoM2n5510cu9O0zlt5YeeKBokH2S
	43zbSQS7N5TGl12K+rdK0zJJbyBwK9NscKy5d6eWENkzuh9wDZiNbEEq9sRA5psaCUngVs6sDuXo6
	ng2XV9SJQsrJOCY2IE5Nx3dex0QgcD9nNsFu6+Hz5Ig6bp0ksYqTm/0b4E3VHULv+6X5PkoO8ofRh
	EHslSbp9cJosUiFRR01KM/HS6ROFSKKSo1Dw==;
Received: from mail-oo1-f45.google.com ([209.85.161.45]:50578)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tWPEP-0003xk-WF
	for netdev@vger.kernel.org; Fri, 10 Jan 2025 16:20:03 -0800
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f4cc48ab37so788924eaf.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:20:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yy9raHmIcnA//D4zgs/l1U8wAJE2BHMOlf5302AIc6csNsdFZrS
	3l1vpKGnWObYIpes+Wx3QF36ifW842AAXC9txvn4OC03mD6J03I4yz0GrEo0MsVh3z/4RyDDrT0
	1b2aq+FVOOOzhynTM7NgmC0hPOo8=
X-Google-Smtp-Source: AGHT+IGqx4OVHTR5RaypoZFPwgy9DWFZi3fdNqZYGXTNx88rDMs84AHYI8Lh2E4OkgxAK0HrZMy+rAs2L82WtIhPC/8=
X-Received: by 2002:a05:6870:414b:b0:29e:5e54:76d9 with SMTP id
 586e51a60fabf-2aa06704bcdmr6949482fac.11.1736554801369; Fri, 10 Jan 2025
 16:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-8-ouster@cs.stanford.edu>
 <20250110092537.GA66547@j66a10360.sqa.eu95>
In-Reply-To: <20250110092537.GA66547@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 10 Jan 2025 16:19:24 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
X-Gm-Features: AbW1kvZh0I1MO_zpS4oUK-dRUYnpBlEAI1oJD4kaKUdUHZ2u3BmBj6YGhAfTWoI
Message-ID: <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and homa_sock.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: 1a99e790efc5595ebc7b409aae77a077

On Fri, Jan 10, 2025 at 1:25=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> > +void homa_sock_unlink(struct homa_sock *hsk)
> > +{
> > +     struct homa_socktab *socktab =3D hsk->homa->port_map;
> > +     struct homa_socktab_scan *scan;
> > +
> > +     /* If any scans refer to this socket, advance them to refer to
> > +      * the next socket instead.
> > +      */
> > +     spin_lock_bh(&socktab->write_lock);
> > +     list_for_each_entry(scan, &socktab->active_scans, scan_links) {
> > +             if (!scan->next || scan->next->sock !=3D hsk)
> > +                     continue;
> > +             scan->next =3D (struct homa_socktab_links *)
> > +                             rcu_dereference(hlist_next_rcu(&scan->nex=
t->hash_links));
> > +     }
>
> I can't get it.. Why not just mark this sock as unavailable and skip it
> when the iterator accesses it ?
>
> The iterator was used under rcu and given that your sock has the
> SOCK_RCU_FREE flag set, it appears that there should be no concerns
> regarding dangling pointers.

The RCU lock needn't be held for the entire lifetime of an iterator,
but rather only when certain functions are invoked, such as
homa_socktab_next. Thus it's possible for a socket to be reclaimed and
freed while a scan is in progress. This is described in the comments
for homa_socktab_start_scan. This behavior is necessary because of
homa_timer, which needs to call schedule in the middle of a scan and
that can't be done without releasing the RCU lock. I don't like this
complexity but I haven't been able to find a better alternative.

> > +     hsk->shutdown =3D true;
>
> From the actual usage of the shutdown member, I think you should use
> sock_set_flag(SOCK_DEAD), and to check it with sock_flag(SOCK_DEAD).

I wasn't aware of SOCK_DEAD until your email. After poking around a
bit to learn more about SOCK_DEAD, I am nervous about following your
advice. I'm still not certain exactly when SOCK_DEAD is set or who is
allowed to set it. The best information I could find was from ChatGPT
which says this:

"The SOCK_DEAD flag indicates that the socket is no longer referenced
by any user-space file descriptors or kernel entities. Essentially,
the socket is considered "dead" and ready to be cleaned up."

If ChatGPT isn't hallucinating, this would suggest that Homa shouldn't
set SOCK_DEAD, since the conditions above might not yet be true when
homa_sock_shutdown is invoked.

Moreover, I'm concerned that some other entity might set SOCK_DEAD
before homa_sock_shutdown is invoked, in which case homa_sock_shutdown
would not cleanup the socket properly.

Thus, it seems safest to me for Homa to have its own shutdown flag.

Let me know if you still think Homa should use SOCK_DEAD.

> > +
> > +     while (!list_empty(&hsk->dead_rpcs))
> > +             homa_rpc_reap(hsk, 1000);
>
> I take a quick look at homa_rpc_reap, although there is no possibility
> of an infinite loop founded currently, it still raises concerns.
>
> It might be better to let homa_rpc_reap() handle this kind of actions by =
itself.
> For example, code like that:
>
> homa_rpc_reap(hsk, 0, flags=3DRPC_FORCE_REAP|RPC_REAP_ALL);
>
> In this way, anyone making modifications to homa_rpc_reap() in the future=
 will
> at least be aware that there is such a case that needs to be handled well=
.

I have changed the API for homa_rpc_reap to this:

int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)

The caller can no longer specify a count. When reap_all isn't
specified, homa_rpc_reap determines for itself what represents a
"small amount of work" to perform; no need for the caller to figure
this out.

-John-

