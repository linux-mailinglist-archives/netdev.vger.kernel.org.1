Return-Path: <netdev+bounces-261687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKinEGQNoWnypwQAu9opvQ
	(envelope-from <netdev+bounces-261687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:20:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C61B238B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A377301DCF4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27325318EEF;
	Fri, 27 Feb 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2XjZwZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466A318EDB
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772162401; cv=none; b=KIuiCdvuvh1TILnsmMkRZVqfBuWReF0ra2pLM0wg+pdGAixMie3OGO/Js/pF6hDVq5w0uNp58pTjtbanwI3u/3Xo9ZjyNos1TGVBQNoOa5CVRcIaC/KDrJ4X5CWfRpT3nD+wPKpMljjsat0ayy7PkgVYo47gvaj2nP6uGLskNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772162401; c=relaxed/simple;
	bh=DottrzipIUGAOIGCqMYPvbA2jR4dJ7jyCd3suZNMXyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+Yhque+jeVtOLeitAsgdO9vvSFxtofX7EEBymmrmvqhvrRTTle5nOByYjiTOij6zePXDB54gCJckEBfmjHfh32MlayHT+nb6I/YRkm8rCDdEbJgDGi80omyqPuh0FVEiGTyoS5I44eD2ZteUWSGj3R24UPeyf0ib8a3M/9xCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2XjZwZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98B2C19424;
	Fri, 27 Feb 2026 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772162400;
	bh=DottrzipIUGAOIGCqMYPvbA2jR4dJ7jyCd3suZNMXyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2XjZwZC8EAGXfm+2EMHaAfWaX5FjoKwdMYZ9g4b6t31OR52WRkaofU+zuKMnn2DG
	 JisKUSKSdepkMxpsAqFRJZFZslv1qTZWtqp7sWQnZgKzn51d3P44Zxouhk2G0VhSyG
	 C9GHhe0Ihhsv9v1sd+qul/WI15nymO4mHeFZFdN92o+wWQp4CO9YYzRQLhMKhnn3CL
	 Pfzo/vKwLf0jJH29W6XUR4cmvkpr3aZmWJ4EbGrgoRDwUHL5T5+UiU9FenNTOKI9xG
	 3DD80dQEWyHczT5NSGuaqCCAALGcMKzr98mory6ceGNn/kBgcBWUu0KvPcqoMukjYB
	 lJMk5BV9wV5eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8F393109B;
	Fri, 27 Feb 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: ets: fix divide by zero in the offload
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216240505.1956064.555917745056918321.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:20:05 +0000
References: 
 <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
In-Reply-To: 
 <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, petrm@mellanox.com, idosch@mellanox.com,
 netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261687-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C1C61B238B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 21:28:32 +0100 you wrote:
> Offloading ETS requires computing each class' WRR weight: this is done by
> averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsigned
> int, the same integer size as the individual DRR quanta, can overflow and
> even cause division by zero, like it happened in the following splat:
> 
>  Oops: divide error: 0000 [#1] SMP PTI
>  CPU: 13 UID: 0 PID: 487 Comm: tc Tainted: G            E       6.19.0-virtme #45 PREEMPT(full)
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  RIP: 0010:ets_offload_change+0x11f/0x290 [sch_ets]
>  Code: e4 45 31 ff eb 03 41 89 c7 41 89 cb 89 ce 83 f9 0f 0f 87 b7 00 00 00 45 8b 08 31 c0 45 01 cc 45 85 c9 74 09 41 6b c4 64 31 d2 <41> f7 f2 89 c2 44 29 fa 45 89 df 41 83 fb 0f 0f 87 c7 00 00 00 44
>  RSP: 0018:ffffd0a180d77588 EFLAGS: 00010246
>  RAX: 00000000ffffff38 RBX: ffff8d3d482ca000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffd0a180d77660
>  RBP: ffffd0a180d77690 R08: ffff8d3d482ca2d8 R09: 00000000fffffffe
>  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffe
>  R13: ffff8d3d472f2000 R14: 0000000000000003 R15: 0000000000000000
>  FS:  00007f440b6c2740(0000) GS:ffff8d3dc9803000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000003cdd2000 CR3: 0000000007b58002 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   ets_qdisc_change+0x870/0xf40 [sch_ets]
>   qdisc_create+0x12b/0x540
>   tc_modify_qdisc+0x6d7/0xbd0
>   rtnetlink_rcv_msg+0x168/0x6b0
>   netlink_rcv_skb+0x5c/0x110
>   netlink_unicast+0x1d6/0x2b0
>   netlink_sendmsg+0x22e/0x470
>   ____sys_sendmsg+0x38a/0x3c0
>   ___sys_sendmsg+0x99/0xe0
>   __sys_sendmsg+0x8a/0xf0
>   do_syscall_64+0x111/0xf80
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7f440b81c77e
>  Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>  RSP: 002b:00007fff951e4c10 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 0000000000481820 RCX: 00007f440b81c77e
>  RDX: 0000000000000000 RSI: 00007fff951e4cd0 RDI: 0000000000000003
>  RBP: 00007fff951e4c20 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff951f4fa8
>  R13: 00000000699ddede R14: 00007f440bb01000 R15: 0000000000486980
>   </TASK>
>  Modules linked in: sch_ets(E) netdevsim(E)
> 
> [...]

Here is the summary with links:
  - [net] net/sched: ets: fix divide by zero in the offload path
    https://git.kernel.org/netdev/net/c/e35626f610f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



