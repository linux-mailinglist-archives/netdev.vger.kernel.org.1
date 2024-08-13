Return-Path: <netdev+bounces-117955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0269500FC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1433A1F2448C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52617B433;
	Tue, 13 Aug 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+1GXUI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D72170A23;
	Tue, 13 Aug 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540230; cv=none; b=cqP8VO17WVHxMwn77NGQMufzDFLdxRTHZvqwkcdix5+zt8AxXyxeQmDG6LFaeLtn/18Mv4wxpSyh3r7Aq3S+/EIyPib8P/ecY262Wb4+eZtJwKn4U31e57dSXkmoYGdyusWuW5A8NjqsKdJ4/zmkxCujLtSYUfWYOWWfwtJxkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540230; c=relaxed/simple;
	bh=Y1SIgINTrTHIVInj/merXo1kDYJYD/K0XNoQLf67BEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cijM3QnsEXcZjnQpydlDVSTL3a9qaHXr/J/NMObdDUoizOOZY6hGxXewckjcgs3VR9JRyPgzOOEcUOuG9v7uuN5cVmCV8MZ1FRvdPqs8AykfKJFw/bNZoy8nxvEw7E9Dnr7vkdn82FLf7xwSLS4Gc3Bc8ngLFs6coJZANxggR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+1GXUI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB74C4AF0B;
	Tue, 13 Aug 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723540230;
	bh=Y1SIgINTrTHIVInj/merXo1kDYJYD/K0XNoQLf67BEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+1GXUI2o56jBAeIaIEJBhF0h6qJpoHY+5t+IndijnMbbpy3IlowtV3rlgJB/oUar
	 +Pa8WMeVNbuxeBmo1pm+7tGqXjmWcVp8COERtQNqGA2wC2+Dl35MDg9H+9kLdXUSLb
	 hqpRkfPbfbLarP0jbNwUBTYrsjF3m+6HHffAbeE3/zzTt1GHiM4vvXYLPOGsXDpJ1M
	 tXPokgWJOFv/pocbnSp7oklXu/gcRLr9yFy/xfla5KR2lwdtBGPjkCr2BGGIRSbJpF
	 hbaMRmU4A3OhGIjePUnYtPS8Bke8tu1eAa+nqsR3xqBYVolNPmJFHepAldZF9gTkF3
	 OaUBRIAKkzz0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710223823327;
	Tue, 13 Aug 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: netconsole: Fix netconsole unsafe
 locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172354022928.1567029.9865389373252064352.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 09:10:29 +0000
References: <20240808122518.498166-1-leitao@debian.org>
In-Reply-To: <20240808122518.498166-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, riel@surriel.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulmck@kernel.org, davej@codemonkey.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Aug 2024 05:25:06 -0700 you wrote:
> Problem:
> =======
> 
> The current locking mechanism in netconsole is unsafe and suboptimal due
> to the following issues:
> 
> 1) Lock Release and Reacquisition Mid-Loop:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: netpoll: extract core of netpoll_cleanup
    https://git.kernel.org/netdev/net-next/c/1ef33652d22c
  - [net-next,v2,2/5] net: netconsole: Correct mismatched return types
    https://git.kernel.org/netdev/net-next/c/e0a2b7e4a0f9
  - [net-next,v2,3/5] net: netconsole: Standardize variable naming
    https://git.kernel.org/netdev/net-next/c/5c4a39e8a608
  - [net-next,v2,4/5] net: netconsole: Unify Function Return Paths
    https://git.kernel.org/netdev/net-next/c/f2ab4c1a9288
  - [net-next,v2,5/5] net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal
    https://git.kernel.org/netdev/net-next/c/97714695ef90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



