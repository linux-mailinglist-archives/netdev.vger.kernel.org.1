Return-Path: <netdev+bounces-283316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z4C7KRhB9WluJwIAu9opvQ
	(envelope-from <netdev+bounces-283316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E64B06E7
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9BB3014653
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C11200C2;
	Sat,  2 May 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lddsY8q5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AC946A
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680661; cv=none; b=kLOGgLorfjmOhxH9iWbUEq9cml6VtE4eyPB+Z2QbJPTzsHX2QPr8DbWn9Hzt/OlRV1cioPnPUxPih7Dy1efudXOBHWlfAEzluqovDMB9qXOVnzaxBDCq3p2ioIOnemWedPOnPc7Sb0xRv4dKG9pjXHdTi8dyrnAY45NpKf1DMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680661; c=relaxed/simple;
	bh=ZkBin6z+2qaIp+WGP/MRx3Ck5A/H2d9Wikge40OFJFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2JSAL33Z7VLgJY+Ms2uEkKO5zwgVOVQLV90zbzMO+m3VV9qRLBF5XzgRz5JnL4Bea3aXYfJPd+OVWWT5m4dZ8+j90QAoTQCrr4CMoMTe7rII5lIZkDnQQ6jbPuAhjjI3tGLpSfW+Emw9UdNXnxl6wDcoWBdSvllKd33f7NGugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lddsY8q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62D6C2BCB4;
	Sat,  2 May 2026 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680661;
	bh=ZkBin6z+2qaIp+WGP/MRx3Ck5A/H2d9Wikge40OFJFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lddsY8q5bYPnw51fN+L1kcMCMIw3Hx4a4KfPePlYlqU4UnA7jnUvRCZSuMViRCd4I
	 wLm61stYJ2qiU1pu2K1rVzyRNtpfUHWhuAtGbdiQZeZnVx6PcmpnVVx2qSzCBKMr5D
	 bw2Ef0+BW7j6AkIhla4M+94Brk/ZIy6AJMOCmLqT3SgAC+strw2NUqIVhtkw0laW34
	 dh6jPw6X5uO8J2J5je6AcKMjjvVe05mDSC4nP9r1Qn0sCsg9n7qQxw5YDQQWMJ6gQ9
	 WXMOwattY7u3ounH8+U9cosPndpqJ5dn/RvMjKLMS8x7vhG83OErqZpC8LANZD2XJK
	 MnJjNKRozSIRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD46380CEF5;
	Sat,  2 May 2026 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipmr: prevent info-leak in pmr_cache_report()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768061407.3667015.8423281488846270004.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:14 +0000
References: <20260430070611.4004529-1-edumazet@google.com>
In-Reply-To: <20260430070611.4004529-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, yimingqian591@gmail.com
X-Rspamd-Queue-Id: F07E64B06E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283316-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 07:06:11 +0000 you wrote:
> Yiming Qian reported:
> 
> <quote>
>  ipmr_cache_report()` allocates a report skb with `alloc_skb(128,
>  GFP_ATOMIC)` and appends a `struct igmphdr` using `skb_put()`. In the
>  non-`IGMPMSG_WHOLEPKT` path it initializes only:
> 
> [...]

Here is the summary with links:
  - [net] ipmr: prevent info-leak in pmr_cache_report()
    https://git.kernel.org/netdev/net/c/4f34002e2e37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



