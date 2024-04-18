Return-Path: <netdev+bounces-88938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB868A90CD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D71F22957
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFC3839D;
	Thu, 18 Apr 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwDc7nSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF84EB33
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404427; cv=none; b=BrhNuTidxbr2PvAZicxch3ci3hEozSJtRRC3h2Ns4YY0qvq6R3vP6ymZjWAiyclWsSDg1CFKfmnqm65kgDvmI8euHAthJr4MkOkVgd4A/Knqmu+mrq2lS1XATW1KBIBz2y1le18FwOu1xNNDchreSOsGEzOI/kziqHM/vFBRsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404427; c=relaxed/simple;
	bh=nJYsOGGHYzgSe36k2CFDRye0rFWwiaiJGPzEsTMjqqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9meRwje2ZeBHWg0YEqEf7hj8FhiSs3WOxq7Toyq+DPuQWCKp3ETVaQ4j+Fel/X8cfufS7LZfHw42kl32jpVCsHuTMniUYSL1trHuuNT1KeBw/fvilzXFQzUciDEInTNzVIAhurgjOyg2PkwXu5oPqXDXmqx6GdAro8V6x1DNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwDc7nSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0408C3277B;
	Thu, 18 Apr 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404426;
	bh=nJYsOGGHYzgSe36k2CFDRye0rFWwiaiJGPzEsTMjqqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PwDc7nSC1ls8YwhApj0S6YP91lvNz1Cfa91OEkZZ4IgYcDEpYRpgn1pHp98izGAT2
	 ONkgdiVgTaN/UgEz940138n1tlcB+FtTmmC/Eb+aifiyDFonbXGOOgH4ghUj3TwKhz
	 qcKutC4KxufHsgxz8XYVLXPx79uins5HXjEylTxQWmo5WR3qw00XQD1r4uETamRn5I
	 Zt7cSW0rmV7xuc4dEsw7sdFGskPM89xPOzV24ApZLwqeQrSA0ClLivR0un3DcIJ+M1
	 gzp6Ur2eW8B8JRI4jyPgBt7yeeCI6EkuIwU+RqEhXYbpW676l6CoaU8JpkpRBBlQrr
	 NlNl80p9RUZbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8B70C43616;
	Thu, 18 Apr 2024 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: Fix mirred deadlock on device recursion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442675.27861.4405474645584745327.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:26 +0000
References: <20240415210728.36949-1-victor@mojatatu.com>
In-Reply-To: <20240415210728.36949-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com,
 pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 18:07:28 -0300 you wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> When the mirred action is used on a classful egress qdisc and a packet is
> mirrored or redirected to self we hit a qdisc lock deadlock.
> See trace below.
> 
> [..... other info removed for brevity....]
> [   82.890906]
> [   82.890906] ============================================
> [   82.890906] WARNING: possible recursive locking detected
> [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
> [   82.890906] --------------------------------------------
> [   82.890906] ping/418 is trying to acquire lock:
> [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> __dev_queue_xmit+0x1778/0x3550
> [   82.890906]
> [   82.890906] but task is already holding lock:
> [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> __dev_queue_xmit+0x1778/0x3550
> [   82.890906]
> [   82.890906] other info that might help us debug this:
> [   82.890906]  Possible unsafe locking scenario:
> [   82.890906]
> [   82.890906]        CPU0
> [   82.890906]        ----
> [   82.890906]   lock(&sch->q.lock);
> [   82.890906]   lock(&sch->q.lock);
> [   82.890906]
> [   82.890906]  *** DEADLOCK ***
> [   82.890906]
> [..... other info removed for brevity....]
> 
> [...]

Here is the summary with links:
  - [net] net/sched: Fix mirred deadlock on device recursion
    https://git.kernel.org/netdev/net/c/0f022d32c3ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



