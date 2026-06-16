Return-Path: <netdev+bounces-299974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JUwkDh/KMWqQqAUAu9opvQ
	(envelope-from <netdev+bounces-299974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A869589C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oqNcDhSv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299974-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290D6300615B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92403AB460;
	Tue, 16 Jun 2026 22:11:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DC3A7186
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:11:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647900; cv=none; b=hZhxPG0gAUeIKqgFnBQWEmNdq6bxuJrnciGIm3n+fntkzjbNvmFl4frI1z0L3wCImFRssmgrSadnvO5+oo+i6ZI83uM0/g9Y78WVk3D3ZoLfEXAFA5bhSfW+8rvSqEv+BMEZu7ApsDAfDQVL3V4D6coyPgXJaoy3RsK7iD9luio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647900; c=relaxed/simple;
	bh=qXfdMR2/sv4YBtwsShrng4036IsJNjwyr0eLQQfPPF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OwxgUdnrUSX2X9xceIEMu6WoF6xS/yocEzmne5o23lJOouQghFH/nUYcOvnRSnBV9AvyQD5sMSt9hUVw9eGUq4BXO/ybvl4iG9zecREruk8sS4EeitAhEXalaVv98Au4m5fWeenHK2ruyk3C9tbRisSJIrBtdpWp+RthsooB7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqNcDhSv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687561F000E9;
	Tue, 16 Jun 2026 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647899;
	bh=pHw0aVCwFWx/V7j5QiDaAmPjq2DsGJ1d+d++pb2rzB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oqNcDhSvheRZ0rVVxvm4Ftgs7gWXT4j8FvnkzIIkUzhs6GabADqZsJTWqWmYqjtzh
	 ghMhxXMflJk6lN6Qt5FkaWChshwIGHzZnf5jjj6fpyEcD1SAto2EcC4XIrtifbyYBQ
	 s9+NRRJTD+Tk00lKKeqvfemxAwXR9qSdXtZIU2zAwdUc1hTZFptkRgjB088pgN/Al/
	 T/sherzVfWN26TWMehesWszd7xvfOVY8v7MPuoY52lbQCROZ7bDd5fCDgHUkPpnY/1
	 oexK705xt/yuvJDTB3SjvwMPtxMSmpNo5OkYZhe5kuU9ks9SYUV4yqrnOsdJV/z3ES
	 MBm+oZnXjy8yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198383930C2B;
	Tue, 16 Jun 2026 22:11:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix QoS counter configuration for Tx-fwd
 channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164789356.1259509.14649095510823015681.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:11:33 +0000
References: <178160712947.2156222.3765685889775458986@gmail.com>
In-Reply-To: <178160712947.2156222.3765685889775458986@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299974-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B01A869589C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 18:50:29 +0800 you wrote:
> In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
> using register index (i << 1) instead of ((i << 1) + 1). This caused
> the Tx-fwd configuration to overwrite the Tx-cpu configuration for
> each QoS channel, resulting in incorrect QoS statistics.
> 
> Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
> counter configuration.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix QoS counter configuration for Tx-fwd channels
    https://git.kernel.org/netdev/net-next/c/1402ecccf563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



