Return-Path: <netdev+bounces-111019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA292F447
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CEA1C22A82
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C907C2C8;
	Fri, 12 Jul 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIi8OY9p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086D8F70
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753831; cv=none; b=lF986wDR+sTWePmMjPfRYpLAb3kv/ZX2gC4kEM2MmA2/sAoKYCkK+C7VLuR+J2tV+CmUev1psJ7G3KfBpNo6StFjWFcqgnNdC+IAh7DOP3SZKqzzQXJskb8l7xoesU+ONhQZSQBdDJYd1s/5qMWEYTgNl6RV1oPcaGVFHP75NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753831; c=relaxed/simple;
	bh=DEL4vMVPgktt+GTMivxRYsNQsmzo3Vo+uRhRyRlR18A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZApge+JtSwOpWiL2cA3mvLE0Eq6jT8FYnQol7oZuPCg++rBqG8Kc68rVwT2QDqP3AVmv8iBP6CBGgVs41NMDMhgTIQGIWuEWDosWTQadd5e4gvKnWyOziPXa9EszDWcOOPxOfPcOOE/nyRVVwk9J8kW595Fb9Yw58Xh8GmTBy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIi8OY9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA71EC4AF09;
	Fri, 12 Jul 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720753830;
	bh=DEL4vMVPgktt+GTMivxRYsNQsmzo3Vo+uRhRyRlR18A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GIi8OY9p82j3A/2UwJFy5y7BfI76ZzAzLZAeFVZUCEdToi0H81YpiPDPCErMNwDFl
	 vUmUCKzfypwryZlxjZNb8OXLQhyleJLjp9d98jp0e2pO80+bJ8L3Q3cumEbRwTCx0G
	 Ww8Qlww/sv7x1DG269yeaaLayLV/DRGoFPmxMmNbMC6kiNJs6guLb6imiPh1b8ZOJJ
	 cTAB/FsKhskFXwPaTAw9v2rK6fdLAEMxYLN/Qu7kvt6FZUVydmr5fuHAYT0b5ObFmB
	 KXZNEst77M4k1YOWJRg62pSTK75//aDvTQqgsuW7bdA9jTSmcBdzR5PDH/hRhy9UsW
	 xnbZC1W9CR5rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D79AC433E9;
	Fri, 12 Jul 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: fix l2tp_session_register with colliding
 l2tpv3 IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172075383064.14429.18140560465588954421.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 03:10:30 +0000
References: <20240709162839.2424276-1-jchapman@katalix.com>
In-Reply-To: <20240709162839.2424276-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tparkin@katalix.com,
 samuel.thibault@ens-lyon.org, ridge.kennedy@alliedtelesis.co.nz,
 thorsten.blum@toblux.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Jul 2024 17:28:39 +0100 you wrote:
> When handling colliding L2TPv3 session IDs, we use the existing
> session IDR entry and link the new session on that using
> session->coll_list. However, when using an existing IDR entry, we must
> not do the idr_replace step.
> 
> Fixes: aa5e17e1f5ec ("l2tp: store l2tpv3 sessions in per-net IDR")
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: fix l2tp_session_register with colliding l2tpv3 IDs
    https://git.kernel.org/netdev/net-next/c/2146b7dd354c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



