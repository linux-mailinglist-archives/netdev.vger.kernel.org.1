Return-Path: <netdev+bounces-148432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7579E1904
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31DCB33C54
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6422A1E0B73;
	Tue,  3 Dec 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIxhVJMd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCF1E0B6C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219933; cv=none; b=rAMW0OqYNeFGXvmg18stuxdjpp1oHdiMmoP+P/rrx1yjP+Q9erOdTpj2ONLCk/p1eEdF53q4SocX5tDL1Xu6j2alxKfaRt/xWrNtMha6O0Fys1uYMV654iloJGIfFOqICUuabxqGAAO0zttmYRIAIfRp9p5Yeevwsj/zeKEINBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219933; c=relaxed/simple;
	bh=KHlD7VfCyajxelVku2hB1Bc453ZoWffRWgUS63WdX8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ewcewGNTdgcYW6HqtFut1Z9FTOrz7nJIe7VCkQiWc/SIfHhd8SpRn3GNXKJyiImCxDODjbsXGrasKbLsMwLPNCLtbH4ofgxY6kUxKEQdgD5pIGRC7Csq2biPW0FBPjK3eQYrMP8NO6xhqqwSo3/cZMxTKW++hh7OBhvmJ4xWlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIxhVJMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2FDC4CED8;
	Tue,  3 Dec 2024 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733219932;
	bh=KHlD7VfCyajxelVku2hB1Bc453ZoWffRWgUS63WdX8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dIxhVJMdU7p85r5jW5vmELHvar9IwTCLfakiFkGu5NK+GXlkxSUN8SAnFlJLOqARM
	 nRRRoU3/r3BMB+e05PdKN7ZsizUqlK3MK2pYPHM3b8mYRhiC9Mcax1zTuXE4kc/yyS
	 zbhZbgcZL9t9aGNLwr7cJ1bo19dNv9MoA++sh8ras/bTgzx+FZjZ7gg4Fry7hsMAj/
	 envDTmFmU0g4WXTdnhIt7eTsa4FIbfZNwQPt4/sjhIJraB3q9EN1+fTNRzy7jKxlcT
	 TdoaixN2yE9qdsODJwnzWcQg8uF+dcKPuq5e0DdvCiu+N14CftIJ4nF8W5VmGwOSZs
	 lfeOXF+mVSejw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2AFD03806656;
	Tue,  3 Dec 2024 09:59:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in
 cleanup_bearer().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173321994675.4135237.11701482291125009677.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 09:59:06 +0000
References: <20241127050512.28438-1-kuniyu@amazon.com>
In-Reply-To: <20241127050512.28438-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ebiederm@xmission.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 27 Nov 2024 14:05:12 +0900 you wrote:
> syzkaller reported a use-after-free of UDP kernel socket
> in cleanup_bearer() without repro. [0][1]
> 
> When bearer_disable() calls tipc_udp_disable(), cleanup
> of the UDP kernel socket is deferred by work calling
> cleanup_bearer().
> 
> [...]

Here is the summary with links:
  - [v2,net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
    https://git.kernel.org/netdev/net/c/6a2fa13312e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



