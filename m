Return-Path: <netdev+bounces-235702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EFEC33DBE
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C45B4E5911
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED462698AF;
	Wed,  5 Nov 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUVJ+jAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10720260569;
	Wed,  5 Nov 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314035; cv=none; b=Gyh9gUkDcZhUw8ci0jxRsWVJ1WzumFSFTRvejaXuL0wvR70zYDtIFqp2ckn3TpgPSbR2rB9QEHsChYy1TDChoK3niYegSdctWXRdi3f8DfE7I3ioqoF2jbXEmRst3HVMkv6/btC/oFn5CZwYCIH1HrJ9sNOhvMO7xgbwaBc9ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314035; c=relaxed/simple;
	bh=sBmVtXSMWfqcgiuaX/QTnkazzr7+e3R8dISehfvLCQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQzVREG+1Tj7jKcBwga07bEAAi43aleQ4fzDRcSlJuJqmsrZU0CZclkyb5FWZPgaNF5L28uldzAZ/mjWqh4SbPHD2Ula6hjQ4I86ILwqMHG4ZtIc4rljHI7rDK/2pW+Hvn9mbeRG1amM+yflx1aybDSTrJhE1ZeDqP2HW8yl0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUVJ+jAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8290DC4CEF7;
	Wed,  5 Nov 2025 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762314033;
	bh=sBmVtXSMWfqcgiuaX/QTnkazzr7+e3R8dISehfvLCQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUVJ+jAaOu48j8MffGsaNZcaY1ZmO942UAzh3olSTjiUdOs2TrgcY16oCREoSdQ0u
	 Ii0RL7PId37V5H0uYuF9XPPMqNGkawjezSWvOGDpB6JRkLguZ29oR7+OLYsghUye1E
	 WXnhyckRKsQgvaA6dcZCaFbehFWFanLyax2ipGtzzkFYwQkWz2cOOHdHQckkBeaLBz
	 nUIfot0Peb2A03k40MEcz3GCK8YRBF/LPbxgCNPYYQDdKAuHnvTDJkSDP3SG9rp3St
	 86wGMlu76CSsRaO2sOF+/Xagm72fmeIJM2oqhbK3iyQqUZFgAoEYA4YuErmVZHfqh+
	 wCgbypiK5gscw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCF380AA57;
	Wed,  5 Nov 2025 03:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] netpoll: Fix deadlock in memory allocation under
 spinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176231400725.3077655.17370020528592249644.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 03:40:07 +0000
References: <20251103-fix_netpoll_aa-v4-1-4cfecdf6da7c@debian.org>
In-Reply-To: <20251103-fix_netpoll_aa-v4-1-4cfecdf6da7c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Nov 2025 08:38:17 -0800 you wrote:
> Fix a AA deadlock in refill_skbs() where memory allocation while holding
> skb_pool->lock can trigger a recursive lock acquisition attempt.
> 
> The deadlock scenario occurs when the system is under severe memory
> pressure:
> 
> 1. refill_skbs() acquires skb_pool->lock (spinlock)
> 2. alloc_skb() is called while holding the lock
> 3. Memory allocator fails and calls slab_out_of_memory()
> 4. This triggers printk() for the OOM warning
> 5. The console output path calls netpoll_send_udp()
> 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> 7. Deadlock: the lock is already held by the same CPU
> 
> [...]

Here is the summary with links:
  - [net,v4] netpoll: Fix deadlock in memory allocation under spinlock
    https://git.kernel.org/netdev/net/c/327c20c21d80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



