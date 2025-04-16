Return-Path: <netdev+bounces-183368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B345A90835
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A374445AF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC01F5820;
	Wed, 16 Apr 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gp7Q5MWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59239191
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819337; cv=none; b=OIJWmbHfn8dyS9WOQILBAehdXBy6KNLLnahhXmKQIwa4W156BhOLPP54xtmLQIQQwsQ79H2/twPdIj9Oki2jcmOv7xivqetyJU5k7xvcgWsj7KfUV/fEZncdaTkPWAYKydcjQXcwZCP1YDRGIT4qj60KIZN71zRhyx72fuF5i9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819337; c=relaxed/simple;
	bh=r0aJic+36zvRTweDQ73VJwSrv/uSINJavi8KFpoSIkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFl4lNqEDPVIcBcvZ+Czn1pubcytJTVu5UqVajoE185DeljvQnBTOa3+Wp+J4Ej8sg7tzpBCgC/a+87WTulxcVE/lUuHx71NS+9N/RS/mpnYUlnxkmzdv+rzHf1CBZiOmMOKYtrN3niYGJnQylF4OfdA/aH7evsiUpai3RP1QLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gp7Q5MWJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so300465ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744819335; x=1745424135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqCWfRvW8Bx8z1ILw2vfbu9SHIro4MFtgFt1NLNthqk=;
        b=gp7Q5MWJcx0NCSykjpyrfPBx1JBVvB2lzTzhLYdwpXDg7ZnoVRriYUSw/24jXzU6xH
         eidaq6cwQNylecUel/eIxbOSE4QTH3zCsMYC71CZIWJQhQH4ielcuMVAvoDqgzVeLxYt
         YQPBHXW4mudG4BZuYkdAvc67oxALLgWkVyfK346B2LrhyazGmwq5azYDoWxB5bCKyBMR
         JJ1w0igTsuJVxxIkA1naYDLJTcGTM7u6ateNyEFzT0qWxdusLXOJfHsMY0kBI8j/1Cna
         8BTk3jrXVzOzhzHj8ayKiwyznMWhIoMcpKhR4RN8A3n/8sDDsZWsKKT+Ny/ch0c7YsJB
         YQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819335; x=1745424135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqCWfRvW8Bx8z1ILw2vfbu9SHIro4MFtgFt1NLNthqk=;
        b=eE8TQ49VSgEb8peDQBRz7ltwLbci1CMCdSsZV01J9qnN9hSJ/CxQlF0FdhwDN+Af2M
         X4ivbhF4kVtK5VBb+G8NtMjzLRNpaiWiIaUGBDYFi8OBpRp7BS/IOKIt9JUrnFwzEA3N
         WwvVyN6DxISaNNMvAkwUd9lJikz/dJCyfIiSnpE7o0X24ZrTDATbnn1UXdhAdS9KOEL/
         YOPAJ9sgDyzYPw5vgXCJUKO/YZ/FylJI91OSCnLgmMOPHZuw5ywSn3SslH/UAbnyu8PU
         tId4xk7gxW3d0Y7twKaeUq1MPugPImKvE6a6lTn4/xvTVKQAE3b6hRjK8IEEwuGL7Y+c
         qH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVr7UFKSr1jdFndnzPLLNoZmoXa+kSYyrlyUVD2qNHTB1SU0/UhBxZRm1H7GG+JpgHb/vxVSBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykWWseQqDUcxYX4grQJjMQKhyWrijg45uRauI6KXil5nWwfPqn
	nJMwM1kd6zkldkJuY538Q/vrkcWxFh6L9NGR0d7sS9QIYyFq+d52cFVMlP0ewoKcTzXcIsRBojY
	msfr4z/yVdy21myie3qlpHh3u6LFZzKeodAmPbMQx9Jl+o0UXA06X
X-Gm-Gg: ASbGnctmuxs2clsTuYNQpHS1JDPmiwhitozGHpAKCEO49FooO1l8uMTmzXxCY5SnRT3
	aaCvVzzi4w5rg06GVJZ9UFv0uM5ksFBmgxi0rOUAo1HMzazMQ5aJ5Kh+Q1VDRjQ1+3Jhfy0sZ5j
	TE7d0aNy6Dvpx5LC67IpH5qOE=
X-Google-Smtp-Source: AGHT+IGmXnoJWXyazz6OrcQcouYZy2ZIDpRCboysaJm6EomGa8Bzpqr8J0kyO/817NzRaxUHrWJ9IrdI1Ae7sknyiqk=
X-Received: by 2002:a17:903:17c3:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-22c355161cemr1864695ad.24.1744819335138; Wed, 16 Apr 2025
 09:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414013627.GA9161@system.software.com> <CAHS8izO_9gXzj2sUubyNSQjp-a3h_332pQNRPBtW6bLOXS-XoA@mail.gmail.com>
 <20250416052448.GB39145@system.software.com>
In-Reply-To: <20250416052448.GB39145@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 16 Apr 2025 09:02:02 -0700
X-Gm-Features: ATxdqUE8Uy9s1W0wBSH4YndYvAUuaOEDBPb9H8KtBNFdSKFp9YHFmbwrniBNsUs
Message-ID: <CAHS8izOBkDdMZhKYegMWYsmEEkzFBrBf6Ds3nenL5AZeKq7-UA@mail.gmail.com>
Subject: Re: [RFC] shrinking struct page (part of page pool)
To: Byungchul Park <byungchul@sk.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev <netdev@vger.kernel.org>, willy@infradead.org, 
	ilias.apalodimas@linaro.org, kernel_team@skhynix.com, 42.hyeyoo@gmail.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:24=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> On Tue, Apr 15, 2025 at 08:39:47AM -0700, Mina Almasry wrote:
> > On Sun, Apr 13, 2025 at 6:36=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > Hi guys,
> > >
> > > I'm looking at network's page pool code to help 'shrinking struct pag=
e'
> > > project by Matthew Wilcox.  See the following link:
> > >
> > >    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> > >
> > > My first goal is to remove fields for page pool from struct page like=
:
> > >
> >
> > Remove them, but put them where? The page above specificies "Split the
>
> We need to introduce a new struct that will be used as a new descriptor
> e.g. bump, instead of struct page, similar to net_iov, overlaying struct
> page for now.
>
> > pagepool bump allocator out of struct page, as has been done for, eg,
> > slab and ptdesc.", but I'm not familiar what happened with slab and
> > ptdesc. Are these fields moving to a different location? Or being
>
> Move to the newly introduced struct e.g. bump and temporarily let it
> overlay struct page for now.
>
> > somehow removed entirely?
>
> And then we can remove the fields from struct page.
>

OK, IIUC, what you're trying to do is fairly straightforward actually.

We already have struct net_iov which overlays the page_pool entries in
struct page, and we use it to represent non-paged memory.

You can create struct bump which overlays the page_pool entries in
struct page (just like net_iov does), and modify all the places in the
net stack and page_pool where we query these entries to query the
entries from the struct bump instead of from the struct page.

> > >    struct {     /* page_pool used by netstack */
> > >         /**
> > >          * @pp_magic: magic value to avoid recycling non
> > >          * page_pool allocated pages.
> > >          */
> > >         unsigned long pp_magic;
> > >         struct page_pool *pp;
> > >         unsigned long _pp_mapping_pad;
> > >         unsigned long dma_addr;
> > >         atomic_long_t pp_ref_count;
> > >    };
> > >
> > > Fortunately, many prerequisite works have been done by Mina but I gue=
ss
> > > he or she has done it for other purpose than 'shrinking struct page'.
> > >
> >
> > Yeah, we did it to support non-page memory in the net stack, which is
> > quite orthogonal to what you're trying to do AFAICT so far. Looks like
> > maybe some implementation details are shared by luck?
>
> Oh.
>
> > > I'd like to just finalize the work so that the fields above can be
> > > removed from struct page.  However, I need to resolve a curiousity
> > > before starting.
> > >
> > >    Network guys already introduced a sperate strcut, struct net_iov,
> > >    to overlay the interesting fields.  However, another separate stru=
ct
> > >    for system memory might be also needed e.g. struct bump so that
> > >    struct net_iov and struct bump can be overlayed depending on the
> > >    source:
> > >
> > >    struct bump {
> > >         unsigned long _page_flags;
> > >         unsigned long bump_magic;
> > >         struct page_pool *bump_pp;
> > >         unsigned long _pp_mapping_pad;
> > >         unsigned long dma_addr;
> > >         atomic_long_t bump_ref_count;
> > >         unsigned int _page_type;
> > >         atomic_t _refcount;
> > >    };
> > >
> > > To netwrok guys, any thoughts on it?
> >
> > Need more details. What does struct bump represent? If it's meant to
>
> 'bump' comes from how page pool works.  See the following link:
>
>    https://en.wikipedia.org/wiki/Region-based_memory_management
>
> However, any better name suggestion from network guys should be
> appreciated.
>
> > replace the fields used by the page_pool referenced above, then it
> > should not have _page_flags, bump_ref_count should be pp_ref_count,
> > and should not have _page_type or _refcount.
>
> These are place holders that might be needed for now but should be
> removed later.
>

I think they need to not be added at all, rather than removed later.
It makes little sense to me to have a _page_type or _refcount entries
in this bump struct when the original page_pool entries in struct page
don't have a _page_flags or _page_type or _refcount, but maybe I
misunderstood and looking at patches would make this clearer.

> > > To Willy, do I understand correctly your direction?
> > >
> > > Plus, it's a quite another issue but I'm curious, that is, what do yo=
u
> > > guys think about moving the bump allocator(=3D page pool) code from
> > > network to mm?  I'd like to start on the work once gathering opinion
> > > from both Willy and network guys.
> > >
> >
> > What is the terminology "bump"? Are you wanting to rename page_pool to
> > "bump"? What does the new name mean?
>
> I hope the link above explain it.
>

To be honest I would drop renaming the page_pool and moving the
page_pool to mm as part of your changes. Those seem to have very
little benefit for what you're trying to do, and what you're doing
seems straightforward enough while keeping the code in place, but
that's just my 2 cents.

--=20
Thanks,
Mina

