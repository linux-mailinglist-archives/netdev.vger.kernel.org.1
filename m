Return-Path: <netdev+bounces-220200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03DB44B93
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2057B609E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550722D795;
	Fri,  5 Sep 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePAOifVC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51818229B02
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038815; cv=none; b=htksdB4wVXa7l/Az+LFBQ95xnv0vQ+UGSpzU4ckx6MQOWYxL8qP7gk4Gn7IltR4CiIBNsJHib/+RWFy+hHPjqDDQJBRyioUHvVx5Attj/H8us4LZDU8FrBl7SS2l4MzJrk4AUIFy3MuVK7eVGl8vDqbEL027nrHxuWezlIZ48mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038815; c=relaxed/simple;
	bh=WoT+wPrEJENFGjSf8LRkJI/w9rPUeA7MSBy6AZU8mww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JPQNK72ZRoRymcnCZKZAm6q3zBj68XMae0JjTTQ/I+qOHMdd3mTopVe9qdEfkpIdF8k3kdb8hQVH4BlW0u0Ey9NvKlIkImZqa+QlecSCfFD6kOto37mMXqt08ro2YzkiFvfSwCIMSnvI2xPhefQpexgaPGD6FdECtimhxH+9AyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePAOifVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5841C4CEF1;
	Fri,  5 Sep 2025 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038814;
	bh=WoT+wPrEJENFGjSf8LRkJI/w9rPUeA7MSBy6AZU8mww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ePAOifVCYFZsfxhcgW0KLZeprrp9KGYDsiAfQJQmVlegNdsIHpat7CeZyHy2sfRy0
	 xkYwfiShnfffnqqYWNka/YrfegL4iRzcYwZ9FMbCp1v6Pe0f/EfNTidoK/tsgWQdug
	 ROkkkim2Z7x6Lcr4BZqxBsCWYSoVFL8+6O+KzwZeM2IpvX46/hrX3LfVHpLw4W9JYo
	 nOFRSmf0nhEDAh1vI9mM+nxEuIwlRhw3aDHI0TiI/UdodwhpPQIqTFhTUjxyiullsy
	 WpkXi3bmAQDcqg09LMqvuzPafK7AfivUhDxLvlU4NOQUGAoFeB4//tgBcm6C8ndA4+
	 fQ4ZZqE4De7dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB24383BF69;
	Fri,  5 Sep 2025 02:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: call cond_resched() less often in
 __release_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175703881937.2010527.11190217854793981593.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 02:20:19 +0000
References: <20250903174811.1930820-1-edumazet@google.com>
In-Reply-To: <20250903174811.1930820-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 17:48:10 +0000 you wrote:
> While stress testing TCP I had unexpected retransmits and sack packets
> when a single cpu receives data from multiple high-throughput flows.
> 
> super_netperf 4 -H srv -T,10 -l 3000 &
> 
> Tcpdump extract:
> 
> [...]

Here is the summary with links:
  - [net-next] net: call cond_resched() less often in __release_sock()
    https://git.kernel.org/netdev/net-next/c/16c610162d1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



