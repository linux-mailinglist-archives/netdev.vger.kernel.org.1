Return-Path: <netdev+bounces-300928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AsWiHRJkOGp2bwcAu9opvQ
	(envelope-from <netdev+bounces-300928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:22:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8C6ABBE5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fz7Jki9W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300928-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300928-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71EEC303A24B
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49697377034;
	Sun, 21 Jun 2026 22:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49E374A0E
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 22:20:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080432; cv=none; b=arFSpbZNkJIPKKLRuc65ad+skX+t9D4d+ZRqjqsGlycSx9K1X7Ozrx+CXC4fq+3xN9F+8EPHaQyoXZgPe3rE4HSauOQ9e6z8DfvYQkm7DrraO27iVtpWI/rKdkhufjgwWjIt4Z4YMkfiJnGAfy+rBRkiz57b8DNaV8FmU5dRezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080432; c=relaxed/simple;
	bh=P9Z2zXKY4uziv/NsoEBs0CXkYe3pcV5x3EvO8+XNb+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BQLyU+YRr/MTCh4K7wuLrUWKUm53KDQ91OgoKzYRxEu9dR+R2R0VVXhi2NpwxlZn/LuMQCmz9h/eQ8HhP3vFUECHHO2NuulBe+tix8oNdQAaZKvo+nYuYLF8mM/OdkDuqkgWWogo6ta3wwGbGQozFwwX/dxFKvUOimnQ0Eog73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz7Jki9W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F01F00A3A;
	Sun, 21 Jun 2026 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782080428;
	bh=iGhCX7nVBCzpVYU7WOdwE6u1flM0yS+pk70INf4ABPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fz7Jki9Wn4ZAVH2R9XkCLkF3gckwdHmzKWQVNXaHSn5qyAPQZKkX311tXXKU+SGE+
	 JPq5yKUsAbGSfLgP6tuk3AOgIwDOcJ0YW26RE3Gen6bS1lsqoVV+F8yAk0oV7Lh7Df
	 ACumfI67MmJveagpf2erbcBsuaJqw34jgMXdHi1S3WpZ/FnPzGOO9LEgvgbctFj7pq
	 UgAQBXkYsxtoUf5BWpJ9SjPg5nnmILQZzsOyQeq7g+71YAOeoKIAPJyPN37dku/sg5
	 xH5OSWwlk7UDVhdaDBbAk6C6ToO8p8ngWkTltrxsX/dKfGocqioWTkNev8X/Rdoxar
	 5G/wBmA3/LRwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B93AAA6EA;
	Sun, 21 Jun 2026 22:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208042004.521994.1468591358072405119.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:20:20 +0000
References: <178194366700.2485734.5368768965976693502@gmail.com>
In-Reply-To: <178194366700.2485734.5368768965976693502@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, joe@dama.to
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
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org,dama.to];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300928-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:joe@dama.to,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDE8C6ABBE5

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 16:17:44 +0800 you wrote:
> In airoha_dev_select_queue(), the expression:
> 
>   queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
> 
> implicitly converts to unsigned arithmetic: when skb->priority is 0
> (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> and UINT_MAX % 8 = 7, routing default best-effort packets to the
> highest-priority QoS queue. This causes QoS inversion where the
> majority of traffic on a PON gateway starves actual high-priority
> flows (VoIP, gaming, etc.).
> 
> [...]

Here is the summary with links:
  - [net,v5] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
    https://git.kernel.org/netdev/net/c/86e51aa24686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



