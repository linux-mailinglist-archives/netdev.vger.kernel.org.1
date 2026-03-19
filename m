Return-Path: <netdev+bounces-269251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHIVEMpSu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FA2C4842
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06BC731EC8E6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5AA2C21F6;
	Thu, 19 Mar 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9DuGJMR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F12D94A7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883815; cv=none; b=SGD636FB49QpySXy2PTtsUWYd8fhDOd2GL2aHvbBKXzYZtR4kRUY2f+T+lFQmND3CDI7vpxiSu/266bCdQ/pPri0XboeWdZHhYG47VNvFiRBl8nVBhJrpmloEsNMI1L8CTTEarzL1MMOBZ/kD0d44ZFs1Va0340kyZncdWWZWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883815; c=relaxed/simple;
	bh=ETHx0wRa/8qbde1sXg/b9VGM6ZIwHfJeCbBqHYKm5iI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hfa/9ggfqhbZfJwFgCk2U/V91F3WfNno85mIklmCN9+ltvi/k8jzgUWgoZs3iDl0K9B+bR4TrDSg5fxuBzO3MZNTwaJMNd5jdYowg8axgnPzLINPOappB3d7QzoXqqyaYP3QyJvymrNX8V6ABG22cO4quGWQ+gpp39mk/7+y83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9DuGJMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58ADC2BC87;
	Thu, 19 Mar 2026 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883814;
	bh=ETHx0wRa/8qbde1sXg/b9VGM6ZIwHfJeCbBqHYKm5iI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9DuGJMRRq23bCljMCD4TJNuWIP0tP6wqjgMpeU+jvkUJMvWayEeL6wyIXhcngCKq
	 sVwMQ+ZloW4l0aJ8CIxc+5aLlQDuEpH8FW+nyrEIJpt1f1Mp/YW7DKij83mXXQ5qN7
	 JpOpSmFxQ9gPYAzcxlSygZFlZFVdcJxKenp8lhYlgGyEEihFE4+k8KiEFkAWu/NtqX
	 rWdkPdpuKZLuMrGzklU6a1Xfd3XkTVUVWi+jR4BJjPjGkueH8DS8MyoI7qd8gpIPZI
	 bx6dDHhMKYI/h00ky0Bt3MsYCN7D4kkaJre+pknjLIIbBZx8CBxOWVbHZVvulML2Nz
	 brYoTFVKfvbKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEF53808200;
	Thu, 19 Mar 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bonding: fix NULL deref in
 bond_debug_rlb_hash_show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388380604.978731.12457938620572912783.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:30:06 +0000
References: <20260317005034.1888794-1-xmei5@asu.edu>
In-Reply-To: <20260317005034.1888794-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bestswngs@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269251-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 990FA2C4842
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 17:50:34 -0700 you wrote:
> rlb_clear_slave intentionally keeps RLB hash-table entries on
> the rx_hashtbl_used_head list with slave set to NULL when no
> replacement slave is available. However, bond_debug_rlb_hash_show
> visites client_info->slave without checking if it's NULL.
> 
> Other used-list iterators in bond_alb.c already handle this NULL-slave
> state safely:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bonding: fix NULL deref in bond_debug_rlb_hash_show
    https://git.kernel.org/netdev/net/c/605b52497bf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



