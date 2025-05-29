Return-Path: <netdev+bounces-194139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EBAC76F3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493207A5AEB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5EC21ADC7;
	Thu, 29 May 2025 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/b+JBhT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF41D5CFE;
	Thu, 29 May 2025 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491797; cv=none; b=WhvCTiSOwQmQ5m6oD0D7+JDzW63wqdUhFWiY8YfaR5xrmpKUyIhDQEJ2Mj/3LZeO79ZoXosgjITdXRVypCC+dedLfiaphRfoWTh3rdF8tadQdVx3NuKOQ2XdnpGQSwRDG9KVWdPTcI3vPE4omnW6GnlsF5T57kYInDl+Zf9OoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491797; c=relaxed/simple;
	bh=EvTXQV/V9BLYoQXJAAARdV+vxG/Xp6Gp0ol3AVyRpEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ONp3uN2u0Ligo4bQ1MpAqZunY8H7ezS7YiI0ZL/4ocjQzOXV1HmL6njGRPlZpJF9d/Wm5fr7uPrLmuCDAJvrmNokRkRh4WR00rsgJz7g41z42VAL+mUCRrqW4vRheqAz4kKqZbK8esYfgP8JOCrmuEk95A9+IlBigAoaHndW7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/b+JBhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FDBC4CEEB;
	Thu, 29 May 2025 04:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491797;
	bh=EvTXQV/V9BLYoQXJAAARdV+vxG/Xp6Gp0ol3AVyRpEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/b+JBhTOnxpOeXBdagtlLMPVArmNWSInftX4nOXBAavf5QHQNN1IyB3xYyLuDGPn
	 W5tBQx4HuE3QjSHZ3G/m7jRzLyOuaR/5Bj1YIK2NBpolsnV/Q3M9KrDrd3ju+VR4X/
	 iEsraZGAF1pzUtuCmX9xkItHdoDldsXVW7rkblONO65Y5lhavkh6iNLrq7qw+9VbtD
	 MsWyr86sga9bUTHb6synZuuWj3hsars+T2YE9kTYWbu4QrgMBMYItXgFs1JluIUQyt
	 KRRRZRxE+pRIbBxwkr2NMRZldcWqkyc0FLdatogHFNUt5ViYvnFH/eaDgXMPlXYcs2
	 4ctWWl01285kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3E3822D1A;
	Thu, 29 May 2025 04:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174849183100.2759302.4461849519042994301.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 04:10:31 +0000
References: <20250527114152.3119109-1-dongchenchen2@huawei.com>
In-Reply-To: <20250527114152.3119109-1-dongchenchen2@huawei.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, linyunsheng@huawei.com, toke@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangchangzhong@huawei.com,
 syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 May 2025 19:41:52 +0800 you wrote:
> syzbot reported a uaf in page_pool_recycle_in_ring:
> 
> BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
> Read of size 8 at addr ffff8880286045a0 by task syz.0.284/6943
> 
> CPU: 0 UID: 0 PID: 6943 Comm: syz.0.284 Not tainted 6.13.0-rc3-syzkaller-gdfa94ce54f41 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:165 [inline]
>  _raw_spin_unlock_bh+0x1b/0x40 kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  ptr_ring_produce_bh include/linux/ptr_ring.h:164 [inline]
>  page_pool_recycle_in_ring net/core/page_pool.c:707 [inline]
>  page_pool_put_unrefed_netmem+0x748/0xb00 net/core/page_pool.c:826
>  page_pool_put_netmem include/net/page_pool/helpers.h:323 [inline]
>  page_pool_put_full_netmem include/net/page_pool/helpers.h:353 [inline]
>  napi_pp_put_page+0x149/0x2b0 net/core/skbuff.c:1036
>  skb_pp_recycle net/core/skbuff.c:1047 [inline]
>  skb_free_head net/core/skbuff.c:1094 [inline]
>  skb_release_data+0x6c4/0x8a0 net/core/skbuff.c:1125
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb net/core/skbuff.c:1204 [inline]
>  sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  __skb_queue_purge_reason include/linux/skbuff.h:3343 [inline]
> 
> [...]

Here is the summary with links:
  - [net,v2] page_pool: Fix use-after-free in page_pool_recycle_in_ring
    https://git.kernel.org/netdev/net/c/271683bb2cf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



