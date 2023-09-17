Return-Path: <netdev+bounces-34346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B57A35B6
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8070F2814EF
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237946BF;
	Sun, 17 Sep 2023 13:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF341859
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D59C6C433C9;
	Sun, 17 Sep 2023 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694958024;
	bh=23aoHGVEZA5ZJKjN+bz4DtmLBXIu3RIdG2yOHRpZ/pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tYeA8RVtatrclwmlB5hjX2/Ahodj/xJpdzmRLzUHYERjHDUVhRj+jbvCEQs4ieYmJ
	 cMU6W/TIr78oLKfX6iCWXT6scO8vUjiNHfxrHYHMgfWP+AqUf4aMjM/gsANyytdpiG
	 lQR/g34WOYu0c6wZpgUeolKx7+g1kYm6lrwAR2xNOs8y0OGiHv7do6yKzAoygCbD0V
	 /Hje5qgwEAYQkw1odnRqrwhb+roceNDaOIskmcPtxNchAOcEsTxhRJB0u/YCAGVjsC
	 JLmiWYemhzBMFj2LBs1FdPGKbiKo8qoQP6wF1gFgH2uvJnOMER5KkNU1g/S6DzPRgK
	 sYkrBbglYoRcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B56D2E26880;
	Sun, 17 Sep 2023 13:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: phy: avoid race when erroring stopping PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169495802473.29369.10874261402549315982.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 13:40:24 +0000
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
In-Reply-To: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, chenhao418@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shaojijie@huawei.com, lanhao@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, pabeni@redhat.com, shenjian15@huawei.com,
 wangjie125@huawei.com, wangpeiyang1@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 16:34:17 +0100 you wrote:
> This series addresses a problem reported by Jijie Shao where the PHY
> state machine can race with phy_stop() leading to an incorrect state.
> 
> The issue centres around phy_state_machine() dropping the phydev->lock
> mutex briefly, which allows phy_stop() to get in half-way through the
> state machine, and when the state machine resumes, it overwrites
> phydev->state with a value incompatible with a stopped PHY. This causes
> a subsequent phy_start() to issue a warning.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: phy: always call phy_process_state_change() under lock
    https://git.kernel.org/netdev/net-next/c/8da77df649c4
  - [net-next,2/7] net: phy: call phy_error_precise() while holding the lock
    https://git.kernel.org/netdev/net-next/c/ef113a60d0a9
  - [net-next,3/7] net: phy: move call to start aneg
    https://git.kernel.org/netdev/net-next/c/ea5968cd7d6e
  - [net-next,4/7] net: phy: move phy_suspend() to end of phy_state_machine()
    https://git.kernel.org/netdev/net-next/c/6e19b3502c59
  - [net-next,5/7] net: phy: move phy_state_machine()
    https://git.kernel.org/netdev/net-next/c/c398ef41b6d4
  - [net-next,6/7] net: phy: split locked and unlocked section of phy_state_machine()
    https://git.kernel.org/netdev/net-next/c/8635c0663e6b
  - [net-next,7/7] net: phy: convert phy_stop() to use split state machine
    https://git.kernel.org/netdev/net-next/c/adcbb85508c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



