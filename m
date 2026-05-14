Return-Path: <netdev+bounces-287766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QABHNz0hBWpySwIAu9opvQ
	(envelope-from <netdev+bounces-287766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:11:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F853C938
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005F2303CC08
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B930595C;
	Thu, 14 May 2026 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn/9PlqO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6041A6835
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721068; cv=none; b=bBs6PwWW9a2DGXJ4U0E2DZC9BBNBu9fMLdnZ4cagx36kR15b/PIlwYCL++Y4fGpQ7wbR2zvhEEaObkYxcZCTc454v8eHUlGqulcfuPeNQDJUdtz2z1AEw5vXvsQvjC+Fk5d491+LepjRh1MqzcxWmXhqaHxowNJxWxr/maDV1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721068; c=relaxed/simple;
	bh=d/2jPCrC+5aSuu9PbvfeZ+4yl3VgiLImJ1mvR6ZYaNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0LqZW71nIpjpZRPt/1LsusOdqaTQBCtRGS1kKxPjk/jeGhJepgnuezYMIChtr2t1ZmxQbH8j2EtwYJmNvdfBcHJKAeVr6so/0MOxYL8/Lne38QLflQNxSWACk5Q5XDOgqtMx453FLhQVgZmTL+zPSzbQKfJe1D6b+BlhTkKczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn/9PlqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5A5C19425;
	Thu, 14 May 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721068;
	bh=d/2jPCrC+5aSuu9PbvfeZ+4yl3VgiLImJ1mvR6ZYaNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rn/9PlqO5XEnUWL161v8IJ4gve0bahhw5CWa1QgRqyqLVDm+b5kMyVdCC7t6+kQTj
	 tL5hC7P6izwK+TDVMGLWyp5ZYXkgoyaUgHQCc6JeOQ+bJq0G98qH1IUG3MiktuzJXn
	 myXIxzWuMEz2WppOCILFS+ePb3hStWQCQz0FduHOzFQdrYLlKntnLAP1eOUThP2kyl
	 7bh5S/e4pcgTqsO25ThmrertaufoEOR+vXWRQ4rmBhoZyDmkwp03V6DN5RRKMlXvvQ
	 rsTvvA7JsL6H9EPu9Smq4If/XV9bQUfymr7v8YBF8MZS3ZHIkUKbx/6Lgwog78okfb
	 vE8ekWGWA9tAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE53393088E;
	Thu, 14 May 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipvlan: use netif_receive_skb() in
 ipvlan_process_multicast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872101330.3905490.4199302955949492356.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:10:13 +0000
References: <20260512042019.3300975-1-edumazet@google.com>
In-Reply-To: <20260512042019.3300975-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 5C2F853C938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287766-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 04:20:19 +0000 you wrote:
> ipvlan_process_multicast() runs from process context, there is no
> risk of stack overflow if we call netif_receive_skb() instead
> of netif_rx().
> 
> This avoids some overhead adding/removing skbs to/from a per-cpu
> backlog and raising/processing NET_RX softirqs.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
    https://git.kernel.org/netdev/net-next/c/d0273dbe8be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



