Return-Path: <netdev+bounces-143180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE29C159C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562C61C227B5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE21C7B8F;
	Fri,  8 Nov 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGTBm8sD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F81C6F4E
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041425; cv=none; b=AbIyvJvvSAwSi6NiQCJ/kfEP1Q9WGX+oBzG7FUA51e+Q6TPQnG4KzFr0PhyHZqglrJBmpCx/K7qky7chzno6Wz0zPGNWzxz35xmNEFIXlLbR90iPuSOqfbwhudrPp1nZ6I2K7y2Z1Ny2CB+JNFchav/CeCvR1wfdgjhTl3fHDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041425; c=relaxed/simple;
	bh=mXp2ZJ+vBfeKTYaV5/I9wBge8A5KYxES48n69cOAb8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHaErluHwFACvZv/3vwH6wgKzN9TxplBqzJT3d/1+/xywM/e8lsWv8DzLDH387kbMX54YFuHMbRo9UlVXC5d/qomQRxFaY0WwlIf6oAPXKVkYfzqPrIZWRevy1SviZ02ScZ4r89eJn903q2NnDYkpAyXsC9gZtNLXKk96+PLoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGTBm8sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775FC4CECE;
	Fri,  8 Nov 2024 04:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731041424;
	bh=mXp2ZJ+vBfeKTYaV5/I9wBge8A5KYxES48n69cOAb8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rGTBm8sDdzVEq5ByeuOPnrNOOkh5l3YC+2BIUybFjsqUWsTUwVfKz/31QrtZ5gRK4
	 ck051HJduZv5zdbe1oBca3rhPFhRyf1oZsUdU1i7l6ZE9PyQziFM5m+XSyve7zanDE
	 Fexgzj2DD+p2pXXgBQZqRJpLIv1Z0GhHWnxwO3+rApmL2i7aXFLYXvvjJrwb7EPjp/
	 cheijUkdqlI9crheY0pPwflav+RO7wW3RAex1RkDJp2HMsG4XDj9FhZgQZJQr1wccY
	 6Mfeh0Jpk5fkON8KtOM4Nbi6797PPzLEPX11EeHytrVxvIhe0Jdq3MYpLoEFzWeuwM
	 P/kKWIzsnoNaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF633809A80;
	Fri,  8 Nov 2024 04:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] phonet: do not call synchronize_rcu() from
 phonet_route_del()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173104143374.2196790.15910658703147293811.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 04:50:33 +0000
References: <20241106131818.1240710-1-edumazet@google.com>
In-Reply-To: <20241106131818.1240710-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com, courmisch@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 13:18:17 +0000 you wrote:
> Calling synchronize_rcu() while holding rcu_read_lock() is not
> permitted [1]
> 
> Move the synchronize_rcu() + dev_put() to route_doit().
> 
> Alternative would be to not use rcu_read_lock() in route_doit().
> 
> [...]

Here is the summary with links:
  - [v3,net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
    https://git.kernel.org/netdev/net-next/c/38a1f50a5efb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



