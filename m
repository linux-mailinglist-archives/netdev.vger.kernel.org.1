Return-Path: <netdev+bounces-166173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAEA34D2F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A45C7A142C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2F245AF6;
	Thu, 13 Feb 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvR7QEeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388E245AE4;
	Thu, 13 Feb 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470208; cv=none; b=pGK2rWZbalOSNaCRatjenWOlkaE2AVgw0yA67wbU+1PuYeNafeVPaqW/tuz+9G7IYsy/Q3ch72pYYynfoSxOusLEXg4Lz2UQS8bc+6kWDHGKQ64ND4OY4r64wKV2Di3L63r9dOFoAhlj8HZdl+4skPm4vBB9ch/oybW5kQsJ/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470208; c=relaxed/simple;
	bh=zjC3cx+p6X+Idtcj9LgZW2aXbAComDDZDka8d31rcXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jaYWAGRcKijeBVyUpuNXJ/hbupQTka+VKWCJgBRqKRnac/AmQTNJi+4dn3qhxY+Uad7iqwS0NvT/ncRcGiOYCe8+6FjgeI2nkHM+huaCEfRpki4eCQ99Ym2+VWIdssdklNkpxB++trEyhbQT69Vejww1C9fCw8awGNr7Uu2j+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvR7QEeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83438C19422;
	Thu, 13 Feb 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470207;
	bh=zjC3cx+p6X+Idtcj9LgZW2aXbAComDDZDka8d31rcXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvR7QEeYHpsk4yiJH0W+k621HKfNMWh4iFw5IJcNFM0ODcU65OA+mFYGrTHqZ3vdH
	 OIWENI5CjNtrIFUD8XFkH57I+sQFoO55pSNycTG9BfLtkO/8KMxYbkZ5UjHIDUua9e
	 XwqFUIesIxhOZUtr/GxCASCaSoSPPE4CK8CHV9SOIpAYY5DDS6cb1uwdsfQpiCveEq
	 1LgFZqwJMSbQ5MgZIuJtma/EJWNAXB07i8cbuzpQn21qi7prSTb2w4DOFqa0woovCQ
	 kOdqzJrW4cDLfAixj/m90vbu5ZLGm8T1TzyVF/sOvMAjOBaT3fY2V8Mg1ayqSNhH27
	 tolP2w4M8IHEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB545380CEEF;
	Thu, 13 Feb 2025 18:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: Fix deadlock in current limit functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173947023650.1322759.9682637236707051742.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:10:36 +0000
References: <20250212151751.1515008-1-kory.maincent@bootlin.com>
In-Reply-To: <20250212151751.1515008-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: pabeni@redhat.com, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 16:17:51 +0100 you wrote:
> Fix a deadlock in pse_pi_get_current_limit and pse_pi_set_current_limit
> caused by consecutive mutex_lock calls. One in the function itself and
> another in pse_pi_get_voltage.
> 
> Resolve the issue by using the unlocked version of pse_pi_get_voltage
> instead.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: Fix deadlock in current limit functions
    https://git.kernel.org/netdev/net/c/488fb6effe03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



