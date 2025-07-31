Return-Path: <netdev+bounces-211117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB7B16A19
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BDC7A7547
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6F17C224;
	Thu, 31 Jul 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUZx5OTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C91714C6
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924795; cv=none; b=AthvbDPzauKPmM5kqNno9+7qjal6COWUAd0bkf/TMXahj4WB8CxwwkY4ymFiC1PWtQo7S8IAMA0pC5YirUvTdGINUkp43JrM7SA8rnj6Rk5TObD4aaRrYtYQParUbudXkjXUu7s0wb6EbZkZMUpEMz8HHrYpl/wHzIrRvdyHYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924795; c=relaxed/simple;
	bh=tMDqfwD7elil5jwSZblV+U+YbHU/gJO8gdPiov7DLBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVWnBb0Q/BURRCQVrmOpi6QXj0SBs2Wlr5eU3utqKoIkqtS0oexC5kMt6Sor5KOiZfdrkFY5jiWx488FA95UZZaFaBYEQXNvV3zZAawz8abwWqzrF/9vT+IUx4ZcZYSKhJ8FEbBHBTocBVOSGJvxM+2k4DZFJfcSrJNQVWvS3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUZx5OTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AECCC4CEFA;
	Thu, 31 Jul 2025 01:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924794;
	bh=tMDqfwD7elil5jwSZblV+U+YbHU/gJO8gdPiov7DLBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nUZx5OTsbMmhvEV3ehUifBs436AmhqSXhNgGZ0xgAVdRMHref/3nT1daftodul8aZ
	 qwM6C9p6Kq77LPmSq6CrtJktAuKSzzF+nF/vw2SNykqK9kFVvppcKdSm0RdVyRCOqD
	 63PYioQM1AiqFOC+uAg1A4N5f3gnaGIHFvhH5rXP4sFmeipVuuBvPf8188wbrUig2N
	 Ri6MdyVoxMrAwMnJBLdE4LgUs7BJHlsIRg91vvHyv5MICCyWe3HYUa1+XZ27fNabB5
	 zKI93d3pZaxf4lgfGKUwvkrV45Q7kKzldSemvy+IGoMz4w9C2WsKywKfIc9r7E2gXV
	 ye2aDbQfaMyoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AB7383BF5F;
	Thu, 31 Jul 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netpoll: prevent hanging NAPI when netcons gets
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392481025.2568749.840711867155556143.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 01:20:10 +0000
References: <20250726010846.1105875-1-kuba@kernel.org>
In-Reply-To: <20250726010846.1105875-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jasowang@redhat.com, zuozhijie@bytedance.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org,
 sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 18:08:46 -0700 you wrote:
> Paolo spotted hangs in NIPA running driver tests against virtio.
> The tests hang in virtnet_close() -> virtnet_napi_tx_disable().
> 
> The problem is only reproducible if running multiple of our tests
> in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
> netpoll_basic.py stats.py"). Initial suspicion was that this is
> a simple case of double-disable of NAPI, but instrumenting the
> code reveals:
> 
> [...]

Here is the summary with links:
  - [net,v2] netpoll: prevent hanging NAPI when netcons gets enabled
    https://git.kernel.org/netdev/net/c/2da4def0f487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



