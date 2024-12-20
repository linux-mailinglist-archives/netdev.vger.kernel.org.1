Return-Path: <netdev+bounces-153812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DE9F9BF6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E0A7A4B5B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52B2288C3;
	Fri, 20 Dec 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQx2D7yz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A311228381
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730222; cv=none; b=d8GCsYHKm9898+en3to7UpcMnzDqIHA1n+x/9GS47SJ+jCwX2wxxRCkUnFGJjtomtMeLlOJxcadoLctTr7N37PJkfsVa/7Ks5JRFZBz354RZIWFKJKUYmQ1CuhQ3asFuNFO2xJDqE89z5ESh+8VBMc8WuBfSINM7kCGCY5+lbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730222; c=relaxed/simple;
	bh=zJbppH5J1psqlCkCoF8AvKQogQPWC6HpsLNYTBWFUNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dO9oeD6PIoRxWTKBh+mQwZxIG8TiIs9Y4GlAt4E8Oy0UucIroNtmUgb4q/4kM+asSmdPopvse4qyQqEOcRpWfFPI+hX6aI/ItisGWTPaFknQECyDRI4CI2GVcNrJMY7bau71+CZCrtjbMwIud2qVzloqdj+IjMPI/ynOO9uSHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQx2D7yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD89C4CECD;
	Fri, 20 Dec 2024 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734730221;
	bh=zJbppH5J1psqlCkCoF8AvKQogQPWC6HpsLNYTBWFUNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bQx2D7yzkvyf8Jo6vCqa30M5sHf8R/wwquWLf3fNzno2omkyRGT4EUA0hNtMibnIM
	 /GcdNmdNP8/Srp6XH0oFr0WDan65OrCHrR+MzB6NZd99e5TnZ6xG2q3k8UIm077Ww4
	 gzOS1QFqfVLonNp87domnJPuuMC2uDdWltAUpcmkSFks4MpMiQIJqUG4D8VcWFlDmz
	 mYUxj1xcNWMbdown/x/nSEj3ZTnjUSrSgEuBHL/ZNGc7dF9YxzvGhH0bynxBQnzH1A
	 XZPFKZedxny62PFt5phSd9SQiETQCacfl2LnjKDZtCn2vytEyfVQvaHde3+L+JhMIF
	 AJvLAlU0Z9qmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD303806656;
	Fri, 20 Dec 2024 21:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inetpeer: avoid false sharing in
 inet_peer_xrlim_allow()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473023957.3026071.9084710164772069286.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:30:39 +0000
References: <20241219150330.3159027-1-edumazet@google.com>
In-Reply-To: <20241219150330.3159027-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 15:03:30 +0000 you wrote:
> Under DOS, inet_peer_xrlim_allow() might be called millions
> of times per second from different cpus.
> 
> Make sure to write over peer->rate_tokens and peer->rate_last
> only when really needed.
> 
> Note the inherent races of this function are still there,
> we do not care of precise ICMP rate limiting.
> 
> [...]

Here is the summary with links:
  - [net-next] inetpeer: avoid false sharing in inet_peer_xrlim_allow()
    https://git.kernel.org/netdev/net-next/c/05dd04b218f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



