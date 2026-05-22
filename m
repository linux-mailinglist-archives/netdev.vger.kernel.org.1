Return-Path: <netdev+bounces-290923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCIKKczKEGpAdwYAu9opvQ
	(envelope-from <netdev+bounces-290923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:29:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104595BA748
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46594300823B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB5388E48;
	Fri, 22 May 2026 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHeziVPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC5332913
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485385; cv=none; b=PcVq+/0f1XgvXySMeR5h1r6jZkM+/iUYYxusyIp+OnH2bOv3J+976yydxh/7zooQlzOTbSQPfjH7Qrov7/4L9KTiyYDpS+gNRNlN3m8zNGUULvVRrVRJkoghwreVVxNxR8b0E1DQb2uxpcxVEVHv47jrcqUQ3AWQLPbD9LzLVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485385; c=relaxed/simple;
	bh=KEoHFxqSfZiubgBPdzO5owVDC1W2g07FnrUTXRZq5uU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWxdi0B8HtErEGtsRVQlJW+60ISCT3E54t1crwEbJD5l4fZY+oSy0eBsjLlPzRL2nYcUciMH5nuCHr9wIZHZarP9DJuHrONymhMewjo+jELu5G9NqA772Ii8ypUDlOrLICiv9r0m0WT6YxtO0nIlNn9rQSUcSt9eau/06tuSoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHeziVPr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFBD1F000E9;
	Fri, 22 May 2026 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779485384;
	bh=vpHPzYq8EHD4VOAOrwxPgkdGpp/U7ktYggD4F+J6uM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RHeziVPripSIyezIb+Fv1nLJJggPWENUEumdLUqGIsOTo32yencMcrXR9hFVfKd98
	 9cDjsLDcuXdyrwTHS7BUagr+TqgisReDUS1EWGVZuWB9hgKpw9URxt2jsh2CKltIBd
	 KFno+hDilTWTzrWOuvlnSlonkZzqKH9d8IRe1sqJKcJM9X5RfGjAIYpaIco993E2pL
	 9XoX+ZJXwZR00D1qPcvZkPQztfqe1uonSdWvJPROKzdlt+derjzfu6+/FYDoV6oSAE
	 qQhMC6MnMCmu5sQWagfQHNZDyIzvQ46+RajRiY5ddAc89kYei4vfCBZXsjjNZDZMIf
	 n41NtDr1OdSFw==
Date: Fri, 22 May 2026 14:29:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v4 net-next 0/5] rtnetlink: RTNL avoidance in
 rtnl_getlink() and rtnl_dump_ifinfo()
Message-ID: <20260522142942.36973ef6@kernel.org>
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
References: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290923-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 104595BA748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 17:29:57 +0000 Eric Dumazet wrote:
> Many shell scripts invoke iproute2 commands specifying a device by
> its name.
> 
> This series improves their performance avoiding RTNL acquisition
> for their (repeated) name->index conversion.
> 
> v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)
> v4: Addressed Sashiko's feedback.
>     added 2 patches for rtnl_dump_ifinfo().

The CI looks fried, various errors:

# 0.02 [+0.02] RTNETLINK answers: File exists
# 0.02 [+0.00] Failed to create netif

# CMD: ip -d -j link show dev eth8
#   EXIT: 1
#   STDOUT: []
#   STDERR: RTNETLINK answers: Message too long
#           Cannot send link get request: Message too long

At boot we hit:

[    0.661578] ------------[ cut here ]------------
[    0.661608] WARNING: net/core/rtnetlink.c:4296 at rtnl_getlink+0x457/0x5e0, CPU#3: ip/71
[    0.661656] Modules linked in:
[    0.661681] CPU: 3 UID: 0 PID: 71 Comm: ip Tainted: G        W           7.1.0-rc4-virtme #1 PREEMPT(lazy) 
[    0.661735] Tainted: [W]=WARN
[    0.661756] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    0.661795] RIP: 0010:rtnl_getlink+0x457/0x5e0
[    0.661831] Code: ff ff 89 c3 48 83 c4 38 e8 76 44 fe ff 85 db 48 8b 7c 24 08 0f 84 2c 01 00 00 48 89 fe ba 02 00 00 00 31 ff e8 4a b7 fb ff 90 <0f> 0b 90 b8 a6 ff ff ff 49 8b 94 24 40 05 00 00 65 ff 0a 80 7c 24
[    0.661928] RSP: 0018:ff87a370c027b7a8 EFLAGS: 00010296
[    0.661956] RAX: 0000000000000010 RBX: 00000000ffffffa6 RCX: ff368f1541d3ef00
[    0.661998] RDX: ff368f157edadda0 RSI: 0000000000000011 RDI: ff368f15411ffa00
[    0.662041] RBP: ff368f1541e60b00 R08: ff368f1541845810 R09: ffffffff9ec3bbe6
[    0.662076] R10: ffd7c3a340079800 R11: ff368f15411ffa00 R12: ff368f1541e31000
[    0.662126] R13: ffffffff9fe4f700 R14: 0000000000000009 R15: ffffffff9fe4f700
[    0.662176] FS:  00007fa9d67e0600(0000) GS:ff368f15df00c000(0000) knlGS:0000000000000000
[    0.662219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.662253] CR2: 00007fff3c059c78 CR3: 000000000190f005 CR4: 0000000000771ef0
[    0.662294] PKRU: 55555554
[    0.662307] Call Trace:
[    0.662319]  <TASK>
[    0.662338]  ? rtnl_fill_ifinfo.isra.0+0x1670/0x1670
[    0.662366]  rtnetlink_rcv_msg+0x39f/0x460
[    0.662390]  ? rtnl_calcit.isra.0+0x160/0x160
[    0.662420]  netlink_rcv_skb+0xca/0x140
[    0.662445]  netlink_unicast+0x26b/0x3a0
[    0.662467]  netlink_sendmsg+0x1e2/0x430
[    0.662489]  ____sys_sendmsg+0x14c/0x2b0
[    0.662511]  ___sys_sendmsg+0xe1/0x120
[    0.662539]  __sys_sendmsg+0xad/0x100
[    0.662560]  do_syscall_64+0x104/0xfc0
[    0.662585]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    0.662609] RIP: 0033:0x7fa9d6a1808e
[    0.662631] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[    0.662733] RSP: 002b:00007fff3c059b50 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[    0.662775] RAX: ffffffffffffffda RBX: 00007fff3c05ce1d RCX: 00007fa9d6a1808e
[    0.662823] RDX: 0000000000000000 RSI: 00007fff3c059c00 RDI: 0000000000000004
[    0.662864] RBP: 00007fff3c059b60 R08: 0000000000000000 R09: 0000000000000000
[    0.662907] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[    0.662947] R13: 000000006a10c531 R14: 00007fff3c059ca0 R15: 00007fff3c05ce1d
[    0.662982]  </TASK>
[    0.662998] ---[ end trace 0000000000000000 ]---
[    0.663079] ------------[ cut here ]------------
[    0.663110] WARNING: net/core/rtnetlink.c:4523 at rtmsg_ifinfo_build_skb+0xc8/0x110, CPU#3: ip/71
[    0.663162] Modules linked in:
[    0.663186] CPU: 3 UID: 0 PID: 71 Comm: ip Tainted: G        W           7.1.0-rc4-virtme #1 PREEMPT(lazy) 
[    0.663235] Tainted: [W]=WARN
[    0.663256] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    0.663289] RIP: 0010:rtmsg_ifinfo_build_skb+0xc8/0x110
[    0.663319] Code: 80 00 00 00 e8 59 d9 ff ff 48 83 c4 38 85 c0 75 18 48 83 c4 08 4c 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 44 8b 48 08 eb b4 90 <0f> 0b 90 ba 02 00 00 00 4c 89 fe 31 ff e8 36 ab fb ff b9 a6 ff ff
[    0.663414] RSP: 0018:ff87a370c027b720 EFLAGS: 00010286
[    0.663439] RAX: 00000000ffffffa6 RBX: 0000000000000001 RCX: 0000000000000000
[    0.663485] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff368f1541e60700
[    0.663527] RBP: 0000000000000000 R08: ff368f1541845810 R09: ff368f154298f02c
[    0.663569] R10: ff368f1541e31120 R11: fefefefefefefeff R12: 0000000000000000
[    0.663612] R13: 0000000000000010 R14: ff368f1541e31000 R15: ff368f1541e60700
[    0.663655] FS:  00007fa9d67e0600(0000) GS:ff368f15df00c000(0000) knlGS:0000000000000000
[    0.663699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.663730] CR2: 000055ed56288988 CR3: 000000000190f005 CR4: 0000000000771ef0
[    0.663774] PKRU: 55555554
[    0.663787] Call Trace:
[    0.663803]  <TASK>
[    0.663821]  rtmsg_ifinfo+0x3c/0xa0
[    0.663845]  __dev_notify_flags+0xb1/0xf0
[    0.663867]  ? rtnl_getlink+0x456/0x5e0
[    0.663887]  netif_change_flags+0x54/0x70
[    0.663913]  do_setlink.isra.0+0x3a2/0x1500
[    0.663939]  ? __nla_validate_parse+0x76/0xf20
[    0.663970]  rtnl_newlink+0x9d3/0xd90
[    0.663993]  ? do_setlink.isra.0+0x1500/0x1500
[    0.664015]  rtnetlink_rcv_msg+0x39f/0x460
[    0.664035]  ? get_page_from_freelist+0x157a/0x16a0
[    0.664068]  ? rtnl_calcit.isra.0+0x160/0x160
[    0.664091]  netlink_rcv_skb+0xca/0x140
[    0.664118]  netlink_unicast+0x26b/0x3a0
[    0.664140]  netlink_sendmsg+0x1e2/0x430
[    0.664162]  ____sys_sendmsg+0x14c/0x2b0
[    0.664182]  ___sys_sendmsg+0xe1/0x120
[    0.664204]  __sys_sendmsg+0xad/0x100
[    0.664226]  do_syscall_64+0x104/0xfc0
[    0.664248]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    0.664275] RIP: 0033:0x7fa9d6a1808e
[    0.664295] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[    0.664397] RSP: 002b:00007fff3c05b1b0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[    0.664437] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa9d6a1808e
[    0.664478] RDX: 0000000000000000 RSI: 00007fff3c05b260 RDI: 0000000000000003
[    0.664520] RBP: 00007fff3c05b1c0 R08: 0000000000000000 R09: 0000000000000000
[    0.664559] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[    0.664604] R13: 000000006a10c531 R14: 000055ed1cfb1040 R15: 0000000000000000
[    0.664645]  </TASK>
[    0.664658] ---[ end trace 0000000000000000 ]---

