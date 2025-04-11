Return-Path: <netdev+bounces-181851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1625A86955
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DBA4A4EC4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09A2BF3CB;
	Fri, 11 Apr 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZn9e0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AF3234;
	Fri, 11 Apr 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414801; cv=none; b=kaDCu2imwaYcfN79lcw/yr/kt6Jrv24w1Mq1kPnDrE5+soHpecUzlsh4835zA1Sf+q6tR3W50t+pMU4yAvg1i+eJVaaYG50EbJ7pBz8RpH2rRwXQr1KbWyMw5IEF+MfF/u59jjec7y0rFYfAfBwokRuY6YsGLf8EKdi7g00nAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414801; c=relaxed/simple;
	bh=O7y/ukdVyq46qGxMt1hcV5NVG9xSTvqnublVrmQNsz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZIegcmTN0u7y+Phyg7JVkzwUwS6ol8LXi/JFmRMBnIzJNTzwGsgdvXjjzYCnYSo3qA5XDSDLIJlu/+35ivhUbAHTnlJf6mRF6wFeBJzoCjhY8jx7BCM0I5NREYIYBgBGH5mNmHRcNKJ0au1rr40b6PCH+INmF4VdyuoQ6IBvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZn9e0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D61C4CEE2;
	Fri, 11 Apr 2025 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744414800;
	bh=O7y/ukdVyq46qGxMt1hcV5NVG9xSTvqnublVrmQNsz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XTZn9e0U3NdE8+LRlKLP5WJtIwv0stD6PG175gRkzsgFR9jzv2Fvy3071kl14EpBO
	 pTXYGdF2XZU9zPzc6nxMpLUGfxAWYqu7B/hH/F7orlgTi9ZOOPQPGdgyrI4rSwzVpo
	 5k/8y6yoi7WGf9F76D5rJM1h5UQHchcHtsQAr2c/QxCDOMeWrDCctejk25JmLZOF0A
	 w92I0ZYxUuXnkqBnklF8H8uUHxf/bslangIfZNA8OnwaZy9+lIo98+Jy6RxgZppFCD
	 u2fGDtyU7VK+DdyZespdXFqM0Wtp0O5nhsUYHUCrbaZHTsjwyAJkhXKTUD794VNsBw
	 QHvGx+rCfijzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B007038111E2;
	Fri, 11 Apr 2025 23:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sock: Correct error checking condition for
 (assign|release)_proto_idx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174441483842.518794.6671375598659101505.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 23:40:38 +0000
References: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
In-Reply-To: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 xemul@openvz.org, dada1@cosmosbay.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_zijuhu@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 09:01:27 +0800 you wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> (assign|release)_proto_idx() wrongly check find_first_zero_bit() failure
> by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.
> 
> Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sock: Correct error checking condition for (assign|release)_proto_idx()
    https://git.kernel.org/netdev/net-next/c/faeefc173be4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



