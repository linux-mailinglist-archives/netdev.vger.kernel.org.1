Return-Path: <netdev+bounces-152023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5359F2645
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C034A164C85
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E915148304;
	Sun, 15 Dec 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEWcjJHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B065A41
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298213; cv=none; b=Ys9d8vOgZP52QOEUQoTsTwwAKY8BuK85/qYHquqHk2xZfu/4nhQSSvQIi3x7ynQzxaDQFRUeQL/Ldnz1N7t2g0wk15hrWHC7kgJ435JuLleX44F9YMRrkCJ0i7h+Xib4ivwMHf2asfr6ces8exA0e75HIyUjIBz2UBTAXYQxhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298213; c=relaxed/simple;
	bh=Tn2ddh0G9p8eeQ5iBhNGRqMT7/F13X2LG9DhDScD6O4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujuiKkFO7s9ndIM0rF/ZyRBfQQ6qsNOXw0HQONwWD31tHhI0M4tY6vIZJ5R8LQlUtgQ/s137Cmu5Y+4WFH0lZT151IJZq7pYLBmfMP4PQj0YBDyAzwkG6Kym+3JPD2WzOQGcHbxqhCLvT2WFHEVFjGlLyY5giZIKOWHnZYpc/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEWcjJHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8080C4CECE;
	Sun, 15 Dec 2024 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734298212;
	bh=Tn2ddh0G9p8eeQ5iBhNGRqMT7/F13X2LG9DhDScD6O4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EEWcjJHGPycqA+8a/ibNwfsdv+SpH6S0WEL2JpGzw1NPQrVZJtivMZq3vvEJTXpxP
	 6lF8J1W8IMMt1jeeBTBqXu1Do/ygY00Y1l905LOUHaR72TNzRCHIxOeTGWD6FE+HGB
	 2wyWLP4Rll+n3I5HufAgbprD0BHtMIe2C1YshjbYZPGwQ50A4DjvtqUfKZ+Ujghsb5
	 wMn8cDpTdckZ0pBZq8INioIODEJdvIBbpz5O30AmVyjW261itsgzR/gpoJNo+2FrlA
	 rO8yfAi7q1paXUaF7LEJajiRSls9In8fpFlTcXpYSYGJfYFJ9GhHOUGQoFoS+Id6/p
	 U60ZCks1zulLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0363806656;
	Sun, 15 Dec 2024 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: prevent bad user input in
 nsim_dev_health_break_write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429822976.3585316.16368354163524889276.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:30:29 +0000
References: <20241213172518.2415666-1-edumazet@google.com>
In-Reply-To: <20241213172518.2415666-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 17:25:18 +0000 you wrote:
> If either a zero count or a large one is provided, kernel can crash.
> 
> Fixes: 82c93a87bf8b ("netdevsim: implement couple of testing devlink health reporters")
> Reported-by: syzbot+ea40e4294e58b0292f74@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/675c6862.050a0220.37aaf.00b1.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: prevent bad user input in nsim_dev_health_break_write()
    https://git.kernel.org/netdev/net/c/ee76746387f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



