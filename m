Return-Path: <netdev+bounces-267123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBAILF/asmlMQQAAu9opvQ
	(envelope-from <netdev+bounces-267123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14003274470
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDC330C09C3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC4363C4D;
	Thu, 12 Mar 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B31WOPL8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DD2E3360
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328809; cv=none; b=nMVs9XaEvV9/dbaTCddNnAt2Q9ncvMnx0cI2loTD/OFvzv2ZbGasWtGzZ/Te7d7kQmWP3k+1OVVvv1zOaTLBpAKL8IRmUZq6da1Obg5qcYDXXyyI/0VyRY5zVyVx7SuUXrnWQp9uD0m557Pm5UtciACRJApEjW21JyDRojlPeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328809; c=relaxed/simple;
	bh=5IvgrFCFCLQCWe25LzOFKnBhdrdAS01kJKzNTWTdu8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTyylNhULUHqGD8yf1H7+eN91FddV5DRwOsCjngYqLUCBNERPOweHchlX4wPyHHMfngCv13DUNUnTNbOv1gYXk93Jhkqk0+5mr0KXaXCo+bH4LvzVVfStPfD7p2FNSAJZ8tzycnhG05qKMoyx63I9RMqHXVuedajW3Ef568HLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B31WOPL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056D0C4CEF7;
	Thu, 12 Mar 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328809;
	bh=5IvgrFCFCLQCWe25LzOFKnBhdrdAS01kJKzNTWTdu8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B31WOPL8Ynk7Kg2oan2dwpKy/m43UBp9tuPuIErh0uiIT8jfegIgPl0T95kXJS5aA
	 bNJHgfAPKIXN4uNHe2dRfCfXyn7PwD+oIN2Wt2u4uuqw4CrAc2YIDACv8PvEkRFZh4
	 I84IL3R1ln+YttpLjNK8crRJ1tAjKwjGkFz19t6uuP7Uv+b23619NE38EMd+ZaRUYA
	 gXfx+VdQj0UTijJEdF5fWMz/aTW7kKB2C2a3xGoKv5MwlN5PtXw6WSVMxQrRkc8W6K
	 hmqsW2UhxBKJUkSt3lih4IaON5qbBaDkh4llgZEMtMaLWEepjyaqT40IXylY0wiRav
	 IT4i50gc6twhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2A63808200;
	Thu, 12 Mar 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: prevent NULL deref in ip[6]tunnel_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177332880455.4146563.9711657993638461972.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 15:20:04 +0000
References: <20260312043908.2790803-1-edumazet@google.com>
In-Reply-To: <20260312043908.2790803-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, bestswngs@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267123-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 14003274470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Mar 2026 04:39:08 +0000 you wrote:
> Blamed commit missed that both functions can be called with dev == NULL.
> 
> Also add unlikely() hints for these conditions that only fuzzers can hit.
> 
> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> CC: Weiming Shi <bestswngs@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: prevent NULL deref in ip[6]tunnel_xmit()
    https://git.kernel.org/netdev/net/c/c38b8f5f791e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



