Return-Path: <netdev+bounces-291020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB0gK3IPEWq0gwYAu9opvQ
	(envelope-from <netdev+bounces-291020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF015BC953
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C152430433F3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38C346FAE;
	Sat, 23 May 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGvOk/sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BB331A65
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502820; cv=none; b=GEeHQpoZqFhlU3t9P8Th4ioVoNIlxdCGY+V+AzhNIoqfcT9xqVdV20zmp1arBBeaxr/BgVZDaNy92WPF9fPrqWKJCps/d2/zJujmWalzQ7tttPThMNdqpb+CLeubeovNNNoeEqou809/4/KnHfQg/wKDEQb1kmYyY8yb5lNKFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502820; c=relaxed/simple;
	bh=ssaTZv7Mg/5lEblpP4N9hSsvaFHhCxYJRiim6Dqr8iQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jk+hatTY0PJ9GYeuGA8km8DZ2ZZ6p69vo1ZP36E8/DPBh8joBTDqmu2EKXpv1sqxdHKy/RxGdGrI1uRIeChG7YBz3+dRiCt50EJ4AIBIBnPLtDgLGM+xS0Fx3dpQ5LzQpWYulaOoKa3M/GuVk9ou6OusG7CHZtuI1XdAU7LZtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGvOk/sl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0CB1F00A3A;
	Sat, 23 May 2026 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502819;
	bh=kwzV/ta8LuWnYcKklJQXKcxoSaA8I9oFeFFH4tehJho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SGvOk/slv2pTZ2mfgnlV2vvnPY59EbAku5KiCJTwCJZe8hVsbag/uqvpTnDrwb5/F
	 uE/h6DNpJh9YZ0R3qVLvkJvOud5x4T2fWsdQekgwMUy2E1jjeRTzTOAqLOF/SX6sOt
	 tqSSsdNtdL5BqWrktQ0Sp93n9TEvoE3ekxitV2lj87luQ4jjzhxEffirMQJgSDJp6U
	 zkbOsPMhsMIsubB0Sni2f6mHmci2jJX9gLhTUr+U8xjDj206nBSOgDu0RY+i0muEhS
	 pAwYRMpHVDg32C6jLi6e57Pg3uKZbKxISQ8E3pQZLkBgGMuG8nGmQijD7uOzI3zfij
	 bpk4fi4hXAL3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C3D3808205;
	Sat, 23 May 2026 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: free net->ipv4.sysctl_local_reserved_ports
 after
 unregister_net_sysctl_table()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177950282813.1445071.14526089934970978870.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 02:20:28 +0000
References: <20260521122147.3584624-1-edumazet@google.com>
In-Reply-To: <20260521122147.3584624-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org,
 eric.dumazet@gmail.com, eilaimemedsnaimel@gmail.com, xiyou.wangcong@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291020-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,nvidia.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4AF015BC953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 12:21:47 +0000 you wrote:
> ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_reserved_ports
> too soon.
> 
> Only after unregister_net_sysctl_table() we can be sure no threads can possibly
> use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.
> 
> Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
> Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
    https://git.kernel.org/netdev/net/c/87a1e0fe7776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



