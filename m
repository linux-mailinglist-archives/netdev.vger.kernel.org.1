Return-Path: <netdev+bounces-71344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A18853080
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA05284F0F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC824A1F;
	Tue, 13 Feb 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7R1cREc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEB249E6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827426; cv=none; b=MeqXsWaSzcr2p2tGNb/6sUjd/Jfw3NRP7MeyRlpxuibYh6kk3YU/ygI23Gp9FzNmpKhOXunIcmUKSJhYF31lyCHBnRdFgSzVEMZ/C+vhj8fy/fvQAFLF9QnBvD5ipcUVIORaRAGvZOv9BId/2sPHm0fL8mmx00M0AC14twcUbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827426; c=relaxed/simple;
	bh=8eN9avbg5e/PejCsZBqdLwmPibNjQ2LcQxqEl0lGJPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLoEFR69BExn0uaMxWRJr9Ef5+6ZCwZ4nVo1cg2Dz2luK3yJUlCtsxbvVe0BMvf3pjiQZNjKksjxEcjoKM+vynVfI1Ke/0vp4KzaDDrBiayPINnGA68GLkHCULl8pHfht3QWCXSftcju2BfkO6dupX2s9n3NWatdZWHOvP5HAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7R1cREc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E2BCC43394;
	Tue, 13 Feb 2024 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707827426;
	bh=8eN9avbg5e/PejCsZBqdLwmPibNjQ2LcQxqEl0lGJPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b7R1cREcPSF1M6fO+CFcp8HhMRMhBScAEKMHlySvh8QTq0z0Wqy3z9xA86HAbwFrA
	 7GdLOy6RSBiHbrqi4TY3bpFgXxP3NSIqro1kKh6ZUr8c9VWVnnXaofIdpi7eMNcTdD
	 /dvslFhWoE0ljfJX2JgvBsrZNdg+zvgHRHS2/mqH9iCoc9H7vBJF+BxTfHr1J+HEzg
	 JgTydixZd47gdQWYJV44fRSeIdWrHm6gmS+BEwTu+Tv7pDKgocsR4QFeRCsnTZLAls
	 SLndekLZ3KKWUBeJbe7GNAFvre2JhKV58zjkX+l+AHWkbjjezUPBiJn5Z8Kr650YzB
	 XVmP08KGuKpeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37808D84BC6;
	Tue, 13 Feb 2024 12:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: simplify code by using core-provided pcpu
 stats allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170782742622.4191.1918737884186556287.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 12:30:26 +0000
References: <03f5bb3b-d7f4-48be-ae8a-54862ec4566c@gmail.com>
In-Reply-To: <03f5bb3b-d7f4-48be-ae8a-54862ec4566c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 10 Feb 2024 17:58:29 +0100 you wrote:
> Use core-provided pcpu stats allocation instead of open-coding it in
> the driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] r8169: simplify code by using core-provided pcpu stats allocation
    https://git.kernel.org/netdev/net-next/c/400909df6e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



