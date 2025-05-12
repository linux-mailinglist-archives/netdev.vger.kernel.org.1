Return-Path: <netdev+bounces-189882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6615AB44B7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE59D19E729B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F7298C14;
	Mon, 12 May 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xc2IwTMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9472550C4
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077278; cv=none; b=e0dydwSDG4AJMpU9yHNEytv+xCOinCUCI34qwSclsWc3dWz9t1Y5rL1FiaCr4HflOn9SAPtM8RvbC/mX07Gh+mpsohQ+Ac9H4eFQTy8bZ8Q+nMZBa5lb3YSL1ZGVKFZtrOChV9Wb4ouhYLTY6f04SaHeBMvNI6KtaJYYvq+NVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077278; c=relaxed/simple;
	bh=nSw3M6rRmpkbciW/XQfxFWq2eszCHwOBQzhvjLxmTOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EP2FD1OgnCB91bELdjuBeaWdrmYNEu9PliqpLl56HAEVPTKV7EvEK3Tns3IDugymJH/0nrhS4WjX+lsDvV8H3CEz4zBtCQWIZ1NVLsW9sq1zL03+7Fm+s24fcgbp+zi6B6SRhG9N0nUhCrszdunfd1aGbpwe7bCu9mv6t31IBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xc2IwTMZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso2500a12.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077275; x=1747682075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6grkvz4IGQ6h1k6YUz5SWGU/3xxG7rgL4ytaAoxrVus=;
        b=xc2IwTMZdItsXeHUzrjLMZltubWngOxbTl8g2Ayj9NoC+nZw73msQi0xVta1qFBgxQ
         j9RYAuWIWQqlSczjFIRegIBObGYpF/YqfPrHFiFzKrX5z0WvhGMAUQmMGAPKkymW38YP
         f9/LvUS0JbhJ6sMHaa1hd+K/1w1FyqnTwxwLgsMutPnn+y5U4KaZNzS44wUxi/UeXnJT
         lAG9UrTGJj7ahrz+gmKrnw7i0GPogNNwXc0vWdIuMZZrK85ovq47jACvQDymvNzkKCzd
         bxmY4QpY7WZkxsbmWnbquBlNF68kDZx1bIZgn+H9w0E9rujqqf1izKoMlvCYq9Z5Ltx5
         hxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077275; x=1747682075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6grkvz4IGQ6h1k6YUz5SWGU/3xxG7rgL4ytaAoxrVus=;
        b=VwHZqwTJGeSuyBTbpo3AO3UQd9TnyYvQtZa3r+ytljzlRqJqyGrzaPOyYJWVSFSosw
         RhzXlQEzmRJTR9xjj8Nel8u78uDGESeR6IFvfu0b5sbo05BQYSjg74zuchOKkBR/hz9b
         56GZ2Yb3wFKpD963MSIih7IlOM1Nw0Rg3MgBIWmdbDYAyRfr2QruKKQRDc3F/K/eubJy
         Qvf/6KcJHB8dgCFDATBHUaanF2iYP/52ELPZvAXlxTK3c4yMx3Z2/daSugB5dStzyWvJ
         1566Jxa6O4EmQMeGQKNEETi1JTTP/A7we/RYYLH+yZW6sK23B6NJZtxpogMWa+kBXtY9
         Qx7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxhCIfpytAR4GyT+UsLWBuCXFcXygzRvbVOvXMilBJqjEXsa2e3ebG3jcixum5FJQIYBLAh3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cnWBv6OKGq5InDT5Qj8Ch/NMkoBAsaPn0LhJtoi85toQPgi4
	vtVZMtqFm4y0c9UdwrK9gI1m8JzAp5eFZ2tsVBv+Ihy6rA7qV94uJabqQ4hxbXmhQvBAgBroIyT
	atQrL6V7pOR5Gg+Xp7MgNh74zUOjkHXNnrnsRK5DX
X-Gm-Gg: ASbGnctMCNS4pY+HSgWahfvBLMVOF1xYub4hehk8BQUGVjIqQGsnjmSIRuXbCRO5DO+
	FcS9ZXlmnmw48721I2AHeb8pc5WGP5zlibyoKJjejLYgGLtlNJdTewxrMLWvOzO03/PS81fw9UF
	IWvvN0HfuOVKALhKQpvZKD8sQ1l/05eYta02hGAAuyqaurdEtIsWUPZabIxv+CdgI=
X-Google-Smtp-Source: AGHT+IFtZat3CxYkRrxuf4LayeSFUTjMOU/UUK6s3flry2QVc1ThfDr5aYHBrgSXAdeNzDz8w9DKO2TrEjr/VQ451Qs=
X-Received: by 2002:a05:6402:b2e:b0:5fd:2041:88f7 with SMTP id
 4fb4d7f45d1cf-5ff2a33cf76mr16530a12.2.1747077274857; Mon, 12 May 2025
 12:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com> <20250512132939.GF45370@system.software.com>
In-Reply-To: <20250512132939.GF45370@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 12 May 2025 12:14:13 -0700
X-Gm-Features: AX0GCFuWCsCZDfmhnWSbDcL7YWTV_J17ret_1dOAsScEvpk7dr4EAmn0tHdJSi4
Message-ID: <CAHS8izPoNw9qbtAZgsNxAAPYqu7czdRYSZAXVZbJo9pP-htfDg@mail.gmail.com>
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
To: Byungchul Park <byungchul@sk.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:29=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Mon, May 12, 2025 at 02:11:13PM +0100, Pavel Begunkov wrote:
> > On 5/9/25 12:51, Byungchul Park wrote:
> > > To simplify struct page, the page pool members of struct page should =
be
> > > moved to other, allowing these members to be removed from struct page=
.
> > >
> > > Reuse struct net_iov for also system memory, that already mirrored th=
e
> > > page pool members.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >   include/linux/skbuff.h                  |  4 +--
> > >   include/net/netmem.h                    | 20 ++++++------
> > >   include/net/page_pool/memory_provider.h |  6 ++--
> > >   io_uring/zcrx.c                         | 42 ++++++++++++----------=
---
> >
> > You're unnecessarily complicating it for yourself. It'll certainly
> > conflict with changes in the io_uring tree, and hence it can't
> > be taken normally through the net tree.
> >
> > Why are you renaming it in the first place? If there are good
>
> It's because the struct should be used for not only io vetor things but
> also system memory.  Current network code uses struct page as system
> memory descriptor but struct page fields for page pool will be gone.
>
> So I had to reuse struct net_iov and I thought renaming it made more
> sense.  It'd be welcome if you have better idea.
>

As I said in another thread, struct page should not embed struct
net_iov as-is. struct net_iov already has fields that are unrelated to
page (like net_iov_owner) and more will be added in the future.

I think what Matthew seems to agree with AFAIU in the other thread is
creating a new struct, struct netmem_desc, and having struct net_iov
embed netmem_desc.


--=20
Thanks,
Mina

