Return-Path: <netdev+bounces-288757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IwxNsryCWomvgQAu9opvQ
	(envelope-from <netdev+bounces-288757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6A56252D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA523009153
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457D3BFAD4;
	Sun, 17 May 2026 16:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144B3093D8
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036871; cv=none; b=EvqaOAAckcueIQbZKWvtN7rTJPTfddGDXz9YO75RH60oxoWu3cz/6mvXNvEgOk+BJgbWJEfO0duvMYcTNcML1JOtLewDdOLkPnGHi5w3ddRVeWpOoKKsKg7vLBcrVkLXJyRhIWOyR/ex4mCH6zNhVyy0R7fpX4SefMoLrssqbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036871; c=relaxed/simple;
	bh=jVYdJ2YR7wwFJLXVnIkfww5Ht4D7Q3mRuWi5Jd02qxY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rL6rk+gvgaHeCNM1EEGlU54lrPm6eH/xYYY75HPcqJrkW24LdZbMe6keFQ3vazmgZK+LqmZt++/z4fdNcF3asPVVRC0LgCbHKitCUv0XZBOVlizQXhPsSh3scfEBCfiP6DsyhKui84Mz3dbVrxar4tys25v4m25CoU6VyRY9YTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-694867ca29cso3197137eaf.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 09:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779036869; x=1779641669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZSa+hOfI58ShZeSB0IuNkHDCTNfPm7kuEkT4xulFx4=;
        b=rAao9lHtjjUzkntoD/mYolGWxGFTQZ/T0h1iza0I/Pe8PfhiRT17pbSZZK8wMl1HwD
         TNKfb+WirO4T5QKDJH1m1YHJVshUtXVLdOvwP95i3/rPE/IENDKsq31gR2A2DOyCXw/b
         xUlrwIFJ1qCUuA7Zio0mRDm5cydUu/JIX91Sj5PiCvzkg5mwt1j4+hPSmTiVJFuc/Rps
         eHsLhYrFUr9Z0BWzYMayVX3RPAqS5Xu0tuSyTnylzyuqd3mTl5oeL+fFUvpBVpXhgV1D
         6zK2WD/UYtx1py3O+0Y2iSdaBEjjkF09YM09Cyi6I54kwdxtiyye84waTY7NhJtTk41j
         X7Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9zIvYo3XHtJLDNlvC4FzLXmDo+NdhjbF7Pi0H/EkD2WpU7Xnahp4pJNOS9Eia8SdAa9aW2utc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlWzX9F+UJEhV+gey5BsJZb10Ig8Bmv6VEfv/sUPUyf4AucN/
	ZqrzCbrxedGWHYW86UGRz02mozdIdv3cnTZZIyVOcQ4U5DpnyRSWVEGPJMjaN2CgwMeQS9DEmCU
	uF1MG6uBPo76YlrU7OUQg7Izd0i974dZuWE9jiIFQ6vs+FfLECtz/lDBU/a8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b02:b0:694:a362:e3b0 with SMTP id
 006d021491bc7-69c9bfc7ef8mr7434029eaf.49.1779036868732; Sun, 17 May 2026
 09:54:28 -0700 (PDT)
Date: Sun, 17 May 2026 09:54:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a09f2c4.a00a0220.300e5b.000a.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in arp_create (4)
From: syzbot <syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 34A6A56252D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-288757-lists,netdev=lfdr.de,9fdcc9f05a98a540b816];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    70eda68668d1 Merge tag 'hid-for-linus-2026051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f56e36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f3c10169d74/disk-70eda686.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67977be60189/vmlinux-70eda686.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf642084f321/bzImage-70eda686.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000016: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
CPU: 1 UID: 0 PID: 37 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:arp_create+0xb1/0x980 net/ipv4/arp.c:554
Code: 89 4c 24 78 4a 89 04 21 e8 8c f7 a0 f7 44 89 b4 24 a0 00 00 00 89 9c 24 b0 00 00 00 49 8d bf b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 9f b4 00 00 00 49
RSP: 0018:ffffc90000ad7720 EFLAGS: 00010213
RAX: 0000000000000016 RBX: 0000000000000000 RCX: ffff8880202edc40
RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
RBP: ffffc90000ad7840 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200015af20 R12: dffffc0000000000
R13: ffff88806501d0a0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812538a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000032000 CR3: 0000000022ee7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 batadv_bla_send_claim+0x183/0xeb0 net/batman-adv/bridge_loop_avoidance.c:361
 batadv_bla_send_loopdetect net/batman-adv/bridge_loop_avoidance.c:1402 [inline]
 batadv_bla_periodic_work+0x654/0xae0 net/batman-adv/bridge_loop_avoidance.c:1492
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arp_create+0xb1/0x980 net/ipv4/arp.c:554
Code: 89 4c 24 78 4a 89 04 21 e8 8c f7 a0 f7 44 89 b4 24 a0 00 00 00 89 9c 24 b0 00 00 00 49 8d bf b4 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 9f b4 00 00 00 49
RSP: 0018:ffffc90000ad7720 EFLAGS: 00010213
RAX: 0000000000000016 RBX: 0000000000000000 RCX: ffff8880202edc40
RDX: 0000000000000000 RSI: 0000000000000806 RDI: 00000000000000b4
RBP: ffffc90000ad7840 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200015af20 R12: dffffc0000000000
R13: ffff88806501d0a0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812538a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000032000 CR3: 0000000022ee7000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
   4:	4a 89 04 21          	mov    %rax,(%rcx,%r12,1)
   8:	e8 8c f7 a0 f7       	call   0xf7a0f799
   d:	44 89 b4 24 a0 00 00 	mov    %r14d,0xa0(%rsp)
  14:	00
  15:	89 9c 24 b0 00 00 00 	mov    %ebx,0xb0(%rsp)
  1c:	49 8d bf b4 00 00 00 	lea    0xb4(%r15),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 15 06 00 00    	jne    0x64c
  37:	41 0f b7 9f b4 00 00 	movzwl 0xb4(%r15),%ebx
  3e:	00
  3f:	49                   	rex.WB


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

