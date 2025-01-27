Return-Path: <netdev+bounces-161211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE61A20095
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFCF3A4680
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B31DDC0B;
	Mon, 27 Jan 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Nnn6MD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16A1DDA36
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017013; cv=none; b=kmHnWEel1eZfKB2J6qMrYiRSlJK+lXfacDfm1LY0jeweM+abP9cX7vVEf4O9j3za7GiWSmxkjVd2M9WimK6GPoDng8IBm5ySNcV18oCK3BhaLIXX0y5RB9MjzfjHRjGFcCfDnkD3Q4MaHGn+SxSvCJ/sGi6mk86pGs9tP0av/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017013; c=relaxed/simple;
	bh=dVSx+xXCjMAWnzJWYTXlVWvHyPo2DeFrTTYVEUOzp3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rpMFtshTlN79j1Xyu+JTlhDYLBQ7UptCV1Xc+cbJQV9DYqH/YdtA6PSM6nae+CuvY1knA8k+BsFiArXsQBCc3WnMMJZOhL5Q5BwjqbgDI25uw6RU0bAjCmq6MW6B0HNaOpMl434fYJqzhhIBMM1Ivwny0I5pAHOazPDsRbxp42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7Nnn6MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551A0C4CEE7;
	Mon, 27 Jan 2025 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017013;
	bh=dVSx+xXCjMAWnzJWYTXlVWvHyPo2DeFrTTYVEUOzp3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7Nnn6MD20M4CMJEha7wTfIxCJD3xaTsEHumGJ1WgyKRR9EQTagz1dWdfF+2dDEfS
	 Vey4Slr1a/3mEmMkmRKnw5hb1vpUF0yC7Xz1OWHZPQsz3ZGV2Bnukk8jBHIAg2kYJD
	 cs9T0SfUglQR6hp75BFpANeO7pCv5LqTf6pL0NNzehaQJB8sssMw3j8kjHxQVBmgMh
	 3hZmG2P0uuoW2/v7pgZXgNRAqcv26FntcoDZ5sOCKMppDIHwmVOaVlIn8ocjRDFYBv
	 fWkP8Je4RC5Q/46jUJ5gluo5r5jmAM+q2S5SfgEYHYbW14H4b8WzpCISQdRXuAzn1v
	 lZNwBGJ9vy9aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A85380AA63;
	Mon, 27 Jan 2025 22:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rose: fix timer races against user threads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801703899.3242514.7906408551635519733.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:30:38 +0000
References: <20250122180244.1861468-1-edumazet@google.com>
In-Reply-To: <20250122180244.1861468-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jan 2025 18:02:44 +0000 you wrote:
> Rose timers only acquire the socket spinlock, without
> checking if the socket is owned by one user thread.
> 
> Add a check and rearm the timers if needed.
> 
> BUG: KASAN: slab-use-after-free in rose_timer_expiry+0x31d/0x360 net/rose/rose_timer.c:174
> Read of size 2 at addr ffff88802f09b82a by task swapper/0/0
> 
> [...]

Here is the summary with links:
  - [net] net: rose: fix timer races against user threads
    https://git.kernel.org/netdev/net/c/5de7665e0a07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



