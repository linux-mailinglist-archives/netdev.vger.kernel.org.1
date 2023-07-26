Return-Path: <netdev+bounces-21585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65591763F3F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE4281D5F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9EF7E1;
	Wed, 26 Jul 2023 19:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272F17EE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:09:02 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C025211C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690398541; x=1721934541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1r9wvoMQtXrjBbThSHmxAMwUwa3uJ8gOmIK0QO/EBrA=;
  b=Ioximgw8UviGyyTsqY/K4r6F1nyeLbtZgjI4ACGjskgFA0d3/YIfCLKB
   2silkftsEPzgtA56M7yUCXKfQkdeccuSIq1SFA3cpDFuaQhQDZXYelxNI
   E+7MquImPZlbRZtcA0Z80WqTmm+6icLobQ5kgednaucUCp8NzskcLLRFR
   c=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="353814571"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:08:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 8388365484;
	Wed, 26 Jul 2023 19:08:51 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:08:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 26 Jul 2023 19:08:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <simon.horman@corigine.com>, Kees Cook
	<keescook@chromium.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: [PATCH v1 net] af_unix: Terminate sun_path when bind()ing pathname socket.
Date: Wed, 26 Jul 2023 12:08:28 -0700
Message-ID: <20230726190828.47874-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kernel test robot reported slab-out-of-bounds access in strlen(). [0]

Commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
removed unix_mkname_bsd() call in unix_bind_bsd().

If sunaddr->sun_path is not terminated by user and we don't enable
CONFIG_INIT_STACK_ALL_ZERO=y, strlen() will do the out-of-bounds access
during file creation.

Let's go back to strlen()-with-sockaddr_storage way and pack all 108
trickiness into unix_mkname_bsd() with bold comments.

[0]:
BUG: KASAN: slab-out-of-bounds in strlen (lib/string.c:?)
Read of size 1 at addr ffff000015492777 by task fortify_strlen_/168

CPU: 0 PID: 168 Comm: fortify_strlen_ Not tainted 6.5.0-rc1-00333-g3329b603ebba #16
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace (arch/arm64/kernel/stacktrace.c:235)
 show_stack (arch/arm64/kernel/stacktrace.c:242)
 dump_stack_lvl (lib/dump_stack.c:107)
 print_report (mm/kasan/report.c:365 mm/kasan/report.c:475)
 kasan_report (mm/kasan/report.c:590)
 __asan_report_load1_noabort (mm/kasan/report_generic.c:378)
 strlen (lib/string.c:?)
 getname_kernel (./include/linux/fortify-string.h:? fs/namei.c:226)
 kern_path_create (fs/namei.c:3926)
 unix_bind (net/unix/af_unix.c:1221 net/unix/af_unix.c:1324)
 __sys_bind (net/socket.c:1792)
 __arm64_sys_bind (net/socket.c:1801)
 invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:52)
 el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:147)
 do_el0_svc (arch/arm64/kernel/syscall.c:189)
 el0_svc (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:648)
 el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:?)
 el0t_64_sync (arch/arm64/kernel/entry.S:591)

Allocated by task 168:
 kasan_set_track (mm/kasan/common.c:45 mm/kasan/common.c:52)
 kasan_save_alloc_info (mm/kasan/generic.c:512)
 __kasan_kmalloc (mm/kasan/common.c:383)
 __kmalloc (mm/slab_common.c:? mm/slab_common.c:998)
 unix_bind (net/unix/af_unix.c:257 net/unix/af_unix.c:1213 net/unix/af_unix.c:1324)
 __sys_bind (net/socket.c:1792)
 __arm64_sys_bind (net/socket.c:1801)
 invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:52)
 el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:147)
 do_el0_svc (arch/arm64/kernel/syscall.c:189)
 el0_svc (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:648)
 el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:?)
 el0t_64_sync (arch/arm64/kernel/entry.S:591)

The buggy address belongs to the object at ffff000015492700
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes to the right of
 allocated 119-byte region [ffff000015492700, ffff000015492777)

The buggy address belongs to the physical page:
page:00000000aeab52ba refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55492
anon flags: 0x3fffc0000000200(slab|node=0|zone=0|lastcpupid=0xffff)
page_type: 0xffffffff()
raw: 03fffc0000000200 ffff0000084018c0 fffffc00003d0e00 0000000000000005
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000015492600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff000015492680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff000015492700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07 fc
                                                             ^
 ffff000015492780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff000015492800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/netdev/202307262110.659e5e8-oliver.sang@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bbacf4c60fe3..78585217f61a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -289,17 +289,29 @@ static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len)
 	return 0;
 }
 
-static void unix_mkname_bsd(struct sockaddr_un *sunaddr, int addr_len)
+static int unix_mkname_bsd(struct sockaddr_un *sunaddr, int addr_len)
 {
+	struct sockaddr_storage *addr = (struct sockaddr_storage *)sunaddr;
+	short offset = offsetof(struct sockaddr_storage, __data);
+
+	BUILD_BUG_ON(offset != offsetof(struct sockaddr_un, sun_path));
+
 	/* This may look like an off by one error but it is a bit more
 	 * subtle.  108 is the longest valid AF_UNIX path for a binding.
 	 * sun_path[108] doesn't as such exist.  However in kernel space
 	 * we are guaranteed that it is a valid memory location in our
 	 * kernel address buffer because syscall functions always pass
 	 * a pointer of struct sockaddr_storage which has a bigger buffer
-	 * than 108.
+	 * than 108.  Also, we must terminate sun_path for strlen() in
+	 * getname_kernel().
+	 */
+	addr->__data[addr_len - offset] = 0;
+
+	/* Don't pass sunaddr->sun_path to strlen().  Otherwise, 108 will
+	 * cause panic if CONFIG_FORTIFY_SOURCE=y.  Let __fortify_strlen()
+	 * know the actual buffer.
 	 */
-	((char *)sunaddr)[addr_len] = 0;
+	return strlen(addr->__data) + offset + 1;
 }
 
 static void __unix_remove_socket(struct sock *sk)
@@ -1208,8 +1220,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	struct path parent;
 	int err;
 
-	addr_len = strnlen(sunaddr->sun_path, sizeof(sunaddr->sun_path))
-		+ offsetof(struct sockaddr_un, sun_path) + 1;
+	addr_len = unix_mkname_bsd(sunaddr, addr_len);
 	addr = unix_create_addr(sunaddr, addr_len);
 	if (!addr)
 		return -ENOMEM;
-- 
2.30.2


