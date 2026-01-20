Return-Path: <netdev+bounces-251535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFYUOMTFb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:13:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2A49346
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5679D9C49E6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE931AA83;
	Tue, 20 Jan 2026 16:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BA314A67
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925734; cv=none; b=ru+/a6Vr+YXiTRTQZ4qlGZaZzEFLmiPJMj1AYRuvJuMQIS3ZqL05/nMWFMP7DgtSkDrnz8DMB1lzMXdDzGTLh1rBVFD0PcRbCZYvyIjUs/G9k30KT/SmM8BrvWs74EepilzAYuCe03Ax8BP292jIfA3dl54+L2JaEfJE54aQDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925734; c=relaxed/simple;
	bh=Twa0jOFil5YiUIIWht/Y+QEC8GMD8rP/HD43jjr9t24=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LyOjCWCOJIAiOSZRk+tn1hQB+aZx+fa44mhy24MknCMFROM5oXUgvGwT0liisJqj6b+1Un7uGJng73UCdtkVFjLzP+rLGae9QtZVzPKi6HzXUqEYPifIrVZw+GLWCrSvcZFHknmF5c0ZDA2fvx55Hqlqb7/GY/eUZ89DUei8/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4081db82094so4000998fac.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925732; x=1769530532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZufEKCYQ3g1YhCFtyBBjkiGEIMWxhwcBQ1yp8jpI5wg=;
        b=b+2DAGzoVR8huVuuy3106PtYYncJHYoZkd703uwq7RT4xhUe822HfOT517Mke1lIFG
         n4RVo8oPn6Qh2orUTF0T5Jg5ybZPJb5XzbA3pFmGelClOy2PfGzFmiUbWRnw+SDwjL42
         KuEofY2HnWKGajpXxmrV+3PVpYgiPvTLsAiJcOAFeh+D8VYlt1qITK8HUK6CIcTo8teT
         ajLdC/Do2MSwoKGQLkhQQv2a+YYa68+A4xeDW+NSCptYq4cXyw9GciYeUqnRI1zzskg8
         SKJ890SF4CFTsQbOy9IXAVMlim9h9mghYobKzURSYEPO/ke7QaAQHb6goPHNUIeSgzIY
         M7PA==
X-Forwarded-Encrypted: i=1; AJvYcCUIQTHkEGnTJpmhSv+nsbJc9uIKyYRg+C6KaAExkYl/DlSAa2j5P4bW2GSLWvkYfi8yTeNQOp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8Vne0iGj9FiZ9Ilnn7gtlWCvz8ZFXOBgx7FmidzgqgwyYZe8
	2pw5L/W0b9A50kAMNI5TxCGMX6u7Y2gZV9ck2mat53U/6B7ID4pLO+6Jo2hLS2G3gPVmZTBI12x
	vXdFiYFpw87FqlJZ9xQW5OR+UT1mZGROdXO2xsKEYCByzgzI/IZ1gEPznGNM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e901:0:b0:660:ffa9:c3fc with SMTP id
 006d021491bc7-66117a09263mr6325955eaf.66.1768925731909; Tue, 20 Jan 2026
 08:15:31 -0800 (PST)
Date: Tue, 20 Jan 2026 08:15:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696faa23.050a0220.4cb9c.001f.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __skb_flow_dissect (7)
From: syzbot <syzbot+c46409299c70a221415e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a94030c847137a18];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-251535-lists,netdev=lfdr.de,c46409299c70a221415e];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 55D2A49346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    dfdf77465620 net: airoha: Fix typo in airoha_ppe_setup_tc_..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=159d4052580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=c46409299c70a221415e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f2960b575f2/disk-dfdf7746.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b48823d17c0/vmlinux-dfdf7746.xz
kernel image: https://storage.googleapis.com/syzbot-assets/852fefdd1d14/bzImage-dfdf7746.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c46409299c70a221415e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131, CPU#1: syz.2.1418/11053
Modules linked in:
CPU: 1 UID: 0 PID: 11053 Comm: syz.2.1418 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131
Code: 55 00 00 80 3d 94 c5 36 06 01 0f 85 b3 55 00 00 e8 be 8d 8b f8 e9 83 f9 ff ff e8 b4 8d 8b f8 e9 b0 03 00 00 e8 aa 8d 8b f8 90 <0f> 0b 90 e9 16 ff ff ff e8 9c 8d 8b f8 c6 05 5d c5 36 06 01 48 c7
RSP: 0000:ffffc900033a7100 EFLAGS: 00010287
RAX: ffffffff8935c70e RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9000d75c000 RSI: 0000000000000539 RDI: 000000000000053a
RBP: ffffc900033a7718 R08: ffffffff893562c8 R09: ffffffff8df41aa0
R10: ffffc900033a77a0 R11: fffff52000674efe R12: dffffc0000000000
R13: ffffffff893562c8 R14: 0000000000000000 R15: ffffffff8f825fd0
FS:  00007fea4dbe96c0(0000) GS:ffff888125f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c38c723 CR3: 00000000294c6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bond_flow_dissect drivers/net/bonding/bond_main.c:4093 [inline]
 __bond_xmit_hash+0x2d7/0xba0 drivers/net/bonding/bond_main.c:4157
 bond_xmit_hash_xdp drivers/net/bonding/bond_main.c:4208 [inline]
 bond_xdp_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5139 [inline]
 bond_xdp_get_xmit_slave+0x1fd/0x710 drivers/net/bonding/bond_main.c:5515
 xdp_master_redirect+0x13f/0x2c0 net/core/filter.c:4388
 bpf_prog_run_xdp include/net/xdp.h:700 [inline]
 bpf_test_run+0x6b2/0x7d0 net/bpf/test_run.c:421
 bpf_prog_test_run_xdp+0x795/0x10e0 net/bpf/test_run.c:1390
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea4cd8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea4dbe9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fea4cfe5fa0 RCX: 00007fea4cd8f749
RDX: 0000000000000059 RSI: 0000200000000600 RDI: 000000000000000a
RBP: 00007fea4ce13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fea4cfe6038 R14: 00007fea4cfe5fa0 R15: 00007ffdb8efbed8
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

