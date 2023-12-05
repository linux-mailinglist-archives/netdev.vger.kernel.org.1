Return-Path: <netdev+bounces-53730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89639804478
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B0B20C34
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8114433;
	Tue,  5 Dec 2023 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INdjCd2u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B63FE4
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BAFFC433CD;
	Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701742099;
	bh=HMwG43d889XcMV+jjmbOif7Ze0ji3fZ14zwvIe/4VZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INdjCd2uqwoBJoP57dg01wXamoAswVMWdjch7XahOTlF2Ng616xMqthVCUwUEmfgn
	 8NxE1OUTFzmjfhq6PNPX3SU05AsIOyrn2I9JSljbPWZxXLd6D+CxkjuzN6T7BX7oP+
	 DCGA5af9Xjm2SCdmGU6ZVU1E3cktU2c5CKA6LUf3QgixV80vz4UUAp7nftNXsaWqK4
	 /5+BHkPsJmYo/YJbGHY+CKkJEZQ0iogoK62j+eC1TXq7XGHJ2cVhXW3NAZj7QVGygz
	 +qn/4ekBM65mrDvqfwbj3vQi9T8RQrl0+DGQdNFr//hc5xjoGgnOgmE6JpxaqaH1l0
	 FSzegPvHSaQng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6657DDD4EEF;
	Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] arcnet: restoring support for multiple Sohard Arcnet cards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170174209941.18867.5676326878830949662.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 02:08:19 +0000
References: <20231130113503.6812-1-thomas.reichinger@sohard.de>
In-Reply-To: <20231130113503.6812-1-thomas.reichinger@sohard.de>
To: Thomas Reichinger <thomas.reichinger@sohard.de>
Cc: m.grzeschik@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 12:35:03 +0100 you wrote:
> Probe of Sohard Arcnet cards fails,
> if 2 or more cards are installed in a system.
> See kernel log:
> [    2.759203] arcnet: arcnet loaded
> [    2.763648] arcnet:com20020: COM20020 chipset support (by David Woodhouse et al.)
> [    2.770585] arcnet:com20020_pci: COM20020 PCI support
> [    2.772295] com20020 0000:02:00.0: enabling device (0000 -> 0003)
> [    2.772354] (unnamed net_device) (uninitialized): PLX-PCI Controls
> ...
> [    3.071301] com20020 0000:02:00.0 arc0-0 (uninitialized): PCI COM20020: station FFh found at F080h, IRQ 101.
> [    3.071305] com20020 0000:02:00.0 arc0-0 (uninitialized): Using CKP 64 - data rate 2.5 Mb/s
> [    3.071534] com20020 0000:07:00.0: enabling device (0000 -> 0003)
> [    3.071581] (unnamed net_device) (uninitialized): PLX-PCI Controls
> ...
> [    3.369501] com20020 0000:07:00.0: Led pci:green:tx:0-0 renamed to pci:green:tx:0-0_1 due to name collision
> [    3.369535] com20020 0000:07:00.0: Led pci:red:recon:0-0 renamed to pci:red:recon:0-0_1 due to name collision
> [    3.370586] com20020 0000:07:00.0 arc0-0 (uninitialized): PCI COM20020: station E1h found at C000h, IRQ 35.
> [    3.370589] com20020 0000:07:00.0 arc0-0 (uninitialized): Using CKP 64 - data rate 2.5 Mb/s
> [    3.370608] com20020: probe of 0000:07:00.0 failed with error -5
> 
> [...]

Here is the summary with links:
  - arcnet: restoring support for multiple Sohard Arcnet cards
    https://git.kernel.org/netdev/net/c/6b17a597fc2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



