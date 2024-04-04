Return-Path: <netdev+bounces-84677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043EA897D9C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E181F236FE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA21B964;
	Thu,  4 Apr 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIV1nhM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1018E1F;
	Thu,  4 Apr 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196658; cv=none; b=UKAiG4Eg5umClvx5DIVnakF9aWgu6lPzYcMYrjLnPBsi8OQoIuoDOcH8HgEOuCzq+NMa1uyX5vf512+MqkmQvVnb7+23KbzK7g062el1VY6QseZat3lWpJZizqoGFMGmzKZgx1nYgdSZCuTNW4Ba0X+NRkk+beZhzObd9+3dFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196658; c=relaxed/simple;
	bh=AR/AtEDgmwi8snRJBALAksbcJyt6c2+pQS9F+TaXJUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+2A7dY8YFM1rClBcNQS+jOdqKQewNIyUWS/atMFqw40OL+Yr8LKLcXNz8kZe4STNygHnRKyzrjeZN7myS9ZBOYYV86V+on2GUnMMWneh5SsNeHV7/GomiLO97kTYadXl5e3muwIffqfB+Bwi2yfcqiDOOqdML/KNtF4w0RQMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIV1nhM3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c4f23f3eeaso121139b6e.1;
        Wed, 03 Apr 2024 19:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712196656; x=1712801456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJRz5ZKiWg3HYLn11KdTD00YJNISxlIkpr1p7lBKYzo=;
        b=mIV1nhM3El0JZa8rT8NA42W7ifwh6i2/Jh3W1raBK8Ne84w1i7Eg7SsrORcXD5gWVo
         yHl4XndziGeacm/x3FuAITEPCQX/oqiVWVrf0dMaYTvwrt7XpNAuCjm1Rfje5FA4wNKF
         ii4hw+XJ9fYYm4Mm31POMeFPRg9svX1qx7A9djSFqjlBJyUNPXoUMYOjlWzH+9orvl3j
         bD4GFcs24e4tAI0Yf3ADJfVq+HwRb4IsqgxCdJTknBmD3l114J8g07/Ah4+NYzdRzJEP
         lZcz7KOZ4C6dEq0srXTm67SPkcrra3wLHI5hfwx1+m70zMvo0HtQPHPHPBhRM6ezF+A9
         DVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712196656; x=1712801456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJRz5ZKiWg3HYLn11KdTD00YJNISxlIkpr1p7lBKYzo=;
        b=REPpuqNZe3CU0BKADrc51pOfboQRO3dLtDVaMop082zPSPvmgRDjUp0TbvZqZVIwVs
         t/DAu+Gm0zPRlM+k5CuRMBaT19q5mgLdxVCxv41ALEMDZxTyC21GOTIeWOmnOLU8XTfb
         CUQQclrfIau90ItFuk7dwvvnGcyHsf/bYojHQwoXu06KoifbvfXE1tDrGPVpsy8dCyPg
         BtdA8yaOB2IPcjVot0SOkDw1uQfcYeJ46Euo28XADj7+pux8NIu/4TDk47Ot7ETxrJfe
         Sk3qsuQuvi5zs1Z7OkTjIT7fnj0Gyvi45YIk30mFECXiw/mITqWPWaDMxb/EIYBKnOaO
         cr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbWeEKo9x2v8OJr4uHQOZc7i+ogWMl1JdJbeTHdlz58ULYpDn3sSFpNR303wjtsbY6jzEz91/b2z7YyGoVxxzHZxlo
X-Gm-Message-State: AOJu0YwiFXXjD54TFpaf35JoQwRAs3G/eiffPcLwzQY+ofWXHARv7E5I
	nyJ4aF+CQYpy7ebVqSTQPZB5yUbmqtaH3ggsEbfvckUm9IORy2BP
X-Google-Smtp-Source: AGHT+IEPkMztezwxSOPNs6IgW9gHolYGByJoazIyo1bdsErohEpkpUEMEU/2x+ve2q1+dSzvp+ZO2w==
X-Received: by 2002:a05:6808:394d:b0:3c4:e08e:c582 with SMTP id en13-20020a056808394d00b003c4e08ec582mr1140199oib.33.1712196656015;
        Wed, 03 Apr 2024 19:10:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id lp16-20020a056a003d5000b006e6f0b4d950sm12489643pfb.4.2024.04.03.19.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 19:10:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: john.fastabend@gmail.com,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	ast@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Subject: [PATCH net v2] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
Date: Thu,  4 Apr 2024 10:10:01 +0800
Message-Id: <20240404021001.94815-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which
syzbot reported [1].

[1]
BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enqueue

write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
 sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
 sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
 sk_psock_put include/linux/skmsg.h:459 [inline]
 sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
 unix_release+0x4b/0x80 net/unix/af_unix.c:1048
 __sock_release net/socket.c:659 [inline]
 sock_close+0x68/0x150 net/socket.c:1421
 __fput+0x2c1/0x660 fs/file_table.c:422
 __fput_sync+0x44/0x60 fs/file_table.c:507
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close+0x101/0x1b0 fs/open.c:1541
 __x64_sys_close+0x1f/0x30 fs/open.c:1541
 do_syscall_64+0xd3/0x1d0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
 sk_psock_data_ready include/linux/skmsg.h:464 [inline]
 sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
 sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
 sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
 sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
 unix_read_skb net/unix/af_unix.c:2546 [inline]
 unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
 sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
 unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:745
 ____sys_sendmsg+0x312/0x410 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
 do_syscall_64+0xd3/0x1d0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

value changed: 0xffffffff83d7feb0 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W          6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024

Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer
dereference in sk_psock_verdict_data_ready()") fixed one NULL pointer
similarly due to no protection of saved_data_ready. Here is another
different caller causing the same issue because of the same reason. So
we should protect it with sk_callback_lock read lock because the writer
side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lock);".

To avoid errors that could happen in future, I move those two pairs of
lock into the sk_psock_data_ready(), which is suggested by John Fastabend.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa8c8ec2538929f18f2d
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240329134037.92124-1-kerneljasonxing@gmail.com/
1. move the read_lock_bh()/unlock_bh() into the sk_psock_data_ready() call (John)
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/skmsg.h | 2 ++
 net/core/skmsg.c      | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index e65ec3fd2799..a509caf823d6 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -461,10 +461,12 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 
 static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
 {
+	read_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready)
 		psock->saved_data_ready(sk);
 	else
 		sk->sk_data_ready(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static inline void psock_set_prog(struct bpf_prog **pprog,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..fd20aae30be2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1226,11 +1226,8 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock) {
-			read_lock_bh(&sk->sk_callback_lock);
+		if (psock)
 			sk_psock_data_ready(sk, psock);
-			read_unlock_bh(&sk->sk_callback_lock);
-		}
 		rcu_read_unlock();
 	}
 }
-- 
2.37.3


