Return-Path: <netdev+bounces-212266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66CB1EE1A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0B7A3F9C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08598287269;
	Fri,  8 Aug 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="St1vQHwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9227FB37
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675876; cv=none; b=hEqE8Rv3zXy7edLIHIwxwquFLLnjbFEZNyLpUYb2aPGmULdf0dJyFzmq0Fc36bOMzwFSfRris3V3jD8Li1ltSaPKF4BQxSIxAo79kQaMTTsqH8o2OKFkdCdtOVVeYmUlmEAWX9tG0W02W+iG2jjuNa2Aw/3+rsBU+Rs8hk3e4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675876; c=relaxed/simple;
	bh=qWqV/cCg9Bg1mfVGpZAit/gBF2fPmoGWUXgNrlU0GJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAQGMDGO1CPUzYe7dg+0vzewDojh09Qr4EY4HKqt5ljVSloVTdxRqos5L18tis+68wSaGOT5G8A66WHNWtLZxP2JJGxs4e/CZVyLs8LkxDfHtzKur5NQ4lfE4ZNBEBxgSNcnIKXARLopC8BjOaE2/ecTMJZAxg9rWwTPFp90I3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=St1vQHwS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ba0f2f081so644e87.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754675873; x=1755280673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXaRHIxKHmo+v71n2kAA1c+fGSZPzmAH7E7N7+TC49Y=;
        b=St1vQHwSpEJFml8S7syE1ghc0Sor/AD1X6fqA8Ktsv0Hb+w6/x6xwxJ1Pfw+Ff3LhI
         ima7XrIYaCbxJj16dKHZN8orlCbpsIGtTCdwC3V1/AIHsRwX2BCk7WMRfbX2/1ytJUUd
         K+kasc43yKrlW9/r7vkA6LmNd8o2dUCpFxSDEQ0Nlm4Akf3YLl9dAtXE8sz+6BwLmu1D
         +LDQKHh35cIKXAU2fmt3CWe/enuNIrIrnaf8+SFL/rPs/4qX8DcSL21E3050RdhCi1h0
         zo36FvmlSErKpiAOKCyKbZ9YcQwVSMR4zkDdmiWLoxIpOdKHQIsshyIYEUPfys1PyKnz
         LT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754675873; x=1755280673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXaRHIxKHmo+v71n2kAA1c+fGSZPzmAH7E7N7+TC49Y=;
        b=hBURAqTa9DVV9d/vYtnQur106ERy3vby08wxRxlZobjheGmtFi8gkAwg9Ff4mvAVUO
         bPrrGCHn6qqt3IH555hRYxv2ReL+G2gm5zBjjivpnTyvhB0XQtRCTi15YazETAfmbU2Y
         pSGdi6m1a/RNEhy+gU09IVf1qSyZgJICYVxV1PbmC/TI/sp6BTVcn3TTtQY/W3tb/kuf
         YKBXOuUqofHXFMkKGqzWxS32Vtj2LsuzEEGoc12VtI6488HQO8bI0cu35DhGI4E4cDZr
         kSVbgMlh1i6Cm8XiKVM2zRwc/tqzcFtK399WLpV21NY9izG6AAgweaDhLt91LVe5cFO/
         GPzg==
X-Forwarded-Encrypted: i=1; AJvYcCWdIo030KLlR81XOwf38v64GLKcAP2t0nvTQy+ehnxqhsqUflgLqGcVDp5SfUEkVX77WtBewsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gG86eIyp1v3OKVOjjYl4McWxraluUmJbF0Vcx14QEZrDgu4i
	uhhuxXn1O95s3fX/4RBKuHgyYfdq03WPydWF8adQ1TXXhCacATRkMreWDL3mGgV9jx8oQrJs/Ty
	yuiDlgmQvWqT69c+F6ZRnudzDayoG0NOdqvGvB6Ji
X-Gm-Gg: ASbGncvyN1SUze7kQDjvlk0jHjQi0ry9Tr/mJMIVhBKZTFCF1xgaEtl2nCRDcrgRBcx
	cgr6eprT4kyKMedNapwwRqqVMwUiqIpXZ02qB6wpGYfuwrS09dKsSDf/Q+FIUu6fuxHydbHFoCU
	bS/dDEhwTUHz629PDA6ktxvaePzCkikDC5vFEJ/u5F34bXfXhyfXLM/oYNDc3PjBu4EGNW3wFYS
	HrQ/eFKc0ZBV9LpbSzULq6ywlRDW+yTkNg=
X-Google-Smtp-Source: AGHT+IHH/Bdfwpdrye1XnlPV3h9HpFB1/06JHSyWIEdcjNIJ0rmEv5ndWkpAOlHZcLVkI6FjX6YHe5vd+NN3G3A6EIU=
X-Received: by 2002:a05:6512:3683:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cc77c7fafmr13830e87.0.1754675872884; Fri, 08 Aug 2025
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2869548.1754658999@warthog.procyon.org.uk>
In-Reply-To: <2869548.1754658999@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Aug 2025 10:57:40 -0700
X-Gm-Features: Ac12FXxXcgcstidfh2aNH0PAqgqSvM--1mzTOrN4RVQkgf4ePB5KwUufWkqhH1w
Message-ID: <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com>
Subject: Re: Network filesystems and netmem
To: David Howells <dhowells@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: willy@infradead.org, hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:16=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Mina,
>
> Apologies for not keeping up with the stuff I proposed, but I had to go a=
nd do
> a load of bugfixing.  Anyway, that gave me time to think about the netmem
> allocator and how *that* may be something network filesystems can make us=
e of.
> I particularly like the way it can do DMA/IOMMU mapping in bulk (at least=
, if
> I understand it aright).
>

What are you referring to as the netmem allocator? Is it the page_pool
in net/core/page_pool.c? That one can indeed alloc in bulk via
alloc_pages_bulk_node, but then just loops over them to do DMA mapping
individually. It does allow you to fragment a piece of dma-mapped
memory via page_pool_fragment_netmem though. Probably that's what
you're referring to.

I have had an ambition to reuse the netmem_ref infra we recently
developed to upgrade the page_pool such that it actually allocs a
hugepage and maps it once and reuses shards of that chunk, but never
got around to implementing that.

> So what I'm thinking of is changing the network filesystems - at least th=
e
> ones I can - from using kmalloc() to allocate memory for protocol fragmen=
ts to
> using the netmem allocator.  However, I think this might need to be
> parameterisable by:
>
>  (1) The socket.  We might want to group allocations relating to the same
>      socket or destined to route through the same NIC together.
>
>  (2) The destination address.  Again, we might need to group by NIC.  For=
 TCP
>      sockets, this likely doesn't matter as a connected TCP socket alread=
y
>      knows this, but for a UDP socket, you can set that in sendmsg() (and
>      indeed AF_RXRPC does just that).
>

the page_pool model groups memory by NIC (struct netdev), not socket
or destination address. It may be feasible to extend it to be
per-socket, but I don't immediately understand what that entails
exactly. The page_pool uses the netdev for dma-mapping, i'm not sure
what it would use the socket or destination address for (unless it's
to grab the netdev :P).

>  (3) The lifetime.  On a crude level, I would provide a hint flag that
>      indicates whether it may be retained for some time (e.g. rxrpc DATA
>      packets or TCP data) or whether the data is something we aren't goin=
g to
>      retain (e.g. rxrpc ACK packets) as we might want to group these
>      differently.
>

Today the page_pool doesn't really care how long you hold onto the mem
allocated from it. It kinda has to, because the mem goes to different
sockets ,and some of these sockets are used by applications that will
read the memory and free it immediately, and some sockets may not be
read for a while (or leaked from the userspace entirely - eek). AFAIU
the page_pool lets you hold onto any mem you

> So what I'm thinking of is creating a net core API that looks something l=
ike:
>
>         #define NETMEM_HINT_UNRETAINED 0x1
>         void *netmem_alloc(struct socket *sock, size_t len, unsigned int =
hints);
>         void *netmem_free(void *mem);
>
> though I'm tempted to make it:
>
>         int netmem_alloc(struct socket *sock, size_t len, unsigned int hi=
nts,
>                          struct bio_vec *bv);
>         void netmem_free(struct bio_vec *bv);
>
> to accommodate Christoph's plans for the future of bio_vec.
>

Honestly the subject of whether to extend the page_pool or implement a
new allocator kinda comes up every once in a while.

The key issue is that the page_pool has quite strict benchmarks for
how fast it does recycling, see
tools/testing/selftests/net/bench/page_pool/. Changes that don't
introduce overhead to the fast-path could be accomodated, I think. I
don't know how the maintainers are going to feel about extending its
uses even further. It took a bit of convincing to get the zerocopy
memory provider stuff in as-is :D

--=20
Thanks,
Mina

