Return-Path: <netdev+bounces-236148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C7C38DA5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A425D4E6438
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9E2253EE;
	Thu,  6 Nov 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5Aaifbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9C1DE3CB;
	Thu,  6 Nov 2025 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395733; cv=none; b=dV/Irkeqo7ZN8yuBWtPWZbgri6Gm58u5Lcnk8JrEOOCCjds4Mv8iq+lwq8TblH3ZxjNIWAxIuR7rRulcQSWg18nzUg62HQGs5anTg3ZX1LbIXJ7RB120P288Os5GZwKmad48KujAMo1gQ66Q5gaNKw24jVnCu99N8fCDtKc0M+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395733; c=relaxed/simple;
	bh=ls5bGnGavMV1AN7Di2/vdZqY0U56gOr4tI5eY5v7XTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR6/ukIwWreF99GsHhR7TKVySgHCISNxXhElEjCl3f1y/2/FabhBSglqbRUkBcBoCD1WAn0bsRRKFkyhnhvxnlqOsqRrh45ZvupBAj9IN9/1glk2lYncz4MCr0l58yjOwtAUe/DW8S0YyCvzEQMvJRY3897yC/AMoIVJQyKlw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5Aaifbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC17DC4CEF8;
	Thu,  6 Nov 2025 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395731;
	bh=ls5bGnGavMV1AN7Di2/vdZqY0U56gOr4tI5eY5v7XTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5AaifbmD43HDScHcgMZ+TLConzAlVBy6X6cjKcbtiLKG3QBAExI7kN/jMPs/e7oY
	 +cY8GXF2uhMNAzuqgDp9e1KKviG2A52ZGIjdtJgLJJw2xqu85NNW1/k0rZyteaLava
	 YmTT3vwqt9qQKydT/42vZZH0YWCGVdr3wmTq8rpxaNuOC7rvTJN3atmHSMZGml89k9
	 TlcAYzckIhp+K9a2lKeP76NSw6D7yv0rFrV7+2xdzSu7JfCTx6Ys65m74/JClmxH5q
	 RL/D9ABeZGKJ+b99WBPZVhJy8tyliW+vdjFGL6shm9vyhnvtIrFB33wt0U7rfwZQQy
	 EVNtGjBSg3sjQ==
Date: Wed, 5 Nov 2025 18:22:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, Vedant Mathur
 <vedantmathur@google.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <20251105182210.7630c19e@kernel.org>
In-Reply-To: <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
References: <20251105200801.178381-1-almasrymina@google.com>
	<20251105200801.178381-2-almasrymina@google.com>
	<20251105171142.13095017@kernel.org>
	<CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Nov 2025 17:56:10 -0800 Mina Almasry wrote:
> On Wed, Nov 5, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote: =20
> > > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> > > current gve devmem tcp configuration. =20
> >
> > Hardcoding the ring size because some other attribute makes you think
> > that a specific application is running is rather unclean IMO..
>=20
> I did not see it this way tbh. I am thinking for devmem tcp to be as
> robust as possible to the burstiness of frag frees, we need a bit of a
> generous ring size. The specific application I'm referring to is just
> an example of how this could happen.
>=20
> I was thinking maybe binding->dma_buf->size / net_iov_size (so that
> the ring is large enough to hold every single netmem if need be) would
> be the upper bound, but in practice increasing to the current max
> allowed was good enough, so I'm trying that.

Increasing cache sizes to the max seems very hacky at best.
The underlying implementation uses genpool and doesn't even
bother to do batching.

> > Do you want me to respin the per-ring config series? Or you can take it=
 over.
> > IDK where the buffer size config is after recent discussion but IIUC
> > it will not drag in my config infra so it shouldn't conflict.
>=20
> You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
> configuration"
>=20
> I don't see the connection between rx-buf-len and the ring size,
> unless you're thinking about some netlink-configurable way to
> configure the pp->ring size?

The latter. We usually have the opposite problem - drivers configure
the cache way too large for any practical production needs and waste
memory.

> I am hoping for something backportable with fixes to make this class
> of workloads usable.

Oh, let's be clear, no way this is getting a fixes tag :/

