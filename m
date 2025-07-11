Return-Path: <netdev+bounces-206230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98CCB02382
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53781CC292A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221262F2C7F;
	Fri, 11 Jul 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uV5wKG/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC972F271F
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258104; cv=none; b=Ot9mmPRFk/x9jVqseMewIadN0nvTzsIdXPEab8b7RzM9sjeHUEmqzmgc61kS1dcGraihkr6uv43Y5hLHCDXO3N6nSv4vVf5ryLJ5+95HoKZkRNZEM/Oiwe6zOgb9aULBqwHgnohTZX1kAhE1nLbV1v01U2b8OPBVtFTMIP1Z/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258104; c=relaxed/simple;
	bh=M73dbrcEV7G2fa5uMoQdHVgS8PX3NbdFnd+sK/rZwLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k67xKIyCABLJnBH6Ec/tehJR28hXwsU55yNmYCKRdNbstE3l3YT9Hz9Fbhmyw7ar5z3DbiHamOKWZ0uT2YOB5FimWvaz+ySi2pC9SXtHd71AJTmeBxUPkH5Tpx4NZLeexXcvB99m8NX4tJbmsvytOLWoWpriZJnR/xv0QeLgvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uV5wKG/p; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31df10dfadso1750304a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752258101; x=1752862901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw45dXyn3sqUCwdr4DS7NIcKyUgYInb9SPxxtooApSY=;
        b=uV5wKG/pvyTrm71r9TXLyDgyLKC2FraQDHiMv+wAOrGeV+9e1ge8RMZT2QRp983JWV
         dla7jr9duSmetV2HeNKdhYeLZt5JNd4FOkw9on5UpFpvd+HL1FkZvcYLIVK6DXmdCAKP
         TuDu8/jRx7rCfBmxffnCoF6CTljG1juqX67avNVlJLEoJWVHKeYQPk9hdQhTX9c9D2m5
         XX8PVYEymmqegMVJUYrjY8nMEOqShSrT5U+3KSOFKjfvXySGrP+3vpYG6hReuEDXPMJ+
         Q3fXDVD5iZdDJLTsLSkJNL946FlV37XbM53mkjZgfIW9RoDx5j4PExCv6nWqfbMEdHBw
         cYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258101; x=1752862901;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw45dXyn3sqUCwdr4DS7NIcKyUgYInb9SPxxtooApSY=;
        b=sz3bQm1zF7PuDSYgc9QzPG0AAL0ODlGz2juOBILlAxyWwppbDEeqsWxqyfkgoXB8RE
         aVs3t6q2ktqYzEGK4+ANImFkxBIue5KoEpNXRroIzJkXP7+6ikP8avQJ63mCtiCKq1Q4
         wy9IJp79A6+pd70ShOOzWmIci2O9+IbXI6B2InV9cGOqGRYIE3yxYOsfFYWFsrCmJ2mO
         qxnzjSSV4h1vXLkNgLZhmMcsScUk+TpGbEUjt8ytMAPlzLqadALCKyVY/XbifH/TxIfy
         srwn5V85tnXhUPA7+PockYKloI2/ihXkRKO6RmziXV5Iz+vrYx+RWkIoVO7pP+TG09if
         qMsw==
X-Forwarded-Encrypted: i=1; AJvYcCV7fvWHghJJW8dGWtemQpb5tbcFh264eZj++0aiYmPJ6l35kKMcGx2IGON7kj8VTL70oqPUymY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADAGB3xk+BcwNboReOvhyHKmgGpInugL7AGHrWEfqy2u9XePr
	aCZiV4NgZYKr6Jm7FIdXobcPLhLYVzhGfcKoF9+DCUhmxrSWdaczrePQlZSAZXV+zfiwTukVkgP
	hP/iN+A==
X-Google-Smtp-Source: AGHT+IF+34b51S0H4k28Lj47D/6K26H9l8MTfmG1+hLJV1nvu5aD+nEGlgxhbRc+WLOQz67PYCMEEEC2W4M=
X-Received: from pjff3.prod.google.com ([2002:a17:90b:5623:b0:311:b3fb:9f74])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384e:b0:312:e9bd:5d37
 with SMTP id 98e67ed59e1d1-31c4cc9c61fmr6593511a91.6.1752258101430; Fri, 11
 Jul 2025 11:21:41 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:21:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711182139.3580864-1-kuniyu@google.com>
Subject: [PATCH v1 net] rpl: Fix use-after-free in rpl_do_srh_inline().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Running lwt_dst_cache_ref_loop.sh in selftest with KASAN triggers
the splat below [0].

rpl_do_srh_inline() fetches ipv6_hdr(skb) and accesses it after
skb_cow_head(), which is illegal as the header could be freed then.

Let's fix it by making oldhdr to a local struct instead of a pointer.

[0]:
[root@fedora net]# ./lwt_dst_cache_ref_loop.sh
...
TEST: rpl (input)
[   57.631529] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in rpl_do_srh_inline.isra.0 (net/ipv6/rpl_i=
ptunnel.c:174)
Read of size 40 at addr ffff888122bf96d8 by task ping6/1543

CPU: 50 UID: 0 PID: 1543 Comm: ping6 Not tainted 6.16.0-rc5-01302-gfadd1e62=
31b1 #23 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1=
.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:409 mm/kasan/report.c:521)
 kasan_report (mm/kasan/report.c:221 mm/kasan/report.c:636)
 kasan_check_range (mm/kasan/generic.c:175 (discriminator 1) mm/kasan/gener=
ic.c:189 (discriminator 1))
 __asan_memmove (mm/kasan/shadow.c:94 (discriminator 2))
 rpl_do_srh_inline.isra.0 (net/ipv6/rpl_iptunnel.c:174)
 rpl_input (net/ipv6/rpl_iptunnel.c:201 net/ipv6/rpl_iptunnel.c:282)
 lwtunnel_input (net/core/lwtunnel.c:459)
 ipv6_rcv (./include/net/dst.h:471 (discriminator 1) ./include/net/dst.h:46=
9 (discriminator 1) net/ipv6/ip6_input.c:79 (discriminator 1) ./include/lin=
ux/netfilter.h:317 (discriminator 1) ./include/linux/netfilter.h:311 (discr=
iminator 1) net/ipv6/ip6_input.c:311 (discriminator 1))
 __netif_receive_skb_one_core (net/core/dev.c:5967)
 process_backlog (./include/linux/rcupdate.h:869 net/core/dev.c:6440)
 __napi_poll.constprop.0 (net/core/dev.c:7452)
 net_rx_action (net/core/dev.c:7518 net/core/dev.c:7643)
 handle_softirqs (kernel/softirq.c:579)
 do_softirq (kernel/softirq.c:480 (discriminator 20))
 </IRQ>
 <TASK>
 __local_bh_enable_ip (kernel/softirq.c:407)
 __dev_queue_xmit (net/core/dev.c:4740)
 ip6_finish_output2 (./include/linux/netdevice.h:3358 ./include/net/neighbo=
ur.h:526 ./include/net/neighbour.h:540 net/ipv6/ip6_output.c:141)
 ip6_finish_output (net/ipv6/ip6_output.c:215 net/ipv6/ip6_output.c:226)
 ip6_output (./include/linux/netfilter.h:306 net/ipv6/ip6_output.c:248)
 ip6_send_skb (net/ipv6/ip6_output.c:1983)
 rawv6_sendmsg (net/ipv6/raw.c:588 net/ipv6/raw.c:918)
 __sys_sendto (net/socket.c:714 (discriminator 1) net/socket.c:729 (discrim=
inator 1) net/socket.c:2228 (discriminator 1))
 __x64_sys_sendto (net/socket.c:2231)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/e=
ntry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f68cffb2a06
Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 =
75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c=
3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
RSP: 002b:00007ffefb7c53d0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000564cd69f10a0 RCX: 00007f68cffb2a06
RDX: 0000000000000040 RSI: 0000564cd69f10a4 RDI: 0000000000000003
RBP: 00007ffefb7c53f0 R08: 0000564cd6a032ac R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000564cd69f10a4
R13: 0000000000000040 R14: 00007ffefb7c66e0 R15: 0000564cd69f10a0
 </TASK>

Allocated by task 1543:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c=
:69 (discriminator 1))
 __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasan/common.c:345)
 kmem_cache_alloc_node_noprof (./include/linux/kasan.h:250 mm/slub.c:4148 m=
m/slub.c:4197 mm/slub.c:4249)
 kmalloc_reserve (net/core/skbuff.c:581 (discriminator 88))
 __alloc_skb (net/core/skbuff.c:669)
 __ip6_append_data (net/ipv6/ip6_output.c:1672 (discriminator 1))
 ip6_append_data (net/ipv6/ip6_output.c:1859)
 rawv6_sendmsg (net/ipv6/raw.c:911)
 __sys_sendto (net/socket.c:714 (discriminator 1) net/socket.c:729 (discrim=
inator 1) net/socket.c:2228 (discriminator 1))
 __x64_sys_sendto (net/socket.c:2231)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/e=
ntry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Freed by task 1543:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c=
:69 (discriminator 1))
 kasan_save_free_info (mm/kasan/generic.c:579 (discriminator 1))
 __kasan_slab_free (mm/kasan/common.c:271)
 kmem_cache_free (mm/slub.c:4643 (discriminator 3) mm/slub.c:4745 (discrimi=
nator 3))
 pskb_expand_head (net/core/skbuff.c:2274)
 rpl_do_srh_inline.isra.0 (net/ipv6/rpl_iptunnel.c:158 (discriminator 1))
 rpl_input (net/ipv6/rpl_iptunnel.c:201 net/ipv6/rpl_iptunnel.c:282)
 lwtunnel_input (net/core/lwtunnel.c:459)
 ipv6_rcv (./include/net/dst.h:471 (discriminator 1) ./include/net/dst.h:46=
9 (discriminator 1) net/ipv6/ip6_input.c:79 (discriminator 1) ./include/lin=
ux/netfilter.h:317 (discriminator 1) ./include/linux/netfilter.h:311 (discr=
iminator 1) net/ipv6/ip6_input.c:311 (discriminator 1))
 __netif_receive_skb_one_core (net/core/dev.c:5967)
 process_backlog (./include/linux/rcupdate.h:869 net/core/dev.c:6440)
 __napi_poll.constprop.0 (net/core/dev.c:7452)
 net_rx_action (net/core/dev.c:7518 net/core/dev.c:7643)
 handle_softirqs (kernel/softirq.c:579)
 do_softirq (kernel/softirq.c:480 (discriminator 20))
 __local_bh_enable_ip (kernel/softirq.c:407)
 __dev_queue_xmit (net/core/dev.c:4740)
 ip6_finish_output2 (./include/linux/netdevice.h:3358 ./include/net/neighbo=
ur.h:526 ./include/net/neighbour.h:540 net/ipv6/ip6_output.c:141)
 ip6_finish_output (net/ipv6/ip6_output.c:215 net/ipv6/ip6_output.c:226)
 ip6_output (./include/linux/netfilter.h:306 net/ipv6/ip6_output.c:248)
 ip6_send_skb (net/ipv6/ip6_output.c:1983)
 rawv6_sendmsg (net/ipv6/raw.c:588 net/ipv6/raw.c:918)
 __sys_sendto (net/socket.c:714 (discriminator 1) net/socket.c:729 (discrim=
inator 1) net/socket.c:2228 (discriminator 1))
 __x64_sys_sendto (net/socket.c:2231)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/e=
ntry/syscall_64.c:94 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

The buggy address belongs to the object at ffff888122bf96c0
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 24 bytes inside of
 freed 704-byte region [ffff888122bf96c0, ffff888122bf9980)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x122bf8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000040 ffff888101fc0a00 ffffea000464dc00 0000000000000002
raw: 0000000000000000 0000000080270027 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888101fc0a00 ffffea000464dc00 0000000000000002
head: 0000000000000000 0000000080270027 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea00048afe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888122bf9580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888122bf9600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888122bf9680: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                    ^
 ffff888122bf9700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888122bf9780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: a7a29f9c361f8 ("net: ipv6: add rpl sr tunnel")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/rpl_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 7c05ac846646f..eccfa4203e96b 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -129,13 +129,13 @@ static int rpl_do_srh_inline(struct sk_buff *skb, con=
st struct rpl_lwt *rlwt,
 			     struct dst_entry *cache_dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
-	const struct ipv6hdr *oldhdr;
+	struct ipv6hdr oldhdr;
 	struct ipv6hdr *hdr;
 	unsigned char *buf;
 	size_t hdrlen;
 	int err;
=20
-	oldhdr =3D ipv6_hdr(skb);
+	memcpy(&oldhdr, ipv6_hdr(skb), sizeof(oldhdr));
=20
 	buf =3D kcalloc(struct_size(srh, segments.addr, srh->segments_left), 2, G=
FP_ATOMIC);
 	if (!buf)
@@ -147,7 +147,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const=
 struct rpl_lwt *rlwt,
 	memcpy(isrh, srh, sizeof(*isrh));
 	memcpy(isrh->rpl_segaddr, &srh->rpl_segaddr[1],
 	       (srh->segments_left - 1) * 16);
-	isrh->rpl_segaddr[srh->segments_left - 1] =3D oldhdr->daddr;
+	isrh->rpl_segaddr[srh->segments_left - 1] =3D oldhdr.daddr;
=20
 	ipv6_rpl_srh_compress(csrh, isrh, &srh->rpl_segaddr[0],
 			      isrh->segments_left - 1);
@@ -169,7 +169,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const=
 struct rpl_lwt *rlwt,
 	skb_mac_header_rebuild(skb);
=20
 	hdr =3D ipv6_hdr(skb);
-	memmove(hdr, oldhdr, sizeof(*hdr));
+	memmove(hdr, &oldhdr, sizeof(*hdr));
 	isrh =3D (void *)hdr + sizeof(*hdr);
 	memcpy(isrh, csrh, hdrlen);
=20
--=20
2.50.0.727.gbf7dc18ff4-goog


