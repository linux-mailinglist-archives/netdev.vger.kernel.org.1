Return-Path: <netdev+bounces-176722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27209A6BA2B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452FB3B13D9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242D224B0B;
	Fri, 21 Mar 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsV6DqdF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08E22332C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558051; cv=none; b=UES+ictJh9OwBoTTZk56+eS/ADO1nprp6a5xGYbFdImN7XcMqy75jYogyjKW/A9+y7T+WbWeLjlApM/e8bLdma1U4Y5iPZip3eI8ZIxcBd37eRVIIjMWWx3587g5C8JtZwWY6GvHfBFIRcO0VTzxyT+u+/cM3i+gBUAh8hgk5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558051; c=relaxed/simple;
	bh=6yFycll2LhqQPNwBiehC3WfdCYrOTpshzY4S8MdN2rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phvERBM4sXdz/5z/QcYUFCuute+wjocLQ2syZZtx6SKcSLWnAg6u8uScPSr+krMcf0pP7BsqEcPZOR9rhinPWFvO2vSd0aYO5kBv68KiCYpR/s9f/0yqgu41v8Db2U5xgETYc3waT6wSc70uTkxCqeg6AdQyIgvde3C8+c8IpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsV6DqdF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnteUWt9wyYhbRiJ1qeHsqWxQRBKMCdaAPqGdqoj5gE=;
	b=XsV6DqdFjnUBPomEnpPU5VGzMXO4qwQQvJwBYC8baxifnb4SszNfcqkbWakQwH6Vxx2YL5
	EQ94mc0exw5aZ56VDCfAz1jPBMtZNt7IAz+cvPPZLE7VnsmGZilHkdVNi2TMk3equaKP/k
	cxPpp5Y4Xia8iHLcFIZkYdUR3WSv8Mw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-A5g0SpEvMcGwbn0-vUe_gQ-1; Fri,
 21 Mar 2025 07:54:03 -0400
X-MC-Unique: A5g0SpEvMcGwbn0-vUe_gQ-1
X-Mimecast-MFC-AGG-ID: A5g0SpEvMcGwbn0-vUe_gQ_1742558042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 033C01933B48;
	Fri, 21 Mar 2025 11:54:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDF91180175A;
	Fri, 21 Mar 2025 11:53:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 3/5] udp_tunnel: fix UaF in GRO accounting
Date: Fri, 21 Mar 2025 12:52:54 +0100
Message-ID: <70a8c5bdf58ed1937e2f3edbefb37c55cfe6ebc1.1742557254.git.pabeni@redhat.com>
In-Reply-To: <cover.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Siyzkaller reported a race in UDP tunnel GRO accounting, leading to
UaF:

BUG: KASAN: slab-use-after-free in udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
Read of size 8 at addr ffff88801235ebe8 by task syz.2.655/7921

CPU: 1 UID: 0 PID: 7921 Comm: syz.2.655 Not tainted 6.14.0-rc6-syzkaller-01313-g23c9ff659140 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
 sk_common_release+0x71/0x2e0 net/core/sock.c:3896
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_release+0x82/0x150 net/socket.c:675
 sock_free drivers/net/wireguard/socket.c:339 [inline]
 wg_socket_reinit+0x215/0x380 drivers/net/wireguard/socket.c:435
 wg_stop+0x59f/0x600 drivers/net/wireguard/device.c:133
 __dev_close_many+0x3a6/0x700 net/core/dev.c:1717
 dev_close_many+0x24e/0x4c0 net/core/dev.c:1742
 unregister_netdevice_many_notify+0x629/0x24f0 net/core/dev.c:11923
 rtnl_delete_link net/core/rtnetlink.c:3512 [inline]
 rtnl_dellink+0x526/0x8c0 net/core/rtnetlink.c:3554
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35ab38d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35ac28f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f35ab5a6160 RCX: 00007f35ab38d169
RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000004
RBP: 00007f35ab40e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f35ab5a6160 R15: 00007ffdddd781b8
 </TASK>

Allocated by task 7770:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2190
 sk_alloc+0x3e/0x370 net/core/sock.c:2249
 inet_create+0x648/0xea0 net/ipv4/af_inet.c:326
 __sock_create+0x4c0/0xa30 net/socket.c:1539
 sock_create net/socket.c:1597 [inline]
 __sys_socket_create net/socket.c:1634 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1681
 __do_sys_socket net/socket.c:1695 [inline]
 __se_sys_socket net/socket.c:1693 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1693
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7768:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4711
 sk_prot_free net/core/sock.c:2230 [inline]
 __sk_destruct+0x4fd/0x690 net/core/sock.c:2327
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1389
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801235e4c0
 which belongs to the cache UDP of size 1856
The buggy address is located 1832 bytes inside of
 freed 1856-byte region [ffff88801235e4c0, ffff88801235ec00)

At disposal time, to avoid unconditionally acquiring a spin lock, UDP
tunnel sockets are conditionally removed from the known tunnels list
only if the socket is actually present in such a list.

Such check happens outside the socket lock scope: the current CPU
could observe an uninitialized list entry even if the tunnel has been
actually registered by a different core.

Address the issue moving the blamed check under the relevant list
spin lock.

Reported-by: syzbot+1fb3291cc1beeb3c315a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
Fixes: 8d4880db37835 ("udp_tunnel: create a fastpath GRO lookup.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/udp_tunnel.h | 4 ----
 net/ipv4/udp_offload.c   | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index a7b230867eb14..13b54e6856414 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -214,14 +214,10 @@ static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
 
 static inline void udp_tunnel_cleanup_gro(struct sock *sk)
 {
-	struct udp_sock *up = udp_sk(sk);
 	struct net *net = sock_net(sk);
 
 	udp_tunnel_update_gro_rcv(sk, false);
 
-	if (!up->tunnel_list.pprev)
-		return;
-
 	udp_tunnel_update_gro_lookup(net, sk, false);
 }
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index fd2b8e3830beb..b124355a36aee 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -57,10 +57,11 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
 	struct udp_tunnel_gro *udp_tunnel_gro;
 
 	spin_lock(&udp_tunnel_gro_lock);
+
 	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
 	if (add)
 		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
-	else
+	else if (up->tunnel_list.pprev)
 		hlist_del_init(&up->tunnel_list);
 
 	if (udp_tunnel_gro->list.first &&
-- 
2.48.1


