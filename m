Return-Path: <netdev+bounces-105853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027F913305
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80552B227A2
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AC14B947;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXWcmaGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2D2904
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719052829; cv=none; b=NXmSV0hf7XWez+0S+ZYuLW3/V1BuGA6GF2Xa8LePCRWs9gHuC4UuyVLQcBRZ6fjdj5lC/AfXIM0lVj0KALxBAPV6BVMdEyccsLYVqae1sz7+cWPxgCIgoneanGOO6gxK4Qi17ZsUbvchvGXSxiYIZQEHeAuyL4Xl75wUYK9+3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719052829; c=relaxed/simple;
	bh=gp3cUv9DgFhaElw6oAzinltHDBuypDebwLk/OoM3aLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gaUHv+ZjY0GxXmfQz3QGBfdd7Pjrft9AtwOAxRA3E50w1kJAZ39LvBT1tcAIAPTM3NZE4ysLLf4jPJ+fBh2JXCX0U86D8m3URmRilN1jzDoqMYtvHAwZaTBhE01ip8vBbo7DLtTSNpDpZKnYNFInXQr/JQPwg1sQWtT+SsotW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXWcmaGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A848C32781;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719052829;
	bh=gp3cUv9DgFhaElw6oAzinltHDBuypDebwLk/OoM3aLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CXWcmaGSW9VVTXOUgHBcM/iHJtt5J0wayYeYJFAAoiV5Pq7zieYqFYlxTMPr9PqAJ
	 Gf4UwqtujF8rozSvmSj737E3gy2qjmGZSxT+6nfdkOwCkwSALRP1uBNoUeijOO1ZCo
	 8J+NfzO1FmsauppaNTR3Kh+72v3MroFUwCEF8nwWvYPJzduC1+fb+SKWk7xPFkhdgd
	 dUCunharUdQC4wWWtqB3NYpievsYmwX/JEpoxVMGpnRh66HbgJ0DJMt7ydK9KsfGrL
	 R2wbTQIlvSGhsVY3rS2xT8Q/WvXmhLrSQcG3+m8LdXWUjmdADs6RaiSu3VisUJBAgF
	 rYd3QKjX93j6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B493CF3B94;
	Sat, 22 Jun 2024 10:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ibmvnic: Fix TX skb leak after device reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171905282910.9713.13757414179135889565.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 10:40:29 +0000
References: <20240620152312.1032323-1-nnac123@linux.ibm.com>
In-Reply-To: <20240620152312.1032323-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, nick.child@ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 10:23:10 -0500 you wrote:
> These 2 patches focus on resolving a possible skb leak after
> a subset of the ibmvnic reset processes.
> 
> Essentially, the driver maintains a free_map which contains indexes to a
> list of tracked skb's addresses on xmit. Due to a mistake during reset,
> the free_map did not accurately map to free indexes in the skb list.
> This resulted in a leak in skb because the index in free_map was blindly
> trusted to contain a NULL pointer. So this patchset addresses 2 issues:
>   1. We shouldn't blindly trust our free_map (lets not do this again)
>   2. We need to ensure that our free_map is accurate in the first place
> 
> [...]

Here is the summary with links:
  - [net,1/2] ibmvnic: Add tx check to prevent skb leak
    (no matching commit)
  - [net,2/2] ibmvnic: Free any outstanding tx skbs during scrq reset
    https://git.kernel.org/netdev/net/c/49bbeb5719c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



