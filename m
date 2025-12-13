Return-Path: <netdev+bounces-244595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC7CBB0E6
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9028301BE88
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDE226CF9;
	Sat, 13 Dec 2025 15:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048222097
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765640132; cv=none; b=LwE4qMSC9E/7K/FoKf660noTV+dgr7vBFfvoIJRE4FBwEVTJDKLhWhMSY3pmGtIFp6AWWJ0Xztltp2e7SBBBIVFF67OGGiMvRmeLirfvad810nRU7+dRSUDTT8QjAfJ0DD8SBY1QeoPl/AfT/BIDyQc2rdh982/oeCCrV1k+FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765640132; c=relaxed/simple;
	bh=TqLXWW2CIy170mpOfkT7Zh90WqpuAuB7C5yGRFiw3CI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d/wAPpGKDq+bbDtEqbHIy1jcdBC7z/J/0s+tfY4LgYeUWk7BpC6ExHp+8ayhDkhXWjhb9v2lcNVcoAyRAdLbQz2vHNhntp92HoIfP0MB7zo8oB00gAC+HeW+SZ3Co908Mp3l+McbM45Zit9pZ6ob41OuERXXfPrizIvKoTRx1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65997ee5622so2843365eaf.1
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 07:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765640130; x=1766244930;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOjX1vN9wjS9m8uU4U9yGtbFR55FuYbttl3huY4iNIg=;
        b=mPZqhQ9rj4WJpediz5yb5HZny69QouTwPSK0uW4pIzLEcD43/w8PNUHwRxAwiWiyEs
         p48S7XM4XSGyu89Ew5AwD6EyEr103lONMGnRPJA6xePsFVnpjK1tKlh6OBgQAaVWPAfA
         Dy7dGyTHmbe5NmWcOOojXIRKg0+PK8k145ncYVHjMn1f73X/EZuDHCfzXpnJZ8e6IHnu
         276a4beReOm4bJO/+NLVE4EW6s2g95iTvhpkwT59hnmz6rNNQEj9wwkgAU3QvcbuLBnr
         GRTBOFqLMuf8D01uM8erFcHsiaxZcto0vvGra++Y8QLVyk0IHdxb8q58zzaMUvoLh5qK
         ZXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBitkx904U/DZXqdAFczR2GZFZKT4kh1JPmkwFrtCpPV+ETOpz5Wv8oWBDoav9+WYw5jQwaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hvSU/6L7heSeRXKO7GqkPExicPkVkbmsA1Q/GSnteGvXK7yZ
	3t1YyRtdJY/5mCRnizdHWESU65itmPabPtnRTChyAag0j0gx3ec16OHJ+lNwLsgxSzpqarM33hd
	HIKtjyPCJyYGAV+LibLg3dA/bAzIyDUgJaAYJDlNZTn3OK1Bfj4vlck/Ir8A=
X-Google-Smtp-Source: AGHT+IFU6hmVDEuFLiJIe6VLXEcwNYgKFEwGhqcV0ubZdicyMpQGoZ4wqfiFCXqnCZJ01nuZBBnnOySXx/4q4GXFlm+RlHEnj1/F
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b84:b0:659:9a49:8e92 with SMTP id
 006d021491bc7-65b451879b6mr2677818eaf.22.1765640130294; Sat, 13 Dec 2025
 07:35:30 -0800 (PST)
Date: Sat, 13 Dec 2025 07:35:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693d87c2.050a0220.326d2b.0004.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in tcf_idrinfo_destroy
From: syzbot <syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16789eb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff80000000001c
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff80000000001c] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 252 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Workqueue: netns cleanup_net
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : tc_act_in_hw include/net/pkt_cls.h:288 [inline]
pc : tcf_idrinfo_destroy+0xac/0x280 net/sched/act_api.c:943
lr : tcf_idrinfo_destroy+0x9c/0x280 net/sched/act_api.c:942
sp : ffff80009bc477e0
x29: ffff80009bc47850 x28: 0000000000000001 x27: 1ffff0001251a7a6
x26: 0000000000000000 x25: ffff80009bc477e0 x24: 1ffff00013788efc
x23: dfff800000000000 x22: 00000000000000e0 x21: fffffffffffffff0
x20: ffff8000928d3d30 x19: ffff0000d7040000 x18: 00000000ffffffff
x17: ffff8000894c2344 x16: ffff80008ad6b188 x15: 0000000000000002
x14: 1ffff00013788ee6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013788ee8 x10: 0000000000000000 x9 : 2310c4dc04add800
x8 : 000000000000001c x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffffffffffff0
Call trace:
 tc_act_in_hw include/net/pkt_cls.h:288 [inline] (P)
 tcf_idrinfo_destroy+0xac/0x280 net/sched/act_api.c:943 (P)
 tc_action_net_exit include/net/act_api.h:183 [inline]
 gact_exit_net+0x9c/0x104 net/sched/act_gact.c:310
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x428/0x7ec net/core/net_namespace.c:252
 cleanup_net+0x3f8/0x6dc net/core/net_namespace.c:695
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3427
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: b4000b40 9103c016 aa0003f5 d343fec8 (38f76908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b4000b40 	cbz	x0, 0x168
   4:	9103c016 	add	x22, x0, #0xf0
   8:	aa0003f5 	mov	x21, x0
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38f76908 	ldrsb	w8, [x8, x23] <-- trapping instruction


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

