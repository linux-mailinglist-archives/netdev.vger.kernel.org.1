Return-Path: <netdev+bounces-306477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m9LdHjW5UGod4AIAu9opvQ
	(envelope-from <netdev+bounces-306477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B1738F58
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=gYqnPrTx;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306477-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306477-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D15C30A36A3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BB3DB33F;
	Fri, 10 Jul 2026 09:04:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7FB3DA7C9
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674252; cv=none; b=i7I4Fyf+VMKt8+9HUc3nF9Q7D3g9Y3Q7uYgDPnAbfhA5XE/bXpcR1nWiD5pylg8TNhkOnqegML7UtEggfQfNdcrxqHPsKX0mAD3nQgd1rpSOpHJWeQprXtf8k5nA0JsNI3W6yxUr22njjwMsi5nfzpbyTJFUY3qqzyHKC4ITcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674252; c=relaxed/simple;
	bh=MqJ7Qd/uBASgMx17A8ICPjskOClV0rzsLAldUS/WKLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMvErn1wJjdYCJ+0SkpGZCxiTClEhIJ6fQ7hFDgPaRAZE6Rz06eGSU1hDZgI8UCidm+HfK+03SCCDFrQ+hTiC2aU/u1z9joh5HLbyRxFfqa1YjBbtZLRH7lwkLAJ+G4l3zv0UQMfhx9zr4V5gZKIBc7wq8lQpW9gamJ1SqRXf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gYqnPrTx; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B3557207BE;
	Fri, 10 Jul 2026 11:04:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3v1PaCNNs13x; Fri, 10 Jul 2026 11:04:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E6BAD20851;
	Fri, 10 Jul 2026 11:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E6BAD20851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674245;
	bh=CycHHjpmu2wZoVM1CpbGNe9+XmOuklm1OpvLjnAhk8c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=gYqnPrTx8GzdKMzgSVsNW1iOhnE2zSS1N3hNOCMdgfuJGjacFf8/sQEWAX/4dODiq
	 vkL1O8qKwTymzHUROY5/6ds+h3KEd9Dqd3AGPjAmuQWpb9P26uGo5OgVKI9n+PAfnr
	 5Rrlg6in27KPjnhRY9V9aFDG/jnriIv2Kvdrn9qDRdQYDd+XeEeBEnw2En+iPgvRTq
	 JhGOMI9cpvDxxM2Ifp/7X514dH2hkZnwHK64QiabhYSgxRoeipEGgo1YTZScLmkz8W
	 0nCqv5A27clrf2wUAumKm7/YNrgXhzCFN0Ox0v+IziKEd/6TiMgXXpQ2++k419Fp8v
	 iq3DLHlPJ2nqA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:05 +0200
Received: (nullmailer pid 343851 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/10] xfrm: reject optional IPTFS templates in outbound policies
Date: Fri, 10 Jul 2026 11:03:19 +0200
Message-ID: <20260710090349.343389-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306477-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D44B1738F58

From: Antony Antony <antony.antony@secunet.com>

syzbot reported a stack-out-of-bounds read in xfrm_state_find()
which flows from xfrm_tmpl_resolve_one().

Commit 3d776e31c841 ("xfrm: Reject optional tunnel/BEET mode
templates in outbound policies") disallowed optional tunnel and
BEET in outbound policies to prevent this. Later when IPTFS
added, it was not covered by that fix and can still trigger
the out-of-bounds read;

Extend the check to disallow optional IPTFS in outbound policies
as well. IPTFS should be identical to tunnel mode.
IN and FWD policies are not affected: xfrm_tmpl_resolve_one()
is only reachable via the outbound path.

Reproducer, before:

ip link add dummy0 type dummy
ip link set dummy0 up
ip addr add 10.1.1.1/24 dev dummy0
ip xfrm policy add src 10.1.1.1/32 dst 10.1.1.2/32 dir out tmpl
  src fc00::dead:1 dst fc00::dead:2 proto esp reqid 1 mode iptfs
  level use tmpl src fc00::dead:1 dst fc00::dead:2 proto esp reqid
  2 mode transport
ping -W 1 -c 1 10.1.1.2
PING 10.1.1.2 (10.1.1.2) 56(84) bytes of data.

[   64.168420] ==================================================================
[   64.169977] BUG: KASAN: stack-out-of-bounds in __xfrm6_addr_hash+0x11e/0x170
[   64.169977] Read of size 4 at addr ffff88800e1ffd20 by task ping/2844

[   64.169977] CPU: 2 UID: 0 PID: 2844 Comm: ping Not tainted 7.1.0-rc7-00180-geb23b588430a #98 PREEMPT(full)
[   64.169977] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   64.169977] Call Trace:
[   64.169977]  <TASK>
[   64.169977]  dump_stack_lvl+0x47/0x70
[   64.169977]  ? __xfrm6_addr_hash+0x11e/0x170
[   64.169977]  print_report+0x152/0x4b0
[   64.169977]  ? ksys_mmap_pgoff+0x6d/0xa0
[   64.169977]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.169977]  ? rcu_read_unlock_sched+0xa/0x20
[   64.169977]  ? __virt_addr_valid+0x21b/0x230
[   64.169977]  ? __xfrm6_addr_hash+0x11e/0x170
[   64.169977]  kasan_report+0xa8/0xd0
[   64.169977]  ? __xfrm6_addr_hash+0x11e/0x170
[   64.169977]  __xfrm6_addr_hash+0x11e/0x170
[   64.169977]  __xfrm_dst_hash+0x24/0xc0
[   64.169977]  xfrm_state_find+0xa2d/0x2f90
[   64.169977]  ? __pfx_xfrm_state_find+0x10/0x10
[   64.169977]  ? __pfx_ftrace_graph_ret_addr+0x10/0x10
[   64.169977]  ? __pfx_ftrace_graph_ret_addr+0x10/0x10
[   64.169977]  xfrm_tmpl_resolve_one+0x210/0x570
[   64.169977]  ? __pfx_xfrm_tmpl_resolve_one+0x10/0x10
[   64.169977]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   64.169977]  ? kernel_text_address+0x5b/0x80
[   64.169977]  ? __kernel_text_address+0xe/0x30
[   64.169977]  ? unwind_get_return_address+0x5e/0x90
[   64.169977]  ? arch_stack_walk+0x8c/0xe0
[   64.169977]  xfrm_tmpl_resolve+0x130/0x200
[   64.169977]  ? __pfx_xfrm_tmpl_resolve+0x10/0x10
[   64.169977]  ? __pfx_xfrm_policy_inexact_lookup_rcu+0x10/0x10
[   64.169977]  ? __refcount_add_not_zero.constprop.0+0xb2/0x110
[   64.169977]  ? __pfx___refcount_add_not_zero.constprop.0+0x10/0x10
[   64.169977]  xfrm_resolve_and_create_bundle+0xd5/0x310
[   64.169977]  ? __pfx_xfrm_resolve_and_create_bundle+0x10/0x10
[   64.169977]  ? __pfx_xfrm_policy_lookup_bytype+0x10/0x10
[   64.169977]  ? __pfx_xfrm_policy_lookup_bytype+0x10/0x10
[   64.169977]  xfrm_lookup_with_ifid+0x3d8/0xb80
[   64.169977]  ? __pfx_xfrm_lookup_with_ifid+0x10/0x10
[   64.169977]  ? ip_route_output_key_hash+0xc6/0x110
[   64.169977]  ? kasan_save_track+0x10/0x30
[   64.169977]  xfrm_lookup_route+0x18/0xe0
[   64.169977]  ip4_datagram_release_cb+0x4c9/0x530
[   64.169977]  ? __pfx_ip4_datagram_release_cb+0x10/0x10
[   64.169977]  ? do_raw_spin_lock+0x71/0xc0
[   64.169977]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   64.169977]  release_sock+0xb0/0x170
[   64.169977]  udp_connect+0x43/0x50
[   64.169977]  __sys_connect+0xa6/0x100
[   64.169977]  ? alloc_fd+0x2e9/0x300
[   64.169977]  ? __pfx___sys_connect+0x10/0x10
[   64.169977]  ? preempt_latency_start+0x1f/0x70
[   64.169977]  ? fd_install+0x7e/0x150
[   64.169977]  ? rcu_read_unlock_sched+0xa/0x20
[   64.169977]  ? __sys_socket+0xdf/0x130
[   64.169977]  ? __pfx___sys_socket+0x10/0x10
[   64.169977]  ? vma_refcount_put+0x43/0xa0
[   64.169977]  __x64_sys_connect+0x7e/0x90
[   64.169977]  do_syscall_64+0x11b/0x2b0
[   64.169977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.169977] RIP: 0033:0x7f4851ecb570
[   64.169977] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d f9 ca 0d 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
[   64.169977] RSP: 002b:00007ffc830e3498 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
[   64.169977] RAX: ffffffffffffffda RBX: 00007ffc830e34d0 RCX: 00007f4851ecb570
[   64.169977] RDX: 0000000000000010 RSI: 00007ffc830e34d0 RDI: 0000000000000005
[   64.169977] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[   64.169977] R10: 0000000000000006 R11: 0000000000000202 R12: 0000000000000005
[   64.169977] R13: 0000000000000000 R14: 00005619a863f340 R15: 0000000000000000
[   64.169977]  </TASK>

[   64.169977] The buggy address belongs to stack of task ping/2844
[   64.169977]  and is located at offset 88 in frame:
[   64.169977]  ip4_datagram_release_cb+0x0/0x530

[   64.169977] This frame has 1 object:
[   64.169977]  [32, 88) 'fl4'

[   64.169977] The buggy address belongs to the physical page:
[   64.169977] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe1ff
[   64.169977] flags: 0x4000000000000000(zone=1)
[   64.169977] raw: 4000000000000000 0000000000000000 ffffea0000387fc8 0000000000000000
[   64.169977] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   64.169977] page dumped because: kasan: bad access detected

[   64.169977] Memory state around the buggy address:
[   64.169977]  ffff88800e1ffc00: f2 f2 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00
[   64.169977]  ffff88800e1ffc80: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00
[   64.169977] >ffff88800e1ffd00: 00 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00
[   64.169977]                                ^
[   64.169977]  ffff88800e1ffd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
[   64.169977]  ffff88800e1ffe00: f1 f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   64.169977] ==================================================================
[   64.245153] Disabling lock debugging due to kernel taint

After the fix:

ip xfrm policy add src 10.1.1.1/32 dst 10.1.1.2/32 dir out tmpl \
 src fc00::dead:1 dst fc00::dead:2 proto esp reqid 1 mode iptfs \
 level use tmpl src fc00::dead:1 dst fc00::dead:2 proto esp reqid 2 \
 mode transport

Error: Mode in optional template not allowed in outbound policy.

Fixes: d1716d5a44c3 ("xfrm: add generic iptfs defines and functionality")
Reported-by: syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a3ceb94.43b4ff68.30a095.0004.GAE@google.com/T/
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 0eb87fc998d1..d6db63304ba6 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2124,13 +2124,12 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 		switch (ut[i].mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
+		case XFRM_MODE_IPTFS:
 			if (ut[i].optional && dir == XFRM_POLICY_OUT) {
 				NL_SET_ERR_MSG(extack, "Mode in optional template not allowed in outbound policy");
 				return -EINVAL;
 			}
 			break;
-		case XFRM_MODE_IPTFS:
-			break;
 		default:
 			if (ut[i].family != prev_family) {
 				NL_SET_ERR_MSG(extack, "Mode in template doesn't support a family change");
-- 
2.43.0


