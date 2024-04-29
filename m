Return-Path: <netdev+bounces-92061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA78B53DD
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488011C21742
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E61C6AD;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/G6Wqv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1C17BCB
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381829; cv=none; b=eCJCtAQhY3kj/nMDFUSc7Ndx2VfLGV45THVBw2Ho1ZR+1SgtB4Cf/qgmdexyMXaiKzkpL/mPSFseb3dZLkqvRs6yXq0disscdP5r7JzgUXJDs/dz4enLicbgZmn7MxSz3aqXqnLusxcYYPoh1BN0AdaLl3dh+aGJy7Y4Mz/EtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381829; c=relaxed/simple;
	bh=R4ezvSrrNkvi5qFBzamN34HsyH3GvsgGApouDLLbdQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQfwbLSKpfsUYxUQqUp1TkQXuM9CiSrx5OqPPYSDEZCDOAUVsC2BgE7TwkMyPrR838hpHMZVJT7Iptg+S4xWfSZd0xheKqyoGnB/WbfPdwGysT2KAS5ulG/G9pj8wvdQEg3jVI/lhMDao4Bp7HOAujMJ7z3oarUher62c2jdfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/G6Wqv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61887C4AF1D;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381829;
	bh=R4ezvSrrNkvi5qFBzamN34HsyH3GvsgGApouDLLbdQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/G6Wqv38xu/qZFzYvYsoACohCD9EtoDbmO0KLN3oYJXyhuqLjQzbSRwdp6GmHx9x
	 jGRFaYJWgQHsAxC0RouYrzrPu/RLry+HrfQfgqUes1RQ8U6AOPzua9FXyMIKPkPnNX
	 7s1TdYwAE7Y37XHFrKqjIBNCXiPLnl6HZubAafatALXsFtOMvQGVEN0QWstarTbDvH
	 YfzEKGfK/Zzd6j2b/xvia5HsMLPL5P3RbyoBmld7UX7IV2Zx85TF5OqaiLylySoOi5
	 NxEmli/LOmcIjlG5j4+X6FZy/uyeQnf5jTTFlhBSSlJbTlUvJT4EBQKFXBPm19Q/KY
	 aQBlHe3/mWowQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57400C43619;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: use call_rcu_hurry() in fib6_info_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438182935.25540.17800132317545396442.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:10:29 +0000
References: <20240426104722.1612331-1-edumazet@google.com>
In-Reply-To: <20240426104722.1612331-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 10:47:22 +0000 you wrote:
> This is a followup of commit c4e86b4363ac ("net: add two more
> call_rcu_hurry()")
> 
> fib6_info_destroy_rcu() is calling nexthop_put() or fib6_nh_release()
> 
> We must not delay it too much or risk unregister_netdevice/ref_tracker
> traces because references to netdev are not released in time.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: use call_rcu_hurry() in fib6_info_release()
    https://git.kernel.org/netdev/net-next/c/b5327b9a300e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



