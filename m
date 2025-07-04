Return-Path: <netdev+bounces-204029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16211AF87ED
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF4A5487F0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AD24EA9D;
	Fri,  4 Jul 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItRemtmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76B24BBEC
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610265; cv=none; b=XFjazFPxrIAR+FGPgqrtM9RR+nDpJIUi/a1Ds4+jKvRjnGSDWz+B821o5hl/Xbh247CW46N60jdhdfqVaWImh4RS/Kd/aJB0E1ijKUjJFpyPgpMMlp19U8Rdcr/PicJ7Hx6TBhacw1uT9rBMZufponGiQHsXpufxSpYhzoyE/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610265; c=relaxed/simple;
	bh=zT9FXH3e+wMFkfhkMFeXSS+VJnEivKhq4NHDevFL87A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJ4XLNuqc5InZeW5sIl+mUbsLgXHIR2dKWj0TWtRwMPy6HPVbCPiURKzaxVPa1azuSJIP1mbFkdKtzOhqCFcgBnF8imwcQOEPCTnutGLaT5EbnKj9CZJmumAsEg2tvl2DtXawbfZO608ws6LWErQKSX5cQprfGkVp4s1N8kJT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItRemtmY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so474245a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610263; x=1752215063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=34Dwxb0hOrty20KJjGCOBFI57gI2knZNrbaoN4fvziU=;
        b=ItRemtmYEGdssXUTQnpiF/xp8X296FuGIjVq1kWX1pwM86vbBWUvL1B/twmPBjPVWE
         r8GdmYeTH0Jl+y5HSQJgVjazFtEwdNG14O8fytLq/6wJIpRy0gjdkiYRJ5DQ4yTtA7X2
         wjO6rL6Nk6ChcUlLIoOo2DUzfPiG5w2ZTgqBwt95w9bNBmqCRDqcAIJqh9sQB4DK/gMy
         jcdz+o1bMVcbsx0UZ4JDhP3Xdf8uM45r+MEDuDqj+UY9N5j4qaR8JMxsWGJjLtV6d9jg
         7J1NsRZq5D9TDA7Rg66y2cvEcmSb7gWL2zxZsfQuw44XKHxLGUuwvxCh36N25dDCIIVm
         HexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610263; x=1752215063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34Dwxb0hOrty20KJjGCOBFI57gI2knZNrbaoN4fvziU=;
        b=WMFnEy74NeO1ef91QvIIzfBk6OaPtBiNANGBrVID6QYYstBbSRlqjy483GoEBwUOpF
         HpZ9or5oc9iWk+tavOBPh9DokSCO4vFdQOHbx32rZO35z/hCWu/RT0q/xL/QKenlWU+q
         C1cHYou0IdQbppJullji9zrBR+GDll81IZH2Yv81M/gHaJ8vRBJJ4IJdZqmKhfnlkQiY
         Cjd0uQnw8DHByJK7LMB1lDVNrZ9hNj6k3kH1QiBzxPFJYNDtas1HyWoJpnYJmNBo3n0h
         cN4X2Y8pAm7DrTY19WEhakc/t7Oi0A7xCpmIKleaxgojD5rk3//LuNbECP8B4iEf03TV
         LuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXWKH3/RR4UANQOHzod0vD4AI0acRIjc2eYiedRYo4eNRrE3VYvUnse3F41bTfQQQQHJTLZkXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+Y17ukZk+c1oLfRrFP4bpdjd07iek0KGRH94PtgtwZmj4f5s
	v6v1GPTKKN87KhEO9UOp0SgBXE7dWMXmi1hmtmQunsmNlwpOBXluYyG4vqYXssJUpnEoelZPCpx
	FJF/ahw==
X-Google-Smtp-Source: AGHT+IFpGes3mzHWbRZpTLnUqF8BrZ5sAo491Wxg0TPIAkb/AOBb/D60zLUVynhjPnudWmkFPyWkKNUmqh0=
X-Received: from pjbee3.prod.google.com ([2002:a17:90a:fc43:b0:2ff:84e6:b2bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cb:b0:312:ec:412f
 with SMTP id 98e67ed59e1d1-31aac44cc39mr2652745a91.14.1751610263624; Thu, 03
 Jul 2025 23:24:23 -0700 (PDT)
Date: Fri,  4 Jul 2025 06:23:53 +0000
In-Reply-To: <20250704062416.1613927-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704062416.1613927-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704062416.1613927-4-kuniyu@google.com>
Subject: [PATCH v2 net 3/3] atm: clip: Fix infinite recursive call of clip_push().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below. [0]

This happens if we call ioctl(ATMARP_MKIP) more than once.

During the first call, clip_mkip() sets clip_push() to vcc->push(),
and the second call copies it to clip_vcc->old_push().

Later, when the socket is close()d, vcc_destroy_socket() passes
NULL skb to clip_push(), which calls clip_vcc->old_push(),
triggering the infinite recursion.

Let's prevent the second ioctl(ATMARP_MKIP) by checking
vcc->user_back, which is allocated by the first call as clip_vcc.

Note also that we use lock_sock() to prevent racy calls.

[0]:
BUG: TASK stack guard page was hit at ffffc9000d66fff8 (stack is ffffc9000d670000..ffffc9000d678000)
Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5322 Comm: syz.0.0 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:clip_push+0x5/0x720 net/atm/clip.c:191
Code: e0 8f aa 8c e8 1c ad 5b fa eb ae 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 20 48 89 f3 49 89 fd 48 bd 00
RSP: 0018:ffffc9000d670000 EFLAGS: 00010246
RAX: 1ffff1100235a4a5 RBX: ffff888011ad2508 RCX: ffff8880003c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888037f01000
RBP: dffffc0000000000 R08: ffffffff8fa104f7 R09: 1ffffffff1f4209e
R10: dffffc0000000000 R11: ffffffff8a99b300 R12: ffffffff8a99b300
R13: ffff888037f01000 R14: ffff888011ad2500 R15: ffff888037f01578
FS:  000055557ab6d500(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d66fff8 CR3: 0000000043172000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
...
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x157/0x460 net/atm/common.c:205
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc0/0x240 net/socket.c:1391
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff31c98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb5aa1f78 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000012747 RCX: 00007ff31c98e929
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ff31cbb7ba0 R08: 0000000000000001 R09: 0000000db5aa226f
R10: 00007ff31c7ff030 R11: 0000000000000246 R12: 00007ff31cbb608c
R13: 00007ff31cbb6080 R14: ffffffffffffffff R15: 00007fffb5aa2090
 </TASK>
Modules linked in:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2371d94d248d126c1eb1
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/atm/clip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index 9c9c6c3d9886..a30c5a270545 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -429,6 +429,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
-- 
2.50.0.727.gbf7dc18ff4-goog


