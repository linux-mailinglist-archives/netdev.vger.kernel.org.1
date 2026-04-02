Return-Path: <netdev+bounces-274301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBFNKyO9zWlmgQYAu9opvQ
	(envelope-from <netdev+bounces-274301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FB38214F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDACC3026896
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BA230BD9;
	Thu,  2 Apr 2026 00:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAE24A06A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090965; cv=none; b=BO+qC8D2pk0srfkszUuhSZFcGkLFWP07Pdt1eCr77PzIrQXLbP524IFwvcZc8BtSdgnqmhQ95zeeyeo9DAnMcxMuBv8MGgcDDXL5RJy3Jrw38FhW8O1RAUVY2ShbXl4ctM/wbHo9qHQRZv8HLNG8PauELTWenFn2c5Q82I3H/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090965; c=relaxed/simple;
	bh=quIeK+Mo7MQBsJsAeqRrnJkkRUswjh2/gNO5H4ef/Tk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QcPVhg4XuX+97j3Rrfy1AKDnZlbozploxbbOaXfzTzMfCms9UYMqyef2eb7rOB4v6HDPCEj8lUSZ/FNf/XB81EwT7k7hksBslsX81GxeKARVl9CCs6tBWMLcUvZnwt9hn6aDU4RMlDpX4KAyfvaMolfOZbLLQ372EkpoeLdn4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-467b2af6710so1018785b6e.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775090962; x=1775695762;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ9s30YRo/jePoB2r5BZAQsb8eyW6fRXRgrpJnfnwVw=;
        b=Rq3uBnYPagG0Dg+PPJhiU/JUiwJUwvN+jsvjSxGjvUs68nuHv5VOg4Js7BKUYagfVc
         IwPrvSwmWVU4/o8duneVkkv+GYdhOdK0Ew6qLFNi7cTI0n1+jxJ/TgMZbM+2UPOBbhYM
         m5RLDA0yTXuYDkLIG3YRgQRcdoeGL+4SQbqP3s9iO/Srl2716cEa5HrAb6aaEhBsDdy5
         s15III8bOvGTn35QO0/cTXf9XKL/rJcLSCeDF8I6R+3Jc3QVgNHEVqmUMlyBKmPJNXPS
         cA27AmPznU3xRSxMsH4p4t4moWKGFSdhC7FC5fooak+6CwFrJhRD2SLYnblBrDCDPm6C
         vmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuyjOLDQiufGOkbecV6KMMBafJ99j0oHICIPMBTnhbV/qJ78h0R+q6xM0Hq9Ji/zam1iwab/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXcVMXIndCAn+Uyt8fURHHv9BzKA8HqFgtQO7vk4M0+6dRuPq
	zSDkg1+wxofMR9vtlZy9ZaeV2LyBeQEvoNUwbjoeOQdUecupsGnOIen+EAWYw2+RNr6tJ2mkos4
	3zOwSlodLNbgS21ulV/18osIlrbIebX+ojKBSSPaSb3ooBbcIMryrYR9Oi/E=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1986:b0:67f:ab5d:1748 with SMTP id
 006d021491bc7-67fabd020c7mr3101243eaf.48.1775090962240; Wed, 01 Apr 2026
 17:49:22 -0700 (PDT)
Date: Wed, 01 Apr 2026 17:49:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cdbd12.050a0220.70c3a.0007.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KASAN: slab-use-after-free Read in __sk_msg_recvmsg
From: syzbot <syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,cloudflare.com,gmail.com,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-274301-lists,netdev=lfdr.de,431f9a9e3f5227fbb904];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,appspotmail.com:email,googlegroups.com:email];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 516FB38214F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    93d04e76bcf1 Merge branch 'r8152-add-helper-functions-for-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14fde46a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9
dashboard link: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b9baba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152c5e26580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/953c48b40f73/disk-93d04e76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edb39d99bd41/vmlinux-93d04e76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/656d4ad35e4a/bzImage-93d04e76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __sk_msg_recvmsg+0x19b/0xe70 net/core/skmsg.c:431
Read of size 8 at addr ffff88807eeac2b0 by task syz.0.31/6071

CPU: 0 UID: 0 PID: 6071 Comm: syz.0.31 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __sk_msg_recvmsg+0x19b/0xe70 net/core/skmsg.c:431
 udp_bpf_recvmsg+0x196/0xac0 net/ipv4/udp_bpf.c:83
 sock_recvmsg_nosec net/socket.c:1071 [inline]
 sock_recvmsg+0x155/0x1b0 net/socket.c:1093
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2805
 ___sys_recvmsg+0x215/0x590 net/socket.c:2847
 do_recvmmsg+0x334/0x800 net/socket.c:2942
 __sys_recvmmsg net/socket.c:3016 [inline]
 __do_sys_recvmmsg net/socket.c:3039 [inline]
 __se_sys_recvmmsg net/socket.c:3032 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3032
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a3579c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a365f2028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f4a35a16180 RCX: 00007f4a3579c819
RDX: 0000000000000012 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f4a35832c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4a35a16218 R14: 00007f4a35a16180 R15: 00007ffda3b0e6c8
 </TASK>

Allocated by task 6069:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5380
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_sk_msg net/core/skmsg.c:525 [inline]
 sk_psock_skb_ingress_self+0x5e/0x370 net/core/skmsg.c:627
 sk_psock_verdict_apply net/core/skmsg.c:1062 [inline]
 sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1260
 udp_read_skb+0x5d9/0x6b0 net/ipv4/udp.c:2014
 sk_psock_verdict_data_ready+0x12d/0x590 net/core/skmsg.c:1281
 __udp_enqueue_schedule_skb+0xc4b/0x12e0 net/ipv4/udp.c:1745
 __udp_queue_rcv_skb net/ipv4/udp.c:2311 [inline]
 udp_queue_rcv_one_skb+0x831/0x1230 net/ipv4/udp.c:2401
 __udp4_lib_mcast_deliver+0xad7/0xb70 net/ipv4/udp.c:2513
 udp_rcv+0xcc2/0x24c0 net/ipv4/udp.c:2638
 ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 dst_input include/net/dst.h:480 [inline]
 ip_sublist_rcv_finish+0x1f0/0x240 net/ipv4/ip_input.c:623
 ip_list_rcv_finish net/ipv4/ip_input.c:667 [inline]
 ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:683
 ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:717
 __netif_receive_skb_list_ptype net/core/dev.c:6233 [inline]
 __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6280
 __netif_receive_skb_list net/core/dev.c:6332 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6423
 netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:6475
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1397
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4722
 __sys_bpf+0x643/0x950 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6070:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6483
 kfree_sk_msg include/linux/skmsg.h:418 [inline]
 __sk_msg_recvmsg+0xc7e/0xe70 net/core/skmsg.c:491
 udp_bpf_recvmsg+0x196/0xac0 net/ipv4/udp_bpf.c:83
 sock_recvmsg_nosec net/socket.c:1071 [inline]
 sock_recvmsg+0x155/0x1b0 net/socket.c:1093
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2805
 ___sys_recvmsg+0x215/0x590 net/socket.c:2847
 do_recvmmsg+0x334/0x800 net/socket.c:2942
 __sys_recvmmsg net/socket.c:3016 [inline]
 __do_sys_recvmmsg net/socket.c:3039 [inline]
 __se_sys_recvmmsg net/socket.c:3032 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3032
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807eeac000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 688 bytes inside of
 freed 1024-byte region [ffff88807eeac000, ffff88807eeac400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7eea8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fea6dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fea6dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001fbaa01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 176, tgid 176 (kworker/u8:7), ts 108779589894, free_ts 108254079914
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x2e6/0x730 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_noprof+0x474/0x760 mm/slub.c:5272
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 ieee802_11_parse_elems_full+0x159/0x2ab0 net/mac80211/parse.c:1051
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2496 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1565 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x4ca/0x2ce0 net/mac80211/ibss.c:1596
 ieee80211_iface_process_skb net/mac80211/iface.c:1757 [inline]
 ieee80211_iface_work+0x845/0x1380 net/mac80211/iface.c:1811
 cfg80211_wiphy_work+0x2ab/0x4a0 net/wireless/core.c:513
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 6064 tgid 6061 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __slab_free+0x263/0x2b0 mm/slub.c:5573
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_noprof+0x316/0x760 mm/slub.c:5272
 kmalloc_noprof include/linux/slab.h:954 [inline]
 iovec_from_user+0x87/0x250 lib/iov_iter.c:1321
 __import_iovec+0x163/0x7e0 lib/iov_iter.c:1375
 import_iovec+0x73/0xa0 lib/iov_iter.c:1440
 copy_msghdr_from_user net/socket.c:2522 [inline]
 recvmsg_copy_msghdr net/socket.c:2771 [inline]
 ___sys_recvmsg+0x4bd/0x590 net/socket.c:2843
 do_recvmmsg+0x334/0x800 net/socket.c:2942
 __sys_recvmmsg net/socket.c:3016 [inline]
 __do_sys_recvmmsg net/socket.c:3039 [inline]
 __se_sys_recvmmsg net/socket.c:3032 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3032
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807eeac180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807eeac200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807eeac280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88807eeac300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807eeac380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

