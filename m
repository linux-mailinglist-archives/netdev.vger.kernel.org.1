Return-Path: <netdev+bounces-242156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3CC8CC84
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11D724E1C04
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC352D73AE;
	Thu, 27 Nov 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTiSz2XN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD92D6E68;
	Thu, 27 Nov 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216063; cv=none; b=pDwOIzcPyRFOe8Dcqh0PXtqwos6nwWvepEhm784WnBGXFd7Sb2YdEhGmuwDxEIwivEhWHvuYemxzNf0teSVfBmjTqqfiJsCturKVCTHZlQTdftrtfSRIulOTDLOwzS3dmrunXGdgqBDMXuwEuwCwJUjoBkR4rhEuoc9V5ETND8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216063; c=relaxed/simple;
	bh=SEwtudOCOJM+9YlMXLC1wVTE/bF9Bva6xS5DELfRlfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Enqtko3KROMz20wMUgOGRZfTUowkYt3FfLHuGsnVszu0FLus0EnmngDvyAHqizaVptsl+oLegwCRYTlwJEYJCHGaFwyPvmhLEMYyWVCoJmLneA6FMyorDcUwaO94qSODNUwOBQZZJDElmdy45RHlutIaXWlYUzC+9y7nPP2Yous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTiSz2XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC02BC4CEFB;
	Thu, 27 Nov 2025 04:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216062;
	bh=SEwtudOCOJM+9YlMXLC1wVTE/bF9Bva6xS5DELfRlfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GTiSz2XNwKN0wjGU+MXNwhXYYQE4yfAlUp+wzq9fweldzjOwoVH5rcSELTFOahpWO
	 mRUEdvTV3rriZsqZElZVBz3gaIvFfvpZFD9ThVSIyXKVt+M1wuKlSgjQVB+3Kus7ZX
	 6GXnNFmB+MqliMLp0txj0lkMgvyB97P7IHpgTbKERtBTyTa/iX13N3u6y8bdbEReVZ
	 AOD0wDIeEQMljhRSUL0HapvDEEzyQQnXB/Kbni1oZsF7BFwEFhsZvKHXG2j5/Xh/vE
	 cs8s5Jjt5D28OpwsRkkZbir/cVEOv8xucVQZy1f/NLQisnsfd1YX9cbHL5v60CCN0L
	 OZBy84YH7VGkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD0380CEF8;
	Thu, 27 Nov 2025 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: atlantic: fix fragment overflow handling in
 RX
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421602449.2412149.12412790479602516578.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 04:00:24 +0000
References: <20251126032249.69358-1-jiefeng.z.zhang@gmail.com>
In-Reply-To: <20251126032249.69358-1-jiefeng.z.zhang@gmail.com>
To: Jiefeng <jiefeng.z.zhang@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, grundler@chromium.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@google.com, linux-kernel@vger.kernel.org, irusskikh@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 11:22:49 +0800 you wrote:
> From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
> 
> The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
> fragments when handling large multi-descriptor packets. This causes an
> out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.
> 
> The issue occurs because the driver doesn't check the total number of
> fragments before calling skb_add_rx_frag(). When a packet requires more
> than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: atlantic: fix fragment overflow handling in RX path
    https://git.kernel.org/netdev/net/c/5ffcb7b890f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



