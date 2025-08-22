Return-Path: <netdev+bounces-216170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C02B32549
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB91CE0D5B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DE2D781F;
	Fri, 22 Aug 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSn1xZI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9E2D77ED;
	Fri, 22 Aug 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904209; cv=none; b=N/DTA24UTh4jdaWViPuGxPn+s1vPStOlFbqbTKltzsFIDlGntUMThvQPPYuitkAFz/xkHzBuhO0cXydE9xbD6mKqMvJ/P3/j2fEbzpYXk2HQLnQ8GSDFgHGnaq1Q0fC3wxzk2S7b3qIGHTfreZZft5a6B7oU9TQH1xcPH0QW+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904209; c=relaxed/simple;
	bh=f9jyGRXfwAggNufTeXedYs31m95Gs/AvL4IBfLPQJVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U4RY3zg4jRgnvdo2Ya2FQnvJzM3xikKTw3x3c4tzDe7eJbexxXk4GqAVOckUP8iqca1k73JraknPHzVds8ybF3rWQOWirckHaRCysi+LwFkDNYLd5SOXZCIvBgPOUJ+TGX2gZpnpUO6iX5MbGYoLAlZ3EkxZ5cptZJPRNBHj90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSn1xZI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D0AC4CEED;
	Fri, 22 Aug 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755904208;
	bh=f9jyGRXfwAggNufTeXedYs31m95Gs/AvL4IBfLPQJVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSn1xZI8oiHXTbleDTHEen2hVX+x5/BrU+Z1fzL3/ne3O8C90xD9yh01EXb9DOvsI
	 U8hS3psJDX+KrVqLg2BgtdoztmVUTD3DVN7mUO4MJ/ZQE+/igj3ld91TzYoC73f4ma
	 f/4txBSimYCBjQVc57VwhvIphHN5jZVBxi5SMl6f958i3VUPstkmLnRWlSK3OHWSXn
	 TWyyPQZQ8T7Tt47zEo110M9BTBiHrx7f3ecF0zD8mWAoYtRfy247GDVHzqRqcSabqw
	 y+i0BK6l+DX8h85Vx0kzI9iy2AUmF2xp8b53SI5bIqZekM2XcAeBPE0lFRUhjAFV47
	 noAn/647UQu/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE76383BF69;
	Fri, 22 Aug 2025 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] page_pool: fix incorrect mp_ops error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590421749.2026950.457212124383117313.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:10:17 +0000
References: <20250821030349.705244-1-almasrymina@google.com>
In-Reply-To: <20250821030349.705244-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, skhawaja@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 03:03:46 +0000 you wrote:
> Minor fix to the memory provider error handling, we should be jumping to
> free_ptr_ring in this error case rather than returning directly.
> 
> Found by code-inspection.
> 
> Cc: skhawaja@google.com
> 
> [...]

Here is the summary with links:
  - [net,v1] page_pool: fix incorrect mp_ops error handling
    https://git.kernel.org/netdev/net/c/abadf0ff63be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



