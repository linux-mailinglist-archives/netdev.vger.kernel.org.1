Return-Path: <netdev+bounces-218360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59FB3C2B7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F585169BAE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F821CC56;
	Fri, 29 Aug 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nph0yxXC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976121DED77;
	Fri, 29 Aug 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493567; cv=none; b=ZiRq5aWSAoPgiONvGqC2e6pf2JeQyUjckmYdgvLXP76cDYZA1Oiw9m6b9/nPXQtCc1gNdwmYCj1haxhepP6lNEGytd+chZ3BQu7t4A78MXht9Q12FcNILU0/0xGrtUqnQh8sBAw2MbeQ8FEUwF0ItA6PGe4IpMI9OOD+EiQI/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493567; c=relaxed/simple;
	bh=wfv58cvb0JHJKK/3rs9omdGk4oQDMu13ihkaDwW2uOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aDwSyRh7ASc4CVcOrxiPpe5TBOOIoKAFEVa0B7ineKIxpvU26rpqMmpEKVXZWDSXBGOkCcQrTIyuuq5u2sQN7rGKGvhJVB0BBl0k86uyBhKkRMP6h85YHSgQ5EIZzPtOJjx0xoEbbEUNjztWJalSYvPvRVheqc/Y/rg7Nm9fF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nph0yxXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2EEC4CEF0;
	Fri, 29 Aug 2025 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756493567;
	bh=wfv58cvb0JHJKK/3rs9omdGk4oQDMu13ihkaDwW2uOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nph0yxXCPioK9aMVjCqggwum3Bck3rP9VQnQX6EADAAuUtqpJ/bUVbo8pANDACWNJ
	 3pibHYnnp+BOyGmiPY3TFRXWIm5BkZlTIOvtDtGxOtsH/LHqEemog8afQUJbF5ye4N
	 0ZUi/iyLMH+cuHtL2fINs6QC1mfY4HkBRQvLGPe6IjpZJoLn2EnmWy90fLDavaSGL0
	 CgB4kNbLTmE/iLq+GmpY6RAvba0gWDHhnqknkvr5tDdvkjZeFpJ9J0ar/F2kC4vSAk
	 gSLam8uBmS0QFvuukzBcPW1NP2moi7Ii7Lf1dGbSU2Ek78aloi3+DqqEsCjyh470NG
	 QswXfAXL0DWtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE4383BF75;
	Fri, 29 Aug 2025 18:52:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175649357375.2309768.6866206488996278534.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 18:52:53 +0000
References: 
 <20250828163618.86177-1-226562783+SigAttilio@users.noreply.github.com>
In-Reply-To: 
 <20250828163618.86177-1-226562783+SigAttilio@users.noreply.github.com>
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 junnan01.wu@samsung.com, ying123.xu@samsung.com

Hello:

This patch was applied to netdev/net.git (main)
by Michael S. Tsirkin <mst@redhat.com>:

On Thu, 28 Aug 2025 18:36:18 +0200 you wrote:
> From: Junnan Wu <junnan01.wu@samsung.com>
> 
> "Use after free" issue appears in suspend once race occurs when
> napi poll scheduls after `netif_device_detach` and before napi disables.
> 
> For details, during suspend flow of virtio-net,
> the tx queue state is set to "__QUEUE_STATE_DRV_XOFF" by CPU-A.
> 
> [...]

Here is the summary with links:
  - virtio_net: adjust the execution order of function `virtnet_close` during freeze
    https://git.kernel.org/netdev/net/c/45d8ef6322b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



