Return-Path: <netdev+bounces-53741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4880451A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3E21C20BAE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810C20E8;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG7pXZNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242CCA63
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 531B8C433CA;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701744025;
	bh=7qPKJ3S8i489bnlJf7/hjHyGn4ZzVXxeyHWMQ4xpB9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG7pXZNZFIrMvULwRVn7OecljZ6pHpBXbJVi8D3HPtCieQXObKyz7G1D4BtAlcVNl
	 JapKceXN0Nfyk7jz1QPw9H/WFmNAwOhDGGOWyPE+Bl6boUvOyTVJVw69WDbDJWYANE
	 oSG1pvF+Si2GOFb2pCVkCX/niRgDMXIBIErbis2orwx4QSCy6QkGi3B/QJ19IR9BSZ
	 dUOqRXdQZquGaRBOEAystgW+dzDVL2d1EsGFiZpJV58Jp3nVzwOs0GH0Fniu5i8pl5
	 Mfu8WfNCOuYj7A4ruEaOrVxbXzcGMO0F+ACzfa0xUvhV9eC/D7IWxx0NoGRi28Dw+S
	 bwjPdUzaizKCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E8DDDD4EF1;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: stmmac: fix FPE events losing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170174402518.31470.16495979069997859149.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 02:40:25 +0000
References: <CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc: alexandre.torgue@foss.st.com, Jose.Abreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, horms@kernel.org, ahalaney@redhat.com,
 bartosz.golaszewski@linaro.org, shenwei.wang@nxp.com, j.zink@pengutronix.de,
 rmk+kernel@armlinux.org.uk, jh@henneberg-systemdesign.com,
 weifeng.voon@intel.com, mohammad.athari.ismail@intel.com,
 boon.leong.ong@intel.com, tee.min.tan@intel.com, James.Li1@synopsys.com,
 Martin.McKenny@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 03:22:03 +0000 you wrote:
> The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
> handler missing FPE event status and leads to FPE handshaking failure and
> retries.
> To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> MAC_FPE_CTRL_STS in those methods.
> 
> [...]

Here is the summary with links:
  - [v4] net: stmmac: fix FPE events losing
    https://git.kernel.org/netdev/net/c/37e4b8df27bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



