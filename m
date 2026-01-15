Return-Path: <netdev+bounces-250161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFFD2468C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456213011ECF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801733933EF;
	Thu, 15 Jan 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtUNaMdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAF3793AF
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479216; cv=none; b=CFgbg/ts/0XkAU/Vegahqkc+MxmXf/ZdyVrFIsFenrhWbQ+hBxzz1oNk2oL8Vt7AAjQ4E/JNfAPy1JQSO8/8W+TOjRG5sb509ej9Si578lJ/aHOzLsV+UR4CbpqAhHiHGk0SYW6+57KShlxLIFNcXUrUjd2IxHRCO9MtMoE4+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479216; c=relaxed/simple;
	bh=ThZqrN1WW+EtTxAVCoJK3sgYVa+JUzGN5KNnw5ha1KI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYLnVp0fhg19b83tUIA4qyUZFnZVV3xYYSo3L+2KSmlH5c2s0uIoUnNJEl3nh0OGOHxMwsVL8G0zQ3CGJx5MT9DW4EwB0P3Ar7Seb+BEOJWBTRVw0xVFd0uCOdMMM/QbY9OtnTDXb+zPZZsPb9sA+Prdl7QnM3hRiU95q2H0UFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtUNaMdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2750C116D0;
	Thu, 15 Jan 2026 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768479216;
	bh=ThZqrN1WW+EtTxAVCoJK3sgYVa+JUzGN5KNnw5ha1KI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtUNaMdX5PeEjKNUr3L7/MmZzWCD/r4S89MyJfEupx17ifW/DeYKcrJINhimxmaEC
	 F8Ob+Cub9q3Ve9ozJ1yXqBpcT0SScAaqAEkxkV9ojzWBqy5BmpQRtnZPGKZjNKvbgI
	 7jPbv+pJp8WZJex4GTMEdupHXilrlAdj8JKzb97lSxJOMj7ep5o9rIjJ9RcrEoAypy
	 yFpSYqmiVHQSulGqAH+WUnkzhlZpZgIhIy25jTVWiGuMicC57vZW528yNzj6g6Sxdu
	 4Q+aMFEyY9GeMDqdTk8sk0prdhbJbtWeyxnhHY0NX9M2KTaVmI37QE3xB4zsQVdKML
	 TPIYNfdeg2OdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B983809A82;
	Thu, 15 Jan 2026 12:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176847900840.3967700.12571479792943503931.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 12:10:08 +0000
References: <20260114121817.1106134-2-steffen.klassert@secunet.com>
In-Reply-To: <20260114121817.1106134-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 14 Jan 2026 13:18:08 +0100 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner
> protocol") attempted to fix GSO segmentation by reading the inner
> protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was incorrect
> because the field holds the inner L4 protocol (TCP/UDP) instead of the
> required tunnel protocol. Also, the memory location (shared by
> XFRM_SKB_CB(skb) which could be overwritten by xfrm_replay_overflow())
> is prone to corruption. This combination caused the kernel to select
> the wrong inner mode and get the wrong address family.
> 
> [...]

Here is the summary with links:
  - [1/2] xfrm: Fix inner mode lookup in tunnel mode GSO segmentation
    https://git.kernel.org/netdev/net/c/3d5221af9c77
  - [2/2] xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set
    https://git.kernel.org/netdev/net/c/c196def07bbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



