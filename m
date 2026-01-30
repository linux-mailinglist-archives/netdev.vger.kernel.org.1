Return-Path: <netdev+bounces-255000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC/XDGMffGmgKgIAu9opvQ
	(envelope-from <netdev+bounces-255000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:02:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA4B6AE4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44DE3055D47
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247A25CC79;
	Fri, 30 Jan 2026 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it5qz4Bz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FD2DF13A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742021; cv=none; b=tdSadttarJltYu27ryYbRxjSuMJyqIJ7pn9N59NbuA/7ydQGXfGdsPjAlbO1V3GSK+5o3g2nBf2zQTqPa6yzrvTjDrGBR2ndp9bjv2ue30Lwbs0RNCNJluhqkt1Wkyr8ToWjLvZc4QtJiLg21Qv+5+RWCbLFB1+7ZwCFoxa29wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742021; c=relaxed/simple;
	bh=9z4i2QwyV2Y9UzzmFnQgPeDhqToGSrt/tM9403RQKC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0ffNi2ixfO65hmQVpTGo5t5L8ecLeolHmEuHRLO9U1gpFEhVcGFHVyWwKTXq6wjzn5DzE2bYZ39KzXu+AUPX8rhjLkT2xQDaCItz08rKbUPhrNTEBqHwujWjfYzJNA1c3fqwPMURx2pdECOT5vSi43KFL0lU4nA5KlG5Miu5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it5qz4Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54535C4CEF7;
	Fri, 30 Jan 2026 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769742021;
	bh=9z4i2QwyV2Y9UzzmFnQgPeDhqToGSrt/tM9403RQKC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=it5qz4BzGWy1TQelnZeRaUYyJehm2lLJRN0InOK+qG3lL1yzfeWnDNMBFoK987HKn
	 S8izWMgWMDeadcoYNkoAVPahS/ZBHvu3PE9olZ9OOl3VQwe7EUlxyzTjWKMycFyUnE
	 cSJkbQEg08L7NMgQnniqnBYusJQQtOHwqtaUhkpYYSHtS33TzcH8Nj0mtANnnrJmBH
	 ZC44yUC+pxaPc610dyMqMlM2en3xdKXzCpPQgiL7IAzKbOkLKtb1aad5E1kwRXKAPH
	 64Zte6+GhAhutTw7QxDp/JnfT7/H5YIR/xKLCdVuTYE1EmwaMRWKQTT1/OF0ZzhRjg
	 ru6AMqvHkbymg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA48380CEE0;
	Fri, 30 Jan 2026 03:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: make sure we populate the qcfg
 defaults
 on old FW/HW
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974201379.3152167.6194243705845026030.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 03:00:13 +0000
References: <20260128193258.125274-1-kuba@kernel.org>
In-Reply-To: <20260128193258.125274-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, asml.silence@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255000-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3BA4B6AE4
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 11:32:58 -0800 you wrote:
> The driver now depends on the core to tell it what the rx page size
> should be for the agg ring. We must populate the ndo_default_qcfg
> callback even if we don't support any queue ops.
> 
> This fixes:
>   Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
>   RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3852)
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: make sure we populate the qcfg defaults on old FW/HW
    https://git.kernel.org/netdev/net-next/c/3cf48c04966e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



