Return-Path: <netdev+bounces-190008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57987AB4E19
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6833A7662
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C947202C43;
	Tue, 13 May 2025 08:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951861F16B;
	Tue, 13 May 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124902; cv=none; b=nwWwB5zxcjaWLS0GQ/OWRTUSYxJvMQU+vV9UB7ekJ5n5NdL9vkZlpXInE5CX7e1MzfX6TF464sjd1fBbNjpZpnKYcHszIq7PLSQ6CO6M5pmw210KpaN3VRZjuSpeT6P6lEcpAPoahI9frHujk9uE4YkmEqXjF+i33A+1hXi0oEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124902; c=relaxed/simple;
	bh=vUm6b/0xHwT8PXsKP1jeFsQstuwQqSfjwHSbeBN3yxA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDTd/RvyFQsa4AuSFSNINTa9SmDwGEE+VXBJGn6gWePaLpLM7Dcg903buW8KNTAGw/73JvW2yu6iQi7sLiNj2//yhpygr3PceojGGa3PIW3Zc8/QbOsXpqib3UVX22Vje73rdbem9zSGVCF1zPV/GxVnJIzA8E33ZDpAvcGqDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZxV4P6CrXz27gvY;
	Tue, 13 May 2025 16:28:53 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C2AB41A0188;
	Tue, 13 May 2025 16:28:06 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 16:28:06 +0800
Received: from localhost.localdomain (10.175.104.82) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 16:28:05 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [BUG Report] KASAN: slab-use-after-free in page_pool_recycle_in_ring
Date: Tue, 13 May 2025 16:31:23 +0800
Message-ID: <20250513083123.3514193-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemq200002.china.huawei.com (7.202.195.90)

Hello,

syzkaller found the UAF issue in page_pool_recycle_in_ring[1], which is
similar to syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com.

root cause is as follow:

page_pool_recycle_in_ring
  ptr_ring_produce
    spin_lock(&r->producer_lock);
    WRITE_ONCE(r->queue[r->producer++], ptr)
      //recycle last page to pool
 				page_pool_release
				  page_pool_scrub
				    page_pool_empty_ring
				      ptr_ring_consume
				      page_pool_return_page //release all page
				  __page_pool_destroy
				     free_percpu(pool->recycle_stats);
				     kfree(pool) //free

     spin_unlock(&r->producer_lock); //pool->ring uaf read
  recycle_stat_inc(pool, ring);

page_pool can be free while page pool recycle the last page in ring.
After adding a delay to the page_pool_recycle_in_ring(), syzlog[2] can
reproduce this issue with a high probability. Maybe we can fix it by
holding the user_cnt of the page pool during the page recycle process.

Does anyone have a good idea to solve this problem?

-----
Best Regards,
Dong Chenchen

[1]
BUG: KASAN: slab-use-after-free in page_pool_recycle_in_ring (net/core/page_pool.c:718) 
Read of size 8 at addr ffff88811dfe0710 by task syz-executor.14/11451

CPU: 1 UID: 0 PID: 11451 Comm: syz-executor.14 Tainted: G        W           6.15.0-rc5-00207-g1a33418a69cc-dirty #30 PREEMPT(full)
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123) 
print_report (mm/kasan/report.c:409 mm/kasan/report.c:521) 
kasan_report (mm/kasan/report.c:636) 
page_pool_recycle_in_ring (net/core/page_pool.c:718) 
page_pool_put_unrefed_netmem (net/core/page_pool.c:834 (discriminator 1)) 
napi_pp_put_page (./include/net/page_pool/helpers.h:336 ./include/net/page_pool/helpers.h:366 net/core/skbuff.c:1008) 
skb_free_head (net/core/skbuff.c:1066) 
skb_release_data (net/core/skbuff.c:1108) 
sk_skb_reason_drop (net/core/skbuff.c:1177 net/core/skbuff.c:1214) 
skb_queue_purge_reason (./include/linux/skbuff.h:2147 ./include/linux/skbuff.h:2453 ./include/linux/skbuff.h:3353 net/core/skbuff.c:3917 net/core/skbuff.c:3902) 
packet_release (net/packet/af_packet.c:1288 net/packet/af_packet.c:3233) 
__sock_release (net/socket.c:648) 
sock_close (net/socket.c:1393) 
__fput (fs/file_table.c:466) 
fput_close_sync (fs/file_table.c:571) 
__x64_sys_close (fs/open.c:1583 fs/open.c:1566 fs/open.c:1566) 
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
RIP: 0033:0x417bd1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
All code
========
   0:	75 14                	jne    0x16
   2:	b8 03 00 00 00       	mov    $0x3,%eax
   7:	0f 05                	syscall 
   9:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   f:	0f 83 a4 1a 00 00    	jae    0x1ab9
  15:	c3                   	ret    
  16:	48 83 ec 08          	sub    $0x8,%rsp
  1a:	e8 0a fc ff ff       	call   0xfffffffffffffc29
  1f:	48 89 04 24          	mov    %rax,(%rsp)
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall 
  2a:*	48 8b 3c 24          	mov    (%rsp),%rdi		<-- trapping instruction
  2e:	48 89 c2             	mov    %rax,%rdx
  31:	e8 53 fc ff ff       	call   0xfffffffffffffc89
  36:	48 89 d0             	mov    %rdx,%rax
  39:	48 83 c4 08          	add    $0x8,%rsp
  3d:	48                   	rex.W
  3e:	3d                   	.byte 0x3d
  3f:	01                   	.byte 0x1

Code starting with the faulting instruction
===========================================
   0:	48 8b 3c 24          	mov    (%rsp),%rdi
   4:	48 89 c2             	mov    %rax,%rdx
   7:	e8 53 fc ff ff       	call   0xfffffffffffffc5f
   c:	48 89 d0             	mov    %rdx,%rax
   f:	48 83 c4 08          	add    $0x8,%rsp
  13:	48                   	rex.W
  14:	3d                   	.byte 0x3d
  15:	01                   	.byte 0x1
RSP: 002b:00007fffe74be2a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000417bd1
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 000000000077d960 R08: 0000001b2e160000 R09: 0000000000780d78
R10: 00007fffe74be390 R11: 0000000000000293 R12: 000000000006a10e
R13: 000000000077c03c R14: 000000000077c030 R15: 0000000000000001
</TASK>

Allocated by task 11457:
kasan_save_stack (mm/kasan/common.c:48) 
kasan_save_track (./arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
__kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:394) 
page_pool_create_percpu (./include/linux/slab.h:928 net/core/page_pool.c:344) 
bpf_test_run_xdp_live (net/bpf/test_run.c:183 net/bpf/test_run.c:383) 
bpf_prog_test_run_xdp (net/bpf/test_run.c:1316) 
__sys_bpf (kernel/bpf/syscall.c:4427 kernel/bpf/syscall.c:5852) 
__x64_sys_bpf (kernel/bpf/syscall.c:5939) 
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 

Freed by task 11137:
kasan_save_stack (mm/kasan/common.c:48) 
kasan_save_track (./arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
kasan_save_free_info (mm/kasan/generic.c:579) 
__kasan_slab_free (mm/kasan/common.c:271) 
kfree (mm/slub.c:4642 mm/slub.c:4841) 
page_pool_release (net/core/page_pool.c:1062 net/core/page_pool.c:1099) 
page_pool_release_retry (net/core/page_pool.c:1118) 
process_one_work (kernel/workqueue.c:3243) 
worker_thread (kernel/workqueue.c:3313 kernel/workqueue.c:3400) 
kthread (kernel/kthread.c:464) 
ret_from_fork (arch/x86/kernel/process.c:159) 
ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 

Last potentially related work creation:
kasan_save_stack (mm/kasan/common.c:48) 
kasan_record_aux_stack (mm/kasan/generic.c:548) 
insert_work (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141
	kernel/workqueue.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186) 
__queue_work (kernel/workqueue.c:2342) 
call_timer_fn (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/timer.h:127 kernel/time/timer.c:1790) 
__run_timers (kernel/time/timer.c:1836 kernel/time/timer.c:2414) 
run_timer_base (kernel/time/timer.c:2427 kernel/time/timer.c:2418 kernel/time/timer.c:2435) 
run_timer_softirq (kernel/time/timer.c:2446) 
handle_softirqs (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/irq.h:142 kernel/softirq.c:580) 
__irq_exit_rcu (kernel/softirq.c:614 kernel/softirq.c:453 kernel/softirq.c:680) 
irq_exit_rcu (kernel/softirq.c:698) 
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049) 
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 

The buggy address belongs to the object at ffff88811dfe0000
which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1808 bytes inside of
freed 2048-byte region [ffff88811dfe0000, ffff88811dfe0800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11dfe0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff888100042f00 ffffea000495e200 0000000000000002
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 017ff00000000040 ffff888100042f00 ffffea000495e200 0000000000000002
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 017ff00000000003 ffffea000477f801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable,
gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 11004, tgid 11004 (syz-executor.4), ts 427330276241, free_ts 427308706507
post_alloc_hook (./include/linux/page_owner.h:32 mm/page_alloc.c:1718) 
get_page_from_freelist (mm/page_alloc.c:1728 mm/page_alloc.c:3688) 
__alloc_frozen_pages_noprof (mm/page_alloc.c:4970) 
alloc_pages_mpol (mm/mempolicy.c:2303) 
new_slab (mm/slub.c:2450 mm/slub.c:2618 mm/slub.c:2672) 
___slab_alloc (mm/slub.c:3859 (discriminator 3)) 
__slab_alloc.constprop.0 (mm/slub.c:3948) 
__kmalloc_node_track_caller_noprof (mm/slub.c:4023 mm/slub.c:4184 mm/slub.c:4326 mm/slub.c:4346) 
kmalloc_reserve (net/core/skbuff.c:599) 
pskb_expand_head (net/core/skbuff.c:2247) 
netlink_trim (net/netlink/af_netlink.c:1298) 
netlink_broadcast_filtered (net/netlink/af_netlink.c:453 net/netlink/af_netlink.c:1519) 
nlmsg_notify (net/netlink/af_netlink.c:2578) 
notifier_call_chain (kernel/notifier.c:85) 
call_netdevice_notifiers_info (net/core/dev.c:2176) 
page last free pid 11004 tgid 11004 stack trace:
__free_frozen_pages (./include/linux/page_owner.h:25 mm/page_alloc.c:1262 mm/page_alloc.c:2725) 
__put_partials (mm/slub.c:3180) 
qlist_free_all (mm/kasan/quarantine.c:174) 
kasan_quarantine_reduce (./include/linux/srcu.h:400 mm/kasan/quarantine.c:287) 
__kasan_slab_alloc (mm/kasan/common.c:331) 
__kmalloc_cache_noprof (mm/slub.c:4147 mm/slub.c:4196 mm/slub.c:4353) 
ref_tracker_alloc (lib/ref_tracker.c:203) 
net_rx_queue_update_kobjects (net/core/net-sysfs.c:1238 net/core/net-sysfs.c:1301) 
netdev_register_kobject (net/core/net-sysfs.c:2094 net/core/net-sysfs.c:2340) 
register_netdevice (./include/linux/netdevice.h:2751 net/core/dev.c:10999) 
veth_newlink (drivers/net/veth.c:1819) 
rtnl_newlink (net/core/rtnetlink.c:3833 net/core/rtnetlink.c:3950 net/core/rtnetlink.c:4065) 
rtnetlink_rcv_msg (net/core/rtnetlink.c:6955) 
netlink_rcv_skb (net/netlink/af_netlink.c:2535) 
netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339) 
netlink_sendmsg (net/netlink/af_netlink.c:1883) 

Memory state around the buggy address:
ffff88811dfe0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88811dfe0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811dfe0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88811dfe0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88811dfe0800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

[2]
https://lore.kernel.org/all/670c204d.050a0220.3e960.0045.GAE@google.com/T/

