Return-Path: <netdev+bounces-298056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MrGVJy6HKmowrwMAu9opvQ
	(envelope-from <netdev+bounces-298056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB0670A3A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:00:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PgV0RiNQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298056-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BDD43002921
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCFE3C9881;
	Thu, 11 Jun 2026 10:00:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25093C8738
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172009; cv=none; b=EuCtuGJleK5EomPYPFZg4BMZ9kkPVUWbTBPQLwtkOBnsXLDCeVWFBwGotujd3vyE7UgJnLxl7oRL2qG1NGl7T2g5GPaiYKAstjRzK/1go6zFKXx6Y5z3lrVra2pI8uUPd9DQEYcWNMfHWtUOUU9fWEgY7sI4n22vVs8kyHDlgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172009; c=relaxed/simple;
	bh=SZwN0gCOutHbdQUmi+f5dQmZc9r2N+wX4KbimvKGTik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nkl7AhflXdaaSGu4gWRGue/tYw0/lQmbjUfQtJPC7NRPBMI/4OcbrPeqM5Mtey8pR7jv+j9ZzVa6pDiftJ7JRXGmf+Q0wfY30GZAPckBg/p9Wkh0iPHs3IRQta5HqY67Z8VQ4IizZyHjcvNntHtJoR3XlqP5gfJBINul2Br4bN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgV0RiNQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC61F00893;
	Thu, 11 Jun 2026 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172008;
	bh=asH+ui33kBmo4h1i5N5E1JxA4Krlqec1UV6uWDz81cI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PgV0RiNQXwiByfhmeUcCCkIeceZAFRbr/+OYgfoY0JS/GZddvoqsx8wHBi936wdAZ
	 SYc82zRTTwOeonxX9jepMhjt9Dzmfqn7CH7w1NpfqMiaoQcjbl/49Ueo5uGyzUXneF
	 KtcL0QYcJoZQVzUZwr5NuLqpzur5cxeO7GLNewHLIBw/T17mR/zCWmJZ26iQSqLxsb
	 jKdx1Q/3XbSN5+m98bgduGRlorzGvx2XNRBR9MWwMTeY9EbzmcP2IPtjOgOATzEsY8
	 RRSkQ/vY6VVW0J6rb7meDLpUhn6KE6Rhnclaqd9S8jzKUGEgf1EzlRQHUL+V3YuXS7
	 OXf2qjXE6I0Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEECA3930E3F;
	Thu, 11 Jun 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix a potential NPD in cleanup_prefix_route()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117200568.3869936.16889649583129791154.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 10:00:05 +0000
References: <20260609145448.768318-1-idosch@nvidia.com>
In-Reply-To: <20260609145448.768318-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 thinker.li@gmail.com, eilaimemedsnaimel@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-298056-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:thinker.li@gmail.com,m:eilaimemedsnaimel@gmail.com,m:thinkerli@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89EB0670A3A

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 17:54:48 +0300 you wrote:
> addrconf_get_prefix_route() can return the fib6_null_entry sentinel
> entry which has a NULL fib6_table pointer. Therefore, before setting the
> route's expiration time, check that we are not working with this entry,
> as otherwise a NPD will be triggered [1].
> 
> Note that the other callers of addrconf_get_prefix_route() are not
> susceptible to this bug:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix a potential NPD in cleanup_prefix_route()
    https://git.kernel.org/netdev/net/c/b70c687b7cf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



