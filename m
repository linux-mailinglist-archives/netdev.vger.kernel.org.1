Return-Path: <netdev+bounces-304363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TqUhOwVXR2roWQAAu9opvQ
	(envelope-from <netdev+bounces-304363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B426FF16C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YFjcm4RE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304363-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304363-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E233020ABE
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677E35B62F;
	Fri,  3 Jul 2026 06:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6545039;
	Fri,  3 Jul 2026 06:30:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060224; cv=none; b=db4XCdCy5yNo+h03S4iqG8FauvbYvSWiB5DBi/s/7zmm3lZnM7YQILndzVuw7fhwsIh+jgIda+11I3d+wq0g5+nswD9iTUclgs1I9owb6HFaiO0rse8Nt4GoTkY7DoQ3o3HfjRtG6uxwScuEhplq1Mx80JWNO0wvUcMM0m/wdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060224; c=relaxed/simple;
	bh=qHVWz9a9qHi1kznZy40KgMD6Gz+Qk0Nhid1bNn1ki04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dkyds2k+ncXy2Yph3IemdLQjnQWH7y4DMOJUHT6Ez6O0r8IbTac027HZeY3qYrrtKSilyqvhdsY94nPO2h2nUltEPURu3L9eXGujGKQjcvZ1Vt7tRif+v40KM54TrFKOURy3Mmbjw+CLumzAfHbLB87pHwAiYtczRL5HSGGzsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFjcm4RE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D861F000E9;
	Fri,  3 Jul 2026 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783060222;
	bh=aSYWmxj1Ti9dl2kQB9GNGQQQVUGnqQ77vIa1gpjIXzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YFjcm4REEXcvFzwbfORBk430XASBcFLw8Kx/0gddFGKhtU3O9f+C/osFUpGMBizbH
	 Rv/vjD7w3Sn8NCm6tuHfN+c5cw4L2SLFVoKptNDWd3QxEm6pkgLpsgzgUZw5dZ/ASw
	 67+cEXvIIQarpPXLLbaGpKCEk3EcBWBkgAByl6lrNQbZOxc84x9gtnWqq2SreND3Ht
	 uyx7YfXGiIU1agy56zXNVZzEmp3xY7GJdyEugtfAJI/t5XkdgGqB1SxQ5KYLzIJE9t
	 60d061RfVv8akf34wSOhjpb69XFaGcxovYAsO7HYPdJl+kAq/XjsoLbgoE08jul44U
	 hjTDtKiJKl4dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391E393878E;
	Fri,  3 Jul 2026 06:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: net1080: validate packet_len before
 pad-byte
 access in rx_fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306020539.2481588.14914753209820717165.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 06:30:05 +0000
References: <20260630045121.1565324-1-xmei5@asu.edu>
In-Reply-To: <20260630045121.1565324-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, bestswngs@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-304363-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B426FF16C

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 21:51:21 -0700 you wrote:
> For an even packet_len, net1080_rx_fixup() reads the pad byte at
> skb->data[packet_len] before the skb->len != packet_len check further
> down, and packet_len is only bounded against NC_MAX_PACKET. A malicious
> NetChip 1080 device can send a short frame advertising a large even
> packet_len (e.g. 0x4000), so the pad-byte read lands past the end of the
> skb:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
    https://git.kernel.org/netdev/net/c/03f384bc0cb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



