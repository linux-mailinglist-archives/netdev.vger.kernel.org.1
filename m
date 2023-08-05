Return-Path: <netdev+bounces-24649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB195770F1D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C8282522
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3C8BE8;
	Sat,  5 Aug 2023 09:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5323A2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 09:40:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44A10CA
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 02:40:29 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHyCb2QXpzGpt1;
	Sat,  5 Aug 2023 17:36:59 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 17:40:26 +0800
Received: from kwepemm600020.china.huawei.com ([7.193.23.147]) by
 kwepemm600020.china.huawei.com ([7.193.23.147]) with mapi id 15.01.2507.027;
 Sat, 5 Aug 2023 17:40:26 +0800
From: "liubo (D)" <liubo335@huawei.com>
To: "borisp@nvidia.com" <borisp@nvidia.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: liaichun <liaichun@huawei.com>, "Yanan (Euler)" <yanan@huawei.com>
Subject: [BUG REPORT] UAF in tls tls_encrypt_done
Thread-Topic: [BUG REPORT] UAF in tls tls_encrypt_done
Thread-Index: AdnHgMNaOB9BPi3zSWeDlnxBCAh4PA==
Date: Sat, 5 Aug 2023 09:40:25 +0000
Message-ID: <e9fc2db49f6e43d7aca84610f7c0ceef@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.136.117.132]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During the fuzzing test On linux5.10 Kasan, UAF(tls_sw_context_tx) occurs i=
n the tls_encrypt_done function.:

Where tls_sw_context_tx destroyed:
=A0=A0=A0=A0=A0=A0 sock_close
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 tls_sk_proto_close
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __sock_release
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 .
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 tls_sk_proto_close
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ctx->tx_conf =3D=3D TL=
S_SW)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tls_s=
w_free_ctx_tx(ctx);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 kfree(ctx)

where UAF happens:
=A0=A0=A0=A0=A0=A0 Kthread
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 padata_serial_=
worker
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 tls_encrypt_done
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 spin_unlock_bh(&ctx->encrypt=
_compl_lock);
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ready)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ******(now ctx(tls_sw_context_tx) has been released)*****
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 if (!test_and_set_bit(BIT_TX=
_SCHEDULED, &ctx->tx_bitmask))=A0=A0=A0=20

If ctx->tx_conf =3D=3D TLS_SW will release ctx directly. Is it because tls_=
encrypt_done cannot be executed asynchronously if tls is in TLS_SW mode? =
=A0Or is this bug caused by other reasons?

The detailed calltrace information is as follows:
BUG: KASAN: use-after-free in instrument_atomic_read_write usr/src/kernels/=
linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/./include/linux/instrumented.h:=
101 [inline]
BUG: KASAN: use-after-free in test_and_set_bit usr/src/kernels/linux-5.10.0=
-136.12.0.86.h1063.eulerosv2r12/./include/asm-generic/bitops/instrumented-a=
tomic.h:70 [inline]
BUG: KASAN: use-after-free in tls_encrypt_done+0x3af/0x570 usr/src/kernels/=
linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/net/tls/tls_sw.c:493
Write of size 8 at addr ffff88810b762520 by task kworker/2:0/27

CPU: 2 PID: 27 Comm: kworker/2:0 Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 O=
E=A0=A0=A0=A0 5.10.0-136.12.0.86.h1063.eulerosv2r12.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1 04/01/2014
Workqueue: pencrypt_serial padata_serial_worker
Call Trace:
__dump_stack usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/li=
b/dump_stack.c:77 [inline]
dump_stack+0xbe/0xfd usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.euleros=
v2r12/lib/dump_stack.c:118
print_address_description.constprop.0+0x19/0x170 usr/src/kernels/linux-5.10=
.0-136.12.0.86.h1063.eulerosv2r12/mm/kasan/report.c:382
__kasan_report.cold+0x6c/0x84 usr/src/kernels/linux-5.10.0-136.12.0.86.h106=
3.eulerosv2r12/mm/kasan/report.c:542
kasan_report+0x3a/0x50 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.euler=
osv2r12/mm/kasan/report.c:559
check_memory_region_inline usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.e=
ulerosv2r12/mm/kasan/generic.c:187 [inline]
check_memory_region+0xfd/0x1f0 usr/src/kernels/linux-5.10.0-136.12.0.86.h10=
63.eulerosv2r12/mm/kasan/generic.c:193
instrument_atomic_read_write usr/src/kernels/linux-5.10.0-136.12.0.86.h1063=
.eulerosv2r12/./include/linux/instrumented.h:101 [inline]
test_and_set_bit usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r1=
2/./include/asm-generic/bitops/instrumented-atomic.h:70 [inline]
tls_encrypt_done+0x3af/0x570 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063=
.eulerosv2r12/net/tls/tls_sw.c:493
padata_serial_worker+0x25d/0x4c0 usr/src/kernels/linux-5.10.0-136.12.0.86.h=
1063.eulerosv2r12/kernel/padata.c:383
process_one_work+0x6b6/0xf10 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063=
.eulerosv2r12/kernel/workqueue.c:2354
worker_thread+0xdd/0xd80 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eul=
erosv2r12/kernel/workqueue.c:2500
kthread+0x30a/0x410 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv=
2r12/kernel/kthread.c:313
ret_from_fork+0x22/0x30 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eule=
rosv2r12/arch/x86/entry/entry_64.S:299

Allocated by task 2355:
kasan_save_stack+0x1b/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.e=
ulerosv2r12/mm/kasan/common.c:48
kasan_set_track usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12=
/mm/kasan/common.c:56 [inline]
set_alloc_info usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/=
mm/kasan/common.c:498 [inline]
__kasan_kmalloc usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12=
/mm/kasan/common.c:530 [inline]
__kasan_kmalloc.constprop.0+0xf0/0x130 usr/src/kernels/linux-5.10.0-136.12.=
0.86.h1063.eulerosv2r12/mm/kasan/common.c:501
kmalloc usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/./inclu=
de/linux/slab.h:563 [inline]
kzalloc usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/./inclu=
de/linux/slab.h:675 [inline]
tls_set_sw_offload+0xfc9/0x1330 usr/src/kernels/linux-5.10.0-136.12.0.86.h1=
063.eulerosv2r12/net/tls/tls_sw.c:2354
do_tls_setsockopt_conf+0x9d0/0xcd0 usr/src/kernels/linux-5.10.0-136.12.0.86=
.h1063.eulerosv2r12/net/tls/tls_main.c:552
do_tls_setsockopt usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r=
12/net/tls/tls_main.c:602 [inline]
tls_setsockopt+0x151/0x1a0 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.e=
ulerosv2r12/net/tls/tls_main.c:622
__sys_setsockopt+0x230/0x470 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063=
.eulerosv2r12/net/socket.c:2133
__do_sys_setsockopt usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv=
2r12/net/socket.c:2144 [inline]
__se_sys_setsockopt usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv=
2r12/net/socket.c:2141 [inline]
__x64_sys_setsockopt+0xbf/0x160 usr/src/kernels/linux-5.10.0-136.12.0.86.h1=
063.eulerosv2r12/net/socket.c:2141
do_syscall_64+0x33/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eule=
rosv2r12/arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x61/0xc6

Freed by task 2328:
kasan_save_stack+0x1b/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.e=
ulerosv2r12/mm/kasan/common.c:48
kasan_set_track+0x1c/0x30 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eu=
lerosv2r12/mm/kasan/common.c:56
kasan_set_free_info+0x20/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86.h106=
3.eulerosv2r12/mm/kasan/generic.c:361
__kasan_slab_free.part.0+0x13f/0x1b0 usr/src/kernels/linux-5.10.0-136.12.0.=
86.h1063.eulerosv2r12/mm/kasan/common.c:482
slab_free_hook usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/=
mm/slub.c:1569 [inline]
slab_free_freelist_hook usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eule=
rosv2r12/mm/slub.c:1608 [inline]
slab_free usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r12/mm/sl=
ub.c:3179 [inline]
kfree+0xcb/0x6c0 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2r1=
2/mm/slub.c:4176
tls_sk_proto_close+0x428/0x550 usr/src/kernels/linux-5.10.0-136.12.0.86.h10=
63.eulerosv2r12/net/tls/tls_main.c:324
inet_release+0x138/0x290 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eul=
erosv2r12/net/ipv4/af_inet.c:441
inet6_release+0x51/0x80 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eule=
rosv2r12/net/ipv6/af_inet6.c:486
__sock_release+0xd7/0x290 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eu=
lerosv2r12/net/socket.c:603
sock_close+0x1a/0x30 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.euleros=
v2r12/net/socket.c:1273
__fput+0x34f/0x910 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eulerosv2=
r12/fs/file_table.c:290
task_work_run+0xea/0x190 usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eul=
erosv2r12/kernel/task_work.c:161
tracehook_notify_resume usr/src/kernels/linux-5.10.0-136.12.0.86.h1063.eule=
rosv2r12/./include/linux/tracehook.h:188 [inline]
exit_to_user_mode_loop+0xf1/0x100 usr/src/kernels/linux-5.10.0-136.12.0.86.=
h1063.eulerosv2r12/kernel/entry/common.c:172
exit_to_user_mode_prepare+0x7e/0x90 usr/src/kernels/linux-5.10.0-136.12.0.8=
6.h1063.eulerosv2r12/kernel/entry/common.c:206
syscall_exit_to_user_mode+0x12/0x40 usr/src/kernels/linux-5.10.0-136.12.0.8=
6.h1063.eulerosv2r12/kernel/entry/common.c:281
entry_SYSCALL_64_after_hwframe+0x61/0xc6

