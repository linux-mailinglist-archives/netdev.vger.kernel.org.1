Return-Path: <netdev+bounces-282947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK21GqaI82mS4wEAu9opvQ
	(envelope-from <netdev+bounces-282947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 504044A6068
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 320EA3055390
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625B3F9F22;
	Thu, 30 Apr 2026 16:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72F47276D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567354; cv=none; b=D9J9cEQeR8pXxFBnMJ2eMf8Ve+YqGtE26ks6aiWPf+pwU6M+nfZVtlCgeTAtvk8mmqueKVmuBnwZwPVaKLb2T2UEXQGj+xiFDgh7Yh31TiiVlt0TORHRZdypAhBMkaNBBuV0mG0bjhykxky1sm31Vp1ZmCwrIQJ3SnRappvZCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567354; c=relaxed/simple;
	bh=rfb+H5qZ2rKtzwKc6euaXaLazpvHhK9GYWqWgLYYd8s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SJ3SkrZpjULdrp+7IPw18nQvOGlphdgt+ccvXb5/OXWqV7eKsncnv0cJ2FzOSh9jb8I9TJ22vx/+EBxJqnT/TruzDM+Gl3GW/e2HB+IfjA8bzbN1zdvOZvt8uG6mkU+ouUVowRJQH60XoO7y8mBIqa/6mnysLhhLenyyZHAZ4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-696266291d6so1797391eaf.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567349; x=1778172149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/87TmCa3Z2FxwWDx4aZtt07eMNF7YEg9iirIvSv7caM=;
        b=PXSNjlaLOJARIc8iPlt14PBe/Dx4+Udl8FrGp3FWbrUnM/0Pj1Ibrzi50NMfC3PbDW
         zqzzaE1B4e3dvgcqQxztrdypoKiFsVXN5ErWYfGXrB53WYcaKWwGSwIHOlG31hz28YAn
         g7BqndxaOHGi3L7Zwg80YtNkbmNINLF1+0LHWr9SzIhdPS2vfC4S/8VusypQFUIbVLxw
         VZLCttbg/ZFK6346gYeDHcSCFy7T980+N7U97Zi9Urxf2fM5f1wOlmUzvf5PxPfASLz1
         HFATnkx06WBtUU8ClVual/VoHHLMkNiQEpl6Wfiz9CAYSR2iGFLG9amMjsLCV9TvOpmt
         rXaw==
X-Forwarded-Encrypted: i=1; AFNElJ+xK6M+fEhnZctV/nksyg5XSttCzuSpj0c7dsSN9Wf4TCjCpobr5auXsW+oMyQlpEw1JugvzXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37CXAaIzJonw+E0k5Jkuq4M39LVVCjTzfp3lwb8kIZpYpuVzy
	FqoI6MQq9lF1dICs+KslNhbPUvOamMhFUlYa4LwnE3Rggi6FpPtJk7GdgcTDmVlze+X/DU1GEoV
	vwHdp9t9pGG7pJAhodtefgupwddfRfOQKPRqBGnKTuhaBv8P/pW9ZjZTfHM4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2207:b0:696:1860:8baf with SMTP id
 006d021491bc7-6967a510993mr2004307eaf.20.1777567349578; Thu, 30 Apr 2026
 09:42:29 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:42:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f38675.050a0220.3cbe47.0002.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in igmp_rcv / igmp_rcv (2)
From: syzbot <syzbot+ae9a171f239b14485310@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 504044A6068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282947-lists,netdev=lfdr.de,ae9a171f239b14485310];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,googlegroups.com:email,goo.gl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

Hello,

syzbot found the following issue on:

HEAD commit:    2d1373e4246d Merge tag 'for-7.0-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1184a8da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=ae9a171f239b14485310
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2aee7aa6da1/disk-2d1373e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6cbfa1602880/vmlinux-2d1373e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52fe8db03e03/bzImage-2d1373e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae9a171f239b14485310@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in igmp_rcv / igmp_rcv

read to 0xffff88810a66f058 of 8 bytes by task 5213 on cpu 1:
 igmp_heard_query net/ipv4/igmp.c:1025 [inline]
 igmp_rcv+0x10af/0x1200 net/ipv4/igmp.c:1103
 ip_protocol_deliver_rcu+0x421/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish+0x188/0x1a0 net/ipv4/ip_input.c:453
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_rcv+0x62/0x160 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core net/core/dev.c:6164 [inline]
 __netif_receive_skb net/core/dev.c:6277 [inline]
 netif_receive_skb_internal net/core/dev.c:6363 [inline]
 netif_receive_skb+0x137/0x530 net/core/dev.c:6422
 tun_rx_batched+0x106/0x440 drivers/net/tun.c:1485
 tun_get_user+0x2011/0x27c0 drivers/net/tun.c:1953
 tun_chr_write_iter+0x15e/0x210 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x5a6/0x9f0 fs/read_write.c:688
 ksys_write+0xdc/0x1a0 fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:748
 x64_sys_call+0x27e1/0x3020 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88810a66f058 of 8 bytes by task 5212 on cpu 0:
 igmp_heard_query net/ipv4/igmp.c:1026 [inline]
 igmp_rcv+0x10eb/0x1200 net/ipv4/igmp.c:1103
 ip_protocol_deliver_rcu+0x421/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish+0x188/0x1a0 net/ipv4/ip_input.c:453
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_rcv+0x62/0x160 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core net/core/dev.c:6164 [inline]
 __netif_receive_skb net/core/dev.c:6277 [inline]
 netif_receive_skb_internal net/core/dev.c:6363 [inline]
 netif_receive_skb+0x137/0x530 net/core/dev.c:6422
 tun_rx_batched+0x106/0x440 drivers/net/tun.c:1485
 tun_get_user+0x2011/0x27c0 drivers/net/tun.c:1953
 tun_chr_write_iter+0x15e/0x210 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x5a6/0x9f0 fs/read_write.c:688
 ksys_write+0xdc/0x1a0 fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:748
 x64_sys_call+0x27e1/0x3020 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000000003e8 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 5212 Comm: syz.1.463 Not tainted syzkaller #0 PREEMPT(full) 
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

