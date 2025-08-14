Return-Path: <netdev+bounces-213534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B9B2586C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C403D5A2399
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB7136351;
	Thu, 14 Aug 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyKLd7cI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AC80C02
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131997; cv=none; b=tSUW1V43eB8ZYrTfwrepuAOnjFv8Iar9pNGvTxr7Rpssz8a3eReXAqjbkHKeSdt6hsEUr6kT/P/RUmh91IM1n7oaRCHWZDsOnDDEcJrEQDCy1jwqpbQkuvYffwKv5KcTLtgZ51UR1juELE7nTi81p8tId22WnOT1vCdQ3qE9bUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131997; c=relaxed/simple;
	bh=hvv7ASmyeP4DZiQdS3tREsBtoX5JQeQ8aoRhSWnOA2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHQkKnKvnAYUwTbtNgM3cHok4VwyIYkQ9FoPNn/RrW/QZUkJRsXjAlpnytQ4Ek13OdvxWWmIOb8M1QWtl0wXrkZRblZhRtzz/rUTlROEeG/OC5zSxxA67BnJqNpvWXBxA41/SBkWoK9lMZfmFrxfKWU6hzOZOpgczWGIMAy2fHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyKLd7cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46C2C4CEEB;
	Thu, 14 Aug 2025 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131995;
	bh=hvv7ASmyeP4DZiQdS3tREsBtoX5JQeQ8aoRhSWnOA2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gyKLd7cI3mD3SRe6Q3gTMYvx5EI1+GTsutw61sjeGUT4pdsEm6+pVmwpNI3YQrMLX
	 j8oL2bALCOEIV8MpgjniaDLtHR92vNyzA+plg1JEIcXzIMPxQx+tB5dmBGaHoUdowo
	 v4lo4Qa2y1i6tRVHiKc2nb/v1JjESbdFQW+Tp1oTe3BtDBxM1Gb+yFGfp1MHN35AWi
	 QXSk4BIyeoUQ7sXYC4K9ZHignhuhPEyMD6veSSWtJmKGfIOwTuueRnTOE3dqHpy6S3
	 cLibJ3RUqf0DbECceRv40V1ewXxyUZE8U+kDRLRqlRENTPunWvjBcGGhUUvEkguwJI
	 L/TOq8dpEUKtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8F39D0C37;
	Thu, 14 Aug 2025 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt: fill data page pool with frags if
 PAGE_SIZE
 > BNXT_RX_PAGE_SIZE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513200750.3832372.6458233537252002910.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:40:07 +0000
References: <20250812182907.1540755-1-dw@davidwei.uk>
In-Reply-To: <20250812182907.1540755-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ap420073@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 11:29:07 -0700 you wrote:
> The data page pool always fills the HW rx ring with pages. On arm64 with
> 64K pages, this will waste _at least_ 32K of memory per entry in the rx
> ring.
> 
> Fix by fragmenting the pages if PAGE_SIZE > BNXT_RX_PAGE_SIZE. This
> makes the data page pool the same as the header pool.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE
    https://git.kernel.org/netdev/net/c/39f8fcda2088

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



