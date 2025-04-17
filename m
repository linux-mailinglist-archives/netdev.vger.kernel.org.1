Return-Path: <netdev+bounces-183586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DBEA91150
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B32179E8E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C511DDC16;
	Thu, 17 Apr 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9BtF9eT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0371DB361;
	Thu, 17 Apr 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854026; cv=none; b=ipSyYVGjccGQGWuiJAX7aARPYTogcuCpgFpdO8tsGb/lkuGJL4eT4+9vu6QuQFuDy8vkd4XczrhPcMoPhBrxSA4xsS41ISqB6QYPxdpRPHQ0bQDlOBh2yO5VWFF/9amYnL4HGwdG9a398Utooe2wXREtyocQFjzw7WXuNRSK7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854026; c=relaxed/simple;
	bh=t4D2/T+vglGNaV3PdR5qkIJnEsy9z3I9N5XZvJOO41k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pvxfDylFsH9Nhcu3gFhfEibL0H9PNx/Y69Rs0oHatRNkYRJtNosOuPPdNMohQUgP7nl57QJekzOakbI85urhguEsKmZVZq1e2blr+djOQdIICxZD01OgBeEhGwhQpNSriqyntdXoTaH9S2bbNc0Xhk1K1UjXvVng8Rf1Juqp37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9BtF9eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A517FC4CEEA;
	Thu, 17 Apr 2025 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854025;
	bh=t4D2/T+vglGNaV3PdR5qkIJnEsy9z3I9N5XZvJOO41k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9BtF9eTB3daneJ7yWHYfwITdGSs8JR9ok8iZfLxFAMyq8lUUkLaMTyq6IIihEk7d
	 vV33+dA81Z/blWBrJpXw05MbCTcFJDB5R1tLXu5xpeHyepOAjys7IDA7B4pfkvAOmy
	 A1OIQ4VyZYQj209YAgjtemv+9SIc1W0elbL8TBEwDuu7VQZwnX6kYcl9xMvwqatBrZ
	 IVy5iK3XEMBiR1maPJ83ZwvakLjJ2bFxOE7lzNmL4c3fmuIUmQ1Zbr0nC6civMDtc1
	 WaYPd3XUvDQ9atG3kbq9NIua5xcgyBqd4t/Q6e6PWCVtlfh7xArulOy7I3L3NWcAd7
	 EyjY2wWGqyhWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD913822D5A;
	Thu, 17 Apr 2025 01:41:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: lan743x: Allocate rings outside ZONE_DMA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485406349.3559972.7757010421778323268.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:41:03 +0000
References: <20250415044509.6695-1-thangaraj.s@microchip.com>
In-Reply-To: <20250415044509.6695-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 10:15:09 +0530 you wrote:
> The driver allocates ring elements using GFP_DMA flags. There is
> no dependency from LAN743x hardware on memory allocation should be
> in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC. This
> is consistent with other callers of lan743x_rx_init_ring_element().
> 
> Reported-by: Zhang, Liyin(CN) <Liyin.Zhang.CN@windriver.com>
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: lan743x: Allocate rings outside ZONE_DMA
    https://git.kernel.org/netdev/net-next/c/8a8f3f499176

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



