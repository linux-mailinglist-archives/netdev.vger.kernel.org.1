Return-Path: <netdev+bounces-218375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F0B3C3EE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C969C588347
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C229346A17;
	Fri, 29 Aug 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPV2TJYZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA54A11;
	Fri, 29 Aug 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500621; cv=none; b=oTwCZ8EgKfaIkWgQq0BEBzW4BKtG63w6hfQACk8kCnuRXzhh2j21nlpasI7LFFy/lUsJJ15Id9eG0yoXn2UyQsGwUhUuOF/cp1SjCThJIGuHoi4m/EhoEdi4aIr8Iv0/62+bzo2zkBfbHR7YWY7kEvG5bNjOivR6j3x7e6xsShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500621; c=relaxed/simple;
	bh=uwKzq2r0GOJlGqAOm5LVGSywyjOJaypEbLwd5nCqP8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MhVfju4OL9w95ac80ApCla/S/H75lVh7QPAp+V31DRO8yesvYl771yC/zg7AQB/nDRCMybaFyE9akvuHMTKLanQdSLkxd7Auj1zJX2CsXNFUtgtEWrmnpOC9GbT62wAPxe13FhlIZjtzDXXCdeM9YcA/U0EDQuMlS1+VKMBU7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPV2TJYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0745CC4CEF0;
	Fri, 29 Aug 2025 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756500621;
	bh=uwKzq2r0GOJlGqAOm5LVGSywyjOJaypEbLwd5nCqP8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bPV2TJYZOfUaCh5Qjvmqhyx3hsHzMsxqhN1WaDuZzaL9175A0T/TRIeoREnK2N06D
	 756+jge8WAaC40paPjBuXQHO80aqpqMckWXO6/Dh8bwJOD438gf0SFm5JhOuNL6pXO
	 gcg7v/muVbC+yGCNn3dZLTnJwJoIEV7yyWWEHceWktp7DCPHIqK15l2azWRZCfCMZa
	 G5Ez70nrciqS8K2SzH2bW3xa8WGNbaENeHdmaGpaVvwLNv+isJNXhWQ/bjkf1q2JqV
	 wCHupYnSHVhhWY7ijNcJMVzWfOoGUVEsdD5UUCx6Nv9DxfCEIo0aa1OhcI+gJppfjT
	 0Gwu/60H86sTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAF383BF75;
	Fri, 29 Aug 2025 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] pppoe: remove rwlock usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175650062774.2336923.18117158864204534101.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 20:50:27 +0000
References: <20250828012018.15922-1-dqfext@gmail.com>
In-Reply-To: <20250828012018.15922-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: mostrows@earthlink.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 09:20:16 +0800 you wrote:
> Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
> lookups and a spinlock for updates. This removes rwlock usage and allows
> lockless readers on the fast path.
> 
> - Mark hash table and list pointers as __rcu.
> - Use spin_lock() to protect writers.
> - Readers use rcu_dereference() under rcu_read_lock(). All known callers
>   of get_item() already hold the RCU read lock, so no additional locking
>   is needed.
> - get_item() now uses refcount_inc_not_zero() instead of sock_hold() to
>   safely take a reference. This prevents crashes if a socket is already
>   in the process of being freed (sk_refcnt == 0).
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
> - Move skb_queue_purge() into sk_destruct callback to ensure purge
>   happens after an RCU grace period.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] pppoe: remove rwlock usage
    https://git.kernel.org/netdev/net-next/c/72cdc67e7fa7
  - [net-next,v3,2/2] pppoe: drop sock reference counting on fast path
    https://git.kernel.org/netdev/net-next/c/4f54dff818d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



