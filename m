Return-Path: <netdev+bounces-116920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C354794C173
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAEF2843B7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7318EFF5;
	Thu,  8 Aug 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc9N0dHp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4818EFF1
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131068; cv=none; b=B+f2OigxTfrnfjA5qzfuMzEeu6CG1k/PJqz/1tYBPAqachdH/q+tL6dNvC8Uw9pKRGlaeikYR6NQiAeb2qZpqJPg4OPTtada1fnNalwLwaqAyzwRjgh9UbdDDaWttVHSFBhbOwjoIRR0J/K+bPshniHkb8VfzQqjlP6X9VtskOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131068; c=relaxed/simple;
	bh=b0Ntq0hiv6W5Rugq26Zm2PR/moZySDGj4O+rKgORl8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OXERAbGiaxDhSotWW2dXb+BckruiQMT9rtO2GTfeJghjvzHCseZSS0St8iVxsXbw8ejbqgVMKTiDYFU6SEcpVJNK9E2gOjDtIYaKgLrPkRqAeBgIxag2p7GBxa7+tA9gWMCFUOnex94orifVgrUFu0o4gGxpxLkrbT9jnHmw9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc9N0dHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D651CC4AF09;
	Thu,  8 Aug 2024 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131067;
	bh=b0Ntq0hiv6W5Rugq26Zm2PR/moZySDGj4O+rKgORl8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bc9N0dHp0jJTNA2iOOPjgk30YQW1YvwhPsc/Om5L24Vsy3SQzGKPU/YQcpNh3tdH5
	 P3BPnKX9H70c/TzkHqN+CBH3OSaMvvo0RbItD/GbvD7arNwnDNj84Q1intGI9MM4fX
	 ubK3V1GCf+b1ESczHosyptH0pgmuKS2x2qn7xlIbkRnOKWkm3QWPy5ptL00Q9DTWzX
	 PnZEvR24kYYSd1MgCXqkGNizzxEOS7GKhusTwFYxbUY4RxXxWcuPSCmoribtJUQY+L
	 KvOO/FeCvT1kki5u6so9b3o6T0GJV5p2dYq7lSfJU78ltMuf2hg2G3atPs5EiiwsrN
	 yjJJ23NdfKOIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B9382336A;
	Thu,  8 Aug 2024 15:31:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: dwmac4: fix PCS duplex mode decode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313106649.3210703.16681223591090496086.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 15:31:06 +0000
References: <E1sbJvd-001rGD-E3@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1sbJvd-001rGD-E3@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 peppe.cavallaro@st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Aug 2024 14:08:41 +0100 you wrote:
> dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> 
> Fixes: 70523e639bf8c ("drivers: net: stmmac: reworking the PCS code.")
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: dwmac4: fix PCS duplex mode decode
    https://git.kernel.org/netdev/net/c/85ba108a529d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



