Return-Path: <netdev+bounces-299641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+a4Ks+BMGq0TwUAu9opvQ
	(envelope-from <netdev+bounces-299641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F668A795
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FnxXuye9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299641-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C05E305EABE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F139B4A6;
	Mon, 15 Jun 2026 22:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB193AC0C2;
	Mon, 15 Jun 2026 22:50:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563842; cv=none; b=IdPIcP8qZES/V9quUCtT6PE8CDOX4bPA8lbsvkr+G6Ux0LRkmBRHQdb7h5u1mbhHG+7Han3ytFCGwKay5OlDi1BBF4jplO0k5We/dQ7ZQwuBme3/J8cm5ze4jXWHNVWn1uoRrJujVgoBV0zwsZSaZ7K7edqe0eKhL9IfMzX7reQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563842; c=relaxed/simple;
	bh=grgWedY2nNZ4SGRA1oFJn9vNo8Fy4FNyimccqF2MdBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0S8clQCD6YnluR2K0Ky/iwEcguRxxzYqt8sqNxpKelnnxvmLAhmO00UwuqlJNmK4xsgK6Pqcuv4ShqIjwW4Ix2hZuS5iEG71bGpIrsd74JtytyEMGkJP1exIjgifaFbtie5TD7fTWJPL+16hha3LLoPJruiGaSUhONUQW3wIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnxXuye9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577051F000E9;
	Mon, 15 Jun 2026 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563841;
	bh=V6XsH0bL7FqCK4ahZ0MAGbxVbaUz03yea1xWyIn6fs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FnxXuye9GTnQHUKJjUxo7brSz8o81CgcMw6vGvr1uvAeh7lu/v0J30WVOLRBfPeeE
	 i0a1PfQOezl36mkPMqgBGM8QP9sVJBVHMICYcI2Sth+qTEnJrK7eHdbmFmCWUO9APz
	 /CUNQVBLwujNqi/VacCOphx3y6A67aTRBJtVKjF5Icgif45+F02jO49NSSu1RfFFXj
	 ExiRuKl7zL+1u3k72oy1AXmgR6NicFcY6KBPLF4RMXcqGsoz+s+q7uVu1CacP6mzG/
	 /LxFF+wvqNcQJPhbyxnwviWMSYADZpNLMUrxTZ4kq/+fYOu7WCaI/2cWYTgXfnFoEO
	 mIgzMye5Lfz5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A03839A08;
	Mon, 15 Jun 2026 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] docs: net: more adjustments to docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156383616.325968.5598625632200440007.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:36 +0000
References: <20260613165846.2913092-1-kuba@kernel.org>
In-Reply-To: <20260613165846.2913092-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, john.fastabend@gmail.com, sd@queasysnail.net,
 jiri@resnulli.us
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,queasysnail.net,resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299641-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:jiri@resnulli.us,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F39F668A795

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 09:58:43 -0700 you wrote:
> A few small updates to the docs.
> This is trying to prepare docs for getting fed directly
> into AI reviews.
> 
> v2:
>  - fixes in the tls offload patch
>  - add the strparser patch in place of the already applied XDP md one
> v1: https://lore.kernel.org/20260609201224.1191391-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and rekey
    https://git.kernel.org/netdev/net-next/c/c8ee634048dd
  - [net-next,v2,2/3] docs: net: fix minor issues with devlink docs
    https://git.kernel.org/netdev/net-next/c/e504cf18ef47
  - [net-next,v2,3/3] docs: net: fix minor issues with strparser docs
    https://git.kernel.org/netdev/net-next/c/d9e4dd3c6f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



