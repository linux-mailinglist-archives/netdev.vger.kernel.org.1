Return-Path: <netdev+bounces-205069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA4AFD043
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A3D7B2085
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842C2E5B21;
	Tue,  8 Jul 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crbcAhI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC12E5B1F;
	Tue,  8 Jul 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990998; cv=none; b=Ys8+ThiDZ10YFBGHd3w2l65b4FUB15OI2WCHHC/+KBeMxUFbB7yrohPQoJ09venPoHxy4AbffTVRkNwisGSHrMeIL1fxuI6EJe8w/6ndMkJVkA3B6iFrkNF7rk5OiUuHsfWdwgX7+//K7bNnKnwSkjtR8PWbK3dKt/YC3nakswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990998; c=relaxed/simple;
	bh=t3mvrMIcy/79FXuMLK5XWUKhx/6LM12SR6Z/0TqBx+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ata31dH6LUBVMubiWNckmXk7yjHLE/4j4zT59mzaDtUU/zqYeMRSAUlB7cQloSVKeg5BPoNIKb8dVDAj5/Ca9E0klfhYXsdo8C24V05TZQPmiNahi7HivApoEBvWkrvSeBWrxCIibDnKLgNi76s6XTVb4TcWXg0aRevUGYUi3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crbcAhI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB0EC4CEED;
	Tue,  8 Jul 2025 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990998;
	bh=t3mvrMIcy/79FXuMLK5XWUKhx/6LM12SR6Z/0TqBx+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=crbcAhI+cccrN5VD1pj7UM+JSbdzz9tf9au20E2U1CCDDV2tNPJ6hu2qQtgYo86s/
	 nS9XOJgXaZA737rqSvMrMBBpmm4ydLiZZfVzZlxd5gKWPPnDmrbez1FI+kAhutGGoX
	 lad9vmU1GOH3OsxdRsZTnW81ptg1/so9WCvLvq5njRarSCa+lIGYWCNepwjhppen9M
	 QNNmd3vjM/xCH3zCO6IyMpjuxp0XgTZKhWTdyC93DpifHG9lR6U4wXvovvuMd7ygm4
	 Nz/M95f1La3msHPmfV7eMcHPhN1S+sDFifLfUJXQgGMxCH51orqEWM3dnWmPF5OdLb
	 eMCwWQci7xL+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342F3380DBEE;
	Tue,  8 Jul 2025 16:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199102074.4122127.1763624884260031017.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:10:20 +0000
References: <20250702160741.1204919-1-gfengyuan@google.com>
In-Reply-To: <20250702160741.1204919-1-gfengyuan@google.com>
To: Fengyuan Gong <gfengyuan@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, toke@toke.dk,
 edumazet@google.com, davem@davemloft.net, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cake@lists.bufferbloat.net, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 16:07:41 +0000 you wrote:
> Refine qdisc_pkt_len_init to include headers up through
> the inner transport header when computing header size
> for encapsulations. Also refine net/sched/sch_cake.c
> borrowed from qdisc_pkt_len_init().
> 
> Signed-off-by: Fengyuan Gong <gfengyuan@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: account for encap headers in qdisc pkt len
    https://git.kernel.org/netdev/net-next/c/a41851bea7bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



