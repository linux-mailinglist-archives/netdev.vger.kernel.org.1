Return-Path: <netdev+bounces-207913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7250BB08FE6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BAE5880E7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D22FA643;
	Thu, 17 Jul 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5sZrGch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCA2FA63D
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763812; cv=none; b=lq0sJs68PNep941K8FaeXmDOrsjocbc8qFIEMHiszoilVF53X6vjNSu2k7S8bWC0mXAjcF9ma7TDd+duZ/enYDRjuaHfxDRnITHSy2R9IhOk/FSAbwCWt89zMd+DVJO0tqa7uufRDvzBRwfzhlqgkO9czUQ3pgdo2fWlBwiFc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763812; c=relaxed/simple;
	bh=a0ckqX9FKR2Fc10otjFubJaF+hkj9+J50DRNJf6/qKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CcKfaFpE/B9w2T9yi3vu49sryV7HS7CHsAMQR3tJNC+GG3w5bJF1+GkpFQdJVqtYb7vAD3t/8e1KhqU2h1I3pHSEmBmL8fyWBhx2UL3mBY2qSHSiXaTVJgaIYmtlhjrKfsHAomZZyyUKS9oZcdi57WFOzr18wGftIIe5XY1zgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5sZrGch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2766C4CEE3;
	Thu, 17 Jul 2025 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763812;
	bh=a0ckqX9FKR2Fc10otjFubJaF+hkj9+J50DRNJf6/qKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5sZrGchbB0sAiRtxSM6Q8anA7qC/S37qf0hL1Lx9pZG4nk1+TGVPBQH6IWqBQKtU
	 frlemdKOEexbNw818YlWti1VbTTqacXjg4LWbP91BjJJGm8TQHlgAFbHZMxrdaSOWZ
	 wYMMrML8ovRNBjZjy0E3NpNOMbsF7hDLjBSs4/Saz+sD+QdnGegNXaGRVW0P1v2yuz
	 xX3VbhJY9swE9YCFG+c1ImhJmMDCPvFNt/oSnF3iL/IPD6vzAegyAyDGb8tnLO8FLs
	 pBHBSUwPH71/R6hiApDGZe47k9ZeDs8og2Pw16jVB2eS3Ceti8M0Z+CrwoYn9RQhg6
	 ozovVsqDx2x9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABFE383BF47;
	Thu, 17 Jul 2025 14:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tls: always refresh the queue when reading sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276383250.1959085.3407074151813654081.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:32 +0000
References: <20250716143850.1520292-1-kuba@kernel.org>
In-Reply-To: <20250716143850.1520292-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 borisp@nvidia.com, john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 07:38:50 -0700 you wrote:
> After recent changes in net-next TCP compacts skbs much more
> aggressively. This unearthed a bug in TLS where we may try
> to operate on an old skb when checking if all skbs in the
> queue have matching decrypt state and geometry.
> 
>     BUG: KASAN: slab-use-after-free in tls_strp_check_rcv+0x898/0x9a0 [tls]
>     (net/tls/tls_strp.c:436 net/tls/tls_strp.c:530 net/tls/tls_strp.c:544)
>     Read of size 4 at addr ffff888013085750 by task tls/13529
> 
> [...]

Here is the summary with links:
  - [net] tls: always refresh the queue when reading sock
    https://git.kernel.org/netdev/net/c/4ab26bce3969

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



