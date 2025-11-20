Return-Path: <netdev+bounces-240297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC603C72337
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E97E350486
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5B2D480E;
	Thu, 20 Nov 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfM2aZVS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC32C0F92;
	Thu, 20 Nov 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613665; cv=none; b=OFw0jjCuRkUDvQrN5J3XVNxxzWErF5l/Pm+t4eNzDAwf5oRA9i/n8mlYKweFRQOuA9SnX068/esLUHCGiAv4Qiu+2i2dO+CCfQSPU3LVquURlWQCckrqlV+af1BX6qKAcIP7Uniotpcvwb/VC15VdoAcmjcTHOQyyRAXrSr9PjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613665; c=relaxed/simple;
	bh=gFCJmP8j0fkIxZtuIICHxxUtvFKAcgeXIJWG60bXrt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V1sWpUwgWS0ntMYV9fjBBLfakhYJY7VMsURVGbiMw2cBt/rnHvkqD8mzm6csdU8sXQQTiVaWTR+C5YjSaaPsfXT9M0LNUUpFn5CRGoU82aYE0VHmQ3be8wyVQMmXJcerAg47XuLPyjJt/tVPeKAQY2DdaVN5hlsnJwDGmpLgRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfM2aZVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7BCC113D0;
	Thu, 20 Nov 2025 04:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763613664;
	bh=gFCJmP8j0fkIxZtuIICHxxUtvFKAcgeXIJWG60bXrt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TfM2aZVS+HdoyCZqDkxDk9B3JDBs0I89FD8agA+GREsiT18IzDAwjn+LkW4+tQN9L
	 wZhP0X35yo/t66fsRdaN/sVWJiOELLvLFPFtVf6HOyeHyVEUPhdmgTHPAgAnqnWRy6
	 ZGERPhXsgYS4Z7MxTme3qVio5MgOr7kCKIG4tmYWZCKSi0Ufk+dtjuePQWSxG4GfSM
	 94eb68DboRCx0HyT1grRrICSMOyHIK+PIZHDvIpCEiFY+Q7OL954SUowO1pk6GzsOy
	 MyXAn5pGnr3XNH8Dwyg3E9d7PVN2VLUo/jhKc3YMEk797ymP2HDCpPnNxAUQvqTY35
	 NnelgAU5NMPYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCC39EF978;
	Thu, 20 Nov 2025 04:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net/mlx5: Move notifiers outside the devlink
 lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361362999.1080161.9061405777910761241.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:40:29 +0000
References: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com, jiri@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Nov 2025 22:45:34 +0200 you wrote:
> Hi,
> 
> This series by Cosmin moves blocking notifier registration in the mlx5
> driver outside the devlink lock during probe.
> 
> This is mostly a no-op refactoring that consists of multiple pieces.
> It is necessary because upcoming code will introduce a potential locking
> cycle between the devlink lock and the blocking notifier head mutexes,
> so these notifiers must move out of the devlink-locked critical section.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net/mlx5: Initialize events outside devlink lock
    https://git.kernel.org/netdev/net-next/c/b6b03097f982
  - [net-next,2/6] net/mlx5: Move the esw mode notifier chain outside the devlink lock
    https://git.kernel.org/netdev/net-next/c/3fee828789b1
  - [net-next,3/6] net/mlx5: Move the vhca event notifier outside of the devlink lock
    https://git.kernel.org/netdev/net-next/c/d3a356db853b
  - [net-next,4/6] net/mlx5: Move the SF HW table notifier outside the devlink lock
    https://git.kernel.org/netdev/net-next/c/e63c9c5f0a48
  - [net-next,5/6] net/mlx5: Move the SF table notifiers outside the devlink lock
    https://git.kernel.org/netdev/net-next/c/d4a0acbd94c2
  - [net-next,6/6] net/mlx5: Move SF dev table notifier registration outside the PF devlink lock
    https://git.kernel.org/netdev/net-next/c/64ad6470c882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



