Return-Path: <netdev+bounces-87826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8AE8A4BB8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7311C2261F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6141760;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6jGq/yx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57640BFE
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174028; cv=none; b=bqVvwzO5EiE02FSwj175NgRgHWl5/3dQjq262MOHds5pPR0dWCXVJgz5LRl5zFZTKehxwEG9kAg2zjq0kFyzNEF/BEr2TWqJBL/zYCTZMCokB7c4/MMsggTCIpCiXoZ9QBkiHLAEePYPp+zxLfaOwSdSeI9kn1Pw6cQ201f8YbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174028; c=relaxed/simple;
	bh=kxnI3fgiBuQaAxbOxdbM9uQsBv7Bk+fuqi6NBY5AX9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jqifyPiuBV2G7r2hCnqgCMYR5xHg/hoT//XswG5gb2zSHrcH2W1TFnZCUOvyfBOnVDCJPDB8b1AyyI8ZGMi9pM0tVYeK1u1Hi21glNsFgvmagH49rXLvVpTxCvwdHVjrd9844DvXr8SlRD0ipdEr9U2rwvWRq+xfYKRfqVR3294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6jGq/yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A086DC113CC;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174028;
	bh=kxnI3fgiBuQaAxbOxdbM9uQsBv7Bk+fuqi6NBY5AX9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6jGq/yxEStGlezjz4ewClP5mwJiEuPQjhjKNV79xbsi8MvQBAw2a8jmX4NgZ5auE
	 gYYbDZRleB699RROzKb0hJzGkH8N+rUprLBaUUxRZD8lEm2rp6vGZZKdxfi20aHpYl
	 yz5C3CE0jUJOe7VkBFrXWmDX4znN38rOzSq/jNqHaMBBqozHfOOuWW01CGkLHP/Su8
	 njETG1XZf9ofmhSEmr4lSxEKJdMzUZ1EPdH4YR6ALMehcsjL0oE4atM7vKx3CC7+OJ
	 qitg1qqaj2BBFjiWHLvZlPzH0iHEbGYiJ8yq8l4FTQ24NtlNuge/m4zWZMmCcpDwam
	 yvzLygqjol0/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8971DC54BB0;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: save some cycles when doing
 skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317402855.10544.4488096610959172943.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:40:28 +0000
References: <20240412030718.68016-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240412030718.68016-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, pablo@netfilter.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 11:07:18 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Normally, we don't face these two exceptions very often meanwhile
> we have some chance to meet the condition where the current cpu id
> is the same as skb->alloc_cpu.
> 
> One simple test that can help us see the frequency of this statement
> 'cpu == raw_smp_processor_id()':
> 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> 2. using BPF to capture skb_attempt_defer_free()
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: save some cycles when doing skb_attempt_defer_free()
    https://git.kernel.org/netdev/net-next/c/4d0470b9ad73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



