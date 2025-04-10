Return-Path: <netdev+bounces-180980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9DA83578
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BE63B9BB9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37214F9D6;
	Thu, 10 Apr 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1jZ0/N8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A816C13B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247395; cv=none; b=tiWdnzSh/JNwZGIQ8IcqVlpP6R1jKidRzCUAnJc/esCUxtK6LCKuCyS7o1415kIDHmzOBjtBfyrz1ZIN8YHKni1g4Ay0i87jzz01Qx4p2Ar15/eVboYl1fFER+fkZiBWW04osv1+drocN/GbRSZD2jaMqEXGEKfJAlAABT6tNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247395; c=relaxed/simple;
	bh=u326eUHaLOH5CMiiKtfTUoGeyV5XdzCJN1M1Ac7WM9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgHXbkl9lvPk8GOox5Zxm2kQ7c71Y58hLrCH16uxJeYIPPPpHXylD8v6+JBKVjVUmVObK6B5yqHd7nIMBeNWxCtPfYYbRUym88/0w2rA7qoBHGKwAi9FLNa9ve08U35v2u9+SpleQRxm49EYmytFmhxKGp6gdP7ja/gh/svQR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1jZ0/N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB2C4CEE2;
	Thu, 10 Apr 2025 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744247394;
	bh=u326eUHaLOH5CMiiKtfTUoGeyV5XdzCJN1M1Ac7WM9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b1jZ0/N8JKMg8ZeSJnqnj90fC2b97jeGOSDXbbh/5foBEgosGDw/qAn9Kam7nObOj
	 jbDruv2zv36w4Zst7DO3cG7xNM73FYHS9IOABCS/X+OWUV42ZNlyNAMd0xV0mvkMfP
	 TYFw7loKOErSLlTKgqfQYqdv89Pa+VZgNnvQeqlCUS04cwe+Qa/I1LcLv6J/cTrUoh
	 28/e9pvsfbJJwreu06ITAlJRprtBo8hS91dtWqmslcA7czAv+ldlPyxMY2KKAhR0Se
	 8T7maSivXuVnm4RDsv95UkrOng/ww4TUyfYLfdIU4Ufp5axKkifJfNSe3N8Avyde6B
	 0PA2sxv3zk0ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7159938111DC;
	Thu, 10 Apr 2025 01:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 1/2] net: phy: move phy_link_change() prior to
 mdio_bus_phy_may_suspend()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424743226.3099560.4640184487712612410.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:10:32 +0000
References: <20250407093900.2155112-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250407093900.2155112-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 wei.fang@nxp.com, rmk+kernel@armlinux.org.uk

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Apr 2025 12:38:59 +0300 you wrote:
> In an upcoming change, mdio_bus_phy_may_suspend() will need to
> distinguish a phylib-based PHY client from a phylink PHY client.
> For that, it will need to compare the phydev->phy_link_change() function
> pointer with the eponymous phy_link_change() provided by phylib.
> 
> To avoid forward function declarations, the default PHY link state
> change method should be moved upwards. There is no functional change
> associated with this patch, it is only to reduce the noise from a real
> bug fix.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
    https://git.kernel.org/netdev/net/c/f40a673d6b4a
  - [v3,net,2/2] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
    https://git.kernel.org/netdev/net/c/fc75ea20ffb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



