Return-Path: <netdev+bounces-272524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA01D8ZzxmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:10:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C9344002
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F94301DAE0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6CD3939A3;
	Fri, 27 Mar 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtW51gp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80ED3932F7;
	Fri, 27 Mar 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613424; cv=none; b=luuj3AdklalDajOgFn/pdk9ihM+R6Ckl0iD1aouLIax2DzQeYyactqvM4L2KFD6BVr3/ELrjOZ5D2YFTqqEcX5t8HIYXnGZvmclekU9Sn7FM6EXwbW02GWq5RYrvPqSuoU5SY/uBgBWvZEdn2xYFxN57aSvyKrDhrFlUe0Sjl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613424; c=relaxed/simple;
	bh=YnNZ1nfvdPpDm7clKBQ0VkcKsSG9pKcCGTcXk1OjXFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s+OVzh3wR7dv+RXX1xricY8RAm7vRu20gwu5NjByxVjXOmP9Tj+jl3hHUC+xmAhSXkxycF+m0e3uLZHB3cipBYHnyU/IMa20vWmsXPl3ra0TxpARstYdXYdC9eheQdB+cyq6MRslldjoKrKXWtoMQS7arBH8PlIuMi1EmC++xrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtW51gp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC96C19423;
	Fri, 27 Mar 2026 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613424;
	bh=YnNZ1nfvdPpDm7clKBQ0VkcKsSG9pKcCGTcXk1OjXFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mtW51gp8+tPSXAIDnSw1shdBoMpVcrpsY6o9QSWrCAiF57VK3cs7x8/bwE15ImmF8
	 a+2Glfv3gaaZ53W3Ht2Rw3rFJ1hWCdBcjKKjCuj0kbNZI1qqCydf1ZOHI+DFv0viAU
	 ZgHVfcdYv5AxxVVlPFM5Ju4l54v7mLDt0H2WMLqXxA1GOKF+4n7Zyt6hKnoy/GSayt
	 8YEV/0QILPCUXOYWImJWTL9k93xNc6d77roPKs9LxMFRFkY/EtoNEverPX7Q3s1bs6
	 RIaFWP+ah3z1s4+saWcWveCT6PFGVIHHrBQpYFZ1KQdYhhXzDBIppkxrNM1jdo2Luv
	 4ZgU6SKsinnWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA9393022E;
	Fri, 27 Mar 2026 12:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177461341029.3453543.11116884861266878572.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 12:10:10 +0000
References: <20260325125131.53399-1-devnexen@gmail.com>
In-Reply-To: <20260325125131.53399-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 m-malladi@ti.com, jacob.e.keller@intel.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272524-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 9A3C9344002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Mar 2026 12:51:30 +0000 you wrote:
> emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> never copies the packet data from the XDP buffer into it. The skb is
> passed up the stack containing uninitialized heap memory instead of
> the actual received packet, leaking kernel heap contents to userspace.
> 
> Copy the received packet data from the XDP buffer into the skb using
> skb_copy_to_linear_data().
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: fix missing data copy and wrong recycle in ZC RX dispatch
    https://git.kernel.org/netdev/net/c/5597dd284ff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



