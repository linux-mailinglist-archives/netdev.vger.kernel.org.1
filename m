Return-Path: <netdev+bounces-132303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD5991304
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FEDB231C1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E4154BE2;
	Fri,  4 Oct 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN7SMprf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694C1547EF;
	Fri,  4 Oct 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084629; cv=none; b=EYahDfGK0kW1KKrvpvfOQdhRQLlBVM6oSr1WJF917x2o9MTm4oZS7kjgGkyVbWhJVRaY/9WJqB068xqidSRzUJ1dig3n/XLJdjIl0py3NY8PUOj3utfyB1/Ee6ylKCD1F1oCFdKHrc22ko/JTwTi7FYPxRW2DnvKj1pIp3eCWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084629; c=relaxed/simple;
	bh=QxilV3vFIpq1GHgcQvTKzlGRakJ71ff10YnPrmwAq28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kuu6uB+dZ2VjbZCI4EAOZAmW/2BbdFUy9YiBPzlhldScDdZYryYUJIhQYACaAMkDsuGIvSTYa8Duzi1Ny66kmNECU1wKIsoaMzpGRmdLtWGtDvy1U7l6JTgO1QT0Khn7D8pto3ru3EEkaqMu20fkjFWMaTlbY7eK4DGWpQLYuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN7SMprf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E526C4CEC6;
	Fri,  4 Oct 2024 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084629;
	bh=QxilV3vFIpq1GHgcQvTKzlGRakJ71ff10YnPrmwAq28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cN7SMprffBrsgv1uOrSkOd7CYPFKtJocwQl9ew6eVRecCppxRkn1qmsKpt62jPN7m
	 xf4TY8Ez0mtarwqS8pBvWKjuU9m7yZngUev3QiGepHEbcUIDvGvBr67a7C0TuvzDZ9
	 l/77qHhLjqX3ADV8cRSzexhPrrMDBc8gyQ96stkuzrNPAL1H0izCySUU9w/sNFVJ3x
	 BF6X3PhxKG6Dq2avxD120PpDgnip04+LUh2L2Z3waW6xkftJw2cvguRz/vzoslSfix
	 P1qduYFKjgJ5izIpm55H6/2jihoXgVzr4jr/mdrrkPNUDAuH7/7jO+C9Z2+7IePIsC
	 NEYTGo2OWJwjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3425639F76FF;
	Fri,  4 Oct 2024 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: bcm84881: Fix some error handling paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808463301.2774988.13283178558641908865.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:30:33 +0000
References: <3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 f.fainelli@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 21:03:21 +0200 you wrote:
> If phy_read_mmd() fails, the error code stored in 'bmsr' should be returned
> instead of 'val' which is likely to be 0.
> 
> Fixes: 75f4d8d10e01 ("net: phy: add Broadcom BCM84881 PHY driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: bcm84881: Fix some error handling paths
    https://git.kernel.org/netdev/net/c/9234a2549cb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



