Return-Path: <netdev+bounces-98838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE18D29BF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846E5288885
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C1B15A857;
	Wed, 29 May 2024 01:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D631157A40
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944667; cv=none; b=JKjPglQSiSgneFsk2gyWVqA/rLTVxkCSlnFltP5HQBITKY0cgEI1nq3YF9d2gig/QylA9WzZwsRySvJZKs0W7R/0/apmSEPybIsWJ7t3WOyfnHNupXlwdxhbAGRxJkIA5L7D8DxKajy7P8i8ffgW0xw2nkFxUyAbWuwUCOuKT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944667; c=relaxed/simple;
	bh=yYrBrc80hyIGlQBoRvOT48y8Ztkx5nKyCtUFjZ39Q5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=atFvJo215824JNOjKdOI50WfbdFx4oB4zzNyoDcii/Y+PgpTMxkzwWPV7yfG4j9aHpxQDI15xOj/7mrkTpnM2OzcyWxT+Hjx3ljlVzroRk/HkTSgWVjtNod3iM5DVeup08z5EV9lMMB29eOtL9VdlSUpztyWwNowbI7g0EpUuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-374519f6ebcso15990325ab.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 18:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716944665; x=1717549465;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZXGbhTFhiJOStQUUF1Ob48iI23dJ6bKL3UoFrOl37s=;
        b=dcuHH8CGyzjfXVExa4lzAoYvOyJIZvAt8Gu2RxIkJboz5EGe5gr/vOQ8ym4NUpYvHo
         Olj3+ESBz5tNlXtvTfE4M/DIK2SmrxySspQ+lbs9k90ILVbb8WNCyJIzFlQ/pdUKrelK
         P6ncmDghhzMRnMZxYqbOuVwSTrW71d8+SrCTDwXEOk7RaONlNRyujVIfwHRkKucfdM1z
         PZjnIpQRDSdJfQ2uyf9sPgJ7p1jOruqLdKFXkmU1FT2INMfRT7SgJnCnqZEjLMmFmhrS
         kLLY3teln+quqQFDw82KcVydF2ztvLH1UnpThrDddWG+n0ui8xADVnoQ2U+LPucbExuY
         Xnbg==
X-Forwarded-Encrypted: i=1; AJvYcCU06FcGrGKtaVvgMa+Y0HmcroFN4L78V3XmKPTjeWUwxhzsjpf3sfwP38i4QIYJEc20sunWnfB/cG/RVfHIpd3ZQE+TfcFV
X-Gm-Message-State: AOJu0Yy10wJJWl7JKPLGei2wsphLja2JXVuIW4Kz+Ha2Tk0cih6wDLIm
	IJsNdMoFaf5zPh8D/6sydW3IullynWM1yrJGVNJvYaVrUNipELC8+l0rHYiOuKJfHJm02B1IeVa
	pM90ndY9Gj1PNg1szgkjJvLcgebKbWWx79GqoLY+D0DzYa25Cyauq0UI=
X-Google-Smtp-Source: AGHT+IHNdzOfvn06/H/KYXpYdvV38vQwvCrsuvwsSbEuj9AkmWaZ18IZe1lNAsEqSgFY81XZw/GpnHqE52339NWkU475qX/ZTWGS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:36c:4c5b:ce1 with SMTP id
 e9e14a558f8ab-3737b41cca1mr8697405ab.5.1716944664871; Tue, 28 May 2024
 18:04:24 -0700 (PDT)
Date: Tue, 28 May 2024 18:04:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9551e06198d54b4@google.com>
Subject: [syzbot] [wireguard?] INFO: task hung in wg_destruct
From: syzbot <syzbot+a6bdd2d02402f18fdd5e@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1040c63a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=a6bdd2d02402f18fdd5e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2739658d66f3/disk-e0cce98f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad17bcdfd78d/vmlinux-e0cce98f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31990c7700ed/bzImage-e0cce98f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6bdd2d02402f18fdd5e@syzkaller.appspotmail.com

INFO: task kworker/u8:2:35 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:14456 pid:35    tgid:35    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10692
 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11760
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:12:8583 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:12   state:D stack:21976 pid:8583  tgid:8583  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745


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

