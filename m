Return-Path: <netdev+bounces-193388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E80AC3BD1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D53170154
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8061EA7DF;
	Mon, 26 May 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJIekX7+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA121DFDB9
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248840; cv=none; b=S8GTTMQXpnaXFPmDhej4kfbbiJ6cXteKcDxqqYcZQY+wwbEIm2BBk33s375bdPuoUD5m9U+NJExOydYHwpbkZBrRSvHxi27gyKlGL0BXsQl63+/Y5U4PkugfPsn7Scq7V9tDjEA8nv7M4iGChf8PPI5I/KztIQ4ELyta7xp3Khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248840; c=relaxed/simple;
	bh=rwTtRZWCBpccCiljfC4gt2cz8aSV2o9lUsihGbkmj+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjGDTftfMMvmo16Jz9Zh6a2h1VPQjg+JCw6g0b8U1+XShCbqYLZH39iqNJpPfzZMKkIyrBbCsqOE2OqQT48nWAKQ1zSCpv90DDEHcPQmB4VBXJt3V26rH4s+5NK8COfBRs4JBhTcHPzBuG+50eHDtAdBAiexLwMugu/jHR0Rd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJIekX7+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748248836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
	b=MJIekX7+yO2FcjZyDUp26CT2QQHSIm6NFdHHAldpJig93dfoMggC27QQ7/E8F5WuB2mAbJ
	pwievfUwnGqE58pioukXLQwq3mASCW6eTwaM0Cb2RdQ/fhvYLiXGGlWyXTGei7PO5UemMo
	MOnDcDU1F6j7ohGJdM5hcfJG4KRuKgU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-fw8j9w6QOm-9gwGHgQhQig-1; Mon, 26 May 2025 04:40:34 -0400
X-MC-Unique: fw8j9w6QOm-9gwGHgQhQig-1
X-Mimecast-MFC-AGG-ID: fw8j9w6QOm-9gwGHgQhQig_1748248833
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a6759deabso681371fa.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248833; x=1748853633;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
        b=mddgQ015hN+sYoaTKuNZbyFmz05xkL9Vr/2Gr4PQUYNztOZQRahXkveIQP4GTVwg/H
         +PD72zDCAx0czs+DPrtFRxaLFuUn2AQBm6V5sOSX1gfD4Y6Dh2ceWi/te4bifNb/3D1Y
         XYvgbuZDtfXjK5UX0ixw318gnV3igbbpBLNGIjtyULzKHRuSnQhCLcRLvMMlMsWC5GyS
         YXROHI0mtznrkl26LEV5sVTRGrNwxXsQ2MIFPle75fkYh3U6YoaTnXV84NSxbD/CR/01
         xttuXRQcuUrJvGxr6PA6ueWEigDbzpvX30IQfCKfheTGa2MeTyk12bGDjesTsQ8WyKFN
         lr3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9NbjD+9OJXoGaI59gc/wedZ6fmBEwWFFLAp5d3ZSNc5ZCQPegF9DJIOLGA1kT1gbN4gVX+Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNiL9Vl5b3y6ax55RXZnrMoEAjhvpbduow94gXTWFI9iIiJeR
	Xrb6fPHwBY6vZxDE/PBHYBcsfPctlqM0U9KPUeCJ8J5KqthnX4/icM4X+d4uxuisT7SA63CwHgY
	HYtmwvqdAMb6tiXxdPQWk+v91bvKY+WZuuqVB9tHBo55ScM9hG2LqtuzLeQ==
X-Gm-Gg: ASbGncvi16dPvDoM/OmpC8WNp0RrXJxZ2ZHo1mjL+Y1tOSp9oMHiw8eNhQf11eFG12s
	CS+IO6CRSL49DYoJGXdbExRi3CQWa7nEgSyZ9sBNKQkgdPYXLMPOZnoKKReUGDR8cpnZyIqf+rm
	fcuKrLqVGy1ZPSsprqu2LdU1DDEJN28lQ/GvIHJr+bv/oMwnXMhRKv8gOLGJUDe1nTAsoOdJrQ1
	8QTx7fOF4MoKJVput2EtVoHRUS6cN4Pk181lIELSj5dawK3gX14KCzDBgxDt7viNgyl4/eh8pRs
	iciEAJfe
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217310e87.38.1748248832943;
        Mon, 26 May 2025 01:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSksxY/4SDl8nPx9ETpT8GNSo1fb9YNjKF6Ytk8769B3WbBYxWl3jw2VybR5HjV+gllf9dmg==
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217267e87.38.1748248831957;
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f161c7sm5044691e87.24.2025.05.26.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5CC4B1AA3EEA; Mon, 26 May 2025 10:40:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250526023624.GB27145@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 26 May 2025 10:40:30 +0200
Message-ID: <87o6vfahoh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.c=
om> wrote:
>> > >
>> > > To simplify struct page, the effort to seperate its own descriptor f=
rom
>> > > struct page is required and the work for page pool is on going.
>> > >
>> > > To achieve that, all the code should avoid accessing page pool membe=
rs
>> > > of struct page directly, but use safe APIs for the purpose.
>> > >
>> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
>> > > page_pool_page_is_pp().
>> > >
>> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > > ---
>> > >  include/linux/mm.h   | 5 +----
>> > >  net/core/page_pool.c | 5 +++++
>> > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> > > index 8dc012e84033..3f7c80fb73ce 100644
>> > > --- a/include/linux/mm.h
>> > > +++ b/include/linux/mm.h
>> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task=
_struct *t, unsigned long status);
>> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> > >
>> > >  #ifdef CONFIG_PAGE_POOL
>> > > -static inline bool page_pool_page_is_pp(struct page *page)
>> > > -{
>> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> > > -}
>> >=20
>> > I vote for keeping this function as-is (do not convert it to netmem),
>> > and instead modify it to access page->netmem_desc->pp_magic.
>>=20
>> Once the page pool fields are removed from struct page, struct page will
>> have neither struct netmem_desc nor the fields..
>>=20
>> So it's unevitable to cast it to netmem_desc in order to refer to
>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>
> Options that come across my mind are:
>
>    1. use lru field of struct page instead, with appropriate comment but
>       looks so ugly.
>    2. instead of a full word for the magic, use a bit of flags or use
>       the private field for that purpose.
>    3. do not check magic number for page pool.
>    4. more?

I'm not sure I understand Mina's concern about CPU cycles from casting.
The casting is a compile-time thing, which shouldn't affect run-time
performance as long as the check is kept as an inline function. So it's
"just" a matter of exposing struct netmem_desc to mm.h so it can use it
in the inline definition. Unless I'm missing something?

-Toke


