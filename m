Return-Path: <netdev+bounces-293793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIeGFViYHWoXcgkAu9opvQ
	(envelope-from <netdev+bounces-293793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D263D620EE6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D4330010D3
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDB3BED4A;
	Mon,  1 Jun 2026 14:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F613B992A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324413; cv=none; b=hZ8PxojtzKSRXC0MyuZbR0RIcTVtBts/rMQZnsEpY6pk8aagMHvxL1/qk5+MLZivRlnd8wjrMZVvNpvhOs6j+BlmTBVhJurFJzRdQdiz6ojnEzmLaC2Maut/kkokeV8KZzXvW0o+s94dFljLwBx7HUwCdltIz6pCPr1DWd2HwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324413; c=relaxed/simple;
	bh=DpkCpyfUrTRzVZd5xSSei1KOk0n4OQiAm6cbXvbv+Vo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KeCLfyg5nhVJOjtL9891Iqll9n3UP7sHyyue6URudTh5cD4B2cShrsdafN2WXDgK1jXfyfAvf/JPe9/teZQvHxIGFQqOA2KYNJJmfrZ4I0zDCqm69iv4VGU4SM0ri7Y76UGYIIkPSwwXHaPfED7rXjBfvkQgYvNS26Y5qpODGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-69d92a86e3bso10740689eaf.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 07:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324411; x=1780929211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EPzY9y+i2FcltGH4jmZUHKU6LHLG85QdDxKqek6CXU=;
        b=sjdpNpnKWpb+yyDLHGZ5irb5ZISZVePMsXFmiLu6rl4T2rimIaMAfdt6Xu2vbVKxko
         LC8Shgni9nsbunwI/ziEC0nAdm++qgklreOIxoRkxRPwSeDLMrvnc3RhrdBGBaqE/N+X
         b4r/4IaMZTfA5NJKc6VzBo4Jfjb8cwl5XxecULsHaDpmrmQJJ91kgJITnLbjs05mVfEK
         IdE0QCDUIEvqG4xJ8tBp13/yzgJ7wARVRrepckWXO3FChkhpBZrmrU4dUlnCHEpaN/yr
         qDAXm4DwNK/mQ0Ah/x+g0w9TDZLAEnBA3NKz//4g/72KKmJxkDM7kHXi4b6A24/uDMHZ
         tr1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+JVragysatgn6WwoRdQiG/Aw3ZJWzIK1czOBWqNhH6BGUofCFO63KvogZiS7AtnwnlUXPQPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Xe5oQ/Nr693OnYyQ7IwUaFv8uIGPIUO5ZZElC2yaCZRqpwyE
	qRb/8xY/DqiXEdcR8dZEQgKSq/JnBzqMlhPStgvkLkqu91V7Inj3efSQQVUq08BODRtZWaUqvNi
	tjMePgewdXlommBvf5aE2Pp84nmY4QHXxEnDOV1RY0ogpbocOHaMHrF0gyaw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e915:0:b0:685:3561:8926 with SMTP id
 006d021491bc7-69e103afeb8mr5574685eaf.45.1780324411350; Mon, 01 Jun 2026
 07:33:31 -0700 (PDT)
Date: Mon, 01 Jun 2026 07:33:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1d983b.b111c304.35cd64.0028.GAE@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_socket_send_skb_to_peer
 / wg_socket_send_skb_to_peer (9)
From: syzbot <syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f571f22917457cd8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-293793-lists,netdev=lfdr.de,9ca7674fa7521a3f1bc2];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,goo.gl:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: D263D620EE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    9215e74f228f Merge tag 'block-7.1-20260529' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10465ef2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f571f22917457cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca7674fa7521a3f1bc2
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ddf3069118d/disk-9215e74f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0913e4ffbdb8/vmlinux-9215e74f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fe3943ae796/bzImage-9215e74f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_socket_send_skb_to_peer / wg_socket_send_skb_to_peer

read-write to 0xffff88811af99028 of 8 bytes by task 310 on cpu 1:
 wg_socket_send_skb_to_peer+0xe8/0x130 drivers/net/wireguard/socket.c:182
 wg_socket_send_buffer_to_peer+0xf1/0x120 drivers/net/wireguard/socket.c:199
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x10d/0x160 drivers/net/wireguard/send.c:51
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3397
 worker_thread+0x58a/0x780 kernel/workqueue.c:3478
 kthread+0x22a/0x280 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read-write to 0xffff88811af99028 of 8 bytes by task 15360 on cpu 0:
 wg_socket_send_skb_to_peer+0xe8/0x130 drivers/net/wireguard/socket.c:182
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x12d/0x330 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3397
 worker_thread+0x58a/0x780 kernel/workqueue.c:3478
 kthread+0x22a/0x280 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

value changed: 0x0000000000000a2c -> 0x0000000000000ac0

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 15360 Comm: kworker/0:2 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: wg-crypt-wg2 wg_packet_tx_worker
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

