Return-Path: <netdev+bounces-112652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941B93A52F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD2DB20AD2
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0392D15820C;
	Tue, 23 Jul 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCi/frs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68129381B1
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757493; cv=none; b=Q7v5RZb3ZE2HeueHEU5l+KQVlj/zjnahay7ATBTSC3jiJiLMeOmnQXBT0gcVfyihIYJmLIsV+DG4iIZjqAIi+gmJSEjzYZr+QyMuWK8ZXiW8+6t7ig7Lf+FWAsW+fDQ5flHli2v3dhtCliAd2SibFEvxxq/UVujZInDcrROLdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757493; c=relaxed/simple;
	bh=m4eyTykeCFhLf3BBD25OpjZBtytLAkYawS0lXtXnL2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OdGU6wHqqYpfD/ndUfkkfHmeQ+2GTJ0G5YLaS6IKcc6N3dO91DnZpu2qGTyD+5d0MFBO8MVcB4d/L6aAhFzvtV7dPtn+2L+1b9XNGrEvmwIWBrkZpnvY4jQayO/I5CgpiJV9w4F4Qvd39reMUigxD+CzDtReUJTbI2rX2n7LgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCi/frs6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664c185a606so181299547b3.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721757491; x=1722362291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pX+0L/iUdXfKWqWMifzgPYygGc249FrDNRu0QOs8vyM=;
        b=DCi/frs6bC20xC4UnAX4bClIDvrh+16M+RuDlKy33dk6C+2enrqkJL+ZU9Bh5iFfgj
         qyYXV+HHw6Ius+26xgmhr5jNktYjU+MJedLjG5L9aJoArLHermagPmFNTDvts87PfH/e
         l++ISc9i8XJLNRVvbuqaBhFXILfK5ScoiLA8yF/EFG1apOWVf6AukBl4zkVuWM0dVIxx
         EGqq5WZKpXBK1ZPISfgrwdzzoO7VFLUkpZjkSkVQiguRYc2X7eeg7aU1vFMLDN6mZwyh
         UYWrau8NkfBUvdM2zfSwsqbbyX+ZVVdAqPBDGOoKWd7uIOmy6T8EEjqbNCe+dtTXJHOK
         FhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721757491; x=1722362291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX+0L/iUdXfKWqWMifzgPYygGc249FrDNRu0QOs8vyM=;
        b=QwoE9zirrKUeLqgXihVg+9wZVgoVdvTC1+z9zQg8aiAGXJuS/YfaeEzpl2gvFpZ9bk
         Yjc94CIW/TxGCEwXjcPMobqTL75JWzYOo09tqCxMiHqqDcX0p7kEYOhOIYWDgueTikKK
         ZizVx1EDb4CQxRf5MT5fOWIJ9rbTUt0CWBDSw05Ol1LAlrLOUzfUARnBfZ1MF/TSBClW
         VUrFDJE7PjuAFmibXTxvsH1+R6/4LYPKi179rOnGJlEx/pWpoFPBvIF+X+x5RhCDMrWA
         51uQgh7FiIugt+DBXfd2ydoWSca04cnsD8rXwI7zqKxMZpIxlB0MCIahn8LJi4q+sXQs
         /caA==
X-Gm-Message-State: AOJu0Yzmk135bV9skCttbO/ZsHVqSauOsgJ1pFkmUqDCkklXUQQgPXUG
	zyHXXSZhtnuVaLI9AzqpKkuLiizW45ZPigxc5UP9r+LvONIE9Hiw1S8a2YYsvuENsBmPX9ptxb/
	qCTMLvZfrwg==
X-Google-Smtp-Source: AGHT+IF0bjXaHBrjP7KkuxwSJgfGLyZbxxaPWeqtsR+rVsyswZ/Cmiogf2dwaFW7m1DQ7nVOMx9laLrO0txvGw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:97:b0:65c:4528:d91c with SMTP id
 00721157ae682-66a60693083mr9734807b3.0.1721757491397; Tue, 23 Jul 2024
 10:58:11 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:58:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240723175809.537291-1-edumazet@google.com>
Subject: [PATCH net] net/smc: prevent UAF in inet_create()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Dust Li <dust.li@linux.alibaba.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Following syzbot repro crashes the kernel:

socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)

Fix this by not calling sk_common_release() from smc_create_clcsk().

Stack trace:
socket: no more sockets
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
 WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted 6.10.0-syzkaller-04483-g0be9ae5486cd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
 RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_create+0xbaf/0xe70
  __sock_create+0x490/0x920 net/socket.c:1571
  sock_create net/socket.c:1622 [inline]
  __sys_socketpair+0x2ca/0x720 net/socket.c:1769
  __do_sys_socketpair net/socket.c:1822 [inline]
  __se_sys_socketpair net/socket.c:1819 [inline]
  __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcb9259669
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: D. Wythe <alibuda@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
---
 net/smc/af_smc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 73a875573e7ad5b7a95f7941e33f0d784a91d16d..31b5d8c8c34085b73b011c913cfe032f025cd2e0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3319,10 +3319,8 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 
 	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
 			      &smc->clcsock);
-	if (rc) {
-		sk_common_release(sk);
+	if (rc)
 		return rc;
-	}
 
 	/* smc_clcsock_release() does not wait smc->clcsock->sk's
 	 * destruction;  its sk_state might not be TCP_CLOSE after
-- 
2.45.2.1089.g2a221341d9-goog


