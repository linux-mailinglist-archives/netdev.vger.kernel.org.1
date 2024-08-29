Return-Path: <netdev+bounces-123019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA582963724
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0C283A20
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE02134D1;
	Thu, 29 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGceqzZg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0F208CA;
	Thu, 29 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893233; cv=none; b=mWcc9+wQ/XUff3u1tOkZQR7A0HJehl8OGiRlkuWU2XOh2u879vfwN34FCAq20LJtvFMA34lv312E9Fy4OQwbJKIC/ZfMOiPHGV4sXzFWhji6YKBSEAHa70o06qVdTz75Et8Y0Edpjuf3dcuNj6L7jRZwseMhsJQZ44H3rkaq+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893233; c=relaxed/simple;
	bh=ptj+zSAgS9FcKjJPgajPrPBWlVXa5qCk7dhaNYmPgjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUZduLJTsjrkmLp7cNWxC6huZgfQHOim1fV5BU/OZKlWobVlvm3zQRdXIGxH32tBWx6MkkRX9NbSpsr0sTNvykOTwWoNvti5ijr9nbUwlaIK6kIj/43AkecS1LmtlxRJ/ysNWGPb3FMstzyOrio8VQRXy4TpREUqYV9lgQxDhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGceqzZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE7C4CEC0;
	Thu, 29 Aug 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893232;
	bh=ptj+zSAgS9FcKjJPgajPrPBWlVXa5qCk7dhaNYmPgjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CGceqzZgjkJbgM7NqQUz4JUHX4QadXY119ljwsquJXQ96p684YkrJxgMHh3AQvQz8
	 2ZC/PbXpIMl4F/W4tYSY8QMuYKMuthV3F9PgtumNAJXFWzhc1ozFy/GaDy+/qvH/F8
	 0fPwnONyMvG0EAcLIh5smjZqUerk3tY2UI1VGPopNfGnb7mFQCbmU8Xkm3vfcBwqXR
	 oWCxMKHxrXM9b+HAHSLndQWKnS/13d2G1+CtlvAlQDXZtMXOZU57pyEi0ETG+CQd4a
	 kCi00i3KOZDgklZu8rAJgfKPv+anxvdXFsuLzMKqeIlyrVTwWtn57fI4+9Dd6clL1C
	 xsw+eKhpuoXSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D473809A80;
	Thu, 29 Aug 2024 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: cable-test: Release RTNL when the PHY
 isn't found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489323274.1482642.18086443534337757803.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 01:00:32 +0000
References: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, kabel@kernel.org,
 o.rempel@pengutronix.de, horms@kernel.org, mwojtas@chromium.org,
 dan.carpenter@linaro.org, romain.gantois@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 11:23:13 +0200 you wrote:
> Use the correct logic to check for the presence of a PHY device, and
> jump to a label that correctly releases RTNL in case of an error, as we
> are holding RTNL at that point.
> 
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Closes: https://lore.kernel.org/netdev/20240827104825.5cbe0602@fedora-3.home/T/#m6bc49cdcc5cfab0d162516b92916b944a01c833f
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: cable-test: Release RTNL when the PHY isn't found
    https://git.kernel.org/netdev/net-next/c/ad78337cb20c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



