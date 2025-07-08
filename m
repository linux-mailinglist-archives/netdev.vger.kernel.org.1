Return-Path: <netdev+bounces-205055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0EFAFCFEA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C447AC1C6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72772E2654;
	Tue,  8 Jul 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkIMF0lX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAF2E0B58;
	Tue,  8 Jul 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990388; cv=none; b=Ns0ENhaue0VyzqIG6f3aQNe9cukwrjokkrAw88E8Fc/CxyJh3QfnKARqykPo4hUXIy4nHRQ64LSAFptbC7p+9MdpVd+wPP9veaJzCQv76WWkjgx6VgNxwCTJ9iKmmhttqz4fvY9H/Oc+Zeza8LSxllQ4K6DATI+x+OvKI5ZV70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990388; c=relaxed/simple;
	bh=ZW6qYS+Al3lRmdQ1niU7FInxgnj6XAnZwHrqWAeO6iM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qnpDBZtxgNYysGfI0+aGzNHKXsH/vns5K0yDWoMliH/SIA7Uh97iTOsJ51ioIYgj+o30ofeh98mlmBRSsRabGSzdmRnEFdp82AQfXQfzop2bLJTB7qAPBFCFqHs3/SICfDVEDZlVz1wf7XR1lLXD/UB4YlQ/HxhD79e5QxndjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkIMF0lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC6C4CEED;
	Tue,  8 Jul 2025 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990388;
	bh=ZW6qYS+Al3lRmdQ1niU7FInxgnj6XAnZwHrqWAeO6iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkIMF0lXUU8ezPYgLNmJOrJWlC9o3VRIw5z6XAkvITcA8Y/fLJW3y/wvD5xHb5NXq
	 H3nhnbzXQWfGJw6wcm4reb5YHnu8EcJqtCzqCHsIWl7MnAelQvCBieOJ9SFHZ3SzNl
	 1x8pPDERkuipE43vZRFNLAuyKJ80kSNb1jdEDngjVjNqAVPdTd1pexGUh4Ec1H3PiI
	 Ml5OmtVsm8AiMKhUa4ikPemOwDke/qKfiV/dfrdGKmsQoEqXhCoIMvGKoV8Ph6t25n
	 8JXEBXNTJY42AxqbFasztHQSxc7oK4sVSo9/KRbFEf2ua74XU3jnHGTHOVqWW6bJZT
	 jGRvfrnt3ee8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F42380DBEE;
	Tue,  8 Jul 2025 16:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] vsock: Fix transport_{h2g,g2h,dgram,local}
 TOCTOU issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199041100.4117860.14540554652345521469.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:00:11 +0000
References: <20250703-vsock-transports-toctou-v4-0-98f0eb530747@rbox.co>
In-Reply-To: <20250703-vsock-transports-toctou-v4-0-98f0eb530747@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stefanha@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Jul 2025 17:18:17 +0200 you wrote:
> transport_{h2g,g2h,dgram,local} may become NULL on vsock_core_unregister().
> Make sure a poorly timed `rmmod transport` won't lead to a NULL/stale
> pointer dereference.
> 
> Note that these oopses are pretty unlikely to happen in the wild. Splats
> were collected after sprinkling kernel with mdelay()s.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
    https://git.kernel.org/netdev/net/c/209fd720838a
  - [net,v4,2/3] vsock: Fix transport_* TOCTOU
    https://git.kernel.org/netdev/net/c/687aa0c5581b
  - [net,v4,3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
    https://git.kernel.org/netdev/net/c/1e7d9df379a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



