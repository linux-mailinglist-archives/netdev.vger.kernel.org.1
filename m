Return-Path: <netdev+bounces-253212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNMbAiqJdmncRgEAu9opvQ
	(envelope-from <netdev+bounces-253212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C32827BF
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6F93002D4B
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10330DD3B;
	Sun, 25 Jan 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1l52BRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9130C631;
	Sun, 25 Jan 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376018; cv=none; b=jbC/fKw1e2HH2l/iaX3Pi8HL5wmrgBUnaE+V/hjEFUnKNl5Ni3ugbdePZkSEy4ZYkU2sO6Dd7sZhK1hHPj/2uze1nvbh9blp9hrlU8R6KWB+uIuO8nD5q9E5aVOKFJ5ASrJ/p+apG8vZ7t8rwPZ+ccLgq0Vfjv/rsa59mDydg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376018; c=relaxed/simple;
	bh=6j60dgi8/9GlBHmAivaRLBu71UcV/WyFp1Jyq82JIQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVwTl8Lli+R5e9FBTnySv3IM7cC4k/ky2jjRhj1L/id9+i2GJj+cf/fopsXjzcqQvwz/DTvIqY9YyLMrDhFi71W0f6hBXKYup6aZk8fpBVPH/3TxPDS384WIZYIMGgHGP9n0zF4kPPwiDPAI4nWd7NhHXNqVdOQ/Eto0VxdusMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1l52BRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA57CC4CEF1;
	Sun, 25 Jan 2026 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376018;
	bh=6j60dgi8/9GlBHmAivaRLBu71UcV/WyFp1Jyq82JIQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1l52BRj1BYMknDW8GXYTQ+lZ3zk7MwzdZoJwn7HOjM0nFfq0cKMvwFCtq+PQmnXb
	 btAKkCqFNTMjFDd7aJfp1Fsj9t1wMv364ZqR8qDGBpRypzG8w5mntOtlscbZ8K4j21
	 bJI91z20Dgf68qZCOk88wUJl1dADCf1oo7YUN2slhofBq72RQflYfhQhFOFwGAnLbb
	 oK5AT8WC+5u5IajCynKqVr5gK8Af16A+LdzWp2wcox4frzyPWBF+sCzGYHvWFLB6AM
	 x+C1pR9Kgb7bWJqJa9ACPtXvXrrYdgAZ9hohT9+G1Mn3gitmwPDCzYJeKz7Wvm3Cuu
	 UXcpB7o/9BycQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B2D3809A15;
	Sun, 25 Jan 2026 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mvpp2: cls: Fix memory leak in
 mvpp2_ethtool_cls_rule_ins()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937601260.3588307.18092388045138415195.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:20:12 +0000
References: <20260123065716.2248324-1-zilin@seu.edu.cn>
In-Reply-To: <20260123065716.2248324-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253212-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,seu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80C32827BF
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 06:57:16 +0000 you wrote:
> In mvpp2_ethtool_cls_rule_ins(), the ethtool_rule is allocated by
> ethtool_rx_flow_rule_create(). If the subsequent conversion to flow
> type fails, the function jumps to the clean_rule label.
> 
> However, the clean_rule label only frees efs, skipping the cleanup
> of ethtool_rule, which leads to a memory leak.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()
    https://git.kernel.org/netdev/net/c/09f979d1f312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



