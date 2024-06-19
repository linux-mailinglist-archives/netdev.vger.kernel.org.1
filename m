Return-Path: <netdev+bounces-104907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD290F169
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1C1C23038
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9A4CB4B;
	Wed, 19 Jun 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4z65rEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DF44384
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808990; cv=none; b=suR45CX8FwZdmpDXH21tu0Je6LyhJ0reUkbEvymp+Uj6sVgZCjUSZqYYMFAEnPrJY5PKEIBSRmogjaSrYxor7bYHxdrZh7ZMKJ6moZtWd/d6BgiOFDUq8SF9UF0+hxa2+hq4UMWS1/ffKU3cw32KwSOoBA8UE1I3fPsAlgF6gAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808990; c=relaxed/simple;
	bh=mW5+fCVHeybh0B32xcWiOOoTMwWpS8c0Mq/7VYHU2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhmrTO+maO1KTUSE/I/YN8C0IoQ6wA2/2QgOfitIY+eCaLeILrX772QtRkurLfB7iC8UyhRlTzZqqa6pA434yrRK6a21gQ9+EyuxrZpxdY6k6d7bmhfXGOA8PpM6ef5jgyewKrBmDwLwOjwMkoxI/BDIecTfkc7x/znn5VZUD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4z65rEq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so8510a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718808987; x=1719413787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dscl6UrpkREHEcEax9S2VtvCljdvXW5W5V5gZgFuc7Y=;
        b=K4z65rEqnAqvPnqejH1NBPtO9QxgJuDEpd5UfDchYoUZXUxs+JbhCTqVKXZH2CJ6Cu
         4qWXL3wCK5quuGB3oLz+/7dQjfc/JabFU5J1eLRP2oyq5EMnILUZw153nhjSppZFyfEE
         rHrprDvxjNe6l8jeTBZ8GuYRdM5Y2e68YqGvB+BFphAvE8e4jxcbJg/h4fFN0FP9wtOy
         mXWmtFCeojWBlnzkQQQPmQMeAeAhVePOullHD5rCCE9iVzkeup/7xnmtgtYF1STVxmcD
         o5fd+NkFJg1g7rJuuteC7e3TAppODkEqEWOfHMkfGr6PFvDgxfFiHuOQEpfCNgmDoSId
         nFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808987; x=1719413787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dscl6UrpkREHEcEax9S2VtvCljdvXW5W5V5gZgFuc7Y=;
        b=G1YOEQuU7Rif07FDnBOQyPKpLZliLNkQOdjCrB9xd+K8B5HR6fl4XAaU1O6iUS8mGZ
         HF+KLI+lwW7A+ZT9vdj99QydkXOTnIb3hLgX2xuwXytACo7Lygz1sOUiBf3AnnWwBHxx
         qkX1ogmpLcUOMGbzxFPR0uwITaKOkgNIHgMQlXSNGmIcuDRf/3pVPrSAIoLyX8g3af/w
         zG3fV0ODQ5wUWu+vNX+N6lYQwVGBjpKZECmHn8TpnVZvBxhoiIKCnObCrTr+zo6PoiW6
         z6zh5Q8fgI9NCDYfzN364NcKxWGKh8j3LObMVOTouep427GTJtk+aUwaSE14afFR5K+s
         Ly+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZyjXtvz8sPXREHWYF4LZLR+SKEjQc+2JiRMMJK/uL0/A7I6q2lZPV7/Sb71cA3nR++fpKnx/ixXsZtchihzNgagH0rRuw
X-Gm-Message-State: AOJu0YxwHJYfLo1jzMdhDy5fDgeEUvjyTHEwC22l8uBRRUCn3keUiyPe
	tjBe1n2QLor7Tv+Q9pDQSU6W2jkLamD1vcmZFAjxC9LGEKYyJsnluQ0XgbMDHTpERJkle2wx3dD
	klTkyT262M/nXDuY0I+nRuljh5oMYErItjD0h
X-Google-Smtp-Source: AGHT+IHRc1QplqwYcX+VFOj/+h1rSrrKLd2FNFrokx2G8bh3D2DzsdBKUJmVOIzynujozvQFogwYWDtnO+ie71qDhxo=
X-Received: by 2002:a05:6402:4304:b0:57c:b80b:b2f4 with SMTP id
 4fb4d7f45d1cf-57d0d6d1871mr207302a12.6.1718808986678; Wed, 19 Jun 2024
 07:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617095852.66c96be9@kernel.org> <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me> <Zm9fju2J6vBvl-E0@casper.infradead.org>
 <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me> <407790.1718801177@warthog.procyon.org.uk>
 <0aaaeabc-6f65-4e5d-bdb1-aa124ed08e8b@grimberg.me> <CANn89iLQ+9GYYn0pQpueFP+aYHnoWhqZSws6t6VCNoxs8pwL7w@mail.gmail.com>
In-Reply-To: <CANn89iLQ+9GYYn0pQpueFP+aYHnoWhqZSws6t6VCNoxs8pwL7w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 16:56:15 +0200
Message-ID: <CANn89iKukukmyL_FERQ25bBhkfv-_oUpOW_WFd4=GUFNsJN6OQ@mail.gmail.com>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: Sagi Grimberg <sagi@grimberg.me>
Cc: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jun 19, 2024 at 3:54=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> =
wrote:
> >
> >
> >
> > On 19/06/2024 15:46, David Howells wrote:
> > > Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > >> On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
> > >>>> Probably because kmap() returns page_address() for non-highmem pag=
es
> > >>>> while kmap_local_page() actually returns a kmap address:
> > >>>>
> > >>>>           if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !P=
ageHighMem(page))
> > >>>>                   return page_address(page);
> > >>>>           return __kmap_local_pfn_prot(page_to_pfn(page), prot);
> > >>>>
> > >>>> so if skb frags are always lowmem (are they?) this is a false posi=
tive.
> > >>> AFAIR these buffers are coming from the RX ring, so they should be
> > >>> coming from a page_frag_cache,
> > >>> so I want to say always low memory?
> > >>>
> > >>>> if they can be highmem, then you've uncovered a bug that nobody's
> > >>>> noticed because nobody's testing on 32-bit any more.
> > >>> Not sure, Jakub? Eric?
> > >> My uneducated guess would be that until recent(ish) sendpage rework
> > >> from David Howells all high mem pages would have been single pages.
> > > Um.  I touched the Tx side, not the Rx side.
> > >
> > > I also don't know whether all high mem pages would be single pages.  =
I'll have
> > > to defer that one to the MM folks.
> >
> > What prevents from gro to expand frags from crossing PAGE_SIZE?
> >
> > btw, at least from the code in skb_gro_receive() it appears that
> > page_address() is called directly,
> > which suggest that these netmem pages are lowmem?
>
> GRO should only be fed with lowmem pages.
>
> But the trace involves af_unix, not GRO ?
>
> I guess that with splice games, it is possible to add high order pages to=
 skbs.
>
> I think skb_frag_foreach_page() could be used to fix this issue.

For reference, please look at

commit c613c209c3f351d47158f728271d0c73b6dd24c6
Author: Willem de Bruijn <willemb@google.com>
Date:   Mon Jul 31 08:15:47 2017 -0400

    net: add skb_frag_foreach_page and use with kmap_atomic

