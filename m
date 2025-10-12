Return-Path: <netdev+bounces-228640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D05BD087B
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268A03BA2DC
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4129405;
	Sun, 12 Oct 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlnSJSnn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE501CA84
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290220; cv=none; b=Ia6g7XWzP0TqLHmjjhlWJrfO4MR0mJqcDw63eDWYjTvf+XKcywuMSex6cNTPeX5M05rBOEga6C4wi8YoPCKdR7o9KjGpD13WuB/eN/L9o6Az3rXk390x7Q2x4stxPxpZx2dMiO6LjaqoP7Lyge778YJpOozc6MwrfQ5uXvX10XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290220; c=relaxed/simple;
	bh=P1HwP/Fb9RkqCJbBLA1lnCoPo9BNl8lS8geUgz4BCRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rtxqj5qKaGl0JwEZP2/2GS1Wd0+6ZIaf4wGg+ehRJROB2iz7IMjPakTo0/0bs2iTCXxpIInH1L5tkmSVnK2eiBahvXvos0orTQ8kKbHxA8820dQjYf8xast0Uxt6jFA/mu8OcNOJMyBmFOocs2wFD1QCL93+Upuqro9Cs7msjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlnSJSnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE140C4CEE7;
	Sun, 12 Oct 2025 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760290219;
	bh=P1HwP/Fb9RkqCJbBLA1lnCoPo9BNl8lS8geUgz4BCRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlnSJSnnc13aXhV8wwyqyi43nAQ3XBVqHH7ynzmy9lzbgUEWP7meZk8YmzBmihcO/
	 O6HeuopMZyIzqDCMZ7aaHMMClkGOuT+241GgWFcxCTDPbWpfIMe9dbvkHLypbqtaEn
	 aIDRKH1NJQ+cb3nKnzJ/CNUUmgJQrG5tGzQS66wNfaglDpq+IB8oEqxRAu2IerkIsi
	 svpdoslXZmZVzy9x0k5RQrCiuP/3PemMhxvLjXG2HmPBXrGCOvkGLkd+RPftRt1vpJ
	 ghIsc9VuFZ1nRLtZ673aDiHYaGEFPN6Ks4KUuN3u/njV5gVYBWWN2owmi8G2DZo5xi
	 1b5Kd553GYjbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAD3809A1C;
	Sun, 12 Oct 2025 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mtk: wed: add dma mask limitation and
 GFP_DMA32 for device with more than 4GB DRAM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176029020625.1704433.18289911461490913074.git-patchwork-notify@kernel.org>
Date: Sun, 12 Oct 2025 17:30:06 +0000
References: <20251009-wed-4g-ram-limitation-v2-1-c0ca75b26a29@kernel.org>
In-Reply-To: <20251009-wed-4g-ram-limitation-v2-1-c0ca75b26a29@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 rex.lu@mediatek.com, pawlik.dan@gmail.com, teknoraver@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 09 Oct 2025 08:29:34 +0200 you wrote:
> From: Rex Lu <rex.lu@mediatek.com>
> 
> Limit tx/rx buffer address to 32-bit address space for board with more
> than 4GB DRAM.
> 
> Fixes: 804775dfc2885 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
> Fixes: 6757d345dd7db ("net: ethernet: mtk_wed: introduce hw_rro support for MT7988")
> Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
> Tested-by: Matteo Croce <teknoraver@meta.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mtk: wed: add dma mask limitation and GFP_DMA32 for device with more than 4GB DRAM
    https://git.kernel.org/netdev/net/c/3abc0e55ea1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



