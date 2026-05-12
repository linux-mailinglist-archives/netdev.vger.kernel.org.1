Return-Path: <netdev+bounces-286965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPgwEYfHAmqWwgEAu9opvQ
	(envelope-from <netdev+bounces-286965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:24:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8E51AEDF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98693044B9A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4946AF3C;
	Tue, 12 May 2026 06:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C6421A0F
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566748; cv=none; b=TnmaxxH+JHleeMH7ttzTYJDgleF1irg2zhGcpdDyIb7kNsOgj6ot1BLWopCM0JelYgF0/i8VW4O0xxskMLuwFsvvX4gn0jQZiXdyjq4IwTS/4GVDe6qFRoCZaXiV7w2EGgh8aKZREShr6PzjBtSrxJb18ShfOwMlPaY+/HfByTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566748; c=relaxed/simple;
	bh=A9cySep/CEG1X39ZMIB/dkxmsRq8AU52nK52aNjusRQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WM/UEjiAnGEf+IC2KckF1KEGeS7O4llx2xrwcV3rudQk/419O2vKq01SF+WiZwKDM/Iq26ChH4ccpor420sebQbeLfMQ6ltlM8gcJZf9Ff6Gm3I69iKAxKDDZ55dxNIWHjqCSCOOx/wWwtVhaa1Yet0B88/LgwOo2DQtmJAwc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69649771a5aso9536458eaf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566732; x=1779171532;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Quvp48/YwD/viN8Bdy5pN7ImHZzsvCGWxopU74+qfq4=;
        b=MzIEV6o9jr0bO6JWWDtwPsKA9F6nKHsxzUrHjk9jMTv+o2CsThTK35ahZs32JzrjAS
         u4i+FvCrwyjonCVgo5mLCiIrtXsMw0F1uon1MPBUAQhPbXqqWDxhcrqsbUhsC4D4Q55j
         ZIxce4ULZ9lbDxS6PGYKUd+gjRepVlwlfAr8SgBdD25rRi0erSP7MfPFeXEmEXm/Ra++
         zH6RrPcHSD6zcsMxWdwaAjdLnIH7SdrcK48rSO3f7UBCz1Gsi+RqhG0vPpF6CsNo6p2J
         eodx8IwYLE02WVau1k1bLDzkc6LFj+Gw9LsN0kyniTX5FjLZ7LitwPmfdTghQes/m7hc
         rbkw==
X-Forwarded-Encrypted: i=1; AFNElJ91zsmezd3R0rvTzZ6/BFAUqyuVvkT5RO+NL0XUKVHG6mgn6ynmnd7uHSC2SlQUwh4SABQCQJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3e/h6TsXzVG4un/SpSgSeIiKM0ypaxzb9bDYcezdGXHNnTCQ
	Al/9G3IwMs3v+125Q3T3tTkZhjLUUHkzNu2DLkYH6KFYwHU4MN8YZmbMb88rBfSanO9d9gJs5NR
	9IWIcKOv8EnR9hCTNC6wD/DcXmXzolMezYTCplBo0zaNuVExwWCHTVm/CZRE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:151e:b0:694:8d83:a344 with SMTP id
 006d021491bc7-69998ca2d42mr15168311eaf.16.1778566731871; Mon, 11 May 2026
 23:18:51 -0700 (PDT)
Date: Mon, 11 May 2026 23:18:51 -0700
In-Reply-To: <20260511151559.1916614-1-edumazet@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a02c64b.050a0220.14e4b1.0006.GAE@google.com>
Subject: [syzbot ci] Re: tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
From: syzbot ci <syzbot+cic9c132a1582cb710@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8EA8E51AEDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-286965-lists,netdev=lfdr.de,cic9c132a1582cb710];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.875];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
https://lore.kernel.org/all/20260511151559.1916614-1-edumazet@google.com
* [PATCH net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

and found the following issues:
* BUG: using __this_cpu_write() in preemptible code in tcp_v4_do_rcv
* BUG: using __this_cpu_write() in preemptible code in tcp_v6_do_rcv

Full report is available here:
https://ci.syzbot.org/series/45073ca6-4b5b-4cbd-83bf-ae30c470d334

***

BUG: using __this_cpu_write() in preemptible code in tcp_v4_do_rcv

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      a450063ef86b9967234ca1f896c0d77400c74f11
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/d6bfac50-400c-447d-b4f2-f5caa36c16ac/config
syz repro: https://ci.syzbot.org/findings/95b64202-6cf3-4356-94bc-753dbd8443c4/syz_repro

BUG: using __this_cpu_write() in preemptible [00000000] code: syz.0.17/5875
caller is tcp_v4_do_rcv+0xb4a/0x13e0 net/ipv4/tcp_ipv4.c:1881
CPU: 0 UID: 0 PID: 5875 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 tcp_v4_do_rcv+0xb4a/0x13e0 net/ipv4/tcp_ipv4.c:1881
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x265/0x3a0 net/core/sock.c:3216
 release_sock+0x190/0x260 net/core/sock.c:3815
 mptcp_pm_rm_addr_or_subflow+0x472/0x9d0 net/mptcp/pm.c:789
 mptcp_nl_remove_id_zero_address net/mptcp/pm_kernel.c:1140 [inline]
 mptcp_pm_nl_del_addr_doit+0x503/0x1430 net/mptcp/pm_kernel.c:1176
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6847f9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6848e95028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6848215fa0 RCX: 00007f6847f9cdd9
RDX: 0000000024000800 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f6848032d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6848216038 R14: 00007f6848215fa0 R15: 00007ffe50763178
 </TASK>


***

BUG: using __this_cpu_write() in preemptible code in tcp_v6_do_rcv

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      a450063ef86b9967234ca1f896c0d77400c74f11
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/d6bfac50-400c-447d-b4f2-f5caa36c16ac/config
syz repro: https://ci.syzbot.org/findings/f5960777-902c-46ad-b811-9dff0f17d320/syz_repro

BUG: using __this_cpu_write() in preemptible [00000000] code: syz.0.173/6173
caller is tcp_v6_do_rcv+0x10c2/0x1ca0 net/ipv6/tcp_ipv6.c:1644
CPU: 0 UID: 0 PID: 6173 Comm: syz.0.173 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 tcp_v6_do_rcv+0x10c2/0x1ca0 net/ipv6/tcp_ipv6.c:1644
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x1b8/0x3a0 net/core/sock.c:3216
 __tcp_close+0x832/0xfe0 net/ipv4/tcp.c:3238
 __mptcp_close_ssk+0x52d/0x1180 net/mptcp/protocol.c:2604
 mptcp_destroy_common+0x15c/0x330 net/mptcp/protocol.c:3408
 mptcp_destroy+0x82/0x120 net/mptcp/protocol.c:3616
 __mptcp_destroy_sock+0x156/0x370 net/mptcp/protocol.c:3250
 __mptcp_close+0x8f6/0xd10 net/mptcp/protocol.c:3352
 mptcp_close+0x28/0x1a0 net/mptcp/protocol.c:3367
 inet_release+0x143/0x190 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xc3/0x240 net/socket.c:1514
 __fput+0x44f/0xa60 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f69be79cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7668ad18 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffc7668ae00 RCX: 00007f69be79cdd9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000012dd1 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b32b20000 R11: 0000000000000246 R12: 00007ffc7668ae40
R13: 00007f69bea15fac R14: 0000000000012e0a R15: 00007f69bea15fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

