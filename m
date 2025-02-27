Return-Path: <netdev+bounces-170076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7AEA47342
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFC16F44B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314B1A4F2F;
	Thu, 27 Feb 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5+570Ze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E831A2554
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625201; cv=none; b=DXlcPY5B9jJJxYwtbxQOwZJU/rqsTF7/YSPqb7DkGUkrVw+kooeU6839nF8PKN63QMs/yTxnqs6tggi1Z44XNVmew1AQAO55rfzwR3bDIQyfSA7n/8RFvC/antiRripXy01pOSvz2Lt7ZWyQK94NzJyZamI/Nwww7VsRADDyY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625201; c=relaxed/simple;
	bh=0jEhcXUWEY+p+LLE4YehWY7Z12DYYMvGfOvio1J4nOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CK9IEwQDfPy8MdlepIrVkmoAVd6pYKEmVYgygT4DONhvy65yEFSXavcqoj8cj4jThth8T0+Ktnr1vaH74c3iIcvCbGmByKex0ZHF/+gs0v9SEyhFtsOIUXlmD4VVXFRa5ZLEqwEZJvAoSV860/YQvES1kvrxl07q0jzwfbcHWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5+570Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CE9C4CEEB;
	Thu, 27 Feb 2025 03:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625201;
	bh=0jEhcXUWEY+p+LLE4YehWY7Z12DYYMvGfOvio1J4nOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5+570ZehNn1aZWR1oMztszzzdvP9uFqUpYDFlJ4xwYvZv6y84X3MbRyH2zWZZ7Gu
	 8BfCJ0AdP2svOi/mGEfDUJCN0qCooYUVjtOh1CqqMnOK29s3q0y6CAx6hZndsF8J61
	 ergf35GZa1vdSmUK+M+P20WuZQVNkuVtUzOMycDOoVKGq3Ab+BybYyNoQz7V8Geqnn
	 JCGmiBArDcVigY69FoM6FkIYi9uRqWMvKVT82ld99CPuh70HjE2RxfZDryi3+AupZC
	 zAuTv2+4VPjXE8BgjPVmdxMjHraW2pYFFaIRq6pQ0wuv36ZPgAfV3ugF85o85TvlZm
	 ew5njZbNnKO+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD5380CFE6;
	Thu, 27 Feb 2025 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: Clear old fragment checksum value in
 napi_reuse_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062523299.949564.12243959200939454238.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:00:32 +0000
References: <20250225112852.2507709-1-mheib@redhat.com>
In-Reply-To: <20250225112852.2507709-1-mheib@redhat.com>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 13:28:52 +0200 you wrote:
> In certain cases, napi_get_frags() returns an skb that points to an old
> received fragment, This skb may have its skb->ip_summed, csum, and other
> fields set from previous fragment handling.
> 
> Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
> CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
> others only set skb->ip_summed when RX checksum offload is enabled on
> the device, and do not set any value for skb->ip_summed when hardware
> checksum offload is disabled, assuming that the skb->ip_summed
> initiated to zero by napi_reuse_skb, ionic driver for example will
> ignore/unset any value for the ip_summed filed if HW checksum offload is
> disabled, and if we have a situation where the user disables the
> checksum offload during a traffic that could lead to the following
> errors shown in the kernel logs:
> <IRQ>
> dump_stack_lvl+0x34/0x48
>  __skb_gro_checksum_complete+0x7e/0x90
> tcp6_gro_receive+0xc6/0x190
> ipv6_gro_receive+0x1ec/0x430
> dev_gro_receive+0x188/0x360
> ? ionic_rx_clean+0x25a/0x460 [ionic]
> napi_gro_frags+0x13c/0x300
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic]
> ionic_rx_service+0x67/0x80 [ionic]
> ionic_cq_service+0x58/0x90 [ionic]
> ionic_txrx_napi+0x64/0x1b0 [ionic]
>  __napi_poll+0x27/0x170
> net_rx_action+0x29c/0x370
> handle_softirqs+0xce/0x270
> __irq_exit_rcu+0xa3/0xc0
> common_interrupt+0x80/0xa0
> </IRQ>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: Clear old fragment checksum value in napi_reuse_skb
    https://git.kernel.org/netdev/net/c/49806fe6e61b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



