Return-Path: <netdev+bounces-92680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4B8B83FE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13F71C2252F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8F53A9;
	Wed,  1 May 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQXX9uTr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA934C7D
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527632; cv=none; b=IJ4KgeGaJ/EHZpldxV+puA+LEiHxpPjwdulcuAAK7j/e2AwU/9H3LkINVQuFFmWqd5il2eSdYYQX2IAetIhE2XQJYmNczQ+IaYT2e2U/Qwx13I2UrlKXfxXiWWVf3Qzm3ZhEtKsqFChTfd7PRE0ogrysDd3Uw3XTzVBssVb3tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527632; c=relaxed/simple;
	bh=PGngSpJRnL8fFhEx89ydRpN19uNAXuPv/xMutCyNgOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nHKdCK7lYyz0VSvdmGa+LHS9IJ+psRTQJpFO0gKUBv9gL0fbmSGSDdZegN5Z9Zv4UfcvetaLP3gOFt7JUPXfxCLALEAbGqDBmY112R16QEvGalK0r1lqPcpJv8JTXELLvKqmZGVtqOjYc836jVkTvGwUOwUoRU9JDfRDQL/ME6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQXX9uTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94C39C4AF19;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714527631;
	bh=PGngSpJRnL8fFhEx89ydRpN19uNAXuPv/xMutCyNgOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQXX9uTrcS4RqBz2xUimcd11tm9vsqpmGFgJpMJCzZBsVNTNnhtHf42x5d5Q4d63v
	 Zhy3dpINinjTChpOwOFsKqcPvu9aHkuyapSXFUPnfd9HfWtvyfgECy6gJzLqJ1/DZc
	 t/6ZlHS9OufhJXd1WEO8faW6MqpDACyYp4t2fTXut21JG6QdhEXFxGd8sIAh+3xSme
	 6BcIx3a8rXS/IkfDrAoYPbXf8njSpTLR0LiVzSOZkwXrPAfZU+9Yhy3Ax4NEYK1yaB
	 zO/Qsb7GjBvCZpQS95hmmpUE5mVPiQOqijGQwwjfFJeYRv6+3c5vZZOzNQ8c/y6uCZ
	 1s+M50aUDD4cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FFF9C43443;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] cxgb4: Properly lock TX queue for the selftest.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452763152.16260.2017250381831802167.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 01:40:31 +0000
References: <20240429091147.YWAaal4v@linutronix.de>
In-Reply-To: <20240429091147.YWAaal4v@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, jwyatt@redhat.com, rajur@chelsio.com,
 jlelli@redhat.com, williams@redhat.com, lgoncalv@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tglx@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 11:11:47 +0200 you wrote:
> The selftest for the driver sends a dummy packet and checks if the
> packet will be received properly as it should be. The regular TX path
> and the selftest can use the same network queue so locking is required
> and was missing in the selftest path. This was addressed in the commit
> cited below.
> Unfortunately locking the TX queue requires BH to be disabled which is
> not the case in selftest path which is invoked in process context.
> Lockdep should be complaining about this.
> 
> [...]

Here is the summary with links:
  - [net] cxgb4: Properly lock TX queue for the selftest.
    https://git.kernel.org/netdev/net/c/9067eccdd784

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



