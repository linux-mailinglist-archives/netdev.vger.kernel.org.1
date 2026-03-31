Return-Path: <netdev+bounces-273716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCn7MlIHzGn+NQYAu9opvQ
	(envelope-from <netdev+bounces-273716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C136F238
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F6483061229
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AEE2D2495;
	Tue, 31 Mar 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhuPmgbB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164543CEED
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978540; cv=none; b=JJSV5aZN+Y/mWyQuWNPCGv/9gZWsSl3a3FhADR3bnvZfBCpZdFfjxKpBrRPkyPA+ymYFqWoY2f2RimbXYeeGHq7ONuakRvlzmJg5/waGRn53PFF3HWjUPShJakmL0MZwaNvHF0jZ6DOfZ3tEkKuopY9cv0CY6nYPV+S0yfx4xVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978540; c=relaxed/simple;
	bh=vUG6c5DnRRsBQAbjoRhVJa/0egLwSw7laU93yTCeI2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7ha7HAqhs58ln/lEzrf4/XByBpm3JT8fCAEdpPi1vyrqyecvVYvzTedb3fOA4CZuP/QWoJUqY0TGGzFWYginOCKQ5hksxRLXNU/1tLbwEK3mLcL7rOzX4AtmDdapj14VWZVVs7Cpp8nJPUV95jxOUY/2PUO19TYR2eLPRl/hIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhuPmgbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE98C19423;
	Tue, 31 Mar 2026 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978540;
	bh=vUG6c5DnRRsBQAbjoRhVJa/0egLwSw7laU93yTCeI2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AhuPmgbB9vrktIFKicIPu3EnMWqAXytwhEBvx0e8KJ6IsO81ZSHm8El908ogKbplF
	 7YRvfklV6s58pn3KP3DfuvGxiwDfI2QHyHu4rdNyl3s5bJ1X3GpY3kXug9E8Uy05Kq
	 r02PqjRtBO8OtFDRdmy1a0yShi61f2YS9bKycDXYRB7dMiwT8bia8jFPXBU+0aEkCP
	 RjwTh3siZxRk3zGy+4wwwjQbHuNSGZ+BPK2nDhGfgyZb8nnLguaxwysuC1UKtcFZyY
	 21Qz0DuEnPkCl7gtGhNxtUeCRg4lNsD2KtqRVJkZ/CTWBlmi3Bh2F7rn16hcdTsITp
	 w2blT5cbZLh3A==
Date: Tue, 31 Mar 2026 10:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, Yiming Qian
 <yimingqian591@gmail.com>
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260331103538.103e3778@kernel.org>
In-Reply-To: <20260331115943.10404-1-fmancera@suse.de>
References: <20260331115943.10404-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-273716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 465C136F238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 13:59:43 +0200 Fernando Fernandez Mancera wrote:
> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> allocation fails for large nexthop groups like 512+ nexthops.

router_mpath_seed.sh says:

[    9.366434] WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x181/0x1b0, CPU#0: ip/342
[    9.366490] Modules linked in: vrf veth
[    9.366519] CPU: 0 UID: 0 PID: 342 Comm: ip Not tainted 7.0.0-rc5-virtme #1 PREEMPT(lazy) 
[    9.366567] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    9.366610] RIP: 0010:rtm_get_nexthop+0x181/0x1b0
[    9.366649] Code: 25 a7 ee ff eb 80 48 c7 c7 a0 ee af ae e8 57 30 f5 ff 4d 85 ed 74 08 49 c7 45 00 a0 ee af ae b8 ea ff ff ff e9 5d ff ff ff 90 <0f> 0b 90 ba 02 00 00 00 4c 89 ee 31 ff e8 2d 84 eb ff b8 a6 ff ff
[    9.366754] RSP: 0018:ff5db175808bf9d8 EFLAGS: 00010286
[    9.366790] RAX: 00000000ffffffa6 RBX: ff3c7cb941dab700 RCX: 0000000000000000
[    9.366835] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ff3c7cb94404a300
[    9.366872] RBP: ff3c7cb94404a400 R08: ff3c7cb9413f25a8 R09: ff3c7cb94196cb40
[    9.366916] R10: ff3c7cb94196ca00 R11: 000000000000000e R12: ffffffffaf8df6c0
[    9.366967] R13: ff3c7cb94404a300 R14: ff3c7cb94525e180 R15: ff3c7cb94404a400
[    9.367018] FS:  00007fa1f5261440(0000) GS:ff3c7cb9cf3fb000(0000) knlGS:0000000000000000
[    9.367064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.367102] CR2: 000000000044f720 CR3: 000000000573f001 CR4: 0000000000771ef0
[    9.367149] PKRU: 55555554
[    9.367165] Call Trace:
[    9.367183]  <TASK>
[    9.367201]  rtnetlink_rcv_msg+0x13a/0x3e0
[    9.367227]  ? get_page_from_freelist+0x1109/0x16c0
[    9.367259]  ? rtnl_calcit.isra.0+0x120/0x120
[    9.367286]  netlink_rcv_skb+0x59/0x100
[    9.367310]  netlink_unicast+0x255/0x380
[    9.367333]  netlink_sendmsg+0x1cc/0x3e0
[    9.367356]  ____sys_sendmsg+0x164/0x260
[    9.367390]  ___sys_sendmsg+0x99/0xe0
[    9.367415]  __sys_sendmsg+0x8a/0xe0
[    9.367441]  do_syscall_64+0x101/0xfc0
[    9.367466]  ? exc_page_fault+0x6e/0x170
[    9.367493]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    9.367528] RIP: 0033:0x7fa1f53bbc5e
[    9.367550] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[    9.367653] RSP: 002b:00007ffc00947ff0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[    9.367700] RAX: ffffffffffffffda RBX: 000000000048ba90 RCX: 00007fa1f53bbc5e
[    9.367744] RDX: 0000000000000000 RSI: 00007ffc009480b0 RDI: 0000000000000005
[    9.367787] RBP: 00007ffc00948000 R08: 0000000000000000 R09: 0000000000000000
[    9.367835] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000049d620
[    9.367889] R13: 0000000069cbe823 R14: 0000000000000004 R15: 000000000049d620

decoded:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/582821/vm-crash-thr4-1

