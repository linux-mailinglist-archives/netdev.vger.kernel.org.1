Return-Path: <netdev+bounces-250433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D2D2B20F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96AA33013D73
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB13446D8;
	Fri, 16 Jan 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1N8WQny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD27336EC9
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536250; cv=none; b=C84KPR4gcJIx+J7/V/Cf/y/N8R47L323ayMV5mMOvDcwLWNM2OgXQ49dBgRDr7rBmh6R+UgV2ks+2w3WjpfM/LeQzSOmacvUijG4stOnN1hHBdcOek/ykKKfuup8jn/dQRqK9SgO5P/qWMahjs1zy0NdBPq3TgCBdIe5j3fyX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536250; c=relaxed/simple;
	bh=Y6kLexxc48ZOEETQ0k5n25IDHd3JJ1TqM9KUZ42+XcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m2GuNBKvnnIS5hW6Fzze4ik4L2FoXG/EMA8NVgcUsYbjyoAUtfi1PXVXdA050TzTHAoKGgrx5J2dqxlH1m5dEoAftSNWf3WsrVOwqPlute0qESzpr7k6My6j8Xhin5FvNm3Cm43FX3YRbQT64rA22paoZIVO8eO1w2q0+P459r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1N8WQny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156F9C19421;
	Fri, 16 Jan 2026 04:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536250;
	bh=Y6kLexxc48ZOEETQ0k5n25IDHd3JJ1TqM9KUZ42+XcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L1N8WQnyC3b8KvgJbqkdbzizFAM8YPLmEG9V7UmLLNhRzmUEOtMm2Xq/He3V4N2d6
	 GS6PBToVxpaEtU830homBomWHxQGXKeSJX2GscJk6CnbOGE0HWGq2uyN/qti+EGfHe
	 5y+wqBbr4Y7nUVT2zXRW9QkhVHlv/Qk27AGleaFBAJn75RVqBPlc2t2qWyMgdP+AUo
	 8JSQWvCFudM6O1EKEQCF1jr1blmTzyNK4o/tJhoB0wbPxYSY/0soSURii+4JPTpVlL
	 yqFeGECdRdo1z3sVZ5vm/u0tPYny0KKLCYnkph0vMPbkrey0i6A+G0oLLheG722HZA
	 OIUYtTeEshx0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6AD380AA4C;
	Fri, 16 Jan 2026 04:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: minor __alloc_skb() optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853604177.76642.4102106895992369226.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:41 +0000
References: <20260113131017.2310584-1-edumazet@google.com>
In-Reply-To: <20260113131017.2310584-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 13:10:17 +0000 you wrote:
> We can directly call __finalize_skb_around()
> instead of __build_skb_around() because @size is not zero.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: minor __alloc_skb() optimization
    https://git.kernel.org/netdev/net-next/c/2db009e4c8d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



