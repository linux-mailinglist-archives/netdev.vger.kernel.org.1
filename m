Return-Path: <netdev+bounces-146103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AD9D1F0C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47FEB22452
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA6153BFC;
	Tue, 19 Nov 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAFqwoTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E65153838;
	Tue, 19 Nov 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988832; cv=none; b=dmLOAfruAS00UhftDdblHKJGWmK0fC3dSIo4n0O815T34Ql7N5hEZPDoL0Eho97LCNw1cWb/Gove+eGH+eFpauaFtzlEzqGxHvAr3R1bD5UGzZjXaGT5wckOcSC1jqJ3qKuc/Mt6Fx03UYVo7BuSyagm9XUXiyXwAXGXaG0l4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988832; c=relaxed/simple;
	bh=H1kLKdwcGqzUJh4OBxCqwmIQb5jANwoCU/UDgo9BkBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LVqrm5bKRYujdpx20q9KFt7jNJmPu0nEQDwoxYW+VCF4gp2+qkPDB6l1Fpji3xY+Yp5HOxaje6SbbopJIemhvBfSxR4WgX7gXMbMVxjAS0ngf3npA/xPB3gbKRWknd/2NekOdNhdGwRLYrxAL89iFmU9qi1jE74pRaFCZnn+j/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAFqwoTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBCFC4AF1D;
	Tue, 19 Nov 2024 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988832;
	bh=H1kLKdwcGqzUJh4OBxCqwmIQb5jANwoCU/UDgo9BkBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aAFqwoTk6kHCZlMGoom3OmSsA1pIok5fa3C/FgJuZvvC9wgYmHgqSSWoUhIn5CUoF
	 NYF4wMob+CRh2mUbS+v6Cyva287tnLx9qyYv961tNnJTvZX5mzXtfwAXKOrTWOnFia
	 GGYsyv1mo8gq13Q2eCu1kYCBfXByBvwXKFa8JsM0UoxxzcIc1oKw3fKzzpknUotM1i
	 qaAgodK6nxH0ZYyKW1xoVbc/E+DwoS6/T5oSKFMwMcRxyeATOld3La/a3q246k5TTG
	 CPiOPPuUUzEruwPhIX0CiS2/FU1tYok2STVPSjhXJElJ/6siEzvtM60Xuh57A/S8Jf
	 UOi3bm/HNC0EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0733809A80;
	Tue, 19 Nov 2024 04:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mptcp: pm: lockless list traversal and
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884352.97799.1737627825332928151.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:43 +0000
References: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
In-Reply-To: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 17:52:33 +0100 you wrote:
> Here are two patches improving the MPTCP in-kernel path-manager.
> 
> - Patch 1: the get and dump endpoints operations are iterating over the
>   endpoints list in a lockless way.
> 
> - Patch 2: reduce the code duplication to lookup an endpoint.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mptcp: pm: lockless list traversal to dump endp
    https://git.kernel.org/netdev/net-next/c/3fbb27b7f87e
  - [net-next,2/2] mptcp: pm: avoid code duplication to lookup endp
    https://git.kernel.org/netdev/net-next/c/1d7fa6ceb91f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



