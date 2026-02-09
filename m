Return-Path: <netdev+bounces-257904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIhGHuuMiWnP+gQAu9opvQ
	(envelope-from <netdev+bounces-257904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:29:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E210C717
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5AF83001056
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F5322C67;
	Mon,  9 Feb 2026 07:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EC31B810
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622183; cv=none; b=U0xpzqoAnqhsWNSkH8h2SzilZFiJA/GkVOMyGYjxpQqaJSaOcmeX9aCn9YDUHYqCT47oHO/Frw6hw/ruIGX2AKThxcQfRogNNveX7A8wkypD6QIiuHwaoYiSU3U6AZSE/1nfUtXg8gtWRNj6gW1hJlf5t5MGLLLqW7oj9mRh3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622183; c=relaxed/simple;
	bh=1Z80Y54GApA+vwHxwfs9iFi55N75i3Z2lFyPREkRAAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QtKj5X7PYXa1iW6T+lR0XxXiAG3/0628qA6T38B9aDvrVqahHzjmnLNWHHxzxyroBY/qy2CCefRSjYGJo6aKduNuAOxqKRinVqowlmfNITTxpaxunRW6D126RyrmYSwTXVjQLvu99HS5jrrH9pG2mhY3TUpUjruLMME5lrIC4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7cfcf550dd8so13516424a34.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 23:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770622182; x=1771226982;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwjR5eMe1i6OnNPL//eeEDD4NHn6WEJwFySARt82Okw=;
        b=jVij8GGxdT8dLvcCCgPsLYDXWhUxPdf4T5Shr3QlVnQKq0IlsEpOa1ENmXtjjBiC4O
         yHiQVG9YSdBImDcC337RO9OvWpnOvBQkEhsQPHKcjWj09kcLt6WqHsP4ihXVtVtIfCn7
         KvugvbRT7hSPLS/ItE0HiYkC3A7dPuPYHQR9rCHRpNxQ98i+5qSf6Rdj6cC9BhU9s0FK
         3QfcZMHIYwunogXYI48ftRUEzLrpQUMGaC9sp9EGp4tnqaMI7JhUo36iY8AmuNLA1rHS
         gP+HbIso3SpoXpw5LAyEINUe2158ldkjNgHRyyfOZj0v11mLQ9Qtpl4sFlPwnOeh71II
         pXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4d4TWWUwfvWcvZUufSgNa62N2+nqF1v1kigWEyncjDcXm8mGnQr6db+84UwbCpW5HRv3id20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuHNVN+0CaUrw8zSmhzCiJ5LmvacvID2ULO5AbDGoha09hy/o
	dWHvbn9TEzQG4APbsHlOYAZ0ls+J0dHuxdAaZSgim28l3cW/ZAaDGzKMsgiGSshGyWxX9ZHsglp
	HHIzMuwNhniy018H6aTNWZk7QnU67gQkzCOT1j5neJWquriBXYXw9RcNg5Z0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d42:b0:663:1239:9ec8 with SMTP id
 006d021491bc7-66d0a667e01mr4158502eaf.29.1770622182340; Sun, 08 Feb 2026
 23:29:42 -0800 (PST)
Date: Sun, 08 Feb 2026 23:29:42 -0800
In-Reply-To: <20260209021134.21194-1-dqfext@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69898ce6.a00a0220.34fa92.0041.GAE@google.com>
Subject: [syzbot ci] Re: ppp: don't store tx skb in the fastpath
From: syzbot ci <syzbot+ci73cb85ac9652d7d4@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, dqfext@gmail.com, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257904-lists,netdev=lfdr.de,ci73cb85ac9652d7d4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,vger.kernel.org,redhat.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlesource.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 993E210C717
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] ppp: don't store tx skb in the fastpath
https://lore.kernel.org/all/20260209021134.21194-1-dqfext@gmail.com
* [RFC PATCH net-next] ppp: don't store tx skb in the fastpath

and found the following issue:
KASAN: slab-use-after-free Write in sk_skb_reason_drop

Full report is available here:
https://ci.syzbot.org/series/0307aa1e-223a-4cd7-af71-1a3c3b7b33f0

***

KASAN: slab-use-after-free Write in sk_skb_reason_drop

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      57be33f85e369ce9f69f61eaa34734e0d3bd47a7
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/3b8a7fc0-258a-4d96-b4cf-cf828112415c/config
C repro:   https://ci.syzbot.org/findings/43f9458e-e8a7-4c35-83a9-fd92f2c65af4/c_repro
syz repro: https://ci.syzbot.org/findings/43f9458e-e8a7-4c35-83a9-fd92f2c65af4/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:389 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:432 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:450 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1292 [inline]
BUG: KASAN: slab-use-after-free in __sk_skb_reason_drop net/core/skbuff.c:1226 [inline]
BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x37/0x170 net/core/skbuff.c:1254
Write of size 4 at addr ffff88811262cce4 by task syz.0.17/5962

CPU: 1 UID: 0 PID: 5962 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 skb_unref include/linux/skbuff.h:1292 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1226 [inline]
 sk_skb_reason_drop+0x37/0x170 net/core/skbuff.c:1254
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 ppp_push+0x1284/0x1440 drivers/net/ppp/ppp_generic.c:-1
 __ppp_xmit_process drivers/net/ppp/ppp_generic.c:1680 [inline]
 ppp_xmit_process+0x9d7/0x1d90 drivers/net/ppp/ppp_generic.c:1706
 ppp_write+0x2c6/0x400 drivers/net/ppp/ppp_generic.c:540
 do_loop_readv_writev fs/read_write.c:850 [inline]
 vfs_writev+0x4bd/0x990 fs/read_write.c:1059
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev fs/read_write.c:1199 [inline]
 __se_sys_pwritev fs/read_write.c:1194 [inline]
 __x64_sys_pwritev+0x19f/0x2a0 fs/read_write.c:1194
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a1d39acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1381da18 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 00007f1a1d615fa0 RCX: 00007f1a1d39acb9
RDX: 0000000000000001 RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f1a1d408bf7 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1a1d615fac R14: 00007f1a1d615fa0 R15: 00007f1a1d615fa0
 </TASK>

Allocated by task 5962:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_node_noprof+0x427/0x6f0 mm/slub.c:5315
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 ppp_write+0xb1/0x400 drivers/net/ppp/ppp_generic.c:523
 do_loop_readv_writev fs/read_write.c:850 [inline]
 vfs_writev+0x4bd/0x990 fs/read_write.c:1059
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev fs/read_write.c:1199 [inline]
 __se_sys_pwritev fs/read_write.c:1194 [inline]
 __x64_sys_pwritev+0x19f/0x2a0 fs/read_write.c:1194
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5962:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kmem_cache_free+0x195/0x610 mm/slub.c:6785
 ppp_prepare_tx_skb drivers/net/ppp/ppp_generic.c:1850 [inline]
 __ppp_xmit_process drivers/net/ppp/ppp_generic.c:1676 [inline]
 ppp_xmit_process+0x1147/0x1d90 drivers/net/ppp/ppp_generic.c:1706
 ppp_write+0x2c6/0x400 drivers/net/ppp/ppp_generic.c:540
 do_loop_readv_writev fs/read_write.c:850 [inline]
 vfs_writev+0x4bd/0x990 fs/read_write.c:1059
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev fs/read_write.c:1199 [inline]
 __se_sys_pwritev fs/read_write.c:1194 [inline]
 __x64_sys_pwritev+0x19f/0x2a0 fs/read_write.c:1194
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88811262cc00
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff88811262cc00, ffff88811262ccf0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11262c
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff8881616f28c0 ffffea00044a4780 dead000000000002
raw: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 017ff00000000040 ffff8881616f28c0 ffffea00044a4780 dead000000000002
head: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 017ff00000000001 ffffea0004498b01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 20587824573, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3a0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xd82/0x1760 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_node_noprof+0x4b5/0x6f0 mm/slub.c:5315
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x84/0x260 net/core/rtnetlink.c:4407
 rtmsg_ifinfo_event net/core/rtnetlink.c:4449 [inline]
 rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4458
 register_netdevice+0x175f/0x1ae0 net/core/dev.c:11458
 register_netdev+0x40/0x60 net/core/dev.c:11522
 nr_proto_init+0x14a/0x720 net/netrom/af_netrom.c:1424
 do_one_initcall+0x250/0x840 init/main.c:1378
 do_initcall_level+0x104/0x190 init/main.c:1440
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88811262cb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811262cc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811262cc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff88811262cd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811262cd80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

