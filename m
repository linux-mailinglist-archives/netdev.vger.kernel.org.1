Return-Path: <netdev+bounces-279548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN6rHqnZ42kHLgEAu9opvQ
	(envelope-from <netdev+bounces-279548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDF4220D7
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1314301EBCE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D41340A59;
	Sat, 18 Apr 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSigi1lh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F633FE10
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540046; cv=none; b=pxe9n6E42npvrVfu0HCZlDZ+AaMc2v7J59en/4UUGLfq+A6Fo4tjduBiBjrixR0Vfh8kuqlwwNQm7RWBMzLRoZHeOZ7XAYtbzO1Y5tTVoB+jdz7s9rHq8Sk2XvawmPAP4KnbHwg3cntnU89kchjUyb3/fbEepdDWfvtHySTZwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540046; c=relaxed/simple;
	bh=+mzUMcLNf3pr2nPtyWyWaWUJX7n7Fsj4YzjT+x5HTcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRz+SbQaj3hZhWsZTqdqTA7il7whI1itmeXYGR/4+Q9fjiIfHkIq6iN99K3Xqwykqay8RnO1PVcHIpZsyhGPVrE1uskEbWX3kteyA9MbwE7hRkDfIJCQScFbgOTH0GCA2AJsUW66ryAjAzAT8M2DlHF/s9cuUq2rlfPnrRwNQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSigi1lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B0C2BCB5;
	Sat, 18 Apr 2026 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540046;
	bh=+mzUMcLNf3pr2nPtyWyWaWUJX7n7Fsj4YzjT+x5HTcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JSigi1lhyduw1Bg4I2E6zd86tw6OxKsuqEjkMss82nWyIup7xXwGwx1cL9DbBYvu5
	 YOVg/wYX/aI0eh1OUGCIlx9s309pU4x4mzdBoqXc6G0ZuJVF3eJm4dVRRsfJnqE7MM
	 ea2uSMiIDZbATiGL7wrqWucmP/Nz6e4mr2KI7k5zAQ7ebIriX/FeLVeUEVUsk05CdW
	 JRP3zCGg9ht07r9UGTcxieBkV5GQ/czEdHYuSAy/dT30n8ThvVvs0W6xIPfsrTijs9
	 8nb8SE1r6mMMoFIu7x3zurSyA8TTwda93DcybpIQkrtowW7dvP9dErHhLCZH8LzorS
	 ZK260zLdv8ECA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF9380CEDD;
	Sat, 18 Apr 2026 19:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654001279.508728.6020617181881359392.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:20:12 +0000
References: <20260416103505.2380753-1-edumazet@google.com>
In-Reply-To: <20260416103505.2380753-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-279548-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40BDF4220D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 10:35:05 +0000 you wrote:
> Caching saddr and daddr before pskb_pull() is problematic
> since skb->head can change.
> 
> Remove these temporary variables:
> 
> - We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
>   when net_dbg_ratelimited() is called in the slow path.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix possible UAF in icmpv6_rcv()
    https://git.kernel.org/netdev/net/c/f996edd7615e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



