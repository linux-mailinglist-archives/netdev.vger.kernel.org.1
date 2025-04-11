Return-Path: <netdev+bounces-181465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57ECA8517E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E7C3B604E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024627BF7F;
	Fri, 11 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C50kw5k7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216979FE;
	Fri, 11 Apr 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337996; cv=none; b=MCiW6yImMKty7sEiA30tGxNL5IjSPUSBFmacu6M4odjHeNOhcF+KHYx8yixS8GseWFFn4NLMC0vPGzbPwr8tKUYcjNg7Xc7rdgqHvyvX9y6APoNWPjcKrDhXggQvdQoxSc1vfOof5BWuRMGvDcTIKb1UVA6JZCg2uUlLLy+CDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337996; c=relaxed/simple;
	bh=KUwvqFhp8mTd/YitduDkeSaDNuxw+0O2a8gk+MMEFsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OMo0j81o53Xa2aG/rSCN/SddO47XBLQnVnKGQPRfoHl16VbBum56YmGLQLg+gzS4LAD2TRtT/rZ18M4VG1jtWuvGCA6e9BG4uysM+pSAfx3nGwgaU3jfDZM1RqCMWOHr42LR/ISxBFmjFkDa1gaAgAV14oiggUKj29io0ZZmhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C50kw5k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E357C4CEDD;
	Fri, 11 Apr 2025 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337995;
	bh=KUwvqFhp8mTd/YitduDkeSaDNuxw+0O2a8gk+MMEFsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C50kw5k7czirudNsT+k50a43aC9yLL1IXhVw1z57zlEw4P7HgFW7AUglydT1+EH/6
	 1S2c7wy78dXrxYOEkrkbx0ljskOanbaEfX6jTB6o/t2/gWlzZWaO0cq2E7CzIv8DoI
	 cUMlCfYuBRLV8aR7xvGYUFaQx8YmKBFaCam/gXR1/ks3wM8FW43SK6hg86qdVUs3d/
	 7NAEls28S8Rjw9n3XBfGmWwEpw4r7WCZLwp7lgdMAc4Qqwc7h45ffvizF5Hvj2oFyN
	 DJ4TaZe3yWFPHo4L3KbTPjq4P/cfCJrhSO+kAqKq8c+Pc1rRTGGTWv7pgvy/1Ti8Ac
	 LIKeghmg/bfFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED3380CEF4;
	Fri, 11 Apr 2025 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] usbnet: asix AX88772: leave the carrier control to phylink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433803326.3928161.3907087956360057086.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 02:20:33 +0000
References: <m3plhmdfte.fsf_-_@t19.piap.pl>
In-Reply-To: <m3plhmdfte.fsf_-_@t19.piap.pl>
To: =?utf-8?q?Krzysztof_Ha=C5=82asa_=3Ckhalasa=40piap=2Epl=3E?=@codeaurora.org
Cc: o.rempel@pengutronix.de, netdev@vger.kernel.org, oneukum@suse.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, jtornosm@redhat.com, ming.lei@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Apr 2025 13:59:41 +0200 you wrote:
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication. The internal PHY is configured (using EEPROM) in fixed
> 100 Mbps full duplex mode.
> 
> The primary problem appears to be using carrier_netif_{on,off}() while,
> at the same time, delegating carrier management to phylink. Use only the
> latter and remove "manual control" in the asix driver.
> 
> [...]

Here is the summary with links:
  - [v2] usbnet: asix AX88772: leave the carrier control to phylink
    https://git.kernel.org/netdev/net-next/c/4145f00227ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



