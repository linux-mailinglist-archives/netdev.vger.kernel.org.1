Return-Path: <netdev+bounces-285382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMuHFeGt/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:21:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF224EAEB0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DD83300348E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928E3AA195;
	Thu,  7 May 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOUOEleg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C863B775E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167256; cv=none; b=AkL1SPuQdl7yWrKfstVQWAhVQMmpO5oqX5C5tLoIphmGINerIUEu3330yRmXzbSyADZ1XJ74m7uYpGTYdPkxHwVzMJgSwxK6YEoWYlqh51dodtJ5rEUYL+Cc7QNdnl+RN0+02m2pHnjrZwlM6QT6ueBUXqIOjhTFbOMk9UTcleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167256; c=relaxed/simple;
	bh=OF+vlZlvOL9KKG8lwA0Gv/nZ28zzQP39fJfh9ulYM64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vh7xLkhLmR2rnIeWDCNWWkgfS1Q1yvgTJ2Hipg1fWytvZlc+5hN+pSwsv3UkiRU5qYk2nFpwZp7OH4sSywUyXSmbIe0+nO7OxplfEcvk+cR/D1S/59g0+aD/XvTGozd5TEsAi96waY4IHzvxN6ewUUBDdEBq4lGUh9SyzzEUwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOUOEleg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2DBC2BCB2;
	Thu,  7 May 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778167255;
	bh=OF+vlZlvOL9KKG8lwA0Gv/nZ28zzQP39fJfh9ulYM64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOUOElego3BPYUy5r1oZshVIvrfsEsXglseShWDzSd7N+iqiNYOwcUZi0S6FAe2qC
	 erbZ+jBp6aMUVVbPp2k7oJIOY0CAsMUNVIj91MgaEU9uot/FghJnfv53/3hdN7PpZr
	 AeXAjbYlXmtQZUSYACKY+ujChqCnQ2JGnMISNFy4rqM1ABaTActGxvRmknT9N/sEDd
	 rJAb6XwgwL3AppaDSXvIg5tav9jdS7h4xpjUlivuh5S3uSoTnN65ZplsuGK8bBUDEP
	 ol6gXacf2XhaUBSmtJbtxAIh+Qto/XtFkblv280mvZaBOmAFCTFEy0ds3sK/r0fH88
	 UFC6oJ27QVueg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5C3930906;
	Thu,  7 May 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc/class: use rtnl_dump_request_n() in
 tc_class_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816720480.4034455.16026111878922440843.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:20:04 +0000
References: <20260506160656.1226077-1-edumazet@google.com>
In-Reply-To: <20260506160656.1226077-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, jhs@mojatatu.com
X-Rspamd-Queue-Id: 6FF224EAEB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com,mojatatu.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-285382-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  6 May 2026 16:06:56 +0000 you wrote:
> strace tc -s class sh dev eth1 parent 2:
> 
> strace is fooled with rtnl_dump_request() way:
> 
> sendmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000},
>         msg_namelen=12,
> 	msg_iov=[{iov_base={nlmsg_len=36,
> 			nlmsg_type=RTM_GETTCLASS,
> 			nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP,
> 			nlmsg_seq=1778082626, nlmsg_pid=0},
> 			iov_len=16},
> 		{iov_base={nlmsg_len=0, nlmsg_type=NLMSG_NOOP, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=131072},
> 		        iov_len=20}],
> 		msg_iovlen=2, msg_controllen=0, msg_flags=0}, 0) = 36
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc/class: use rtnl_dump_request_n() in tc_class_list()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=eff6e4dad32c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



