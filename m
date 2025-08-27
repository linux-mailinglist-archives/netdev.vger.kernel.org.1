Return-Path: <netdev+bounces-217399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9AB3889F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D7F5E1D15
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA82D6E71;
	Wed, 27 Aug 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlNAsNc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D12D6E59
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315735; cv=none; b=ly5yoo4uBXXw3xVStv81kuzBkSM1xR/5CSm9QynS6RNm/Y8DCtdks4HlNolQ4pVfE32zqtgs5naPr0lY8T2gvtz4CTRwuD9KcjWp5y9IU/x32wbhXgUWvcJ31my/Sr8XImSb71LgYMGoImj63xzUdJ1xDOzRd0NS1VW9Z6P9jRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315735; c=relaxed/simple;
	bh=XK6LtB1QQhJCrSXd5VoKx0nnfJw6jgGQb7gLsDaxnuY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KoJPstNhJ8gurjl2ZYJ+MUdaNDLGBC7/Jt92LqRMv48ffsJzsaBff6FePBwtoYNeu1uNFZalVYCGL3U5+OafXxbVmfW6cZH6reG8EM9qYBcTicBmqPYAG4wjZLJBcDdp0zKLJQif53Ik+CZRn1AQNNF35HwUCAPHIa3uJG3AuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlNAsNc6; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-435de7cd311so162428b6e.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756315733; x=1756920533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAwS44FuOei0l/zf312DIWNuCiLxP1KGIqa6f2mojLo=;
        b=wlNAsNc6PcgO5in/71VoObyLR/0GCBZ+Rv1n5xcdyoLs8x6Wqsiis+HrkE8fkI2QmL
         dRLEfL/ydynqoK8W+gPQmZEx6YwWpwZJitd4LhEr4gpGlV7n1Puw8366/j3JpTUMs37Y
         txtHjAmMN8N6kWYfe2EbC9ge8Fyi5vvA9tplVu1pmlhLS+hSQMWGzLJ1K7mbhrNh9ItJ
         BLv7Y0RswQ9dYWljQMTlJCrcGBXlz1UvpWPAYtTRc6AxfZtXEjBh4P2xOHvMbK3srMup
         1QhFo7C3Lssk2Okw9anCjbAgmFcefKLiLRQBRHiV18xzzmWDKWLEds+LLzs3zmDfnsl5
         UxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315733; x=1756920533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAwS44FuOei0l/zf312DIWNuCiLxP1KGIqa6f2mojLo=;
        b=bm2sS9zS982GjhcVs6+jWVZMy3aJ+DeWFnE9+Pq6gP6JDYvVHvPTQA551TH8x0yw4N
         MWHru1RTBYRLTopa9v+gf6Kk1GWyODk6uTyJ46owNxe+DWsQMvLEMZU65SQx5ulqYVAF
         ioI5viAFaRe/4geaj+yFFwUk5fd7K9vt123+FscNoGbfBrwOr9BXjCeHxl6wueIP44Np
         FjD6Kbde+mhWUM9om9C/+3RnLBnOc0op0fLMtIi110KXP4ht+vAaU2KPL6HH1o5H2+xM
         w76X5WJWYdXCLRq6Dg/TyWIj95fyHV+ScnaF8sGdY+x2f42mXWYM0St5dlGeTerS6ZOb
         3wMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYyDM3CSk0Os2CR8V1e9arXUE5+M5VK57qgDOHn/HdIDNWXZ/A8ezCBXSn6f2dpuO7R0s0KA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjpTfYyfjN1sq6JeYDhP18u4q3oVTChNAfvqGBOzK6yB4IBBp
	0iS5fMSPtJ3yzPw16nkxalyfIDEqmfFFPdKo500mi0/z+rZ9jrwm8ZdZL/bSI1KEqp9xSMpPgUJ
	VUQqPbg7P2lpAvg==
X-Google-Smtp-Source: AGHT+IHAmznMJnzH1A9NF9MxA4oVKtQvp6BGhHPeSlLGnqTBG9OWmdpLJa4cyaQ19jvNdyHVhXEwKJOZN3PsZg==
X-Received: from ybey66.prod.google.com ([2002:a25:dc45:0:b0:e95:3868:192])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2b06:b0:e93:3b3c:bd3f with SMTP id 3f1490d57ef6-e951c3f12a4mr18201966276.46.1756315310860;
 Wed, 27 Aug 2025 10:21:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:21:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827172149.5359-1-edumazet@google.com>
Subject: [PATCH net] net: rose: fix a typo in rose_clear_routes()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com, 
	Takamitsu Iwai <takamitz@amazon.co.jp>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot crashed in rose_clear_routes(), after a recent patch typo.

KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 10591 Comm: syz.3.1856 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
 RIP: 0010:rose_clear_routes net/rose/rose_route.c:565 [inline]
 RIP: 0010:rose_rt_ioctl+0x162/0x1250 net/rose/rose_route.c:760
 <TASK>
  rose_ioctl+0x3ce/0x8b0 net/rose/af_rose.c:1381
  sock_do_ioctl+0xd9/0x300 net/socket.c:1238
  sock_ioctl+0x576/0x790 net/socket.c:1359
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:598 [inline]
  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: da9c9c877597 ("net: rose: include node references in rose_neigh refcount")
Reported-by: syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68af3e29.a70a0220.3cafd4.002e.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/rose/rose_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 1adee1fbc2ed1d04345c6340b717eae1f6a0305c..a1e9b05ef6f5f6f09ee17927c4a4aba50a156adb 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -562,7 +562,7 @@ static int rose_clear_routes(void)
 		rose_node = rose_node->next;
 
 		if (!t->loopback) {
-			for (i = 0; i < rose_node->count; i++)
+			for (i = 0; i < t->count; i++)
 				rose_neigh_put(t->neighbour[i]);
 			rose_remove_node(t);
 		}
-- 
2.51.0.268.g9569e192d0-goog


