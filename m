Return-Path: <netdev+bounces-180971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38779A8351D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044348A4F51
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74654D599;
	Thu, 10 Apr 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebmaNGaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C61381A3
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744245597; cv=none; b=u77NdP64RruNTJ4N/0/F3TyiIpwcMdSurLvjIyh7kf7ETnUHU9LOlanijOY3I1UDgGLZiQx9DsJ3hO8ISGi3UZLwpaa5NgK+P7vmM9LqrMdE4uo83QEDmhcq2RF2FxkUertggj0a8yWIwdVJJD5VqSeSODs3BO3OgLbYPzY8AJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744245597; c=relaxed/simple;
	bh=ZIaPaVr3yCGe2ScrihZRTGX11470A1far/aq1foYG+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HWxamzuDdoT7ybs0OHt0PsHQhEldms961PJRuItZlSc//FtMUeVWuvUZ3BD4kFUVdc7X6du/ixD2c6v4D2o0lXJwPMzUEYseGTh0ONTjRYG4V59lxacm85gYbOblSHOmqLsBPBtZ/0uftMrWTJAC9AFBA9inGQlHLPx0TPoWk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebmaNGaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA2BC4CEE2;
	Thu, 10 Apr 2025 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744245597;
	bh=ZIaPaVr3yCGe2ScrihZRTGX11470A1far/aq1foYG+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebmaNGaPFO7FbxHqfwLh/luCP3eV+mUI+WZeF3p2RU8F1ZxaOiSxBolHwXjxcCnLC
	 7PUFg2H8bAFHv/e4qS3MMAxSCZduWMM1dZu+i7ewIbt3hZ0WN+DfpaE/UbFdkKwp5h
	 y35otRQHZ9VBMYhpFeFZjxnECvv/F5NgomfTYw8KO47TDYQRtCuz64Na1unlQC8M3h
	 43LQDEvDBiSdM8P8TxORhQyS0tQnLAuabSqXj3lI7Xr4Q1XDmfeYf95a916memxED9
	 JnUBJytF096fCEknQYxoAHqm+HIbQb8tE76gqJw434H7y8pSXKuPgsFahraqlZzJsd
	 Nvqi+qtRn0azA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00638111E3;
	Thu, 10 Apr 2025 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: depend on instance lock for queue
 related netlink ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424563486.3092405.11629244278236026519.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 00:40:34 +0000
References: <20250408195956.412733-1-kuba@kernel.org>
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 hramamurthy@google.com, kuniyu@amazon.com, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 12:59:47 -0700 you wrote:
> netdev-genl used to be protected by rtnl_lock. In previous release
> we already switched the queue management ops (for Rx zero-copy) to
> the instance lock. This series converts other ops to depend on the
> instance lock when possible.
> 
> Unfortunately queue related state is hard to lock (unlike NAPI)
> as the process of switching the number of queues usually involves
> a large reconfiguration of the driver. The reconfig process has
> historically been under rtnl_lock, but for drivers which opt into
> ops locking it is also under the instance lock. Leverage that
> and conditionally take rtnl_lock or instance lock depending
> on the device capabilities.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: avoid potential race between netdev_get_by_index_lock() and netns switch
    (no matching commit)
  - [net-next,v2,2/8] net: designate XSK pool pointers in queues as "ops protected"
    https://git.kernel.org/netdev/net-next/c/606048cbd834
  - [net-next,v2,3/8] netdev: add "ops compat locking" helpers
    (no matching commit)
  - [net-next,v2,4/8] netdev: don't hold rtnl_lock over nl queue info get when possible
    https://git.kernel.org/netdev/net-next/c/d02e3b388221
  - [net-next,v2,5/8] xdp: double protect netdev->xdp_flags with netdev->lock
    (no matching commit)
  - [net-next,v2,6/8] netdev: depend on netdev->lock for xdp features
    https://git.kernel.org/netdev/net-next/c/99e44f39a8f7
  - [net-next,v2,7/8] docs: netdev: break down the instance locking info per ops struct
    https://git.kernel.org/netdev/net-next/c/87eba404f2e1
  - [net-next,v2,8/8] netdev: depend on netdev->lock for qstats in ops locked drivers
    https://git.kernel.org/netdev/net-next/c/ce7b14947484

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



