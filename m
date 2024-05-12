Return-Path: <netdev+bounces-95788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBC8C3736
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0222813E5
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485044374;
	Sun, 12 May 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9XCstu3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363140BE3
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529803; cv=none; b=eKoPDXyDsJ53uPcSiYbHfaGaC6Nvq47SDdF85xNdYYFQSdWuCYp7V39qO2i80GvPzriWQiG9E+Pa9m1utrfdz/AWk5kTxgUhxklv9Cb0k7KNl4nCizyj1aUKkmCmvfuvHy+RCHan+mHf04N9XxgTnuCYDteyfeiMcCP18sNgqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529803; c=relaxed/simple;
	bh=nnpQKObQWjGso03RQYyIq/IQvAxeIapx5u3Q2E/gZ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tI1C/yFcElayskyq6uJYDnrMNoSd4PsOcTRmsnOWjnzQG92dRjyCBkuofnwwdS7mxl3r2bHIR5K3qYWLHejM4Dmyxuey8HYfnbAOmY/+eR4oqvq/61IuSC+X6vv89pXlB5lLwKJUr8c7x0+qXmec7y7Sa74L41fRWkUyejwpu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9XCstu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715529800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G2ulJj9uI1oZEabSSUR2f3WYwKzoYV6RqCthSWOFbRg=;
	b=e9XCstu3jiCXcfBdLiYKu4Za3MY5fBbB3iuQotG1gfrLqS8nUnA8x+7ixcSAcpzukr0/lY
	zYVx2xOOVWiBBv/1QOlHsb49kSolFBxu/e6Ij36kRpZJN8vBXfeYWiMngi/Q3xIrTNpav4
	yY8NeYyTPodsd8i2htizTn4+5XtwwkQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-UwH1a87kOOe2fv3OoLvb7A-1; Sun, 12 May 2024 12:03:18 -0400
X-MC-Unique: UwH1a87kOOe2fv3OoLvb7A-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f44b2e0bf2so3566551b3a.0
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 09:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529797; x=1716134597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2ulJj9uI1oZEabSSUR2f3WYwKzoYV6RqCthSWOFbRg=;
        b=efVoY5ENhYDGp+I88CWDHLVPviDs8L6meASgqWi9GbFyKlSpsoN140fWlKJvsE/GGN
         bFKhTZOW3UmwyeR6F4i3BSqqtv4YVsJ3zGVBgt+jX5tVANE91SyUjDQsSsJixerclaX7
         7ZfyVMe31quskp3q+R+Fj7CyYVJKZJD8hq69+Sbuo4EP1jA1EkSZPSvdOdCym5HUs7nN
         u66d5HUfIdAUblqcM5VSq363NrLlPQ9hs3WKz3jgkAlqMmhpm39b4/LaBRCqSq2PnO2E
         ljnWu/Dm29JfIJUkD5dqshYDO7T2/03TyTaEuDFUZcBY/lz7qtEDR2tsKibWup9cvMw+
         7DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiH4uj26UhH28D0MZmR27CfDJXDIMrWlHUtJ9qrlY5M82BhaHXRMzlkTu/PWc7CODVtzgbD4r5Pdqfmx8EgY1abOnLS2FL
X-Gm-Message-State: AOJu0Yw0YjIAVhgc+OWmqRx3tzemzxJSNkCdnbbdwZpjU/Gs/00VB1rn
	MCVLFLPz7Ra68oebsz0xWGvMXiun5rtbblIu6ULnerG92t2EZd/IjbTdeWlc6uKDBlD9hL7L4Fw
	d1NTcYpPKdIDNhOdmQyhc2gFHux+Wr36yDXP0qUyy29MuBEVuTrrHXA==
X-Received: by 2002:a05:6a00:1819:b0:6f4:8e8c:67f6 with SMTP id d2e1a72fcca58-6f4e03bf3c8mr9148722b3a.33.1715529796829;
        Sun, 12 May 2024 09:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaCYQslZhjcGXHELp01w9wNDL1sMcJagXNEsQ8JkcqtpoPCzIKs/Te+SnnPPdviLCaNjCTfg==
X-Received: by 2002:a05:6a00:1819:b0:6f4:8e8c:67f6 with SMTP id d2e1a72fcca58-6f4e03bf3c8mr9148603b3a.33.1715529794844;
        Sun, 12 May 2024 09:03:14 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f9eesm5858233b3a.212.2024.05.12.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 09:03:14 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: [PATCH] can: j1939: Initialize unused data in j1939_send_one()
Date: Mon, 13 May 2024 01:03:07 +0900
Message-ID: <20240512160307.2604215-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
creates full frame including unused data, but it doesn't initialize it.
This causes the kernel-infoleak issue. Fix this by initializing unused
data.

[1]
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:196 [inline]
 memcpy_to_msg include/linux/skbuff.h:4113 [inline]
 raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x2c4/0x340 net/socket.c:1068
 ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1842 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 12-15 of 16 are uninitialized
Memory access of size 16 starts at ffff888120969690
Data copied to user address 00000000200017c0

CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/can/j1939/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a6fb89fa6278..df01628c6509 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -344,6 +344,9 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	/* make it a full can frame again */
 	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
 
+	/* initialize unused data  */
+	memset(cf->data + dlc, 0, 8 - dlc);
+
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |
 		(skcb->addr.pgn << 8) |
-- 
2.44.0


