Return-Path: <netdev+bounces-212740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE6B21B8E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65EFB4E2F08
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC112E3380;
	Tue, 12 Aug 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqFUv+h5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF82DE709
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968803; cv=none; b=eLL4f6YBDPLZyDxN/yc7FwKjQyxdMrwUJzz5mAkbYMkb152KOyTPT6C6BhqlEI9fvzb4jMucaXVwojuye/Ie4jUHEV8REPFvXmBUxu1rjjobTIqT0Q3XHDTaP9ogR0SdX690U4T0EOZb0xUpKcxcosBQM72f+ONCYS4BkAfwy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968803; c=relaxed/simple;
	bh=RWpIXohTMH+rLKlU0Q9IIWKlNizcxyUtaCMlb8/X/T8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sa8RoZFCjRqb/USxlZ7NCplQ3cAKcppSB7ikn2LoKtNcZBSMl3078mVd33Tnjg6ZNLjKIwsrJ4GP7hgWO5mHGXcYzg56DRP028GRjVO9KlVkTp9aKC+0vc99wwPr35LnSRR4aOAOOnHlBgEMPkPnE2G6O+hKSP4S2SaAN2AE2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqFUv+h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E46C4CEED;
	Tue, 12 Aug 2025 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968803;
	bh=RWpIXohTMH+rLKlU0Q9IIWKlNizcxyUtaCMlb8/X/T8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rqFUv+h5p7BXqG3wQRl3h/371b7LINHtZlFCII5AQOTSMSulDHuS4n8THBqaQcYTA
	 l9D02iS++8PHE1T5DXed3WzUWVTkFwHgx6SxKbFBNLTtuwhQOyVriEhttuZqpPJdmv
	 F23LAkqJgDr14mkenFPkbGXYo+bNxbtBsUcWek5DL1xXDFOOlv5zqpoWMYMIM4qmmR
	 ou0iSlbKjKvG81PohbYBpSpBkJZbYC1Ld2xc0NZtGNtYjauu3MpJtBvh4e5w+NIb+R
	 cZ7N/WScjyocPXu0D1fk4X2FJ4n6LOhSUMR35+dqyfoSB/IDtUHVmFX6DvZI5zP9tw
	 4wA6cUelkgrUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C04383BF51;
	Tue, 12 Aug 2025 03:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwc-qos: fix clk prepare/enable leak on
 probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881499.1990527.15915957162598750086.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:14 +0000
References: <E1ukM1X-0086qu-Td@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ukM1X-0086qu-Td@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, jonathanh@nvidia.com,
 treding@nvidia.com, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 13:16:39 +0100 you wrote:
> dwc_eth_dwmac_probe() gets bulk clocks, and then prepares and enables
> them. Unfortunately, if dwc_eth_dwmac_config_dt() or stmmac_dvr_probe()
> fail, we leave the clocks prepared and enabled. Fix this by using
> devm_clk_bulk_get_all_enabled() to combine the steps and provide devm
> based release of the prepare and enable state.
> 
> This also fixes a similar leakin dwc_eth_dwmac_remove() which wasn't
> correctly retrieving the struct plat_stmmacenet_data. This becomes
> unnecessary.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwc-qos: fix clk prepare/enable leak on probe failure
    https://git.kernel.org/netdev/net/c/89886abd0734

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



