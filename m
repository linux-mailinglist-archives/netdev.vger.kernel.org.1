Return-Path: <netdev+bounces-250429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80BD2B21B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6F13062CDD
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD33446C2;
	Fri, 16 Jan 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szQ2sWS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A3313E08
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536235; cv=none; b=gir9Yw5Qu9ljUFXOTXlRBTqi4nD/Al5yUJ3BUwIArTWxebG+6RSBvsAgA9qX3XZBlbz82ec5T2fxwVip65yZheLLW/tj+rlgp8VhORbXSLC6pltoZnsBrbt4UJahVsqS2Cl8LB0KB0h+nHcpAlBPOYwwCU8yU8VXMNukMWtoAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536235; c=relaxed/simple;
	bh=3MORn8xIFOVaT78J8xq1twaSMWUE3J8H1vYsPYqOO/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HPfPS4pvdO/W9ke9O/Ncd/3/9ngYeOxrxHxlnN2QgQrfuUNkbkG01/zxcvbUAmDC6rGQK9b0y3oXS/eOAUG2MOrbLQGKsPGCLPY9SWByRPOBDm6aQBVBgGERN9CZ5gmaw45RhiITzoH7H1XafqCwDKbkVYlCvt2ft/32v9YgiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szQ2sWS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CBEC116C6;
	Fri, 16 Jan 2026 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536233;
	bh=3MORn8xIFOVaT78J8xq1twaSMWUE3J8H1vYsPYqOO/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=szQ2sWS2K0SOlHuOYYWX2YpMl1PM8fx7bz8Ew2TaHRAbmj6PliEYGFYMHiZ2RnDA3
	 m9hA0NQxO2h0I4r+NDI5AeO4h6dLUMWNu3iNLtvN/rgAuvjbzMiZyUwjV4QupMJpME
	 ACeo1p6ezCS9TliQSJweRia91/peipfQPx1lyPIi/X3Oc/SjjPvFs3ZijXc82K8FYZ
	 Obr28EPpnPDP3sMnS3GqgcHE5YsuVGZj4s3iXNXwWWECTKVagw8DaDK7FfTXsrG8oc
	 7zzlpLyVpFKZ7NnMoct41Fzg9t4lW8Uz3YpmqhCrU1INLzFFWXWI46ejJCX0kw7bUp
	 FNFkrB8ohMH2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2930380AA4C;
	Fri, 16 Jan 2026 04:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] l2tp: Fix memleak in l2tp_udp_encap_recv().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853602552.76642.8690909176592818197.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:25 +0000
References: <20260113185446.2533333-1-kuniyu@google.com>
In-Reply-To: <20260113185446.2533333-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, samuel.thibault@ens-lyon.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 18:54:44 +0000 you wrote:
> syzbot reported memleak of struct l2tp_session, l2tp_tunnel,
> sock, etc. [0]
> 
> The cited commit moved down the validation of the protocol
> version in l2tp_udp_encap_recv().
> 
> The new place requires an extra error handling to avoid the
> memleak.
> 
> [...]

Here is the summary with links:
  - [v1,net] l2tp: Fix memleak in l2tp_udp_encap_recv().
    https://git.kernel.org/netdev/net/c/4d10edfd1475

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



