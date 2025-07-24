Return-Path: <netdev+bounces-209760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153DB10B67
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4645A4B21
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566C2DA772;
	Thu, 24 Jul 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajLk5MfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A782DA75F
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363791; cv=none; b=Grnn6XVnzQW/NXqL1QE5L7TKXxIDp+eDDTcI+MNbnqJ6Q7KnoJLMZ2a7/OcnNX3lCFXvUEkMFzlIBHrZUwE+8aif/5FvyOLA27TGocuuPe7WnDwdX/3DPvmBkXk1a7gFpv1M1RNJqBnXSWu3d+wlR1QW7sRCBXnF4B7uR9GUmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363791; c=relaxed/simple;
	bh=RueGTiRRs4xIziPN78V5DzV54xJk9Rzpiet4uHsrl6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8Ugv3Y24Dz/lZSpUVyS2dIJCJG7qf8BXfmwo0JBO3pYVAYg9bb8EK4oxYcwGQ95XjjNIoswFdxKUNZKylMwV+1GfC37QVX4coBepX3M4vgEzSmgQUBKN1/NQd7ebK6kFq1YKsiHQX8g7iiQW1mvFHZC/TjBZj02Lwn4bzbwGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajLk5MfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC714C4CEEF;
	Thu, 24 Jul 2025 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753363790;
	bh=RueGTiRRs4xIziPN78V5DzV54xJk9Rzpiet4uHsrl6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ajLk5MfH1FGZZjHjho2tIKXJFRonhb+qEod8WnFD4ruVBVtWY+o37FrjXRD91uTSv
	 Tqe/5NXnBaJhfNj+7z+PMsJqlJPWJfJZPtIJ6eZzBVGd79ieRVhibQScsRYD3/+rEY
	 O9IoECK6vK++YFdES6FkGbTOtT7tVu6KgrMrB1bxEWtK4/8txVr5xLNhC1Ae+zLrRz
	 5Fp6AYAwGFaPk9a9pZibQRPoyXmJZyiAxpRQjCFwkVAe3f4dXef49J60qTmUGrtyCw
	 ds4kl72k35ktCiCF6Nw7DXwV7h6pfR6UxKWA2FDgfZWfvEWZPbnel/+4dwZplWAx/e
	 UNqth194+a86A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABEF383BF4E;
	Thu, 24 Jul 2025 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] xfrm: hold device only for the asynchronous
 decryption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175336380876.2396070.3234412767137065519.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 13:30:08 +0000
References: <20250723080402.3439619-2-steffen.klassert@secunet.com>
In-Reply-To: <20250723080402.3439619-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 23 Jul 2025 10:03:48 +0200 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> The dev_hold() on skb->dev during packet reception was originally
> added to prevent the device from being released prematurely during
> asynchronous decryption operations.
> 
> As current hardware can offload decryption, this asynchronous path is
> not always utilized. This often results in a pattern of dev_hold()
> immediately followed by dev_put() for each packet, creating
> unnecessary reference counting overhead detrimental to performance.
> 
> [...]

Here is the summary with links:
  - [1/3] xfrm: hold device only for the asynchronous decryption
    https://git.kernel.org/netdev/net-next/c/b05d42eefac7
  - [2/3] xfrm: Duplicate SPI Handling
    https://git.kernel.org/netdev/net-next/c/94f39804d891
  - [3/3] xfrm: Skip redundant statistics update for crypto offload
    https://git.kernel.org/netdev/net-next/c/95cfe23285a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



