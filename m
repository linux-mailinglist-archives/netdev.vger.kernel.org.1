Return-Path: <netdev+bounces-135991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AA99FE7A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3905A28516D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180F1442F6;
	Wed, 16 Oct 2024 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/m+Wkg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CA13C807;
	Wed, 16 Oct 2024 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043425; cv=none; b=lci1IKzggD8osdLR7TWYj2os5sD4aA7jtxOdGZZUfu6MU6/Bl5osVJsLp8K6RdG3nCPnmKfTFMxT0ORq2194L2ViHJLAPecejAYpwCmCIf3Z+M2w7MkGSSY8nVLM1+zX1eQBMH4HuAUyHmw5gpPv9rQylqAkdiIHUxrtt0Ml1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043425; c=relaxed/simple;
	bh=8UA0Tl0wQhdOswULPln9SUBmj/N5QXE6fzUmbSJduVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=msYKLU1bFYmLnCSiJAE8aSVnh8XRTWaTMLJGFfJXANMDHJGdWvCn9nssT+IqWGgxvTBQw75QBNE5OJzVxmJAE58/zVrsNHmxiIyAB7N9sWtdBDWUrrSLaVF+A04u2qZzHXCGssKwqL4s3dFdTVIpsi+1wCT9vxxqkUEMiswT3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/m+Wkg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D1C4CEC6;
	Wed, 16 Oct 2024 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729043424;
	bh=8UA0Tl0wQhdOswULPln9SUBmj/N5QXE6fzUmbSJduVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/m+Wkg0KlmbIYmXgFzBshJLXnaqg1DwTqrCqyVVGi9mYV3W6Ueai2hoHLfH1zhG9
	 17XXwNCeImZD4Ma//cA+fV3PpubGA4gMw7WkH96F42hnH+DPoaSzDYfUrI/nIj/HQ0
	 O/3K5kC9DzFFVtamv+BtdqepjAiypmB1ItY1oYDiu9onQuvL5bSh+9Tl2vSsV6lIS3
	 kGerEWQLNF/wkMsNFKcU3UqSUs1z8clrmuSU7YG3gw0uIm9fmTd1sw0ahThgiRUsmg
	 s75xqZsKkWXY9SnsQd5BMDgpLZ6nxR/WTo8CedR4UI+9HwoglB01pF+paCrUccsM8g
	 CfyK/g3P6GDew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341A13809A8A;
	Wed, 16 Oct 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: vsc73xx: fix reception from VLAN-unaware
 bridges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904343002.1354363.8682202935797978740.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:50:30 +0000
References: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 paweldembicki@gmail.com, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 18:30:41 +0300 you wrote:
> Similar to the situation described for sja1105 in commit 1f9fc48fd302
> ("net: dsa: sja1105: fix reception from VLAN-unaware bridges"), the
> vsc73xx driver uses tag_8021q and doesn't need the ds->untag_bridge_pvid
> request. In fact, this option breaks packet reception.
> 
> The ds->untag_bridge_pvid option strips VLANs from packets received on
> VLAN-unaware bridge ports. But those VLANs should already be stripped
> by tag_vsc73xx_8021q.c as part of vsc73xx_rcv() - they are not VLANs in
> VLAN-unaware mode, but DSA tags. Thus, dsa_software_vlan_untag() tries
> to untag a VLAN that doesn't exist, corrupting the packet.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: vsc73xx: fix reception from VLAN-unaware bridges
    https://git.kernel.org/netdev/net/c/11d06f0aaef8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



