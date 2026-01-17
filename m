Return-Path: <netdev+bounces-250745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AADD3916E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1D63015A83
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CA827281E;
	Sat, 17 Jan 2026 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHFwbik7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EED137932
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768691028; cv=none; b=s21JXm5g1vjS2cVeR36IraJjsAgJPeyS1g1IIMrCRNvFbO1bCrtzbKJrMA85U53duQTc0uyoPvR5MluK9fUtj/QgOWMZxSjtf+ygcFVhs1LB2Z0S0ljo8NTOwnMYlsZTlno9szkEEU0D8dfU/HYyO8Qgp2FWhsDAr4carmQxeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768691028; c=relaxed/simple;
	bh=nKoaEZWxoBnT9YjT8ZA9EgXzhmQYTJZLwV9LFBUgwk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGAw7OQ0yw27df/PQUB/pJF4Yv9HndqwZyndGGNNKrBmJ1bLjy/DBEtBN7REfBi/fXqWUqNdHq5yc9oRfBdScczTvr3tUzSnb7tqDX35sKKXC2UmACs8TNB2lEP+FOy34YEKKsd3CwJKzrk8fudL3vQLx2gFymr5HYvVymwxol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHFwbik7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF0EC4CEF7;
	Sat, 17 Jan 2026 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768691027;
	bh=nKoaEZWxoBnT9YjT8ZA9EgXzhmQYTJZLwV9LFBUgwk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHFwbik7g+dNuXTzrf+zEAsKA41oksGeO8m06Iw4lKSsu6F+hTdIaOcLp2ETBx1BX
	 XVOmzorXWLtpT9IXqC3C2i83KbhaZlGmydZYz3ZKhvYuq6hu3W/9Eox9wMhTTb4iwh
	 xmozTM/FRxC/c16pEOQu+EIHHJquW+olYVtXGDEc1b2aDlCSovHIbewwv6OU8bi1Rw
	 m+p1gFcLzBehM1KY5Kdf65NyEdDm7hgeatB1hFgn5nZZ2cWsqHkR/tqL59BksuAYsd
	 AzfGqWMFtgJT7Wt3UR5PhZUzg07jq7s5MBFshknCjHTt8ul20nWYsoo25SybtvQ2yl
	 6tMb2uuYuCJ/Q==
Date: Sat, 17 Jan 2026 15:03:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260117150346.72265ac3@kernel.org>
In-Reply-To: <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Jan 2026 19:16:57 +0100 Eric Dumazet wrote:
> On Sat, Jan 17, 2026 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Running a memcache-like workload under production(ish) load
> > on a 300 thread AMD machine we see ~3% of CPU time spent
> > in kmem_cache_free() via tcp_ack(), freeing skbs from rtx queue.
> > This workloads pins workers away from softirq CPU so
> > the Tx skbs are pretty much always allocated on a different
> > CPU than where the ACKs arrive. Try to use the defer skb free
> > queue to return the skbs back to where they came from.
> > This results in a ~4% performance improvement for the workload.
>=20
> This probably makes sense when RFS is not used.
> Here, RFS gives us ~40% performance improvement for typical RPC workloads,
> so I never took a look at this side :)

This workload doesn't like RFS. Maybe because it has 1M sockets..
I'll need to look closer, the patchwork queue first tho.. :)

> Have you tested what happens for bulk sends ?
> sendmsg() allocates skbs and push them to transmit queue,
> but ACK can decide to split TSO packets, and the new allocation is done
> on the softirq CPU (assuming RFS is not used)
>=20
> Perhaps tso_fragment()/tcp_fragment() could copy the source
> skb->alloc_cpu to (new)buff->alloc_cpu.

I'll do some synthetic testing and get back.

> Also, if workers are away from softirq, they will only process the
> defer queue in large patches, after receiving an trigger_rx_softirq()
> IPI.
> Any idea of skb_defer_free_flush() latency when dealing with batches
> of ~64 big TSO packets ?

Not sure if there's much we can do about that.. Perhaps we should have=20
a shrinker that flushes the defer queues? I chatted with Shakeel briefly
and it sounded fairly straightforward.

