Return-Path: <netdev+bounces-174348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45990A5E59E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044591897527
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E101EEA59;
	Wed, 12 Mar 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhz91nWV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C91EEA47;
	Wed, 12 Mar 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812600; cv=none; b=R2ZZZNOtZuCQBHIBoYyGLeYjPqcjAYVSDG/wud0NpuRyaV5iGmw/OlipnZFIPxvaElshQpTNJ80gawcz+UDkBNH3U0d2cOCJl3UylulLfdZoDTlow8xdbHJXWknCfIQ4NoyK1VSGjlcTVCiRGPa6BG9NW1Zsdxqt8b84BxdbXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812600; c=relaxed/simple;
	bh=FfGBxFWtcBfVcTWHwKl6PVZwoahFegz5oSW5Abn0QXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LT2h3NT1pF7m5zgttwrhUhRlm4rWtg+V/XYtH1ZaBjzDthM3TtIE8FfBTuJbb9RthRA8xsn0q2VO447KiN0uZa8X78ptKCinb0x6gvZwF53mBu8HjQHIUZqewo/Ia/U5m33cQJ9oU/VbeaCN4OSWvU1dL+jflYzdXc05UzzTFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhz91nWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E4C4CEDD;
	Wed, 12 Mar 2025 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741812599;
	bh=FfGBxFWtcBfVcTWHwKl6PVZwoahFegz5oSW5Abn0QXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jhz91nWVNWTPbsAxteS/s5JchdXPQ9MhuH05vLj1s2g2Ojpazr0AkeAz9NcMn4DFv
	 HX85UfenKv5Rmj6XqYQHj3He1hQgn4WbvmTJb2MJbL5fXCFE4LJDfhYxDmiTH7hORO
	 tf9oDp2fF5cW85Mb2f1Wg1FudrtnMtm4MmrHBzjTbMfAs4EZrXBLHQLcvZLEaIViSj
	 WmlyiG0lDz2DquaYgq3c/DRAlxBo/wwvk/zrflSBCehVNsTOJrJ6GI68WguUYM/sbc
	 b8oLgKXdnXWhowYOG4dBjOHHEoF8K9S+H/nx/pHDOlHBKSfYWNcUnBqM9x4dwKjOzK
	 o59+KT7FPrX0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B54380DBDF;
	Wed, 12 Mar 2025 20:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: remove rtnl_lock from the callers of
 queue APIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181263398.928071.13904102204365438144.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:50:33 +0000
References: <20250311144026.4154277-1-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Mar 2025 07:40:23 -0700 you wrote:
> All drivers that use queue management APIs already depend on the netdev
> lock. Ultimately, we want to have most of the paths that work with
> specific netdev to be rtnl_lock-free (ethtool mostly in particular).
> Queue API currently has a much smaller API surface, so start with
> rtnl_lock from it:
> 
> - add mutex to each dmabuf binding (to replace rtnl_lock)
> - move netdev lock management to the callers of netdev_rx_queue_restart
>   and drop rtnl_lock
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: create netdev_nl_sock to wrap bindings list
    https://git.kernel.org/netdev/net-next/c/b6b67141d6f1
  - [net-next,v2,2/3] net: add granular lock for the netdev netlink socket
    https://git.kernel.org/netdev/net-next/c/10eef096be25
  - [net-next,v2,3/3] net: drop rtnl_lock for queue_mgmt operations
    https://git.kernel.org/netdev/net-next/c/1d22d3060b9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



