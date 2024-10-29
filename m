Return-Path: <netdev+bounces-140046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B19B51D7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA851F22B65
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9609206068;
	Tue, 29 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnbWuy/t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472F200C8B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226633; cv=none; b=L9Zcz+urpzDSFuINtw/N+N8hXRKGWKBeiEpHZTLFj+JXEovMNqHw0Cd50E8x1VPi+u9TNorgxwfHcjmCoEGxLKGc+bh9Pww0QziYZkSwxZRGm5bZF6tQiC28DhmoFB44Xxet0Vh/TxfztNhor3gnsPoqzHtFKBmGMNY+mpaRcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226633; c=relaxed/simple;
	bh=DVYTBes27DgHtPM4ujGGYEBp4CtV6lTEk7Hsn2EP1Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tr90QykbDebk37oYNSHFE3F9sjU3xu4O/aAIM4VqlJW3cEVbwXfkC9uYIqwxPQQKbo714K70HXhPAPYj2gpiP144E+DRztQPLZTdpTv7c3l8tRvz7rMUTIeJfPmo61Vj5pGwhaX/UqCgWIMrg4KQGwSfkn3fvoNNMZ3Aufp0nOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnbWuy/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64119C4CEE8;
	Tue, 29 Oct 2024 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226633;
	bh=DVYTBes27DgHtPM4ujGGYEBp4CtV6lTEk7Hsn2EP1Zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZnbWuy/tbaL6rW+li6cYSzDpIuhJdObAZ5tqakcbuOiMZTZL2GzMDnwLqnTLXhhCZ
	 Wae/gLbest4JKVjmy2b+xDIprWid2A6mFGM/gOgFT8/ydHZP1AB/LuXsrkrjOVdHp8
	 USRDTGQeMB5cXh3whLuuUK5ufYN7KVM7vp17Cxvw3yAxATvmtaHPEaerrQQMxaMYFB
	 3GD5IxbMa2d7+omADmK4Ei+F8DHLTOZdclQK5KaMDJE/7afoczdaIlU07C7B593qCc
	 WupkCs0UckCsFet94X2+SELz37sbg1Plcue+yl4JSSaZz3hc985111OxNvt1LFzqYA
	 bUh042Vowjyqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6D380AC08;
	Tue, 29 Oct 2024 18:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: ip_tunnel: Fix suspicious RCU usage warning in
 ip_tunnel_find()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022664074.781637.5915049772260552843.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:30:40 +0000
References: <20241023123009.749764-1-idosch@nvidia.com>
In-Reply-To: <20241023123009.749764-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 pshelar@nicira.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 15:30:09 +0300 you wrote:
> The per-netns IP tunnel hash table is protected by the RTNL mutex and
> ip_tunnel_find() is only called from the control path where the mutex is
> taken.
> 
> Add a lockdep expression to hlist_for_each_entry_rcu() in
> ip_tunnel_find() in order to validate that the mutex is held and to
> silence the suspicious RCU usage warning [1].
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
    https://git.kernel.org/netdev/net/c/90e0569dd3d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



