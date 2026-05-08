Return-Path: <netdev+bounces-285962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCCqLE01/mnYnwAAu9opvQ
	(envelope-from <netdev+bounces-285962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC464FAFBF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBBEA300E253
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56023783C6;
	Fri,  8 May 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHAi8kn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D703451CC;
	Fri,  8 May 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267464; cv=none; b=KbSv3o5zc7G2U+oqR0MoqnReXNXX6cseEA44hTq7XMznHNnDrjW3MujR+7GSK6I4OoKA8axpFLFlwnMRWB0G00XCfI/nTCyskrpDq52uoWfPLcDuaI2h9c7jmGv9htZmdk1t4qkquBl+/gTJJUvFUEj59Y35D5/6oKuQsmsKNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267464; c=relaxed/simple;
	bh=K4T8q70tH0HqIqOl86K9GSbjiuvVoMLW12ZGriclTmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbWLjFqyjEYTZ4NwdD0XZH0mNhcLHx/SAm8SFrxF2baS4IDiq5Md461ES0nrDRjE2pYdB1FR58HcbhCG8ZE3jy2Ie4w3LDDyNfG2cXFu2UjgUethviyPtnutVZSanCVNQ4pnfXJrKMLhiOAxms9fvblFe65TxXLsMmrr2GFNQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHAi8kn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A502C2BCB0;
	Fri,  8 May 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267464;
	bh=K4T8q70tH0HqIqOl86K9GSbjiuvVoMLW12ZGriclTmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GHAi8kn3Z/Hni2yA9Vn7RqSaIuCfGAKfFgHmmBhoMttaRdCt94rzSPOlDRW+MeMpS
	 3san8nRj7MnyISWfnrW/GfXgKg5XyjRpLw0sNOy0zY0o99Q3xDLjU9ipBB77B6tZB2
	 Lq826MNM6E6U41fiOse9rVa1mh08WniIFQO8BmQ1d+jNhK/Hy+o0R+IGaTgqHvVJiE
	 eLCrGRl7/FmTpOXEG6uObmV+X//3EDhjUWcqioEC2djZl5l8KhoGOsOygbQL4AbSHs
	 d9ZXxYv2TG9F8K+aLcVQYxtRxiFhKNuwlG+do/eAgZ9TkK9zzs4HMJjMbJZQ6zrfSG
	 349J1QcLTFpuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE0D381197C;
	Fri,  8 May 2026 19:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/6] bpf: tcp: Fix type confusion in bpf helper
 functions.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177826741305.812133.13447548558506507640.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 19:10:13 +0000
References: <20260504210610.180150-1-kuniyu@google.com>
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, sdf@fomichev.me, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, edumazet@google.com,
 kuni1840@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 2EC464FAFBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285962-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,fomichev.me,google.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  4 May 2026 21:04:47 +0000 you wrote:
> bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
> but RAW socket can bypass it:
> 
>   socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
> 
> The same issues exist in other bpf functions:
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
    https://git.kernel.org/bpf/bpf/c/481c2265286e
  - [v2,bpf,2/6] selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
    https://git.kernel.org/bpf/bpf/c/d73549b8bb7f
  - [v2,bpf,3/6] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
    https://git.kernel.org/bpf/bpf/c/7995b216a731
  - [v2,bpf,4/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
    https://git.kernel.org/bpf/bpf/c/decb84b8383a
  - [v2,bpf,5/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
    https://git.kernel.org/bpf/bpf/c/843064b0a77e
  - [v2,bpf,6/6] bpf: tcp: Fix type confusion in sol_tcp_sockopt().
    https://git.kernel.org/bpf/bpf/c/1c2958e4ab1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



