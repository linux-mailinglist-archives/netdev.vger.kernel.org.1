Return-Path: <netdev+bounces-299592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YveEJadXMGqKRwUAu9opvQ
	(envelope-from <netdev+bounces-299592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:51:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A768994D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EgDieSZ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C3023016C69
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5463B637E;
	Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF13B6C01;
	Mon, 15 Jun 2026 19:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553039; cv=none; b=Te3T+0nK55Xt4epVmB+snVDIJpnXFA0wDW8tx5sO4SIBxmqHwaaCkZi6bcaDsACxeT3BgZRSljO39Nrjd233TPI77r278waycUcqa1aLXrOezil9qzR1hODPN4Mi1hN2BoGjjTDVnL/aLGl04WtfnFpKmrZGKMqBbruTpLdrUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553039; c=relaxed/simple;
	bh=Z77/GdTCeWdmQdC27U0PuHvM2mPKrOrZHOCXDAYVoBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iePOv06pJPgcnCyovGSI5rJVmhOWEkAjHxrygm/PzFm2k8RHVfp166aBuLXVJo3fXgaX6wOp0S+5xF0i7aSmOD4ZbaxtglsU1tVE7JUwUYCiXTMuafeTSf326jH9ZIe6SSjGbfD6umO98y3LAU/p2PRGHxxx7E/d+y5sLBkc7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgDieSZ5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CB21F000E9;
	Mon, 15 Jun 2026 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553038;
	bh=xqKI0anXFa6Mu9LkJEEcXSh/c6yH/5QyAdhTCzzt/2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EgDieSZ5xKgAFYssIoe0kQEyACZK/DaMbGqJG+HXCuwZX2SzvrL4DJj3l0kMmRBae
	 ocZfl8pNfK48dhswjKfBATCaTruZEvkKKgfRJUZ4rGyzeuatTusjNe3+v5OnSSjlF/
	 pO1ErTZ7PQqqFtRgyqClq/KCoF/bzYNV8dO4YGYEKoAEPcsDuJo6f6Z1k7wxSmkd9N
	 xUDhosYJqe3FSbxriqn85SiMEgjlhdxk2d31XKTILCCNz6n7VoKOFv8ye9LfRIlxNk
	 nrrUxWuzdkUwWN7uWsHfAxGGwGgxmZiUyxbuWJXJMfnNuSKcoO4JyERMTD1G8VBqr+
	 SSfPSIEHSa6cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F63839A06;
	Mon, 15 Jun 2026 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: sfp: detect presence via I2C when
 no
 MOD_DEF0 GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155303288.269508.9458032419916353803.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:32 +0000
References: <20260611175341.2223184-1-gregspatrick@hotmail.com>
In-Reply-To: <20260611175341.2223184-1-gregspatrick@hotmail.com>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, mensi@mensi.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299592-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A3A768994D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 17:53:41 +0000 you wrote:
> An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
> GPIO currently falls back to sff_gpio_get_state(), which unconditionally
> reports the module as present. An empty cage therefore fails its probe and
> is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
> there is no REMOVE event to recover the state machine, so a module inserted
> after boot is never detected, and empty cages spam -EIO at boot.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
    https://git.kernel.org/netdev/net-next/c/8ac44d24c3a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



