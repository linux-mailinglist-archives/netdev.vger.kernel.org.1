Return-Path: <netdev+bounces-183081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD4A8AD23
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC017441F85
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7A1FF5E3;
	Wed, 16 Apr 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSnC9P3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BF1FF1B4;
	Wed, 16 Apr 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765197; cv=none; b=YKZ9yvaRIyqJpMXiIDwr9DVcueJyerXPhcW4HMvlh71V0X69K453Ayhk1dhBDS1Kw3ts+I5/AhCepwdbp6UC2QWJdb6eLsDez32LxgvDrygRECopEpYKoudqBVxMj8MKNBs2IQ9WRtiII/ur8xKAH8nhRni+VkDCpXbfeBInrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765197; c=relaxed/simple;
	bh=151ygcNcMsIrFJplJv9MnBQOAdO53zCmpNtyrWa+quA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQAL67UIcz5MVtWpxnu/BYEFj5tw4SmynUJQxCakZtHxArcWU99/QJA+D1TP612PYxx3oMBGQCiqou8NOpKnRke2DaMGNrsJiP7yp0FzG+G43cN6+YJIs/jL4zru4+yWckGI5Ewce8fgG8FEwzdhdYG9GRNTOnuShKf1bMwy0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSnC9P3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C61C4CEEB;
	Wed, 16 Apr 2025 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744765197;
	bh=151ygcNcMsIrFJplJv9MnBQOAdO53zCmpNtyrWa+quA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSnC9P3Rr+Kfd0txBvFl7NiYvSHdTIhA+belTHNgD0yzB8wKinm0IpPBHyz9SsYye
	 LywxoCGvyO/B6SFafA1vrkCSGzYLIh8jXEbVYI+ViIX3xVMOWTT3/DBI+8sEzZ2gLu
	 cgnr546LFuT4L9q6Baq4iL9oiyQKkggHqwfSP1f3rwe6SYADAiETUfJuNNNloyaub9
	 b6w/V2huI0AhuM+F7ydpNpKa9fRgC40Rh/l7IDt8FUXSqYrtvN5rXbk/bdqks/PbBU
	 3BedhfjgT1beI+lvuWZUD4jYfP5GAHh3i8/KLtJSFSHlJVPFDTqTS1y4VidH5i9oIl
	 0u9XdfeoZhqSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1EE3822D4B;
	Wed, 16 Apr 2025 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174476523524.2834710.11784912594036142552.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 01:00:35 +0000
References: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@nbd.name

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 18:56:01 +0800 you wrote:
> If multicast snooping is enabled, multicast packets may not always end up
> on the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received
> locally, let IFF_ALLMULTI allow all multicast packets to be received.
> 
> OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in relay
> mode it sets the ALLMULTI flag in order to receive all relevant queries on
> the network.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: bridge: locally receive all multicast packets if IFF_ALLMULTI is set
    https://git.kernel.org/netdev/net-next/c/a496d2f0fd61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



