Return-Path: <netdev+bounces-194221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3CAC7F66
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDCF7ABA07
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E990227E8E;
	Thu, 29 May 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN4a3muX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0C227E82;
	Thu, 29 May 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527196; cv=none; b=tsFpFz2JhdLZ5+Imb5ev1s+qUMc6eSAFXB2uD0qXoMsbpKH7XueKkBSjlSrEG/4bTlQ16GTNWLdnfV9nnlCHWdniYKJA1NbuqJF1/SZBwcyc3WANburYTr5E3ne6942MB8zahFu+mmWfEFaqJzFcDEs1MTBQtYgt/Pe/S4lPz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527196; c=relaxed/simple;
	bh=r0b1+y3vdwo65g0qxEBrgxzfef0IiHmph8xg0c/0v6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oeKPXnGEXBRuyeFxibwCI1wU8BXtbvmrTAt0wci3yr1djc9xideBnZ+T+KUCvWNTOZATnAu0Fk5770DRtyOHr+MP/sJ5pCIGz9K/iOSK5Bdq0iHjqX4oiuaTDm9pwFIAW+oZfhYULVBHXCNTdkp5kign/QKD+OigFJWEG5QPTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN4a3muX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75523C4CEE7;
	Thu, 29 May 2025 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748527195;
	bh=r0b1+y3vdwo65g0qxEBrgxzfef0IiHmph8xg0c/0v6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nN4a3muXqtndXSdwmPJquvbh7jXtnrrft4DbwHbY7KMReaDbfndzcsYngBRUyjnmP
	 Mw2P1XhY5GULPvlnONKygY6bMoWJlpcxaKvlWTvfu4VcKWV3NVRH1zSY/5JXpgjSif
	 D7fjvRnL0Ex2O79lE1hPMo9gYhJS8mieH7OkB7MeS/vS7eoc81uiuC6qnFDedIrODH
	 twf6WDXPAEQFcJivBfBYupM71U1MSiNK03w4skwehkSYkopSbP8P5CUZrDTrscYltK
	 T6WwVJOuMK6kbqifkArTnK2KeTo/r2ava4rPUo7jO8cyzYjAS1mYtIJ/9CVlWOzH8L
	 dVJr7Fpe2m8bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D46380664F;
	Thu, 29 May 2025 14:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: lan966x: Make sure to insert the vlan tags also
 in host mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174852722925.3275782.13189601985927931052.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 14:00:29 +0000
References: <20250528093619.3738998-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250528093619.3738998-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 May 2025 11:36:19 +0200 you wrote:
> When running these commands on DUT (and similar at the other end)
> ip link set dev eth0 up
> ip link add link eth0 name eth0.10 type vlan id 10
> ip addr add 10.0.0.1/24 dev eth0.10
> ip link set dev eth0.10 up
> ping 10.0.0.2
> 
> [...]

Here is the summary with links:
  - [net,v2] net: lan966x: Make sure to insert the vlan tags also in host mode
    https://git.kernel.org/netdev/net/c/27eab4c64423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



