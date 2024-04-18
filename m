Return-Path: <netdev+bounces-88941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B98A90D0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8741C21BFA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65674EB36;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUaiHmXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B53BB3D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=p4whlm9B6h9AeDUU7GbzQ0f5170jCKZHySSWi3yhDvmwX4xZBZFKsSK8p3OcYHa4krnlUAjPXNwdIfGjkCTB3sBp5X12jH4Of3qPiK0rVsC1HD2ZwhTLNGF0y3pIcbF8jbCkQ2EWFiG4mv9O7WzGmfXcarSl5a8eSsuh81l5QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=vS9StlKSKemv/q9AWSfmF4InIFzN4iCo5hyiPL/LrQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bNrUJREZvjQDII6DsQaDaanVXxBceU3fqRF0/F6qQXAnnMn8FEvsnWbyL8jSECFkWjQCU4DN4NDqS+YL2Q4u8Yh8HOK5qlkN8qEftJQEt2ZD9rcYWx0DfM5YbrZcFqJ0/XZxppz07E8yZIklI0h6O7r4tDQVtZeshFGXf071MVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUaiHmXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E26C32786;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=vS9StlKSKemv/q9AWSfmF4InIFzN4iCo5hyiPL/LrQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUaiHmXjl4wxBeY9Q8QSbZj4Pm4duF8fj9CXjWRGFXOIS2ez0Zk5rYAa9Z3T6y0iu
	 97EY0wSGYWnYNH0z2EuF0oJVSTXqohd7h837TonHbymm2iOCVna1x+PRfaIEDeWeRM
	 RKgYy5iErSrFaYhp/vpHxpYh7Kk/XAM8+/lbCYXzRNYzeRCpeyOHvJlmJmeHGirZHm
	 pWZvw9iHf1RRz+S7cOtqXAmJ4TEBta9SPrJBntB3jrxWUIlbxfj1dG3LTBLtcNbUnV
	 Nah5QwMY99hXDgJDimFtWfzku8nrzXTjLsXvBeKepcwtkIiVkbaW7Sc2OA1HQ6RxBd
	 bh5tnD9T7lk6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 145E4C4361A;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netns: no longer hold RTNL in rtnl_net_dumpid()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442807.27861.11161376134912583153.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:28 +0000
References: <20240416140739.967941-1-edumazet@google.com>
In-Reply-To: <20240416140739.967941-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, gnault@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 14:07:39 +0000 you wrote:
> - rtnl_net_dumpid() is already fully RCU protected,
>   RTNL is not needed there.
> 
> - Fix return value at the end of a dump,
>   so that NLMSG_DONE can be appended to current skb,
>   saving one recvmsg() system call.
> 
> [...]

Here is the summary with links:
  - [net-next] netns: no longer hold RTNL in rtnl_net_dumpid()
    https://git.kernel.org/netdev/net-next/c/1514b06aff16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



