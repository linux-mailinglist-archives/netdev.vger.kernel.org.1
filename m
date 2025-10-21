Return-Path: <netdev+bounces-231075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37558BF4723
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 05:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 556B7351A50
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9DF274B4A;
	Tue, 21 Oct 2025 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw4ONpJE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2596287503
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015651; cv=none; b=WiyacbInponqetNJvzroihZPFUaSM3IZPnhQrTVeuMlTr6dWVY+qpZMunWZS+BOdaCU31xw4ZTreSL2Ioe20bTtfjTEK6koFQi7R5d2M0eqRlmB88brfA0H3TKhAzDGmx9m3dm3qbWBpwlImhGsc1ny/NyLY+s72w/AWEkg7N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015651; c=relaxed/simple;
	bh=VjjuVOLJyaMjpKyFa3e/I/CAEthbc5Jq6lZpMmuNKcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jj9n77cPCCwfpPLWs1+KGB3MD7UHZdbiEx2qczy3umpIhA1EHNW9z/FnEFPRFnIKJfOS6N3wVCL1G0aFPuYZVP2NN3nFP2g3W4usNAH36hIrWTLE9ImeTeLMFy2ZwA768lf76OyJLYtB9IB9smsRflDY9+i4OFwBZr4dBJWbnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw4ONpJE; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33bba55200bso959162a91.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761015649; x=1761620449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYh7z0PspQMFROHdfCjCd62qi0/IJ1qC/tFhUi1CPf4=;
        b=Xw4ONpJEThtMPrVjqQTclMB2gAWwfpQ2rZMlrHTdU1mORrca9WZDfOTKNOGltPTS1J
         udE/i703VQRXYeD9iogaAjPgHuhbuj052mPV2AmuoSb2mfAq2tR8Eowhl8a/swaaUhVB
         yWPTHVg81xD63WWAJh7eIGbNKPEZ7YDRyrjztZRo2h0vozzOY4mTDhPs3+5K9Ra6PhRO
         CFdTd2f9MVqBiTcBEpe+m4w87grVXV7L0YyCKW+9Apkdl3WKniXt+M1IW3FTLEGJvWMY
         kmugpWDEHh7bZAYNbXoz9aX/FygPZP6jp2h7Cdk/rcQhjkgdPO7a9kaTr70/jjA2OJAp
         v98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015649; x=1761620449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYh7z0PspQMFROHdfCjCd62qi0/IJ1qC/tFhUi1CPf4=;
        b=koVjMoOmRmrMvAcuZu0Kpuwbfuo0EE9OgS1DXah8CxfHpuf1p4YVxOvfbO0PHouVFa
         ymRqdjykUOcGBcyQAmU9FF8kKdj0b2VmyReFuqsGgmbeKhO8Vdse7KNIGhLiX3jozYUE
         lykH0sLc5UfksJxKBAkyk+n530WNTE3vmQcHAHp2DfA9IO44g9+Az5RZsx9Nz/RzFq8m
         ItZ8U6N+4KCUxQvr7fpdvlYsbcJIpHo8f3tjKT+WsQZPHDKRKGH4XaI0zt3I9HpoM/qL
         c5ZqNKQ1fTZwYMpK92nctAMXp16x5oEvt4iD7DLi1AxJZWeFoGBDVPEIMMFGaWMeoQzp
         VIMA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtg4UZgmJN+oVMXnOSE+IU2RJkPrCOJUFv0+MZ26g5vls+nJNUhWvMuAK1BXJUxnkCYdn31s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2D+pn2ESN/K3iC47kNvVGn8U9SIkQAEd9iTxrIBBo0o9ynq2
	N8biwrely6G5ec3P3PDIXQhTO4sATdPESH+zyUugO5peB+zbvlrqhvkE
X-Gm-Gg: ASbGncuxb97XTQZHEviFQYiBcCA/c1pYVtafDDkDBNgkfoy65GTFkxIvwPFTnCn5CJd
	QOAz3RYJy0EccWsG8kl4sIh0pwlx7Na324MgwoQXmaCiZgom0CDSAH/DAU8nF/PCLZAhtyS9dc3
	2fvDi6d8Jwb4Ph6Xyi+R3ibdC6OUVxw19e0LV4bO1HqiuVjT3gl+7Ifmy0bOpRlbsqpQtqBdrwR
	xvrcoytLJ9tTtbd0wH0P3AvWivABzWeTGIRcQ9ZSgdJ90j5hSqn+5zTbJUb/4/CSYtT/SV9mIBE
	5V9LXu0ueJPSAVmGEPx1ka7HwHZcQTeUyvgACxaOwGizh9AjFceNRHFS0r3Un7sozAiUiLz3dIC
	vjKPBF95E6tYvRVatRdQOhfFUyfgNwt/gmghyeXvPmNVNavbDdPEE4u693580Useb
X-Google-Smtp-Source: AGHT+IHjw7vU4Xrexk+rh7QUuZtiKSmQzFlMdKvp5Fcm1oLPnvsLVK5XV6KocVys7Y7/pKFhJ701+A==
X-Received: by 2002:a05:6a21:e584:b0:334:8a13:8939 with SMTP id adf61e73a8af0-3393246cb38mr1372698637.8.1761015648730;
        Mon, 20 Oct 2025 20:00:48 -0700 (PDT)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b67fa4sm8927792a12.33.2025.10.20.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:00:48 -0700 (PDT)
From: clingfei <clf700383@gmail.com>
X-Google-Original-From: clingfei <1599101385@qq.com>
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	syzkaller-bugs@googlegroups.com,
	clf700383@gmail.com
Subject: [PATCH] fix integer overflow in set_ipsecrequest
Date: Tue, 21 Oct 2025 11:00:35 +0800
Message-Id: <20251021030035.1424912-1-1599101385@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found that there is a kernel bug in set_ipsecrequest:

skbuff: skb_over_panic: text:ffffffff8a1fdd63 len:392 put:16 head:ffff888073664d00 
data:ffff888073664d00 tail:0x188 end:0x180 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:212!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6012 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 60 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 
41 57 41 56 e8 6e 54 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 
90 90 90 90 90 90 90
RSP: 0018:ffffc90003d5eb68 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: bc84b821dc35fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003d5e867 R09: 1ffff920007abd0c
R10: dffffc0000000000 R11: fffff520007abd0d R12: ffff8880720b7b50
R13: ffff888073664d00 R14: ffff888073664d00 R15: 0000000000000188
FS:  000055555b9e7500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b9e7808 CR3: 000000007ead6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2583
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532
 pfkey_send_migrate+0x11f2/0x1de0 net/key/af_key.c:3636
 km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2838
 xfrm_migrate+0x2020/0x2330 net/xfrm/xfrm_policy.c:4698
 xfrm_do_migrate+0x796/0x900 net/xfrm/xfrm_user.c:3144
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The reason is that there is an integer overflow when calling set_ipsecrequest, 
causing the result of `pfkey_sockaddr_pair_size(family)` is not consistent with 
that used in alloc_skb, thus exceeds the total buffer size and the kernel panic.

This patch has been tested by syzbot and dit not trigger any issue:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Tested-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         7361c864 selftests/bpf: Fix list_del() in arena list
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1089f52f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bf83cd980000
>
> Note: testing is done by a robot and is best-effort only.


From 6dc2deb09faf7d53707cc9e75e175b09644fd181 Mon Sep 17 00:00:00 2001
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 13:48:54 +0800
Subject: [PATCH] fix integer overflow in set_ipsecrequest

syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic.

The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives
family as uint8_t,  causing a integer overflow and the later size_req calculation
error, which exceeds the size used in alloc_skb, and ultimately triggered the
kernel bug in skb_put.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Signed-off-by: Cheng Lingfei <clf700383@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..08f4cde01994 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    uint32_t reqid, uint16_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
-- 
2.34.1


