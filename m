Return-Path: <netdev+bounces-203104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CBAF0840
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01157A91B6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4919938D;
	Wed,  2 Jul 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqVL8BSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6F192580
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421885; cv=none; b=oKjV+pETMolZSQ9KMtIlL0SbIuXthJt1Y3Ya71hYkBwC1NHZ3cqWHYcy8mXbNkU4HAcxl3YJgN6pADV1TXHvJOxcCF+fbLQ1Y9QmtqUqHbnu6EMj+sU4QuLcAENOWK7bhL6KsPfLjAM7W3yvG4aYOXnuhuvGwMaM46IOJJlqyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421885; c=relaxed/simple;
	bh=Nc/Sz9JHWEHh4nSvAMgx0GXsaFNpKUlsISOY+qIgnPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p7QyQjKo1T+OyW5pQ2bTwMYxmW1VOytq40gaxxSn8Jxo6v+PGLRyssjidmGT0dLA4/lN9hNqdZqVSMc60lKc3mCYu9XrpOBZzboOe5ZbZGaUGtWu8wzdOgzpYr3ZsyErhFXtV2FcfCaYMADZBMZvcefPNxaLbu8wCZWsa8mMbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqVL8BSa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235dd77d11fso35011805ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751421883; x=1752026683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVok9w7FxgoLCrWqFzug6aT/mtmehd1y55avia2mjCw=;
        b=rqVL8BSa2YEgfPlonAOxQPzEsc8RUHZHR76c3l8n8KhYLjOjMZETCsTEdj20OIojuj
         iEJ53EVMZyIRr3RW15ww+R4nvxSIEz+9gYNOKTpKvZhWB59MFPEc4lh2cGTEpT+2WP5u
         6cVddjV9vSaYzaa92PRUmejZHpoBoRuwfRtxVQl0kEbUqv7lzQPxE/hXC8hGewq8G29b
         0zfOOWTPrqHj2Up7/WkIMdudx2nppTDOEQwzCPXR+QZk6mKubMRxKGbORuFxCXrEJSLL
         xTEPrNqNy7R2M/RN7dcXKL/ucM6Lt7F9PQ9noT+RV6PpLE11s/rvjpfmXwdpYqOAY7Rk
         Hrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421883; x=1752026683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVok9w7FxgoLCrWqFzug6aT/mtmehd1y55avia2mjCw=;
        b=sPM24ddrniSIIsjsNSXMVLTEqtLwAG2Cev4Q/EIaJdhZpnUj3dQVzbW7Wk356E6Hkj
         74miM7WlAnX/zyRYOWsZP3x0svHEZbFI9AzpfBweMyZB7SNSqdMkN/dkAtCS+bynijuq
         BHVeBzXLSBxnfT05H71rp+ydy6A04CgCjc0CjbYI9Fzh4oSPeF2VvzV2fO9ZOPViZk7W
         zcKb+Ho6ya9MMeVCxV/HHCxp4jf1zULKJ/JaX3p0LGx5Ns+aLG0USMXUTrlV0TdzlFry
         6K8pDkcF4xIjEJSMBlsKWOXnledVhEnPKDtNcuSBdMHb0Cm9hD+Ty5PUaCEejeXQ7NaD
         qJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVrAWf1oYEG0HzANLCriUZOGbL8mBRbpiyoxV0YQfc6kHJUOzzXcj+8ejMJQ3Iwc5/t1LZs7D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzem/GOheySCSIFsuMDiS6ZzRA/sLkHn/7a1cepO2dcPhaGqjG6
	aThGPFOKof41o+3zNZKZnPNr2XRqsLuWEfltKsQwrLzkrMGZDIZPZLUj40Dk+1iYlQZWMaktbJ3
	PBhwUbA==
X-Google-Smtp-Source: AGHT+IGhjLIU3mSyAT8bkqPgyFig8XSzZe594PNUrwIYagQM8XmHIsOTYQBfL4q9ty3lJhLdC8bZo2/GgFY=
X-Received: from pgbda8.prod.google.com ([2002:a05:6a02:2388:b0:b31:c667:9fce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4e:b0:235:c9a7:d5f5
 with SMTP id d9443c01a7336-23c6e4b06c9mr13832805ad.13.1751421882777; Tue, 01
 Jul 2025 19:04:42 -0700 (PDT)
Date: Wed,  2 Jul 2025 02:04:07 +0000
In-Reply-To: <20250702020437.703698-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702020437.703698-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702020437.703698-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] atm: clip: Fix infinite recursive call of clip_push().
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

Later, when a NULL skb is passed to clip_push(), it calls
clip_vcc->old_push(), triggering the infinite recursion.

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
 net/atm/clip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index b234dc3bcb0d..250b3c7f4305 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -417,6 +417,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
@@ -655,6 +657,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_vcc *vcc = ATM_SD(sock);
+	struct sock *sk = sock->sk;
 	int err = 0;
 
 	switch (cmd) {
@@ -682,7 +685,9 @@ static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case ATMARP_MKIP:
+		lock_sock(sk);
 		err = clip_mkip(vcc, arg);
+		release_sock(sk);
 		break;
 	case ATMARP_SETENTRY:
 		err = clip_setentry(vcc, (__force __be32)arg);
-- 
2.50.0.727.gbf7dc18ff4-goog


