Return-Path: <netdev+bounces-297395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id utuVKYrBKGp7JAMAu9opvQ
	(envelope-from <netdev+bounces-297395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F36654A8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mHNMCKrW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297395-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297395-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4F930BFD84
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB955287247;
	Wed, 10 Jun 2026 01:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F73274652
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:40:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055619; cv=none; b=MPVryFJowzGw0K4Pyy6POlrEmz9wn0VpbotYnUrnTzImqyuaMu7pQQbBUOIfmnwGmSMGuMr9iHvB4m25xp5FQ7PoBGuY5uuSsG+tPFIZbkIbO/Etz3CG/YhXUfn4B65lwTBmp3IWInU3m8fVPT07WeBgKu6hOx6cgmNwAAecRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055619; c=relaxed/simple;
	bh=rFBtAmCZK3ZIZj1fXPx5f8wbo/pg7S/lHCKnGAK8Qvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iv9tLugoJXPj19FlRc1GizwszZx9DgonuSCh64dkbKy/IBd5Xl7+YbLHZJYX2MzG7seAEgGjNPeTKPqdiJf2eQeky964UySUWu9i43CU4sksD1XxMCWwFczShB1EftjecOJ42zEAT0rUZjobRIGWm2TSxx9aLtdtOuSqoVLWCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHNMCKrW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B5E1F00893;
	Wed, 10 Jun 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055618;
	bh=hL2R417QuJMLMyXMORugzzCT4ozPp+xb/DOxQtiQa+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mHNMCKrW2jZimElyrrgYGceCrtQC35I/VS0BKWAHjh0ewc9zDBFbXjZdTO/7uSoH4
	 /GS4rJkEGgKwqGMaYUwwZSzdsodo8Kx46fVvvnbkAE35f96bQ90L35oXNxi/sVuuFU
	 GoXsyT4KorHCOe8mEfqTq5P8awVupK5TFtw4ugISictbplDpYNwFxrK6M+IZtLuPFf
	 cFYOUI3KlkH+i5gYWH+fkiYQEv25HVrS6O9CLyK/NbGRKYknHw5G13q+PWAUnU2fxO
	 XOI0SCm3/znSx1JCSu501RuLjp7hTgyzCD1lmYS1u85atUD5NPdYYnKYQu8uV3rTDd
	 KBPG9jPgGGLOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D096C3930A1F;
	Wed, 10 Jun 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: add retry mechanism to
 ndo_set_rx_mode_async
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105561662.2786170.17213005167553331124.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:40:16 +0000
References: <20260608154014.227538-1-sdf@fomichev.me>
In-Reply-To: <20260608154014.227538-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yzjaurora@gmail.com
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-297395-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yzjaurora@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F23F36654A8

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 08:40:11 -0700 you wrote:
> Original async ndo_set_rx_mode work left one place where we do netdev_WARN
> in response to a ENOMEM. The intent was to see whether actual real
> users can hit that (adding uc/mc under memory pressure seems like a
> very unlikely thing to do). However, it was quickly triggered by
> syzbot's failslab. Add a retry mechanism and downgrade netdev_WARN
> to netdev_err. The retry logic is a typical exponential backoff:
> 1, 2, 4, 8 seconds, 15 in total, hopefully enough for a system to resolve
> memory pressure.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: change ndo_set_rx_mode_async return type to int
    https://git.kernel.org/netdev/net-next/c/d11706b56a3f
  - [net-next,v3,2/3] net: add retry mechanism to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net-next/c/d90b85c23b3d
  - [net-next,v3,3/3] bnxt: convert to core rx_mode retry mechanism
    https://git.kernel.org/netdev/net-next/c/a96c84126dc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



