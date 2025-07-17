Return-Path: <netdev+bounces-207763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D6B087C8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0953BC7FC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7375B2798EA;
	Thu, 17 Jul 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvVMXJHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B435957;
	Thu, 17 Jul 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740386; cv=none; b=jPi0Caws34RXQY3yb+F/w0UrTfwZ5bTlTtqR04FGwCvLx1gUZPcQvNiLz2HFVPaQc2Ost2B32eNbgb3Zc8QXeNf88nDtgL9eMvaqML4/V4eTTpJCdIpEmU4tmXY4HpQO3LdZ7pu+0nmdOI4YCXi1oWQUxPSIrTe1YIf+GarL/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740386; c=relaxed/simple;
	bh=Md5WNw8ujg/pxCAl4moKw+t7jhdSwpRRG1PB6BznJMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dnrMtkbZYkmD4madjBEfMChHxG+MIw17sDfgqxvyTPLCzMvQSsCcqqSl8aQUZFn7digp5xcvljdZ3+DFyNhIry+YbajImDDWnkWgc/mFokdludhNMDPyZBZONKzzUJVPVAkzWN0tTVc4BL7kj4E0uYb+XIT0R8EXZJxBhPoUByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvVMXJHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154B7C4CEE3;
	Thu, 17 Jul 2025 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752740386;
	bh=Md5WNw8ujg/pxCAl4moKw+t7jhdSwpRRG1PB6BznJMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DvVMXJHLkXKGVj6QV7IONQPsfCfZM9+GJoQrf0J3rYLKYB0MEQLXm+PaFsXutWzR3
	 QYy9ZZaqCsopG02lEyaFMye8SuTD4E75lwegyh4yz0hcaYyqEOLEhD5Ay2/Zqdn52B
	 rYaG7jnKOSZ//bg1nR4KyRgN5xUBVwNFwLivqRudU5iElxKlHvxDZntp1Pcxex4PfN
	 xNR7gGFBmLWVDvzCg+mupYaFjZc/NnREs7XOGLKrCO5xyLZVBPEK/Rcn599CPlzixe
	 Q76fb07iUzE1jRgQVsyke89wnokH7P3NmNG/p1ujY+AW5h/MtWbo/ZVTRWdlVbSImO
	 2MvQ8hk5tkqAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F65383BA38;
	Thu, 17 Jul 2025 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175274040626.1485472.15419586586867820749.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 08:20:06 +0000
References: <20250705150622.10699-1-nbd@nbd.name>
In-Reply-To: <20250705150622.10699-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 richardbgobert@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  5 Jul 2025 17:06:21 +0200 you wrote:
> Since "net: gro: use cb instead of skb->network_header", the skb network
> header is no longer set in the GRO path.
> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> to check for address/port changes.
> Fix this regression by selectively setting the network header for merged
> segment skbs.
> 
> [...]

Here is the summary with links:
  - [net] net: fix segmentation after TCP/UDP fraglist GRO
    https://git.kernel.org/netdev/net/c/9f735b6f8a77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



