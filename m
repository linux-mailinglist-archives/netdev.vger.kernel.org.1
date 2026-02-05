Return-Path: <netdev+bounces-256951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKu2A5whhGkDzgMAu9opvQ
	(envelope-from <netdev+bounces-256951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:50:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E6EE93E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B558330154AC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3B2652B6;
	Thu,  5 Feb 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJAWdQvE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1C2609E3
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267015; cv=none; b=PUBbp+2LdsPWQWWsggc9BqmGtrJmM354OmMbwELu/18mpgZWG4IYvIsohmDKc1E/cbr/jU7KR8wd1yUEDvI0PbYBCWonaKanCnTS6EpeRX5jN+7jrf+CJxfIwmhNPH1Lq5+ZoV4jRkoCNz04tVA/BHbLPhnRWQfeAAR5O+rnx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267015; c=relaxed/simple;
	bh=BRt+14I65dDVqlbm+6vDs9KanhrqDsLvKqjo5xWV4to=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TWP0o1nW2DAArmUdiAkK8yPmakEDuVmgF2r3pkkd6fqjb+dOa16VrbC9ybrrabA5YEYZ/lp30MFhmT/cKfm73C57p43THRFuy5NmGw6WOcEXCZZwWz3X3diiirVUfln8b91YhlUknvhitJjP1qDCd3f+UC0veueBvqQdrYr348Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJAWdQvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BEC4CEF7;
	Thu,  5 Feb 2026 04:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267015;
	bh=BRt+14I65dDVqlbm+6vDs9KanhrqDsLvKqjo5xWV4to=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JJAWdQvE4xfZk7IcpYawopel2UD10xZJaDwNhUEylSsIudcMfBxm/fAIV8+vj59rH
	 q+4JuXmxd7k+eN+iBiMoOGfKRkmU9LYtKYckYgiXSrYypOy0XBOuatYa7KdtO4tvJh
	 alECBAneAjoukUD7zYVKCjxo1Z2tKWqr1DzkYGXKX3ENIjTg5o8f8Ly3D1Dn7hAz4c
	 cBgOfk8RHr23mj8l87i0/uB1fmiWaDqD1E+UJ6HL6HxeWfIJyOv8bXs+FzDvuTDdqJ
	 DN1/A/UFsp4wX9SbZCiDhRJ3kOrRJpxO+CvnzfMYvU3rM8HV4aspRJ5f7ms//GwP0N
	 QOxLFN72QYQVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C21A73808200;
	Thu,  5 Feb 2026 04:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_fq: tweak unlikely() hints in
 fq_dequeue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701332.165764.9055894497445200011.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:13 +0000
References: <20260203214716.880853-1-edumazet@google.com>
In-Reply-To: <20260203214716.880853-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256951-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E2E6EE93E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 21:47:16 +0000 you wrote:
> After 076433bd78d7 ("net_sched: sch_fq: add fast path
> for mostly idle qdisc") we need to remove one unlikely()
> because q->internal holds all the fast path packets.
> 
>        skb = fq_peek(&q->internal);
>        if (unlikely(skb)) {
>                 q->internal.qlen--;
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_fq: tweak unlikely() hints in fq_dequeue()
    https://git.kernel.org/netdev/net-next/c/acd21dd2da19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



