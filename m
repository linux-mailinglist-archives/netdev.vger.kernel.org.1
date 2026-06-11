Return-Path: <netdev+bounces-298401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqhwLVtAK2qe5AMAu9opvQ
	(envelope-from <netdev+bounces-298401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB8675C5C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Kh1/qHKX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298401-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21EFA30D3E6D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E0A38C410;
	Thu, 11 Jun 2026 23:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71638C2C3;
	Thu, 11 Jun 2026 23:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219416; cv=none; b=hPvFSHeIvDv0/9htO9WGObIN/eYi8lcuYX8tyIHJGVW7kkD7BIr6MD7lqj2/+s+1Et7BY0ZcF/f7lV7d8kUAyA9ccFgoFtHEY9ERYHGQsy6yp04m2uK19X+Q0POIXSnEfgcU0LVABfNspEY90FCW+EuQiHXu1ihOdNAw4EDaEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219416; c=relaxed/simple;
	bh=YNWs/e3uCXkbbPZ4iFcZSI2Bird10XSbI+OTsyCmwQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YhwjbVtFHaG/ydT6EIb9958kcOo2V1zgXDpT7XcuCvmVh8BmjS01lAPrdlepL4Sp3/I1ESOtkSL9id3VcN64EOMN4HgvP8LZ4nuzBKwIZtJ3kdlMD4nvOJJ4LmgQze0No6uu/dZhZP0H+3OFVvt1LRFKZB7xsUjvbvlCJnT810g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1/qHKX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2BF1F000E9;
	Thu, 11 Jun 2026 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219415;
	bh=BNXC8raD3CbldODhpTGZ9hn1Q8PmFDNOPdX6N8RIDfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Kh1/qHKXmVo9P76sWuqGPwSK3LGJ/QUJXKZv6MKMkTHYMK9Csut07gRh+CdHitd/9
	 tWy1SEmUroTWMyHPsic3satJ+i5uHOPdMqIhzu5L2moInjuGeOoKWXg6N+3IxEmZ3G
	 DMo+eAuqAhAJXFwyzRel11yivR8GbhmVg4zZE+rtfwERL1o2zcxFN5tuSIcz9esOqQ
	 n+PHw6eI+raPW9lIkFD+q3b1olj2lRKTNruuDf0o7cEIDrBUH6hCnebt9gIxfnM1Jt
	 yD1KDeu0+W1nWsElMUXu9p/wRbWSqoZZwsVx5q/5I1mluDw2WF2Y6asJcZ0FppStBF
	 ef0Fx7gfzrH2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B323930FB3;
	Thu, 11 Jun 2026 23:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] tipc: fix netlink gate and receive-path bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121941238.401113.9393840948015079926.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:10:12 +0000
References: <20260610124003.3831170-1-michael.bommarito@gmail.com>
In-Reply-To: <20260610124003.3831170-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tung.quang.nguyen@est.tech,
 horms@kernel.org, ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298401-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10AB8675C5C

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 08:40:00 -0400 you wrote:
> This is v4 of the public TIPC series. The only change from v3 is in
> patch 1: TIPC_NL_MEDIA_SET now uses GENL_UNS_ADMIN_PERM like the other
> mutators, instead of GENL_ADMIN_PERM, so the whole series uses the
> namespace-aware CAP_NET_ADMIN check that matches the legacy TIPC netlink
> path. Patches 2 and 3 are unchanged.
> 
> Patch 1 gives the TIPCv2 mutating generic-netlink operations the admin
> gate the legacy API already has, so a local unprivileged process can no
> longer change TIPC state. Patch 2 drops CONN_ACK messages that
> acknowledge more outstanding sends than exist, preventing the
> snt_unacked underflow. Patch 3 rejects peer bindings with lower > upper,
> which would otherwise leak binding-table memory.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] tipc: require net admin for TIPCv2 netlink mutators
    https://git.kernel.org/netdev/net/c/86b0c540e2ea
  - [net,v4,2/3] tipc: prevent snt_unacked underflow on CONN_ACK
    https://git.kernel.org/netdev/net/c/ab3e10b44ba5
  - [net,v4,3/3] tipc: reject inverted service ranges from peer bindings
    https://git.kernel.org/netdev/net/c/2afb648f7b99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



