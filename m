Return-Path: <netdev+bounces-149331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289E9E52A1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBCA1882D68
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE751DBB24;
	Thu,  5 Dec 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsj+XhHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16691DB956;
	Thu,  5 Dec 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395220; cv=none; b=kOoihhVRYw0S4wySaVnRUNoxxRDc2ljvsY+cMuYB0qnRuo6ekE5c8yZMpFX+JZOe+J2daD1MRaFJ7Pbeh56YIU22bVqbxuj0hvqjk9TNugsWl8MyFr661WgNd+wrkDLLd5/N7mY8cIWkn1gApRiwIpGFdBGJU56HIptY3CEWK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395220; c=relaxed/simple;
	bh=AtET8wqbVxERLuaXn8BUW4u06cm4/lDqVfFPRwxry1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oIg72bCEjRg835j1yA7Uz8L7L2DGB179Yj9njwLvJwLdKKd3ixY03L84dG2p2/3I1Tgj+ws+pC2Ui3TfM3ZDA8HIvB7Zz1MJ5NNEKWKijBhPYq1z1LgkDP2k9biehrj2koE7tcKZUR4/8J886sBOkQ1vMy0sFd9NC8SsjcWNuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsj+XhHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD0C4CED6;
	Thu,  5 Dec 2024 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395218;
	bh=AtET8wqbVxERLuaXn8BUW4u06cm4/lDqVfFPRwxry1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bsj+XhHqOJnNpCR7/wwZc4MS2TxLMUXFn8szjI72GGdD4Jop9nGpZEywjwa6o4h86
	 1nF23aKg/nPSkxESbk4bvAlDB7QIQK79tHp3vei6JqFyZVQLo4D0JeTgaE3jRezY7C
	 vPMYWReNOUF4PXo5BsC5eyCEZLQXzkgKHcFszOR5oOeBr0rkj2ynSwMNIUHf10xroU
	 3NFo2CHdPb/njavp1+NBcx16u3FOIh6bf168wK3f58yzY39qwoAYCrcSL6GAddQeB8
	 t5J97VK59XGSIzTAt83CMFaLMhI2Y/kDok7EmkmPTU0HpMK02hjzu2aXDRQ9d6BuzJ
	 3NJq3p6g4B0Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4A380A94D;
	Thu,  5 Dec 2024 10:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v5 0/4] Mitigate the two-reallocations issue
 for iptunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173339523275.1540596.2078316757203196719.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 10:40:32 +0000
References: <20241203124945.22508-1-justin.iurman@uliege.be>
In-Reply-To: <20241203124945.22508-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Dec 2024 13:49:41 +0100 you wrote:
> RESEND v5:
> - v5 was sent just when net-next closed
> v5:
> - address Paolo's comments
> - s/int dst_dev_overhead()/unsigned int dst_dev_overhead()/
> v4:
> - move static inline function to include/net/dst.h
> v3:
> - fix compilation error in seg6_iptunnel
> v2:
> - add missing "static" keywords in seg6_iptunnel
> - use a static-inline function to return the dev overhead (as suggested
>   by Olek, thanks)
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v5,1/4] include: net: add static inline dst_dev_overhead() to dst.h
    https://git.kernel.org/netdev/net-next/c/0600cf40e9b3
  - [RESEND,net-next,v5,2/4] net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
    https://git.kernel.org/netdev/net-next/c/dce525185bc9
  - [RESEND,net-next,v5,3/4] net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
    https://git.kernel.org/netdev/net-next/c/40475b63761a
  - [RESEND,net-next,v5,4/4] net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
    https://git.kernel.org/netdev/net-next/c/985ec6f5e623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



