Return-Path: <netdev+bounces-84248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30312896271
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D6B21DC2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50633168DE;
	Wed,  3 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSmZgOVk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C624E56E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110827; cv=none; b=qc7jpdZvh6DjRsLpIXtxq3d0KU1pLuglU1WPEHkmpSfTo5zm+pqA5vMIVSuf2rGl3PhoWnE4Cu2LqRXrrC7UdSo7Na30WivryGSmgdvM9jgZjPsIZPZYtvSchMuic+QQSQKF2e3NETXGOD1o32l+j7XsuTGSRcrQMn/nEISJ1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110827; c=relaxed/simple;
	bh=xANhuUStz1Q4EJT4zXEO1LLAP0+lkvgpW/LLcil34qI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iuFKjujLxHuTQMLl7dHcAbAhYCmZVY9Q4qQ5i5HQmvC26N2KBav8OS25aTqSV8yfvi8gJPJtrrZtLVaKNNFdPloSZQEl1R057Hs7n9IT2/rySdpoXtFmRgnwroRhgSU7V8yr3fJEhULUpxBtYcX2MKR0RdWgJXJ4y1xZEzoL84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSmZgOVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 039A4C43390;
	Wed,  3 Apr 2024 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712110827;
	bh=xANhuUStz1Q4EJT4zXEO1LLAP0+lkvgpW/LLcil34qI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSmZgOVke04oJw22BxXqWDor7c5iXKyN6i13jPaO6RfdrpFLvELgFd/05qAqmHHJt
	 H7+W0cYLD4umnkdbiBwEj4p0YoE4/phzGxZMTzN7jAD0v4zdPBNqD8RMvBdjihTP3+
	 Zc9gSwyryOzUwX3Q9NvDcWny3irrey1KmkcL+m4h3IXEn/07syA+OEBKzaUxPy1Xi2
	 5eW5Se++Db6j6DSkFtXuX26/kaopDpqIurM4OqF0GS8+t3zL+uoIt+0VDPnGt8ljk9
	 kcsPRxnEf2XLABes4YTacaToFFXqXxRthx/cpZXVnvqE/YC75oRqb28ptD7ciJz/Bu
	 t4Kp+0q65VhpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E207BD9A14F;
	Wed,  3 Apr 2024 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv6: Fix infinite recursion in fib6_dump_done().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171211082692.1409.675102691609445892.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 02:20:26 +0000
References: <20240401211003.25274-1-kuniyu@amazon.com>
In-Reply-To: <20240401211003.25274-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Apr 2024 14:10:04 -0700 you wrote:
> syzkaller reported infinite recursive calls of fib6_dump_done() during
> netlink socket destruction.  [1]
> 
> From the log, syzkaller sent an AF_UNSPEC RTM_GETROUTE message, and then
> the response was generated.  The following recvmmsg() resumed the dump
> for IPv6, but the first call of inet6_dump_fib() failed at kzalloc() due
> to the fault injection.  [0]
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv6: Fix infinite recursion in fib6_dump_done().
    https://git.kernel.org/netdev/net/c/d21d40605bca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



