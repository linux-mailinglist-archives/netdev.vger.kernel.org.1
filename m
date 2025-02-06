Return-Path: <netdev+bounces-163319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82CA29EAD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE9D188905D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EC6BB5B;
	Thu,  6 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2zSsdt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16F2E62B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808411; cv=none; b=hdiBwJFfdsRCzce06tHV0z6F0PPwZUokkagQZMTO9Hnayv15M1DEEMCogV2tfHJVz4K4hOrJUUKHuM6zeoAaIoxawVNoUxE0/4yQjRAAq+nKz4y7O6wLSrwq/ozu+aUnUoXtngqJfMhM/gi1oilnrifheklafGKqJCLt5ePGX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808411; c=relaxed/simple;
	bh=gyMnmLLanWfclikVa/nrROvcFXAF6gt91ChScQZU6ZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FBG417sjGnb4yI6mnEGJFji49/4QvkKjFP8N/Z3OSYR0BR6xDXY91mqZXg/VhM2WVcwUJhzkrGsOzq1JBJpGUnZmkB/bDMwR4r+Aq8Dn2fxIonKeyBNN5fO05zgmgyKsV+eHaXUKR7Nt1pm14F8M37H4gJkMpHrg3GwIHTlthho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2zSsdt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AE2C4CED1;
	Thu,  6 Feb 2025 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738808410;
	bh=gyMnmLLanWfclikVa/nrROvcFXAF6gt91ChScQZU6ZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k2zSsdt1OmWIYp2xK1+mVxjUGUUYiFX4Ddik18+CelA1Gmgl2V34EW/YyotztvYuZ
	 d9AC4n+agqY0Eq41Xfcd3+2FagmSD9OwrOuPpuGEdTEFE2Xgwjf2jMhRsaMKBO/8jY
	 goS/JJCr35qZoKEpjtGoxiWN1M5NTmJK5PZkHGPgo9gY1e5qDQRnJ66yDyRECpsBvs
	 ucsncAvAJ7KSfbIyUnnPAGolszftN85KmXIz9iBu6oyJbAhbaFeS4PDpqiyWEOtlkG
	 El97g3NLtrBSsAtiyB1TRIk/Iq4A3gXEIBKNLuQaNPc4OX+uvakgqfrzDr65nPf9pI
	 7apRrr3W3GaHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF4CE380AAD0;
	Thu,  6 Feb 2025 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net-sysfs: remove the
 rtnl_trylock/restart_syscall construction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880843824.974883.529007615837841136.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:20:38 +0000
References: <20250204170314.146022-1-atenart@kernel.org>
In-Reply-To: <20250204170314.146022-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, stephen@networkplumber.org, gregkh@linuxfoundation.org,
 maxime.chevallier@bootlin.com, christophe.leroy@csgroup.eu,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 18:03:09 +0100 you wrote:
> Hi,
> 
> The series initially aimed at improving spins (and thus delays) while
> accessing net sysfs under rtnl lock contention[1]. The culprit was the
> trylock/restart_syscall constructions. There wasn't much interest at the
> time but it got traction recently for other reasons (lowering the rtnl
> lock pressure).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net-sysfs: remove rtnl_trylock from device attributes
    https://git.kernel.org/netdev/net-next/c/79c61899b5ee
  - [net-next,v2,2/4] net-sysfs: move queue attribute groups outside the default groups
    https://git.kernel.org/netdev/net-next/c/b7ecc1de51ca
  - [net-next,v2,3/4] net-sysfs: prevent uncleared queues from being re-added
    https://git.kernel.org/netdev/net-next/c/7e54f85c6082
  - [net-next,v2,4/4] net-sysfs: remove rtnl_trylock from queue attributes
    https://git.kernel.org/netdev/net-next/c/b0b6fcfa6ad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



