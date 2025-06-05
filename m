Return-Path: <netdev+bounces-195311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B7ACF78E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A84188FACD
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AC27AC36;
	Thu,  5 Jun 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQMs6X12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC820012C
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149979; cv=none; b=IQ8+vk9zt3AYqnn77raJCLcgzdLA/dK2orhe/bYVa/e7eAUfz63tUQA5HcnDYTEc2zxooA/Iwv/CE4BVwrdW/8hKiQH50SvT48QWYdr8z8wqSm0K5JUar78sZUCSRWADlIY3ceLe1xkmicft+sC8iOqtJ4rOcUZgfvzz2bLRd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149979; c=relaxed/simple;
	bh=uMI+9/1wKveAhyojQMkdj/cma+OSgU0Tqvt6R/U9zEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElEBNCVJTKOwg7t5j2ihrhwhq3x2Q/tlqbgNRgqY13qIFY4XmE1wtqoTrzI6y12+gGadW2sSE97htbpYnOoGuXfwKVYrkFlNDQlQUv3sKSFXM5mbp9Yp4etF4TeNnBNY4upDGsqEmxfMOlN4On0/toCun5RoK/gpQQzC3eZfuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQMs6X12; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2348ac8e0b4so35965ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749149977; x=1749754777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H05/LnQbfBjMagEcyvCs4/p13Cyqf8KAitB4wn3TCi8=;
        b=JQMs6X12Ie7b5Kuvjp+Wtfhqw8qebDsxmrY3zlMuqBkzqFujlbIZGRQAe9OL4tx8Cu
         y1h+1//ZhnrPgaf4pZUgQbhazAHGwXdllposp3EKgnq3R4gO1frlMh70I2aspDdiWZ5Q
         l12siuH1FbsP8ICWPJchfTeyFOJwUy3Mxw2/w+b9V8gGD9gk7Qa2QSjlQ1ChkbGMviWA
         p0CmGmVbJs3i9MyO6m58Pg/cRZ1/6cRw5lYf4ZX+Ra4yCT6maPXCPk4nNr0YLyLYPZJw
         RpzNhzciAyH7NXwuI5nba8lwiA76sBOVFFEJDJop6vzLwMFGRUa4a7wR5lM4AHGvdrcP
         3PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749149977; x=1749754777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H05/LnQbfBjMagEcyvCs4/p13Cyqf8KAitB4wn3TCi8=;
        b=iBqzni1X6VIv3wRsJ1eksyHW+0JXdP4GItJDVS1FN4mpLS/L9Ob02EqWQJOQB/GhHM
         Hy49/BC91/aILrg2qGaFa1Il4cg2f642xlrrBdzZpezmSWw/6SI5lMd8a2WCBwCoxXcD
         EOaBz2dMQjN2n9bC1ocATXsClt3vpKKx1NQj4lGChRhPuBBeUlyX3ebnkLVAZibCcWYA
         9S19XBC7UY47mETJNAGu6k7IgltToUFCfYwxf07uCocq1CHDLBZssVa66tfwjIZOlMj4
         Zx8t2RqfxWkb07YmxCKfwBJXnR/EIrdpsu0wwwWQRkysM26y5WKzQ926vt70ntpTvW4t
         Wlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUxNQ/DI7wqNxq1xxcBH2SbJMHRmQSPcw7uq6HRt7Y/q5IxRmehy0iUXSMK3tDTOu2SIc5QGiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JnDdPQGd08mnrCwLlYdjMdooZB1YrJl6oTcWVU9Rn1gjH7m4
	HsWqDHoutmRtC+ojcMFW0M9Q1NXmhQMKIAdJ7tSgVX6LzeaXVgiP/eQ33JAFZdFwxVWKmEL7wOD
	0/Szo+gbpPuPtpiXfygQLSYNjFx5ekD0hMeEyCE4q
X-Gm-Gg: ASbGnct4xcrpgL4AcAyd5tOm3zL0pAdYJIiFjJzoaNCu11s/9KsF4S+w7DlWBfbDw4F
	6YhPtVA9wQxXaNHiRZtZjKDuqH8ylPy19IAgs/oENM7raudLAQ8DAPqMi1GSSySNPci2elV6sLB
	MgWsWGiELxk3k7F1OyhfRoXEhOMWSI8TVKd4cze/XpAjf+
X-Google-Smtp-Source: AGHT+IH0Z19F+C9739ZW11S4OWSArlhc70SyePq2+bEvFgwOuWKH5ok0NpwbUSbVk9PZRJ/HXQ1ZP8O7qcCObcGc9VM=
X-Received: by 2002:a17:902:cec2:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23602119b58mr512155ad.0.1749149976908; Thu, 05 Jun 2025
 11:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770012.1748618092@warthog.procyon.org.uk> <aDnTsvbyKCTkZbOR@mini-arch>
 <1097885.1749048961@warthog.procyon.org.uk>
In-Reply-To: <1097885.1749048961@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 11:59:24 -0700
X-Gm-Features: AX0GCFvXkMQX3ul5swdW02rs4DNQ2tHgyFN68VxdxFtirNcZNnjY_XTNytYjMiA
Message-ID: <CAHS8izP-6mKM1vEELjRXRj09qwSh_tCDdwA3TWxVuSOYNBGYeA@mail.gmail.com>
Subject: Re: Device mem changes vs pinning/zerocopy changes
To: David Howells <dhowells@redhat.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, willy@infradead.org, hch@infradead.org, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 7:56=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
>
> > >  (1) Separate fragment lifetime management from sk_buff.  No more wan=
gling
> > >      of refcounts in the skbuff code.  If you clone an skb, you stick=
 an
> > >      extra ref on the lifetime management struct, not the page.
> >
> > For device memory TCP we already have this: net_devmem_dmabuf_binding
> > is the owner of the frags. And when we reference skb frag we reference
> > only this owner, not individual chunks: __skb_frag_ref -> get_netmem ->
> > net_devmem_get_net_iov (ref on the binding).
> >
> > Will it be possible to generalize this to cover MSG_ZEROCOPY and splice
> > cases? From what I can tell, this is somewhat equivalent of your net_tx=
buf.
>
> Yes and no.  The net_devmem stuff that's now upstream still manages refs =
on a
> per-skb-frag basis.

Actually Stan may be right here, something similar to the net_devmem
model may be what you want here.

The net_devmem stuff actually never grabs references on the frags
themselves, as Stan explained (which is what you want). We have an
object 'net_devmem_dmabuf_binding', which represents a chunk of pinned
devmem passed from userspace. When the net stack asks for a ref on a
frag, we grab a ref on the binding the frag belongs too in this call
path that Stan pointed to:

__skb_frag_ref -> get_netmem -> net_devmem_get_net_iov (ref on the binding)=
.

This sounds earingly similar to what you want to do. You could have a
new struct (net_zcopy_mem) which represents a chunk of zerocopy memory
that you've pinned using GUP or whatever is the correct api is. Then
when the net stack wants a ref on a frag, you (somehow) figure out
which net_zcopy_mem it belongs to, and you grab a ref on the struct
rather than the frag.

Then when the refcount of net_zcopy_mem hits 0, you know you can
un-GUP the zcopy memory. I think that model in general may work. But
also it may be a case of everything looking like a nail to someone
with a hammer.

Better yet, we already have in the code a struct that represent
zerocopy memory, struct ubuf_info_msgzc. Instead of inventing a new
struct, you can reuse this one to do the memory pinning and
refcounting on behalf of the memory underneath?

--=20
Thanks,
Mina

