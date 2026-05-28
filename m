Return-Path: <netdev+bounces-292521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pm5EmamF2oaMQgAu9opvQ
	(envelope-from <netdev+bounces-292521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:20:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E55EBBD0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBF13015E32
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278142DEA93;
	Thu, 28 May 2026 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7QNWo83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073811F5858;
	Thu, 28 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934802; cv=none; b=Qd83RXVQBo044MwLkX+9ckfBdI3OwzXhQqU1XKI7mo13ykqvH/SfJinC6c5inr8nju0jD/OlwxCRtyS6NLkREfoLh9ymwUt6gB6bVtJJ7pW1cZZcVvg74eVKzhTLrSoR5ePoC43+OONskOhtBNTFqR5mMTBGEHnXYUd8r8FOgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934802; c=relaxed/simple;
	bh=HOzg/dvIeG9Ja/PqBbxkp2vf7WFYqBZXngUSeC85kbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gzMEQtiOSu7N7/gPDPtFG2zl3xqJ0Lk/BSyueiRYvd59NCHppgxKfK1AImvK6UpVIU6ylk3csvsWoC64kTSDWm7Y278CXGwj84xX+uUaqqWBhSBfI5VOf7ZwhYNQnXM/FSpQ/gUkYrSsTUQcgLtUczDWyRcYjOAkhpv5DF0NnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7QNWo83; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36641F000E9;
	Thu, 28 May 2026 02:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934800;
	bh=yvDJtRypZBbxQi7iTRMpFHJ0Xf2K73yxjqlzagEc4gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j7QNWo83+F3a/ytTipCx7AhNtYhgN25axFQH8Kb5PGnLTWbyvXmQOjhqrSLpWB8sS
	 LhdVvj1M9vT6kouEktnTnBNeq3gUNKHGvFLpddKv34K6Lv1LbrGU9AZF30a3LqGX+8
	 91g7DlB6C92ZVNFwkQos08CzyCcm9HaoWkvzWrDuJQlJNTSge6obt1FB6PJ9ZqTdey
	 SIn3IruzrjfJ4KPAdqJr3Gd2nx2MpAODCKQXaNCN+fE/RMwDh+5GjedmxjLg53jWt/
	 zXNiKGVDzfXmLolTFdxwvE9SPxrTrxzgsLGoPJhdXYR273ANU/Jm8JwVVFlS9ehcTI
	 8UNEPbQxeo6IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F44380CFF9;
	Thu, 28 May 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: rpl: fix hdrlen overflow in
 ipv6_rpl_srh_decompress()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993480564.718177.17841853640746767104.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 02:20:05 +0000
References: <20260525154031.2290876-1-rc@rexion.ai>
In-Reply-To: <20260525154031.2290876-1-rc@rexion.ai>
To: Rahul Chandelkar <rc@rexion.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292521-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C17E55EBBD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 21:10:31 +0530 you wrote:
> ipv6_rpl_srh_decompress() computes:
> 
>     outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);
> 
> hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
> truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
    https://git.kernel.org/netdev/net/c/9d5e7a46a9f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



