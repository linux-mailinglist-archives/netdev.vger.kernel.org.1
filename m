Return-Path: <netdev+bounces-201373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59609AE9379
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7421C404C3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663515539A;
	Thu, 26 Jun 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRtBRQt3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174512C544;
	Thu, 26 Jun 2025 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898982; cv=none; b=U9do7fw8HIv91yULeHuvYuQTspWy+uT3FFjBN1KYJk1B07ndP6nvEQWLnsA4q3wmU+UJ+K+I/Mtz/BNXkX94oTah1/+/H6sh2hIrbQrD5XoZB/9ic2j0GtmO/6mRK0yXsXlZstDK9X3Fph+lTmJF/tKZiKzzyC8ERGiz6thZBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898982; c=relaxed/simple;
	bh=1bZNUVkfTdPVMi2sk2zKTqYBof6VwPJKGQKafr4v3ZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lk8Ny0MLvlNPFzJLRGBb/TXl/8frjrnoMjgGcRrL19lBsZs7p+zf0TVd/qFiI4CXUABYO5tliqssbpfJ8ymHOi0b8Aen/tWW9wXTp+PLk1KvMykycnJyg4UlZmbCLOkhH7YyPYcKkdxFYLTEWk+fUCExjO+Ri2hyBJ8tHWrBbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRtBRQt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3D1C4CEEA;
	Thu, 26 Jun 2025 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750898981;
	bh=1bZNUVkfTdPVMi2sk2zKTqYBof6VwPJKGQKafr4v3ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BRtBRQt3xNUQh4hPPq4hYuuH3MhNaXbS8FtDZN+s7b+TI023C97yWwswopeo8Q5OJ
	 RpJnwa3dDZCpanAmI38OBK7uXfoGzT0JLmCJfw074ZDsaG83FlSmcNnwM2211HrzCC
	 TMCE/JGeeb2V6NJqU7UOYuBtwFAJx1AIW+p7d/WoeuWmnBPaHKnYvO3aQUzUAekQlV
	 hNlbz1jq4oCi28Rh4exiWsIHnVJ42D++H51j9mC8yVEW0eQux9clADBsTzMKEiFiCD
	 Knf1dOnmCRcH38wMUI5EtfAR+yr3YF+mp2C/OTY7kMdR2gVDLsThrbcti8kRnvm/0r
	 z70a/XZnupiwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1B3A40FCB;
	Thu, 26 Jun 2025 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Reoder rxq_idx check in
  __net_mp_open_rxq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089900800.676531.3267976147463501284.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 00:50:08 +0000
References: <20250624140159.3929503-1-yuehaibing@huawei.com>
In-Reply-To: <20250624140159.3929503-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 22:01:59 +0800 you wrote:
> array_index_nospec() clamp the rxq_idx within the range of
> [0, dev->real_num_rx_queues), move the check before it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/core/netdev_rx_queue.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: Reoder rxq_idx check in __net_mp_open_rxq()
    https://git.kernel.org/netdev/net-next/c/f6fa45d67e05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



