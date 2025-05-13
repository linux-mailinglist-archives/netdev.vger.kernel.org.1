Return-Path: <netdev+bounces-190257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72024AB5E5D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CA24A42A8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40901FFC4B;
	Tue, 13 May 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEbxESnY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA619E967;
	Tue, 13 May 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171312; cv=none; b=E6CmnomhDdYta9TUI7KaH9GOQljTQAV6L3HOXvARdgSOLyNxqCiKKgrEzXEcmKYt8aodvs7F6DWXgPctaSMdPX6VoTLlUVnmnOR290S3Y9Yl8gcxhrAwa39V5g+bZi+6Ic6Sd8wjB3R5obk9rrzto33eahFXjtw70kn/wIt/AIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171312; c=relaxed/simple;
	bh=zFhGKv0C5VNgNA3NK+6kUhwjof1Pm8va/22wZtE4gOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5BFi6/d6lcJ+IPETZnMoldN7PMejSpNcBi3x2gTxylQwk2IJo5ivd51kiq9nV9vj7zpjs5ROZqum96vUSriFt8XuGbWUb3/t30N5E5ZhbmLmyxXZObOgE9IDVAHJLYkwia8LjPRgM319FnCyWfzqfJ6K3F9XCd2vNHcOQgleNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEbxESnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6340C4CEE4;
	Tue, 13 May 2025 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747171312;
	bh=zFhGKv0C5VNgNA3NK+6kUhwjof1Pm8va/22wZtE4gOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEbxESnYQ9HDL448rzcTb6oI094WpbQhDeSJfW12Je4ipJaJ4Hs7SRkB2ax7vSwl4
	 y5sS9+tRtSdQw2FYspiIG/ci6IbBJFPt8vnk65X8YV5R46Jx9WsyDlivfqLaEQGMV1
	 glW2hxuP1YYn9RFRNAHNp0yjtS1h/8mqdaYSdW1saaVormyl1qo0opjKwWgwi+q7OZ
	 1JyfAw56lw4ngbDnABL5ZeG4ytxsGzDhMe9XAgqQ9x9otX+FjjvJV9F9Bh18rQE7WC
	 EjOJoOjrdDZ4hEgtz1rKfzrtB1BDfvXjeZyVfKB4PX4JgpoIoVaURdbpgJLeSmpkac
	 d/6F7Pk4ajclA==
Date: Tue, 13 May 2025 14:21:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangchangzhong@huawei.com
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
Message-ID: <20250513142150.3cb416e1@kernel.org>
In-Reply-To: <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
	<CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 13:06:38 -0700 Mina Almasry wrote:
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2b76848659418..8654608734773 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1146,10 +1146,17 @@ static void page_pool_scrub(struct page_pool *pool)
> 
>  static int page_pool_release(struct page_pool *pool)
>  {
> +       bool in_softirq;
>         int inflight;
> 
> +
> +       /* Acquire producer lock to make sure we don't race with another thread
> +        * returning a netmem to the ptr_ring.
> +        */
> +       in_softirq = page_pool_producer_lock(pool);
>         page_pool_scrub(pool);
>         inflight = page_pool_inflight(pool, true);
> +       page_pool_producer_unlock(pool, in_softirq);

Makes sense! A couple minor notes.

Consumer lock should be outside, but really we only need to make 
sure producer has "exited" right? So lock/unlock, no need to wrap
any code in it.

I'd add a helper to ptr_ring.h, a "producer barrier" which just
takes/releases the producer lock. We can't be in softirq context
here but doesn't matter, let's take the lock in "any" mode IOW
irqsave() ?

The barrier is only needed if we're proceeding to destruction.
If inflight returns != 0 we won't destroy the pool so no need
to touch producer lock.

