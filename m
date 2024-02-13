Return-Path: <netdev+bounces-71147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B3852718
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32289286B6E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B55CBD;
	Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHCfPNvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC348BF3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789031; cv=none; b=ZuCkRUIYZTMayVCNrq8UQwe3zFNbBHI0WXtYphQrQ3v0+d4yMC6DU4VqQxWwi1+AQI1SF0vLg4gs735VaiPvSNd/y9ohkejHrIea7Cid/L+L0Ex28LG3EAKLPzw62ZgNtb1gNX1WglGXpjmvfRWCBK91KLSylLCjn4azeReV5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789031; c=relaxed/simple;
	bh=/j5y+0bmBl8y99U7EgG2hE07/3cEa7IUl711TOLaR2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a4l1trpx4ORt5+FieTGPGuf8xLcY0fwKYARD4Di8oSLVYnM3LXti3diEg8qN0CFrtWGrmaBrLADX2ywJ5MYI9PYfw52k48MonKpTrqPBmLjvzeTWpGYySk/ARkmJTq8AcBXEF+zgf4jYB+WCKFgzOTPlkinBhU9T0Pp9FpKqFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHCfPNvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C5D5C43390;
	Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707789031;
	bh=/j5y+0bmBl8y99U7EgG2hE07/3cEa7IUl711TOLaR2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JHCfPNvtQIwVaudAfLUs9vUEMit5pVtQF/FQdzUpFG63FjABAMrSPqwBdQh5hV++H
	 q6Qrt6NXv3j0Uzfv3PMJexEHcZk850o0zt5dEpUxK9/OqoeczqGsTgrkF2sj6oQwip
	 4/G2PEWFDFvN7x1L5j2Xq5Brciba83WoEIfd7TuMIEkz2+YG52sBzvt+HkjfjWAr84
	 DaPoa8KCidrH03V1Dl7Yr9t/oDrqA5mdlXQeGzNySYVE7YWzT1VwwY1tl6DamQgCPS
	 j7pbc06MqvAFOMcT2drZ2NRyzTUCx9FFPGUD0eNNGUrT6iETGOAge6glVPWHXZJvIt
	 BKjj7NTSUD02g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E974CD84BC3;
	Tue, 13 Feb 2024 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add rcu safety to rtnl_prop_list_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778903095.20137.8123169804494779564.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:50:30 +0000
References: <20240209181248.96637-1-edumazet@google.com>
In-Reply-To: <20240209181248.96637-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Feb 2024 18:12:48 +0000 you wrote:
> rtnl_prop_list_size() can be called while alternative names
> are added or removed concurrently.
> 
> if_nlmsg_size() / rtnl_calcit() can indeed be called
> without RTNL held.
> 
> Use explicit RCU protection to avoid UAF.
> 
> [...]

Here is the summary with links:
  - [net] net: add rcu safety to rtnl_prop_list_size()
    https://git.kernel.org/netdev/net/c/9f30831390ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



