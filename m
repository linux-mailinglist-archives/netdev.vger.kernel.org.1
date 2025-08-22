Return-Path: <netdev+bounces-215867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C61B30AB8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C8B5E8472
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7A186E2E;
	Fri, 22 Aug 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8Qpra0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253E1494C3;
	Fri, 22 Aug 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825601; cv=none; b=mYt/1qhrhx+fu5afk+x0wFBHX5TZGShQL9mDibgvBNkrSSim5w60ib5TgRSZeJCVz8ZwFd079K6wsZ13rkZbIsO+F/SAE3ZdFGc7fMScPmIJA6AY77s+Sy2jINfi88uINDxlf6b7wTw/KrW6b0ROp+EaVcAKpDVGwcZizZ5ZSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825601; c=relaxed/simple;
	bh=WtWNlwUaJGNLxFQ6AhOXtzd2zun+Tj5TzmJk3wENCqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZC6cEtsu/jFuoCSehz3T1e8J/NE9S5LyMrURwUfYp9QlOcU9k3lRYY11jZ3Om229n0cSfdGFTKsfyH0P0T2zoaNygSeXuxYUpx49/3iVwZL9ZLftEePN4CurciPD4WXtnXxrqp73Ar62WgAmGEBYBXrqpbJm8uhE2l+6V9kHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8Qpra0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173D2C4CEEB;
	Fri, 22 Aug 2025 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755825601;
	bh=WtWNlwUaJGNLxFQ6AhOXtzd2zun+Tj5TzmJk3wENCqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8Qpra0MmYrUNmvhC9OTefLi6Vn3Dbzqfeunmqz8nZYW3zGpNEq2N7I4bbIGjstb7
	 oXWLyqYZ0pPa+no+iTVXDUO2jMA/GxaXUIqLBdiw0opfkBwcxEgaWwxArb8l4JDT88
	 pwwO3NyxdUEO1m2vzzuc3QLsqH08OOLz46s3k/otMDFkgX7Ma9UYDSTtaCaFMDRUk2
	 iPRsR3QDb0bk4xYD2SEO98l7nMi8IVcqzQPxIgefqI8VqkZ8P7uYWMBljc8Br4BMuY
	 2JMKVTt2NFadwc/scHbPZ9D3ma3lgL9gdX5uooZpQvfLAF3HcfsSlxdVM+roaQzfEO
	 VweTqBr0M5RIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C67383BF68;
	Fri, 22 Aug 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: macb: fix unregister_netdev call order in
 macb_remove()
 [v2]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582561025.1263133.13241944786966815629.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 01:20:10 +0000
References: <20250818232527.1316-1-15388634752@163.com>
In-Reply-To: <20250818232527.1316-1-15388634752@163.com>
To: luoguangfei <15388634752@163.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 07:25:27 +0800 you wrote:
> When removing a macb device, the driver calls phy_exit() before
> unregister_netdev(). This leads to a WARN from kernfs:
> 
>   ------------[ cut here ]------------
>   kernfs: can not remove 'attached_dev', no directory
>   WARNING: CPU: 1 PID: 27146 at fs/kernfs/dir.c:1683
>   Call trace:
>     kernfs_remove_by_name_ns+0xd8/0xf0
>     sysfs_remove_link+0x24/0x58
>     phy_detach+0x5c/0x168
>     phy_disconnect+0x4c/0x70
>     phylink_disconnect_phy+0x6c/0xc0 [phylink]
>     macb_close+0x6c/0x170 [macb]
>     ...
>     macb_remove+0x60/0x168 [macb]
>     platform_remove+0x5c/0x80
>     ...
> 
> [...]

Here is the summary with links:
  - net: macb: fix unregister_netdev call order in macb_remove() [v2]
    https://git.kernel.org/netdev/net/c/2df84b42f155

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



