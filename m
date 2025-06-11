Return-Path: <netdev+bounces-196562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4EAD5515
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785F91887E42
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158A27D76E;
	Wed, 11 Jun 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU5Ru9t5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F427815E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643801; cv=none; b=V35I/Sb6m0dq3NFRWyM7BpRUFu9cxlrKuNQM9GhJq7OKgs3lc+2CIoU+MIslT4yqBerGdJBI1Oh0+F4LbJ/Z1Or6Rg95ofyP2lJhGpfDZihsmxLOmpASJEpo30fCeaVeQaWIPxC9Vm8/gjvvqXqONesooM3SfBsOY5jA3ssLMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643801; c=relaxed/simple;
	bh=Xna2gmG9gLc4m4opS4DDS+YWVskCTk2Y/FJFVP9RVPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nuqUxDLSw90v9RD06qj39o0cnX6MbPcxkzJZWW3OJzp119IzaCy4Pzj7ajfiBHs5ySnko2S4vYxiP1axlg682IxR/Xac11ZlRv0eaw7Y9F2PxI+D3BAPdEn1BkFKc+ZZraqlLKf1s0Hloi91vhqECPUKU0EWdJ/AYEVX9W+DBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU5Ru9t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2208C4CEEE;
	Wed, 11 Jun 2025 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749643800;
	bh=Xna2gmG9gLc4m4opS4DDS+YWVskCTk2Y/FJFVP9RVPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aU5Ru9t5dadES3yV0cUVSzGsqZKnNLnHhpdqg6R6VVIvbxjmCfhbnq5VLNTn9tMhn
	 Lrzn5UHE6RC42SM0RmzwVkgVuK30gff12KOc0OmGtBjTUaM5LSDxt4Rh2b1aOBYnMb
	 Jb00MDYf42g+rVHNufZv5mKzmoFYND1RuEyELDbviQuFsyh41+2tHueSaZAnvvntPu
	 ytwbXPv7gBNYnUSj62y0DE235uuuI8bvfFchzmeqXN4uCh9ImiWeYLFtcs+TcXDIKk
	 dLuqrN84TLVWWVkLU3C8Y5TKxe7bXelKVVlg9VYp9HNqj1n941c0LL4sDEP8/dEIGX
	 jx7Bm3BTGm9VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7339EFFC5;
	Wed, 11 Jun 2025 12:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174964383100.3294450.3135324219520894757.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 12:10:31 +0000
References: <20250609153147.1435432-1-j.raczynski@samsung.com>
In-Reply-To: <20250609153147.1435432-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 netdev@vger.kernel.org, wenjing.shan@samsung.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Jun 2025 17:31:46 +0200 you wrote:
> When using publicly available tools like 'mdio-tools' to read/write data
> from/to network interface and its PHY via mdiobus, there is no verification of
> parameters passed to the ioctl and it accepts any mdio address.
> Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
> but it is possible to pass higher value than that via ioctl.
> While read/write operation should generally fail in this case,
> mdiobus provides stats array, where wrong address may allow out-of-bounds
> read/write.
> 
> [...]

Here is the summary with links:
  - [1/2] net/mdiobus: Fix potential out-of-bounds read/write access
    https://git.kernel.org/netdev/net/c/0e629694126c
  - [2/2] net/mdiobus: Fix potential out-of-bounds clause 45 read/write access
    https://git.kernel.org/netdev/net/c/260388f79e94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



