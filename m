Return-Path: <netdev+bounces-198835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430A0ADDFA8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD9317C128
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3C29CB24;
	Tue, 17 Jun 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvTWoNpF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A4295519
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203005; cv=none; b=uxyD113hUe9K7jVt+SZtGf5vYZUE5Vnp0N7JN9DTSDs09kTaTietJsD9shD3Wzbtq8A663PTBr8DgjpB2PqqYL7xWt8+B4hawC6mrjmOO5zae/AiC2LduMvHmBSUSRrogXUn8xbEFbLlw8Snw92dt1aZm5ecxYHMfrKJc4PWBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203005; c=relaxed/simple;
	bh=05ar+x5d0epXfJQcIJrP3p7566sQKAu5y+XQLiJgv94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JiHMqEN2rWkJHXcK2qWpaXVYP2dpGcZU9KdsOycY7fx2qTk52dY97ZZLvIlY2y3tUWfyhv9HYFeXqsp3zlbiAPQ51RynaGQP9SMff26szZW9z8ut8fwU2TMu0khqKCH5mD3yXv1bl7Fj9jdgkbe0o3Ph7k/Tler/UirFG/AwUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvTWoNpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6690C4CEE3;
	Tue, 17 Jun 2025 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203004;
	bh=05ar+x5d0epXfJQcIJrP3p7566sQKAu5y+XQLiJgv94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvTWoNpFNRVIks6Egrwq+lsekbYUhojL4gGE5zyUCRbMOsSmzOTVo5zxPTyGq9AxL
	 GhWw7sZkKjnd/H2wc+ktCmfG86ATXI3beLvbM3sZfbmyxJnfuJHQWMdyB2oTY/xIx7
	 vj5+CSa736cmhNryweZvnrNe7FQamf1nWgj3XgNm33cFWyLbbbPfg/0HphKtcPnzDj
	 rpSdboOWKu+LyTlov6jUfszQQ/KFRIO5ACDvSHcwKqkAmytgvgGmywwGxAfJ6RWx61
	 7E7D0+4BCJSLfAwvZIUiScoYautff9/29xoD1hdrwyisB/RAkxi3XtX3uvRPZCxngi
	 Z7QbsB9pNRWTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7338111DD;
	Tue, 17 Jun 2025 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: fix use-after-free in taprio_dev_notifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020303324.3735715.12082273700118012368.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:33 +0000
References: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, v4bel@theori.io

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 20:54:57 -0400 you wrote:
> Since taprio’s taprio_dev_notifier() isn’t protected by an
> RCU read-side critical section, a race with advance_sched()
> can lead to a use-after-free.
> 
> Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
> 
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: fix use-after-free in taprio_dev_notifier
    https://git.kernel.org/netdev/net/c/b160766e26d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



