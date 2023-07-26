Return-Path: <netdev+bounces-21513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5174D763C44
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE81C213B3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED63799F;
	Wed, 26 Jul 2023 16:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E737991
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:20:18 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF3268C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690388404; x=1721924404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vedA0tBPnLKFhmZ2bBCP4QsuT1oa0T4cLKtKhheWcEE=;
  b=YsmikmSKNI2laYTBAQR5Fi4/vNgVsrj7E8uPQzlyRcpeHGqMukVfj2Rm
   IeK5XaGFcTUUyRL0tgHUErPHgoi4jn1r6mZjNgfCa6n1BwXaQA/pc/8CI
   T1N8GDtNAKXU8yCThw7u8V+z6XS7eIBELsdt2YA/T8xm/lepK4X+cHMS8
   4=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="598517829"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:20:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id A7663856B1;
	Wed, 26 Jul 2023 16:19:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 16:19:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 26 Jul 2023 16:19:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <oliver.sang@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<keescook@chromium.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <leitao@debian.org>, <lkp@intel.com>,
	<netdev@vger.kernel.org>, <oe-lkp@lists.linux.dev>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
Date: Wed, 26 Jul 2023 09:19:33 -0700
Message-ID: <20230726161933.26778-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202307262110.659e5e8-oliver.sang@intel.com>
References: <202307262110.659e5e8-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: kernel test robot <oliver.sang@intel.com>
Date: Wed, 26 Jul 2023 21:52:45 +0800
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_strlen" on:
> 
> commit: 33652e138afbe3f7c814567c4ffdf57492664220 ("[PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().")
> url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Fix-fortify_panic-in-unix_bind_bsd/20230725-053836
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 22117b3ae6e37d07225653d9ae5ae86b3a54f99c
> patch link: https://lore.kernel.org/all/20230724213425.22920-2-kuniyu@amazon.com/
> patch subject: [PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> [   33.452659][   T68] ==================================================================
> [   33.453726][   T68] BUG: KASAN: slab-out-of-bounds in strlen+0x35/0x4f
> [   33.454515][   T68] Read of size 1 at addr ffff88812ff65577 by task udevd/68
> [   33.455352][   T68]
> [   33.455644][   T68] CPU: 0 PID: 68 Comm: udevd Not tainted 6.5.0-rc2-00197-g33652e138afb #1
> [   33.456627][   T68] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   33.457802][   T68] Call Trace:
> [   33.458184][   T68]  <TASK>
> [   33.458521][   T68]  print_address_description+0x4d/0x2dd
> [   33.459259][   T68]  print_report+0x139/0x241
> [   33.459783][   T68]  ? __phys_addr+0x91/0xa3
> [   33.460290][   T68]  ? virt_to_folio+0x5/0x27
> [   33.460800][   T68]  ? strlen+0x35/0x4f
> [   33.461241][   T68]  kasan_report+0xaf/0xda
> [   33.461756][   T68]  ? strlen+0x35/0x4f
> [   33.462218][   T68]  strlen+0x35/0x4f
> [   33.462657][   T68]  getname_kernel+0xe/0x234

Ok, we still need to terminate the string with unix_mkname_bsd().. so
I perfer using strlen() here as well to warn about this situation.

I'll post a patch soon.

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bbacf4c60fe3..6056c3bad54e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1208,7 +1208,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	struct path parent;
 	int err;
 
-	addr_len = strnlen(sunaddr->sun_path, sizeof(sunaddr->sun_path))
+	unix_mkname_bsd(sunaddr->sun_path, addr_len);
+	addr_len = strlen(((struct sockaddr_storage *)sunaddr)->__data)
 		+ offsetof(struct sockaddr_un, sun_path) + 1;
 	addr = unix_create_addr(sunaddr, addr_len);
 	if (!addr)
---8<---


> [   33.463190][   T68]  kern_path_create+0x18/0x4d
> [   33.463727][   T68]  unix_bind_bsd+0x180/0x5a4
> [   33.464367][   T68]  ? unix_create_addr+0xdd/0xdd
> [   33.464929][   T68]  __sys_bind+0xf2/0x15f
> [   33.465437][   T68]  ? __ia32_sys_socketpair+0xb3/0xb3
> [   33.466046][   T68]  __x64_sys_bind+0x79/0x87
> [   33.466575][   T68]  do_syscall_64+0x6b/0x87
> [   33.467094][   T68]  ? lockdep_hardirqs_on_prepare+0x326/0x350
> [   33.467780][   T68]  ? do_syscall_64+0x78/0x87
> [   33.468305][   T68]  ? lockdep_hardirqs_on_prepare+0x326/0x350
> [   33.468989][   T68]  ? do_syscall_64+0x78/0x87
> [   33.469538][   T68]  ? do_syscall_64+0x78/0x87
> [   33.470051][   T68]  ? do_syscall_64+0x78/0x87
> [   33.470576][   T68]  ? lockdep_hardirqs_on_prepare+0x326/0x350
> [   33.471268][   T68]  entry_SYSCALL_64_after_hwframe+0x5d/0xc7
> [   33.471917][   T68] RIP: 0033:0x7fd5b1091b77
> [   33.472426][   T68] Code: ff ff ff ff c3 48 8b 15 17 b3 0b 00 f7 d8 64 89 02 b8 ff ff ff ff eb ba 66 2e 0f 1f 84 00 00 00 00 00 90 b8 31 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 b2 0b 00 f7 d8 64 89 01 48
> [   33.474908][   T68] RSP: 002b:00007ffddf8bb5c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> [   33.475878][   T68] RAX: ffffffffffffffda RBX: 000055dcbcd8e8c0 RCX: 00007fd5b1091b77
> [   33.476785][   T68] RDX: 0000000000000013 RSI: 000055dcbcd8e8d8 RDI: 0000000000000003
> [   33.477697][   T68] RBP: 000055dcbcd8e8d8 R08: 0000000000000004 R09: 000055dcbcd8ed50
> [   33.478561][   T68] R10: 00007ffddf8bb5d4 R11: 0000000000000246 R12: 00007ffddf8bbe18
> [   33.479431][   T68] R13: 00007ffddf8bbe10 R14: 0000000000000000 R15: 000055dcbcd8e260
> [   33.480352][   T68]  </TASK>
> [   33.480723][   T68]
> [   33.481014][   T68] Allocated by task 68:
> [   33.481537][   T68]  stack_trace_save+0x77/0x98
> [   33.482086][   T68]  kasan_save_stack+0x2e/0x53
> [   33.482644][   T68]  kasan_set_track+0x20/0x2c
> [   33.483188][   T68]  ____kasan_kmalloc+0x68/0x7b
> [   33.483761][   T68]  __kmalloc+0xac/0xe5
> [   33.484260][   T68]  unix_create_addr+0x1f/0xdd
> [   33.484821][   T68]  unix_bind_bsd+0x161/0x5a4
> [   33.485512][   T68]  __sys_bind+0xf2/0x15f
> [   33.486024][   T68]  __x64_sys_bind+0x79/0x87
> [   33.486559][   T68]  do_syscall_64+0x6b/0x87
> [   33.487066][   T68]  entry_SYSCALL_64_after_hwframe+0x5d/0xc7
> [   33.487761][   T68]
> [   33.488048][   T68] The buggy address belongs to the object at ffff88812ff65500
> [   33.488048][   T68]  which belongs to the cache kmalloc-128 of size 128
> [   33.489631][   T68] The buggy address is located 0 bytes to the right of
> [   33.489631][   T68]  allocated 119-byte region [ffff88812ff65500, ffff88812ff65577)
> [   33.491272][   T68]
> [   33.491571][   T68] The buggy address belongs to the physical page:
> [   33.492321][   T68] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12ff65
> [   33.493503][   T68] flags: 0x8000000000000200(slab|zone=2)
> [   33.494120][   T68] page_type: 0xffffffff()
> [   33.494610][   T68] raw: 8000000000000200 ffff8881000418c0 dead000000000122 0000000000000000
> [   33.495560][   T68] raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> [   33.496528][   T68] page dumped because: kasan: bad access detected
> [   33.497265][   T68] page_owner tracks the page as allocated
> [   33.497959][   T68] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper), ts 31189252946, free_ts 0
> [   33.499819][   T68]  __set_page_owner+0x15/0x59
> [   33.500391][   T68]  prep_new_page+0x17/0x70
> [   33.500931][   T68]  get_page_from_freelist+0x1ca/0x3d2
> [   33.501972][   T68]  __alloc_pages+0x159/0x25f
> [   33.502494][   T68]  alloc_slab_page+0x1a/0x4c
> [   33.503011][   T68]  allocate_slab+0x59/0x1b6
> [   33.503517][   T68]  ___slab_alloc+0x348/0x510
> [   33.504034][   T68]  __slab_alloc+0x11/0x27
> [   33.504641][   T68]  __kmem_cache_alloc_node+0x63/0x10d
> [   33.505246][   T68]  __kmalloc+0x9b/0xe5
> [   33.505736][   T68]  pci_create_attr+0x33/0x3c4
> [   33.506282][   T68]  pci_create_resource_files+0x9c/0x126
> [   33.506907][   T68]  pci_sysfs_init+0x66/0xf1
> [   33.507434][   T68]  do_one_initcall+0xc3/0x274
> [   33.507955][   T68]  do_initcalls+0x308/0x366
> [   33.508479][   T68]  kernel_init_freeable+0x2b1/0x315
> [   33.509081][   T68] page_owner free stack trace missing
> [   33.509687][   T68]
> [   33.509974][   T68] Memory state around the buggy address:
> [   33.510640][   T68]  ffff88812ff65400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   33.511564][   T68]  ffff88812ff65480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   33.512499][   T68] >ffff88812ff65500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07 fc
> [   33.513453][   T68]                                                              ^
> [   33.514393][   T68]  ffff88812ff65580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   33.515328][   T68]  ffff88812ff65600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   33.516257][   T68] ==================================================================
> [   33.517245][   T68] Disabling lock debugging due to kernel taint
> [   33.518764][   T68] udevd[68]: starting version 3.2.7
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-6.5.0-rc2-00197-g33652e138afb .config
> 	make HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

