Return-Path: <netdev+bounces-213619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E7B25E6F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CB817CA78
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AA2E717D;
	Thu, 14 Aug 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBeMTkpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41A27587D;
	Thu, 14 Aug 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158998; cv=none; b=LfaOFGv75NPMkTVb5tdBnHBShjHWoi0dyLF486W6UE8uTurJC4rRuEunCB7zl5FtzL9TfYLumBzBEPawgWS9HDjCdusGcrN6cEI55qwYoX0BK9ActBuUhyjAcKRIk+ZiIIgHav7MBv1p2tByLPKjuyEVYLY4/6ogdZn/ybGZdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158998; c=relaxed/simple;
	bh=kRPvWk3+oRUyAKWoxWpoP6qQ6GBUxFbJ97WPacEf5u0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bv7lkE0awBZ8qbpGneErpQkErjUwNa9IRBFlWPfG6WlsItM6C3fFQG7Ls31FedHIpNf8SVwj69d8necf7zxFj2tQG8G9K2hyKLH+Eungk2S06UEJRh/E7e2ZBFBhC86EC2/6ZATOuDyt2jbeDM5bQUMy+nsW8aW9HbsPmkPDltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBeMTkpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35B7C4CEEF;
	Thu, 14 Aug 2025 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158998;
	bh=kRPvWk3+oRUyAKWoxWpoP6qQ6GBUxFbJ97WPacEf5u0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sBeMTkpNRQ5SMWT7ZAp2DlQx+p1b5GxjQ90xd+qujp2z88tZSe1o1w66tYD0np7E6
	 xxgEHQ8N7dm0c6d+68JcHimSbYXP0rKMj+ijzqWbiCZDMHMQ28Uh2TdmDM+enwXKX2
	 ZtNzViLBtn4w3fKFgYXQ6zdEg0oCxvDSDM6dQZnrKJAKKc160kIvMNkQXFcD2iEUkr
	 8P4kbIf5GMil5bQAmtAfLNEp7pkxuyp51dLxlo3Awq1ylfOd/4I7lyXhEyRzdBj7+S
	 VA893SUFzYMiC7IZfc9r6HvKfLpmPemjVQ3PldDqIUN9LZJZ8+Im90gb2QgJ6cDI68
	 M3D5ZMBhGDymQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC239D0C3A;
	Thu, 14 Aug 2025 08:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: cadence: macb: convert from round_rate() to
 determine_rate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175515900950.181378.1619500424714699903.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 08:10:09 +0000
References: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
In-Reply-To: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
To: Brian Masney <bmasney@redhat.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paul.walmsley@sifive.com,
 samuel.holland@sifive.com, mripard@kernel.org, sboyd@kernel.org,
 linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 10 Aug 2025 18:24:14 -0400 you wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate().
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
> 
> [...]

Here is the summary with links:
  - net: cadence: macb: convert from round_rate() to determine_rate()
    https://git.kernel.org/netdev/net-next/c/40e819747b45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



