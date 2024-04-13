Return-Path: <netdev+bounces-87593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F78A3A74
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B051C209F3
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7012B95;
	Sat, 13 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExXkq/0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935034C65
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974828; cv=none; b=Q5aWvii869OLeJXckX4iAy9wTeoObxRmUd0+qtqMAw7rMrbJHI5bohUB+qTgyI7siwLXFhrbrR5rKyU9TMtLb6kegnvsQj7ym5YXCTZbRABwM/E+fmKGff+hY9EaGTxRJTxESPjBKf6liGQrkObuZIl32c2ebun5y19eTUln49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974828; c=relaxed/simple;
	bh=R88H3KCxFlaA4+/Jv1Ugnd7ZZvlWNtSjBKUs6pU7trs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c2E3YHlJabq/C2jDTDILSMsjn0rPFSPO6T69y8CPsIwxFU544I1p4aXeCbiXQpNiLsHhTzrp84TTX7BYkXhVfp57LUlU++EqeElRlUlbwB8s8GIiQiHG8Uxh0qMkFYX1gd/5gQX8rF5mdrYiAmrEqczN5OrY1rSv8cw/P0cbCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExXkq/0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1E87C2BBFC;
	Sat, 13 Apr 2024 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974828;
	bh=R88H3KCxFlaA4+/Jv1Ugnd7ZZvlWNtSjBKUs6pU7trs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExXkq/0Sp3s+ZAyHdSqYZeXolZ+pcBHGZnhOWVJWj9PQoKpbOvKjooplvc0S5Vsp2
	 MGQgdU3DAhAJIF/5fKvJN6mfwf2DZDOJpA84zSgoBn3KRwaHDfx3jENbjESjYmxjmt
	 2sJl8XCqqXv+iBpuUEKosXPOGzOdMBe95jmo/UAp2cmws/MHjVUvkFHl//p/hOqxEp
	 LhIWBC81jc+9VSNOjixg1jwMpRscCYSbunrK3v+w2k0zMeQM9ckVjgzJiHmsA9FgjD
	 AaKf0EPTgTq0zwIFf2VV7fpzGTVJjLcR3Z15pKN+r6scbyvKa+Ze3Fdn79Q+HpyYem
	 luLIO9Q9m3IiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDA62C32750;
	Sat, 13 Apr 2024 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fib: rules: no longer hold RTNL in fib_nl_dumprule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297482790.4822.5630399407622602819.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:20:27 +0000
References: <20240411133340.1332796-1-edumazet@google.com>
In-Reply-To: <20240411133340.1332796-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 13:33:40 +0000 you wrote:
> - fib rules are already RCU protected, RTNL is not needed
>   to get them.
> 
> - Fix return value at the end of a dump,
>   so that NLMSG_DONE can be appended to current skb,
>   saving one recvmsg() system call.
> 
> [...]

Here is the summary with links:
  - [net-next] fib: rules: no longer hold RTNL in fib_nl_dumprule()
    https://git.kernel.org/netdev/net-next/c/32affa5578f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



