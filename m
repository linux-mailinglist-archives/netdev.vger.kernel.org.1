Return-Path: <netdev+bounces-306498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IPhXEjnEUGoV4wIAu9opvQ
	(envelope-from <netdev+bounces-306498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:06:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C4739717
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gjXm91pO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306498-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306498-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047A230131FA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F03FC5CD;
	Fri, 10 Jul 2026 10:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41027FB18;
	Fri, 10 Jul 2026 10:00:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677655; cv=none; b=JDH5UmBsL6xZpM/V1Ank7vQDZU4JtzMkahOxMLq+Kaa6u+/cWtvA0z7sCo/RXyFpY9jqpRlBmAnULz1QLSu8SKJPw1wYvoSjSRwfg4L95l4zRGFaokyBKBVId5vk7GrkR1yGr+VUxIY9/6iu2e5Fo9IpR8lzMdpO4c8oBYLhPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677655; c=relaxed/simple;
	bh=EtmPUHcRvdHeZmHMBbKSfuWvPQbB2lI+zq2exzqfSno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AuFgimRQbXdG4pZ2Ar8rllpdDOriXq6Bv8wLDkDFO36ZqQp8O91Nx4fHqyw7+O3TW8djb7r5FerJWIPNiADL4Ycr2f5mMVW36m7yUk+NrxweeIkI1KSEcRCHWcp7QDqcl4FktJIVfifblPMnriXOuRcfXYh4Bord5IaOVr2A3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjXm91pO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334871F000E9;
	Fri, 10 Jul 2026 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677654;
	bh=HzPqK4xMTB2qqBgyyqGaAQo0knBfJ2oc1EJuW1FOnNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gjXm91pOJcwSsl/qH4F4fQ0psvb8fmy5DPplFFcGeTJoJjp/zc5dTyDac0bTBML7R
	 ELopZ/rio8QX3XRU43v9Yh0G+HZn+xXWTgdUId4HQvfIQeyhYSGz9nGUpQQg7tE8t0
	 Eq/0K2slsxuu1F05ZtbnguDNgltxYrDhD8YepC54WA4+zNjdqBBL709mDlgIf8IRyE
	 Rr7gXgwXJ6V5oZoO1e0iHw/eK3FxqN+JSvxfd65nRzNwNFBkiMXs3jY7adVOn5OB/T
	 e14JuwTAs6VUwtvzJ4zOST/NL25kUhJ+As05gvyXLvZQTzF/aFe8ZWDI0K6FHZMi64
	 w/58Em2bf0QnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 60E903924A7B;
	Fri, 10 Jul 2026 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/5] bpf: add icmp_send kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178367763213.156295.1145469306231918635.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 10:00:32 +0000
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io,
 martin.lau@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
 netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org,
 sdf.kernel@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306498-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA0C4739717

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Jul 2026 14:48:55 +0000 you wrote:
> Hello,
> 
> This is v11 of adding the icmp_send kfunc, as suggested during
> LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
> actively reject east-west traffic, similarly to what is possible to do
> with netfilter reject target. Applications can receive early feedback
> that something went wrong during the TCP handshake.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/5] bpf: add bpf_icmp_send kfunc
    (no matching commit)
  - [bpf-next,v11,2/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
    https://git.kernel.org/bpf/bpf-next/c/39b337a3d995
  - [bpf-next,v11,3/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
    (no matching commit)
  - [bpf-next,v11,4/5] selftests/bpf: add bpf_icmp_send recursion test
    (no matching commit)
  - [bpf-next,v11,5/5] selftests/bpf: add bpf_icmp_send no route test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



