Return-Path: <netdev+bounces-274303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBYCFO9zWlmgQYAu9opvQ
	(envelope-from <netdev+bounces-274303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B407F382167
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AE5A3038A5E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6B230BD9;
	Thu,  2 Apr 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRAla4KR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFE1F0E25;
	Thu,  2 Apr 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091022; cv=none; b=g3nQnydRVEf4THFZvPHN0jSUgRWjiVze0AfU9oc4uU/skf8rABqBngvSiz6mm9W2ML0feLbt17ajEHHc804wlESr8kWhrrLSgsjNY3toJsCMtgCWJp/Dc+JfaAv1iSqXEpcoGjhCjHh2GnaIfrYYVwZ9P0rcMUSKWc0Dqnl1FUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091022; c=relaxed/simple;
	bh=/eg3P3PUb39JIfzndr75JqyTUzA/W99qWud/tN4mtu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UpEMcWNTivONCmk3sL8Y96X3RdjX4gquWUBCen/V5AVIBMkXZkM5uwpt/k0S6oe8u5TAl6y10sPi96nITLP6z2MyAY9AL6VpqcczxOAQL6KPz3UXr1wC7HLa4TMMOIr9yZwbVgmMp5TU5J/KtzEwpww3FXmIhr1gBvRINeZVf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRAla4KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE27C4CEF7;
	Thu,  2 Apr 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775091022;
	bh=/eg3P3PUb39JIfzndr75JqyTUzA/W99qWud/tN4mtu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PRAla4KRM5sg6y6IWsxA5FOti+soW72+Bmi+utd2WXNjUdwpJ4LNLzwwTdYRswxy6
	 +X7uUHXo4zwjjuDinTbw3bM3LA5lGymI8pBhP4BdrASCKfyb2dW0GIdeStIAAhtaYs
	 HK4RF6mrDHnQXqnmsGcyz9Slt571TCgXwByEGMmvrURRhpGFd+enCISkyuL9/wdnSC
	 +AK5TWuUG8/5w0Qa2822dICfjhQJ96op5Ni4xEb6v7aJsN6BxlKPFdCd0IsDL8ZT2q
	 YJ1ohC9GJZxYM5fOwkCfM7/ffR+SQ56/XVq6KdFkMd4huWH1631tHg0v6G3oVGW5jv
	 UdGpmWEt5yfCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF593808203;
	Thu,  2 Apr 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509100529.3929284.7880637325111529134.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 00:50:05 +0000
References: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
In-Reply-To: 
 <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiayuan.chen@linux.dev,
 dsahern@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 feliu@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274303-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B407F382167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 12:17:18 +0800 you wrote:
> fib6_metric_set() may be called concurrently from softirq context without
> holding the FIB table lock. A typical path is:
> 
>   ndisc_router_discovery()
>     spin_unlock_bh(&table->tb6_lock)        <- lock released
>     fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: fix data race in fib6_metric_set() using cmpxchg
    https://git.kernel.org/netdev/net/c/ffb5a4843c5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



