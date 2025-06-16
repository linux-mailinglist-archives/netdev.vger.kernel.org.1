Return-Path: <netdev+bounces-198177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFCADB7BE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE611188DA85
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EF28751D;
	Mon, 16 Jun 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koBOAfB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2F72607;
	Mon, 16 Jun 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094779; cv=none; b=blMa2mwD8nIf/vCpeBMy7EYdW2TxPyLXWuEMijZJtQi2SiDQMiWjmqr4cn0HXieYKazf1KxQ2yHegr9kS8H4RewNl3xlrB5xI7axJM2i6n+57cp9gJUVl+BsMDnixfgPM8lmbbJ+zflTaSXfg4JrXlLIwQhNw1AOdJNe9DL5WAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094779; c=relaxed/simple;
	bh=qcjYbV5/soyaoRHOIZqwLJEW9marfpVFY3IiTWa/K+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lty+huMlZfolfLJJYfe23YgWmhC0gdAS0Vp2rcixXTsZtj9GX+6AkgisxIlZbRLRAzj52e0y8SU425EVBBygRe5E5q2zYsxCA2k8RwqEOCbokC+91ZF8TXkcidlFJcaAQ13WlmrHWeqTSg5Ma5Tx1+KS3m7zO/LyxzyfDmk0SEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koBOAfB8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso5391231a91.0;
        Mon, 16 Jun 2025 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750094777; x=1750699577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6ymH5qU0Npj727Li0g+FCfZy9IP5/b70hORw/Ticsc=;
        b=koBOAfB8+saEp3jbUdsHpKxpebLu7+Kl5mIkym8Eam6Z3i+Z3ysTB82gTAbjtz1755
         Ff8oQ6dlKUjovfxlAxO/FocCjGQUwvkIOk5Uyno7VAKCzlz9UQxX52oSimC+ewSNbxIN
         lQl38buR8CqU59WhebWBqnjKOJsq5Nd03SyZysS0Qm0CPclTvYnC/lwVA1o3BcPY47xu
         LSfXFYulF143O4idDq/kMlPd8Peouan7afU6G6CGiRsCdTs2xYTcTzI3li/lfWdX80KK
         feb8wGhI1jonwVjgXU92BW7WLsTm0W54UzPY45nxlUstti8kvov6cyjtaSRyR6Ve9KzR
         SVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094777; x=1750699577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6ymH5qU0Npj727Li0g+FCfZy9IP5/b70hORw/Ticsc=;
        b=wlvt4TxoDZjFaaS3SgVC1HLmny0R8XRb9YCMQKL3lHnPeoU8zv8K6Sfr+Gs855wS2j
         dDw1rMCwTlR0AyNldfo2pdKMo5UYe9HjYIwFPDT9oTnuqUGa5K48qCbB17Jnado5NCmu
         PZGneJHiRp6YxzUT1W9BraZhb/KSMGX6J4Fy7CykdiTVrlUyDCFvHJc3//aQV8NLrn7F
         mswZ1r9THVI7oQD7KTHvwkxS9GB9TnU/WIU1dkGMtPcfQU3BCjRcxi8Sru2UgQ6++7j+
         dJm9pRW8JN4e9vBw+EYCXpLA6RQ4lE5UhANn/VLJ3/ed5v9WfL3a1P0TiaSR47dCEQa7
         jjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXcc8vCV52FY7i94tZjWjQ8+I7ZOHeSrdenw3jsI9CnQhSQlRJIBtYRsS3fujzUFKUN5xNu9KOQxMBqouwsHhvJfUdPF8=@vger.kernel.org, AJvYcCWJgfx1tCsw+UqEvylIaoncJk97fhpRbZHgNIp7/M+zR1lyX+K1f6NGQ6otBh69YEZNHew4oJgs@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGKp3purfH1Jk8KcGM7297tQvCyQBZHNz0a9iuxc28YaN6xHG
	bAKz75pRgCNYYbN4FFn7T/c/9RuMvQ1b56EFOmvNWJkJ7vo2Kb0BiGU=
X-Gm-Gg: ASbGncvxDOvRd0FBUS4mBsgCZ1z/oJZL/NohOK5clfb9vg6lrmcU0Z6jBrkhCjkMvuL
	a+4sYZubJhAZWBAtI3iYhLlhQSt1Y+0zLmAmvX1vouOkDyO0Rt26Gune8iyiuyBZ+EpSTAfKodk
	nhIsR2SzEReuaj2EiHJyqMCKgdrHTYY9M/Xx6E8MtNWbs0H/ru9A5LzlTu27d9M+EJWp0XdR7H4
	9d46LxRmxHgMCC1wd15Rx/qHbQLd2JEefwMjbeS8pSTvzINyA60mc3uAzinnHojWhZiTDin75wJ
	ElIIPB1PfQi96ogIhuDRCb8WjI1dTu7sAfudUXo=
X-Google-Smtp-Source: AGHT+IHGBo0/kdy2VhBGbLdz6PaiMpuWM0oTL/6ID+4AcpsVw0ilDJtlGhdAwc/tkYhM978QQryvsg==
X-Received: by 2002:a17:90b:37c5:b0:311:ad7f:329f with SMTP id 98e67ed59e1d1-313f1d30751mr16725448a91.31.1750094777285;
        Mon, 16 Jun 2025 10:26:17 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de76e1asm64268635ad.112.2025.06.16.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:26:16 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	John Cheung <john.cs.hey@gmail.com>
Subject: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
Date: Mon, 16 Jun 2025 10:25:55 -0700
Message-ID: <20250616172612.920438-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
a CALIPSO option.  [0]

The NULL is of struct sock, which was fetched by sk_to_full_sk() in
calipso_req_setattr().

Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"),
reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
client, as hinted by the leading SYN Cookie log.

Here are 3 options to fix the bug:

  1) Return 0 in calipso_req_setattr()
  2) Return an error in calipso_req_setattr()
  3) Alaways set rsk_listener

1) is no go as it bypasses LSM, but 2) effectively disables SYN Cookie
for CALIPSO.  3) is also no go as there have been many efforts to reduce
atomic ops and make TCP robust against DDoS.  See also commit 3b24d854cb35
("tcp/dccp: do not touch listener sk_refcnt under synflood").

As of the blamed commit, SYN Cookie already did not need refcounting,
and no one has stumbled on the bug for 9 years, so no CALIPSO user will
care about SYN Cookie.

Let's return an error in calipso_req_setattr() and calipso_req_delattr()
in the SYN Cookie case.

This can be reproduced by [1] on Fedora and now connect() of nc times out.

[0]:
TCP: request_sock_TCPv6: Possible SYN flooding on port [::]:20002. Sending cookies.
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 3 UID: 0 PID: 12262 Comm: syz.1.2611 Not tainted 6.14.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:read_pnet include/net/net_namespace.h:406 [inline]
RIP: 0010:sock_net include/net/sock.h:655 [inline]
RIP: 0010:sock_kmalloc+0x35/0x170 net/core/sock.c:2806
Code: 89 d5 41 54 55 89 f5 53 48 89 fb e8 25 e3 c6 fd e8 f0 91 e3 00 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 26 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
RSP: 0018:ffff88811af89038 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888105266400
RDX: 0000000000000006 RSI: ffff88800c890000 RDI: 0000000000000030
RBP: 0000000000000050 R08: 0000000000000000 R09: ffff88810526640e
R10: ffffed1020a4cc81 R11: ffff88810526640f R12: 0000000000000000
R13: 0000000000000820 R14: ffff888105266400 R15: 0000000000000050
FS:  00007f0653a07640(0000) GS:ffff88811af80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f863ba096f4 CR3: 00000000163c0005 CR4: 0000000000770ef0
PKRU: 80000000
Call Trace:
 <IRQ>
 ipv6_renew_options+0x279/0x950 net/ipv6/exthdrs.c:1288
 calipso_req_setattr+0x181/0x340 net/ipv6/calipso.c:1204
 calipso_req_setattr+0x56/0x80 net/netlabel/netlabel_calipso.c:597
 netlbl_req_setattr+0x18a/0x440 net/netlabel/netlabel_kapi.c:1249
 selinux_netlbl_inet_conn_request+0x1fb/0x320 security/selinux/netlabel.c:342
 selinux_inet_conn_request+0x1eb/0x2c0 security/selinux/hooks.c:5551
 security_inet_conn_request+0x50/0xa0 security/security.c:4945
 tcp_v6_route_req+0x22c/0x550 net/ipv6/tcp_ipv6.c:825
 tcp_conn_request+0xec8/0x2b70 net/ipv4/tcp_input.c:7275
 tcp_v6_conn_request+0x1e3/0x440 net/ipv6/tcp_ipv6.c:1328
 tcp_rcv_state_process+0xafa/0x52b0 net/ipv4/tcp_input.c:6781
 tcp_v6_do_rcv+0x8a6/0x1a40 net/ipv6/tcp_ipv6.c:1667
 tcp_v6_rcv+0x505e/0x5b50 net/ipv6/tcp_ipv6.c:1904
 ip6_protocol_deliver_rcu+0x17c/0x1da0 net/ipv6/ip6_input.c:436
 ip6_input_finish+0x103/0x180 net/ipv6/ip6_input.c:480
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip6_input+0x13c/0x6b0 net/ipv6/ip6_input.c:491
 dst_input include/net/dst.h:469 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 ip6_rcv_finish+0xb6/0x490 net/ipv6/ip6_input.c:69
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ipv6_rcv+0xf9/0x490 net/ipv6/ip6_input.c:309
 __netif_receive_skb_one_core+0x12e/0x1f0 net/core/dev.c:5896
 __netif_receive_skb+0x1d/0x170 net/core/dev.c:6009
 process_backlog+0x41e/0x13b0 net/core/dev.c:6357
 __napi_poll+0xbd/0x710 net/core/dev.c:7191
 napi_poll net/core/dev.c:7260 [inline]
 net_rx_action+0x9de/0xde0 net/core/dev.c:7382
 handle_softirqs+0x19a/0x770 kernel/softirq.c:561
 do_softirq.part.0+0x36/0x70 kernel/softirq.c:462
 </IRQ>
 <TASK>
 do_softirq arch/x86/include/asm/preempt.h:26 [inline]
 __local_bh_enable_ip+0xf1/0x110 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0xc2a/0x3c40 net/core/dev.c:4679
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0xd69/0x1f80 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
 ip6_finish_output+0x5dc/0xd60 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x24b/0x8d0 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:459 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip6_xmit+0xbbc/0x20d0 net/ipv6/ip6_output.c:366
 inet6_csk_xmit+0x39a/0x720 net/ipv6/inet6_connection_sock.c:135
 __tcp_transmit_skb+0x1a7b/0x3b40 net/ipv4/tcp_output.c:1471
 tcp_transmit_skb net/ipv4/tcp_output.c:1489 [inline]
 tcp_send_syn_data net/ipv4/tcp_output.c:4059 [inline]
 tcp_connect+0x1c0c/0x4510 net/ipv4/tcp_output.c:4148
 tcp_v6_connect+0x156c/0x2080 net/ipv6/tcp_ipv6.c:333
 __inet_stream_connect+0x3a7/0xed0 net/ipv4/af_inet.c:677
 tcp_sendmsg_fastopen+0x3e2/0x710 net/ipv4/tcp.c:1039
 tcp_sendmsg_locked+0x1e82/0x3570 net/ipv4/tcp.c:1091
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1358
 inet6_sendmsg+0xb9/0x150 net/ipv6/af_inet6.c:659
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0xf4/0x2a0 net/socket.c:733
 __sys_sendto+0x29a/0x390 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0xe1/0x1c0 net/socket.c:2190
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06553c47ed
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0653a06fc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0655605fa0 RCX: 00007f06553c47ed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
RBP: 00007f065545db38 R08: 0000200000000140 R09: 000000000000001c
R10: f7384d4ea84b01bd R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0655605fac R14: 00007f0655606038 R15: 00007f06539e7000
 </TASK>
Modules linked in:

[1]:
dnf install -y selinux-policy-targeted policycoreutils netlabel_tools procps-ng nmap-ncat
mount -t selinuxfs none /sys/fs/selinux
load_policy
netlabelctl calipso add pass doi:1
netlabelctl map del default
netlabelctl map add default address:::1 protocol:calipso,1
sysctl net.ipv4.tcp_syncookies=2
nc -l ::1 80 &
nc ::1 80

Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by the lsm.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: John Cheung <john.cs.hey@gmail.com>
Closes: https://lore.kernel.org/netdev/CAP=Rh=MvfhrGADy+-WJiftV2_WzMH4VEhEFmeT28qY+4yxNu4w@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/calipso.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 62618a058b8f..e25ed02a54bf 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1207,6 +1207,9 @@ static int calipso_req_setattr(struct request_sock *req,
 	struct ipv6_opt_hdr *old, *new;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	if (!sk)
+		return -ENOMEM;
+
 	if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
 		old = req_inet->ipv6_opt->hopopt;
 	else
@@ -1247,6 +1250,9 @@ static void calipso_req_delattr(struct request_sock *req)
 	struct ipv6_txoptions *txopts;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	if (!sk)
+		return;
+
 	if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
 		return;
 
-- 
2.49.0


