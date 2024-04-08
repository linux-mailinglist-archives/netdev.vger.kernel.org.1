Return-Path: <netdev+bounces-85622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EDC89BA3C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C9C286C4F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F3381DF;
	Mon,  8 Apr 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INXm6yRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75836AF2
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564933; cv=none; b=Nb264rUSMxxLcKgjI1IIDaSRNdnUEYzfe8AX85ZujCBIRUQG9djts9NlVIpgomsJ1Ku/zWRRU612e4i83Q+Pg5pZRr6MF6+C4y65dgIDH+hPbp41Iyro5963mO+wkkHCPwaiAlGk6LpJdh7wkEos/hfiAc2hdmQp2ePfBhnPIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564933; c=relaxed/simple;
	bh=ILGfKfl8I6bt2H+au9AhsuuyCKaG6RIMwE+K4jkIHsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMnihIKLM6xytoiSkeH80Qkm6+cHteYEmElzegjpUeCCPPfFb6y9pO/4L8C5fGMaXD18zemBA4BbQcNiH2wFGJkoxrcC/2qouSfl3+sXj7/pywKQ/H7benzCStgmN3065YGt3GBceUuoycXeBrwxpT03+xno/b3freveJkYYKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INXm6yRd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso7808294276.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712564930; x=1713169730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yybjFMAN71rn0WkyuXs2LQiLrbziHyRQJsoAUX+BZR4=;
        b=INXm6yRdxqhnHJY49lykMNMS/LZT7An1NREDpL3HrKpdLZt25bqEndgLqR5Z7WepiL
         2p8gMeRn2X+iNECtPsicCmxZ8aGnELSiKQtnjLPvPf2kaWubvN8WE8V/G7Dp225oMQB2
         yGWOdcD/aFZPmp3cePIwwbypy0p1F2bo8BmUuH9bAME+CX+PNkt4tA/8Q9tDPBH+r3pZ
         MnIoB0o9wAjdDyM45ErHiMH/mRa5AZH/D9oBtI4Ln1MJGgk+nfgp8rD0MKM2vxu+T9ob
         T2cR9NWn7vgKB73LftMjirCwegHCPwqtre8u6boLPb/OkD+6jPWIea+DbPeCq1czXM5v
         dq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564930; x=1713169730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yybjFMAN71rn0WkyuXs2LQiLrbziHyRQJsoAUX+BZR4=;
        b=uaPwheTF73TWEypbQa/m54B6jK/bBJu3ZnUzGw/5Upahn9IDrFxn9XfRzqJAdmBrPu
         ljh0soY4h5D7NX9OvtA/h1WEEfUMRzFKdX5KwfL+K9dEm+yOF5CDQG82BZeQLti41qBM
         uc4KKLF+sgjUC4zTsdu7nKCPXjZe1PpsOeaxjqWnz427HXxhmAxvkdZHoroqFKAOgun7
         u8WonLRuycBfSp+bYQ/PEnwMbfUV7u55dyXQDrYI+QHNVVIavtYx4xwQUWPqweDV87g8
         8glGs9nycYwi81tbo+ouX4+CoWXN5Cq67K53OVk/YMPhckRGTXif3DQIpeNmMbvs32wb
         raWA==
X-Forwarded-Encrypted: i=1; AJvYcCXlhRkT3vojj7RP0btqdFuXcafVLfdKsvV1glrJr9dxzQ917+uBP5PmalBM1u1i6UQSFHrQp1w40Obr58eRkwzKj7UHEakb
X-Gm-Message-State: AOJu0Yz+VdE2O15l5YL3xIGVvm1zP4DVw4nP7bfJz9mgNJEubn2wC+cC
	YoXuudPYQ1ggolh9Zuxu0DNEHmEoHIwq1Z8otCdkQwdDrq7QmRuXbs9hnNH/lEpC7x6gbFa8mfa
	ii8ANWI4rog==
X-Google-Smtp-Source: AGHT+IH+nmW4hfu4dSCWJOlGIue1gBz4IU9sKAbaw24npTmj3VStaAH5eIiCgIKUe6WnjWaM/Ohg7kaRXqJDvw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18c1:b0:dcc:c57c:8873 with SMTP
 id ck1-20020a05690218c100b00dccc57c8873mr2497688ybb.9.1712564930735; Mon, 08
 Apr 2024 01:28:50 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:28:44 +0000
In-Reply-To: <20240408082845.3957374-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408082845.3957374-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408082845.3957374-3-edumazet@google.com>
Subject: [PATCH net 2/3] mISDN: fix MISDN_TIME_STAMP handling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Karsten Keil <isdn@linux-pingi.de>
Content-Type: text/plain; charset="UTF-8"

syzbot reports one unsafe call to copy_from_sockptr() [1]

Use copy_safe_from_sockptr() instead.

[1]

 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in data_sock_setsockopt+0x46c/0x4cc drivers/isdn/mISDN/socket.c:417
Read of size 4 at addr ffff0000c6d54083 by task syz-executor406/6167

CPU: 1 PID: 6167 Comm: syz-executor406 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x178/0x518 mm/kasan/report.c:488
  kasan_report+0xd8/0x138 mm/kasan/report.c:601
  __asan_report_load_n_noabort+0x1c/0x28 mm/kasan/report_generic.c:391
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  data_sock_setsockopt+0x46c/0x4cc drivers/isdn/mISDN/socket.c:417
  do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2311
  __sys_setsockopt+0x128/0x1a8 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2340
  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Fixes: 1b2b03f8e514 ("Add mISDN core files")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Karsten Keil <isdn@linux-pingi.de>
---
 drivers/isdn/mISDN/socket.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 2776ca5fc33f39019062b3d9fb8f02547a5e4139..b215b28cad7b76a5764bda8021cece74ec5cd40f 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -401,23 +401,23 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 
 static int data_sock_setsockopt(struct socket *sock, int level, int optname,
-				sockptr_t optval, unsigned int len)
+				sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0, opt = 0;
 
 	if (*debug & DEBUG_SOCKET)
 		printk(KERN_DEBUG "%s(%p, %d, %x, optval, %d)\n", __func__, sock,
-		       level, optname, len);
+		       level, optname, optlen);
 
 	lock_sock(sk);
 
 	switch (optname) {
 	case MISDN_TIME_STAMP:
-		if (copy_from_sockptr(&opt, optval, sizeof(int))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			_pms(sk)->cmask |= MISDN_TIME_STAMP;
-- 
2.44.0.478.gd926399ef9-goog


