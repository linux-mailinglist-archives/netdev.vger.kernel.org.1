Return-Path: <netdev+bounces-258790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ObqIGuEqkmlRrgEAu9opvQ
	(envelope-from <netdev+bounces-258790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:21:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657D13F9DA
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13B43036D48
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780E527CB0A;
	Sun, 15 Feb 2026 20:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA96263C8C
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186892; cv=none; b=mcwQw3kJpgzC48E+8kYCiqBgv6peNua6n5WlnLCNUUv/jcaUaXD8xMWB9eJZK/rWyRBS8tyqvlb4ErXrM0Ag468j07pskWcT/9C2Bnoc+QlJ6kHqWZXNgR//UBR77S3cO/DnNG1I94vID9CZMt28eL/qHD5TkopUi8jI4V7qhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186892; c=relaxed/simple;
	bh=misesBBnWan8eGwYsqMIxMXKery3rircp+T1au2mX3c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lftpvZiSswlugLNKMvZNGGols+Hee/X1gQRNC9/yOewvCz7dWYJ3uOLH4VQ8hxoQHy2mUd61oRaDZAfeqB3hhwFFeiuJ7HwAdJ/aLrhE8M8BndBHmtw9K33Ww3412wNVPefPJfotxpv25DURbnaG2NdMkFq8JzirtDka84GZxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-678f3fef828so18249290eaf.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186889; x=1771791689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmqIEV1uSWubq+ImbJ9wiQZJTfCDAV0EkiIVsRLJzxU=;
        b=j7NuSf2qSCNcCpHr5m//8H0T8KjYx+WOwWnoyHuXIceDQ8RO62hPSFdk5J5QcgyyCp
         /sShrrwqylR4z8j/XVJoyuYgtyFo6eJG9xSRpvsR/9LDmrnB406rBVoUmtTEpX0G8VLm
         w4VLOZTkwPowgBTklIl80D6p9mgTQTKkr/ghtGUxNSFmXPEhgL9fLLmbrurnaPCloymW
         KpqkLrr2mDrWZ1YB7kYyi0NiO+LRwx6Km8hw7w+/MlcAgkv1ZJFtSVJh72tMqWfb4gia
         4EnUOFyka+OKlEVaB77f46Ed34ETgdeF/JSi3VcghwT8FRvyYW6XTNzVhh0mq9HrL+fM
         aD0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdci0Ffj6aO2C5pDGmRH3aWVCVWZz6tpo3HBH/2VRsUDbD+/f5FUEztco2Qvy3z5Fkw7krGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgbE7RdvcRPNLeQ6ryPY4tKIjWqd7XoTFtd2BXOd0TLAkbQGG
	0tEAIPN0O2RUXXXMkWbDID9zlZbp0V5US+PBnv1zX+3qYzbCO7k42QFpUw85aP/s63FhB1/yMGP
	HQKf++AOuQtDyiY/EcYdZIZLpL4g8bgxza4DZwUU+/y4C1Svjuo8Hu7hN+ps=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1a0b:b0:676:e8d1:bb49 with SMTP id
 006d021491bc7-6776968feb8mr4437870eaf.69.1771186889442; Sun, 15 Feb 2026
 12:21:29 -0800 (PST)
Date: Sun, 15 Feb 2026 12:21:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69922ac9.a70a0220.2c38d7.00e1.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KCSAN: data-race in __udp_enqueue_schedule_skb
 / sk_psock_drop
From: syzbot <syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258790-lists,netdev=lfdr.de,113cea56c13a8a1e95ab];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,cloudflare.com,gmail.com,redhat.com,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5657D13F9DA
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    f14faaf3a1fb Merge tag 'tsm-fixes-for-6.19' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125c6402580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
dashboard link: https://syzkaller.appspot.com/bug?extid=113cea56c13a8a1e95ab
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9cdf3c60fee1/disk-f14faaf3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24b163320d00/vmlinux-f14faaf3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/854533a48cfc/bzImage-f14faaf3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __udp_enqueue_schedule_skb / sk_psock_drop

write to 0xffff88811d063048 of 8 bytes by task 23114 on cpu 0:
 sk_psock_stop_verdict net/core/skmsg.c:1287 [inline]
 sk_psock_drop+0x12f/0x270 net/core/skmsg.c:873
 sk_psock_put include/linux/skmsg.h:473 [inline]
 sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
 __sock_map_delete net/core/sock_map.c:426 [inline]
 sock_map_delete_from_link net/core/sock_map.c:439 [inline]
 sock_map_unlink net/core/sock_map.c:1608 [inline]
 sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
 sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:468
 ____fput+0x1c/0x30 fs/file_table.c:496
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0x1f7/0x6f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x1d3/0x2a0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d063048 of 8 bytes by task 23117 on cpu 1:
 __udp_enqueue_schedule_skb+0x6c1/0x840 net/ipv4/udp.c:1789
 __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
 udp_queue_rcv_one_skb+0x709/0xc20 net/ipv4/udp.c:2475
 udp_queue_rcv_skb+0x20e/0x2b0 net/ipv4/udp.c:2493
 __udp4_lib_mcast_deliver+0x6e8/0x790 net/ipv4/udp.c:2585
 __udp4_lib_rcv+0x96f/0x1260 net/ipv4/udp.c:2724
 udp_rcv+0x4f/0x60 net/ipv4/udp.c:2911
 ip_protocol_deliver_rcu+0x3f9/0x780 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:474 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x42b/0x6d0 net/ipv4/ip_input.c:644
 ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
 __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6242
 __netif_receive_skb_list net/core/dev.c:6294 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6385
 netif_receive_skb_list+0x31/0x1f0 net/core/dev.c:6437
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1396
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x4c0/0x7b0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6272
 x64_sys_call+0x28e1/0x3000 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffffff847b24d0 -> 0xffffffff84673410

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 23117 Comm: syz.8.5085 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

