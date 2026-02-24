Return-Path: <netdev+bounces-260292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IlZM3QBnWnhMQQAu9opvQ
	(envelope-from <netdev+bounces-260292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5918097E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9C5305E33D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F513AA2D;
	Tue, 24 Feb 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIAYuTVI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FB1DFF0;
	Tue, 24 Feb 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897201; cv=none; b=WjtGSpsrUYrf0w2qS2eA2Uq9gk/NtQhXMFFU27B7fWyxSOKP8RzMyIRYogeSnrx6tbKz088cJiOpax0K6jsgUG0oZYg7jQ7vjXsZ8zz6DlTe4nekOUUEI+gG/fwv8S+YTf8vgpt9wryfHF6jJ/CbElsmKjaFxqs2CvHh+YkD/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897201; c=relaxed/simple;
	bh=PaaIM9TjlOResMgfmjqmyCxMOqPKh7mT69EdL2KWmao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zz53TWmGQO+7ZvTOuUInRIsZjUM/5bDNgnr5dFGvfDXijkEZ5a0wd0G8KhRat+sbq/LeCXfiRvt0xoxOlaIKc54H2wgKxKkobvqukvk607gYvWLae5Vk0HZkP4jIotI4iEz11QhphZPrjpbDtf12S4ZQNC5dAymH8Xhid2YNNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIAYuTVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D82DC116C6;
	Tue, 24 Feb 2026 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897200;
	bh=PaaIM9TjlOResMgfmjqmyCxMOqPKh7mT69EdL2KWmao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIAYuTVI70HxdVJCHRoE8J71g68218YNQa1gzfpFNVf82tl+pqRDeo4+8vLEwGqlz
	 eH2cavfb/SsXn5zTNEcaJ8Our7cQFvdoBKurxyrfYBhO9bgl8Pxhz8rnIwXXA1eVgb
	 NODKLnTMw7T1P5zM9UAtPU9VToZRHOPkrsAFXlCQGJOocPHJ1DuvCA1yXtLd+fnvbN
	 sxhe5/azINOOFC1Nag4c2QQfgIqhrvNl7FzIN/pUwIzOUMpMwRm6uWL4jEZjqdXTDP
	 bqxL+cWdl/Vk4tAfc4/1Vaq6LUmai0feEaFv9kSNwKWrWnIRz6dv3A4CeL+tLVWzCH
	 3bWZA1ex8ALYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EDC3808200;
	Tue, 24 Feb 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] kcm: fix zero-frag skb in frag_list on partial
 sendmsg
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189720655.3267776.15644480509683053572.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:40:06 +0000
References: <20260219014256.370092-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260219014256.370092-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, jiayuan.chen@shopee.com,
 syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, mhal@rbox.co,
 sven@stegemann.de, brauner@kernel.org, tom@herbertland.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260292-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,52624bdfbf2746d37d70];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 26B5918097E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Feb 2026 09:42:51 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzkaller reported a warning in kcm_write_msgs() when processing a
> message with a zero-fragment skb in the frag_list.
> 
> When kcm_sendmsg() fills MAX_SKB_FRAGS fragments in the current skb,
> it allocates a new skb (tskb) and links it into the frag_list before
> copying data. If the copy subsequently fails (e.g. -EFAULT from
> user memory), tskb remains in the frag_list with zero fragments:
> 
> [...]

Here is the summary with links:
  - [net,v2] kcm: fix zero-frag skb in frag_list on partial sendmsg error
    https://git.kernel.org/netdev/net/c/ca220141fa8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



