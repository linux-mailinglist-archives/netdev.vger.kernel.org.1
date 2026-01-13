Return-Path: <netdev+bounces-249301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98479D16893
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA6B43011B38
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3D30DECB;
	Tue, 13 Jan 2026 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9sbva3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B972E0B59
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275821; cv=none; b=spLmqKr9mQDv1FhP7c14yZIoSHd5m7llbdL6vqh4QJbLal9vXqx+z9qbHInaYx9kOgWxU7em2tZBEArZpnwY/gEFieS9bO2jz5+s0YWKI/ER82wvUYalp57zzaZLrUul0pUsOaueF9svCva9JnH/qrPxoku5x2K1hCAlgNLIfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275821; c=relaxed/simple;
	bh=lk5qw8wXogb8USlNq5Ev0wssPHl7RD7oPjdQWKGxNHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvfsamZgnzbtMFli/q4KuyU7PFNtjjwBIzDhi/3T/WkCHygaYX7o52GiTsOpJcLi6pz0w9bAyokOq3mbo/yqBr0Ey7Ck7zB8QEy7kdsYDTY2jgYNz1nGK5lWC7COeTVAwyssk+ByUe84Bk0BrDa6BYH207ZRE54NY7V3MsChjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9sbva3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D7FC116C6;
	Tue, 13 Jan 2026 03:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275820;
	bh=lk5qw8wXogb8USlNq5Ev0wssPHl7RD7oPjdQWKGxNHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e9sbva3FGOxWzCganKUlIswkPMqiPzyranB1c/S74sFPP2gOYO0XlbAsEmval5ckp
	 5/qErz1KqKYE/N2pTwa6WwIldSgFXbrSptBoiPtV3/jHK6gapLXO7ICU17k4tUvkTI
	 KzsJog2zBil2EenFJ7ODlEnipTkgIwckMIb8S7ASjswtFphIR5gIyirKqgZgGzywK3
	 5Yd9eSqtooXDFSOb8afn1ox8z3IiQ8qTHa0RQISJq0WNZBCIPwnCrgAO6HKNI8Ruf5
	 sqvsHBAt7Fj9bv90unNFUTYzjqLxsvKZBhtfKOP8+JIZMT7aLy0Yhp54t5hiGglFTz
	 M/NaY0xqUDuqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58DE380CFE5;
	Tue, 13 Jan 2026 03:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add skbuff_clear() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827561454.1661897.14255397378941759223.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:40:14 +0000
References: <20260109203836.1667441-1-edumazet@google.com>
In-Reply-To: <20260109203836.1667441-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 20:38:36 +0000 you wrote:
> clang is unable to inline the memset() calls in net/core/skbuff.c
> when initializing allocated sk_buff.
> 
> memset(skb, 0, offsetof(struct sk_buff, tail));
> 
> This is unfortunate, because:
> 
> [...]

Here is the summary with links:
  - [net-next] net: add skbuff_clear() helper
    https://git.kernel.org/netdev/net-next/c/0391ab577c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



