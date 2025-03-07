Return-Path: <netdev+bounces-172707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9934A55C35
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A06188F9DC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42513C8EA;
	Fri,  7 Mar 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3q+bQgc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588C13A88A
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308605; cv=none; b=Uck6RoXirGmyyh07Ru7Plyy8yHjWPa9m3UBcvBb+2dBfY3cArvnQpHMChrkNIxpi3hn4fJ2c5ZikzwhMDGr8lefMkBlTuSUvGXL9G7tGdy0zcaVjWevbl5nSVbNX6I9tgjDz90NAgTrkNw7IzIjP0ejUJEQPamxLKvIf60go3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308605; c=relaxed/simple;
	bh=k+QGs8UJazLvwtaSasdsV2fYOGm2zy64SGuQoDxyQqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cij0AgFwhNRgWTuih0NhJGl4vlRtmAxJDnDYjCldHaiwlBSIgRLlll2FNYUUjxmeuay9nykecpypRF4DB6a5hVUSHgB7nHwwIM5gTY1janNlw1lRCmzcNydGsnoXx6t9lyj7mWFdfpLAP67CFNqKxnXQBfJhE5I/7c1N3MuM5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3q+bQgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1166C4CEE5;
	Fri,  7 Mar 2025 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308605;
	bh=k+QGs8UJazLvwtaSasdsV2fYOGm2zy64SGuQoDxyQqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3q+bQgc7pQM+7XfeDpWgiRv8eL0ZlvII6KhdWJZDaachKhuGfMOpnaC2+TmfxH7I
	 MtiTttWHCGD73I0njm4+BvEljdRtd/2+xsOzrbMYpSBubI2sfBNUpBNt166bjxHaPQ
	 k5TAXd2okviQiArRXAhy3jVvI6dOUdqS6SJ73LpEFxngQTE3bI5ao+UULZTL/NLHok
	 ulgYjuQEh/0hgyESuom8GJmX9Ejo7VjY43kMyoG2gu+7HmWGFhah8n3V4Qiu7jBC2P
	 fuT7P8TjYkR+Pawm3F6hDi36CM/iS0ImItJWrPqGJ5stx82Uq12gBZkgcXXegxBfv9
	 MU9kAjBhZmBlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C61380CFF6;
	Fri,  7 Mar 2025 00:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: simplify phylink_suspend() and
 phylink_resume() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130863899.1835493.10259048343165526348.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:50:38 +0000
References: <E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 11:21:27 +0000 you wrote:
> Currently, the calls to phylink's suspend and resume functions are
> inside overly complex tests, and boil down to:
> 
> 	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> 		call phylink
> 	} else {
> 		call phylink and
> 		if (device_may_wakeup(priv->device))
> 			do something else
> 	}
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: simplify phylink_suspend() and phylink_resume() calls
    https://git.kernel.org/netdev/net-next/c/f732549eb303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



