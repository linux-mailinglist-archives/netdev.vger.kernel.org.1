Return-Path: <netdev+bounces-72333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBA857954
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1682A1F21632
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A01F93E;
	Fri, 16 Feb 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSGt5TOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EC200C4
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077025; cv=none; b=eVwURBNbOuIjdFtMMYEgOC6YWP7hPgotZ3ywJC1lN1FR84C0Sg9IRRFDBYsFOwVXjDJvUyg9WbBbGNd150khY0RnIuslZpqQb/hUtLEIP4rk86drYe2NnvKuIQAbuTsxkCIqwzwIPf5jEAsrFm1nCXGTWkmoevRj08+NFtgb+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077025; c=relaxed/simple;
	bh=H7Zk8DzMwJgogZ1RwAVQQc8dPhzXPwVbDeyZcHB4tBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2s81g9l7E9UVq98j3cC/zN+B78z4seLxNsOIFRiTEOERT5sYKLPe3py8N+i6DE9SCG5rKRWzclLHgntOx7+MROtHX+4SwihvrCWzY5+9/svAtEsecArcjoK98uCtapYhfltwR1I7xdJ5Ifwe3hOzYgx21RDQTGwGnlTO6Cl2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSGt5TOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A6DC43330;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077024;
	bh=H7Zk8DzMwJgogZ1RwAVQQc8dPhzXPwVbDeyZcHB4tBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YSGt5TObAZPH9StpfDMgM6m0fSGtCXuZ60u9BQ3SDktzRA3brImBV+eMuy7gwAtnF
	 lY7blKXG4gvLajaopnsDkGzcL9VZox/F0LpX/TYMsxOrQNEq8Bw2g/4eNNJp86HQqV
	 Oy5wl4FiaDQjnbkIs7iEBZEGHPG83PEcYR2U1PzLQFPjIWq17Yvl8jd9R05X/M//we
	 pKu4mybG/3/tPvoUthBD6Vwn8FxJNnHGmlATe5nX3lb3/Igmz3MyKeDHWo6D4hUt2+
	 jkSrAK+MzJJMa4xCUothJMBI3C9+HgkFLP95MVGpCrzeelj9zklOTAt1kr9SvuPNlA
	 cQE+lsR4bJXtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8C6DD84BCD;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure
 after check_estalblished().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807702475.29322.4063439451772691558.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 09:50:24 +0000
References: <20240214191308.98504-1-kuniyu@amazon.com>
In-Reply-To: <20240214191308.98504-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, joannelkoong@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 11:13:08 -0800 you wrote:
> syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> repro.
> 
>   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
> 
> However, the syzkaller's log hinted that connect() failed just before
> the warning due to FAULT_INJECTION.  [1]
> 
> [...]

Here is the summary with links:
  - [v3,net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
    https://git.kernel.org/netdev/net/c/66b60b0c8c4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



