Return-Path: <netdev+bounces-88948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281028A90F6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58A528227B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1A3FBB8;
	Thu, 18 Apr 2024 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaQXswJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202333A27B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405930; cv=none; b=L2acbATq/ujxBsqXtUZsV4L6qlhWCTDDt2A++8HIqyODiMPHT+lQqvp1yShQQIQio3cGqGNiAW37wozMNY95pTbS/sdmOjhdAfRfZuPjyVk9Odqgb/g6DZ9JaynSJyUbyXiJJbhcfnekchjZ1FO3QXlfYPs2mW6r4+OSKcgTr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405930; c=relaxed/simple;
	bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB1GoSJKraM3+uoPbTf0Jml3jqWd3Ae/nXj7g3h/aY6q1RWvvR1DRBxdnO9uEUO/7+/Zquh2PiWo4s2DPR2T30TLr6LZ+bLc0desCRN2X6XoZUBzdKGhvnQlWfGtppj9NqJRjksEyNbzyIjQ5VpfaoBtWX7TotYyWGFF8n0+8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaQXswJS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so6776951fa.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713405927; x=1714010727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
        b=iaQXswJSwbd6W25fe4Gm0Pjcaxlny+oZVrwFZ5yeQDqUCqctGQ0oJzeErLjcaqSVjQ
         c5rROx3N5EHWyGn7GYvncjhJ2MW+mzH4mfu0FnHyvfU/krB54BJpgMR7zL7aXg3gHt1h
         Cix3sRYVObXpzTpratyv/GQAbufq/aQo47i5wFdquZDGtwXA1bRzIChHOiU9gnz9YgWO
         pVtgb4K/M67JhK2l5S2DYN/nP1WKudwWA/AFyov3uh9pQgyGoFU2m8gEh9/1UdgACd/e
         /VoLNfpm6mfQJYZ3SJRs1JomoDjYLJ055rtMehVwPTfjEW5/Vs2/KqpkVDlMUOR2Prfc
         BuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405927; x=1714010727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
        b=IgsWX/o6xWKmnSSB5hAiPhPjaI/Wr82O58Pbr3wf+JhQYvdAt34pmfvvZwf4fuDpJ7
         ClfyfE0yvdinWboNsD8WqBDE7OmhNwULb9xG7fMh4CUOzPOyBsUdRxKskTG1PFjjdC4f
         TELWhNfb3qSjLLJe8lZ8ekzkowdSaypbZXwipHPGAwXDLWKYwSo5odAyW54Ox7f5hJdA
         3pPaQ7zIx+1JdKb2RTo0AIaUZxOO4wACvzjwyU6l6jw/3Osm0M0dJG59tBSnSCcYGYC0
         F2x/AsY5yTOIIzJC1VgYzyWTd8OAQBHnEVvlNiL8tC06yEP4vJ3wkNiXAoitvh+6ZN+J
         CEqg==
X-Forwarded-Encrypted: i=1; AJvYcCUtmvT2vUInnLBdD/yEnq51X5K5bKTCbe4rlcOI6LWbxF/hKc3jtuHr7FoD+oFOvQ82qjQvIfgC4IL6IAAM99yWd0Zik+wg
X-Gm-Message-State: AOJu0Yw6c5RcqCDog3diHw4b3Mwf4evn6xQySxf3s1J4tXYuA62jxx96
	fAuJwdiV87EnXBngqEdYGEMpxvJQNH0UemgQTWh0V/xfyd/EPdYX4v4TqhSPZuoA9Zg88bF2luG
	fYtxDUjxvxFwZrig+GIehJ70FCn/d/ACLyVf0
X-Google-Smtp-Source: AGHT+IFCm3pN2ShD28Z+g4gvIKer7DIONCtgHex5oajrniOoI2un8C3zrZeQwrRhrc0hLYs0bHNGtT9KLILyXzzacvw=
X-Received: by 2002:a2e:9003:0:b0:2d8:bda5:c5f5 with SMTP id
 h3-20020a2e9003000000b002d8bda5c5f5mr644366ljg.35.1713405927096; Wed, 17 Apr
 2024 19:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org> <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
 <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
 <4fd9106c-40a6-415a-9409-c346d7ab91ce@redhat.com> <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
 <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
 <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org> <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
 <9f6333ec-f28c-4a91-b7b9-07a028d92225@kernel.org> <f6daabzdesdwo7zdouexow5mdub3qnzr7e67lonmhh3itjgk5j@qw3xpvqoyb7j>
In-Reply-To: <f6daabzdesdwo7zdouexow5mdub3qnzr7e67lonmhh3itjgk5j@qw3xpvqoyb7j>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:04:50 -0700
Message-ID: <CAJD7tkYnSRwJTpXxSnGgo-i3-OdD7cdT-e3_S_yf7dSknPoRKw@mail.gmail.com>
Subject: Re: Advice on cgroup rstat lock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jesper Dangaard Brouer <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeelb@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

[..]

> > > I personally don't like mem_cgroup_flush_stats_ratelimited() very
> > > much, because it is time-based (unlike memcg_vmstats_needs_flush()),
> > > and a lot of changes can happen in a very short amount of time.
> > > However, it seems like for some workloads it's a necessary evil :/
> > >
>
> Other than obj_cgroup_may_zswap(), there is no other place which really
> need very very accurate stats. IMO we should actually make ratelimited
> version the default one for all the places. Stats will always be out of
> sync for some time window even with non-ratelimited flush and I don't
> see any place where 2 second old stat would be any issue.

We disagreed about this before, and I am not trying to get you to
debate this with me again :)

I just prefer that we avoid this if possible. We have seen cases where
the 2 sec window caused issues. Not because 2 sec is a long time, but
because userspace reads the stats after an event occurs (e.g.
proactive reclaim), but gets stats from before the event.

[..]
>
> >
> >
> > With a mutex lock contention will be less obvious, as converting this to
> > a mutex avoids multiple CPUs spinning while waiting for the lock, but
> > it doesn't remove the lock contention.
> >
>
> I don't like global sleepable locks as those are source of priority
> inversion issues on highly utilized multi-tenant systems but I still
> need to see how you are handling that.

For context, this was discussed before as well in [1].

[1]https://lore.kernel.org/lkml/CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com/

