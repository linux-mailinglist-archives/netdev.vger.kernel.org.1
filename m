Return-Path: <netdev+bounces-161220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F7A20116
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0BD3A2456
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48B1D9A50;
	Mon, 27 Jan 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgtOU7Gi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E61990B7
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018207; cv=none; b=YXvOcdKC7eNo7SjEOkZsaPje8mfvtjzSY6WfhmW51FyeEVATGOKB96Pua+PW7UPa0jokSmCQzs4tVfwxs6m2x/qALPcMcWgZj8iF0MYilYrSWsKlF1OieyeK/0yahIcGSYNAvTbUc17QfQ6DoVnN8E3lxMrbXvLih82MAJpBmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018207; c=relaxed/simple;
	bh=SjLOcQ912BLkkTZ5imgfW5bh2IwtninnrceNd2cR0u4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pX22qdqRgPoirhucSLZ1lBuzpwZU0Tryi5Q7AlrDrAHArbJBKDt3OYDVkx9sS7Oysrgm9NrYrGNi+pc+jYxWZRPkBQ2ApkjVh4Gu7SzJFSJwnAdwBvMQ2vfGW9zhLKFL9fdwnWpLQ55wa9NlZVnMONPn5ZAED8Y2vX1x1jr3hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgtOU7Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C29AC4CED2;
	Mon, 27 Jan 2025 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738018205;
	bh=SjLOcQ912BLkkTZ5imgfW5bh2IwtninnrceNd2cR0u4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LgtOU7GiRn3wbo0YNLwueSwaferWZm+mqT1dBX2fdzHigDfP+na23dd6Lu8+8Ltbe
	 AkvFjzkQfM6XJvQPS5fzWMm6GIAtPgNmZEVCQlxpOzxEcvzijjEnlZspJyllqh/N2Z
	 TVLCzeiShkGfY+0S2zkBxbh77ZWsIRn1sN5SehT08+RQ8Mdv7m7gBH2w5hg5GQNg5E
	 qvA6lUFseDY6ZkH8bzNn20MWTwUlSZHwu0+72Z65Iv0WBbUQQL164McJqS/pLfZmj5
	 5m878PlWyWOI/t2GB2Efd4SukOzA7tW26z2DsG2Oc0yFoMkHs8B3bo6apzSIHB/owL
	 bPkoGGk5OILAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1D380AA63;
	Mon, 27 Jan 2025 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: don't assume core pre-populates HDS params on
 GET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801823127.3248259.15864016856612867120.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:50:31 +0000
References: <20250123221410.1067678-1-kuba@kernel.org>
In-Reply-To: <20250123221410.1067678-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 14:14:10 -0800 you wrote:
> Syzbot reports:
> 
>   BUG: KMSAN: uninit-value in nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
>    nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
>    ethtool_set_ringparam+0x268/0x570 net/ethtool/ioctl.c:2072
>    __dev_ethtool net/ethtool/ioctl.c:3209 [inline]
>    dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398
>    dev_ioctl+0xb0e/0x1280 net/core/dev_ioctl.c:759
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: don't assume core pre-populates HDS params on GET
    https://git.kernel.org/netdev/net/c/6db9d3a536cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



