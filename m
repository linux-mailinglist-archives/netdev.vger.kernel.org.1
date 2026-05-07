Return-Path: <netdev+bounces-285090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLisLJvf+2nLGAAAu9opvQ
	(envelope-from <netdev+bounces-285090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD474E1BFF
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC4D300C935
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE2192D97;
	Thu,  7 May 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Skg6Yh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6F4A07
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114456; cv=none; b=q/9BazA3a/N4f9jigwUWBzvKI7+7c33v6uZFOUxiL6/ls0ZMnE6QHURcYYjo1JoeyqIblkkf1fpnrx88pi2OBqDmFGrn1cPWFmyPhRxswkMEvUEc0S8Ozqp6FuAzs6PC8U9hgaMw2t9FBZLJg2ZJKai3v1Li35uMjPPiPdGcNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114456; c=relaxed/simple;
	bh=I86N/BV5DsVD8OGYu3BdJNS1nik1aOKYwvET77Ii8Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LDe4KUsjrDKJkObrhDmfcdo7ilSOzyk9vVrqXKQL2pNPDS/WxbxGWe4RuhYMxcrya6gLAN7/fMb8aH1yFkpt6lUGe84Jo0f5OqVtEWWi9EYlD8HcKlsIV0GT9X0jCNTLpRXzq2Y2BdDsgfcTjc/Fmc9WJGerfmZfYz1wRoLilG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Skg6Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB6EC2BCB0;
	Thu,  7 May 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778114456;
	bh=I86N/BV5DsVD8OGYu3BdJNS1nik1aOKYwvET77Ii8Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6Skg6YhU5a86EzsY3MOUs0BeyJILrqSp87W61HcPvYu/P6C+d7o6Hd8z3CTpYa6W
	 AT+GWvBhAbtGxoG/zAAwZtU16bb9eHq37VTAVsZE3x3Mqg8QN8sISBQpARHeFHhZfz
	 zJkVbqNPyUaMFHTocf7VixYjx3jnK0sd1lneu0WIVRP5lJjco/A1vZC6TOCMaKJe/p
	 wcXmy0bHqEQc00AeuZl9Mptz5r9JsKN5eukIUCZ1U2nhGKPWiOCqb4V15GlnX4lvn2
	 6wrl1/QB1XXBNBNEhZkvde+2ghhQN1sGnFYxUgTLHpHw3RfiJVUpZ5yzJ1dzHG64O1
	 Ng7doCLitjDFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BEA393089F;
	Thu,  7 May 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix potential UAF caused by
 ip6_forward_proxy_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811440570.3278368.4185578549317990881.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:40:05 +0000
References: <20260505130056.2927197-1-edumazet@google.com>
In-Reply-To: <20260505130056.2927197-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com
X-Rspamd-Queue-Id: 1BD474E1BFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285090-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 13:00:56 +0000 you wrote:
> ip6_forward_proxy_check() calls pskb_may_pull() which might re-allocate
> skb->head.
> 
> Reload ipv6_hdr() after the pskb_may_pull() call to avoid using
> the freed memory.
> 
> Fixes: e21e0b5f19ac ("[IPV6] NDISC: Handle NDP messages to proxied addresses.")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix potential UAF caused by ip6_forward_proxy_check()
    https://git.kernel.org/netdev/net/c/7aaa8f5e45a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



