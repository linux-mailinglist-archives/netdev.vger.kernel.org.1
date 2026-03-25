Return-Path: <netdev+bounces-271350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNU+BVRLw2m5pwQAu9opvQ
	(envelope-from <netdev+bounces-271350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2AE31EC4D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DDE4302BBAA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36992874FF;
	Wed, 25 Mar 2026 02:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D227FD43
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406430; cv=none; b=FTqA3dih6oJ9UCOu1PopNyTDophWjouZqKL0ZiSPVBZ2iHbeOzwnBCThGX8Xa9XObd9I55A+Qzzogixfuq1pBLZ4dwJi/sS8IjuEpLDuD+5byzLfERh3gq6RjsF2WauJRzTyT1VYCl/nNX0m+oZxJWX076lwTPIteNRrMeItUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406430; c=relaxed/simple;
	bh=r2/SqIjLIWy0EUSMP3v29DKK68YqLCchwQbERUhn2nM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B9WSRL4I14HCOIR8/BiynC+3DYGI4sH98Ca+1rAU9CC41xmG8tf8tG6DtktJy+BtPtHBSgFlF71sQSXwdq97nNNd8Lmrba+cuSj5m7OKulHjBkz8POQYU7Ht9AKf7LNmLY7IVlHwCLnn0EVB0D+jn24ldbJu4pwuBkIJ/r9dtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67de83227fbso18965321eaf.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774406428; x=1775011228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06ZkxdPmjXJHAdYiuofRx86KOCd4GJenDBvOMPL3C0A=;
        b=iIxzBaZWA043ezd7DqD5oP5P0w6eLPd/9lI0SoaHDSezirLJw+vpH2N7wkIx/7Enyz
         YLS0GHk4ETO81dRjwuHqpQBCjtwHrAP1AakRACs88k4acAPE6TVRSIz2FBxKSaRIXe3C
         8gC8H9l/I8RMXOire9mLfxg9ZPRbvbfydB9YqNWHY8vdbJuUHKYRJmShDU9JC7aEqVr+
         xSk7O+D2OA1YSYq/T4+YSuaueCXLl0FpoQC8dx//kY4t+unOjG+Y1Sty/7GG7cGn9x8z
         EYoPhcoQfqYpkXkmFsArLvWIUXTypqmj817lujDJStUsV8qlciw51bm0RrsvN/le8Nqj
         AHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb652ScCos7lFYV5WvVhCiJGsXp0igSS65YU8JLiKEZNq4d09aiKo1KGj+t2YOOtQHt1SAiu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzghgz/MSdILawp2Pi5ChPx4I6L1QmDGdOpEHqH6ZuAIsubntHG
	e24PmzQt7cSO1+rMPRlllkVvi7h82gwiGr737vCFQKjKuvanrePa+RqD8Wgtz68YI19zGOhP57O
	fuCpztt3OCTVrlhWohoKXf4Lqa/EkRDAL7RqfFKzGnZ2BMFgYLe9f6QAItmw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61a:b0:67d:e836:2e35 with SMTP id
 006d021491bc7-67dff534a70mr1160458eaf.47.1774406428462; Tue, 24 Mar 2026
 19:40:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:40:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c34b1c.050a0220.abc16.000b.GAE@google.com>
Subject: [syzbot] [usb?] [net?] KMSAN: uninit-value in rtl8150_open (2)
From: syzbot <syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-271350-lists,netdev=lfdr.de,9db6c624635564ad813c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email];
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
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 6B2AE31EC4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c612261bedd6 Merge tag 'io_uring-7.0-20260320' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155801d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb
dashboard link: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa2bdf537bf6/disk-c612261b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fcd98072431/vmlinux-c612261b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/737b94c52155/bzImage-c612261b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com

usb 2-1: device reset failed
=====================================================
BUG: KMSAN: uninit-value in set_carrier drivers/net/usb/rtl8150.c:726 [inline]
BUG: KMSAN: uninit-value in rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:763
 set_carrier drivers/net/usb/rtl8150.c:726 [inline]
 rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:763
 __dev_open+0x8e3/0xd40 net/core/dev.c:1702
 __dev_change_flags+0x32f/0x950 net/core/dev.c:9764
 netif_change_flags+0x8d/0x1e0 net/core/dev.c:9827
 dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
 devinet_ioctl+0x10dd/0x25a0 net/ipv4/devinet.c:1199
 inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1015
 sock_do_ioctl net/socket.c:1254 [inline]
 sock_ioctl+0x769/0x1140 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x1975/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp.i created at:
 set_carrier drivers/net/usb/rtl8150.c:723 [inline]
 rtl8150_open+0xc26/0x1360 drivers/net/usb/rtl8150.c:763
 __dev_open+0x8e3/0xd40 net/core/dev.c:1702

CPU: 1 UID: 0 PID: 5428 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


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

