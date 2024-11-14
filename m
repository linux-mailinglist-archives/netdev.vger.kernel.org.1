Return-Path: <netdev+bounces-144671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419E9C8157
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2C4B24928
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3651CCEE0;
	Thu, 14 Nov 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPAaVjJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682982E634
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553819; cv=none; b=aLasQb5mmiCJfuTZOWCw/iVM+qGp7PLafXotT1N//kk7SM7R+2iXb4OiPTXcdY1NW556K6w7wmRDmJYPo936vQnl763isQUAUju0BWtZ0x6UoDwuybvpZk8JljlMzzS5Pbr5uolnx7w02WKo6U5ubdTE7tes1Ee+/sV48YbE2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553819; c=relaxed/simple;
	bh=Naw/2iMvIsKYhVEY8NtnnYLnLQKzbYI2YxAKc1ylb7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P2S3lj1o7jdU9fHn124GN6+N+rdghuzZ9bzxoaavY2XUzEbwJo2G9u+Qvwaa08B37qlmeIaly1eOdTa9pHwQHUpDUZMFJNRY4lOIbKvD+3k1ZpLHylyzCuoxLHdFnHXPcOJRfNQHVNKBVI3fFsEQ/7z3WQgh/OqJ1HSxYmn2hko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPAaVjJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0691DC4CEC3;
	Thu, 14 Nov 2024 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553819;
	bh=Naw/2iMvIsKYhVEY8NtnnYLnLQKzbYI2YxAKc1ylb7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jPAaVjJEr+wZAiK5Yo4EZ+VST4Th1E1VtJLxuprp6PGsqW3i4i9eX9H4IZgsQZRoJ
	 /MLGYboBBZJNgo8WVMqwKpNee6C1pR7ptSRoMy6hEWW9nA9Rl+ID7879V4is6liADz
	 89w8ge0K+FRX7wbSKu4+cl+P6208TF3wJO5Bs70F2rTP6hfrV7OzGVoPwBrU/7EC5U
	 7MZnE7tUkohEwK0x+EqrFIBu6OdGRno85x+EfgLL4NVbcUnctfKwbafBYc7zk4l/LD
	 IA6QPBsM6BOMG4jQz0fasS8fYWNqr9NKumyLKk89BUK/f7VNc5BP3LtsxFc29+gbrP
	 U2kbb3IM+PePA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD503809A80;
	Thu, 14 Nov 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: ensure PHY momentary link-fails are handled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155382952.1467456.818025393378907444.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:10:29 +0000
References: <E1tAtcW-002RBS-LB@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tAtcW-002RBS-LB@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, florian.fainelli@broadcom.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 16:20:00 +0000 you wrote:
> Normally, phylib won't notify changes in quick succession. However, as
> a result of commit 3e43b903da04 ("net: phy: Immediately call
> adjust_link if only tx_lpi_enabled changes") this is no longer true -
> it is now possible that phy_link_down() and phy_link_up() will both
> complete before phylink's resolver has run, which means it'll miss that
> pl->phy_state.link momentarily became false.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: ensure PHY momentary link-fails are handled
    https://git.kernel.org/netdev/net/c/671154f174e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



