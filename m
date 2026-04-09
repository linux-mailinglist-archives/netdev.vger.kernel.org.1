Return-Path: <netdev+bounces-276787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMwyF8YR12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C083C597C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541CE3018AE4
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1C36654F;
	Thu,  9 Apr 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltw/qGon"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FC2BB13
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702439; cv=none; b=iQSUms4YUAJz8PmBH7UNJNkDoOwwLLoF7GBg+YTglVYWKXRAQ+DUNH9zKT8hiiuz2oASJ7MtbgiQkoqOSg1YyoDm/2hsn98K8jHnXbhlK+M3k7Ja0iygp3SLG00+4GjyLdKnbBrOr3Yo7P6Z1OiUGiXI3yMw2ldZvc7NE4MkACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702439; c=relaxed/simple;
	bh=At+bHGG7g0doDVEDAMUjzAbGgV70aa7kfq9fhMjD0Hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zc67sT3W/1dB6fnvwxMpUU+7fmD0a/yRyOYqYqzsYQLYJVzhC2nCNZ+d/Z7leFcMPGdyKgrJhb0KOA2N7WLHHhcG3awjZQ7Ehy93hjYVyGJHqrfQUvEhGjZBGdrs15/JV5gTqUb0Ban5UIdLiYcz+KBf1wlef0nWr/gOJ5VTKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltw/qGon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213EC19421;
	Thu,  9 Apr 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702439;
	bh=At+bHGG7g0doDVEDAMUjzAbGgV70aa7kfq9fhMjD0Hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltw/qGonAWS0c1E2TioyDbgoXN5ljHTW62If+a530ZERBhhAI3zwcrovW5mwzFd7r
	 JuCArQkgpvAMBBljnxjM7WkQi2gDyDXfG8+Ia7UuFn+1PwKpokJ+NlCiWAs8fiyHH9
	 +jL9MPCtFsr76oFBuldVy3ocjfD0H7VlwO5IpI5Jgpgqv93M6U9g6Vo9DCOVKFIFrW
	 M9HvHQKKPrS7p9KqCdc34X8SHvV4aD1cTVZWgBczAVn1quRps0kOaEkxLYQB7KLeR9
	 7wQ1CWJhrNl61hlaZGl0NQhAgzA0dBorqw17+A7ttN8RN+1RtElhhkawt83HG3lY16
	 XmAEOG1Tnyj1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9D3930793;
	Thu,  9 Apr 2026 02:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] codel: annotate data-races in codel_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570241555.964658.12760829880285646820.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:15 +0000
References: <20260407143053.1570620-1-edumazet@google.com>
In-Reply-To: <20260407143053.1570620-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276787-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0C083C597C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 14:30:53 +0000 you wrote:
> codel_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Alternative would be to acquire the qdisc spinlock, but our long-term
> goal is to make qdisc dump operations lockless as much as we can.
> 
> [...]

Here is the summary with links:
  - [net-next] codel: annotate data-races in codel_dump_stats()
    https://git.kernel.org/netdev/net-next/c/ea25e03da7a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



