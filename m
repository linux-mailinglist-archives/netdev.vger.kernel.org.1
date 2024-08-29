Return-Path: <netdev+bounces-123003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3ED9636D0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6331C22199
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3135D51E;
	Thu, 29 Aug 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryPdF8+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D71B963;
	Thu, 29 Aug 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890841; cv=none; b=DoIewrs5NlkgZtBy8ey1QL17g/GGzUPa2JbKFMg+GgU+ytPofyElrv6fKqq+PJwwa2mTXcFZUFYbDi+HIFed5ZhJVsnkCrrVRrJCPbWcabLKKU+Inq9LK2dpGReqh/b+Rlhlgr6ApvDcQRYcd4D+VndiX7B5CLgfxsg1mhl61g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890841; c=relaxed/simple;
	bh=8VdaBMWa3uBFRZnze4PidHbF9PUFsKco6n6g9wkDYkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DcuwLgCx43vVVLrcAIxeEmQ00ct58PYgeeiGIvLiPXeD7RgvEzsl3f/HDnA7pzA2wJlq+Jm81d2rNTRAPOxhGWjt17QWbGvijV5dsf9PM6WReAm8soSk4PGpkyqXB6ilW2lpVpcAc19/f1D4hszdI2FzYSXO7R3YBLRhl1ebcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryPdF8+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4329FC4CEC0;
	Thu, 29 Aug 2024 00:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890841;
	bh=8VdaBMWa3uBFRZnze4PidHbF9PUFsKco6n6g9wkDYkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ryPdF8+NShBxnOvVHTr91MzgUhtgzh99WBDA/e4YXlJZSX0EFxXb5jEa8vZ5mf+4K
	 vqC1We/wkfxZ2ycjIku9Kmh2b9A2Oy7sM8GiQBGsAIrEM0iLnHxsHRYZySoChUp0pa
	 EM8MDig7i5oJsqtE+2VyN+gdG72z3wyHD2QcWbhwgd8UOdJQ2NpYew6hWez+hhpBoC
	 XSZKwh1GDvQ0NvGGwN9rQikHxGsm/yVtB8gntRwsREYeIlTehJKosg0ZEIclvQSqO8
	 SV1VdrVq9WwK6gCckbp2LDISVtVoZ/1sbh0EiaLemvL+Rl7A88ZH6oo6ym+5+n/ypC
	 N8CGXFxaYr7fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3D33809A80;
	Thu, 29 Aug 2024 00:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: ftgmac100: Get link speed and duplex for NC-SI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489084124.1473828.17762595427923363228.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 00:20:41 +0000
References: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 11:05:13 +0800 you wrote:
> The ethtool of this driver uses the phy API of ethtool
> to get the link information from PHY driver.
> Because the NC-SI is forced on 100Mbps and full duplex,
> the driver connect a fixed-link phy driver for NC-SI.
> The ethtool will get the link information from the
> fixed-link phy driver.
> 
> [...]

Here is the summary with links:
  - [v3] net: ftgmac100: Get link speed and duplex for NC-SI
    https://git.kernel.org/netdev/net-next/c/e24a6c874601

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



