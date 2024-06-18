Return-Path: <netdev+bounces-104293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500890C111
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F402828EC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C1D53C;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrOiqZrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5E6AD7
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673029; cv=none; b=OGdvBAwWsJTD1SJaz21sbwKhcDGm2ervuKnfcuHnC+jLGzHDIed/DAAMVQQv1v/E1hp4aE/4NXCSi1+YCG99mvdG2l7z/VLHSipj86JaqQqf3+k+HOtrElZZ6XDq7yOxmjz4G/CvKgih1exQNvhxh9fcuUbIWBGrmjBo9hSy21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673029; c=relaxed/simple;
	bh=4q/W/9gY07mAJDX9yjLyfF0ShewmdeerOxiAy1oa1L0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ePiizey1jxBRKCFtWVOWVe0pvIPgXjLTL2pa5zxW+fprf+aECjWAUkneBso+DIYtHf1L7j/rjGexpiO/GZNist1jNPKWTyEUwUbFFWIEuRW9oYWnksDl9vn+06BzmXM4jzmwQ3ziqhIdkLW7C83HQe3MCs25Gt43NUVsc0EqdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrOiqZrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 348CAC4AF53;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673029;
	bh=4q/W/9gY07mAJDX9yjLyfF0ShewmdeerOxiAy1oa1L0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZrOiqZrt79uTk6m5Xx/uy73c6Y/0dQeEqcpeJ1y8WenKgIWGeT4JG5ZVR5+1pC3ae
	 RQk76NmFm3WgEv0czzx0rs5/9cmrNfTBfpm7+atGU8TDwa8JVv2Eo08K+Vq5+6XXYS
	 y5qnLPYYkFhJqVfPmQSlxeer3vrLBLWzDdIxaCgoKVFcv2Bwadt3c6LoivUBNhTtTQ
	 9uUGMo1fkYmJEmG2ejPzacdu4kewPYENKjwWd1UJVA0zWVQxCcdO5NAji/CNt8JDKT
	 slN4tHFnBfG+VKp0oIxp9paBYvbBnntbm2yrL35Tg3dunfMH/ZBFJXpj57qIZqJmpd
	 I4QfMKKO4Cvyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2367FD2D0FB;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: prevent possible NULL deref in fib6_nh_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302913.10892.16350885844569506425.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240614082002.26407-1-edumazet@google.com>
In-Reply-To: <20240614082002.26407-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com, lorenzo@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 08:20:02 +0000 you wrote:
> syzbot reminds us that in6_dev_get() can return NULL.
> 
> fib6_nh_init()
>     ip6_validate_gw(  &idev  )
>         ip6_route_check_nh(  idev  )
>             *idev = in6_dev_get(dev); // can be NULL
> 
> [...]

Here is the summary with links:
  - [net] ipv6: prevent possible NULL deref in fib6_nh_init()
    https://git.kernel.org/netdev/net/c/2eab4543a220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



