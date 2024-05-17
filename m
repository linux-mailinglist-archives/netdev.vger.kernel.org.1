Return-Path: <netdev+bounces-96917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9E8C8326
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361021F21E50
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3941EB36;
	Fri, 17 May 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oU8+DhfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685928DA4
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937418; cv=none; b=NIK/wBDGNST3A6kjJ5R+sEbuZ6PmSn8v6z7kuQadnW2TtjaYndFcb4797y2A6shgmpZpgKxm7LpRJedDMEPDTj+KzFFKyho/00LZSPowxAmq/RMKYVQ+LvaS4iEOIRS52CejJ362Zh6SkoCBZNcnNa0HtwcABG4pkQYq21n6uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937418; c=relaxed/simple;
	bh=fIui5kWmqcqSaKApNexaTw3IlQfFJxB9c2qRjtNii+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fc2F0CydGqy+WF535gScrgOhP7eA55Y0zW3oDEqi56X1wQxQbiBSfSByu9tMddoAuKASgeGx1UwbkLJnbEbP8OX5uOu7WYwb3lVnWzaIqllSuKhgLEuwcK2ivpwUbM0Pcf6MbEi2boAa2LwjDZ+3NLAVx4gGVG0/62fdZiSSjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oU8+DhfQ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715937417; x=1747473417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FSpzQSmUoqKX/iinOhD9rfmRb1dkYIVsDScrwlmZo90=;
  b=oU8+DhfQAK2q47i1GX73jszRKGGuOHsY2oMp9Ign0SKNKkBIPuzbNH7g
   a6bcDNd2xrLNrH94MHmLQEh8AS8ioPBrLiDyqmfMMHaeLOAYwAhDnXv3c
   2IFqEbfwNmW+vCtfnNsYg+PZ73nNvjz3V16azBO+9V6Y1zy5ddD5H6cni
   s=;
X-IronPort-AV: E=Sophos;i="6.08,167,1712620800"; 
   d="scan'208";a="407388866"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 09:16:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:40975]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.170:2525] with esmtp (Farcaster)
 id 31d6a37f-c949-4cb7-b57c-d23c027b44e3; Fri, 17 May 2024 09:16:52 +0000 (UTC)
X-Farcaster-Flow-ID: 31d6a37f-c949-4cb7-b57c-d23c027b44e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:16:52 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.241) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:16:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>, Florian Westphal <fw@strlen.de>,
	Glenn Judd <glenn.judd@morganstanley.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Yue Sun
	<samsun1006219@gmail.com>, xingwei lee <xrivendell7@gmail.com>
Subject: [PATCH v1 net] tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
Date: Fri, 17 May 2024 18:16:26 +0900
Message-ID: <20240517091626.32772-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In dctcp_update_alpha(), we use a module parameter dctcp_shift_g
as follows:

  alpha -= min_not_zero(alpha, alpha >> dctcp_shift_g);
  ...
  delivered_ce <<= (10 - dctcp_shift_g);

It seems syzkaller started fuzzing module parameters and triggered
shift-out-of-bounds [0] by setting 100 to dctcp_shift_g:

  memcpy((void*)0x20000080,
         "/sys/module/tcp_dctcp/parameters/dctcp_shift_g\000", 47);
  res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20000080ul,
                /*flags=*/2ul, /*mode=*/0ul);
  memcpy((void*)0x20000000, "100\000", 4);
  syscall(__NR_write, /*fd=*/r[0], /*val=*/0x20000000ul, /*len=*/4ul);

Let's limit the max value of dctcp_shift_g by param_set_uint_minmax().

With this patch:

  # echo 10 > /sys/module/tcp_dctcp/parameters/dctcp_shift_g
  # cat /sys/module/tcp_dctcp/parameters/dctcp_shift_g
  10
  # echo 11 > /sys/module/tcp_dctcp/parameters/dctcp_shift_g
  -bash: echo: write error: Invalid argument

[0]:
UBSAN: shift-out-of-bounds in net/ipv4/tcp_dctcp.c:143:12
shift exponent 100 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 PID: 8083 Comm: syz-executor345 Not tainted 6.9.0-05151-g1b294a1f3561 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x201/0x300 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x346/0x3a0 lib/ubsan.c:468
 dctcp_update_alpha+0x540/0x570 net/ipv4/tcp_dctcp.c:143
 tcp_in_ack_event net/ipv4/tcp_input.c:3802 [inline]
 tcp_ack+0x17b1/0x3bc0 net/ipv4/tcp_input.c:3948
 tcp_rcv_state_process+0x57a/0x2290 net/ipv4/tcp_input.c:6711
 tcp_v4_do_rcv+0x764/0xc40 net/ipv4/tcp_ipv4.c:1937
 sk_backlog_rcv include/net/sock.h:1106 [inline]
 __release_sock+0x20f/0x350 net/core/sock.c:2983
 release_sock+0x61/0x1f0 net/core/sock.c:3549
 mptcp_subflow_shutdown+0x3d0/0x620 net/mptcp/protocol.c:2907
 mptcp_check_send_data_fin+0x225/0x410 net/mptcp/protocol.c:2976
 __mptcp_close+0x238/0xad0 net/mptcp/protocol.c:3072
 mptcp_close+0x2a/0x1a0 net/mptcp/protocol.c:3127
 inet_release+0x190/0x1f0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:659 [inline]
 sock_close+0xc0/0x240 net/socket.c:1421
 __fput+0x41b/0x890 fs/file_table.c:422
 task_work_run+0x23b/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x9c8/0x2540 kernel/exit.c:878
 do_group_exit+0x201/0x2b0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f6c2b5005b6
Code: Unable to access opcode bytes at 0x7f6c2b50058c.
RSP: 002b:00007ffe883eb948 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6c2b5862f0 RCX: 00007f6c2b5005b6
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffffc0
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f6c2b5862f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/netdev/CAEkJfYNJM=cw-8x7_Vmj1J6uYVCWMbbvD=EFmDPVBGpTsqOxEA@mail.gmail.com/
Fixes: e3118e8359bb ("net: tcp: add DCTCP congestion control algorithm")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_dctcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 6b712a33d49f..8a45a4aea933 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -58,7 +58,18 @@ struct dctcp {
 };
 
 static unsigned int dctcp_shift_g __read_mostly = 4; /* g = 1/2^4 */
-module_param(dctcp_shift_g, uint, 0644);
+
+static int dctcp_shift_g_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0, 10);
+}
+
+static const struct kernel_param_ops dctcp_shift_g_ops = {
+	.set = dctcp_shift_g_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(dctcp_shift_g, &dctcp_shift_g_ops, &dctcp_shift_g, 0644);
 MODULE_PARM_DESC(dctcp_shift_g, "parameter g for updating dctcp_alpha");
 
 static unsigned int dctcp_alpha_on_init __read_mostly = DCTCP_MAX_ALPHA;
-- 
2.30.2


