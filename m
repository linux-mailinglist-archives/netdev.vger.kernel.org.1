Return-Path: <netdev+bounces-116944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB3D94C284
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C6B275A2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1318C925;
	Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG2Bue/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AC646;
	Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134037; cv=none; b=rxQx0/oYtJib19wjsBm+s9pnrtBJC8ZY4boOtlbzlpEv4BKZoJsbn0YIpPW191DTUNdEqwebeO4XWsVeFYvMMFsD42/ZElxL8OaGzpiq+JrsAEKol8UTs7UAdrr5Sz6bDexvBpiddabgJep6R0rB6lL8r/id4baZ7FUD/peB2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134037; c=relaxed/simple;
	bh=/F9CzbDaHZlcXmh2nFEN2EBENa7yJncXVXhwq9kWCSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQR/x6ij3i6s2x8w+0ThzWpO8KOOkX7kBtn9+KZv8xAi6XZBEgI86jdMnQr/K6WfkMW2pDgP3Tosl15pVZCU7d6wtfgUrfU17jH8u+RoMC+pt+ryEHeuwwGZIRajuNBhSY8QMdZm+6NQQpYkTDRk3zXlQU0jd9v87tx8anx2X/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG2Bue/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB66C32786;
	Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134037;
	bh=/F9CzbDaHZlcXmh2nFEN2EBENa7yJncXVXhwq9kWCSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EG2Bue/vE/dgXHELWVDPsC/Fh8x0u6VNSoKtRFExlOVYaaMifUFJvfoZtV+8iI3i3
	 3HI2gPNEzEJeTv2W6ghXmYkoOgB+B2oMF0lFaFI8eFPfGXkgkeQfpOP3qLZ1AXPQRK
	 XDtQ1ZBTZcvYn/cUDfTZHX+yDhWUd9mYkFXrYN7K0C3BIdNl5Rv0LpsEC5bdUg10ib
	 YBbH2m4/VVZSVzUP8r7IAVgqf4Qbo4ADiLF9MgNesb5WPFPZyy4GSAfLUAcs4uuh9c
	 4YEb2djkjpsx7IMMe7CNEzLdCpeKRhJJL06Fk+miC5DeSidnt2hEq1A9oUY0YtScxo
	 gJcn8FoixvySA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5F2DF382336A;
	Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmgenet: Properly overlay PHY and MAC
 Wake-on-LAN capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313403624.3227143.18053785706101144239.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:36 +0000
References: <20240806175659.3232204-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240806175659.3232204-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Aug 2024 10:56:59 -0700 you wrote:
> Some Wake-on-LAN modes such as WAKE_FILTER may only be supported by the MAC,
> while others might be only supported by the PHY. Make sure that the .get_wol()
> returns the union of both rather than only that of the PHY if the PHY supports
> Wake-on-LAN.
> 
> Fixes: 7e400ff35cbe ("net: bcmgenet: Add support for PHY-based Wake-on-LAN")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities
    https://git.kernel.org/netdev/net/c/9ee09edc05f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



