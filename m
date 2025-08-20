Return-Path: <netdev+bounces-215078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED3B2D0E1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD421C24350
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622D198A11;
	Wed, 20 Aug 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGTDJF/I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9672625
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651597; cv=none; b=qgOcK18FWV7qqee6DSnNNUGvkRGHhrh/I3+8Nq7Lq1iEEdOQchIyP8fR4+jXkSBf++X4rMnkbQ0LxiFj3nkGl0vQfqLRYrYqF/wjgjEn4gPA2+qZVaE+FcpDTWvzFDL519PlhQlZMHXUHBom2cAXF4Gew2M3qdFm1/iIJnvdD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651597; c=relaxed/simple;
	bh=pknHe9VeCb/zO6qyTxGDGFqthtCyuS8QdO5J583eY3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QjOVqXelrZY5/Zx6NGVM4tkNq49c1PhfEKmCE/+Fwpa/3KBaCHTYhQV0rKiP2GidLAAQHtpFqHmPe0FYXwdtUsVrEI+ZUyzdZcczmKgPswUuU2YxnzuxcGwdLGHp8nu+zVfZDJakCca3s1fmp/ftztS3fONJ7YYjjLRhxF47BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGTDJF/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77680C4CEF1;
	Wed, 20 Aug 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651596;
	bh=pknHe9VeCb/zO6qyTxGDGFqthtCyuS8QdO5J583eY3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KGTDJF/Ibr8YbJKXdkGsERPO/+YmWGB6SKCy/AJ32RP09ZjCLW+CbnfusK0x6MCpS
	 RadQ9DVr1VO1sJx48DoBE21xY0RKCBFRajtg+KZTwpkzJZ7QatLXEN635YMrBjUcJ2
	 6nWQLq914ExIo8VJvHUNo0zcvNRkVybFWHoSVRTOZtlr6Zr6iqvO7uWd6IDfcQdwMT
	 Vu5yrha4PkP3LXHUPO815kkCTTJ22yfFlTRghRMWLd6GpWaIhv15kjXr3GBWW1+gjn
	 UuJbQPaM5V4ZqAVjOrw8BnrI4G83GNnf9MuA5haVc+eJqqYfqPSRBFB9HG0M3mbH/3
	 dyzoaVabd6Oig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717AB383BF58;
	Wed, 20 Aug 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: sch_dualpi2: Run prob update timer in
 softirq to avoid deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565160625.3748899.17255822579721560435.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 01:00:06 +0000
References: <20250815135317.664993-1-victor@mojatatu.com>
In-Reply-To: <20250815135317.664993-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com,
 koen.de_schepper@nokia-bell-labs.com, olga@albisser.org,
 olivier.tilmans@nokia.com, henrist@henrist.net, research@bobbriscoe.net,
 ij@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 10:53:17 -0300 you wrote:
> When a user creates a dualpi2 qdisc it automatically sets a timer. This
> timer will run constantly and update the qdisc's probability field.
> The issue is that the timer acquires the qdisc root lock and runs in
> hardirq. The qdisc root lock is also acquired in dev.c whenever a packet
> arrives for this qdisc. Since the dualpi2 timer callback runs in hardirq,
> it may interrupt the packet processing running in softirq. If that happens
> and it runs on the same CPU, it will acquire the same lock and cause a
> deadlock. The following splat shows up when running a kernel compiled with
> lock debugging:
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: sch_dualpi2: Run prob update timer in softirq to avoid deadlock
    https://git.kernel.org/netdev/net/c/f179f5bc158f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



