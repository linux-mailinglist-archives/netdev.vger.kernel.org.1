Return-Path: <netdev+bounces-83337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E76891F97
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB152881A4
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35687144D1B;
	Fri, 29 Mar 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQRwA0MK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB81C0DED;
	Fri, 29 Mar 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719654; cv=none; b=GTxEP60nY7kwvZSdvEJ+MXOcZozKBeVaSqbfXsOcVRQrM8KI/+2XTssJRA09H7AhqrQz+dJqaNrmzubTLgUPsiBuF6MonNuiThqRynT/bJUfGI1CYPbnRElQV81gXPges8QSXlmF/Z70ZWF2X9pqHVHo4d+DAoHI6R48fKPhCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719654; c=relaxed/simple;
	bh=5834Rh+cWz88KoVcr0LtQ3rKmVWIk8tBTuV6dc0JRnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5vAgtvLx1D4ZSdHJcA4e9x8QImAgp0263HKFMZAbFj4NZH7UHXu+M57lSgZ7B9+V4Kq6lqZTyt7fJlNwU6jm82YvlXeI/NJ05M4JIdEnoGqxUJefkSK3VzwzT7z0m95tIhUx2Vv/HzZu3BxWZ5kiX20hZz1MUVakYKZb+PWwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQRwA0MK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1600515b3a.2;
        Fri, 29 Mar 2024 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711719652; x=1712324452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kvAS4gLGQo67RMtmhD+Lxk6MPomwl2ABlEwmaS69Els=;
        b=CQRwA0MKEHy+hkqZNE8Do4tdOrXuPsPhMSX4I+ewQuzrqZZUElwcxdVoELTa5hIC+3
         3UG/gGNIbqq/NxLVkA8rBr7PHIMNq+U3bzJHaXhOLs9SrCyTwP7s5I1MlKW9UjrY47N9
         xTKfE6nBmXVhfc0IHN7bAMo0H89LTgHvd1UQ+6q4q/haAT5TlVyd/FI7NR+JNIGCNkg9
         7K85+bhqivf2TSJMO9jEpc5y3J8kXk4NmtgzB/2ISQCn/yogkumhfO+cdJLuaALQU7D2
         lhPBUic60/qhYNb7WHozgYZ0uhvtaqvk5o7oNniubRBhFKBx3vyaSyPDgFc8IwvvsmEp
         Ub5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719652; x=1712324452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvAS4gLGQo67RMtmhD+Lxk6MPomwl2ABlEwmaS69Els=;
        b=sDFZJg/DVLR6NcDTdpIXS1TSgr9J/+SkkcN/4jgrfoPw7FvY/LatS637aKn9hU3808
         JnvbVzWo3dKEw3zKeNgApzBda5IkDYIs+agSJtvLHiEFLJvEQRQPmd9kuMpWnoQrEqPN
         5/TpexotRnZGMe7Ya8YPxzr3pVh2ExyTdAGCzhjrymjeSIIf0JwlAxCeE/LmX4i7TP1K
         SIvgupQG1R26BwMLbQCZeciRMY4cxNvgvEGuXYG7i5HBWLFwH8kAnWdvbc7oBW1DPfUO
         uDuYoc5HCrJAW/I+Vswa8OCIJfAzR5EsyXc1OmxtcqhXdLfmVuZWkFB51/9/jbAUW4G4
         uAMw==
X-Forwarded-Encrypted: i=1; AJvYcCXrzHzNFJkX3g6LRe83473RkxwbZqmMs0N3iG+bBhbswoyf8u6j0z/mQSbMcvFcmRQbtkuyhzRbVNqn/k6y1fFap8ih
X-Gm-Message-State: AOJu0YywTwMcQ4p370E+wNinJGArljksF7gyp8F1ddQUQfxHHY8qULsQ
	pPCGCyzzysXPxHHAu3lC22Q/2nCtN/q//sMa/Okk9Hpog92cgBcS
X-Google-Smtp-Source: AGHT+IFWlOxpNgsGLYJqX6FEzJNKpQ8garMBF1crYscVokC1V2Yk2I2rcH2n1P2EsUWQSJLAw2vXjQ==
X-Received: by 2002:a05:6a00:92a9:b0:6e6:6cc8:ac9d with SMTP id jw41-20020a056a0092a900b006e66cc8ac9dmr2491907pfb.28.1711719651433;
        Fri, 29 Mar 2024 06:40:51 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78d51000000b006eaec9b623asm899994pfe.89.2024.03.29.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:40:50 -0700 (PDT)
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
Subject: [PATCH net] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
Date: Fri, 29 Mar 2024 21:40:37 +0800
Message-Id: <20240329134037.92124-1-kerneljasonxing@gmail.com>
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

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa8c8ec2538929f18f2d
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..67c4c01c5235 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	msg->skb = skb;
 
 	sk_psock_queue_msg(psock, msg);
+	read_lock_bh(&sk->sk_callback_lock);
 	sk_psock_data_ready(sk, psock);
+	read_unlock_bh(&sk->sk_callback_lock);
 	return copied;
 }
 
-- 
2.37.3


