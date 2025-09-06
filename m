Return-Path: <netdev+bounces-220526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD4B467AC
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A67C5C2050
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6571991CB;
	Sat,  6 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1tIzxYK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DB19049B;
	Sat,  6 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757120405; cv=none; b=Uav4FSVMgq5B/ruYsIjFOFgrkwJJA46ZQKGJ2BITAGHA0cXFSIzWeg5Etmi46lvMGb/WT5hd+11iT1+CrCDWa+PaBVyu0igTsHG4hjM2JxatpheWpnzKzdc+VEPMO7Ev1B5EF2WS+5vN7yvQ7UGG880gY5A6siQkA3e1Kbci1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757120405; c=relaxed/simple;
	bh=wxL1SbwDEyGwWgb/R0Vpa95jn9vOP6SjwGk+CX8YrQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLx2uVB8o1mCLNo1WL8SWM/3UiJposUGoJ10GDO77dGM2kjjJ+xSjHixwz2RHckfdLJHf0f0T9xztaQmUDkhaXSiDsP+lYpm7UvEqP1gayzRc8YIFfQP3DrctrSXOoh3aXnwYcqRRsDmUygZd3sj0Iq0D10AoTjyPPL5On4MomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1tIzxYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1DFC4CEF1;
	Sat,  6 Sep 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757120403;
	bh=wxL1SbwDEyGwWgb/R0Vpa95jn9vOP6SjwGk+CX8YrQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O1tIzxYKebzvcCzV/DUbLxYpNTwNpbx5DT49Mu1naa5RScokdDxWVe2t9Xy+pEBD5
	 GLnMBUB5NcaqTiMT4ick9fjNHIQE02eoY7W2Lthc8TiNadngthyQ2QvJ67lPDdPiEp
	 exOrqR4R7f7OPFRY3KMpI/zDQaY2jKYODRwPik4aetmQK/bJkYlQj1B3UxV1aaL5XG
	 098UkVvQYEcUo3/OH/AqetG/om1qSJwLilzposAs1uy1exynewtZ+PXRtypZX/NOZ/
	 5sHggw5o/KIWlrOeqGxqbZzQNXbYw+QnCOy8UE0f+UBOlbxDhVnOczHjVCP1Jmo6Qw
	 5/AtZldO+FJzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E49383BF69;
	Sat,  6 Sep 2025 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 1/2] net: phylink: add lock for serializing
 concurrent
 pl->phydev writes with resolver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712040831.2733722.5895135773021312161.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 01:00:08 +0000
References: <20250904125238.193990-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250904125238.193990-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Sep 2025 15:52:37 +0300 you wrote:
> Currently phylink_resolve() protects itself against concurrent
> phylink_bringup_phy() or phylink_disconnect_phy() calls which modify
> pl->phydev by relying on pl->state_mutex.
> 
> The problem is that in phylink_resolve(), pl->state_mutex is in a lock
> inversion state with pl->phydev->lock. So pl->phydev->lock needs to be
> acquired prior to pl->state_mutex. But that requires dereferencing
> pl->phydev in the first place, and without pl->state_mutex, that is
> racy.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] net: phylink: add lock for serializing concurrent pl->phydev writes with resolver
    https://git.kernel.org/netdev/net/c/0ba5b2f2c381
  - [v3,net,2/2] net: phy: transfer phy_config_inband() locking responsibility to phylink
    https://git.kernel.org/netdev/net/c/e2a10daba849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



