Return-Path: <netdev+bounces-259383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +g5NHwBjlmmSegIAu9opvQ
	(envelope-from <netdev+bounces-259383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:10:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254E15B52E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FAD830041E1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB81F37D3;
	Thu, 19 Feb 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1MAfQOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7B29CE1
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771463422; cv=none; b=BAS+j4YNfU1hHrpWgpieit2+1r6ZeZTimh6FqmZObDl8vRz+vjplbrqseXQNyS7KzCzbRO+i32t1tkpXKY5DCKxlO5QO3z1bIQi+aNlln7D5JbjLDyjUj7BHJGNsWRjfsrFS/SGDvLts8YpQIlDjQbmCKGks0sHi4Ke0Cve7QWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771463422; c=relaxed/simple;
	bh=pERr3BPads2qYXoT8OUYmysIL0vNKKi5smcrBz46D3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c66iM2b3oj9WsQPp920WjHDO2+d7nd4irCiyR69IxHLX0F2BEF4FBCnJe9C8r4tAZKBu2SUakmJv9mvmB6jaWX7xZuL7Yk82yRFNhyy9btheWOQT/obSClJHQhqTQCNxcboSZAWtIZE4Nps0akxXLy2kO3ypuewNe46boj+TfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1MAfQOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D74C116D0;
	Thu, 19 Feb 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771463421;
	bh=pERr3BPads2qYXoT8OUYmysIL0vNKKi5smcrBz46D3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D1MAfQODYpJM6WTnL7zwoUbdmWFFS/Z4bF5W4BBUzvwzIfc790eQDgw2mDkSYTQZf
	 69M8TfhJDSJVcbgVIL2eBGQgnJNqR9uvLt5tA864zeYDRY9dFTKeALhNTjNgjJi2ex
	 z0LKaPoUPRUGcf1wBdfsClqfGSX0fWKeiQBcQ/zhBHZgwp1vxE2Kb9pxMMzGkrz4sS
	 aL1GwOU47nA+G63+84/8WL6o3DFdpBNUmbB7okdJo8+BHk5C4fMIUSq3PPDJTKDQIw
	 POOTPNCN+nj0UpCk4oxxkQbQR76Fp+qAiwsu4gp3vIT+neoaPZ9rJRZ+5O0CsPNEcl
	 rx7NImgCdUEsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2AD380CEE0;
	Thu, 19 Feb 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/5] icmp: better deal with DDOS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177146341282.1623576.18106037772861542619.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 01:10:12 +0000
References: <20260216142832.3834174-1-edumazet@google.com>
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259383-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1254E15B52E
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 14:28:27 +0000 you wrote:
> When dealing with death of big UDP servers, admins might want to
> increase net.ipv4.icmp_msgs_per_sec and net.ipv4.icmp_msgs_burst
> to big values (2,000,000 or more).
> 
> They also might need to tune the per-host ratelimit to 1ms or 0ms
> in favor of the global rate limit.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/5] icmp: prevent possible overflow in icmp_global_allow()
    https://git.kernel.org/netdev/net/c/034bbd806298
  - [v2,net,2/5] inet: move icmp_global_{credit,stamp} to a separate cache line
    https://git.kernel.org/netdev/net/c/87b08913a9ae
  - [v2,net,3/5] ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
    https://git.kernel.org/netdev/net/c/0201eedb69b2
  - [v2,net,4/5] ipv4: icmp: icmpv4_xrlim_allow() optimization if net.ipv4.icmp_ratelimit is zero
    https://git.kernel.org/netdev/net/c/d8d9ef298867
  - [v2,net,5/5] ipv6: icmp: icmpv6_xrlim_allow() optimization if net.ipv6.icmp.ratelimit is zero
    https://git.kernel.org/netdev/net/c/9395b1bb1f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



