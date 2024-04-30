Return-Path: <netdev+bounces-92308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCB8B67EB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8123C1F22F3D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18FEC13C;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVsMtw17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3908F6D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=i68ilR3y1DMxWbuTCj1Fd48juJ0E4Z2+C+w2FpIsbfjQbCsYDRjAueg4IlaRs5qIKdzPS0gCF9Ch2tJX6KNszHuUTraU43mgvMgCZC9tkpqEGc5yseBQFmP/q2KQWBqIxp3hFJ5hQcdWuFawHHRCKnOF0Dhz4RfbV6v6t14RIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=4PN09eJ9U+1o0cfvLRn2Av3etzlS6zvZd6ETeobe8Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwkNkfbI6GOfunGZ54mxGJZUpG/+d6u9he/JronXJWZsBXZrQxJDIyVyyvJEqZA5qxE97DORdGtYj2Gow94m0/Z96uQU2npMS+SnijBcPm0xppWWaokPxE+Ynp3HaITp6olgrp22E1Kea/moE34YLc8bxxBP3Rr84M/qYhWv6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVsMtw17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A202C4AF4D;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=4PN09eJ9U+1o0cfvLRn2Av3etzlS6zvZd6ETeobe8Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVsMtw17bOqxK86HgylHK4JTbUdXRKPsCzXqXtU7H5rtJ0iTNcfznpCiIQT7+D3Ny
	 EZ1VgHFwjT7rnh7V2lrECQDb1ylOYQ3YgpGDg2r2+i/DGYJCh+X+b7Nyytxer9ainy
	 pleqkLydnD6w+s61j+DpHPDKeI87FkJl5uVDUS8Kiz2OKDWCx2CV3JhZly81zpFFyB
	 8smN2PqkYseCYgNwYjKX7FEYNOCZnFkYpY3PeqayjYrq3FGrNK8NUmr7O0/w9198H3
	 KnCO7nkBvEsRAZ/HcRn44T6vG2Aa5/2V8hJMcQE7FN6cLZ8RYM78syFQVAcVU24F4r
	 pcFdcWcL/9BnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49041C43613;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvneta: use phylink_pcs_change() to report PCS
 link change events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363229.30384.18345128085879171428.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <E1s0OGs-009hgl-Jg@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s0OGs-009hgl-Jg@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 17:17:58 +0100 you wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mvneta: use phylink_pcs_change() to report PCS link change events
    https://git.kernel.org/netdev/net-next/c/21c8e45acbdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



