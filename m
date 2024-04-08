Return-Path: <netdev+bounces-85665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3DB89BCB4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F951F21287
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B289535C8;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+mPKhMt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CB53389
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571027; cv=none; b=FQB2IT1CypMUspilfHAy7vxDXAELBdhcrmzq04P6Kwpkc0fKlXMluzA7tqn9lT7r9obmMHLz0RSvkYju4LRDWYhTi1jXAaotvLurYuSeUIhfk2tcS60YdSoG1mXL7TWz7Df21zRR8Ho3BDAxL19mtzVH5PgTxyVMIHKhXrSGKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571027; c=relaxed/simple;
	bh=NX5af7LaHQ8RprrXxWuEvooWdDIOx7sNUW2cPns0rO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OHyMVqJybqUPhlPOcpjxwYU2pA5YSDMrcsPu6zb/Bk/T36i79o1/PHTQUcNqFsZ/ifXvSHNnNnYN6OJDub5BVIt7zsbS0einOUBycnDcmcEi58YmLFsHZkaVVyFmlRsHPsaKzhLndlEeXzjB6uvHCfi/1hZ51dDTRiEitB3P5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+mPKhMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26675C43609;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571027;
	bh=NX5af7LaHQ8RprrXxWuEvooWdDIOx7sNUW2cPns0rO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z+mPKhMtqPCNqsJ6sRcyt3OOiNjxtSO7Y0aKdjTljyZYPLN41hr07WCRl0D8OOFOu
	 V2a4npM7dzDxEYcAEybFlpnTZdcinJLxljb/GHnCB4SuBlucS8AgfBwMzNE8fBnSFU
	 rZMsK1MSkxjYwhFTM5zHGZgeBLArayk1Q0AIMTz1BHtpdSghx6pLV12mkvp7MxKNQA
	 d0RNgWkE2iyk985nDJj/t4eXSPyaLs8HbBRxa87Thmb2IILsJQarIAONrinBgZ+TBj
	 06L13TlhDq22yG06nt+zROFzSJ6L2ZGyW0be+MsH09cPazVgEsXLI5m6PlQaliU4tG
	 oJg+Y8gpTdm8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A790C54BD6;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: frags: delay fqdir_free_fn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102710.30740.16098288868677962814.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:27 +0000
References: <20240404130751.2532093-1-edumazet@google.com>
In-Reply-To: <20240404130751.2532093-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 13:07:51 +0000 you wrote:
> fqdir_free_fn() is using very expensive rcu_barrier()
> 
> When one netns is dismantled, we often call fqdir_exit()
> multiple times, typically lauching fqdir_free_fn() twice.
> 
> Delaying by one second fqdir_free_fn() helps to reduce
> the number of rcu_barrier() calls, and lock contention
> on rcu_state.barrier_mutex.
> 
> [...]

Here is the summary with links:
  - [net-next] inet: frags: delay fqdir_free_fn()
    https://git.kernel.org/netdev/net-next/c/802e12ff9cbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



