Return-Path: <netdev+bounces-101162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A568FD915
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258BD28B1BC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD88169AFB;
	Wed,  5 Jun 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul/9h/V1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29615169AE1
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623033; cv=none; b=pCRkvogtSGDf8eAlbA/F1jGHDsD8ljwt3Q7TzUEz1amXA7lJ4b/Oy494qDYaDzFzcGtcDHGLjQU7tC3XtqbFdpl/B3DmD9mIJCba14zhgjF1hMHH+qJ0B6yUS0jPgY4rsT4s9Nwp/y0Hnt3cVFZaJqQfiGX1tP9aeXFnWXWBBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623033; c=relaxed/simple;
	bh=TwljzjIRxQ/FtrM9SO2gW06EXoFqZapa5mp75LoYlkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svAS+j79kFuZhJN3Ia7106czEukoueNOheN19zFCdaCssHEsBZfd4wkPjeuqI74nbBGODxMAqsmoFv+ezCDzsWCy+2bGpuOzenLxAaxUWjZNqDbUrgLERErGl2/ItsX1o3R6SwETz2+TzM+wIME+9GA03AEUkgyVeqTfLcgey/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul/9h/V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0549C4AF0C;
	Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623031;
	bh=TwljzjIRxQ/FtrM9SO2gW06EXoFqZapa5mp75LoYlkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ul/9h/V1JT34QNSyFH+4UBWsZkMPBvudleEjQWer6yRIqtEDC0Uk8AH0fAbevkkFL
	 9QCiYJntreosFIW+97vcrrwSZz8+VnPPq4GL4PBOOLWza9b+/ANscGtJLIVuGNjBff
	 n1ywInYlU0SvNaTscm4iWKlI4SUi1gaFRUe20bww70/ssNDAwLoBEfrjkuKZrooasx
	 3PhnknL38c+TbZwjkP6It0Dd9CGCKCXBzflGwwCAKr7x0UM7Reryq3am2L6ZC/KP8M
	 3yjONIi5o48DvImqMWimjXBmNeUmoeOBpSKnkdRrmxmHD7Mc2DJ8eleHB0R0v0jGWS
	 JmWl9WzAiFugw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4A17D3E996;
	Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: fix atomic counter for ptp packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762303173.24326.16199914725430660946.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 21:30:31 +0000
References: <20240604091939.785535-1-vadfed@meta.com>
In-Reply-To: <20240604091939.785535-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, michael.chan@broadcom.com, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Jun 2024 02:19:39 -0700 you wrote:
> atomic_dec_if_positive returns new value regardless if it is updated or
> not. The commit in fixes changed the behavior of the condition to one
> that differs from original code. Restore original condition to properly
> maintain atomic counter.
> 
> Fixes: 165f87691a89 ("bnxt_en: add timestamping statistics support")
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: fix atomic counter for ptp packets
    https://git.kernel.org/netdev/net-next/c/c790275b5edf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



