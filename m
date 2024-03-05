Return-Path: <netdev+bounces-77643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F887276E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D31C28ABEA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CDB24A1D;
	Tue,  5 Mar 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc1XtVRS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001FE23758
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666431; cv=none; b=nn4rBO6jtR88F67uZjBc2Qq0J7Vu7nZ3jtVp2vQzYEpjClzdqosd/qwKKX/t1DYOGo7LiLR0Gh6g7HZYIWc3HMLn2tMqPsz8oahyEIX9j6+aNulx6vXu+d0f8RFV2fEgiFDZZ7vvHZ1FsR/Vwu+3nu1+mNWxmqkOeWbiIpRzG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666431; c=relaxed/simple;
	bh=oXGnEOeAxG1g9hJ+yWjUadT+HzOFOuz3Nz7lLqVBMM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=okTzFfsU1KYruCTQSlnaMRZba3BOPxFXnV4ya/e8CeUXDB4aHFT75Dn/1beExVfzgEdbbV3aZgGNdlN6I9JrmbaYYXN2wjxnYBroQNMmvzClZdgx/rp1SmB6tbVPIPmS/y8mhCxU36ezYhHI8YgrknBCy5bihe8WkDjQg0sO00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc1XtVRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7308AC433C7;
	Tue,  5 Mar 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709666430;
	bh=oXGnEOeAxG1g9hJ+yWjUadT+HzOFOuz3Nz7lLqVBMM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tc1XtVRS5dCZha1/Rp8mYoTzl5wpFsaG4WBZX9k7B3tjfULqm4N2g/vIdLBJzv3fN
	 lpguoYLOhf4O5gMuWOojD0XdZF1kt9ci5IeoUAfSCQUEVi9eiVfl5jRZsQ585v0zTI
	 BgWjTYQQP6F28cWF9gGECohHQ7QfVDERlt5ND2B9BZPL76Zw/ToGFlhmL0V4xEyU1s
	 E3KejdMwz+no/cQetYmB46G6OdbqPZfgwirhoR3KAKDYTidtMnyIH/FOb/iGHDqRo4
	 KEAdBFsqYLfzUMhY0BWpZTiFcl18a6QF3gHx/E1iI+U/zCUVeOzjTMr+qSJX8K41vV
	 qUQm7vjw9VeOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56591D84BDF;
	Tue,  5 Mar 2024 19:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/ipv6: avoid possible UAF in ip6_route_mpath_notify()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170966643034.28029.5945491496744626018.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 19:20:30 +0000
References: <20240303144801.702646-1-edumazet@google.com>
In-Reply-To: <20240303144801.702646-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 Mar 2024 14:48:00 +0000 you wrote:
> syzbot found another use-after-free in ip6_route_mpath_notify() [1]
> 
> Commit f7225172f25a ("net/ipv6: prevent use after free in
> ip6_route_mpath_notify") was not able to fix the root cause.
> 
> We need to defer the fib6_info_release() calls after
> ip6_route_mpath_notify(), in the cleanup phase.
> 
> [...]

Here is the summary with links:
  - [net] net/ipv6: avoid possible UAF in ip6_route_mpath_notify()
    https://git.kernel.org/netdev/net/c/685f7d531264

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



