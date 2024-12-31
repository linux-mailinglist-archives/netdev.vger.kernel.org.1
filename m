Return-Path: <netdev+bounces-154603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EC9FEC2B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7257A14B2
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F23594C;
	Tue, 31 Dec 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLdcLQ2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF8134D4;
	Tue, 31 Dec 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735609211; cv=none; b=f2lxRNYKrDpT9XX07NxHSo/ayJKyWZlZhg24eu0DXnyqAwjl4R7Jqibf0hwKpe0OFBWCQc219kNeusbEL9Rr0kn9XgB4lMgZs1JkCoCkfwUr88JnBionK0i6cS/W5AaItRd5O74RqWeygNLZxK08CT3ONVMoACcfXla3jNuGxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735609211; c=relaxed/simple;
	bh=if2dCsL5d1+UQoDMcIZq2pHmPMhWYuB8ZgVCT3et4wE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQ4gXo9qSoLI1OfUC0yQtlQtFfJ5XfzYQ2pNgkNWknnboI1MrjVOP0aHfFAtw1LYmRqAWGXyjyHkjCvhbcwpQrxloLo2GGN2sckBQ6hMCCJQLaOiF//IBHlTw4Y79zRhFMdw4ujJfV6vl+RxKSMZBO1ZeLbGlkOisfOE4ORgVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLdcLQ2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B74C4CED0;
	Tue, 31 Dec 2024 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735609211;
	bh=if2dCsL5d1+UQoDMcIZq2pHmPMhWYuB8ZgVCT3et4wE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HLdcLQ2d4h+eS0LQSfmh+yYMFiKLILl1DmL2BfOKzHypARFCZfLwO81KHhmJE6laQ
	 DJqPOazwBN2+caOFTJpO1MzrMXhtMTeHjb7MmKGJl0J+YPtRI28sczr78sA2czuctO
	 FNXVRogn587UPSeAfp0Trp5kkMuyWy9h245/2RckJIXwhjhpxIWqtbpteeuOOAvW2w
	 I7StsiFZQG6RjsTZ/NfUvn6eowI9/dQmfQ1+BgqwBhAhkBZttwyK6AX3LhYaXKU4MU
	 Aihp1UzHkdF+/MAGVNwjSAS/JptvXK7RCTdewuDd0P7KRxjq4jPUub21TSMHmHSCUO
	 D3pZgWk/R7w8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB5380A964;
	Tue, 31 Dec 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net]: bcmsysport: fix call balance of priv->clk handling
 routines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173560923103.1483294.958836875087028251.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 01:40:31 +0000
References: <20241227123007.2333397-1-mordan@ispras.ru>
In-Reply-To: <20241227123007.2333397-1-mordan@ispras.ru>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pchelkin@ispras.ru, khoroshilov@ispras.ru,
 mutilin@ispras.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Dec 2024 15:30:07 +0300 you wrote:
> Check the return value of clk_prepare_enable to ensure that priv->clk has
> been successfully enabled.
> 
> If priv->clk was not enabled during bcm_sysport_probe, bcm_sysport_resume,
> or bcm_sysport_open, it must not be disabled in any subsequent execution
> paths.
> 
> [...]

Here is the summary with links:
  - [net] : bcmsysport: fix call balance of priv->clk handling routines
    https://git.kernel.org/netdev/net/c/b255ef45fcc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



