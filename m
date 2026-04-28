Return-Path: <netdev+bounces-281584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDQ/CLoS8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90147C880
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682F43046530
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9D2D877A;
	Tue, 28 Apr 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5fFM4Rl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D9233D9E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341057; cv=none; b=Uq6H3FpnxNchEXxxytGt7QwZ+xYNy/S8h835PdmOktj5tfpp3vcR18v3BpefchTvP4/2zNA47370bV+6wl/Woam2AfIsX2UgaGoJsfDk7uVebnchf1obSwH5uexnoOhEo3+yHgxJVjeU7oujUCLTFw6sXBdU05Xi0u7NJP02E/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341057; c=relaxed/simple;
	bh=ncljqCu+fxPifhQ5tOHCxbttAIwCJiC+5mqNzSJWW3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ITtAUisyy2nFjHI95U+XecJ/McPTW216CVDZ6JxXPBFHIf6Ksg1kaXQRljxMyhjnd8qjAOvUIZxIRBdRrV7tAUlPQcerivyoFqACpu+Ouzcs6FRSWrDJBIIDLIYScvjFqlnz/an1SrA3R4/gRtXNF7vuIISle4NrIo+hhMbfctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5fFM4Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AABC19425;
	Tue, 28 Apr 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341057;
	bh=ncljqCu+fxPifhQ5tOHCxbttAIwCJiC+5mqNzSJWW3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5fFM4RlMGx34RllaJfZnylA9wGyzcz2SznUKE/5Zi/llBBZiCZhuXKTrYrMZ5moP
	 7YAvYfsP50sMDT5rKTai9tCZRGOHALI+VdXh1CgmSJ5nCkj67jGkmi+lCX0jtZ6+3Y
	 DMFQV41n+fPUZNGUBm1hW2nWtCciJ5TdD8gHjXEB+yACAFlOR6m0qUaxDhP+Jv+faY
	 GD8GvHc1A9PFnhCUbD3MnCKtbrYwrSMqYsy/E79LaXaz7R1X8ZsKW9v2HOc8HUHkG/
	 PvKwDmAKb6sxsiWflmdDWVqDsEfzepcb3GVBOdyMB8QLF3T8rB9Zsc9rV6M/CWaePY
	 7avlDzCP8+z1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD17392FFDF;
	Tue, 28 Apr 2026 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipmr: Free mr_table after RCU grace period.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734101404.196918.3582322232814529805.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:50:14 +0000
References: <20260423053456.4097409-1-kuniyu@google.com>
In-Reply-To: <20260423053456.4097409-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 9B90147C880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281584-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 05:34:54 +0000 you wrote:
> With CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
> does not check if net->ipv4.mrt is NULL.
> 
> Since default_device_exit_batch() is called after ->exit_rtnl(),
> a device could receive IGMP packets and access net->ipv4.mrt
> during/after ipmr_rules_exit_rtnl().
> 
> [...]

Here is the summary with links:
  - [v1,net] ipmr: Free mr_table after RCU grace period.
    https://git.kernel.org/netdev/net/c/b3b6babf4751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



