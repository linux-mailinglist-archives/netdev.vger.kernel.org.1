Return-Path: <netdev+bounces-113127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9D93CB41
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8020281F28
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F214387B;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAjyYqNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4513CFBB
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950233; cv=none; b=ToD5tYalOomerY15PNdkHyCrMaUlCMUnvekyEgIvDyMZZ8ZO4LWbivCHcOCIgOQ9zy5Ez8X8xe37zcWEmZICs5D9DfmtJjWftDrKGG0jE+IuKACdiTzkFsQU8K8gvxAUN5SVEzeFqaOFemL026vJ2/xcyGGg4Bh2CkC8x/8frfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950233; c=relaxed/simple;
	bh=RbNMwLG4GM9J+0jlXVKMcsVYZkHH5qo55nIjk8/2OGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOTJdTRViQ1qcPeDgEogtCX/wMJXjDCtqOay0rSqyy1hga+ctqEiXHKiG36DfrwkfjfXHXsznApO0AZG4AOzl53XMhuoLfuBVdcSv3OEtTg70dfD5N2FcloVuy5Xu7CmuzOvtOTuj4TzMzFwSTZIXHCFAfjWYh9AyO01LG2PFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAjyYqNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37825C4AF0C;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721950233;
	bh=RbNMwLG4GM9J+0jlXVKMcsVYZkHH5qo55nIjk8/2OGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SAjyYqNgDUtHHe/PptPKMQsGaEeqUkD+kdVvjBNHomiwXBPKpFg0Ug7oFUESTObmD
	 GGgh76dB+LEynvUhEMqKPNJ+7Fr/DjM1d3LDWHbkeBNU9tfmJueAL3N8gm9mjlR3Nb
	 YQYhuFgPvPGOtXarHO/OrmZcIWC0R8p8lqqcs2YVkZwBI2TO3obYukk9oXYzkBcf5z
	 O/JxjfG+IUwcGSy+SvkZZXT0vtENrNbcYe2miqGZgRY7yVLDOAdK1qVzG9QE4plC0Z
	 Don8eeNEAqxTVyGYvoShHQnq260iF6j1HmJe/D7o/mYLU0C5uE5Hv57QrcE8H0qG/w
	 vDVO89psvuHyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 267E9C43638;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172195023315.25262.12343985900887431574.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 23:30:33 +0000
References: <20240724222106.147744-1-michael.chan@broadcom.com>
In-Reply-To: <20240724222106.147744-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jul 2024 15:21:06 -0700 you wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> In __bnxt_reserve_rings(), the existing code unconditionally sets the
> default RSS indirection table to default if netif_is_rxfh_configured()
> returns false.  This used to be correct before we added RSS contexts
> support.  For example, if the user is changing the number of ethtool
> channels, we will enter this path to reserve the new number of rings.
> We will then set the RSS indirection table to default to cover the new
> number of rings if netif_is_rxfh_configured() is false.
> 
> [...]

Here is the summary with links:
  - bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
    https://git.kernel.org/netdev/net/c/98ba1d931f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



