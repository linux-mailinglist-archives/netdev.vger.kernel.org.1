Return-Path: <netdev+bounces-280567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BsmZBZpw6WniZgIAu9opvQ
	(envelope-from <netdev+bounces-280567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282F44C00D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C08C3019FFE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E81EA7DB;
	Thu, 23 Apr 2026 01:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E21A6825
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906390; cv=none; b=PCfCxYX7/7g5EZMUxy5manjLU0i1aZOBrgDb89ZT1X2iS829EBmN6HGBatrDUl6RjLh9YK3Fn7cmXMLWv+J1OhT3sQUhqGwZiyGSU07Vjq4CBiOn4eMq9u+zFvxFYfgFRQx8RkdWiEKDWjOLQWpW/d1tOWKB8/2f9UbaTMNhMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906390; c=relaxed/simple;
	bh=vWqOM9nXuwLGUOZ+JxVDQtJNjHxs/osDVjdzuCyp35E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p82LltlkLDdslsn/lkyxKfi3DDI2MKJ7/DcNgvteBFoPR5gWKf1TAgLrKGHmIVAjHhlYR8+NZ64yho9DeLS3L2HQ0tH1a9ptogyeJV2CUoIkBWJNItgtsQBmYG6t6GyZ4vtjL6fRw3pBL7Tv/hzEsxngC8rBtJ9ay/bzbfuu87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7d4be1dee67so14913552a34.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 18:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776906387; x=1777511187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsSvGzVB80tFyVwkB3cRPRPM6dI8of/Q43SEFzEvigI=;
        b=OrnztPrGYvGUlBn1QoO/4eodUEIXCn2R7BrAHb7sTJDxWyaHRXYQA0I1WWn5cF9NSq
         kstglstnjNRygvYdjDNR90nB7LfQqaiXVjV+BdRowegY4z2UhPa/9cfDhurTBI2fkChr
         Y8DJSXp21UdjPVE0qBns+unSHoxLLElD+MK3KNFB25aL9mBtfsiAaQtYZpkJ7eBHckOc
         lSX30psFeqAhT6pJWOFhjHUgfqaPbuXFAj3lYLnb4COu4zA2S4jTrrLUAbQkn7JRpLNQ
         FJcbR7npKa9Ss9CMayxc6izlZKFmxsjF+WuyoRMFZn8zopLIHzwnBNZ8gTMx3AHK393f
         kFiw==
X-Forwarded-Encrypted: i=1; AFNElJ8GhIFTURRqtGMhw2QSWRUrJbSm9pQkLGji/Eo/U0y/+C/P+8NVwYXmwILGl42rpPclsICu8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlk3Q5YUE/EpV2AJTxu+BamWTKjvsmzSf0snkU30MfyrDfa+e
	A6sRbhPUZJ+WgRCZLRQfGJSRtLfyn3FNC+63A4oyVjCjYv4gv03IhnmfL+waT9MTRr2FNxmSxYj
	aWPZ9vbhj4FQWVU+E8nYx4hAAhe9tBrk5sWnDETExDMaR+d1d+ItrinyMMFg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e844:0:b0:67e:36e9:79a6 with SMTP id
 006d021491bc7-69462e48a91mr15566883eaf.19.1776906387619; Wed, 22 Apr 2026
 18:06:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:06:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e97093.050a0220.24bfd3.0048.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in __udp4_lib_mcast_deliver /
 udp_lib_unhash (3)
From: syzbot <syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6b32b22d8934c136];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,redhat.com,googlegroups.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280567-lists,netdev=lfdr.de,04905b8b3523856476c0];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url]
X-Rspamd-Queue-Id: 7282F44C00D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c23719abc330 Merge tag 'x86-urgent-2026-03-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141b0806580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b32b22d8934c136
dashboard link: https://syzkaller.appspot.com/bug?extid=04905b8b3523856476c0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0ec3784100d/disk-c23719ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff5ee751c9be/vmlinux-c23719ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1dda25fb6996/bzImage-c23719ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash

read-write to 0xffff88810194a9c8 of 4 bytes by task 15107 on cpu 0:
 udp_lib_unhash+0x1f4/0x3e0 net/ipv4/udp.c:2261
 sk_common_release+0x7a/0x230 net/core/sock.c:3990
 udp_lib_close+0x15/0x20 include/net/udp.h:324
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:469
 ____fput+0x1c/0x30 fs/file_table.c:497
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x1f4/0x6f0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x249/0x370 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810194a9c8 of 4 bytes by task 15111 on cpu 1:
 __udp4_lib_mcast_deliver+0x9a/0x790 net/ipv4/udp.c:2564
 __udp4_lib_rcv+0x972/0x1250 net/ipv4/udp.c:2749
 udp_rcv+0x4f/0x60 net/ipv4/udp.c:2936
 ip_protocol_deliver_rcu+0x3f7/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x415/0x6a0 net/ipv4/ip_input.c:644
 ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6207 [inline]
 __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6254
 __netif_receive_skb_list net/core/dev.c:6306 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6397
 netif_receive_skb_list+0x35/0x220 net/core/dev.c:6449
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1397
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4722
 __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
==================================================================


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

