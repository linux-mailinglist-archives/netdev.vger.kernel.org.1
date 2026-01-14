Return-Path: <netdev+bounces-249701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A7D1C378
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799D530409DC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04D324B22;
	Wed, 14 Jan 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfbLYblj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AE322B8E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360420; cv=none; b=OlHuvGclgmhJt0Mdyet1EfsryBKhrZb696fX/yODF03f9ON7PCbE5xFJ7JbuGD7EaXpWIBQrVMAhHVG5HknwoTnFT77XXkdqwF1RahCzJN9uEI8Wu1Lf/cicKUq5FlHnPJW6eSt3CLG1CpmJ5PyRgdp0t0I1AKS7cG9a0khb7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360420; c=relaxed/simple;
	bh=ZcbHNRwwcE7//Jo3n6xmIhe7WLx0rImKdrNyIPP4ouw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aFPLV3eVCV+EvROG/lLyZqWI1z4EA2b6/fkTmEU3NOktqbM6bZ7zBCOoVePWKyK1c5Y646KcvzC5gIq/cQxlkVebbXdt2MB0GuCe5sAq9d4WK3krJvYbQWhtG9l1p/JhByyLgqJO955fePAnUrZb4fCbLbCnqrOIywdYfDQR320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfbLYblj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D5C116C6;
	Wed, 14 Jan 2026 03:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768360417;
	bh=ZcbHNRwwcE7//Jo3n6xmIhe7WLx0rImKdrNyIPP4ouw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfbLYblj+DRK78hd05ZX9z9SlFfDi3XLxnAcwuFri4I83M9/SzcD9d6p4fTCpx/Gm
	 GSxflRdjkRq3FeVsk0y/mYpczrMtcFSGeJGSWTEcWua2mznhYIH1VbeWdoCOg6ezqn
	 kQcXUOPDI/01FckyDdf0crG02LG1vbpbaYhRvo1pTLqtWz3M+pPgQcq/gd/WJX5KTC
	 x1Q+Xim0pospDV9pcp9KgX5nkp+4QfaYfYcqMidDJlb12a00rPvRkZQ3UQcOZWsNgP
	 0qnSFB3sG0bmugdV56jzmGVvhUWyQNjacCaJPShApKNfClAKw+f9/lre+tc+qZkc6n
	 q4qeClmoExYMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29773808200;
	Wed, 14 Jan 2026 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and
 rt_del_uncached_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836021053.2567523.9034814725830906123.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:10:10 +0000
References: <20260112103825.3810713-1-edumazet@google.com>
In-Reply-To: <20260112103825.3810713-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com, martin.lau@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 10:38:25 +0000 you wrote:
> syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
> in an interesting way [1]
> 
> Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> list->prev, while the prior write on list->next went well.
> 
> static inline void INIT_LIST_HEAD(struct list_head *list)
> {
> 	WRITE_ONCE(list->next, list); // This went well
> 	WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> }
> 
> [...]

Here is the summary with links:
  - [net] dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
    https://git.kernel.org/netdev/net/c/9a6f0c4d5796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



