Return-Path: <netdev+bounces-218436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EDB3C75A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD158774D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2AD2472A2;
	Sat, 30 Aug 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR32Nk3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891030CDA5
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520402; cv=none; b=NkqVJql7Ras+zZ9l/fmQVCPiJlLrDTUHvuifWsbF1ylBmQ+VV+MenYzexxQTQjJORB4njl+qrUeo1NKaAXmhabL/GLYG4UMYXFK037q9WXVpcRS0vlUBg7nqeamCDi8O3OHbxHm6q36Wu6UTG0ctmEdjbmCIf/6N7/dNqsd1S98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520402; c=relaxed/simple;
	bh=b5Iupua4tGfMoeCnCmppCZWCGyWJtWAg6ZbMq8RxSWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N/75ONi+bHptjXlDq3M3O/JFYVswWyAabrDn8+QJTgsjOTHz6DihMbL+vgiVjuM1gytSiIOAGBK4ckrlcK77oYomrr1fhRnMk5su3Ma/qug17WUEqYfARu/WbZOMabGpEAXd6Wsi2x2vLoGCqr67h4Rhw862QU//flC5tpr/kS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR32Nk3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78E2C4CEF0;
	Sat, 30 Aug 2025 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520401;
	bh=b5Iupua4tGfMoeCnCmppCZWCGyWJtWAg6ZbMq8RxSWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KR32Nk3P8hv1ra0wCRJ+yxWgGliWPDRRdMvkG8RvcMmg1L0iUFqhtf5G3IYoxIagH
	 gsm3gkIVweczyH9y/DuYWhlSoTcu8D7XyEFPmfwOO5cP1jj1PCd7RenJuPAAGqa3b4
	 5cTvTguQh8vewkU+H25C+dNa6HrL1z3xSmP6r+ZPUQvHLSgL1BPXsYkjmyjt6hS9tI
	 QgEcLnzR7WgaXfnCEiJfb/4uZf5GcGFGGzeH8jGeJSSYYpMfqfRQWZHFgyY9lzaOCQ
	 5Z4oiAhPbneBqOG9OlT8V+JKejXWT0KVH9ZCYD5kTVXSyb2OsWkLVjihhAjqM6nO09
	 UGimXRkK77okQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B60383BF75;
	Sat, 30 Aug 2025 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net_sched: gen_estimator: fix est_timer() vs
 CONFIG_PREEMPT_RT=y
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652040825.2398246.18294908645803503145.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:20:08 +0000
References: <20250827162352.3960779-1-edumazet@google.com>
In-Reply-To: <20250827162352.3960779-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com, bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 16:23:52 +0000 you wrote:
> syzbot reported a WARNING in est_timer() [1]
> 
> Problem here is that with CONFIG_PREEMPT_RT=y, timer callbacks
> can be preempted.
> 
> Adopt preempt_disable_nested()/preempt_enable_nested() to fix this.
> 
> [...]

Here is the summary with links:
  - [v2,net] net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y
    https://git.kernel.org/netdev/net/c/9f74c0ea9b26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



