Return-Path: <netdev+bounces-229007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD01BD6ED7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15581406E5C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BF29B79A;
	Tue, 14 Oct 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5xOFEzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8B29AAE3
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404254; cv=none; b=Co5G/VNsK744bLFzhrMPIDLwxiRvYVDDrbibac5Uy2W9PeWqSuiVhLS1lL+U77a6LmRBvDYa1Nl9driEEuc1eXV8GNHvAyw1eQYSEom8BlWZFzSrBEH4OKKh/p3TH+h7zGJ1tSim3DXaYV2P3NV6DTdFqrUt53C2gW5pO1u2FqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404254; c=relaxed/simple;
	bh=hVZxzFDv46b7VWHiXZ4hKTmr+XozCfjyuwqtMxH01Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DWq5i8lGbcUKJdET4fyHoe7geYjOUsV2B4SkL3278DpkqRIZtY1cHdh2k00BFBVyikv4dmrAAHMqz4185ZQ62LqwUk+x7GARd2LSZroZBkkJ3bsWi+qoxT/npk8K3zTxmfCehATyOq+C08wbl+mXmbM7EsexFGrRr2oo3/8lhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5xOFEzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C9C4CEE7;
	Tue, 14 Oct 2025 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404254;
	bh=hVZxzFDv46b7VWHiXZ4hKTmr+XozCfjyuwqtMxH01Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E5xOFEzOE1qDJ/qZ3mXQYaSsK4m3wwk89gK9/PYmUlwHJGQzFgIXXsMeAabeF1jBU
	 PfnswAmInKR7SfRgMgJD16+5TH+N71ixanMuJJSzokQBQFjxhMwx/ZV9CH2o5HF/51
	 L/4BdVZCN4uUFVKjZATJ4vm+pfWfopKrnxmnzk9CukcJTV+0nuYxLpldscYrjYmCw6
	 ip37JpYpNNaz6V4CHsdM8WLTNANTPwi00DrM6rSVP3FSDYk2kuNypwUBBiZcacT8dO
	 bIqnuae4UhXL5yp6/lsoiPVyoRUZNMdUdAESsp+iRkeJFATe/4ajLv1tInOWBUheaF
	 jnmSappMsJ+nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8C380A962;
	Tue, 14 Oct 2025 01:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net,PATCH] net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
 present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040423999.3390136.2244389961141829576.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:39 +0000
References: <20251011110309.12664-1-marek.vasut@mailbox.org>
In-Reply-To: <20251011110309.12664-1-marek.vasut@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
 daniel@makrotopia.org, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, markus.stockhausen@gmx.de, michael@fossekall.de,
 pabeni@redhat.com, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Oct 2025 13:02:49 +0200 you wrote:
> The driver is currently checking for PHYCR2 register presence in
> rtl8211f_config_init(), but it does so after accessing PHYCR2 to
> disable EEE. This was introduced in commit bfc17c165835 ("net:
> phy: realtek: disable PHY-mode EEE"). Move the PHYCR2 presence
> test before the EEE disablement and simplify the code.
> 
> Fixes: bfc17c165835 ("net: phy: realtek: disable PHY-mode EEE")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present
    https://git.kernel.org/netdev/net/c/2c67301584f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



