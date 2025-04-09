Return-Path: <netdev+bounces-180932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846EEA8318F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 22:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0607B1883EA6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20174202C44;
	Wed,  9 Apr 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gonB0jQI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC57143748
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744228913; cv=none; b=LnSiIfMAFS1s6/EqEDsA2LBE6OR/PNgBYzJr4qxSPrYXY6qng99xKgjMFhwH280whDBpPnvEySDi83TFbrDIzZ8ycrvKoeGtEhTTATuAQ2/IoDFmRVgQt8CfqpcsoSFJuabyJBtyQeIKbpgC86SIiFQQPapiq4u37MtS+iXHogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744228913; c=relaxed/simple;
	bh=yaL/ywHwuPQsVvtg6ZRMYk5T0/zBOQglL+9mB6Mwr7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Phpu5ocZQInmHpZO5asT59aGyt7EUMveiKmzciZWZcHUdude7+V4XDMaRoTCFGjrqd5x1T5DXzvSM5iLw8wt7j2e9SKif/svKQzeb/Lp9NWnwDqQ4qnESo5+M9uQWmopVuyK9m3qz8Gfx/i4k2IZDBcs5DXn2zDp1aK+NV6v3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gonB0jQI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744228910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIgAyrF2k7dRorD29uzq+ilAyM64Yue0WDj/eSINd/U=;
	b=gonB0jQI8+j2zcUpKsji6cyBj/0golNfYmpKLP8TYLVXkUueCWIQWlrImclBYF5/gFpgJg
	+vD6cyQChwcB4HApRyXbgmm9oMyINLOk4lm3a8m3Z0WS+p7nuUoxccCl4UgBNvuMdrZVHj
	VYAVSL8LeumZqKl3KynWXr0P+iO8o50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-1_OoWwkcN7iOJcyjRbD9WA-1; Wed,
 09 Apr 2025 16:01:46 -0400
X-MC-Unique: 1_OoWwkcN7iOJcyjRbD9WA-1
X-Mimecast-MFC-AGG-ID: 1_OoWwkcN7iOJcyjRbD9WA_1744228904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE82D187BE0A;
	Wed,  9 Apr 2025 20:01:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FBD8180B486;
	Wed,  9 Apr 2025 20:01:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>
Subject: [PATCH net-next] udp: properly deal with xfrm encap and ADDRFORM
Date: Wed,  9 Apr 2025 22:00:56 +0200
Message-ID: <92bcdb6899145a9a387c8fa9e3ca656642a43634.1744228733.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

UDP GRO accounting assumes that the GRO receive callback is always
set when the UDP tunnel is enabled, but syzkaller proved otherwise,
leading tot the following splat:

WARNING: CPU: 0 PID: 5837 at net/ipv4/udp_offload.c:123 udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
Modules linked in:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor850 Not tainted 6.14.0-syzkaller-13320-g420aabef3ab5 #0 PREEMPT(full)
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
Code: 00 00 e8 c6 5a 2f f7 48 c1 e5 04 48 8d b5 20 53 c7 9a ba 10
      00 00 00 4c 89 ff e8 ce 87 99 f7 e9 ce 00 00 00 e8 a4 5a 2f
      f7 90 <0f> 0b 90 e9 de fd ff ff bf 01 00 00 00 89 ee e8 cf
      5e 2f f7 85 ed
RSP: 0018:ffffc90003effa88 EFLAGS: 00010293
RAX: ffffffff8a93fc9c RBX: 0000000000000000 RCX: ffff8880306f9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8a93fabe R09: 1ffffffff20bfb2e
R10: dffffc0000000000 R11: fffffbfff20bfb2f R12: ffff88814ef21738
R13: dffffc0000000000 R14: ffff88814ef21778 R15: 1ffff11029de42ef
FS:  0000000000000000(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04eec760d0 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_cleanup_gro include/net/udp_tunnel.h:205 [inline]
 udpv6_destroy_sock+0x212/0x270 net/ipv6/udp.c:1829
 sk_common_release+0x71/0x2e0 net/core/sock.c:3896
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1391
 __fput+0x3e9/0x9f0 fs/file_table.c:465
 task_work_run+0x251/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa11/0x27f0 kernel/exit.c:953
 do_group_exit+0x207/0x2c0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04eebfac79
Code: Unable to access opcode bytes at 0x7f04eebfac4f.
RSP: 002b:00007fffdcaa34a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04eebfac79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f04eec75270 R08: ffffffffffffffb8 R09: 00007fffdcaa36c8
R10: 0000200000000000 R11: 0000000000000246 R12: 00007f04eec75270
R13: 0000000000000000 R14: 00007f04eec75cc0 R15: 00007f04eebcca70

Address the issue moving the accounting hook into
setup_udp_tunnel_sock() and set_xfrm_gro_udp_encap_rcv(), where
the GRO callback is actually set.

set_xfrm_gro_udp_encap_rcv() is prone to races with IPV6_ADDRFORM,
run the relevant setsockopt under the socket lock to ensure using
consistent values of sk_family and up->encap_type.

Refactor the GRO callback selection code, to make it clear that
the function pointer is always initialized.

Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
Fixes: 172bf009c18d ("xfrm: Support GRO for IPv4 ESP in UDP encapsulation")
Fixes: 5d7f5b2f6b935 ("udp_tunnel: use static call for GRO hooks when possible")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Technically this addresses 2 separate issues: the ADDRFORM race
already exists on net, but is very unlikely to cause any problem
in practice.

Since the gro accounting fix depends on it, fix both with a
single net-next patch, to avoid cross-trees dependencies and redice
the syzbot noise.
---
 include/net/udp_tunnel.h   |  1 -
 net/ipv4/udp.c             | 31 ++++++++++++++++++++++++++-----
 net/ipv4/udp_tunnel_core.c |  2 ++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 288f06f23a804..2df3b8344eb52 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -215,7 +215,6 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 	if (READ_ONCE(sk->sk_family) == PF_INET6)
 		ipv6_stub->udpv6_encap_enable();
 #endif
-	udp_tunnel_update_gro_rcv(sk, true);
 	udp_encap_enable();
 }
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8867fe687888c..f9f5b92cf4b61 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2904,15 +2904,33 @@ void udp_destroy_sock(struct sock *sk)
 	}
 }
 
+typedef struct sk_buff *(*udp_gro_receive_t)(struct sock *sk,
+					     struct list_head *head,
+					     struct sk_buff *skb);
+
 static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 				       struct sock *sk)
 {
 #ifdef CONFIG_XFRM
+	udp_gro_receive_t new_gro_receive;
+
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
-		if (family == AF_INET)
-			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
-		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
-			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
+		if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
+			new_gro_receive = ipv6_stub->xfrm6_gro_udp_encap_rcv;
+		else
+			new_gro_receive = xfrm4_gro_udp_encap_rcv;
+
+		if (udp_sk(sk)->gro_receive != new_gro_receive) {
+			/*
+			 * With IPV6_ADDRFORM the gro callback could change
+			 * after being set, unregister the old one, if valid.
+			 */
+			if (udp_sk(sk)->gro_receive)
+				udp_tunnel_update_gro_rcv(sk, false);
+
+			WRITE_ONCE(udp_sk(sk)->gro_receive, new_gro_receive);
+			udp_tunnel_update_gro_rcv(sk, true);
+		}
 	}
 #endif
 }
@@ -2962,6 +2980,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_ENCAP:
+		sockopt_lock_sock(sk);
 		switch (val) {
 		case 0:
 #ifdef CONFIG_XFRM
@@ -2985,6 +3004,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			err = -ENOPROTOOPT;
 			break;
 		}
+		sockopt_release_sock(sk);
 		break;
 
 	case UDP_NO_CHECK6_TX:
@@ -3002,13 +3022,14 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_GRO:
-
+		sockopt_lock_sock(sk);
 		/* when enabling GRO, accept the related GSO packet type */
 		if (valbool)
 			udp_tunnel_encap_enable(sk);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
 		udp_assign_bit(ACCEPT_L4, sk, valbool);
 		set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family, sk);
+		sockopt_release_sock(sk);
 		break;
 
 	/*
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 3d1214e6df0ea..2326548997d3f 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -90,6 +90,8 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 
 	udp_tunnel_encap_enable(sk);
 
+	udp_tunnel_update_gro_rcv(sk, true);
+
 	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sk) &&
 	    sk->sk_kern_sock)
 		udp_tunnel_update_gro_lookup(net, sk, true);
-- 
2.49.0


