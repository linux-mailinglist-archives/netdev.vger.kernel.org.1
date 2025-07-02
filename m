Return-Path: <netdev+bounces-203526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4CAF6493
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83A81C41B27
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0D2441A6;
	Wed,  2 Jul 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMEEq3Pu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E03242D84
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493603; cv=none; b=UMh8v14JJCnLZ5dSO74w0fg+rbNZbaeaN1jmlIOq0ALPINni4DH9yR4IwyEl1cjZR1yS5XpgsLDfbcXgSFrRbAZzHWUltLmc7nurtpoHNMrZfelG/d0ij/9Qc/OpNXP5AnCfsdNYduYxyxK5rDS+r1AtNsVQEPBJ8MPre/vZm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493603; c=relaxed/simple;
	bh=VcxfmgzNRf3UkfJSiNEPsOn+ndUxdtJIkJdUWA2agto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQTXGcncc0nAN7t0VODaYOF79ZPRVnLU1XAZTPUQsgnfgQ3KSFXt8ayXtVjAg/KoI+29fd8w7odzCF/zlYVYe87A3+rsgDh4Ys7ZDu2mw441GzZFm5GXOBgw21y1zWWMPG1A4ORY+3cu81Ye1i6j7tjIGsKvT3rOd3zX8FIyA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMEEq3Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F999C4CEE7;
	Wed,  2 Jul 2025 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493602;
	bh=VcxfmgzNRf3UkfJSiNEPsOn+ndUxdtJIkJdUWA2agto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hMEEq3PuamwTcFTT2qmJAAMtPKUJbhA1zMGKaK8X/lrsslY2ig2QhGlEY3q64N+Tm
	 /Z+F+u990JRUcLiIwGYUtYm21ML96f4nPhUmXpUEtZZlTrJCIuHe2GuULAP1lPE+iQ
	 lIovJqFRcomkMMfCmV/liq8GwGNcgK35nGdunDkWY/kzwwh0VQOpFdqDMh9lKN2y6V
	 I6/9W7sxZu3QwQL9pUCRe4Jc2FpNW9FuwCqOstm1ES+31jabbNvrV5oC4g2H7AJdsB
	 ++6VIQ8mxck21ObeNCPBA0GUZ9BDN9U6yfiUg5M4CuxeRxGLESf1s15IeyYa7Odq2Q
	 xHYRycDRGGgRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF64383B273;
	Wed,  2 Jul 2025 22:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ifb: support BIG TCP packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149362675.877904.14567695268233104491.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:00:26 +0000
References: <20250701084540.459261-1-edumazet@google.com>
In-Reply-To: <20250701084540.459261-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Jul 2025 08:45:40 +0000 you wrote:
> Set the driver limit to GSO_MAX_SIZE (512 KB).
> 
> This allows the admin/user to set a GSO limit up to this value, to
> avoid segmenting too large GRO packets in the netem -> ifb path.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ifb: support BIG TCP packets
    https://git.kernel.org/netdev/net-next/c/7d2dabaa1796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



