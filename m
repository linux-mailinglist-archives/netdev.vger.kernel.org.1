Return-Path: <netdev+bounces-83353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F3892059
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA9D1C29515
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F7535C6;
	Fri, 29 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWpPDjk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815D1C0DE8
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725628; cv=none; b=s33WCZOE/tdKrvjM/7HVRbSs1Dch07Xy1lcUpTf4p2ApcVX3MWbcDG4rksb1jyu4vMZhbV6Qmc0G6/niwK/iwufUsxzc2v467EsmijRpRf+cAgLYTnaCHgjo1LmL5ET+QQUbWx+lYiQZKU7cv8UZQ3lw8SI7sZeJEw3u6yJeV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725628; c=relaxed/simple;
	bh=3WJ0Jm+zv0HMsvjMoM+7DcqguxSI+xOn452kKxraelo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wsro1H42fvQKRzfkYkItPuuSxgqgpi9wDIBZZ/lcKAv4ZQTwnsUUNgYSlgDIp4GvNMp9k/8G2BNq1c7dWmG374XlSj76E0sENaPBlG/Yd+mykHLxk0ip0IZyJx6yZb61FHuHz2m1mrdq46XWyOWaCGW98/6W2nbXLBMRu4+KNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWpPDjk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E011C433C7;
	Fri, 29 Mar 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725628;
	bh=3WJ0Jm+zv0HMsvjMoM+7DcqguxSI+xOn452kKxraelo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OWpPDjk+QIcJNfD2ihTJKn+Dtb7bYyDiGlAZv8l+qN2YVQEdYNlG7wXDUJncoqWR4
	 OOp5MbXCsWskZmM3HS6LqR2dxep+YgK5SaW3yukDl3DB6uOa71TOMPwzAmQWlcKECn
	 HlbBlWovEinLfHPVVV4GRobV+qXlWJRLPWplR3zoKBTUY+ZexydRM2+GMkr//Zrimb
	 CqLbrXehdBSzqU/k/EhpauPWRZz0QlqAXEEhQ0Vt14tPGZoS+AAe1vRKnJwRj/YzrP
	 t5MbrrQflHnUGnVC16XFGGNVKo/PDP8wkU4schtNn2bwpUWK25NOCygjMHInMPvjNn
	 ZFTNFYSJpmzNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50D89D2D0EB;
	Fri, 29 Mar 2024 15:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp/dccp: bypass empty buckets in inet_twsk_purge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171172562832.31693.12167185652020886326.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 15:20:28 +0000
References: <20240327191206.508114-1-edumazet@google.com>
In-Reply-To: <20240327191206.508114-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 19:12:06 +0000 you wrote:
> TCP ehash table is often sparsely populated.
> 
> inet_twsk_purge() spends too much time calling cond_resched().
> 
> This patch can reduce time spent in inet_twsk_purge() by 20x.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp/dccp: bypass empty buckets in inet_twsk_purge()
    https://git.kernel.org/netdev/net-next/c/50e2907ef8bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



