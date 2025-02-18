Return-Path: <netdev+bounces-167314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7DFA39BC2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278D116AE95
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E82417C0;
	Tue, 18 Feb 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW6dhpnR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68122CBD0
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880602; cv=none; b=sej7WFqJY86v1YEuc01J0MIYZ3aozjmG9EQ6NpXW1Ew4FyYnAwKsSjPuPQTtBgWHAZaag/eo4hNRvMaVVPhHJu4536vCr0v0PO7TBdTjUbr0V0BsShAs6QSLELkUBt1NQ2RHU44qx6JtOR4ggB9DI+bugtQgyzqDTJyMpnP/frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880602; c=relaxed/simple;
	bh=GOG0Y9iNdvX+SK3iAOQfVNrqzyQKIn3saFzElOzUrVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lUt2sMkopWHuO9yqfYllGYkJkFfSr2wk0tKjjvopssBKoEoTHI8WNupnDjimp6pZYr8e4TSR3reotaHwe3RyP7nDKtP4x+Qs3Jmt3eLMA8kAozHHfHCy9s9ulOxUBRjV1YzmOqaIKANPX7tpuYi9Ee1bKkTS2ITpQIxTTiptI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW6dhpnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B2FC4CEE2;
	Tue, 18 Feb 2025 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739880602;
	bh=GOG0Y9iNdvX+SK3iAOQfVNrqzyQKIn3saFzElOzUrVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gW6dhpnRPPmpQZfU/W90mW5ekW9T6Us/yAvvx8GXNAceuWR4T7HRtIvB88DzFKo1i
	 aRnuYROlfHFtlgNORk07DTovTjUR7Xg6lw7qK4HgpSB3mcl6TRhnvm0kQpiqe7L+mi
	 M6xitHJNzu157FA3fgZtIfho9S/AhwKkYzKuI7TEAFN11IMyRXiEDOraPs4QTG1m6C
	 IQl0SMlvyQlVKxU2THXDmr52iBojpevawwYmm4Sgg103H+HmTqmfNozKCaAKWvtKn3
	 juNH4c4D2fzUOT5xJ00Nk25yteDWa+saES7XZC5mXs3lOkaT8JwQO62zjBV2BtLMGw
	 qLRnUaWpGGnxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF45380AA7E;
	Tue, 18 Feb 2025 12:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] vxlan: Join / leave MC group when
 reconfigured
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173988063254.4063928.14621964134002219718.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 12:10:32 +0000
References: <cover.1739548836.git.petrm@nvidia.com>
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com, andrew+netdev@lunn.ch,
 razor@blackwall.org, roopa@nvidia.com, menglong8.dong@gmail.com,
 gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Feb 2025 17:18:19 +0100 you wrote:
> When a vxlan netdevice is brought up, if its default remote is a multicast
> address, the device joins the indicated group.
> 
> Therefore when the multicast remote address changes, the device should
> leave the current group and subscribe to the new one. Similarly when the
> interface used for endpoint communication is changed in a situation when
> multicast remote is configured. This is currently not done.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] vxlan: Drop 'changelink' parameter from vxlan_dev_configure()
    https://git.kernel.org/netdev/net-next/c/5afb1596b90c
  - [net-next,v2,2/5] vxlan: Join / leave MC group after remote changes
    https://git.kernel.org/netdev/net-next/c/d42d54336834
  - [net-next,v2,3/5] selftests: forwarding: lib: Move require_command to net, generalize
    https://git.kernel.org/netdev/net-next/c/f802f172d78b
  - [net-next,v2,4/5] selftests: test_vxlan_fdb_changelink: Convert to lib.sh
    https://git.kernel.org/netdev/net-next/c/24adf47ea9ac
  - [net-next,v2,5/5] selftests: test_vxlan_fdb_changelink: Add a test for MC remote change
    https://git.kernel.org/netdev/net-next/c/eae1e92a1d41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



