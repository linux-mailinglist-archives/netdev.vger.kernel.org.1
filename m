Return-Path: <netdev+bounces-288528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGJGFNXBB2p+HAMAu9opvQ
	(envelope-from <netdev+bounces-288528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57C559AA2
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FDBA30315D2
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3202848A8;
	Sat, 16 May 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A14lFU4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1E28469A
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893198; cv=none; b=P58QI0a4nBqrjDieGK31xc4SDHzU1pALuYgtgtTCbUtUWnUsQCUKEopS8inwMdUSd8idx2VjYUqnshNMl3OAY20s+j1ST87Dac2uHJI1R+0SS1RQE8gpHtWd8H6yi8zgRVkEVRwLLiIAcre4RD0IS5F3oubsM0mGLcXkBF4Qio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893198; c=relaxed/simple;
	bh=g8SnCnZJIdQZecdL3FKlth71CqTU18sPOaUw+NH63Fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J2k8KHlytD2NTpNtvB64lsbx4ho1c9uuuBm7YqItZ0z/FrtdGPiL8D2oaWPPnslhFzt4E8kM4Z0s7+Ci6HQO9SFNBKYthFmAQnIemfdS+UtSyjmotBYleTHxKwf2p45RZQvUbFDjx245dfY8rdQjBCiGzFRVOQ3XcsdjXq7v88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A14lFU4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED007C2BCB0;
	Sat, 16 May 2026 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893198;
	bh=g8SnCnZJIdQZecdL3FKlth71CqTU18sPOaUw+NH63Fs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A14lFU4GJHwK3LrMeXjQgOj8M7MDCAeHtJlO+7mGrQOm6FcxyFJuUs/Dr5hvfvMKG
	 nBTNp1C9fGE59vreCjNFSqvLt21IlaAIZUtMz4TKnk5Z45paBAHDEmtu+m6HzPFBvF
	 NZJHeH5wRSSa9jADJ6einpXdWV4QFmuUH/l3g9Wv/84tVoCun7kB5Frg3EyQyEDmfE
	 MsT1kA12Dxq6uB4Ym8RxzgHORk2GdGEqwcxiSIo0D+plmmSujoYVXj5pQBZ8TMjDsy
	 oM1Ge6YkZir8LSE7IHtUybK7fEc8d6lbETwK1GwA7K0xABK2Z2FHOU+VC2budpnh9u
	 qOfRVDE9UCtrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567CA3930A23;
	Sat, 16 May 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: sch_dualpi2: annotate data-races in
 dualpi2_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889321113.213149.12119139753396392487.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:00:11 +0000
References: <20260514114713.4134674-1-edumazet@google.com>
In-Reply-To: <20260514114713.4134674-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us, toke@toke.dk,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, agarwal.vineet2006@gmail.com
X-Rspamd-Queue-Id: AC57C559AA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288528-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 11:47:13 +0000 you wrote:
> dualpi2_dump_stats() runs without qdisc lock held.
> 
> Add missing READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: d4de8bffbef4 ("sched: Dump configuration and statistics of dualpi2 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vineet Agarwal <agarwal.vineet2006@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: sch_dualpi2: annotate data-races in dualpi2_dump_stats()
    https://git.kernel.org/netdev/net-next/c/5658bddaca41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



