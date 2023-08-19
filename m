Return-Path: <netdev+bounces-29129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12995781AC2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9CC2811FA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894756FB2;
	Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC2EBD
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAB02C433C9;
	Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470062;
	bh=zno65NsaCDTBTahswRO/GiauKWv/QcZvhjy0PyEpGB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fVVqJ5Wa/wNE7YzQT9DvtGYEhD0gKhKjR1bVu0mdSMg2de18quTSxqnvkbAe3RND6
	 FXvrc0EuKiyKCG15Y7huQtxhlVqyxhEfsKnXo4xXLlNqUeIfqnKJuqiw+ez1Z2NjL0
	 dRtSZBIYhFrBdIiMwHCMZh3SOTzGC/UTTxF7DevhF9osCH0UiFf4UQY6XxyFrnKj6k
	 jrvOfAzYWlcv5R0bV5L2QuDPydfN3Rq1m7H70WALsNqpupl53fdMokaX2m5nohWNYy
	 5Spr0UCpqIy3TiRbXeNidR9+fLDFFP6wyxPbJlAF1zlMRGrQOiyPXPPnw9JIANqaNO
	 Crq8pklFLPxOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF928E26D32;
	Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247006184.18695.13657924227141073910.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:34:21 +0000
References: <20230818125449.32061-1-fancer.lancer@gmail.com>
In-Reply-To: <20230818125449.32061-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 francesco.dolcini@toradex.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 15:54:45 +0300 you wrote:
> Since commit 91a7cda1f4b8 ("net: phy: Fix race condition on link status
> change") all the phy_error() method invocations have been causing the
> nested-mutex-lock deadlock because it's normally done in the PHY-driver
> threaded IRQ handlers which since that change have been called with the
> phydev->lock mutex held. Here is the calls thread:
> 
> IRQ: phy_interrupt()
>      +-> mutex_lock(&phydev->lock); <--------------------+
>          drv->handle_interrupt()                         | Deadlock due
>          +-> ERROR: phy_error()                          + to the nested
>                     +-> phy_process_error()              | mutex lock
>                         +-> mutex_lock(&phydev->lock); <-+
>                             phydev->state = PHY_ERROR;
>                             mutex_unlock(&phydev->lock);
>          mutex_unlock(&phydev->lock);
> 
> [...]

Here is the summary with links:
  - [net] net: phy: Fix deadlocking in phy_error() invocation
    https://git.kernel.org/netdev/net/c/a0e026e7b37e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



