Return-Path: <netdev+bounces-230624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A0BEC066
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745543B6AFF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70B307487;
	Fri, 17 Oct 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw49MaR+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BE2EB870
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744430; cv=none; b=T93I7IIkBcUVKdYdwvmBQ2O6Mhkkv3yh6dykKBqVLSCrT+CiJXL6G+3MMW72aKFaLvuEtBS8awkrHL70v7jWJIm6VRKdVcJtTpzyaTipzjMyh1mPNnlOUmun8gJpMgIfe4LzDZ3kq5mY0240Y0OHKEa9AW1JzBA7k44gJnKb47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744430; c=relaxed/simple;
	bh=nUqidglqSNDdkC2qHJvZn6InNgTtcFroCRwnAokGtVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghveR+vj4dwFf3+0k557xrPUK8t6GLEg7UgnC5yj7yQWkDZCuM6QYYUwxcCni71SMhtE/x0I7MpnhEGFxCPEw7o6Qc9LWMCHmoGaiO7ZOKOGIZQ5R6+ZX4FQWH8rzj3Fsc35udS5MWUer6InKodeDz2EKRCiQjSzdOpamhqcgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw49MaR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8D4C113D0;
	Fri, 17 Oct 2025 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760744429;
	bh=nUqidglqSNDdkC2qHJvZn6InNgTtcFroCRwnAokGtVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aw49MaR+2lOSF/ZvzAY7pmscDTbk8GU1/Kq3AstpiB3TQTBT0gPa8NxpfaH2yqGw+
	 viW8iJ4IxrICUL/0xpg/T+LTzE/GqJ/I/4gSMSr496dgGGV9AyMmcXKsHb5MjcWZsf
	 zPGFeYq3gxql5FGub1PB8nZexwFSAjJN99wvrwFEf+xDPCYQ/Nnya7kSIWT8adbF43
	 dkQ7rxfbHBDatGMg/eo9tlYhPc02yJPuzl8l9hBpA7CdkPRrisCHZQxyv5GlEHK1Tv
	 jsxq6CqHp5kPWeirgNoHtaEnl+FkX6hnEryY5Fw9rROJtEDNwbWVUWsV7oeKNxjqIN
	 WwPNV2YYz8CGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF739EFA5E;
	Fri, 17 Oct 2025 23:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] net: Avoid ehash lookup races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074441324.2826097.8362521486408596129.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 23:40:13 +0000
References: <20251015020236.431822-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20251015020236.431822-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 paulmck@kernel.org, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 jiayuan.chen@linux.dev, ncardwell@google.com, dsahern@kernel.org,
 luoxuanqiang@kylinos.cn, frederic@kernel.org, neeraj.upadhyay@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 10:02:33 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
> during the switch from reqsk/sk to sk/tw.
> 
> Now that both timewait sock (tw) and full sock (sk) reside on the same
> ehash chain, it is appropriate to introduce hlist_nulls replace
> operations, to eliminate the race conditions caused by this window.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
    https://git.kernel.org/netdev/net-next/c/9c4609225ec1
  - [net-next,v8,2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
    https://git.kernel.org/netdev/net-next/c/1532ed0d0753
  - [net-next,v8,3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
    https://git.kernel.org/netdev/net-next/c/b8ec80b13021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



