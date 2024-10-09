Return-Path: <netdev+bounces-133632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52B99693B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650A01F24493
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3011925BD;
	Wed,  9 Oct 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKRctOIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2B191461
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474626; cv=none; b=ZPpy8CW2JG+v1Ph4Mp+4AItz7JosG7j27f9mUJ6y7NUGod3ZV0kCzx5vzPvjMCBF4LWXJgp2Rh4uJJgVCcV39AORX5KTbeWX9DuXKrVAxWwPFJ9TBcx7cK5zkQKHJVXMjRFJOsxXGv+7158PeCqo4i5Jzxmvh84+AsWmYP+0czE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474626; c=relaxed/simple;
	bh=ynwwdlAwfKJWbLK80w+o/rez6ajVqieZUlwBQ10WDQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RMGM6TNViXR88SZ+QXFj+ilTyrTxHf3nyZnunxuAdApmRB9c1+3nNTvlhJGPSNztviLDtAPeKgxI319pxe/n0ayL+4A+DEK+cNweh1uoiaE1K41NkGlXfOg7GknaaBwKmFkfNVerOkOjhZybE2xKkV8sJLEb9OSj1PpKi99cPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKRctOIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03051C4CEC5;
	Wed,  9 Oct 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474626;
	bh=ynwwdlAwfKJWbLK80w+o/rez6ajVqieZUlwBQ10WDQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NKRctOIUubynAzZ2LedoFcwSoH8+ocFtXCV/KUYf64rzCX6QkFs/5eeDERwSRkqDL
	 DzWC3oxIJqMjr8ujekgMiXsoeL0v1Z8wm7+fspsaxPGiLctTEM61jAdBnsy5bFYapg
	 uKvYVvBYYhj2o/CVcQtfieXktqLQhprxVPRuZSVybXoAPZBHtE2iD1MEod80a3mYjA
	 KhQWxWptkY8ES2olr2WQdO9GgX03Ge0bf1isUuNkgawmzZAKF2B6HiDTPwgwxdqOrj
	 euMS3wClE8oFITQ/lCfh56FCI9zCz++dhqt9irCbg/4lQuFN5YxHkOGOXoJrp/uEK7
	 CD96lssiLZ3UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715E53806644;
	Wed,  9 Oct 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: realtek: Fix MMD access on RTL8126A-integrated
 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847463026.1238216.14210224442593261683.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 11:50:30 +0000
References: <431c3bdc-d493-46b9-889a-4db3363275ff@gmail.com>
In-Reply-To: <431c3bdc-d493-46b9-889a-4db3363275ff@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 7 Oct 2024 11:57:41 +0200 you wrote:
> All MMD reads return 0 for the RTL8126A-integrated PHY. Therefore phylib
> assumes it doesn't support EEE, what results in higher power consumption,
> and a significantly higher chip temperature in my case.
> To fix this split out the PHY driver for the RTL8126A-integrated PHY
> and set the read_mmd/write_mmd callbacks to read from vendor-specific
> registers.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: realtek: Fix MMD access on RTL8126A-integrated PHY
    https://git.kernel.org/netdev/net/c/a6ad589c1d11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



