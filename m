Return-Path: <netdev+bounces-299086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sy9fHFzjLWq9mAQAu9opvQ
	(envelope-from <netdev+bounces-299086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:10:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27768001A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dSYMmOtK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299086-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299086-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA573014523
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7145438A70B;
	Sat, 13 Jun 2026 23:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED2331222;
	Sat, 13 Jun 2026 23:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392214; cv=none; b=BeNwSgj1FRWbiVrBWiBvk74QTZwgDpXscQbAYfe6nJyndRu2FyLYl3ayT9UrCKrdBJfAUBhJgToLhRYkjNOEy91BS/qBVdt7J24tfHelT+EFfVcP31xygo9SGkduSIaXZjwURedvH1gvICYsO7RwznzlosSE4a8VGrJS1M9co1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392214; c=relaxed/simple;
	bh=Pf+JPilGVfEbynN26XqwaHtTSYoFlhksdL2CdPTziQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+IFaZIxhVQhvIHSU+rpeIf9gN5P3fuVK2BHmYd9mZU4ccGZ7cPP2qu6aarS/8hVs9+Jmfe4i33QxLoojrl5Spe1/aJOrt/38oEPGr/FgNyrZkpwf2VvfDRch1FPqNj5ws+qUwfYB0maFU1ihU+3NoxZuWYnfuBzowriq1dzerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSYMmOtK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122741F000E9;
	Sat, 13 Jun 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781392213;
	bh=2q/iUZHmzQJ2DtmNMtcn+7efYWlaZTLUNoV8eMxuMoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dSYMmOtKsCxoiSxOvLoSHdYRssn1le0ynrgX79A9xb2JkxdSS3dN37bID7oTZwlsE
	 syuFBg2CNBQ2Wbdafq7x3RKeXQs9xkyE5YIh3+HSNJXYbJTDUxDMsksDgzyeVmr/LA
	 svs2tDYEE24ivI0Qx1JHnJEbY0xnt9SZBhfe+Y0ti7EzTCCJPopzdZpXgKukSlKQ5w
	 qJQ5j3PLAMK9sDh5CsQuV/Po+Jo9Qm8OPKGU8AnD0SoNRzLSMrmPm6vAXCPv2eIAAy
	 PU1u8ZkiQ/LxPd0vpnFscWdLYH57yDnJze2GUavg8aULtiea7CxB4TIjnKDDSjz5x6
	 Ni2YwmUmLjL/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569ED3A54A32;
	Sat, 13 Jun 2026 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/stmmac: Fixes for maximum TX/RX queues to use
 by driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139220914.1621428.9980668998947938804.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:10:09 +0000
References: <20260611113358.3379518-1-j.raczynski@samsung.com>
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 k.domagalski@samsung.com, k.tegowski@samsung.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,lists.infradead.org,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299086-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD27768001A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 13:33:56 +0200 you wrote:
> When contributing other changes preparing functions for new XGMAC hardware
> https://lore.kernel.org/netdev/20260601162537.553512-1-j.raczynski@samsung.com/
> there have been reports by Sashiko AI review about pre-existing issues
> in the code. These problems are non-insignificant and are 'net' material fixes,
> rather than net-next features.
> One issue in this patchset was reported by Sashiko AI, while other
> technically part of new patchset, but is reasonable related fix.
> All of issues are wrong DTS configuration, but kernel needs to handle it.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/stmmac: Apply TBS config only to used queues
    https://git.kernel.org/netdev/net-next/c/8b10877d9d6c
  - [net,2/2] net/stmmac: Apply MTL_MAX queue limit if config missing
    https://git.kernel.org/netdev/net-next/c/8a7bca6de6de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



