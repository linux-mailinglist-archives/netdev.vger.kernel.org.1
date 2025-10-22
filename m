Return-Path: <netdev+bounces-231480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D194BF9878
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4A219C6A13
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C51DF979;
	Wed, 22 Oct 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Seh6oqgg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F31DB375
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094241; cv=none; b=rsrs1ItvWgBWnhJJpejhZxRtrUjbzqEcXuurKtJXM+J/Fw3ZdFmWrw50IIugnal6LVr3eaWxmwf/fYPX4BYt+0y+MFYlWPviUxnklLIM+P/E1edJIkK2mYkHStOao5H+zE1HdgS53aToKkG1+gCZJZ9bDUFbjdeOg2j7k+ztGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094241; c=relaxed/simple;
	bh=BeH+swyCbcQeji4Nb+izYs1FJovjThxek7shggdsaxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nOUfGZEvWw3ZaN+Hk4YVNRleD3ghcB6wN2VgyFLBdSKjAhAp5PR/RAkPJd2HSSSlauUDyEKHaN0lxSpmOGZCdJKemZrznLhw423HaYzm7hBZTvWwRL00sTMWIZmdm6NtscxzKCBkqiI3XjLA7e0IDa2kC9uZjBv8puimMuapLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Seh6oqgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA77C4CEF1;
	Wed, 22 Oct 2025 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094240;
	bh=BeH+swyCbcQeji4Nb+izYs1FJovjThxek7shggdsaxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Seh6oqggnDJLXXNJqKyxozSewH6dJp9CPrXxAkNgkjKahv5NyNzdernD7nAhwEBm6
	 TG2x1AGZLeadQWvgRbC49Ymby8aZwuRlr5IU8GS41/Fjkttc/NnOdy4UkQkTofAJvD
	 FZGR5ivviT5EYEOROSV7+Yu6CvOw6TqSrF/SwdpGXSPy57t6SmytpVcvAxLQRhoTpE
	 KPcb4bTJCbJBkZXmZhxTtMOCgTf5P+kbyvR+t21HViVidBPx9LgEtSXmbnbQeiDn3Y
	 H2gRYlSA6DKXWalnVr6jPT694U/+uXmB+IZwe+bZnUiOt1TY5sVC4Is7CwdnhQiD8J
	 MPBe/9AaXe6Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 381893A55FA6;
	Wed, 22 Oct 2025 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gro_cells: fix lock imbalance in
 gro_cells_receive()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109422199.1291118.14362751027086992846.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 00:50:21 +0000
References: <20251020161114.1891141-1-edumazet@google.com>
In-Reply-To: <20251020161114.1891141-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com, bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 16:11:14 +0000 you wrote:
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
> [...]

Here is the summary with links:
  - [net] net: gro_cells: fix lock imbalance in gro_cells_receive()
    https://git.kernel.org/netdev/net/c/c5394b8b7a92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



