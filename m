Return-Path: <netdev+bounces-134451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D146C9999D5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8160D1F23D0D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC16EB4C;
	Fri, 11 Oct 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np+MWB0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B54EB51
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611430; cv=none; b=GH6t7/Z1CRwGWtAIK+32lsedPRsc2gIvCKq99GqzvfJORwMgJ56oftKrrV1/cJLHYkUkPZ7JHVkvfeApxpdiA6FHhtPiRUaFKlBLgG7/REgWjCUbC2P8FTK03kEHormsuu+n3JPgwTJLvJ/B6LcYXw387pI9bls/eCq+gcM9quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611430; c=relaxed/simple;
	bh=mv4FUulMeZI1auucEA1JpFkk+mD0j3DMn/MBleOZzFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PcnurEYlFxiRtH7+znT/3DhkP581JXhsnhg+HIgnLN4I9aomu9YVglFwRZi3IPmQD64qA2lQUM471h4vM3g/KGO5cwWbgwJfTeAE5GeBV929AuUTEa/AEalUwweFELXkFobSGZbITkMUfdT3Bo7dJhxV7q+gwAmE4/8882fG2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np+MWB0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7219C4CED0;
	Fri, 11 Oct 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728611429;
	bh=mv4FUulMeZI1auucEA1JpFkk+mD0j3DMn/MBleOZzFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=np+MWB0kYreBHIFpTUpDJ7l6WlVqp0gb/OrnMsXKyFC5TQ3zQM3fydQF7AGo78ULf
	 DTrulA5R+Ns+tT0Rv8+EpSqPOX6h6oPNzrBPF8rB7bUv07zdTVBjZtTUkIA4c2pep9
	 Y9EUfXdTpNf2citzf2w9+VMGn317SzgH1R37yRgacfgMCa2zSFfC1wH+zbcg9FvuZH
	 2OPJrPOsTLOLS0sLoeCk+Alvi/K1gbuEcHRHoWuy46aFOfltWBB/QoSYaqNXDfx7Wm
	 wMDJYCaL+BlKdhvLqOicTFQbF+7dEqti3SbNdURNwgs2SWV5wD9SLZGNYjDZ7TQupo
	 JuqDjSkug3y/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE73803263;
	Fri, 11 Oct 2024 01:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: don't apply UDP padding quirk on RTL8126A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861143423.2243561.13870359304688128206.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 01:50:34 +0000
References: <d1317187-aa81-4a69-b831-678436e4de62@gmail.com>
In-Reply-To: <d1317187-aa81-4a69-b831-678436e4de62@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Oct 2024 07:44:23 +0200 you wrote:
> Vendor drivers r8125/r8126 indicate that this quirk isn't needed
> any longer for RTL8126A. Mimic this in r8169.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] r8169: don't apply UDP padding quirk on RTL8126A
    https://git.kernel.org/netdev/net-next/c/87e26448dbda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



