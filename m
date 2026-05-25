Return-Path: <netdev+bounces-291411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKwLABuWFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BD5CDB05
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561B7304CA7F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3B73F54BD;
	Mon, 25 May 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxdnH8hA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB33F5BC2
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733803; cv=none; b=IDB3e0n5GBv0qMTLetbidE+3SCQHtUW5uNCf10ST6MC+BhG2w/HzPG9pHGQizVa6GbQQFtQV/K5DaK6nteBHhSQrg1Sfx9SA/Im17ocVyJlgRe69vk8Cd+AaSlUM3f6MqSnRWc7eG/EehfWAT9Kpwce9lpqozFTU4SDIvQSlj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733803; c=relaxed/simple;
	bh=uhnZRO4wh2Vu25B8wvGzCCn3wriSGnv8ZHHQjcBnQmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lu2tQ5Q63yaRkejFdnXhsqTKLHw29YQApMwaAZkJOdKtXwqzYJnKCBvFC1cQKFqyB/RRRR0HtDDDZ+07JuX5Ver2Lkx3/ewGMAL7Qd+44Ik4yHDew0K6s662SreKo4RrTXLJ0FS5lXRmd0mj874vlZ2Zm1EjreH4mbFcsEj/fOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxdnH8hA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0641F000E9;
	Mon, 25 May 2026 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779733802;
	bh=lumSUw2Anh13SXjaRZT1TIeabA9y+3Y1e+pgzyUkpbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nxdnH8hAiTk6c9ji55jh/HH9ngRB4o+adlx+xN/5fxCbNuIkqElj236TtjEmjtu1t
	 j2uDcqJI6uquJtPluRMJwtvlp4MOZzNDgikT40hCsi8uhNVpHavLU2/q5ukckb9YnD
	 w+Ljj7o7rwqaTxC+yYxNaHjMiUEEXNXeooEJi5jWowJymO0yH6IAcYpdFFOXMERueQ
	 eJ/+n8/rLdY/w3tcMTsuRdcgIC3tnH/gmgecMcznp7AigycKoVaezRnjnuP5d6As3e
	 5/lbbQzB3Wjct3gvUAENCQNmHVuTpfMumwlrR1A36QfgLcg+S3AXgypw7hp+iLu2DY
	 bfw/z83DIHeDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E7B380AA75;
	Mon, 25 May 2026 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: sch_ets: make cl->quantum lockless
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973380839.3078812.14874980158429995031.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 18:30:08 +0000
References: <20260522110356.1403343-1-edumazet@google.com>
In-Reply-To: <20260522110356.1403343-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291411-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 548BD5CDB05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 11:03:56 +0000 you wrote:
> cl->quantum does not need to be protected by RTNL or qdisc spinlock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_ets.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net/sched: sch_ets: make cl->quantum lockless
    https://git.kernel.org/netdev/net-next/c/0f700d144b5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



