Return-Path: <netdev+bounces-276240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qELoMRa51Wno9AcAu9opvQ
	(envelope-from <netdev+bounces-276240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:10:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF333B62ED
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882943016ED5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC813624AD;
	Wed,  8 Apr 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8DBnFAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E76BB5B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614228; cv=none; b=ffhJcO2LcW61fzIGcy6u/8X69HlYIm0nfXunTwmkga9gjUeic1CuUQ2MI/ba3wLNxbkSas/jK4vjGQqFy5OsYnzzynbTtPmCDSB5n1QCo7cQ4US8BzJv4+pL0s0yKNnnAMnE9YSD0NBFoLTm5e4xKo8RDBhPcAARrlH9bJlGB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614228; c=relaxed/simple;
	bh=QGzb3TvC2braq/ZHHqMKVMEInY5gAWpgk5WdrntQf+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ncpSDlNd5GvPmjYks0fH3HUY2GEIF3l6TYhd3jOPua7ykFnDC/tJ3OBhm8vfwl8VUx3q5J1fqUVk0tqn8cyy0uuJ0nZAMmC89/3hYWU+Tv4sPvbknZbbftgwqnmiRCN//viwEItJ2G/yGTVy9UBBC3pS6WEIkvcfXjIQR6MGHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8DBnFAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC96C116C6;
	Wed,  8 Apr 2026 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775614227;
	bh=QGzb3TvC2braq/ZHHqMKVMEInY5gAWpgk5WdrntQf+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S8DBnFAdXKr/0KBTlaK0WDrD8M00rtHco1F/Qmb1QRwwxoeVvNhrm7R1OPWTsWsIl
	 JcbofvMPkbLSCJu3/EQ6gGTqf+lAF6s0dJb5qM0PvE2gWYlx5kCFSk7sbrcQsn/2ko
	 hDDTgGQ/O/YCkzQ46UVhZa/p2pDXUpGwYDTThzD62Z9fgSSmOmg0TRRWKQImFA/rtp
	 odPhQAjJdBnbrGpR6uTMJ2iSkCBC+Nf9PW58A4oB3niqnPjDcSWOSt6ZFD0Jz4H6Xi
	 CImqdQyfXz5+ySNkBqZbWcplAZaiwTbOawD254ZBFyB9ysrmpWHCj/OTVRhouMwN1y
	 RgpI2UCIa969A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BB43809A3D;
	Wed,  8 Apr 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: avoid nul-deref trying to bind mp to incapable
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561420483.39088.16493247026502045434.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 02:10:04 +0000
References: <20260404001938.2425670-1-kuba@kernel.org>
In-Reply-To: <20260404001938.2425670-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 almasrymina@google.com, daniel@iogearbox.net
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276240-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF333B62ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 17:19:38 -0700 you wrote:
> Sashiko points out that we use qops in __net_mp_open_rxq()
> but never validate they are null. This was introduced when
> check was moved from netdev_rx_queue_restart().
> 
> Look at ops directly instead of the locking config.
> qops imply netdev_need_ops_lock(). We used netdev_need_ops_lock()
> initially to signify that the real_num_rx_queues check below
> is safe without rtnl_lock, but I'm not sure if this is actually
> clear to most people, anyway.
> 
> [...]

Here is the summary with links:
  - [net] net: avoid nul-deref trying to bind mp to incapable device
    https://git.kernel.org/netdev/net/c/944b3b734cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



