Return-Path: <netdev+bounces-90861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3A8B0808
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8EA1F21EB9
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094A15990D;
	Wed, 24 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF368SZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3291598FB
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957027; cv=none; b=RuMWzyy7L58HyBGeCLDevM6Tz0Fn63+UHzrRfO4J6k/pnl/HYD1ul9NIHNWGl6VAlu+Rfkdo5OfSbGrD/Zu2dZsuTXszWwVz7QXaUaVnXDIuy5eMeuHJZYJqc83oYW0KnCEynQC9Hgpts7I6OOFJHtTVYY0ImzlORkmARfg4Mr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957027; c=relaxed/simple;
	bh=POdpAEQEe7fm2Px+29yIGpY1QIdZp0GUCLx43IaRMkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2NXz67mmga6CmS4lBQfDCxlkSCdQA8Npe5wC26zPlsmBHfut+Z4PjWZ1BKqL50B8LzYfv+tWC5poTvdPJ17oidheCc/ndoDLaV803ky6aYiA1eFIg+dtNAR8Y1tZa7bifyP6lXrnXxKr4dGrxsgxxvzuc+TcMxzKEk8Z1JbykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF368SZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED799C2BD10;
	Wed, 24 Apr 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713957027;
	bh=POdpAEQEe7fm2Px+29yIGpY1QIdZp0GUCLx43IaRMkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pF368SZGiD9CeHMmLCcMcqZsqwdlgCdo89Cvn90YRAuAJrakaD2uLjSjgi8fw8/wd
	 WWy124um0mKGD+Nxcl2xR4qFP0F04U/3ERfX0KHwqw5YkwY4/uLw5Jw+ruYj1ohjEQ
	 9j/fXuXlqfzjbCiSRFnnu+yk3yiVFCMNNlLXicDaG84TF9NI2jNZrczvNvJ7gS/WUZ
	 6LU5tXbb1tAabccP1mm/kpe7R/bNMgE+/Nr9GvcdccxvQfxdn7RWDR3B2/0nAqRs2U
	 ISwerjd1r5fD+c2nU/7pFPtfNUFom//MtezpJ3UA0ifLke+uK9L4Hog9GJ7XDv6W46
	 bxKvorUVT8Cbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC91ECF21D8;
	Wed, 24 Apr 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: gtp: Fix Use-After-Free in gtp_dellink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171395702689.12181.3425991361261164457.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 11:10:26 +0000
References: <ZiYwUnZU+50fH0SN@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYwUnZU+50fH0SN@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pablo@netfilter.or, edumazet@google.com, laforge@gnumonks.org,
 imv4bel@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Apr 2024 05:39:30 -0400 you wrote:
> Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of gtp_dellink, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
> 
> To prevent this, it should be changed to hlist_for_each_entry_safe.
> 
> [...]

Here is the summary with links:
  - net: gtp: Fix Use-After-Free in gtp_dellink
    https://git.kernel.org/netdev/net/c/f2a904107ee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



