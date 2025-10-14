Return-Path: <netdev+bounces-229010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7FABD6EDD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0CF04F7C65
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E152E9731;
	Tue, 14 Oct 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgYV8pE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413A2E5430;
	Tue, 14 Oct 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404259; cv=none; b=q7C1jrl3FET3enSKSLVrckeSiY/eVvyPscnWUW2E27uPadK1tECpu52+4i4EHGZ6aYAvsD0Bo0qT8DHumc7gbwMFlDZ7fkOXcGcepXGKZIU/yQ6Kz/GaW0ToYNigjuun/mxLcRbyBAyRjAFqeCyBMlXb+rOaRV9EuCiZphVwmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404259; c=relaxed/simple;
	bh=yatIg3t1WqJConxyQytL7RSrVAlOOfgGztRq+a10wpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPpf+V6EeDN6CVTMPfKbihXr/Y+En18WFjh0+tj8ssshFQZsnv/ZvPbXK+nid0jeAjjGvPIWtdnrq8nPfl1f8lLTvvb7tFmceP10ajonJWYL7XoBqHyqKRhDI05zAl5PQP6NVNZh4WGTho9t7HIdlHEn5h1TPih/VuL+EuJGw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgYV8pE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD36C4CEE7;
	Tue, 14 Oct 2025 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404258;
	bh=yatIg3t1WqJConxyQytL7RSrVAlOOfgGztRq+a10wpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BgYV8pE2DRDIhOqLzfK6uCWhsPOCVibhzP2mhldSqg6oLanX7PzsQ2y0/U0Rm3gX4
	 K2oeL/USsw3Wd0NU4fJoW8dxlsfeHvlrH/TnM+X3kYgnmOUcMUnBy1INlsrpB4VQ6A
	 6yz9kj/NP6hSmObPvFv+3GwTZortn01KjBJb+iTfTuwTUUDKP42bBhd/94alJMyxxc
	 82sHbrZgetS7+POqGbp1h36Qv7C0RzZL2hJhsDJaXpDs4sqG3+rkry3KIFf2XuYR+X
	 51G8YQ2OxCn8TiYedfaY5j9BL0JPNozkGvEMWhZFfQN35l/L5TF6OFgXAkqXldwQ/4
	 QfHjHHo/06umA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B6380A962;
	Tue, 14 Oct 2025 01:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040424399.3390136.8061166550868756938.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:43 +0000
References: <20251009094338.j1jyKfjR@linutronix.de>
In-Reply-To: <20251009094338.j1jyKfjR@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, clrkwllms@kernel.org, rostedt@goodmis.org,
 syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Oct 2025 11:43:38 +0200 you wrote:
> The gro_cell data structure is per-CPU variable and relies on disabled
> BH for its locking. Without per-CPU locking in local_bh_disable() on
> PREEMPT_RT this data structure requires explicit locking.
> 
> Add a local_lock_t to the data structure and use
> local_lock_nested_bh() for locking. This change adds only lockdep
> coverage and does not alter the functional behaviour for !PREEMPT_RT.
> 
> [...]

Here is the summary with links:
  - [net] net: gro_cells: Use nested-BH locking for gro_cell
    https://git.kernel.org/netdev/net/c/25718fdcbdd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



