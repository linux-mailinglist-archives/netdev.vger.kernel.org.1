Return-Path: <netdev+bounces-300924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTPEAmBhOGr+bgcAu9opvQ
	(envelope-from <netdev+bounces-300924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650686ABB60
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:10:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HKQRs65L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA39F3006F3F
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942DA374A1F;
	Sun, 21 Jun 2026 22:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D0372EDB;
	Sun, 21 Jun 2026 22:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079819; cv=none; b=KsAqYAEO5deFLR0tnhvfbb2wleOUNg43Ehc46vg7P6eslUBLIUglrcAmbdKjdzhw7rpfsjYGo8xSU1B51ECrQ8UG9fgeNVmg97Jg4otXXt8ltqXOad2xi23wL48UBMcDb3dlDtW5XvhEssv0xVjvnKA+yaVhfqtooMKILcsrP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079819; c=relaxed/simple;
	bh=mcnEGqyya3cf1eKFYCtRg3Kf/UWqKw7XDs9Ae4Q9PpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6U3uBzQqM0j0Jb95I46oNiathrn1FaHMJfaU1A4xsKBbMR0V0HHCmi7b47yhDvKBMlSRUxTQU4Eha6u+EVgXQtUAFwjdG3HcW1tvJXeoWfew5zYVP0ztoLr0ri0dX4bIFQL8P16qy31kVUg9sEDqNY87LozfhQoc6PqayYbD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKQRs65L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5305D1F000E9;
	Sun, 21 Jun 2026 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079818;
	bh=F3KQOA8niY5syZgapOtOUTkEOsCPaRi3zs70UPiGApk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HKQRs65LJn10kL1nLS3hw79xVAGFySjdyl03RWpv0/miJJojP1ViCGWabzqCnxYkm
	 4hADcfLKifIlh9lmti+T5RGTJePwsHoJ3gYLY+RaP+AwOINH8RKFgiivH2NNTpy7vW
	 UBGaoynFvZ+seDVw21AyY2tGzYLfpAAiT8ghrjj0XUwX4fUT21iLp8yjW/Ht/G3juh
	 v2mCQO6j9XNzXA35l8qzbJo7nlfDolavuff4ZsYhhYMCl57pS4UEhva37Pf97Sj7m3
	 RjaDIQijGHWxw50K3VhqjMJIHrtkoO4PG+eqANINXLdI1lPyPFNUbx/V0ZKUUaGZD5
	 2oesgZYTwEDxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8E3AAA6EA;
	Sun, 21 Jun 2026 22:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net: emac: Fix NULL pointer dereference in emac_probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207980944.519103.9674366344380035115.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:10:09 +0000
References: <20260618023405.415644-1-rosenp@gmail.com>
In-Reply-To: <20260618023405.415644-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300924-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 650686ABB60

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 19:34:05 -0700 you wrote:
> Move devm_request_irq() after devm_platform_ioremap_resource() so that
> dev->emacp is mapped before the interrupt handler can fire.  An early
> interrupt hitting emac_irq() would dereference the NULL dev->emacp and
> crash.
> 
> Also remove redundant error message. devm_platform_ioremap_resource()
> already returns an error message with dev_err_probe().
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net: emac: Fix NULL pointer dereference in emac_probe
    https://git.kernel.org/netdev/net/c/f623d38fe6c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



