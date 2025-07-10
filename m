Return-Path: <netdev+bounces-205619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B4AFF6CB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E234A1C8197D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7727F177;
	Thu, 10 Jul 2025 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4f+6zxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0619D065;
	Thu, 10 Jul 2025 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114588; cv=none; b=TiqR0jj4RQQ7Bh4Dj6LspPB0NSDh7GzxpD467iLpsCKKYFKWwSLesM8gpz2R8GuYEOccxrMve9urrmLkwa4ParW3IugbG6EI1LGgKyRqm+TIxeNZXZQ0mTkNE2RQ4U4RAOh2abaSSdbkaIH3LYEyiKJgvm67tja/dPqEdSoo6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114588; c=relaxed/simple;
	bh=THlgbPKaBIAndpi3ctc5NliKSeKarMqNvCUYHFvBXYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQTaEcC9A0baXYxWyiHyU5MdHXWGEp9mVJfxLem7+jfNjtfMXDG8dsFMQClCzfv8/pDxM2QXEAaq8vYYcP44AO8rlgX0XqfDr0KMHYrIO6vo5pE5ONYmuKRK+NBrvOpgdEk39jemOh7c5ieqsz4dpfs9zpeAAw5d8wYzJ9ULr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4f+6zxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA76C4CEEF;
	Thu, 10 Jul 2025 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114588;
	bh=THlgbPKaBIAndpi3ctc5NliKSeKarMqNvCUYHFvBXYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f4f+6zxpZQe/wxBr6UdH5ju9D006L6rdEZnXXWtqLlrvV5iJvpnpVyfJ81qcOz80R
	 kUB0CNZCz+v3/mPzDAsSkr8Id7wgYuN/hZ4m/JAE30WEILX6D/TAuiBtZq0lLZVMms
	 lz/xHPOvrNrGeJizT1pWBPE7ONNgOyTPPRFY4TpmMoEwSYWX8IRNYBl/8EgCxC2rD4
	 umPImKXPxe23kpO21p68mzz1ZqWjU5Z7pvqyuWHW3r2+fPAUNOxspAht+dV8sgeTwo
	 ZTsx+Yb9RgpdeoFit1mtxSZt3omFyDE3IuNllRzlkRDmHc3TTNRel/xatqvUijPPLG
	 X9oRetATGISgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E1383B261;
	Thu, 10 Jul 2025 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by
 accounting for skb_shared_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211461077.963219.10864182215949931442.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:30:10 +0000
References: <20250707085201.1898818-1-c-vankar@ti.com>
In-Reply-To: <20250707085201.1898818-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rogerq@kernel.org, horms@kernel.org,
 mwalle@kernel.org, jacob.e.keller@intel.com, jpanis@baylibre.com,
 s-vadapalli@ti.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Jul 2025 14:22:01 +0530 you wrote:
> While transitioning from netdev_alloc_ip_align() to build_skb(), memory
> for the "skb_shared_info" member of an "skb" was not allocated. Fix this
> by allocating "PAGE_SIZE" as the skb length, accounting for the packet
> length, headroom and tailroom, thereby including the required memory space
> for skb_shared_info.
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info
    https://git.kernel.org/netdev/net/c/02c4d6c26f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



