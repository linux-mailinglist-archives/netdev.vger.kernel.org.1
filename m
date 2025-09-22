Return-Path: <netdev+bounces-225358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0376B92B52
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8619020F7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AFA31AF2A;
	Mon, 22 Sep 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+ryZ/6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4831AF1A;
	Mon, 22 Sep 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567628; cv=none; b=AW4IPDVBHSUUq4SJuKYcZa3fw/+rGB7mtamRi6caVPZRixGktCZajNJynMAF8ZkPEDDYT50fiI7GJAdfdTtuAN35aJ/7f+9zUXmGVThPepFJfceWC2TsSpquWzhRaWlFFGb/77whmc5TXW5JBZwykuZHMFYTPn5nv5E+UfsMU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567628; c=relaxed/simple;
	bh=jSZMVY8tK6FEY+x6iuddgnutHAt7zymsZwQ2rIdY01Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yi3VG/crB45/sorOaj8m9MMulBQqQl20TmxEjYhDtVGH8/4u1s5BR72hSFYEEPVBb1BPGP7Cj1kQ7TSdETYxOLlZRlqqKA7RB4WUPL2RyMPkkiP5NTS09DkglHH1JLtwH1z0D57jomfbOjqFygEcS0FjFyoV4kt4fAWdyO6fPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+ryZ/6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C5C4CEF0;
	Mon, 22 Sep 2025 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567628;
	bh=jSZMVY8tK6FEY+x6iuddgnutHAt7zymsZwQ2rIdY01Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+ryZ/6f400scXloTds6VVlrsNvr3YVS1Csy4J9T3vm5sfo/IRUIjSExqYsgaB+n5
	 HGGop+jRnchJAy7yeFamfYpp5mr6xfAL7TPzdW5qllM/o28daOWNzZhbxj0uDKufeO
	 h8bZRWsVVnddarfHaymo8HrqNLY34m62SW19s6q+lCyMQgkrMwgv0aLTUMcPa9KRko
	 UD3zFDqNK6056F/wipMnKiMb5XzWXsIHcaY/IUedObbaAF+jdm3DkTC3X0fCYuL5gW
	 jCal2RFkFDQjwPWMzWxlTbqe63u/TZbcGYpcLePL5wbuFcdP/GzrkOQrxhNrd+8/Ng
	 Q7FzO4MeYOyzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6339D0C20;
	Mon, 22 Sep 2025 19:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: spacemit: Make stats_lock softirq-safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856762549.1122110.9995435257899207460.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 19:00:25 +0000
References: <20250919-k1-ethernet-fix-lock-v1-1-c8b700aa4954@iscas.ac.cn>
In-Reply-To: <20250919-k1-ethernet-fix-lock-v1-1-c8b700aa4954@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@gentoo.org,
 maxime.chevallier@bootlin.com, troy.mitchell@linux.spacemit.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, uwu@dram.page, m.szyprowski@samsung.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 20:04:33 +0800 you wrote:
> While most of the statistics functions (emac_get_stats64() and such) are
> called with softirqs enabled, emac_stats_timer() is, as its name
> suggests, also called from a timer, i.e. called in softirq context.
> 
> All of these take stats_lock. Therefore, make stats_lock softirq-safe by
> changing spin_lock() into spin_lock_bh() for the functions that get
> statistics.
> 
> [...]

Here is the summary with links:
  - [net-next] net: spacemit: Make stats_lock softirq-safe
    https://git.kernel.org/netdev/net-next/c/35626012877b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



