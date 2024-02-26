Return-Path: <netdev+bounces-74898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC6867394
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A2E280D23
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A41EB27;
	Mon, 26 Feb 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwr9/1HV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC124B21
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947631; cv=none; b=gQwoHf0J+iQ9SOqCGtMmK9UcOTAgP6NIK+wAAduR3Jw78bVpFyCKyGRCqYp1j/Lbu35K/gGntODpuGOWhl1loLTADisFzIP8oqMlIHyLKp3u5fcPoWf2iEQuwQUPcvTAr80y062xKArcTQ+IfTejtjS0B/v4nqgkFf4V366beok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947631; c=relaxed/simple;
	bh=mMLKPcszZq80SDdKpYonRO1c2meCNdGBo8A1IL9wIg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i2nnCQ7HUC2jcAQrHXcmx89Su/PQPCP5UK1SYUPbrNsYMlbxPem8xn61/qOs4rKERMGfwCuQKYbxVLMy9HS8skjvUTp6zAujdsoO17XwmbIcHDqfUK03yEDNiqgP/ax7XpDQ6hp9hkSAo+2BlmwleBhWFLp/BCINY0yutSzpLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwr9/1HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF388C43394;
	Mon, 26 Feb 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708947630;
	bh=mMLKPcszZq80SDdKpYonRO1c2meCNdGBo8A1IL9wIg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uwr9/1HVs0LUkaM21/9W0sTyicxpY5Or7AY9EKSfAaN9UFf+GuKYGrsikdJVIjkIb
	 7wnq/83I7s6wtZoNSaP58L0lfO5ezg2KHBCwvaQvhCkm4tOT/aLRmlgFACa57ODVaF
	 XGFVG0c1Oy8UnxPrHAKb6Q0B0LHs1khs33YQsWVdJS9mE1m6Y7iwkb7CO2+JJGtSQW
	 T2YfzAJz8D+Bw/bZOCvdDoEt7nCphptL4+eZc1fa9yIzcGnAi+aTazhopyseZNtD8t
	 895owt55BgEtqJsuFoqsEVbfpZCFQXgAHHhrIaZTZZlyp50u+JR7wlPVLvVZHiihVA
	 i38IwZroNwxdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF308D88FB4;
	Mon, 26 Feb 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: veth: clear GRO when clearing XDP even when down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170894763070.4235.7396075348697529173.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 11:40:30 +0000
References: <20240221231211.3478896-1-kuba@kernel.org>
In-Reply-To: <20240221231211.3478896-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, lorenzo@kernel.org, toke@redhat.com, tglx@linutronix.de,
 syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 21 Feb 2024 15:12:10 -0800 you wrote:
> veth sets NETIF_F_GRO automatically when XDP is enabled,
> because both features use the same NAPI machinery.
> 
> The logic to clear NETIF_F_GRO sits in veth_disable_xdp() which
> is called both on ndo_stop and when XDP is turned off.
> To avoid the flag from being cleared when the device is brought
> down, the clearing is skipped when IFF_UP is not set.
> Bringing the device down should indeed not modify its features.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: veth: clear GRO when clearing XDP even when down
    https://git.kernel.org/netdev/net/c/fe9f801355f0
  - [net,2/2] selftests: net: veth: test syncing GRO and XDP state while device is down
    https://git.kernel.org/netdev/net/c/1a825e4cdf45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



