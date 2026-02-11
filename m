Return-Path: <netdev+bounces-258353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JGI7BdPdjGl8uQAAu9opvQ
	(envelope-from <netdev+bounces-258353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:51:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167F127449
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD5C30125EF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B647335083;
	Wed, 11 Feb 2026 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NwycEEJK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qy595Zjx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BFyPBNzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xQwBIgSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9A221577
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839504; cv=none; b=jnI8vlfje90XtjFi/cskERCeNw4dfQxtTvnXoloYZHDRf9RJiW6TR5K5WtRstVUW/vhCGCIBbwaNMbRh9/r++hYvguf01nvQR5T/18SRBFckc7/RPMa5EcobTvxw3njlKXJSMNThiEeMCiC1fMufnXJg/tszetEQKDEEph+RyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839504; c=relaxed/simple;
	bh=n9048xvsvlXMU9UhiahywhqKdr06ki2zLUGixBcGnY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JU5VQb0FPEku5jOWPgoIt5XIqL1XwxFETSHDbO9++//g22vhXj5O6d0Ca8NZxNwkZA0cI165D4EOqjo8sQebZxQAFKhIfZ7WU/cZiBWIVF9phn9PeclE8g04ZgM4/bkEoSPv4rEprJyO5f7cv0NrhBivtVb8H3emxI4KEZdAxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwycEEJK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qy595Zjx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BFyPBNzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xQwBIgSF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1602D3E748;
	Wed, 11 Feb 2026 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770839495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZFQFR7uBEgYkNlMM16a9RAnZTWaL3ZVxxJ+VHSUfq4=;
	b=NwycEEJKlZ7JM+X6OaaEbK6AuTsnif3tIh1yOcvxJOEUvV6bxjxawDdRy/pahTh9YaKb8C
	z+htRtd9FzOsSuh7FP96AXYZylmVyuOPje8iFOQxVlwG0TVgsXQ4QTpu72n25NdJKfWYsj
	PtFdeQ0v5dKyv3ErXlW+ya7S7itqGBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770839495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZFQFR7uBEgYkNlMM16a9RAnZTWaL3ZVxxJ+VHSUfq4=;
	b=qy595ZjxDbEi0IMqRParWoMEUgpi+tjFGyFZtGzB8QmEhT/xaTSA1LL/JA5z/GOXesI9dY
	D97iN7YTyr5gTcAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BFyPBNzy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xQwBIgSF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770839494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZFQFR7uBEgYkNlMM16a9RAnZTWaL3ZVxxJ+VHSUfq4=;
	b=BFyPBNzyHWH4TxxNbbhOzOcCLDi2tPROfe/onOq4x3BKd5xhhyJ1hnvhoVPnmpxL/svZEG
	h0MPBaqyv6CeNCvO9T3+81kRtqTOLdzPrbs6D3j/o9EE2G9+6zVsF+ZXbQLEOT8uyxRm/h
	TLaZCmb7Ue8pI478OhwWid9G0A3UjYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770839494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZFQFR7uBEgYkNlMM16a9RAnZTWaL3ZVxxJ+VHSUfq4=;
	b=xQwBIgSFhnwcvpOZ8DstsWFPuGxXpfqy3V2+L4VFuHfcnpdIMZf3jNrge2O1Mvlukngvqy
	jSrKJ0ydmh8v7vAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C57E3EA62;
	Wed, 11 Feb 2026 19:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aO5fE8XdjGljJwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 11 Feb 2026 19:51:33 +0000
Message-ID: <8a1fe2ae-2c87-4e02-b3b3-5c709573c27f@suse.de>
Date: Wed, 11 Feb 2026 20:51:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] ipv6: Fix out-of-bound access in
 fib6_add_rt2node().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
References: <20260211175133.3657034-1-kuniyu@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260211175133.3657034-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-258353-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,707d6a5da1ab9e0c6f9d];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5167F127449
X-Rspamd-Action: no action

On 2/11/26 6:50 PM, Kuniyuki Iwashima wrote:
> syzbot reported out-of-bound read in fib6_add_rt2node(). [0]
> 
> When IPv6 route is created with RTA_NH_ID, struct fib6_info
> does not have the trailing struct fib6_nh.
> 
> The cited commit started to check !iter->fib6_nh->fib_nh_gw_family
> to ensure that rt6_qualify_for_ecmp() will return false for iter.
> 
> If iter->nh is not NULL, rt6_qualify_for_ecmp() returns false anyway.
> 
> Let's check iter->nh before reading iter->fib6_nh and avoid OOB read.
> 
> [0]:
> BUG: KASAN: slab-out-of-bounds in fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
> Read of size 1 at addr ffff8880384ba6de by task syz.0.18/5500
> 
> CPU: 0 UID: 0 PID: 5500 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xba/0x230 mm/kasan/report.c:482
>   kasan_report+0x117/0x150 mm/kasan/report.c:595
>   fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
>   fib6_add_rt2node_nh net/ipv6/ip6_fib.c:1363 [inline]
>   fib6_add+0x910/0x18c0 net/ipv6/ip6_fib.c:1531
>   __ip6_ins_rt net/ipv6/route.c:1351 [inline]
>   ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3957
>   inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
>   rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>   netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>   netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>   sock_sendmsg_nosec net/socket.c:727 [inline]
>   __sock_sendmsg net/socket.c:742 [inline]
>   ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
>   __sys_sendmsg net/socket.c:2678 [inline]
>   __do_sys_sendmsg net/socket.c:2683 [inline]
>   __se_sys_sendmsg net/socket.c:2681 [inline]
>   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9316b9aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd8809b678 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f9316e15fa0 RCX: 00007f9316b9aeb9
> RDX: 0000000000000000 RSI: 0000200000004380 RDI: 0000000000000003
> RBP: 00007f9316c08c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9316e15fac R14: 00007f9316e15fa0 R15: 00007f9316e15fa0
>   </TASK>
> 
> Allocated by task 5499:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>   kasan_kmalloc include/linux/kasan.h:263 [inline]
>   __do_kmalloc_node mm/slub.c:5657 [inline]
>   __kmalloc_noprof+0x40c/0x7e0 mm/slub.c:5669
>   kmalloc_noprof include/linux/slab.h:961 [inline]
>   kzalloc_noprof include/linux/slab.h:1094 [inline]
>   fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
>   ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3820
>   ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3949
>   inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
>   rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>   netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>   netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>   sock_sendmsg_nosec net/socket.c:727 [inline]
>   __sock_sendmsg net/socket.c:742 [inline]
>   ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
>   __sys_sendmsg net/socket.c:2678 [inline]
>   __do_sys_sendmsg net/socket.c:2683 [inline]
>   __se_sys_sendmsg net/socket.c:2681 [inline]
>   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF")
> Reported-by: syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/698cbfba.050a0220.2eeac1.009d.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   net/ipv6/ip6_fib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thank you, I completely forgot about the nexthop object while reviewing 
the blamed patch.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

