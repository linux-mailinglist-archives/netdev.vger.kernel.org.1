Return-Path: <netdev+bounces-117710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9D94EDF4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA971C21BCE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3D117B4FF;
	Mon, 12 Aug 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRRxEH5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34D1D699;
	Mon, 12 Aug 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468827; cv=none; b=nNtKVCBcVmxWDonb0dwHRVY2OO0WpltCc5djiJnq1H3xhi/PTupsyMYW/FTP+c7AgmZsw/+PgpIEdhSfdivStcvwT2urDhQXxgLRgUhxawwRk8+zn2c4iaCsBFtsPd9Z1ZsMz/JALLunrh/1zzUHM7aEGgEKZgvP5+pwCO2tBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468827; c=relaxed/simple;
	bh=Y9rNj4VgWST9LHQuXoXSSHBNGwGl6tL0CsD6uHMMwXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cs6zxcjs0CERPVzwGw4zifbH6WnhX7aqgwjD6YPjh7CF/KhltIGfNzPZIx+M6oWe95LunGie5FSEE6Vr3k9uXFjWLXhV5Vo8BDD1TbA5zFe36qw3nnTNVZgW+SDBzS060KTtz5IcIZNCbVxdIk1ohji8n17jRLPYuv/6UBVZDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRRxEH5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B687C4AF09;
	Mon, 12 Aug 2024 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468827;
	bh=Y9rNj4VgWST9LHQuXoXSSHBNGwGl6tL0CsD6uHMMwXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRRxEH5dYuZUxrFr5ib3ZZB1KFJv9trPJwNPiubDsWkvVSqdrLFWIpToUCIyfN96K
	 Te2KFxVpmDGTk2DpxHGoFstVG5rSYcGvBmdY7mXWFHEkOHHluDrR6iR2E73a5pXosk
	 gy4zXm90dCE9HNRKiKz6niqYTZOqGipuS2M2G4o+U6uk+67sH9s4wLj58nyMvJ9cf+
	 EXgC/FEMiCOewO+zExa2VdeL7umv7d6T96fbEu0Lvl59qZoE2wjq0LKbx0pSnDZRTp
	 Zg4wp05M1tz5vEaWlWKO0xmFbUV9dc1YvoulCw4NZUXnpNkZiL4iCCAM55+CCNWwbg
	 Fybv5tAD+ArkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C04382332D;
	Mon, 12 Aug 2024 13:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_wed: fix use-after-free panic in
 mtk_wed_setup_tc_block_cb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346882628.1022466.3636636409697645083.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 13:20:26 +0000
References: <tencent_7962673263816B802001C50C5EE77D0DF405@qq.com>
In-Reply-To: <tencent_7962673263816B802001C50C5EE77D0DF405@qq.com>
To: None <everything411@qq.com>
Cc: nbd@nbd.name, netdev@vger.kernel.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 10 Aug 2024 13:26:51 +0800 you wrote:
> From: Zheng Zhang <everything411@qq.com>
> 
> When there are multiple ap interfaces on one band and with WED on,
> turning the interface down will cause a kernel panic on MT798X.
> 
> Previously, cb_priv was freed in mtk_wed_setup_tc_block() without
> marking NULL,and mtk_wed_setup_tc_block_cb() didn't check the value, too.
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_wed: fix use-after-free panic in mtk_wed_setup_tc_block_cb()
    https://git.kernel.org/netdev/net/c/db1b4bedb9b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



