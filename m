Return-Path: <netdev+bounces-87589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DF8A3A5F
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B97C283CC3
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8E19470;
	Sat, 13 Apr 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6EVD2hQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C818C3B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974232; cv=none; b=SkZcyP/rw05wheR+RIq4vy8pivwJeqtvb/NylhmowKyqBWkEkV0FxDI1lqEEgjfNZxoIQgvnzvTiXB7fUO0NPwbyCLgpW2KkfjpdcL7axpL6/A1w3zeo90vAffNzZEmMNTiVWZhxsAwQUl+mo8zxaEq29soDU5TJ1h+fPuBVlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974232; c=relaxed/simple;
	bh=OGWBbl3FfTxpP9k78XmHP1hfV2Lhs/wdFvgXxtHEvzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cj3FzZWR9MlmSSF/g6btMwKLwdi/qufF7vpPa2t7Qg/wQB95yiMZJKnyC5hzzxASKymSNWE7w5pUK35I+LMoI/w8SLrRKXvV/LAPHZVHSXo6jru/J9p/a92PnkQEYLxY4dw/tV1a3xpHI83HkTO+sbU36SJ+UJYgDaDmJdi4mNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6EVD2hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2FB4C4AF0E;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974231;
	bh=OGWBbl3FfTxpP9k78XmHP1hfV2Lhs/wdFvgXxtHEvzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6EVD2hQwUE78Gq630Fb3w/Cx2HDJP9cfg4JROtz54/lWZl7KRjBzrlPQSszeiF9m
	 +aKimh7s28LMG+Ef6R47yGKw0rSfBNzoEWArNf9UgvEMjhBebBG/VAGEbHnOEoF55Z
	 o/pTDbcT1D2T9qVEmwrIBr+a3q/L5ImE/uEFJmO/xCHZJFQbMGlapwOHCDpZzWSod9
	 XOwjldlgmmTF+5BTSnl2qxyTLU76zjDIQPZbaXEWrQBfmQ1oelCat45SyZfzKiQ1bR
	 tKWKirTr1aoqIRkub81iUz+rldLVKBu0wzcTzZs/eCKJ2RP1xNLJ+I9tWkRiO++RBi
	 fGUVTHbcwzR0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 955DFC32751;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: small optimization when TCP_TW_SYN is processed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297423160.31124.7636272714807302322.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:10:31 +0000
References: <20240411082530.907113-1-edumazet@google.com>
In-Reply-To: <20240411082530.907113-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 08:25:29 +0000 you wrote:
> When TCP_TW_SYN is processed, we perform a lookup to find
> a listener and jump back in tcp_v6_rcv() and tcp_v4_rcv()
> 
> Paolo suggested that we do not have to check if the
> found socket is a TIME_WAIT or NEW_SYN_RECV one.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/netdev/68085c8a84538cacaac991415e4ccc72f45e76c2.camel@redhat.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: small optimization when TCP_TW_SYN is processed
    https://git.kernel.org/netdev/net-next/c/d13b05962369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



