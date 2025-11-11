Return-Path: <netdev+bounces-237423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64333C4B372
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 684444E8FCB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB23348877;
	Tue, 11 Nov 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZl3ih4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7434886B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828238; cv=none; b=shlzXAgjutxbb3B+n9vu1GJfl2aEgXGZE+6zDkJBno58YoQIJ1yZxz8qZX2+UX6fKTHEIZN63YDs0puBat4UVPVqm1gT9q9+rfiJSupi/fTcSt/AWZsSVFxmoagqa/+tKr1oCIJQpBjg7wUeP6ClgJx0ecoKoJ9mZhrbXASjAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828238; c=relaxed/simple;
	bh=Tg4YrF+wQaEuD95y9sHczKsNVaFICf39RURk5oNJtoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EchGrrDT2BRtU6jvBaerW3rK3hAB3zhuewAirFL9VLuANffL+EGwRtweRLl1YK7w7tHb07wRINN0HV3qRVfH8Fr/2h+pfZjUc5bpqrkR32HF1hZBVRQiNzypi/Bui4m3vobzCbYqdKtX6thB0o+CjCm2KQs7alybBxHY6yA490Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZl3ih4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3994EC19424;
	Tue, 11 Nov 2025 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828238;
	bh=Tg4YrF+wQaEuD95y9sHczKsNVaFICf39RURk5oNJtoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XZl3ih4iBKzgyVTglKNSc+frfYbhNprhUZkNLifb4ZSq8JEroEQ8r9mnyHePjDakH
	 r8QBTFSHCfYVfHPtEY1TKoXSWXYBP/+ph5/PQ+mwn6X/An8OfyznlZoYRdb7ULbgsf
	 kqcQDWxP3Emnb3R/xmRvnziio/ikL0JITGUBqWsKUv/BI1+OV5KEaCQsIj27asn1yr
	 z50YPurkS7wgaheAotEHWyNg0m28UdBFiOtIwBIrBAg7OiNsHMgOQoInqpdAxUF5Wl
	 JAAHu54KTt+mW37mDQFVnCXmWfqF+x+/fFNC7ZNZETm3Fh5WDgW2jgPnUDP5ZU5hMU
	 CyrnuKCvUA9gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB054380CFD7;
	Tue, 11 Nov 2025 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free in
 tipc_mon_reinit_self().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282820849.2856551.15259746264900359327.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:30:08 +0000
References: <20251107064038.2361188-1-kuniyu@google.com>
In-Reply-To: <20251107064038.2361188-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hoang.h.le@dektech.com.au, kuni1840@gmail.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+d7dad7fd4b3921104957@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Nov 2025 06:40:25 +0000 you wrote:
> syzbot reported use-after-free of tipc_net(net)->monitors[]
> in tipc_mon_reinit_self(). [0]
> 
> The array is protected by RTNL, but tipc_mon_reinit_self()
> iterates over it without RTNL.
> 
> tipc_mon_reinit_self() is called from tipc_net_finalize(),
> which is always under RTNL except for tipc_net_finalize_work().
> 
> [...]

Here is the summary with links:
  - [v2,net] tipc: Fix use-after-free in tipc_mon_reinit_self().
    https://git.kernel.org/netdev/net/c/0725e6afb551

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



