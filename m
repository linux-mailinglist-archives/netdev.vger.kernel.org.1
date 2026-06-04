Return-Path: <netdev+bounces-295031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mVXABAvkIGq68wAAu9opvQ
	(envelope-from <netdev+bounces-295031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A563C87D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IcNmzFKn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295031-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DA7307B9F3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2985031327A;
	Thu,  4 Jun 2026 02:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683C2BE03C;
	Thu,  4 Jun 2026 02:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540217; cv=none; b=lXwW84jyE33gF/Y4nowETzP/e599LYGnp5h8J18QbIMd5Uuf4BzBu4wgr3FiBlunif1i5p3/vsonW78/S7kVWVp2i8Sqh25zcRtX0ssY7oMklIRLi22oeV0u4Iq8v72TraMESXHj8hxmDfx27q43irQK4BPWIWGVsXod2YFvzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540217; c=relaxed/simple;
	bh=sdCzHy7C40HMOj4/b7kN8+YkH4JkzzQucO2MAVnyLK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBks4cqzr/ZgTo32dZFVSw8j45z121Ntn/N+4TbyY7ohI1KaFI4kdydphEQOpSGI3zoL+LkjolCzv85nx/bSJmgvpBBRqfLPWyvkbSJAOpNhijGlM8iaGHP/K5gjuF4AN6V45YzjYm/BdFnUD/ZA2BGkwX9g/YytF19jELr6LcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcNmzFKn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B11F00893;
	Thu,  4 Jun 2026 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540215;
	bh=9wU2AxMPhoOp7B/T3SMAKEa5O1kX2NJAEi/Oh9Z6D5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IcNmzFKnDaBPQVTFAu+lROvtOHA/BFQHeCMnym0wKTIhA0y9xlqjuS122INkcBR01
	 7C1oAaA8LPvz5dVCGnC9UglQju8ikMDo9fI+r+Gvz+b+BSnL2zU4JectbpxEx3AR6Z
	 rJIAXCnAM/mEW8o9gIy5JidNC50UN+g0anc7W1R/wg2GK3nD4IwKppTVFxlYl1OvlN
	 2pEFwmS9/dX+XG8wNrJjUKVAh2orSTbTOSDs/Y6RpiGKnq9OorkD7ePT2UWFchNLzZ
	 u1Aei8v3Uq9NXtBnUayxwuzoIAh8UuKvnlNH2aZc84EcC0DwXMOCfd15jtxh1mFZqx
	 2Q5x2x5ylBzuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393939308E6;
	Thu,  4 Jun 2026 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/sun: Fix multiple typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054021614.2211213.3521363278754692746.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:16 +0000
References: <20260601163727.554364-1-j.raczynski@samsung.com>
In-Reply-To: <20260601163727.554364-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kuba@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295031-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:kuba@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B1A563C87D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 18:37:27 +0200 you wrote:
> There are some typos in comments and while they are harmless and not visible,
> there is no reason not to fix them. Fix the ones that are not register related,
> which might have intentional naming convention.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
> Changes in v3:
> - Just fix typos, no funny business, no changing spaces
> - Restore commit message to original
> Changes in v2:
> - Fix typo within typo fix ('empirical' word)
> - Change autoneg related sentence to make sense
> - Fix double spaces in lines where typos are fixed.
>   Add annotation to commit message why only these
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/sun: Fix multiple typos in comments
    https://git.kernel.org/netdev/net-next/c/8bcffff57d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



