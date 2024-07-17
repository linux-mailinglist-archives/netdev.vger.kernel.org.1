Return-Path: <netdev+bounces-111838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75B9336A2
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 08:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F18283E9D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255E125C9;
	Wed, 17 Jul 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gNB20wsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068C11720
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196431; cv=none; b=OnEAL+vbTLZk0Q8FQz9DwDa2Ire2iMEaQfmGLdt1Qstx0IB1QeUwyA+FGt+YnzI13eqskii+6jWNskTzr0W9euIQcmZFN9KhKqYJikLu04nr/gehPBKwnu2aZ2UUKgWu+jCzp+ktHT37Eubi/Ehf3jt9oC9duQmB4QVH3gWFdCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196431; c=relaxed/simple;
	bh=u9zrIbLNt6r+NLL75A/B9GGqKSc26Gfkc/E56cEIndM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KJ1IVX0Ds1xdOP5lHky+MgPc+oLrQ0FDVMsJCzOfbulbL9qOURPM9piONB4ihPlTLCyWZPCpxZ6HvTTSesANxAfI8Ki7d4xqI7af1i9NwM/NlpWkNWVAezeMyP4SFWxjg3UR/yLUTWL4yM097s4YGIIpKTfVrrjMQGuSSrobQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gNB20wsy; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so34335385ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721196429; x=1721801229; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgUrGmqmMWtCBhPSlUAoCHAQGr50bG3mluKGn6yRCac=;
        b=gNB20wsy1m9PaTDDhKCi0mzHXHJuj6qfWfy2hudno/yp2NZP9WUKzqr1UMzDCZu0sH
         oaoP4Gf6w4Gq07BahmBvXM+eF8YdlO+RVbq06NJHliANVjNx6GYOvM7/m46u6n71qNY5
         cepQawwdqoSb9qM0dhvatlGme/tJX1sJpnREs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196429; x=1721801229;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgUrGmqmMWtCBhPSlUAoCHAQGr50bG3mluKGn6yRCac=;
        b=LLUZhaQ3hLztZucvcX/YxjvdEM3tcmNwhU/Qa4/ELM2JWq/WboUXEK5yMaMIVSuTGj
         ESCvm9+ltaCk6LSOusyHkFc3cOU42xxQsEAFTIcd9dV9NGQmDzdGvAEFLS8Mz1xgxZjU
         8uZXonHcSaY8/IIWNWXi8f6ZICpeYq5RDhAQst4zZiXQ1io/aZUu3aYCJ/IpANA2Lld3
         XQ+FxN7U59MJr7/8PtkX0KfOJfc3FCbr5r+5AKWlGV+zNHkSJZzKuO4r2Vo12rKRmJih
         bSqvanLbqJRdFgGaOVHZm83616TppiYqj+6qv9TOp/VHW8eDy84AcKYeO6c0hGovrr7g
         hW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQcayorcDig+UGkFlhXQnxvNgjvyImeic+3/xxiDCug/RYqjX8aBpFKeLilSYxg8ITQFcMrpxCHkLgAC3cFYfLxMpq+cUh
X-Gm-Message-State: AOJu0Yw4ta5xf39s3ON04p0+65gFYl1R41cZbJHEHX3MzDeTgjSk6A6R
	lz3Op8DyOYeVnBZx9ymu2vmg0TOwmSFDeL2lgcwwwl4zVLBkKlVVwC361yKS2w==
X-Google-Smtp-Source: AGHT+IHGsBfXVa8Ok1WZsxnr1r3Yw1BDvsbj6UT2V0KW+QeJjtQtCrbGTkBd6Ej1yD/yJgDmZMhF7Q==
X-Received: by 2002:a17:902:e5c8:b0:1fc:52d9:1047 with SMTP id d9443c01a7336-1fc52d9192amr2223855ad.42.1721196429287;
        Tue, 16 Jul 2024 23:07:09 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bba6f9asm67829645ad.86.2024.07.16.23.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2024 23:07:09 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com,
	Jason Xing <kernelxing@tencent.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5.10] bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
Date: Wed, 17 Jul 2024 11:36:56 +0530
Message-Id: <1721196416-13046-1-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 6648e613226e18897231ab5e42ffc29e63fa3365 ]

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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=aa8c8ec2538929f18f2d
Link: https://lore.kernel.org/all/20240329134037.92124-1-kerneljasonxing@gmail.com
Link: https://lore.kernel.org/bpf/20240404021001.94815-1-kerneljasonxing@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ashwin: Regenerated the patch for v5.10]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 include/linux/skmsg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 1138dd3071db..a197c9a49e97 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -406,10 +406,12 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 
 static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
 {
+	read_lock_bh(&sk->sk_callback_lock);
 	if (psock->parser.enabled)
 		psock->parser.saved_data_ready(sk);
 	else
 		sk->sk_data_ready(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static inline void psock_set_prog(struct bpf_prog **pprog,
-- 
2.45.1


