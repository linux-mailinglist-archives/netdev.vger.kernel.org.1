Return-Path: <netdev+bounces-205628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A9DAFF6E9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6073B6FB5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D928032F;
	Thu, 10 Jul 2025 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqq6w9f/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4F280324
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115194; cv=none; b=fvvzSKmr2/Hd6VMNB8df3Lrto0LBng2WEI5SxqQmjMM0oVils9E0E7Q9ATxBDUtEhi8GEl4oCzcX4in7F6HtoXES82lcUASxUX38giR0cxIrARHpfyerGLaeUQm/dTCU/LxRgIGo1QOpcRwnLmHteToU8h4j6ojb9ttmEC50e5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115194; c=relaxed/simple;
	bh=nO94sTA46AWzlrcxav1oS3uEYvLj7YYPpqnVOUvMDIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sKWaH2PL4fi0dOJa+aeuA/7x1+rHk8yJSTzL5peXlbFco0CoVSlsUucvywtrDxFyWWhEiZ8Cyj9RkZUjSc4QzZy/E4o/2UwOmH8G3frFei9PrdFMINJ4NqbgI2YSM5njLlJekVvdMVoN6LbcYYPhT2BlAU9rZvuZOGWvRZGXH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqq6w9f/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB34C4CEF8;
	Thu, 10 Jul 2025 02:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115193;
	bh=nO94sTA46AWzlrcxav1oS3uEYvLj7YYPpqnVOUvMDIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oqq6w9f/UM1MlJV8DFEJkWYEjYAtnLyufw1TpKcxVJd/YTo+yyn/xZjLuDXYe42y1
	 H7mAfAn2ruFwuViq2L3iwzOrNHNsePE7kAw2PmwPDt4wSBhvJ2B2F4l7GsTyjymsly
	 WuqWzSIN6bLwBt3/P8tk2eNAB62/ipKTdCElKcW5CsSw9Z5GBaSsn0OlLARA2+5qLY
	 NmIn7l7rP5eeaHGF42T9jxydL2o/o7hz1GuhVG767WvVErFN3TDKIWN158z0iCx2lJ
	 cxjYZmCSaEdkIDx+DqCayw0Ix+W/aQmFZl7THEhM555p/2RgSadUZG/UCvG6qCt8c0
	 +0fbVuwIIvguQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1D383B261;
	Thu, 10 Jul 2025 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gve: make IRQ handlers and page allocation
 NUMA
 aware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211521600.965283.16790922695385981485.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:40:16 +0000
References: <20250707210107.2742029-1-jeroendb@google.com>
In-Reply-To: <20250707210107.2742029-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com,
 bcf@google.com, joshwash@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 14:01:07 -0700 you wrote:
> From: Bailey Forrest <bcf@google.com>
> 
> All memory in GVE is currently allocated without regard for the NUMA
> node of the device. Because access to NUMA-local memory access is
> significantly cheaper than access to a remote node, this change attempts
> to ensure that page frags used in the RX path, including page pool
> frags, are allocated on the NUMA node local to the gVNIC device. Note
> that this attempt is best-effort. If necessary, the driver will still
> allocate non-local memory, as __GFP_THISNODE is not passed. Descriptor
> ring allocations are not updated, as dma_alloc_coherent handles that.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gve: make IRQ handlers and page allocation NUMA aware
    https://git.kernel.org/netdev/net-next/c/d991666b7b69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



