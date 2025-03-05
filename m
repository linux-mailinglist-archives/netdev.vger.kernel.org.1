Return-Path: <netdev+bounces-172047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFCA500BD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE718865CE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7D248881;
	Wed,  5 Mar 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwTCWkK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFE1E531
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182001; cv=none; b=FsI7a0BJC7CYLIz3mVMtzHG8G1CR8IaDL5h8Fmmph5TTQz0XrwMThPVt9+ksHdk1nPNg3eThq9pz3RUi5NvouYNbnKjVD4weJg+VtwI5+g13IXI2ZZIB99CMnGOfhgr0QW1ccgWP4wqRAosr+I4/cunMX4T4Zs8p/oCIxJ6/k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182001; c=relaxed/simple;
	bh=A/Y973yzuEJmBe+jdOVPIFbD6ha0pBn/vYDRKQQmgl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e4K1zzsk8SR+GeK2xx4rWofBnavuPIwxdF0HHJfX0jrDy5MTabCRzP2Q/VJ9KHwm79SBQ4bexS++2AP6kxEp0mGW7KB+/eV+vqhUQu14Uy2LWIxppNwccLbXba6qcyz5yqPO37A1gZwhGDyzajjHerrNx2xpOW24UbNnNnjIZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwTCWkK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67117C4CEE2;
	Wed,  5 Mar 2025 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741182000;
	bh=A/Y973yzuEJmBe+jdOVPIFbD6ha0pBn/vYDRKQQmgl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwTCWkK5iwYVe+rSd6FNw9JKNViN748xjBrDYU/B0XTBQyVjRnG+xmICyxUID7DlP
	 zYOE9DYc06yh+epHQs5qxUNF6tS3c4XugC3pM6GSmijPisThWtXxBPCmftfoDQ06i+
	 8DbVC3SKJurtQfewuJGqvX7YtWBQeB+a+TtCIQlGjvKE6IeFAmBKwsrHIawbnaQtG3
	 vNDMeoRaTGdvK24+S+30ikyhu+Lm86oBgalSJpMOmywV/vmntCoxycpEULRkZUrym2
	 fTsSmvJOilJoPN2hZ/3+stBsyUuatggmKKVTZFjdeoi82na8kTqEQvzM7/X7+8sFNb
	 1FGqXtdIEQAAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE105380CEDD;
	Wed,  5 Mar 2025 13:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net-timestamp: support TCP GSO case for a few missing
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174118203351.886004.4860497203823639707.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 13:40:33 +0000
References: <20250304004429.71477-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250304004429.71477-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com,
 dsahern@kernel.org, willemb@google.com, willemdebruijn.kernel@gmail.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Mar 2025 08:44:29 +0800 you wrote:
> When I read through the TSO codes, I found out that we probably
> miss initializing the tx_flags of last seg when TSO is turned
> off, which means at the following points no more timestamp
> (for this last one) will be generated. There are three flags
> to be handled in this patch:
> 1. SKBTX_HW_TSTAMP
> 2. SKBTX_BPF
> 3. SKBTX_SCHED_TSTAMP
> Note that SKBTX_BPF[1] was added in 6.14.0-rc2 by commit
> 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
> and only belongs to net-next branch material for now. The common
> issue of the above three flags can be fixed by this single patch.
> 
> [...]

Here is the summary with links:
  - [net,v2] net-timestamp: support TCP GSO case for a few missing flags
    https://git.kernel.org/netdev/net/c/3c9231ea6497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



