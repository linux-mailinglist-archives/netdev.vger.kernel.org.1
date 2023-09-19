Return-Path: <netdev+bounces-34930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F17A5FEF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EC61C20C39
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49C1864E;
	Tue, 19 Sep 2023 10:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68148498
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:45:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3110C8
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:44:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RqdVp4RWBzJsTL;
	Tue, 19 Sep 2023 18:41:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 18:44:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()
Date: Tue, 19 Sep 2023 18:44:06 +0800
Message-ID: <20230919104406.847875-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When making CONFIG_DEBUG_KMEMLEAK=y and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y,
modprobe handshake-test and then rmmmod handshake-test, the below memory
leak is detected.

The struct socket_alloc which is allocated by alloc_inode_sb() in
__sock_create() is not freed. And the struct dentry which is allocated
by __d_alloc() in sock_alloc_file() is not freed.

Since fput() will call file->f_op->release() which is sock_close() here and
it will call __sock_release(). and fput() will call dput(dentry) to free
the struct dentry. So replace sock_release() with fput() to fix the
below memory leak. After applying this patch, the following memory leak is
never detected.

unreferenced object 0xffff888109165840 (size 768):
  comm "kunit_try_catch", pid 1852, jiffies 4294685807 (age 976.262s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa0209ba2>] 0xffffffffa0209ba2
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810f472008 (size 192):
  comm "kunit_try_catch", pid 1852, jiffies 4294685808 (age 976.261s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 08 20 47 0f 81 88 ff ff  ......... G.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0209bbb>] 0xffffffffa0209bbb
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810958e580 (size 224):
  comm "kunit_try_catch", pid 1852, jiffies 4294685808 (age 976.261s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0209bbb>] 0xffffffffa0209bbb
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810926dc88 (size 192):
  comm "kunit_try_catch", pid 1854, jiffies 4294685809 (age 976.271s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 88 dc 26 09 81 88 ff ff  ..........&.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208fdc>] 0xffffffffa0208fdc
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810a241380 (size 224):
  comm "kunit_try_catch", pid 1854, jiffies 4294685809 (age 976.271s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208fdc>] 0xffffffffa0208fdc
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888109165040 (size 768):
  comm "kunit_try_catch", pid 1856, jiffies 4294685811 (age 976.269s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa0208860>] 0xffffffffa0208860
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810926d568 (size 192):
  comm "kunit_try_catch", pid 1856, jiffies 4294685811 (age 976.269s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 68 d5 26 09 81 88 ff ff  ........h.&.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208879>] 0xffffffffa0208879
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810a240580 (size 224):
  comm "kunit_try_catch", pid 1856, jiffies 4294685811 (age 976.347s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208879>] 0xffffffffa0208879
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888109164c40 (size 768):
  comm "kunit_try_catch", pid 1858, jiffies 4294685816 (age 976.342s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa0208541>] 0xffffffffa0208541
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810926cd18 (size 192):
  comm "kunit_try_catch", pid 1858, jiffies 4294685816 (age 976.342s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 18 cd 26 09 81 88 ff ff  ..........&.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa020855a>] 0xffffffffa020855a
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810a240200 (size 224):
  comm "kunit_try_catch", pid 1858, jiffies 4294685816 (age 976.342s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa020855a>] 0xffffffffa020855a
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888109164840 (size 768):
  comm "kunit_try_catch", pid 1860, jiffies 4294685817 (age 976.416s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa02093e2>] 0xffffffffa02093e2
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810926cab8 (size 192):
  comm "kunit_try_catch", pid 1860, jiffies 4294685817 (age 976.416s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 b8 ca 26 09 81 88 ff ff  ..........&.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa02093fb>] 0xffffffffa02093fb
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810a240040 (size 224):
  comm "kunit_try_catch", pid 1860, jiffies 4294685817 (age 976.416s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa02093fb>] 0xffffffffa02093fb
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888109166440 (size 768):
  comm "kunit_try_catch", pid 1862, jiffies 4294685819 (age 976.489s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa02097c1>] 0xffffffffa02097c1
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810926c398 (size 192):
  comm "kunit_try_catch", pid 1862, jiffies 4294685819 (age 976.489s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 98 c3 26 09 81 88 ff ff  ..........&.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa02097da>] 0xffffffffa02097da
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888107e0b8c0 (size 224):
  comm "kunit_try_catch", pid 1862, jiffies 4294685819 (age 976.489s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa02097da>] 0xffffffffa02097da
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888109164440 (size 768):
  comm "kunit_try_catch", pid 1864, jiffies 4294685821 (age 976.487s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 5a 5a 20 00 00 00 00 00 00 00  ......ZZ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8397993f>] sock_alloc_inode+0x1f/0x1b0
    [<ffffffff81a2cb5b>] alloc_inode+0x5b/0x1a0
    [<ffffffff81a32bed>] new_inode_pseudo+0xd/0x70
    [<ffffffff8397889c>] sock_alloc+0x3c/0x260
    [<ffffffff83979b46>] __sock_create+0x66/0x3d0
    [<ffffffffa020824e>] 0xffffffffa020824e
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810f4cf698 (size 192):
  comm "kunit_try_catch", pid 1864, jiffies 4294685821 (age 976.501s)
  hex dump (first 32 bytes):
    00 00 50 40 02 00 00 00 00 00 00 00 00 00 00 00  ..P@............
    00 00 00 00 00 00 00 00 98 f6 4c 0f 81 88 ff ff  ..........L.....
  backtrace:
    [<ffffffff81a1ff11>] __d_alloc+0x31/0x8a0
    [<ffffffff81a2910e>] d_alloc_pseudo+0xe/0x50
    [<ffffffff819d549e>] alloc_file_pseudo+0xce/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208267>] 0xffffffffa0208267
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888107e0b000 (size 224):
  comm "kunit_try_catch", pid 1864, jiffies 4294685821 (age 976.501s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 03 00 2e 08 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819d4b90>] alloc_empty_file+0x50/0x160
    [<ffffffff819d4cf9>] alloc_file+0x59/0x730
    [<ffffffff819d5524>] alloc_file_pseudo+0x154/0x210
    [<ffffffff83978582>] sock_alloc_file+0x42/0x1b0
    [<ffffffffa0208267>] 0xffffffffa0208267
    [<ffffffff829cf03a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20

Fixes: 88232ec1ec5e ("net/handshake: Add Kunit tests for the handshake consumer API")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/handshake/handshake-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 6d37bab35c8f..16ed7bfd29e4 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -235,7 +235,7 @@ static void handshake_req_submit_test4(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, req, result);
 
 	handshake_req_cancel(sock->sk);
-	sock_release(sock);
+	fput(filp);
 }
 
 static void handshake_req_submit_test5(struct kunit *test)
@@ -272,7 +272,7 @@ static void handshake_req_submit_test5(struct kunit *test)
 	/* Assert */
 	KUNIT_EXPECT_EQ(test, err, -EAGAIN);
 
-	sock_release(sock);
+	fput(filp);
 	hn->hn_pending = saved;
 }
 
@@ -306,7 +306,7 @@ static void handshake_req_submit_test6(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, err, -EBUSY);
 
 	handshake_req_cancel(sock->sk);
-	sock_release(sock);
+	fput(filp);
 }
 
 static void handshake_req_cancel_test1(struct kunit *test)
@@ -340,7 +340,7 @@ static void handshake_req_cancel_test1(struct kunit *test)
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
 
-	sock_release(sock);
+	fput(filp);
 }
 
 static void handshake_req_cancel_test2(struct kunit *test)
@@ -382,7 +382,7 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
 
-	sock_release(sock);
+	fput(filp);
 }
 
 static void handshake_req_cancel_test3(struct kunit *test)
@@ -427,7 +427,7 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Assert */
 	KUNIT_EXPECT_FALSE(test, result);
 
-	sock_release(sock);
+	fput(filp);
 }
 
 static struct handshake_req *handshake_req_destroy_test;
@@ -471,7 +471,7 @@ static void handshake_req_destroy_test1(struct kunit *test)
 	handshake_req_cancel(sock->sk);
 
 	/* Act */
-	sock_release(sock);
+	fput(filp);
 
 	/* Assert */
 	KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);
-- 
2.34.1


