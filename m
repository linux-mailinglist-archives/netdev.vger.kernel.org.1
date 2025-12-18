Return-Path: <netdev+bounces-245441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB5CCD7AD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F7C301BEA7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164782BEC27;
	Thu, 18 Dec 2025 20:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D929D270
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088748; cv=none; b=AhnhAGLlF3skWOHWvhPJLgvXyF60baqdjp4l1isjGY2lBsiFP1w6094y88b/ayZo8KrE1UU/ql4+UQtNtgztTZiMO/b+GSz7iBLuFhFg8IJms5BTYKFwD34VwwXuswi3nQ5N7hEVXX2pcOMsKVuyZVwFqdUuUc8KXKVeGv2fg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088748; c=relaxed/simple;
	bh=SCmrBCTDFD5ubTjkA56SqENcQgdXvnofAPhlNZPj5ic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NlVjC2ly92wqmNJbj7nqB3/IjiP6BxfnY38CMQwhYJLsmraazb+CuyEdlDroRpSGeWP18J78WzW0x41JAzMgVL4byl1rp5BlkDKvWKQh2mvLod73M9KCc+iODTbIuERyppza/zhwh9RuM6GjygbET0FWeW7ZZW8kuzLqAJ35WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-657486eb435so1323291eaf.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766088745; x=1766693545;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tfr7FL5pZakXGk7tny8jsZuMcDvYO9J0q/4MvmwyG2E=;
        b=fTnaJZnpRB3S7EUT/Qqfk4Y/moie1vFnyieufegvBlXjAOguiqPAHEPXvstuV0q+a2
         LaSW/EKNTXZE/KQg+drUaL7xaL6C75A2/K0UluiSTC8pKcX2EsQGo+rXOjbwvBRiLueM
         I1g6ej6nZYoHEZ0EZ4T5QTxVbErJXUQyNl1ymtzz8yYl1CzVrDUoCxGbgfT8cNR0R9dw
         P4qBVHaK62wtG7Rgq3c9Fy8P7uIo0G+q2z6FbvFra+wTwRQXxV7LgoPajFNw6CYkwmNv
         hqQb5uf3DPQtuCuhpFIHlCDQPUkMa4qn+wvH61kxM9B3VnuJkv/UpMWOLHHeT9WIOwlI
         jvFg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ieKhzSB8nDer5+KuDnsA47dIAA1opZljK/1sKq7iW/SL2Fgcisc/NigiqV6+umhnsTSQyyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEn/rRi8cr92NbubrSAHymzfR+VJMBmXdBgZRP4WU7uGo3YHt
	1ozaCWVyk+ZK6WKfOiLagkzEJt8W6emTmhlxJ+oTrSejIDNO70Df3x9XtFLVv9/32/gTSjWXzGA
	OEzt3qE1Eekex3EBsW5//QRGzIhm3C+RaSWGr269t8buCaevLpgKnpOlcQDg=
X-Google-Smtp-Source: AGHT+IFDkWTsNoL3eU9I8Uu1JnhOI/l/+UygD1nN4dlXSN/0peBnV6HtRg2gNSDhC8VnFI3q2nIbSMXl8S0hJ/OeGZGikFDiCT6M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4289:b0:657:4733:dde with SMTP id
 006d021491bc7-65d0e94d6c4mr252189eaf.8.1766088745350; Thu, 18 Dec 2025
 12:12:25 -0800 (PST)
Date: Thu, 18 Dec 2025 12:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69446029.a70a0220.207337.00f1.GAE@google.com>
Subject: [syzbot] [can?] INFO: task hung in cangw_pernet_exit_batch (5)
From: syzbot <syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175489b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=6461a4c663b104fd1169
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139e99c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fe312c4cf90/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a1f54ef730/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64a3779458bb/bzImage-8f7aa3d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com

INFO: task syz.0.17:6104 blocked for more than 148 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25440 pid:6104  tgid:6104  ppid:5956   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1288
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x525/0x990 net/core/net_namespace.c:252


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

