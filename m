Return-Path: <netdev+bounces-197342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02909AD82CF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745397ADE5A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A53254854;
	Fri, 13 Jun 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYwkUfUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB861A5BA4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794233; cv=none; b=AE1lZMLuo1mRrMMvzhB0DzbkQMybUmqzexPXSLC/HPZvr9OsJwfFaX9bt0SEqW7au4VwyT9aEm7GLTBqh9GeDcb357+lHa6vr8aQvfocj1jJKu1ne0JMEXuRPm5uOjMtYaW/l/jqWKfV2vphiZv+8rHD/v63pInMkrnOL3SHZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794233; c=relaxed/simple;
	bh=S0Yf79t9H5E41DAbDc3rAM+7YmmV3mJ5Mi2qqQwP7Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+N51jjJV3cjuZszpiIVz1ZV9S4u8GPDKFXmOMvqMYywMWKA7k7uk8DT0UpjPtx86sx6U6i7pAkXnYOuJs29qvLlRjozsNc1PyYo7f5cZVlyJAylnNR8FV7cO46kjhJI/ye3z/MsrsoOTMYrsSA/mQoBjcGawfL5lkwUv+LTfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYwkUfUW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3121aed2435so2119685a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749794229; x=1750399029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjHEcVwotEApUSAHsa2lLoF3gJeUekEbkbVmggyuzM8=;
        b=hYwkUfUW+mPpttAJ1IbvGWR41RT4SPPJfguGzUp2YsCh0RyKnSTX0UlM1VVOyYJYs3
         VOnQbYaFl0aUbZVAKQLgT62YhRH+8dbZFoJQ3FMGONv4w0RF7dWUIt6J+7kwvDRb9Tbk
         juH0989fuGshAS+R7RlWLNTPb+Ssiue8AVsw94FL5r/jw/rZgwBUN2JJtO3E6XaA8EtL
         Wjkay+ZFifI5Q0ArO4+AcmeK/ejLyCWkuu3OupADPfbbZ+ibxUKL8y6CSudrBKNf57kc
         GJKhEeTUL7SiioiYBeU6Mysg4tjqhGD1wpz8CoxKUDM4db3HMsylVNAa2KhFfZdmTGR7
         8cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749794229; x=1750399029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjHEcVwotEApUSAHsa2lLoF3gJeUekEbkbVmggyuzM8=;
        b=brb6LC/jQ9lfo8k+y0bjkwrG80wsaYD1KXVU7LyR4yZ3mWcpz6cpfWLYT4Hbn9Kk+9
         ndt+SM6lgZS69u2CfRoEHf1KHmI7e6FdPenhuUv2WIqrb9SyqFoF9qSSKF6z79XZr5im
         Kpz+Ts6u/Gs9IZOSczRXAUqkletnTxayvxLoQG0Z2saggqF+BOt4zSTp7RECgOZjjqub
         ZsxSo707AX+1aExWQCtAbWfotoborfQQlHHch9iBzE62z3mgGQZB6zMrFKpnWSlzsIyu
         zTYLrTvsSovXDVv9Npg8vLwWoF+YoqsiHiWyoXvY0YL3QDByQLlaTet8WUEFcq9dUNmC
         Hhdg==
X-Forwarded-Encrypted: i=1; AJvYcCWKqgt0B4TUtrVr3ZWz6py8lNDm4ki6Xymc5OUgb4NTR6NrSUSMF1UYKqdsOL26NNaRIwnFeW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91QDSOm25pt9PjITs5qk+CqWCqD0mOSf8oxIbluhKP/ksEnTU
	YVGSGLZaVEeBl4417dvp9BLkREkJIRZ42EktdtOZnb+MfDrbUYQ/nFA=
X-Gm-Gg: ASbGncvPFw2eMhKN/aPX6j/0gtnPGY7b9KxwmmXVAZUhFTEQ59KrCIEklNWluA/bII5
	13IyBQQBB9n2ZVBRq1fzBMltcNaVqk+7657Z6uyjmhur7qCDSt8m2wvkxEcamg2tybm0NrNSMlW
	kLWOz3tBY9Ns/jOO2wSB/cTaIofW/SP9cb/BBZzFkFSta7LGDeWcw+9lqOC/iMzciDSABW2l6j8
	p1o0YWnL20kwXo3FtPorZYlxaVcFyO8/tOA+Hd+JhfCacxZe5d0TVtKDy9+F+INpbZRZVBInZHT
	5NlIPle37h2EYHycewa2R/JdyEUhDt9Mwqwk+DI=
X-Google-Smtp-Source: AGHT+IGl2BLYupy3Yjc6f7Dupbe7EwSU/fTUXHEtD+QGtOP/6HsTxt8ZzlHtGhCz0VcYyweAGjk60A==
X-Received: by 2002:a17:90b:54cd:b0:312:db8f:9a09 with SMTP id 98e67ed59e1d1-313d9c34e45mr3277885a91.14.1749794229363;
        Thu, 12 Jun 2025 22:57:09 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d2dd0sm2560860a91.17.2025.06.12.22.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:57:08 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Subject: [PATCH v1 net-next] atm: atmtcp: Free invalid length skb in atmtcp_c_send().
Date: Thu, 12 Jun 2025 22:56:55 -0700
Message-ID: <20250613055700.415596-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzbot reported the splat below. [0]

vcc_sendmsg() copies data passed from userspace to skb and passes
it to vcc->dev->ops->send().

atmtcp_c_send() accesses skb->data as struct atmtcp_hdr after
checking if skb->len is 0, but it's not enough.

Also, when skb->len == 0, skb and sk (vcc) were leaked because
dev_kfree_skb() is not called and atm_return() is missing to
revert atm_account_tx() in vcc_sendmsg().

Let's properly free skb with an invalid length in atmtcp_c_send().

[0]:
BUG: KMSAN: uninit-value in atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 vcc_sendmsg+0xd7c/0xff0 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 vcc_sendmsg+0xb40/0xff0 net/atm/common.c:628
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5798 Comm: syz-executor192 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(undef)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/atm/atmtcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..54c6aeac63d0 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,12 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr)) {
+		atm_return(vcc, skb->truesize);
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
-- 
2.49.0


