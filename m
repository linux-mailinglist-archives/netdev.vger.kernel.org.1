Return-Path: <netdev+bounces-115457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453A946675
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34971C20E02
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6B3FF1;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4lvfasT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EB380
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645034; cv=none; b=Vf6EiNdkOoLJjq5iatQOKSvX9tSgWTLElOgkECoThEBitZLZ1NrhS6mMqVLqxAUdxY9SJmgmM6+djuD8Gs9bdzrCEF68uo9kseAsvqEtciwldqd1Frbuu6E5cjtbqFzUvJAFR7EcA8GzD6DdEsnHhuR15DnmOqEFBUTmGFyc/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645034; c=relaxed/simple;
	bh=tKkOInOfC4N7GcEW+sxr/ao18vUba9yfkWnwndW04OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pTCcvrSz8QUut5Gr7zRG0rm4YwiZLFK9IinDNkYulx39YP2NTZsdXsXgHG1f8EOVWfGg2GWT6jv35zr/3yuXoR1j4TaWGZGGxLLVLnNdUXrFwPsDmbCSc00xp7WuASdJOxpkYs0l+LO3e7ZLET+5RlLRr88BvqnAJlCFsrVjQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4lvfasT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 412C8C4AF0B;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722645034;
	bh=tKkOInOfC4N7GcEW+sxr/ao18vUba9yfkWnwndW04OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K4lvfasTLNmwBkrPqdL1LXJgwAS/VYfdAsrFa4ZcBxR4ptM0QM2Lp604Hw8yqkhN8
	 JAO5ZmLJLLHCcJXXTSwE85lFRy9LT+IIcHtIaL66V3b6iYDT+pGZayuflqVpSzCBmo
	 hirbRY3qNE8XE74LicF+bajEy/bC6XX/3jDrqXalT8sCCh8x3YwXYWr2D8yAXlqBT5
	 NQmdUgBQOhctelQd7D8OVKdCcYCi1xWNBAudHgNZxANMgImJm9xoYYbcANv/5cVV1l
	 Jywkemqyvp1+ajVIlVBb5wmjDd9IOHVxHuodsVXwWz7LGqOyk1Lp3qZTh7hOSRwBVg
	 xodmAr7uTdzQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28887C43339;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tipc: guard against string buffer overrun
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264503415.23714.14575733017599531449.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 00:30:34 +0000
References: <20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org>
In-Reply-To: <20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jmaloy@redhat.com, ying.xue@windriver.com,
 per.liden@nospam.ericsson.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 01 Aug 2024 19:35:37 +0100 you wrote:
> Smatch reports that copying media_name and if_name to name_parts may
> overwrite the destination.
> 
>  .../bearer.c:166 bearer_name_validate() error: strcpy() 'media_name' too large for 'name_parts->media_name' (32 vs 16)
>  .../bearer.c:167 bearer_name_validate() error: strcpy() 'if_name' too large for 'name_parts->if_name' (1010102 vs 16)
> 
> This does seem to be the case so guard against this possibility by using
> strscpy() and failing if truncation occurs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tipc: guard against string buffer overrun
    https://git.kernel.org/netdev/net-next/c/6555a2a9212b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



