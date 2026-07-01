Return-Path: <netdev+bounces-303410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id did2DplYRGr5tAoAu9opvQ
	(envelope-from <netdev+bounces-303410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:00:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF16E8BE2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:00:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HGVFGx93;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303410-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBB2D302D4EB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79255330B01;
	Wed,  1 Jul 2026 00:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB08284B29;
	Wed,  1 Jul 2026 00:00:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864023; cv=none; b=Lz+UPAUupt7nipgN4NHpRirV0e8xvB7/KKpghwi3cGx4+FHOcOVEjmHuOFu4olKWmO5BjvaYkHtHb8+4lepxxAhJ6tBMxYqAMVM/INpz6h7PDMpIkcOqltS6679Waabk1QyJxXLoewfBXaTlp3LLZlbu6Ygud2fKvAR7XIh0y1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864023; c=relaxed/simple;
	bh=cl3Iat4nUIW3kY20Flk8kF90PyH0SDbaQoW4rPAYJx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihwrMNeKZw/XIT+gE1o3VoN+lL8GlfwTEN0Iy7hckbA99zWK8Y9jPZVtXjnS9AQCY6KjjR/jLjrkqg0Mxkp5CVC+a8l284XSXx/eLNJ0P1L/APxTDGUTxWIcQLeC/f2HluP0FapcwBjIUPITgsikPEO2ZTE8evBFra6P0mcq78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGVFGx93; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A11F00A3A;
	Wed,  1 Jul 2026 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864022;
	bh=LShLHA0wxK2eW4t/XdclT0v1hf8/BEGAbO795ip3YEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HGVFGx93YPWO2GmYsvGZrVHOuhN8EsSEQlbKFZwG7GlecgBfCQUIMFY46f7H0bwob
	 Rm53bv/6MMhBU4geKOFlyng3LHaEjcCqegFRMXGuBr5Dhy9CoP0vaFYNHmAScleJz3
	 rf82NFh5+iDAx4l72Myqc4qkLKe4hT32GO7aVyvdFPKaL6HfKLafA2lUCkdPvkEKoo
	 IwEs6bPpkJNfX5EQhGvXkrmv1+wLyDj1SEPHIhuGZ7ng3Ku62dy7gFt3jeRce7lkDa
	 Z77xQFR11XMxs2/0624UKNtM2yjhbIiNGBHg4gN0RzxB3Cvnh3IpJC7f4/fVAqPGHT
	 ZfCjW8hz0sQBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19664393A963;
	Wed,  1 Jul 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: bump default cmd() timeout to 20
 seconds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286400564.341356.9563391960804788182.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:00:05 +0000
References: <20260629233348.2145841-1-kuba@kernel.org>
In-Reply-To: <20260629233348.2145841-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, leitao@debian.org, dw@davidwei.uk, noren@nvidia.com,
 gal@nvidia.com, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303410-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:petrm@nvidia.com,m:leitao@debian.org,m:dw@davidwei.uk,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0EF16E8BE2

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 16:33:48 -0700 you wrote:
> We always used 5 sec as the default command timeout. But soon after
> it was introduced, David effectively made us ignore the timeout
> (it was passed to process.communicate() as the wrong argument).
> Gal recently fixed that, but turns out the 5 sec is not enough
> for a lot of tests and setups. The fix regressed regressions.
> 
> In particular running reconfig commands (e.g. XDP attach) on mlx5
> with 32 rings and 9k MTU, on a heavily-debug-enabled kernel takes
> more than 5 sec. The XDP installation command will time out after
> 5 sec but since the sleeps in the kernel are non interruptible
> the command finishes anyway, leaving the XDP program attached,
> but with non-zero exit code. defer()ed cleanups are not installed,
> breaking the environment for subsequent tests.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: bump default cmd() timeout to 20 seconds
    https://git.kernel.org/netdev/net/c/57bb59ab6fa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



