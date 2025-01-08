Return-Path: <netdev+bounces-156116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE00A05056
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AE83A24E3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4315B984;
	Wed,  8 Jan 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtwIqsRC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990781442F2
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302211; cv=none; b=K6tBQJsDeZAwxebZfwe4S6mvoEnqGdqq80yKH+59a79By/yn+vfnBtMO+73OJQPd7SkCsYhXmcWPHtRlRThGoxQKzy3nNeBYsZoIbac/U4bqSAwnBIHsTYeI5DHzTmRzXMSqj+gexQdtMxsm/0YmLe8whgbsmJIw1oI1Uh0L/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302211; c=relaxed/simple;
	bh=oO7p8azLsuW/O7yPbiMgrPDFmOV5QymJC2pscYFARcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d1cJhggTvPPU+LCp3lDq7lkI+iUOBbiTH8pAWv85RjAs3yRpjy8XTdRdkjKrdCkdbod6kNJzWuH2/DpeK7yBIOzCC9+Wwyw5qF49vx7hSrEoowLXfdIwYqrXXmXUL6kQ8gRH+JEKBaN/x/285TB/oBFAF1zn5r6+1DRoVhPoRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtwIqsRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEE2C4CED6;
	Wed,  8 Jan 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302211;
	bh=oO7p8azLsuW/O7yPbiMgrPDFmOV5QymJC2pscYFARcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gtwIqsRCxzMAZJaVI0dxNdNxjK4jNk6KBhGVTZXcgdgD9askABABrRIxpV3CieAai
	 5MWlb+7ttvKWPdm+h+W0u5YTCXv7ltOVzDl+hu7+RMGlNQnTqQbSVE4GpbX7DURmjD
	 QKoea5WZ0VJKMGGChbO/0KsllXyU+EAghcJYWv+LC5aNtOJrMjZfqe60e8ONk5WfIg
	 xhswKtowi+Yay76FeBr9XY9ryyaxdWBgoCDX5oNrvAy3ci6xMtTRCXOI2NHbRJyyeb
	 ESgZyKC42rIUv4IR0HZT6RlOda35EnPCMMNQdxtO/8d4RM2GmPqhg6MJMUXsdG7+CZ
	 mo5nDoEKIewDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDF380A97E;
	Wed,  8 Jan 2025 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] ipvlan: Fix use-after-free in ipvlan_get_iflink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630223252.165659.12682571299886198939.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:10:32 +0000
References: <20250106071911.64355-1-kuniyu@amazon.com>
In-Reply-To: <20250106071911.64355-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vladimir.oltean@nxp.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Jan 2025 16:19:11 +0900 you wrote:
> syzbot presented an use-after-free report [0] regarding ipvlan and
> linkwatch.
> 
> ipvlan does not hold a refcnt of the lower device unlike vlan and
> macvlan.
> 
> If the linkwatch work is triggered for the ipvlan dev, the lower dev
> might have already been freed, resulting in UAF of ipvlan->phy_dev in
> ipvlan_get_iflink().
> 
> [...]

Here is the summary with links:
  - [v3,net] ipvlan: Fix use-after-free in ipvlan_get_iflink().
    https://git.kernel.org/netdev/net/c/cb358ff94154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



