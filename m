Return-Path: <netdev+bounces-222373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B1B5400E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD25A6E44
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E3195B1A;
	Fri, 12 Sep 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpmSTASq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA31957FC
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642403; cv=none; b=OViOtb621Vlb9Nu9FmQKDv0Yw8cBtr2U+tn+Tz+mrsQ4yj5JKvOImUnQM6eZ6iddTmQG3v3s7hw0WHv1RjM4OiAreASyLxvVr2DlxoWArB7euVsTCVTmC1Ygf59e225n9d0kTyLVHI4Eb1itQnNfcMTEawF42tVh++v/8JK+OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642403; c=relaxed/simple;
	bh=0fpMs+M34glu60tIOWrZ8WX7GPVrlPCGRSHkCUnAbP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=diH8GrzD5CavK1NU93JExKH8m3Kf4ywfbCpyJauPnhtQi9KHp8pB2E/t1046zbUAbG4Oy1Vo4VeXexPDCaNywW1jf2kbriDMQACse9KV7gIJ4TdV8KT/DwwMc9lnNBbHMF4bS1G6Q/T79NcYqY+4S63Ed54ZaI6BlH4FJZf5NpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpmSTASq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC56C4CEF0;
	Fri, 12 Sep 2025 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642403;
	bh=0fpMs+M34glu60tIOWrZ8WX7GPVrlPCGRSHkCUnAbP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cpmSTASqT/NMN78ceQqnG3vxOjrVnia1aSizhHBF8IEHmqJ6LWyDY7UqxoJzPwB+5
	 bsKKaoZyHUt91cHIFwqFHe0JHxI9UeIxnLWxOM7MRywpAE2hCw8kH9mmwacNXE9R5o
	 +xczJhQARqOvYofkBjiADpdZoZVQsMwWvuvTZZYCk8seN2ncf9Z8X6X7dRV/9vWdTy
	 s/i6Q18PKcYLLIE7uU31z1RuEe36Nf3gEPuVXpHO2tfCvLugPEX4DmuN3ABPCwUfEr
	 raMMQyoOXa1Ic34ZhDo6Tzp2Wi1rlcI1ue2tjpUZUeEs3Ku+h5CGdGUxl9SlK+VyxR
	 klBTEDzHNoUjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B79383BF69;
	Fri, 12 Sep 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-switch: fix buffer pool seeding for control
 traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764240601.2373516.14083685662692051175.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:06 +0000
References: <20250910144825.2416019-1-ioana.ciornei@nxp.com>
In-Reply-To: <20250910144825.2416019-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 17:48:25 +0300 you wrote:
> Starting with commit c50e7475961c ("dpaa2-switch: Fix error checking in
> dpaa2_switch_seed_bp()"), the probing of a second DPSW object errors out
> like below.
> 
> fsl_dpaa2_switch dpsw.1: fsl_mc_driver_probe failed: -12
> fsl_dpaa2_switch dpsw.1: probe with driver fsl_dpaa2_switch failed with error -12
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: fix buffer pool seeding for control traffic
    https://git.kernel.org/netdev/net/c/2690cb089502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



