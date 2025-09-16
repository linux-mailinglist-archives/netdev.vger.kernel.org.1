Return-Path: <netdev+bounces-223455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC1B5934A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9001F1BC531E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28474303C83;
	Tue, 16 Sep 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGIAYYce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E90302CA2;
	Tue, 16 Sep 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018007; cv=none; b=Su56fnVY42x/Fjaa0VG8O44oEet2erXkIM85+zkpwBoeqfzACA+DFZVEVCVT7J15exMoFOWbhNuiPx5ZzKERIefyewR0oKCOpJjd23d6mUJ6JDECUldzAN12D8/6eHoXZQr4iV1F7JuGCi7FZArqFoPPDcgLt/ySTj2bEGR9NqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018007; c=relaxed/simple;
	bh=TbzkzVHEK1yEbMNnfkgImEYVcP6Q0LNVAAHXAk3Oil8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZcqCFVnCGO5uHPUwMQL97jHmN7pFKj/6cGWhrOK1GnyA93QAO9nQUgnPtJWg1idzwcpNlaWhEiIBgZo5o/HEbBWjI8ILGBC7etlJqyrdlux9TVCbgVyHy7/M8FUESs/X9GJfnKnMdELZpiK6U2wXxe+HL+EJ2f6YTWbmfJSmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGIAYYce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819A9C4CEFC;
	Tue, 16 Sep 2025 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018006;
	bh=TbzkzVHEK1yEbMNnfkgImEYVcP6Q0LNVAAHXAk3Oil8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGIAYYce8e8rXdcjgfq4rkk01Qfd3kY8EVjhL4DScF/Nn6Tv5VYSR9AOx9SiRLmoq
	 DrVbtCnRTsPVHIwS3Vg2LL3jEft4vf8J1hiWjwCYe0qeqnoS73OfeUs/XIE7c3774p
	 ajk/eDUF0crP/xkbhmkE4DAM1RjeN39LOJi41Evt5gn5bTLs9zTcOW/hR2ncCAkUR8
	 XBXBrpdt85lg1QIeD04zIOfKDBY0Kyx8Q1RwbDAC4g2kp0gHYh7mwjMi79awGDcpN+
	 dOb60MqmTuU4kYHdsnbYr22I2j55pHgonfd++Y9Sgbx1djKvUYtK6bPCpIbYB/KSMb
	 tJRvNQXZqUd0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7939D0C1A;
	Tue, 16 Sep 2025 10:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: nxp-c45-tja11xx: use bitmap_empty() where
 appropriate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175801800777.695774.17798425923008297639.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 10:20:07 +0000
References: <20250913182837.206800-1-yury.norov@gmail.com>
In-Reply-To: <20250913182837.206800-1-yury.norov@gmail.com>
To: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Cc: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 13 Sep 2025 14:28:36 -0400 you wrote:
> The driver opencodes bitmap_empty() in a couple of funcitons. Switch to
> the proper and more verbose API.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx-macsec.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Here is the summary with links:
  - net: phy: nxp-c45-tja11xx: use bitmap_empty() where appropriate
    https://git.kernel.org/netdev/net-next/c/29fa7f9e5adf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



