Return-Path: <netdev+bounces-291701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOtULfuhFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A05D69A9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BD1B3007977
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF63E0252;
	Tue, 26 May 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVaX3jWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9922D4E9;
	Tue, 26 May 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802547; cv=none; b=faEa4eGKgZPrfN7r/2tU4efXCQfTfTtfAjJOIl0m7xMRVBfCQLy6iD0J72m+BgYWf7vnGObNA8MB3W33uDV+nWn1bQZR6fzIYRuWJrh26A6Uj3lYrlHYeY0W4NyWyAT8HnWqPNYKTh0MOrASJqXcf7lX0FJYxNsPqD88c1nGU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802547; c=relaxed/simple;
	bh=PSSGPO179pCLOA6P7m0UwOmiKXa/3cLeHSkv0cKIpt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7QQB00J5ZNO8bnTTIOmSoK+gz64WJLx/nj+jD4+pqPwRtKv9JLVt5U+NU90A+LQJR4B7wJqDI6alb0QI2hZID1Pkuvs0dMwz92g6+ETBfBeWUF74wkiYolh/cSqwxUQDD3ELyGHnd83gR30V6GnESm6ID5u/OdFNdiHtx31osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVaX3jWv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2DB1F000E9;
	Tue, 26 May 2026 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802546;
	bh=SNU9HmIak8A7LxJioBhx2vl3t5cvShoWRf4tubGIfbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RVaX3jWv4tNuAdxnlClpNngpoHL7Yj/Ajt9C+8D6PDcFXnjRx+HeIMop1Z1KXpAan
	 FSTyPdbjm749wpd/qFCp71niE7JEuOQbcYgsEodeTs4pcutMO5VY/AvnhRnocS4aal
	 0Tjzlir0Pp72uD2mOd2q5jGkdJRSo6bYC7EG7eKln1qDoynomPQSL5weck746Kr0nu
	 2jCIYo+A9CMNcO55G3uoQ5p51zPEdMXB10IuPlG9xLMy+cxp/sFKRZ+Sxh080c5D4a
	 vcQBjQ3Zoz5Q/2McGG1lXqZkz0ZRGGsBF1VPMS/ff4QRsybAHFyFTlj9rCo0peKArn
	 wPCAJ2Q9U/6sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A34380CED3;
	Tue, 26 May 2026 13:35:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Avoid checksumming unreadable skb tail on trim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177980255215.3372351.8251686694284496132.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 13:35:52 +0000
References: <20260522120643.242974-1-bjorn@kernel.org>
In-Reply-To: <20260522120643.242974-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 willemb@google.com, kaiyuanz@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291701-lists,netdev=lfdr.de,netdevbpf];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 357A05D69A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 May 2026 14:06:40 +0200 you wrote:
> pskb_trim_rcsum_slow() keeps CHECKSUM_COMPLETE valid by subtracting
> the checksum of the bytes removed from the skb tail. That assumes the
> removed bytes can be read.
> 
> io_uring zcrx skbs may contain unreadable net_iov frags. With fbnic
> header/data split, small TCP/IPv4 packets can carry Ethernet padding
> in such a frag. ip_rcv_core() trims the skb to iph->tot_len before TCP
> sees it, and the CHECKSUM_COMPLETE adjustment then calls
> skb_checksum() on the padding.
> 
> [...]

Here is the summary with links:
  - [net] net: Avoid checksumming unreadable skb tail on trim
    https://git.kernel.org/netdev/net/c/2e357f002c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



