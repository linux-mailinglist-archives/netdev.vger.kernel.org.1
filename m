Return-Path: <netdev+bounces-228063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16BBC05A8
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1D4D4E2650
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBED224AF9;
	Tue,  7 Oct 2025 06:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B401DFE12
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819227; cv=none; b=E+/rdYfP1AgLbFsFqeC7a5aG+moP1CG4W7LP0WRUCMQdsIP/ZQQS2lZm6QtPlsVX8FEgT95TnsfJ8j4rkXGXvQCfjo37hiu0iZn8LRqUgCUAo7VJ0ud1ZDFy7CZV2JGuF8JJqMPq2gkONCSacuhVnaxfiAWtNyLfB9uzHD78Jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819227; c=relaxed/simple;
	bh=XlOTIbzyJ9ae2wkRAdNrqwCpKp7faZ2gxc/qDolAbPI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B3uafK8ZnwaX4dfu74K2yWAWFz17sJqrq/WWGI9brGIBEg1+E2V0SaSvAvv6jjreL8Rk9r8zu3hat5MMHUtbL5cT6qmP9CUrjqK1X3wtx+r6hlA69WjOTD02X8LGEoascMiq7xuRCLYVkNFlPIDJqx29FKqjEy2cyIKGgVCsHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42f6639fb22so39645345ab.0
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819225; x=1760424025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmWH0sFJ81ae4IdRbfRzpAwRmesL9eDv1LLY5X2e6JQ=;
        b=S1kTqQGjo3LF66HMhrxk4o0VaPyWrwA5MNfok6cQisi3EJbVn3Phentu/KEmeoWqYZ
         /+AEZAb/WyQoHbgexTkj9vJbWFyomrxk/O+6orwMcXeaFhs3CsAU1exVeOyrpp5lBCvV
         jAF8qrDmK7zt4pIe+aXSPhHt79wOJRNIZ39VK/Ez1oAr2a6OdjBYJ0rlHdvQxFYGSZy3
         F7shEoS2mUdUn1GIsaZ/x2/AGtH0jAfDWMY1jJVu3Dni8XPPUYJdPfzC+fvxeTmQM2Ue
         Wmyb83ikQapZQKkCGUWKKMc03/gXZHbouR7dvG/1U9jywEDxf0RcIZlxQxRPkWuTg7mv
         F+IA==
X-Forwarded-Encrypted: i=1; AJvYcCVxY7/A3Zb+EmAG8gZvnTMn81GHCMCBJ9nfIB5UOE8McAd59SLzLzL/RnNVSXtRuo+BJKk7/Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAMjlhDZhhjNE3LwoOtbmSgUe2wIO51iuAVX+EaoYqmv2x7QV
	1NDq0u4CBUhrR8WhtB3BaCG8xL5WxjzwBfUf8CFckYrtz2MTblhSJQYALM9pzxGCisUBp6dXeBz
	Mnz9pSjTYLTe+U55dEIkTeYU8IoKDW36TsLRMQf+yYuuHVVsaLZNCoSubOJw=
X-Google-Smtp-Source: AGHT+IHEceDnSvP7Mgd+2PyErdUwcXrmuHiI9Iqr/mzTkggx/G8u97rfYlYQ8kAvua5X+UpFjIbQHAKncBBlCrwFSJ1JNEKAVESF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c5:b0:42e:7481:8973 with SMTP id
 e9e14a558f8ab-42e7ad84488mr189261375ab.20.1759819224982; Mon, 06 Oct 2025
 23:40:24 -0700 (PDT)
Date: Mon, 06 Oct 2025 23:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e4b5d8.050a0220.256323.0018.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in netif_skb_features (4)
From: syzbot <syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e406d57be7bd Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144ad942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50fb29d81ff5a3df
dashboard link: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7aa074b1bf56/disk-e406d57b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c8a46bed2ec/vmlinux-e406d57b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ed66e725466/bzImage-e406d57b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in netif_skb_features+0x115b/0x2160 net/core/dev.c:3825
 netif_skb_features+0x115b/0x2160 net/core/dev.c:3825
 validate_xmit_skb+0xb6/0x1d50 net/core/dev.c:3985
 __dev_queue_xmit+0x23f8/0x5e60 net/core/dev.c:4755
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 hsr_xmit net/hsr/hsr_forward.c:430 [inline]
 hsr_forward_do net/hsr/hsr_forward.c:571 [inline]
 hsr_forward_skb+0x2162/0x3c40 net/hsr/hsr_forward.c:733
 hsr_handle_frame+0xd6d/0x11a0 net/hsr/hsr_slave.c:81
 __netif_receive_skb_core+0x2040/0x7150 net/core/dev.c:5966
 __netif_receive_skb_list_core+0x2f1/0x16b0 net/core/dev.c:6154
 __netif_receive_skb_list net/core/dev.c:6221 [inline]
 netif_receive_skb_list_internal+0xee7/0x1530 net/core/dev.c:6312
 gro_normal_list include/net/gro.h:524 [inline]
 gro_flush_normal include/net/gro.h:532 [inline]
 napi_complete_done+0x3fb/0x7d0 net/core/dev.c:6681
 gro_cell_poll+0x2c9/0x310 net/core/gro_cells.c:66
 __napi_poll+0xda/0x8a0 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0xbc8/0x1c30 net/core/dev.c:7784
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:622
 __do_softirq+0x14/0x1b kernel/softirq.c:656
 do_softirq+0x99/0x100 kernel/softirq.c:523
 __local_bh_enable_ip+0xa1/0xb0 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_rx_batched+0x889/0x980 drivers/net/tun.c:-1
 tun_get_user+0x5d60/0x6d70 drivers/net/tun.c:1953
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0xbdf/0x15d0 fs/read_write.c:686
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x3014/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5297
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 __pskb_copy_fclone+0xcc/0x14d0 net/core/skbuff.c:2164
 __pskb_copy include/linux/skbuff.h:1447 [inline]
 hsr_create_tagged_frame+0x32c/0x11b0 net/hsr/hsr_forward.c:340
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0x16a4/0x3c40 net/hsr/hsr_forward.c:733
 hsr_handle_frame+0xd6d/0x11a0 net/hsr/hsr_slave.c:81
 __netif_receive_skb_core+0x2040/0x7150 net/core/dev.c:5966
 __netif_receive_skb_list_core+0x2f1/0x16b0 net/core/dev.c:6154
 __netif_receive_skb_list net/core/dev.c:6221 [inline]
 netif_receive_skb_list_internal+0xee7/0x1530 net/core/dev.c:6312
 gro_normal_list include/net/gro.h:524 [inline]
 gro_flush_normal include/net/gro.h:532 [inline]
 napi_complete_done+0x3fb/0x7d0 net/core/dev.c:6681
 gro_cell_poll+0x2c9/0x310 net/core/gro_cells.c:66
 __napi_poll+0xda/0x8a0 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0xbc8/0x1c30 net/core/dev.c:7784
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:622
 __do_softirq+0x14/0x1b kernel/softirq.c:656

CPU: 1 UID: 0 PID: 11876 Comm: syz.2.2011 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

