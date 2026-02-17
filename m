Return-Path: <netdev+bounces-259083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Le4OXySlGl3FgIAu9opvQ
	(envelope-from <netdev+bounces-259083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:08:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A014DE3E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2F0F3034A07
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685B36D51E;
	Tue, 17 Feb 2026 16:08:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886E36D516
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344503; cv=none; b=QlskDpfzUpXUv+uDdD8ePhY5Hq9ZDG9v5frvNxzsfod98b8XTYWnNTo7B+is9FYujo1TPO84uK8DlSDq+joIk9KAB0V89f3YYVAlqEliFiLeMEfstxNy8j/u+hknfFd6J9LI3M8KoAfZogkHJXLfa7qq2uZgnxKdJNZhDiIZsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344503; c=relaxed/simple;
	bh=JliyW7zepwjvQZbLMGbch8OU0DTaqQTYQv2hTda1lDU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gdF7nO4ZAKeSchLu/W8xKGHkvwSqag/XPZQjyYdclc62u5b7dpz6vemBJbc7IQLKXmrW/7fT+n3CUrpe37CupXOvzWj5EReJOsG8d7nUIAwEw94pfGBCNClBiY7v7+eitQVsc02id8Gi/pesbPflNeTWcr3erPgt8BCERXfjA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6781479fe9dso46311332eaf.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344501; x=1771949301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaZk6k1MJUvmTXwEbhhr17OQUKYfol3DA5TSzMsaSLM=;
        b=kAKZiOQceyXBTEBgNaHy5MAeFG9ri+7sNrfnmEVuGu9a0yFKAqESD6maaFWcIfxHwl
         prn8w25orvjw4R5b33czb8Awy9IzJgpHhiFfvrBTRMhKJA0rmRKdJV1qioEZ6XfVwj2k
         HYL/MiiJUZVxl22TJauvrxHCTaDDYHzfdgITEvBB1uLJjuXu/SXvMzwHSyyEq7Rm0Ip2
         Fa3WNa26N2efWWGiaSt3N4xqWlBKkKo59O9+yr4i283nuB7NGTKeCuZGIqmFGJEXTW6r
         PBsE4oxBGcb1rmMmg+/pZ9sMXh3AVJX5ot8aMh7DdYoHOUC3luu4sSa+yMbVeG521XfM
         QJUA==
X-Forwarded-Encrypted: i=1; AJvYcCXzxSaiT1yfmbKXA+w83WvsmIZxfkaBBAwTIK13xiDnVjlMd+As3UEgH67u1NZRSx5pC/dC6oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EH5eyaS+z+1tW2wbpbW37Kqu+kqGz0LxcBF9TFIuTqfVuq6+
	uiOHwSfikSK0W1hvoxFQbaXm2VSPZybsGsjqwBq0ui7gwQn06/N9Y4I6nhGMwQ7E+68ycmhz4l4
	EF6gUtd/pgliY1nHMv7/XMvCqvhWOhLEI2+PM/PXmE28QU3S8eCUZo7YttqE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2283:b0:66e:b5fa:db0a with SMTP id
 006d021491bc7-6781fff0e68mr6912382eaf.5.1771344501268; Tue, 17 Feb 2026
 08:08:21 -0800 (PST)
Date: Tue, 17 Feb 2026 08:08:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69949275.050a0220.2eeac1.0145.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in tcp_assign_congestion_control / tcp_v6_syn_recv_sock
From: syzbot <syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a6d4a8c8877f1220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259083-lists,netdev=lfdr.de,937b5bbb6a815b3e5d0b];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 5D6A014DE3E
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    cee73b1e840c Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1188e15a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6d4a8c8877f1220
dashboard link: https://syzkaller.appspot.com/bug?extid=937b5bbb6a815b3e5d0b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c607da3ff440/disk-cee73b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ca19d705091/vmlinux-cee73b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c9182a73e86/bzImage-cee73b1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in tcp_assign_congestion_control / tcp_v6_syn_recv_sock

read-write to 0xffff888103ccb073 of 1 bytes by interrupt on cpu 0:
 tcp_assign_congestion_control+0x2d3/0x310 net/ipv4/tcp_cong.c:-1
 tcp_ca_openreq_child+0x196/0x1d0 net/ipv4/tcp_minisocks.c:522
 tcp_v4_syn_recv_sock+0x4ce/0xa90 net/ipv4/tcp_ipv4.c:1760
 tcp_v6_syn_recv_sock+0xb1/0xe70 net/ipv6/tcp_ipv6.c:1340
 tcp_check_req+0xddd/0x1150 net/ipv4/tcp_minisocks.c:927
 tcp_v4_rcv+0xeda/0x1d90 net/ipv4/tcp_ipv4.c:2238
 ip_protocol_deliver_rcu+0x395/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish+0x194/0x1c0 net/ipv4/ip_input.c:453
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_rcv+0x62/0x160 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core net/core/dev.c:6149 [inline]
 __netif_receive_skb net/core/dev.c:6262 [inline]
 process_backlog+0x341/0x670 net/core/dev.c:6614
 __napi_poll+0x5f/0x310 net/core/dev.c:7678
 napi_poll net/core/dev.c:7741 [inline]
 net_rx_action+0x452/0x930 net/core/dev.c:7893
 handle_softirqs+0xb9/0x280 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x139a/0x1f20 net/core/dev.c:4856
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0x705/0x8c0 net/ipv4/ip_output.c:237
 __ip_finish_output net/ipv4/ip_output.c:-1 [inline]
 ip_finish_output+0x114/0x2a0 net/ipv4/ip_output.c:325
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0xbd/0x1c0 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:470 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 __ip_queue_xmit+0xbb0/0xbf0 net/ipv4/ip_output.c:534
 ip_queue_xmit+0x39/0x50 net/ipv4/ip_output.c:548
 __tcp_transmit_skb+0x1af2/0x1f10 net/ipv4/tcp_output.c:1693
 tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
 tcp_write_xmit+0x1597/0x3640 net/ipv4/tcp_output.c:3064
 __tcp_push_pending_frames+0x6d/0x1b0 net/ipv4/tcp_output.c:3247
 tcp_push_pending_frames include/net/tcp.h:2282 [inline]
 __tcp_sock_set_cork net/ipv4/tcp.c:3688 [inline]
 tcp_sock_set_cork+0xe1/0x100 net/ipv4/tcp.c:3695
 rds_tcp_xmit_path_complete+0x3b/0x50 net/rds/tcp_send.c:52
 rds_send_xmit+0x128c/0x16f0 net/rds/send.c:480
 rds_send_worker+0x44/0x1b0 net/rds/threads.c:200
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0x4cd/0x9d0 kernel/workqueue.c:3358
 worker_thread+0x581/0x770 kernel/workqueue.c:3439
 kthread+0x22a/0x280 kernel/kthread.c:467
 ret_from_fork+0x150/0x360 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffff888103ccb040 of 128 bytes by interrupt on cpu 1:
 tcp_v6_syn_recv_sock+0x103/0xe70 net/ipv6/tcp_ipv6.c:1353
 tcp_check_req+0xddd/0x1150 net/ipv4/tcp_minisocks.c:927
 tcp_v4_rcv+0xeda/0x1d90 net/ipv4/tcp_ipv4.c:2238
 ip_protocol_deliver_rcu+0x395/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish+0x194/0x1c0 net/ipv4/ip_input.c:453
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_rcv+0x62/0x160 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core net/core/dev.c:6149 [inline]
 __netif_receive_skb net/core/dev.c:6262 [inline]
 process_backlog+0x341/0x670 net/core/dev.c:6614
 __napi_poll+0x5f/0x310 net/core/dev.c:7678
 napi_poll net/core/dev.c:7741 [inline]
 net_rx_action+0x452/0x930 net/core/dev.c:7893
 handle_softirqs+0xb9/0x280 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x139a/0x1f20 net/core/dev.c:4856
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0x705/0x8c0 net/ipv4/ip_output.c:237
 __ip_finish_output net/ipv4/ip_output.c:-1 [inline]
 ip_finish_output+0x114/0x2a0 net/ipv4/ip_output.c:325
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0xbd/0x1c0 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:470 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 __ip_queue_xmit+0xbb0/0xbf0 net/ipv4/ip_output.c:534
 ip_queue_xmit+0x39/0x50 net/ipv4/ip_output.c:548
 __tcp_transmit_skb+0x1af2/0x1f10 net/ipv4/tcp_output.c:1693
 tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
 tcp_write_xmit+0x1597/0x3640 net/ipv4/tcp_output.c:3064
 __tcp_push_pending_frames+0x6d/0x1b0 net/ipv4/tcp_output.c:3247
 tcp_send_fin+0x58a/0x6a0 net/ipv4/tcp_output.c:3846
 __tcp_close+0x67d/0x1130 net/ipv4/tcp.c:3258
 tcp_close+0x28/0xd0 net/ipv4/tcp.c:3349
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 inet6_release+0x3e/0x60 net/ipv6/af_inet6.c:487
 __sock_release net/socket.c:662 [inline]
 sock_release+0x4b/0xe0 net/socket.c:690
 rds_tcp_accept_one+0x4a1/0x830 net/rds/tcp_listen.c:345
 rds_tcp_accept_worker+0x1a/0x60 net/rds/tcp.c:524
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0x4cd/0x9d0 kernel/workqueue.c:3358
 worker_thread+0x581/0x770 kernel/workqueue.c:3439
 kthread+0x22a/0x280 kernel/kthread.c:467
 ret_from_fork+0x150/0x360 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 1918 Comm: kworker/u8:5 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: krdsd rds_tcp_accept_worker
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

