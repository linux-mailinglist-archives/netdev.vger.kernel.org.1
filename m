Return-Path: <netdev+bounces-133638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13099696A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133ED1F23C1C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6D619149F;
	Wed,  9 Oct 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bei0ifpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685B824BD;
	Wed,  9 Oct 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475230; cv=none; b=uctws09CohZYg7rshSrW0Odfl9eYDw+vaHFmtMHyEA7+iMYoxtc9uO7E3CMM89E4ZAvAL8zYtYUsbTPo4IgshCcSca9F4hWHf6Zit718s/zB8GXPM5oZ8cB8UfP9MIcYwMyuzZTsV54TSPi2Wt9uwgAOfWw4zS6IcREgSCTwcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475230; c=relaxed/simple;
	bh=nlYHzGLhj4rclM0KV2hJPZZjHX3Pq+0hLcWIbKNYt6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYRfgGkI/5hrxomgk2xLPqDlkK9Lfbhjz4Rtv9s6gzRr6mZClLa+KdpYPIv93R4UIqFITqJs6y3SsRwywwadC3lWmfbyMIFmvX+huDZGyq3/QvShifRe43rtkUMTC8PTuheyuYaGH5WfRS7hF2HrjkPL7q8gmnqKbDJ9HFPys4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bei0ifpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D449C4CEC5;
	Wed,  9 Oct 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728475230;
	bh=nlYHzGLhj4rclM0KV2hJPZZjHX3Pq+0hLcWIbKNYt6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bei0ifpaz5UyOcpbAoIQ/5jgS9f0bs1bopKr4p9bB1IdH7bpZrJS6rASX/xKCNMxL
	 iGpBFAsQ7jOCV6BL6dHQ6k/jVFdIZ5SRaD8UbdsMcajgdo4Xgb0+oZOSqlfr3Lhg0i
	 VBH0wV4eodrSZbUz6XRsDboDiR2khDtyDlmBAh2C/nwAvSbYuqQlMmcN/euld64eVv
	 iyaHbzgHtliHOg2/1q9mAeg05sQnU1mGicjvbdDgDrRwWDM3F8+sZ+UXSGQMZLVaVo
	 DmMrAYp7UxgR9GrSaNI9MjBcdrQ0V1XwTXgYYSRsOMnxUzB7p7qT+GudXYoGwVL+Xn
	 n2r3Ct1rFgA5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE42E3806644;
	Wed,  9 Oct 2024 12:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] improve multicast join group performance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847523450.1241124.965690201878894665.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 12:00:34 +0000
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, madalin.bucur@nxp.com,
 sean.anderson@seco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 07 Oct 2024 16:17:10 +0200 you wrote:
> This series seeks to improve performance on updating igmp group
> memberships such as with IP_ADD_MEMBERSHIP or MCAST_JOIN_SOURCE_GROUP.
> 
> Our use case was to add 2000 multicast memberships on a TQMLS1046A which
> took about 3.6 seconds for the membership additions alone. Our userspace
> reproducer tool was instrumented to log runtimes of the individual
> setsockopt invocations which clearly indicated quadratic complexity of
> setting up the membership with regard to the total number of multicast
> groups to be joined. We used perf to locate the hotspots and
> subsequently optimized the most costly sections of code.
> 
> [...]

Here is the summary with links:
  - [1/2] net: ipv4: igmp: optimize ____ip_mc_inc_group() using mc_hash
    https://git.kernel.org/netdev/net-next/c/69a3272d787c
  - [2/2] net: dpaa: use __dev_mc_sync in dpaa_set_rx_mode()
    https://git.kernel.org/netdev/net-next/c/298f70b37144

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



