Return-Path: <netdev+bounces-301557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Fz6DlCFO2qwZAgAu9opvQ
	(envelope-from <netdev+bounces-301557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:20:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C31A6BC1C5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301557-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301557-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF2730234FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA29739A7EA;
	Wed, 24 Jun 2026 07:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C8390CAB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285634; cv=none; b=h7T/iTQHkXFJqj7AdBrQTz2XwK5xlxLcqGzHhiIW07l22NI51MGSNIaBFoJft5UwjnjT0RTnOe5qZOUVGwh1WtILkLbgDlt9qAgIKtZ8GaRlPHZFLrCPKKfLHMxQs540/iACL0YQ/ORlhEqQr7Zf/UxEgrayX0+d8t4fJBOWyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285634; c=relaxed/simple;
	bh=/mXRt1KgB2yMYu4eVE5/zbBtVw4HiXvrXoJ6kF5tXWo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GbRCSnL3z6sMgKbtvp+wMcWl37xb5CT8+dSnebA9zj/ZyeNQHcBinbHk73dLSplToq1Vvaz+B8D5s0oLTQSks6PwQp/ipgpzPPgBPdCO8tClgTA6uBmp/i6qjwq9dkAEKvRVQpCfAGpzcdcdqyqQjeTW2RRgoWltOMOGylLApU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-486a2231742so1057451b6e.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285628; x=1782890428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efjZMiDv/qOd8uxrTrxuiqmStDg8HEmf+X6Ut6FB9Io=;
        b=iMclIFo5qS+LTlwYLGpglyOererTgAWqoDI2tnVQG03wcm83nYN60Wk5XRmyaG6Ukx
         rrB+WBz+H1RKFH670MChbOc7e43IrHxdKEU82w9AS5m0gIxF8J/mMWnfrA+SyoeED39r
         gi31jDGPDI/atrr6gpUhR5GwwEW390vrtMP7xS5dUuVHR6z9c/EzelhOWzXDsjWCA9gX
         DJfVwWUBYC5SAVbtunqAiL3Hmc3aGU3aS/ObDQArXF4AQEwBlwMZTL/P1lNA52dwhK8x
         bUMOcJQfzaCz+l+wWXzud7inFrSJmCxOU5SrmHRPvU2MPVDDXWQjh+yhFxVvBlj31OGQ
         w9kg==
X-Forwarded-Encrypted: i=1; AFNElJ+QZeSj4Zs7xl94rH9R5iX7d2mNwkHYXfoqdNH9mSkSpqocSs18EC4fdlMe3T6toq/idZw4RQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlPPMTsszn39KlrQVpRwnPF32LzFUn/YwV5WjD4jdIZYfKr7p
	eqmdnh8FMOfNKizT2gHnJzJTGG2DZSA+7hRTQXFkImrRh3cUlDh8Ne1A5IuVea4e5Mf8EOu/5AI
	WMy2zrh311LF2fILzv9ouoFDceXe7uj7HrjxyEoM/un5BWEiONh6yN1LDXNM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a0e:b0:48a:b0cb:6589 with SMTP id
 5614622812f47-48ee2f56a73mr4407274b6e.13.1782285627826; Wed, 24 Jun 2026
 00:20:27 -0700 (PDT)
Date: Wed, 24 Jun 2026 00:20:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3b853b.52ae72c2.136ac7.000c.GAE@google.com>
Subject: [syzbot] [net?] WARNING in qdisc_pkt_len_segs_init
From: syzbot <syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301557-lists,netdev=lfdr.de,d5d0d598a4cfdfafdc3b];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,vger.kernel.org:from_smtp,syzkaller.appspotmail.com:from_mime,goo.gl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,googlegroups.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C31A6BC1C5

Hello,

syzbot found the following issue on:

HEAD commit:    9c87e61e3c57 Merge tag 'bpf-next-7.2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d2901c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=d5d0d598a4cfdfafdc3b
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5489ff1c0660/disk-9c87e61e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcdabd5a8fea/vmlinux-9c87e61e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa77e3b769c6/bzImage-9c87e61e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com

------------[ cut here ]------------
len > ((int)(~0U >> 1))
WARNING: ./include/linux/skbuff.h:2866 at pskb_may_pull_reason include/linux/skbuff.h:2866 [inline], CPU#0: syz.0.5520/24128
WARNING: ./include/linux/skbuff.h:2866 at pskb_may_pull include/linux/skbuff.h:2884 [inline], CPU#0: syz.0.5520/24128
WARNING: ./include/linux/skbuff.h:2866 at qdisc_pkt_len_segs_init+0x4b4/0xa30 net/core/dev.c:4138, CPU#0: syz.0.5520/24128
Modules linked in:
CPU: 0 UID: 0 PID: 24128 Comm: syz.0.5520 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2866 [inline]
RIP: 0010:pskb_may_pull include/linux/skbuff.h:2884 [inline]
RIP: 0010:qdisc_pkt_len_segs_init+0x4b4/0xa30 net/core/dev.c:4138
Code: 00 00 02 00 31 ff e8 1b 3d 49 f8 81 e3 00 00 02 00 0f 85 fd 00 00 00 e8 ca 38 49 f8 45 89 e7 e9 2c ff ff ff e8 bd 38 49 f8 90 <0f> 0b 90 e9 ee fd ff ff 44 89 e7 89 de e8 6a 3a 49 f8 41 39 dc 0f
RSP: 0018:ffffc90000007660 EFLAGS: 00010246
RAX: ffffffff897ccc53 RBX: 0000000000000003 RCX: ffff8880761b8000
RDX: 0000000000000100 RSI: 00000000fffffffa RDI: 0000000000000000
RBP: ffff888034a70b40 R08: ffff88807bd48067 R09: 1ffff1100f7a900c
R10: dffffc0000000000 R11: ffffed100f7a900d R12: 00000000fffffffa
R13: dffffc0000000000 R14: 1ffff1100694e183 R15: ffff888068a29b98
FS:  00007f26d46806c0(0000) GS:ffff888125272000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 00000000894be000 CR4: 00000000003526f0
DR0: 0000000000000006 DR1: 0000000000000000 DR2: 000000007fffdff5
DR3: 0000800000000005 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 sch_handle_ingress net/core/dev.c:4479 [inline]
 __netif_receive_skb_core+0x13aa/0x30b0 net/core/dev.c:6057
 __netif_receive_skb_list_core+0x24d/0x830 net/core/dev.c:6281
 __netif_receive_skb_list net/core/dev.c:6348 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6439
 gro_normal_list include/net/gro.h:523 [inline]
 gro_flush_normal include/net/gro.h:531 [inline]
 napi_complete_done+0x299/0x730 net/core/dev.c:6807
 gro_cell_poll+0x5ab/0x5d0 net/core/gro_cells.c:74
 __napi_poll+0xaa/0x330 net/core/dev.c:7729
 napi_poll net/core/dev.c:7792 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7949
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_rx_batched+0x616/0x790 drivers/net/tun.c:-1
 tun_get_user+0x2b04/0x4350 drivers/net/tun.c:1986
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2032
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26d379ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26d4680028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f26d3a15fa0 RCX: 00007f26d379ce59
RDX: 000000000000fdef RSI: 00002000000002c0 RDI: 000000000000000a
RBP: 00007f26d3832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f26d3a16038 R14: 00007f26d3a15fa0 R15: 00007f26d3b3fa48
 </TASK>


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

