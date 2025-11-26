Return-Path: <netdev+bounces-241749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA2C87EEE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44A944E3FAD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A330DEA3;
	Wed, 26 Nov 2025 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQd+nXeQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27E30DD3F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127248; cv=none; b=Q+jKeOFvvAEyW2QuMfV9rdpEHs6+JBDObj4WxaLCLQVepBEtMEpJ3rP929UjshoNnOmQvR/ViZWzwvjWJv7MCBbD0Huqdh1GP1WX1N5w3RSH8C8FDzX3sA0aT0GaNRW3wNiz+CQGDc8pqghvWeiNTohGtk7G8pIXAUt5NVolpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127248; c=relaxed/simple;
	bh=naTAQnpyGzHiBErM43FwFpdtty+5s/JZpZKn59RCTRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cika6rPSlK90Ao44mibymp/HBxvrsqxLpzzQmX8KBkw3CpY1T+8znFzoyDMrPQ5WmKuIQzv1f4JS+3WlUYaWIOVEOV4jR2QxtPCyPvxJ22hgjVds96e27XcAMHdzC+Qne5pHam6kZMQiDC7dlYAztOqlCGpIDDLvi8PT9ZglY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQd+nXeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE5C113D0;
	Wed, 26 Nov 2025 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127248;
	bh=naTAQnpyGzHiBErM43FwFpdtty+5s/JZpZKn59RCTRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tQd+nXeQCQV2Sh+AqVNDVAGvYyem2BCBqP5x6hJRqPHGrS/Zu6pvmKOvK+Zn57y9g
	 VCNBJo/Mvd+XfxckuofQj1xhs1avf9t5IALdMDa9I9QsWae7skkQRxjrBBQ5QV6wy9
	 n+uyxU1rl1dAKz3hMKF18A1Z5NlDgJLCNYjBI0l+DF0G/EYKCcDxqUsF6cgSwRgB1k
	 7Tu7XOZ4NfQoYGuBrMTKrS6RimM9e1vzocRNxR+flDvAt4L2qZEJvmqrd5pCCCWTwU
	 qqEu7OpDrNcBdgZ2UN0fp6FfxtQZLU2nW+A9rJqD582Yf4IBlHYgn1U5bHviJYx13f
	 oFV8zXBeE/kHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF56380AAE9;
	Wed, 26 Nov 2025 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sxgbe: fix potential NULL dereference in
 sxgbe_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412721025.1502845.2428357241156284947.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:10 +0000
References: <20251121123834.97748-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20251121123834.97748-1-aleksei.kodanev@bell-sw.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, bh74.an@samsung.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ks.giri@samsung.com, siva.kallam@samsung.com, vipul.pandya@samsung.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 12:38:34 +0000 you wrote:
> Currently, when skb is null, the driver prints an error and then
> dereferences skb on the next line.
> 
> To fix this, let's add a 'break' after the error message to switch
> to sxgbe_rx_refill(), which is similar to the approach taken by the
> other drivers in this particular case, e.g. calxeda with xgmac_rx().
> 
> [...]

Here is the summary with links:
  - [net] net: sxgbe: fix potential NULL dereference in sxgbe_rx()
    https://git.kernel.org/netdev/net/c/f5bce28f6b91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



