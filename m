Return-Path: <netdev+bounces-218889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6667B3EF79
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF6E487578
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3843279354;
	Mon,  1 Sep 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUG3Xef/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8027932B;
	Mon,  1 Sep 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758008; cv=none; b=UcD3kR/WONfPO6k5y1H/gCwM7eF4qfudf55i04mpab2zKWzz+LwOfzoBXr75VicT2BY6sWjx3a6DVkkw45L1GqD+INpIz+MvmDOUJ6yMlK41x8Mb/ea3LHgPo3Ky9GDFGb2QjuUBF5nkItmYhPWYI/VtR8/h57gpncZkA5D2NBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758008; c=relaxed/simple;
	bh=BGOwdNbU9vLIZz1WdKyL/3bVlxvLn2EyzqwMGkmJxqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KoRshKo4M/+lA6ra4BHCtxlcl7Vf5eDueVmylmzWUIF3aLXT3KLvjZvyxWNt5jEcSuuVIzWPt7/3J5fr/13FMo6S9lQEum/B543FCDvDJh49nOdH0KGdHk72p5KQqbJCve+Em79VLSeLskprv872EvNcXczFBA80CzlEui2ACzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUG3Xef/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B7CC4CEF8;
	Mon,  1 Sep 2025 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758008;
	bh=BGOwdNbU9vLIZz1WdKyL/3bVlxvLn2EyzqwMGkmJxqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUG3Xef/eDpl/IXdli9dAvk71PYqnnQqEz+ljhabRRaFWis1ElvZqqCY9atB5fY0U
	 eNbh9rgQy0We+RTkJvwUbFEMcK9N4YyqhCD7GKW6ozJeZyEPYlyMXVQtQLsX/bZt6v
	 35lknuBXx2qiB+3B5l2VYemx+AJzugmPXk7DoTmPy43Syzd+KzjjnsTz5o9QMzIhuT
	 cfbU+MkSeTC9RD/cviggziX6vizZhl92GbajC/U/0NtUUkYKVroQGt4CtZgS3ZARuu
	 4erFImM+fS7+Dt66BEBpWP3b1zqDfXCyYfQXd79pKZnytef+JCbyksTtPwTUV4MXkM
	 AACv2qXxyfL2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7F383BF4E;
	Mon,  1 Sep 2025 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: macb: Fix tx_ptr_lock locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675801374.3872744.14092876974796053119.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:20:13 +0000
References: <20250829143521.1686062-1-sean.anderson@linux.dev>
In-Reply-To: <20250829143521.1686062-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
 nicolas.ferre@microchip.com, efault@gmx.de, robert.hancock@calian.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 10:35:21 -0400 you wrote:
> macb_start_xmit and macb_tx_poll can be called with bottom-halves
> disabled (e.g. from softirq) as well as with interrupts disabled (with
> netpoll). Because of this, all other functions taking tx_ptr_lock must
> use spin_lock_irqsave.
> 
> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: macb: Fix tx_ptr_lock locking
    https://git.kernel.org/netdev/net/c/6bc8a5098bf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



