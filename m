Return-Path: <netdev+bounces-90744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB48AFE4A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CD5B21551
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98524134AC;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcWgRvok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72158125D5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925228; cv=none; b=n0HbCZmzbXKJFo55Sw3SKxXhBkECEdgxrN0I+lgwztN4gB41inTmhT3SCmHUTL7jwTLNRJNwdIpZ+SCVezkDa8402mLQhGn1QKAilm3Vd9mP1W23bHqdwYr8zU65LjxFEd90Dr3H4/bKXrCXd3vA1cL9wCQTwdKXrVNFrKwzhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925228; c=relaxed/simple;
	bh=lNtY9J43P8KFZSrK+3zMn5R5o7lR1tw46HlH1mhIIec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T59CA3kNwGL33LdcUX6TBFX0RDFUdl92EphTRP6Ju1/VzfaxdMLgnjyIsH2I4KdN2OVlSGkBjmm8+IYn4yNkfNv2B0cWlb/Fe3ixvLYAlrRZhesJ/Vm7QrBejobSloh8CZleFxjZLBfmx7Aa98Nkxye646cUaalzbj6j8vcSt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcWgRvok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2393DC32782;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713925228;
	bh=lNtY9J43P8KFZSrK+3zMn5R5o7lR1tw46HlH1mhIIec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lcWgRvokjP5AQupmugFTKEzVuMNoBY/4zgsJHzw5vzvj4hNiBy133VG8If92/P+Ci
	 ffpaFOUx0NRLA57pYJa27oQ39B6hBzc1brB+LY+htfyEqV2bxJ9xFj6R0IsFtL4WHW
	 cmOgbjDlY03BmGpZsr9i9STSRz3F5oen1sEVcpQpHAdLlJUEQXNyzesa7gOBYXuvSl
	 L0HH+H8SRndrhof7VdC+aDir5QTn+4SllpuncvYuCQC90RpgAESvGFpHWZ3lkTl9U/
	 +3SZ1TB0tBpI/L7nroFsznnRSLMU0gYHPdgYcwiDzTdL1srYFE65E1DDpwQ1DFm2Ws
	 PB25kfcBXxLsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AC25DEC7DE;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp: Fix Use-After-Free in tcp_ao_connect_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392522803.21916.8050553701739889698.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 02:20:28 +0000
References: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: edumazet@google.com, 0x7f454c46@gmail.com, imv4bel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 05:33:40 -0400 you wrote:
> Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of tcp_ao_connect_init, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
> 
> To prevent this, it should be changed to hlist_for_each_entry_safe.
> 
> [...]

Here is the summary with links:
  - tcp: Fix Use-After-Free in tcp_ao_connect_init
    https://git.kernel.org/netdev/net/c/80e679b352c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



