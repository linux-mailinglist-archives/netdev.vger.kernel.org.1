Return-Path: <netdev+bounces-210169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9558B12396
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418D61C8315C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE628C877;
	Fri, 25 Jul 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdrlCXyl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484528AAE9;
	Fri, 25 Jul 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467003; cv=none; b=Kmft/XTpZh7LWcKiav9I9dFhSsdiN3J9paEauffgeTFCQGFb5DkYkWbvHpUI+M0cG0Za8NluAfxfjWFNnYJ0eJjCkhpD9ahW18S4QlEtLmmgvg8Nu2ML1E5hMWD7tQDrvZGw9iSMypBD29pORiFK0G/7A4C+24rcTymtfQXDH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467003; c=relaxed/simple;
	bh=QLYVPW9A57ubioy0Yqdy+BdFtYs4kXX7d17Vf6YqN10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WaCeToe75n/krJ5x3VpuSRdAtkOynqL4swcD/et6imxJinVGNQm1+jfw9VcKdP2/2UCp/dZAfy39OVySzdE8SF6hmHtNRpp8+JEjwqWTQIkSR3+p1C61gNi4EvtPAlH/OkHR9jrEc0l+XrQFfZCZVZqN0iG/V+Ch+xrpgqjYsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdrlCXyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A75C4CEE7;
	Fri, 25 Jul 2025 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467003;
	bh=QLYVPW9A57ubioy0Yqdy+BdFtYs4kXX7d17Vf6YqN10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdrlCXylaG7tkIbS82YOGv6O/PXKK9eoNKVI7KGDLuGPMXZh5CPI44N0dufbQ38Fh
	 qZMerbMeHQzt2sqcLHSf2Mkp6GLdIjE1HHxSQuDVaLLf1sStl6VOOlF2zBqAGQ8dP5
	 9AiGFA72+/7VAjpM2xJXice1GoO1cjUELwiPkhMDGklEVEacX6Nz+16+6kpWbw1bP/
	 StI1HZ20/EAGRp8dpHtRMKcpkB61l7dRvU9bpI8S6ufug9p5Q0Jud0HSLYo/FWcxK3
	 AfnB6nmjZUBTf0XNZ6FOnEIzxKItT5WWWFqTm/tDcwsaBgsZKWcsTyJqNymWLJWIL9
	 3ruTaF4VatCgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAA383BF5B;
	Fri, 25 Jul 2025 18:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] usbnet: Set duplex status to unknown in the absence of
 MII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346702056.3223523.12381590141591970711.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:10:20 +0000
References: <20250724013133.1645142-1-yicongsrfy@163.com>
In-Reply-To: <20250724013133.1645142-1-yicongsrfy@163.com>
To: None <yicongsrfy@163.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, andrew@lunn.ch, oneukum@suse.com,
 davem@davemloft.net, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 yicong@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 09:31:33 +0800 you wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> Currently, USB CDC devices that do not use MDIO to get link status have
> their duplex mode set to half-duplex by default. However, since the CDC
> specification does not define a duplex status, this can be misleading.
> 
> This patch changes the default to DUPLEX_UNKNOWN in the absence of MII,
> which more accurately reflects the state of the link and avoids implying
> an incorrect or error state.
> 
> [...]

Here is the summary with links:
  - [v2] usbnet: Set duplex status to unknown in the absence of MII
    https://git.kernel.org/netdev/net-next/c/a75afcd188e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



