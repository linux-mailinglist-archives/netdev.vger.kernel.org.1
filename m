Return-Path: <netdev+bounces-156677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE801A075C0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188A81888426
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5B21771A;
	Thu,  9 Jan 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CunRKQqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBC21770C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425812; cv=none; b=b8tiiyxNuBdPq34x5Di/bli4L3FFfZt1xKGOYWm9fRHwta5cWBdf06yDlk42sKTXdEw6+BORgCX+lE3tPUeZNnFzgQqj/hKduMF7qauqd8wr4tIJgvm2NzA+SjH/ikv/Bar53W0EXwPcvpKmhDkGAInNEt2M2rB+POIekEvYigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425812; c=relaxed/simple;
	bh=ncNuGF03BTe92N4MJD7aWXff1QQYYPMsXimuvTbZN0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mZbfPYF1NzW6KsjF6Rodp8oGw+OWSmPyUyFKYohjI2J1UmU6NV8QZCayGBV1/RfO/lRvnlxDZNrUGnezxNFnxiaLhZkvW/GxmZq43f5fPOAG8jbzN8Elys0LJ30N0EYyR3rFE0yI6f7hXGMps7NxvTgcm5oViiw2AfpDWw5b+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CunRKQqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E85C4CED2;
	Thu,  9 Jan 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736425811;
	bh=ncNuGF03BTe92N4MJD7aWXff1QQYYPMsXimuvTbZN0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CunRKQqdDd+AsDFUL6wa7oePXR0uOjbX3unFBOFvnLGt2K2AwwDolkb65GmEdSxx3
	 KLuWp/idh9UpqUkhZKZvSUPI76SyiawiOfgivW54ma3nUqKwb9630JLt5BEZA0gKMQ
	 otZemAmjb1xzgiPiZhzhIjFIfAqRQ0PSaA1H2a3/esUZyrsywd99/CWfFJ7J7bWVY5
	 2iGEN0PCOd7jRua2WN/hw5yP7wROVVFNWNYWOh2ASPJtRE9RffKcxCou/KKqLOcMmX
	 hOS8mWZXbFWrRkdMX5AxPLgQP+cXII1mG4lzoAO9ddPp+Kn0kcp3vhHwDmJXdfylFf
	 f4VVAb6uJKBnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BCA3805DB2;
	Thu,  9 Jan 2025 12:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hsr: remove synchronize_rcu() from
 hsr_add_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642583330.1307582.3144551314847522633.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 12:30:33 +0000
References: <20250107144701.503884-1-edumazet@google.com>
In-Reply-To: <20250107144701.503884-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 14:47:01 +0000 you wrote:
> A synchronize_rcu() was added by mistake in commit
> c5a759117210 ("net/hsr: Use list_head (and rcu) instead
> of array for slave devices.")
> 
> RCU does not mandate to observe a grace period after
> list_add_tail_rcu().
> 
> [...]

Here is the summary with links:
  - [net-next] net: hsr: remove synchronize_rcu() from hsr_add_port()
    https://git.kernel.org/netdev/net-next/c/a3b3d2dc3895

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



