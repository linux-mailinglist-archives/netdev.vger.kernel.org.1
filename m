Return-Path: <netdev+bounces-289596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA01ClfCDGqJlgUAu9opvQ
	(envelope-from <netdev+bounces-289596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:04:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7F58474B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D46308A365
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C943B95E3;
	Tue, 19 May 2026 20:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5253B776A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220844; cv=none; b=DG1eP2vGup/pNNs3ggVV9LMe0UuEATZ2hsXXrVypwobKjE2ui8sjaiL9h//3uIoZkmpabPvIjnRYa2iwBI3O5NYeUuoqIlKI0/Ml6UmkmUr60AlL2gfXue6/hpiK7ZAwqBkYxvf/MPxZUTvuTqyKrmRMIBB+G7YM+eQOWM0EbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220844; c=relaxed/simple;
	bh=4MHwwNanuqgJNc3I6/HWUg8CDm0jyU7ClfTaDLB1YBk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=csF0YtQpNK127Meeiz6/DBTFIz7Uc2EYjFXuKKBIz4EWrkv44fmXbp3oaK+wAEmOj3y9gowK4+ial8QT35yl2W6tphS03XKfFioEuD9c8zT14XCwhTTA17O1q1HOsVrNb6HYPk/RYo4gPweUv5pEnKnSDKQv8gBhBVfxl+UxSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69b90f1a51fso9156235eaf.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220841; x=1779825641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOJpY3mFwz7JP+JSDBqnmJgbG6krrfI8VErveIOJXqc=;
        b=n8VoxVqwCypEfVCJBI6eMHw+yejQ7wzvd4t1Fdg4m1VZWOB6/NZ1DydRWZ9HgmbdwA
         +qcjCyjiQdys0xayW2T3CXMZB/G7S++teTWLECZbPHW8+/Ff1ySctT0cQm1iyJKrwdJe
         j+OH+1SiV5Ulj9toVLwY8SolK9cKdnMjRpO1SMuytRuSm+zBX6ejTGllO9xz3G3orsi1
         1iwoxQiEHvwSZN/DPV20LfPnlb3l78IOD++SmSQ/y6/zHiV9kYyIBFrIa6UzWq07rZph
         /KlLDBBOjFrsvKPZC7yf0sX8pQ+22v2zyJzQtasFdqxi4XcztmYNMdHToQ2XVIc1+eKx
         VTUA==
X-Forwarded-Encrypted: i=1; AFNElJ9doyvD2vUWoRLPJ0oLG8y5ors2yqFZtSVagIk2kdYAj9NccTeJxWPH1UGbR0e9O2ZdYyqcZeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+y/6pb/NCKBeWi50Z1+KUab93rHFcRdFn0Yz2VDb6dBoQRQvm
	cR/fP2L6vLmjq44MRNiw1o72qWZa0ZbUlDjFXEnGkFpeeoJT4WSgvW4mybioqI9cbUHdUMio7t7
	gm/19hPl56wDNLt0VGrT2wf03W8JVbItlx6C+oWLuYoYl/NACjz1dgL7+ZwI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2982:b0:67e:160c:36ba with SMTP id
 006d021491bc7-69c9bfb1664mr12975942eaf.48.1779220841719; Tue, 19 May 2026
 13:00:41 -0700 (PDT)
Date: Tue, 19 May 2026 13:00:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0cc169.170a0220.1f6c2d.0004.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ip_rt_bug (3)
From: syzbot <syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-289596-lists,netdev=lfdr.de,c13a57c2639c2c0d03a6];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 7AC7F58474B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    fcee7d82f27d Merge tag 'net-7.1-rc3' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=139c40ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=c13a57c2639c2c0d03a6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d3e56a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1177bb26580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b61ce97ed88/disk-fcee7d82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3d680659d25/vmlinux-fcee7d82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16070336dc25/bzImage-fcee7d82.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/ipv4/route.c:1275 at ip_rt_bug+0x2d/0x140 net/ipv4/route.c:1275, CPU#1: syz.0.17/5858
Modules linked in:
CPU: 1 UID: 0 PID: 5858 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:ip_rt_bug+0x2d/0x140 net/ipv4/route.c:1275
Code: fa 55 41 57 41 56 41 55 41 54 53 48 89 d3 e8 0a fb b8 f7 66 90 e8 03 fb b8 f7 31 ff 48 89 de ba 02 00 00 00 e8 84 81 68 ff 90 <0f> 0b 90 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d e9 0f d3 9e 01 cc 49
RSP: 0018:ffffc900032ef1c0 EFLAGS: 00010286
RAX: f1fcc608b0941b00 RBX: ffff8880750b3000 RCX: 0000000080000401
RDX: 0000000000000002 RSI: ffffffff8dfa6610 RDI: ffffffff8c28ade0
RBP: ffffc900032ef4c0 R08: ffffffff9030adf7 R09: 1ffffffff20615be
R10: dffffc0000000000 R11: fffffbfff20615bf R12: dffffc0000000000
R13: 0000000000000000 R14: ffff8880750b3000 R15: dffffc0000000000
FS:  0000555579ced500(0000) GS:ffff88812538d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd90672700 CR3: 0000000072438000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ip_send_skb net/ipv4/ip_output.c:1510 [inline]
 ip_push_pending_frames+0x8b/0x110 net/ipv4/ip_output.c:1530
 __icmp_send+0x11e4/0x1690 net/ipv4/icmp.c:1000
 icmp_send include/net/icmp.h:43 [inline]
 ip_options_compile+0x80/0xb0 net/ipv4/ip_options.c:473
 ip_rcv_options net/ipv4/ip_input.c:290 [inline]
 ip_rcv_finish_core+0xaa2/0x1c00 net/ipv4/ip_input.c:430
 ip_rcv_finish+0x14c/0x2a0 net/ipv4/ip_input.c:490
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6202 [inline]
 __netif_receive_skb net/core/dev.c:6315 [inline]
 netif_receive_skb_internal net/core/dev.c:6401 [inline]
 netif_receive_skb+0x45b/0xbf0 net/core/dev.c:6460
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1487
 tun_get_user+0x2bbc/0x43e0 drivers/net/tun.c:1955
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd9075d60e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007ffcba496af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555579ced500 RCX: 00007fbd9075d60e
RDX: 0000000000000046 RSI: 0000200000000400 RDI: 00000000000000c8
RBP: 00007fbd90832d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd90a15fac R14: 00007fbd90a15fa0 R15: 00007fbd90a15fa0
 </TASK>


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

