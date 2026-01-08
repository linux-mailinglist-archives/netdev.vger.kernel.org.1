Return-Path: <netdev+bounces-248039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468AD0253D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0801831A9482
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A741B35C;
	Thu,  8 Jan 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlJHjlTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35573E9F9F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868414; cv=none; b=ljHlvkGZ2h4KUZebR4/k2ZDIeuaBQW0r/H4qMlKDvkZwgXmKGL0jBp1syS+VQtPnO65MMBylWG3nqmTvvCocX/M/PyodJzWEAglZ3NUqbbm6OE+wzSpHop7XZR2iibr2co29f6wz/dA+DEndoxxsdLt2H5XocPr7NFhgxK105FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868414; c=relaxed/simple;
	bh=bzS/PjfPcMpnrR8b0KVdxQk9x4TACwFE5DrS+QCDpOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FC6YBs6/6IjvedSxK+dvvz9o+zspZi3/ozjbelaRz7vTcP13gqXROhURA5QxGH/9iMj8P2OIv9nt8GgsJbYWe+EsaC35wW065rtZQqY5yICtKX8L89PTFBV3TymlL4sRP/AFU5lx4Eh7iQjU+JjoTQ9qCdo4PsxIoLS0pY5N6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlJHjlTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB5C116C6;
	Thu,  8 Jan 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767868414;
	bh=bzS/PjfPcMpnrR8b0KVdxQk9x4TACwFE5DrS+QCDpOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LlJHjlTXVCw6tCautdO/Ycp25Nni4NGrkiqTbdh/AhaHQrLJLy8o5Y9hCbN6jCGWY
	 JTf15UgnIsq3HizY1e7TU3qg0VKh2DxaMmx8Wq1wTtXxdybWojDAodU+2rgXL1kosA
	 ZbzQEaVK+Z0AqFok805xei6hRUEiGtC0ySWNABEUn5m5jCsDhJzLCMbp+rNpRktTUV
	 E43yp2oAAYsNX0P9k+jpwevqtLzBECulGBqnKvpcJRpW8FowE3NrlQHfMfawseeSb4
	 /N22bcGqi0qxzjWRZxQ4R217/N3Ga/OCCyTsWZgoHLQSuGfPJ+2+eY1sbPG8EAak48
	 3v9GWS2XDcXjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28783A78A5F;
	Thu,  8 Jan 2026 10:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176786821079.3573457.449577303139061207.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 10:30:10 +0000
References: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>
In-Reply-To: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 05 Jan 2026 09:43:31 +0100 you wrote:
> airoha_ppe_deinit() runs airoha_npu_ppe_deinit() in atomic context.
> airoha_npu_ppe_deinit routine allocates ppe_data buffer with GFP_KERNEL
> flag. Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order
> to fix schedule while atomic issue in airoha_npu_ppe_deinit() since we
> do not need atomic context there.
> 
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix schedule while atomic in airoha_ppe_deinit()
    https://git.kernel.org/netdev/net/c/6abcf751bc08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



