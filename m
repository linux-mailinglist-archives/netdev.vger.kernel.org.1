Return-Path: <netdev+bounces-275241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GATDm850GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:04:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF53398A2D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B8D30B826E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074431E850;
	Fri,  3 Apr 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWulMMjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FB2673B0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253638; cv=none; b=aqisjwREG5AmmORzEPbOIBl/LHP/15VkMj7/iUg3h2t3KcWzDtP7ZKCDim/FsnvhWT1cmW4dE/V1lcauxgs6SEx6fEaCjhmsKy2IbamjNEfGg/POqx6K5y+/4rMjoBoN0O2X6jaKQI46YQErA12QzaVYgi53JnRliHKkevP3/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253638; c=relaxed/simple;
	bh=XQhuRFS5BhcmVEdMuLawsRfUu2jHBVhVjnMXYwC/UYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t4hWb0n8zxTOFPmWk+52+TXHjFibuSnXAevy95yHI8UOpE4IiKtZ7l/jesa95IeCBEKjLvYlTKJDhWDLkhF0rbcgoBwwWDkKRd/UehGPEo75Wuq/plKbpzUzG3LTs9c/JGV+plDiIjv8awZ4CAZdRSYOwkT+s8PRyys4ZeXfP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWulMMjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7A4C4CEF7;
	Fri,  3 Apr 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253637;
	bh=XQhuRFS5BhcmVEdMuLawsRfUu2jHBVhVjnMXYwC/UYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWulMMjS+GA+sce/alHYMe7S7502pEHOwPO1e/XgbBPylsuwU8FChqi9PUMkVsHRG
	 1t39RpQV8EObJa9vFGWjc2iuJfAitb9hGEGomEZQL2NaRc8WrqNubIuaEbeVeuV/2H
	 MIglKDpeW7SrwzMbeTJalPgTHzExCK5WkQOQvMr90Q4qkMHJ6MHFQ0PYkuJ/eXU0qD
	 RZpsxw3MP5jDdl9kkb08OZKfYebprt/FG9JMnz4oyZqqT7+oNfDcxVEDsr1/MeOBkk
	 mOLc1Od6wjUdQuC/vd5VWi3F3ZcBwm9dVcIIbc9NOQTk8HWKmKKUfJsYCENYWzAoTP
	 jEtS2nofA9Y+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD813809A14;
	Fri,  3 Apr 2026 22:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix memory leak in
 airoha_qdma_rx_process()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361903.1466030.1505141844783892898.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:19 +0000
References: 
 <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
In-Reply-To: 
 <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275241-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DF53398A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 02 Apr 2026 14:57:10 +0200 you wrote:
> If an error occurs on the subsequents buffers belonging to the
> non-linear part of the skb (e.g. due to an error in the payload length
> reported by the NIC or if we consumed all the available fragments for
> the skb), the page_pool fragment will not be linked to the skb so it will
> not return to the pool in the airoha_qdma_rx_process() error path. Fix the
> memory leak partially reverting commit 'd6d2b0e1538d ("net: airoha: Fix
> page recycling in airoha_qdma_rx_process()")' and always running
> page_pool_put_full_page routine in the airoha_qdma_rx_process() error
> path.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix memory leak in airoha_qdma_rx_process()
    https://git.kernel.org/netdev/net/c/285fa6b1e03c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



