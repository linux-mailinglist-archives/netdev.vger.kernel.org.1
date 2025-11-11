Return-Path: <netdev+bounces-237400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B41C4AA7E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2283B3C15
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E9341661;
	Tue, 11 Nov 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsZ5Vzr2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0C34165A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824040; cv=none; b=sCmCPV2n8NmnTlZ8TuRTf7CLVGRVMvM6xuc6u8x3veSQX4FHR6ByFAyRxNEDgSsUm+0sCvE0DVhfSEoTeBskKGl+OBNl1jmzNZe1OkvvG8+7jyYagxiZWDhGfpoLqNgpq5i6O4AhH0G+7UqGmGedGo+rr3LuRDhtz4EAUMovNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824040; c=relaxed/simple;
	bh=Hs/caOKcz7dDsvbKz6ieBxxnISBDRnSvj9nRCyfK5AE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IOXKcEIVeh/OsLFQxY+/SilQjUp6d8M0GPT+YSYE5QNNr2ADcu2fuK5VH7NxkWzM3cu+3s0kg389UaONH5pds5go54GO6jQnLpQKRDOlM9eIKJ+3KLMss8fa3ti6DZvxokcmf/QVMCwcfJP/rQHvrnKlCdQkp8lCTtQb1T28wUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsZ5Vzr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7375C4CEF5;
	Tue, 11 Nov 2025 01:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824039;
	bh=Hs/caOKcz7dDsvbKz6ieBxxnISBDRnSvj9nRCyfK5AE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IsZ5Vzr2v3K+TirqR6+NZGVlNrBQMN0aF1TiZqa7+ncD8jozEc+KAl0sXYs6DUY+/
	 Q1UBz2jXqUfemuGPeKxTUvz8n5i3Zj8L52bk5X/WExjMD/MXfo66vQBKM+KLzoy0uP
	 EyzSIvTJNUSYeMpMh7QT/gzue2GdWnIaC1S8pY7uUdDSPQl2H+R+DicUemw40iOxWW
	 Yt2t9ovrBIVaogf7LsuknNpXdvqM4KtqJsLadtSH5jGT+6Gzh+82TP4XcS1UDARrin
	 U+ikV1BSG/ljSoUQv5QrK2m1Qnrd7xpuWb7bs8ekWyvhDV/bfwNoneixMgBTk+vk10
	 w9z00Div/yaZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE224380CFD7;
	Tue, 11 Nov 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: Abort __tc_modify_qdisc if parent is a
 clsact/ingress qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282401024.2838761.18211030225410260090.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:20:10 +0000
References: <20251106205621.3307639-1-victor@mojatatu.com>
In-Reply-To: <20251106205621.3307639-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, wangliang74@huawei.com,
 pctammela@mojatatu.ai

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 17:56:20 -0300 you wrote:
> Wang reported an illegal configuration [1] where the user attempts to add a
> child qdisc to the ingress qdisc as follows:
> 
> tc qdisc add dev eth0 handle ffff:0 ingress
> tc qdisc add dev eth0 handle ffe0:0 parent ffff:a fq
> 
> To solve this, we reject any configuration attempt to add a child qdisc to
> ingress or clsact.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: Abort __tc_modify_qdisc if parent is a clsact/ingress qdisc
    https://git.kernel.org/netdev/net/c/e781122d76f0
  - [net,2/2] selftests/tc-testing: Create tests trying to add children to clsact/ingress qdiscs
    https://git.kernel.org/netdev/net/c/60260ad93586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



