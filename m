Return-Path: <netdev+bounces-84687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50DD897DC3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F98285EAE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2381C6B8;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTYcTf0O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832A1AAD3
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198427; cv=none; b=JHdH4zHSlI4lhleG+V6cGOZXCluM6qdkljFf8PcVny4hdhkbOm7KiTrJK0mMAu7Efodt91uncLRVxLZQeGOdjkYwpYYpeBv0Uy36JMD1JLdQ6yjPN3fi3aXfevkCUsTwdlMzSas1VM0jWTwN8ii9cLB8/1RfzzrE3WMZY5wfa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198427; c=relaxed/simple;
	bh=30elOBsXPpptGHsEb+MekkeCeh0L0ZNaUTDOd+0wXFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UAFM+Rs1C4EpxiqtbxWgQ/Ibwd/I5LVP96znvj7HsyDoiAi4tfyHukHuF1NbrnwFteAD/PYW5rABdQcLMHuq95Ba8zGDY95qo4vRAJw0gbZU0Q6F0okey+k3o6S83AW7mmXC9mghl4yA9pvXmAuUXv6b5nr5Nu8meWn6j/WG51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTYcTf0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4682FC43390;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712198427;
	bh=30elOBsXPpptGHsEb+MekkeCeh0L0ZNaUTDOd+0wXFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTYcTf0OwI0n9TgK3AbAWUZpPg8q1iw7yHMdlWGiUIzOUkmMDfI4ES6tEI70R5qrn
	 NplBQHiv9rd/GKC0HHhnwfJHkVqhGzXiyi29QMo8TuS6YSEZ01q68kRjGEqCyxWqtd
	 M5S2YSLQsobiAwFWiVA7P4GHxNI1eaEciCVheGjTOVXKVet0EF0VOuDyDrLCha+wYT
	 JO6mc1t1khcU8yGjzZ0BWLf9Mg44LcMIThfFSYpxhaG4U5ht4BZhpjtyZkptbMFG1P
	 PFoSLLQg+8Ak2ZUkJXTJvXMe1pQDRBDVUplYubfNLeOsfhWF1VekTWtGjhoZTTgsEz
	 U9nvs81TYxX0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B30BD84BB4;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: fix lockdep splat in
 qdisc_tree_reduce_backlog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219842723.31127.1396314664737208519.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:40:27 +0000
References: <20240402134133.2352776-1-edumazet@google.com>
In-Reply-To: <20240402134133.2352776-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 13:41:33 +0000 you wrote:
> qdisc_tree_reduce_backlog() is called with the qdisc lock held,
> not RTNL.
> 
> We must use qdisc_lookup_rcu() instead of qdisc_lookup()
> 
> syzbot reported:
> 
> [...]

Here is the summary with links:
  - [net] net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
    https://git.kernel.org/netdev/net/c/7eb322360b02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



