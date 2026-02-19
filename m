Return-Path: <netdev+bounces-259600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J9QJj+Rl2mR0gIAu9opvQ
	(envelope-from <netdev+bounces-259600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:39:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DC1634CA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9297130117F1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93932D0C4;
	Thu, 19 Feb 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr2KiGY0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E02FC011
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540798; cv=none; b=QpYoaZiXYfxenTwjYnA31kmr0fi2twBxKCAaNnZM+aOYJohR2JE5bflK14wKrtnVNkb/eiXPAnoTCVUjqb0lyTk/8pJa1FKXqv5Vh149CEwm09VYXjliLJLYoGZnKVbKRQdnpxAUi3rkLSGfJV8J7RVFVC2WGRWzXHyGAhVFoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540798; c=relaxed/simple;
	bh=8oKUzdC6r8+Bat7NbT0j7paV0kb7jf9w64Ux6bJdCnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lv2zfeE6kQ8GkjGeXShwYvlZa1ZZFCX2JiMvUjJmNikF97xqxcHGmxr3f9HYdUch+SaS/OYZsqdrMWiUhnelrfb/GtU7+/6FMxscibqilBM5/f2p6adzqACtsXVKNCz9UC5iEOSMZw2Is9GfjM2LCLnf2xoBrXkuahySpoDq7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr2KiGY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF64C116C6;
	Thu, 19 Feb 2026 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771540797;
	bh=8oKUzdC6r8+Bat7NbT0j7paV0kb7jf9w64Ux6bJdCnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nr2KiGY0JboI9DIgj4elTPqAWkskdQXdbSEvBupLv7rUbXIBqwpZ5lZ212lBHlbyo
	 +MGOa2N5Nu4i38mVRQXcuWs+9nQmcLMYIKOxQdLHOaaEhLYf3lWMi2nKJXET0Xnk/a
	 Ru9A4MmGf9b1Uz/V1J2Wj+l9jQV7gBQNLmkG8b0+LJAILzFoHfnGsck3OKP6dnfNxg
	 k5iMwEPOqvX0ezpOiTFjrQ8dWoybWpiXBV83y0P4fF55f12sIhPq2UFjrTVZdtHGqX
	 owtj+ZIAnA4IfL/zJdpb0s7OvBrITqE3p4O0Z5uOBbOyjORsoSp4R3uXABGHjSUI/F
	 nA7HebR2tI2OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3B53809A88;
	Thu, 19 Feb 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] espintcp: Fix race condition in espintcp_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154080630.118053.7292779449955622515.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 22:40:06 +0000
References: <aZSie7rEdh9Nu0eM@v4bel>
In-Reply-To: <aZSie7rEdh9Nu0eM@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: horms@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259600-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 389DC1634CA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 02:16:43 +0900 you wrote:
> This issue was discovered during a code audit.
> 
> After cancel_work_sync() is called from espintcp_close(),
> espintcp_tx_work() can still be scheduled from paths such as
> the Delayed ACK handler or ksoftirqd.
> As a result, the espintcp_tx_work() worker may dereference a
> freed espintcp ctx or sk.
> 
> [...]

Here is the summary with links:
  - [net,v2] espintcp: Fix race condition in espintcp_close()
    https://git.kernel.org/netdev/net/c/e1512c1db9e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



