Return-Path: <netdev+bounces-148781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E29E31D8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E50B28A19
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9D136338;
	Wed,  4 Dec 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfJBHUF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B494D9FB
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281816; cv=none; b=txoWySWUiVB9fGn4DmmNPAP8gNK/WMZmWTxQttsoNrJzngDTEOJRyZTsUnzWyI9EYSs57SxYVb2OUCaPDIl6SYvhXnJoGbJVticwGm+SodpnoO4NkqfVY7gYyeh8DLIi+x6Nvfeqo9rn7gDvC+pctRoU0iYfnFsBTllcQ8pWMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281816; c=relaxed/simple;
	bh=3afM9+aFs6LJ3y3z6TW7WaVCtPDdmGA+Yv0U4dzZFLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ip8ZLujb3Z+NfAXWNeEqkKsvc3Zmqm2uHlv4ZApqJTNkQGcx3F1gsX0HXQFz8TmQE+ASI9IPhyIFNR/vzPQq1b7i17KFnhJqgMm8IM8CHkvtSrw/xycaNnpQYvDL9BjdyMgGaheZzknEKYSDFK/HUMJlTfvIq4ILQ9jtOl/1njY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfJBHUF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA78C4CEDC;
	Wed,  4 Dec 2024 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281816;
	bh=3afM9+aFs6LJ3y3z6TW7WaVCtPDdmGA+Yv0U4dzZFLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IfJBHUF7LDK6rmqaqpKEIhUlLgSDkZcdAh5qN1Qs9xC+Q4rSwdBgL1rvskpth2VH+
	 BN22ItPn0hYwOV0ZAAi1FwXDzNieJH9CnZd8CYY8phUqM2PJMFTktZON5Wf2aX+im/
	 08Xaks8KZDrrPZSwEo/ZEtD2AEuzWk5SbEysrTvF34VvULXmyA/N3/0dLLDD0OlJuI
	 ghcliOMBxlldjzWfxc//ILwe24z2VCWHLXkeqe1HkNTRNps9P6meIMKtjZEqYJVbRq
	 7BmmIrS0pZX538Wz0RzQszsIJymVBFofxqtoJ2N4jvsHtL2JiqtMNWAOtnlJ0va5J0
	 2/4JY7Q00/ZYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBCE13806656;
	Wed,  4 Dec 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: Fix access to uninitialized fields in set RXNFC
 command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173328183076.718738.2560916849911480657.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 03:10:30 +0000
References: <20241202164805.1637093-1-gal@nvidia.com>
In-Reply-To: <20241202164805.1637093-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dtatulea@nvidia.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Dec 2024 18:48:05 +0200 you wrote:
> The check for non-zero ring with RSS is only relevant for
> ETHTOOL_SRXCLSRLINS command, in other cases the check tries to access
> memory which was not initialized by the userspace tool. Only perform the
> check in case of ETHTOOL_SRXCLSRLINS.
> 
> Without this patch, filter deletion (for example) could statistically
> result in a false error:
>   # ethtool --config-ntuple eth3 delete 484
>   rmgr: Cannot delete RX class rule: Invalid argument
>   Cannot delete classification rule
> 
> [...]

Here is the summary with links:
  - [net] ethtool: Fix access to uninitialized fields in set RXNFC command
    https://git.kernel.org/netdev/net/c/940719094776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



