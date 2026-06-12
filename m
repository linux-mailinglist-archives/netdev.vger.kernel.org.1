Return-Path: <netdev+bounces-298802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lPXCMEaGLGpLSAQAu9opvQ
	(envelope-from <netdev+bounces-298802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2F67CB89
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KfWk/Fhg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298802-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E667321453D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1EB3CFF6A;
	Fri, 12 Jun 2026 22:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90F3D1CA2;
	Fri, 12 Jun 2026 22:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302826; cv=none; b=boyWAhESDeKDQWkhcTwPSG8fP8v3zE+wwOHt4P04jQZMoqTI6gAKotoKU4Ly4C6SzGxOqbFkLRBoxeHxGxdyV2BoWMyVYH78kXypaz1KPb42puA2whq2obCZTid8oIFNzWKqrjtpTQGgRdf1iw4nbnTc2kMz22lYSIJsVKdlbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302826; c=relaxed/simple;
	bh=l+G2mSQPcBR8A5HyjK+taptnJ8TGSeYkJof8wXWr89I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t5cWaJrjLT7Ccc5Ccnbn1QxrQIYVMSlZ5TG47DJ7vBQaZeuvZkVxXW+Gbk6LcsgP/NAlyuszU26S/+tbQOlsSi60ux06p19Yig77EZx9+fEcK4Taur50w2YNANnQ9HusMDdXi5M7JItnameDMrLiSyuoxuZ2s1yDYUr68uRffgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfWk/Fhg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18011F000E9;
	Fri, 12 Jun 2026 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302825;
	bh=B6zsRPQQPs1NoB96yoFZvqV5a2leMuzSBDcwdztufW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KfWk/Fhg6Zeb2+VBrqJflcITzHlWMrvnTQuJma3y/Te6K6A/HndV8ZECwdPqT3Y/b
	 6qaxEE6JkWNonsAmvnhT0Q4Mw40EoSBZoB+jToAFn0HRxKssZXjAZGpxvXs2EsGKB0
	 FbZu+UyoYMyvpEBq/AtYjXwp9hXmeMP/8/jLuM0uS6bf4+km4j3ffZkRKEAoZnzfDP
	 +bs3/vZ4NFFPSrZE+s4c3we/wNsIFwbWC0G5Ns24E+kYyBfn5+PHpONVTzc56bT076
	 iTiG5h2L1nQRkxWzHarWutmBc+DwBrz7U38tpher2EadD7RVTENeXokRXbFVhmCCTM
	 eqrLm8vNtSDGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E339E4DB9;
	Fri, 12 Jun 2026 22:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net/sched: act_pedit: require matching IPv4 L4
 protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130282214.1269656.1323140123470715734.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 22:20:22 +0000
References: <20260609185636.1599359-2-sam.moelius@trailofbits.com>
In-Reply-To: <20260609185636.1599359-2-sam.moelius@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mtottenh@akamai.com, pctammela@mojatatu.com, johunt@akamai.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298802-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:mtottenh@akamai.com,m:pctammela@mojatatu.com,m:johunt@akamai.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15C2F67CB89

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 18:56:34 +0000 you wrote:
> The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> header fields without confirming that the IPv4 protocol field matches
> the selected transport header.
> 
> That lets a rule written for TCP or UDP modify unrelated payload bytes
> in a packet carrying a different protocol.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/sched: act_pedit: require matching IPv4 L4 protocol
    https://git.kernel.org/netdev/net-next/c/d504a9785722
  - [net,v3,2/2] net/sched: act_pedit: require matching IPv4 L4 protocol
    https://git.kernel.org/netdev/net-next/c/f7d109f176f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



