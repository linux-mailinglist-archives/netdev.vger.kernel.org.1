Return-Path: <netdev+bounces-231028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4388BF4135
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8D54E2149
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901962EC08D;
	Mon, 20 Oct 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ3dYoUc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B1238C1F
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004421; cv=none; b=hgzJCCe0QZlaNkcTBTHfhMwAdGV5BSATd8qrc2EMuVdDR5kgLKx3MnbdO6MSlToV0uqwn85AzDpS4gsMqIR/BMm9SBCZO+RVGbSR24QGe0QFjpD/wC79x0fMcMd0Az0bLW2+a1onXNKPTRCQsJxEbDPFJR0RpOhk7jdtty29qFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004421; c=relaxed/simple;
	bh=f4KHYXNeliT82bWg7tQd1dOcYLuGXx3ar2NGZNdgM0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jA9nfHmKF7oRyowXdoA5PEA3L/DmhbFDcUo8JRiJQ7o+irhsiSzu427G3HY+YfwU7INmaNO57PNWKxv2pZhf4KjAcxHD0zVNufi42En30ph+fNA45snSwjhixuWXafv35RuWtBY3HzZme2lTXtEYnxDWLktuVIaoO31oQ6cP4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ3dYoUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D059C4CEFB;
	Mon, 20 Oct 2025 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761004420;
	bh=f4KHYXNeliT82bWg7tQd1dOcYLuGXx3ar2NGZNdgM0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IZ3dYoUcF7jHLXpNUgT0L8dszcv6chDG44kPJROBmWbfcuzinKJXo8PcQ4PCAaJ78
	 kR0TWAnTbWFUW3SRUCVpquUk72Y9k7IWa5gmqqwjFU8J4jFxjDQszLEkHuq0qOYtZU
	 /rddLFhjfs2ocrhvzrY2Shy6y4DJfiVLBRqOAicLWbT19D7bu19+wkHiLlnhvT2LrL
	 Tibb2CK7yZcJZvE4Hce/kIK6FUVAMvdibcmVUOUgraP/7KzCEwdf7sXN/asgiCvAkY
	 pu0gSu5h40njRC4lqXoGxFqfsijiem1Gy82DS7U2czwtsh3if/Wxcpf3C88eXifyu5
	 BfATPbwSWCviA==
Message-ID: <547630af-642c-49f9-b511-bd45dd65e20f@kernel.org>
Date: Mon, 20 Oct 2025 17:53:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gro_cells: fix lock imbalance in
 gro_cells_receive()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20251020161114.1891141-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251020161114.1891141-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 10:11 AM, Eric Dumazet wrote:
> syzbot found that the local_unlock_nested_bh() call was
> missing in some cases.
> 
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.2.329/7421 is trying to acquire lock:
>  ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30
> 
> but task is already holding lock:
>  ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock((&cell->bh_lock));
>   lock((&cell->bh_lock));
> 
>  *** DEADLOCK ***
> 
> Given the introduction of @have_bh_lock variable, it seems the author
> intent was to have the local_unlock_nested_bh() after the @unlock label.
> 
> Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
> Reported-by: syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68f65eb9.a70a0220.205af.0034.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/gro_cells.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



