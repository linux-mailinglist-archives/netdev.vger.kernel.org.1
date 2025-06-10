Return-Path: <netdev+bounces-195973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40FAD2F6B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EEF163B40
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF2280307;
	Tue, 10 Jun 2025 08:02:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFC25DD01
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542558; cv=none; b=O9EfYYfOGlm7kKa873eT0Gtjl+wGeY5K+QziVdIeMLkpMw93QSenLiJcM40auxh/bSRexws40xXAE46KpoR7DewqX3l3SSvrsnv0sCZNKHgbS246V8XPh2rF11ZV8LhreDIGxfa3nbQWlBJoevFB6BZxrTXhSadYzqB/1GZGXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542558; c=relaxed/simple;
	bh=OZoYBYTlwkLiMpSPc8fdrVo8/i8kX55/L9jGSeRtV4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t/MprnmeRrd5gOOmxf1eYba3P0X1UTF7TdJaycCT+yCC7mlo7R6ElqmV+kB6wdBi5jYFBYAcixydHdwBi8uocRxixLRQjU9zqoGlJSQ1X87zQfK6ZY3rojK2YPwDo8HuIj5lmfXquVuXxPpJlpm0cHi5qkOM45KiVHhGDk3izWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso56833115ab.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 01:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542556; x=1750147356;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7GbDdel3IUK8fSKvAeseaNyJLsdrTcfYnH0qmMJJ7k=;
        b=j/o8TXrLkXfFU87/Vel9nt34EaJHzkQapejYTL9qlael+jjjTbDriY4wS36iIkG4eE
         PeoEtSrP51fuwvge9B/v5/mkWiGzrW95dNoXdZSldFM879WXNPvLXLdxE6IlXCaK7rU0
         D6CUShO4szse7V4IXjBTiN88V45RQcW5/z3RZYAqBNvpNjl6NERF/jjoV0anEiL0VMvu
         KR0RngHTCJLr5DWrCWGL+ppBMjITtu8XgMUcKTk2G1K4uKok1RXqqv1nDklkOnpl6xqx
         bSSvZf+uyCFJCjjufZ4of9nGiStn456X0Z+zXPZgQfBTxa3CTz5qQSmboT1Hj+8acKAd
         nH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWVOeeSgZtG6SkQcoC/uWtAp6rVM4U0jw41amVKWmoHYxka8BKPhrgv90TZUKeMlmInPaA8FaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45NDT4tbfAjxJU5wFqKBvoNe+9ZkkOALLVnRMHL0StdhXhtC+
	Dpa4qAsQSqTVeU+qyYgvbjNYG5IHw8xAhtnXdEllfvo1KC9l/M/ikHhN/m8pLWv4esVpc/e5QnO
	06Sbp/od5kn5SyXjIuDvV/kNWDVCTK9JmS2Xt20CHPZ4T0OJvr2UKQT+074I=
X-Google-Smtp-Source: AGHT+IFjH6OPrbyVdM2kIH0ThYhow5IOSH2t1RJmwi1Oj0SPMdtyA08QXKLBVaAMFPyznygVaO2xhAu+jYt6LkHDaxMAxeQC+k+6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3ddeddc683fmr12533155ab.14.1749542555978; Tue, 10 Jun 2025
 01:02:35 -0700 (PDT)
Date: Tue, 10 Jun 2025 01:02:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6847e69b.a70a0220.27c366.005f.GAE@google.com>
Subject: [syzbot] [tipc?] KASAN: user-memory-access Write in tipc_crypto_stop
From: syzbot <syzbot+2434dfff4223d77e8e1d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f70f5b08a47 Merge tag 'pull-automount' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157dd00c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22765942f2e2ebcf
dashboard link: https://syzkaller.appspot.com/bug?extid=2434dfff4223d77e8e1d
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f091df6896fd/disk-0f70f5b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/978b2a8699d8/vmlinux-0f70f5b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6e13557ddc0/bzImage-0f70f5b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2434dfff4223d77e8e1d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: user-memory-access in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: user-memory-access in __refcount_sub_and_test include/linux/refcount.h:389 [inline]
BUG: KASAN: user-memory-access in __refcount_dec_and_test include/linux/refcount.h:432 [inline]
BUG: KASAN: user-memory-access in refcount_dec_and_test include/linux/refcount.h:450 [inline]
BUG: KASAN: user-memory-access in tipc_aead_put net/tipc/crypto.c:398 [inline]
BUG: KASAN: user-memory-access in tipc_crypto_stop+0x1fb/0x430 net/tipc/crypto.c:1536
Write of size 4 at addr 00000000ffff00c0 by task kworker/u8:0/12

CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.15.0-syzkaller-09161-g0f70f5b08a47 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 tipc_aead_put net/tipc/crypto.c:398 [inline]
 tipc_crypto_stop+0x1fb/0x430 net/tipc/crypto.c:1536
 tipc_exit_net+0x7b/0x140 net/tipc/core.c:119
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:253
 cleanup_net+0x4c5/0x8a0 net/core/net_namespace.c:686
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
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

