Return-Path: <netdev+bounces-236939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD3C4254D
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5D43BF177
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB2157480;
	Sat,  8 Nov 2025 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZT0FYEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706D748F;
	Sat,  8 Nov 2025 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570835; cv=none; b=ez+2iBHJahSV28XGhuyQB1AC0jkaJ864/1E/Z5eNuSf5t8CtEzokz4w+mSGKkJd0FLM0xXT2ghz88zGAIkBD+4U/6L3mLk4zXcvisFSQSQweaUfHFbRModwbO8uRqNUP/0VEnET1JjuMgZtbfLbodjmlOmI4gqUKmVkgJIS94hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570835; c=relaxed/simple;
	bh=Vy1J3SyqFWlVAbP05a62I5YuDOrB6SkejVaOSzy3d98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CPDUddtL9N603V8zwmoA50qpSxUEqDo57uUqrZcWBXcp2Pju10cSdYtJk9MJRXN7lpsEBIf3aCm/J14FJ+LRHbrN0ntrGSOFtEZxdg6S9ltKYDQZZmbBhdX2M1ZeHJPY5f9vRshDU3cCTS50Yc63jshgC+M9nyeCiK1E1EVXbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZT0FYEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4588C19421;
	Sat,  8 Nov 2025 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570834;
	bh=Vy1J3SyqFWlVAbP05a62I5YuDOrB6SkejVaOSzy3d98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XZT0FYElu90WYbbDSDLHzO9cbv4q5shUgjxmKjjKxTVM5+mIcqErRxRruQJNdVvL7
	 xSQ3vTiR6eJ450D1K7D+0ReR3Wrwl4jo1QTrC7tgzYRsd+yIL4fHEB4VLC88/fzUt3
	 48ZF9LtSUEPqX5uOisLh2v/94cIR4OWP1kMb/YG/dGiq6BgIizcIErnUBgMJyS47nN
	 GdjuQhYIjuQx19B2drWR+1KFQt8Sid8nYNPl4zXExJmj53pEHt5kCNhcsMId3qGL6B
	 +k7jL1KnjsvdXfkPvw6MMcGhYZ2vtXolgy0ZJU8rjsvf099B1HLReSqMDPfoo9/Rju
	 f+gJzCD68VteA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4A3A40FCA;
	Sat,  8 Nov 2025 03:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: correct rx_bytes statistic for the case
 SHIFT16
 is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257080700.1232193.7245500159998786642.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:07 +0000
References: <20251106021421.2096585-1-wei.fang@nxp.com>
In-Reply-To: <20251106021421.2096585-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eric@nelint.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 10:14:21 +0800 you wrote:
> Two additional bytes in front of each frame received into the RX FIFO if
> SHIFT16 is set, so we need to subtract the extra two bytes from pkt_len
> to correct the statistic of rx_bytes.
> 
> Fixes: 3ac72b7b63d5 ("net: fec: align IP header in hardware")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] net: fec: correct rx_bytes statistic for the case SHIFT16 is set
    https://git.kernel.org/netdev/net/c/ad17e7e92a7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



