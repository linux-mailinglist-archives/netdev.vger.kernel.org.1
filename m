Return-Path: <netdev+bounces-290555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBspAIk+D2pNIQYAu9opvQ
	(envelope-from <netdev+bounces-290555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBF5AA10B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98481328FBD7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35D379C4E;
	Thu, 21 May 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khyyXovI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57D376A14
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379214; cv=none; b=gnMlTC4NMJEfvoJVIUO7evOdm8uCBw3V3DX6L3XRSaa80gzxJJP/yLZW6SolMfnfnoljBRPPQpaWU5qIeG1feS5rn04AQt2eukpac3gTyMSkTD9PAVWqspF0mZb4OUiyPkIQ4Kb/uk+JCXj2NZEKaTYKsfCNaIvuSqQ0ywV412g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379214; c=relaxed/simple;
	bh=DnbjOWrr4yom8z81WSsyNh5TsCtNGN5pjyJbB5NMeGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvA/LJPoGtFEDebKx4S91hC2MlfqjD8XVFu8CpdbGe1fQEXyqNQ8DNWkd88mbHQSxCLG6+Q6px/66Nu7TWfRi8MxykM16LQVOYnwGEK3UeAOIC/PXrVx+lTrFhKDxc/i2mKx5t5Bagn1SjdX0VA7PFuoL5a0FMYreYwj+zG5Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khyyXovI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AA01F000E9;
	Thu, 21 May 2026 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379213;
	bh=oHbs+jFfWsRnxoAUkMUUwuv1GE7PN/mZRBB7M+aY7HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=khyyXovIVfBF3Otruc41J8HI9UNAb733eEVnj5LsTacc9u2G9fh4y2L68Z2JMKsHz
	 R3JZndIF1wmQPlA/v//7BnJ6fBcTqgqnfVYFUfAKZtYCywREO4c2AdneSEw1rR/1xT
	 Gc6VNrYCHn4t4Bin1d2ip7qQ2LPYGJOcPpkaHDhYPpbKpDUIMeJgFE7o3olfYK/VWh
	 p3DNN+SsPZwfRtyX7+//fbkOL6nQEmaBmXer4ikEZrSjmdN69CvAPziTx1t9oo87FC
	 qL0GTAxuSVUtt1h5pp1Ko5xydc4ehkzV/sUCSCVhtwCvzZjAK7gEyuQtP+aEgviO2h
	 0DNTw++0MwZ1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568113930E0B;
	Thu, 21 May 2026 16:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: bridge: prevent too big nested attributes in
 br_fill_linkxstats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937922289.398712.1321471261054348076.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 16:00:22 +0000
References: <20260520114207.1394241-1-edumazet@google.com>
In-Reply-To: <20260520114207.1394241-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com, razor@blackwall.org,
 idosch@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,blackwall.org,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290555-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DEBF5AA10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 11:42:07 +0000 you wrote:
> After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
> syzbot found that br_fill_linkxstats() can send corrupted netlink packets.
> 
> Make sure the nested attribute size is bounded.
> 
> Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: bridge: prevent too big nested attributes in br_fill_linkxstats()
    https://git.kernel.org/netdev/net/c/bdd39576bf50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



