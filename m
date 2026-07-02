Return-Path: <netdev+bounces-304187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PXAzO79kRmpYSgsAu9opvQ
	(envelope-from <netdev+bounces-304187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:16:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 616056F8371
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=T3Px2sRM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81170302294D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F784963B2;
	Thu,  2 Jul 2026 13:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80843635E;
	Thu,  2 Jul 2026 13:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997826; cv=none; b=ShUL4OWczbWsdmSL2DBIS5cyxa3Oz71Y8hbInrknQDZ+9lLGh2V0UFpn7mqcAFPZZHcp1WVot0UdKTCBHxahQWPiRdae4eof5o2kCaC9B5u2WSziXrGnd440Je7LKXdwDQAjy8BquBdtEWv94CsgrC6h32936sZSZ4wUhVZh6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997826; c=relaxed/simple;
	bh=wlEFNsBNZVvjEMMcH9iTogG9145ZrVIjhPvCX5Nx9kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sr2ffXWOXX0XMMSzBRxIL28W9qYHimMzYfkQUCNeoNB2AOk7ByGy0Pypa+KWcxifH+LOHO6r42D8V6IX/gBr6DfuxFW1XN1qee6E3iIW62ImXCThTqpONkpakw/ZJkzc9se9jeXNwgsrgI6EQ63Nryqsv7NVc+xB3MmtITzxREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Px2sRM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9751F000E9;
	Thu,  2 Jul 2026 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997823;
	bh=0NMaqO6Gp1oZU1CpHlr43Ak/+yM00C9gJZOlz8x1dRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T3Px2sRMlv0JoF/+OdjSW/t3cHyIOvHVsI+luNnVNifi1LEJ3xQnz8h6xPSxhxf/J
	 ZLvI/6ud2Ez/H6LjPXCmoa3GzQKgZkmOQMG5y55UgiJkCofxBM0nFK1LDmOqnyMqkO
	 6eu3YBDIbujtaQ1O6bP6SyEUhXIVAuifTaBnSrLSCUgkGolOO287oubfY3Ob+YnxZj
	 qlWBXrRGkZecms4vD/qE4XygOQgbEWzpyOJBlgEaeU8MZbZLJhJdj1A1B6cFvTNCb8
	 UiS9IKiu6607QpQumjGGNc9U8iqckHqzCwqbvlPXfSOWT4J7qgLe3ARr40mBb4F0uz
	 CBsQRgniv/q9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396B392722F;
	Thu,  2 Jul 2026 13:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] net: mvneta_bm: add suspend/resume support to prevent
 crash after resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178299780640.1662984.16960798958320642497.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 13:10:06 +0000
References: <20260630060311.4072140-1-yun.zhou@windriver.com>
In-Reply-To: <20260630060311.4072140-1-yun.zhou@windriver.com>
To: Zhou@codeaurora.org, Yun <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304187-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:Zhou@codeaurora.org,m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 616056F8371

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 14:03:11 +0800 you wrote:
> The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
> allocation. During suspend, mvneta disables its clock, causing BM to
> lose all buffer address state. On resume, mvneta_bm_port_init() re-
> attaches the BM pool to the NIC, but BM hardware returns stale/garbage
> buffer addresses. When NAPI poll processes these buffers, DMA cache
> sync hits an invalid virtual address causing a kernel panic:
> 
> [...]

Here is the summary with links:
  - [v6] net: mvneta_bm: add suspend/resume support to prevent crash after resume
    https://git.kernel.org/netdev/net-next/c/140be217df57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



