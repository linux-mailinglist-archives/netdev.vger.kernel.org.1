Return-Path: <netdev+bounces-173454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954C0A58F67
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C17169A71
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4B224B0B;
	Mon, 10 Mar 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="h/5KiRQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC72248A6;
	Mon, 10 Mar 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598652; cv=none; b=pqsoGZzjptVbKOAA7ekcTgsyexjQ8UFcVZHaWTw4W0KnuDcf2aCmDjSX2U/dKUeW7OjLtJoSYWdrloxeIvk2/6161vgmhUkoRiHOMYyVB6JfJnjK4Z3WhgFKLBlme4XfaF7ZDpK0BtvpRmcu24GRgGVKi5HpXt8A1Q3yGVuhaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598652; c=relaxed/simple;
	bh=tGbHNBv9xSwc1TPHZ6xLc61UvhZA63bQ+RMjSx9gQa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNi8BgBGpVT274gyDq+w4lnd650yZR0UyoGvceRHU+30UojOj1tbYsNRHxQ4zkrW8482w3Kz+2PyQ46EpAW/xcnbxnXUi+p487ie3GU5ZVFhotNxtK3k1J80WTZbKUqEc10ZrtTeI7lv+i1m7JUf4whGJCUKBbCNGUrosP1Jjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=h/5KiRQO; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1741598152; bh=tGbHNBv9xSwc1TPHZ6xLc61UvhZA63bQ+RMjSx9gQa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h/5KiRQOst0lHeHhL37ekuXCMNA8dTF/aj4+0oNb67H4TUWmSpJe8Or79t3yqK1h3
	 OYJzTl7RrvdtS4OYy2M/XcuVPPS0m//liVjJKJxgsJ9HvLyAuId6enCRqNFtEEQpLS
	 4tNCMPJ0VOZVafGWDxpSd50xauLIw6m0igbheMk4o/onW8hlCh/eyjXbzDfvd8ZThw
	 Z7LpMn7wVfGpWDM7HiNgh0sxw7KQv2Ap0QUXIgV3kGEJTnGxHjKLcpvf8LDC7sMZOO
	 wRJip8+uN/rtPNAQD/y5AY89h/TWkW2neV5Dxv4mR32k7ffT+NxSbE6wfgojPEV1HG
	 UiKh7fjhGanwQ==
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Mina
 Almasry <almasrymina@google.com>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool
 benchmark
In-Reply-To: <20250309084118.3080950-1-almasrymina@google.com>
References: <20250309084118.3080950-1-almasrymina@google.com>
Date: Mon, 10 Mar 2025 10:15:48 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a59txn3v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> From: Jesper Dangaard Brouer <hawk@kernel.org>
>
> We frequently consult with Jesper's out-of-tree page_pool benchmark to
> evaluate page_pool changes.
>
> Consider importing the benchmark into the upstream linux kernel tree so
> that (a) we're all running the same version, (b) pave the way for shared
> improvements, and (c) maybe one day integrate it with nipa, if possible.
>
> I imported the bench_page_pool_simple from commit 35b1716d0c30 ("Add
> page_bench06_walk_all"), from this repository:
> https://github.com/netoptimizer/prototype-kernel.git
>
> I imported the benchmark, largely as-is. I only fixed build or
> checkpatch issues.
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> RFC discussion points:
> - Desirable to import it?

I think so, yeah.

> - Can the benchmark be imported as-is for an initial version? Or needs
>   lots of modifications?

One thing that I was discussing with Jesper the other day is that the
current version allocates the page_pool itself in softirq context, which
leads to some "may sleep" warning. I think we should fix that before
upstreaming.

> - Code location. I retained the location in Jesper's tree, but a path
>   like net/core/bench/ may make more sense.

No strong opinion on this...

-Toke

