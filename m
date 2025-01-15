Return-Path: <netdev+bounces-158336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA41A116D4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19377A06FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A222D4FB;
	Wed, 15 Jan 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqYFeHvn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0E1E1A05;
	Wed, 15 Jan 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905823; cv=none; b=GHySOepA3OYNvVFnv866I0aA0+CyECATsJCNe81S+0d31bsRp83QdnkatT9ds+BZ/7koyyPDymQ5yL4xHJlKpLFcEA/zX9Ecm14Az4nxk6xuEG/DZP0c5Jl9qxx7ok8Dx6O2TpuQb3GflJoQPa7Dj2aWFfVltzDZLdmAOgiG7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905823; c=relaxed/simple;
	bh=piXgpZsu1F/VKSRIMaXHHc5VRrrN0OQ0DI+orsEVKEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fw8kSAc2qvoJVp5rUXtJyD9DwTqJJcROBpmne0KnOdQ45LzAnp9IwU3pJ4u7KsKDUK8gGzQSYGE2m2qkQzZSmItewU9eKxPkItng20D+OZpryvPXSRL9HlVvAUHyN8EHt9pcMrpw1OAWlWBZr4aynsjnUTVyUtJkENEM2uPyLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqYFeHvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F22C4CEDD;
	Wed, 15 Jan 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905822;
	bh=piXgpZsu1F/VKSRIMaXHHc5VRrrN0OQ0DI+orsEVKEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NqYFeHvnUbrbwEe9MnhQ5QwV17U1SsNW4Vi1GPp62xsEHYPkte5sn5hpEw0jICsTs
	 XZuhZZevJveav4qQdykRFrBuXtIcGlk/BgwfHmGLaVmYXbPvL6qdrCeLyE/4op9dYS
	 Xytlt0aDPhYlayYTrZJanrkMAq9jSgXtqRG9+hMMzPUAqCDGd6Mq4VmHTXFlFmwlxc
	 nOivOjh+x+QEsM6qGhucyghxXt7msTBuikpoWebE8DX99Vw6cr0kRZ/b+/HCUdFtWs
	 rCPI7ibIIwmHmTm2/tBwNEywokJHdO9UqIuFBqLxi6SUUYcOewoCmsqEvd4ZIdpk+8
	 9SNlZIUhVYvxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEAB8380AA5F;
	Wed, 15 Jan 2025 01:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: xilinx: axienet: Fix IRQ coalescing packet count
 overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690584559.216599.7734406079004798430.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 01:50:45 +0000
References: <20250113163001.2335235-1-sean.anderson@linux.dev>
In-Reply-To: <20250113163001.2335235-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, shannon.nelson@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 horms@kernel.org, michal.simek@amd.com, linux-kernel@vger.kernel.org,
 daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 11:30:00 -0500 you wrote:
> If coalesce_count is greater than 255 it will not fit in the register and
> will overflow. This can be reproduced by running
> 
>     # ethtool -C ethX rx-frames 256
> 
> which will result in a timeout of 0us instead. Fix this by checking for
> invalid values and reporting an error.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: xilinx: axienet: Fix IRQ coalescing packet count overflow
    https://git.kernel.org/netdev/net/c/c17ff476f53a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



