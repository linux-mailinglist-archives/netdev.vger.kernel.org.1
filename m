Return-Path: <netdev+bounces-180198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183EAA80584
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADFE4A636F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830ED26A1D5;
	Tue,  8 Apr 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNswvUlJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E6269D04
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114196; cv=none; b=Ffs/l2to41tEXPdnZwJUDRBzTENzm0+MOQDFLIiJiUHAhU0s+OlBMXwSuuw/g31it5AuSz/5AFMiftMNfflGOkTruLU8T8tELZ7gCvrCss8Z6afjkftbxG1YAbYZpBsfWKprGNKNgQZ4MvyTvQzvYMGHvcNDmhXRes4+Ljbeq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114196; c=relaxed/simple;
	bh=yZ3G3Tdw2WihfZVw7+8lwAmAApGRRHVVMV7zKmSGtFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AuM3IhWSo87oGPH2TBQLH07JrGSkJji948YYW5SE7tDVX8xZE7INJdc3Ddt+9VVdv6z1EIdi0tT4pSC18/ZZiWcPBk/tsJxGydxaiUTH6UYtCDZX4YZC3B/4Mt1DgVFKhI1ixMETJAZk5iF93XHB5XrUYXMCFZGP7Su/aK83qOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNswvUlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E95DC4CEE5;
	Tue,  8 Apr 2025 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744114196;
	bh=yZ3G3Tdw2WihfZVw7+8lwAmAApGRRHVVMV7zKmSGtFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iNswvUlJMjvtwruZDpQ8k3BPoRSWSHw8NZaf/9vmNX1Grd5mPO9ftnv8ZSPHTz55Y
	 Tzzg+s4He5q7fCgmbvEmc19YtX2dfpNdF9NMgwatIF+QO3rOVYc3yoCIrd3lDaEfpn
	 UaTwA049JMdt5ObWfL8Z7US/n0AoEuIx/6r/nU+6P/HSZ+vOxhrT1GOFKX5ziAxI+n
	 lmkqN5nhFx5darcUbCj7lTQCqYp8Oi1lJIwk6DdZKNtZEoviDkO9jJClGp0KFLIhGd
	 ZNURGxkNdo7rnTkglnxh0vS6f8AfXg6iOxz0orjSSWmXGhKMScigzgmJPYaAx5gayk
	 wnJ3+9uKgX+mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCF38111D4;
	Tue,  8 Apr 2025 12:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174411423350.1899640.15697214840893622302.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 12:10:33 +0000
References: <20250407105542.16601-1-toke@redhat.com>
In-Reply-To: <20250407105542.16601-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 i.maximets@redhat.com, frode.nordahl@canonical.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Apr 2025 12:55:34 +0200 you wrote:
> The tfilter_notify() and tfilter_del_notify() functions assume that
> NLMSG_GOODSIZE is always enough to dump the filter chain. This is not
> always the case, which can lead to silent notify failures (because the
> return code of tfilter_notify() is not always checked). In particular,
> this can lead to NLM_F_ECHO not being honoured even though an action
> succeeds, which forces userspace to create workarounds[0].
> 
> [...]

Here is the summary with links:
  - [net] tc: Ensure we have enough buffer space when sending filter netlink notifications
    https://git.kernel.org/netdev/net/c/369609fc6272

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



