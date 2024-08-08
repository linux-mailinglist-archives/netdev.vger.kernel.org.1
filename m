Return-Path: <netdev+bounces-116671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9294B577
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78E21C21441
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91D10A1E;
	Thu,  8 Aug 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZn+ggdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9292E567
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087831; cv=none; b=JKmkplPNq6cwhbroqk4BESWv1mh8JHMOU+HuegDWznCuKOI9fM05YYMC3+s4pZjf9B2+gj4Am1gZc0m3ortINYLv0tNfukfDn5B2I/BQ7ZOVdU+9ps8BIkLZq67+w1Y2TSv+jhp2odxJZvXvBDW/0IkFY+cWeQW42Fv1rxQ8e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087831; c=relaxed/simple;
	bh=0YbwGfnI8UGqDLJJrUdJWYGQB7VqfB7LlUifIbcbIkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LLzQfzWS2tvj9tilwFdk6gdZb5Z8vhN/nqsdKEcDFr0PtijafCB8M9/0QXxcIh9qpN8HiulhioSC5lqAEHAReACvFDbw/xwV5MzN4zM9mXgxKVqrkVAYIPfHxxbStUciYCkCyEvBmwQGiAObazCcgFrQQ38oiZNGmnjsGKUNUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZn+ggdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A019EC32781;
	Thu,  8 Aug 2024 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087831;
	bh=0YbwGfnI8UGqDLJJrUdJWYGQB7VqfB7LlUifIbcbIkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZn+ggdHZrxKoHhLNf8EeyGRRF1pxCG1DmAgPLzsUDXj62iO+ygrFnptcSfSFlRP1
	 dQ9RrxxwnyMhol/8c7HghgEw9i8kMmsT6o3uncHN8NcTC7JEDA1W5dqU6Csog0+kCd
	 iqRt6KSvvfiU28LSF6BCmmjhbH98st06UHYu2P3X7ogF6++zOGoI3AI+rnP2OdKUUT
	 1ValxLFMtV9iGxE14F2TAw9U7JCvdy4Xuv0FiWpWSa11+td1ODxQLtN8LECSnT39zn
	 +BGcEBIWGdyoas6W0q7IYsH53d6ZOlPKEmdY4k0DBV7GFUPRF+tdAyeWNKLPs1Q9Fv
	 HpkMWgpKKWKkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF03822D3B;
	Thu,  8 Aug 2024 03:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: bcm_sf2: Fix a possible memory leak in
 bcm_sf2_mdio_register()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308783051.2759733.17175721563938757744.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:30 +0000
References: <20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: f.fainelli@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Aug 2024 10:13:27 +0900 you wrote:
> bcm_sf2_mdio_register() calls of_phy_find_device() and then
> phy_device_remove() in a loop to remove existing PHY devices.
> of_phy_find_device() eventually calls bus_find_device(), which calls
> get_device() on the returned struct device * to increment the refcount.
> The current implementation does not decrement the refcount, which causes
> memory leak.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()
    https://git.kernel.org/netdev/net/c/e3862093ee93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



