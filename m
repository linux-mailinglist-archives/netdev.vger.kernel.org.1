Return-Path: <netdev+bounces-85623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2989BA3D
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AB01C221FE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE838DF1;
	Mon,  8 Apr 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb891Tlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA0381BB
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564934; cv=none; b=aqVJJugi2giulxjYi+kU4UelnPHxdi5OX7rSji6fo5OG45/GGM7Ln5CJjXfTKcCKqQgrxYwXPoAhC6tC/fNvHtzpW+cJ5m1DgKquf3qOFa9qzSDeeafFbe7tc9DmhVSS5HBsuGOdTvXZSSdEvutppMp7+7mQX8F60Ut/bvR7kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564934; c=relaxed/simple;
	bh=MYqlv9D40H40f13UIjC7zHoLDwM0tMcccHa/6DwQS1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VquS9OhW0Dxiqhv5v2XnTQOWDPyGbb/LOG6LHxZf/1j5e38vSPuwoeUArk1xMTnhrDEbtTeOcbybifeiZKWP1w+kP4eHqdKMV+YXnf/1f9KXxc5y+28bp0oRbeM8c6bbCbaHAIvaQomK+AYWt9qx8xFnv6LRAP52MhihXAJ637w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb891Tlf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61814249649so6514587b3.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712564932; x=1713169732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsgjVYS5+lt6E4DMR+pupChoDCeq4tx4ij2d6OvD65U=;
        b=Mb891TlfHIeKipw7Y0XUy1ywq/oRGig6o22nIdAr0eePzv8yrir5h7PO8l27/n2uVg
         NkYPUnoxtjjj5oRhljnmQbqGmsyomh4sCR70fzYzSwqgJUAPFOTLuu0GOFelg8MkySCk
         rwEcDcTbvRdLl5V0q6YolHGkMv7RlcAAFndcXx1vIurNbtQExa/PYC71MgMOeiD9pTxv
         vG4aX19B3VqswUN1J2IRfJy+KsTIyO8NG9nVwY46nJR4aFLkOrbpItRt/k3xKi0DUOPT
         EY0iV635ifiWQwOgPjR/9Ngh5Dqr7keVPgVBDJiNFC0Boim+O/8xk3MexDdbVi0RXatT
         ONzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564932; x=1713169732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsgjVYS5+lt6E4DMR+pupChoDCeq4tx4ij2d6OvD65U=;
        b=jo6HVjttMFXj5v4W0Ca/b//zFm5liNQkcgCCAJ9ZvpfT/slDVtWBVGxqKm7y9j7blt
         DSV3MTX96sEmoMg0YwwKAhbWhHOJZe9H07gBUdB2JlzeOozcqlovbAIF8AHuW1AFt7yM
         f7t3UwL5tRjTLIm/x8TLHm2GITrXywb5RnuzEP3vdyABtxFX+yQ+1LGDgk46gicVCIYI
         J34rzikmlnRg6KMNAnlql9YNi0UHcQa3ZApSqWsoOZUaGl+20k6iNRqx7sJsDMBki5+I
         E0Z7i39NF+7ltIEQQ/vcd10Hbvi9bb2wjPWddDCwSzPIzhBoBP6jzSmHptQGDqgBfI/2
         LdpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXjW7LFJQ3zc4fzp5i5luijkkEbx2rl0/rUM1GB5T+/yWlYB3kzq+qWh4iF5pc9wsqSLp+4Dkgbu9I86ksVt422vyKZmcC
X-Gm-Message-State: AOJu0Ywc+eaI1xmcuM6I87drIl1v+0zYtaRznrMsWjYHWWzo7dM6Y3UT
	9QFHeh/EzTnXbvkMblx/HUwFZZiS9zOUyB74aufQ4QnHV5qRaXZUybwxMSstJCqkWth0YXdOA9n
	L3SHCFJVc/A==
X-Google-Smtp-Source: AGHT+IHqZBDQM0gMzggv+1JmYNlJhuzPTb0GeD+FJ1Ms5i/xIesAAiv2KHG5Z+tj07/kW9K6qi/TtONkJMIHMw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:84c4:0:b0:617:cbc7:26f9 with SMTP id
 u187-20020a8184c4000000b00617cbc726f9mr1955066ywf.10.1712564932164; Mon, 08
 Apr 2024 01:28:52 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:28:45 +0000
In-Reply-To: <20240408082845.3957374-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408082845.3957374-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408082845.3957374-4-edumazet@google.com>
Subject: [PATCH net 3/3] nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

syzbot reported unsafe calls to copy_from_sockptr() [1]

Use copy_safe_from_sockptr() instead.

[1]

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
Read of size 4 at addr ffff88801caa1ec3 by task syz-executor459/5078

CPU: 0 PID: 5078 Comm: syz-executor459 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
  do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7fac07fd89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff660eb788 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7fac07fd89
RDX: 0000000000000000 RSI: 0000000000000118 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020000a80 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/llcp_sock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 819157bbb5a2c6ef775633931721490b747f2fc8..d5344563e525c9bc436d5ad0b84380f0bcae62a8 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -252,10 +252,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_RW) {
 			err = -EINVAL;
@@ -274,10 +274,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_MIUX) {
 			err = -EINVAL;
-- 
2.44.0.478.gd926399ef9-goog


