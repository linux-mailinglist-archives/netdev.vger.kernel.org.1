Return-Path: <netdev+bounces-232101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C94C011B2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 491C935A108
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175829BDA3;
	Thu, 23 Oct 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxsm4WQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024912B143
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222325; cv=none; b=IOikKK2imI+bAlFHeGCJ3T1FsM0zUvMiIpmQaU2siIhWqUJ8Qi90mUEv6WvH01/dGBljQ5XqtPn7JcI0Ub5NEQK5eq7QstN/XKDCLhEp7dEJPFkvj7l3/6HfSO8Tn6kK09BWgm+mxO6ksRMkJhwkkrNm67U/opz/e3prKfH4ouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222325; c=relaxed/simple;
	bh=gH1QxgpCetu7kizrxHoHHg7KTeThEjL3QD6Lg5r7T3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STcPy/ZTUGPaavhKkNi7OSX4nACdO4UOY98j4y7f1SsvSLvPvmM3VnrvaGas9WtVIdTjOtVjv2h4RUxNp9QP2qIgMZ2Jbs0H45pnebabWbzuBVTLpdtBVCR8DHZrJTrHASPQL6biiBt58jrdRh3EdttwA4ne+Z9Wu/hVIB8ls2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxsm4WQL; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b47174b335bso51179a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761222323; x=1761827123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QjTwYOzpkDEA/ocyG2cBj+uj0itR7zz8WtGEAMDG2s=;
        b=Lxsm4WQLkEU2ftO6zXUdMaY/4o6beUKaMEnP/sOwsHMmfLT+Nq92+GyFYDKf7jzZua
         QDJYcWIgvs2lWsGQ7zLwptMMdnYkaSpWoYSa4CqEEEMrIF28YTbMoF01z10C2CbrtvsK
         kfaDNVFRGxOXRWdmx7n0/Oy12Ja+VmMTDOFdCGXkMnMbWY8TiQWBr/CkO8dDUdZQhDVk
         3gRBVULAhQOApjNKPbk12Zx4kCm8k3uNtELJQjCtEftCypLHVS3umzfOWIfNVHLVsZrm
         pMWToGZtsRHja0CPdFND+CrndvrrAdmBWIWDjj3JaOUEgfUIIgMKJZl4nniIB7kTiumF
         MveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761222323; x=1761827123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QjTwYOzpkDEA/ocyG2cBj+uj0itR7zz8WtGEAMDG2s=;
        b=sT4HamxegFWezSokBr5y0laUdCFRiKPT8cMx6CBpptPNPDqNTdKLxOXT17Dwp827zo
         +D3YNBZn5jbxZflZ76dKVcIoqFTjnudYo9QwsUNevnxIPYZfyCUf5YvQZqmEQbnR11xn
         FxekedClw2XKSe8PGFZHq0EI+OcOrgDQoppFMb9/FP4eNgCYoghvfuLNPOhdOOr3fOL/
         T8dja8Y2xL9r5gWECMfw+pfsietTqjvM7rALJY11t3bicmMZrXP9B78J9qkxdeEBiJQD
         7fnu800QGdtcQ+CiGoqCA8QuVBBwr/v3k7OLb2IQYxscUs/6DrNTyv/2eiRcp1JtoG/o
         35HA==
X-Forwarded-Encrypted: i=1; AJvYcCX49rHF5KIoRIJ+IOtni1oflqlfsjysUwNPUjq7b6OTyA17ZFsrjrWYaBeHBqyMQS4ZWpl6E58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPy4tXjzcEdCycL9w3YNFlgCNYFqCNgopyiLdhleAfSSsI8+tW
	A1KFyWxjGkPOep4ARS0rGhCGsR0HOlJXK4JSZBtauaGd+WKIKxX19XZP
X-Gm-Gg: ASbGncuZinuCaD6wfA0SY/F7rAiIokTZvU21Q3uOZUq2lUO+wEJU3ODN6XWXj8qu1S0
	zuqva0taJHeJcSxEfv/KSi9jYTl6wmIjhZdgxPLojH7Wm4+b4b0MRlcURFZerAgo/ALvy+zjkYl
	iigr/p+rmhzynEZR9kNbm+77boyLnoXmAU3LlBaxAIXrFFnYCYf6IOB2LBMh3jxMZn7aewmN3lx
	SqbtUJFrvJLDiwiJNJA0awFopPnlivJQdNhsLO1Akj4G1ar2KXu0a0pXdfV7drdSu+H29VJdpS1
	OzNOEszdmjdub2gfzmquA1PgpcOqg4Wwon6FQ2LWRII3B4NMKpSl32IkAbXXsJWgNypYthyYEvx
	ofj+0YtJdfcCJplIxQszXjjj72ztyTNimrDl1jJaN2E1j7OokQlzWyj8gKSY/ujdj
X-Google-Smtp-Source: AGHT+IF03IYVuLtHNljpmyJKTLX2ueFVUYHymHpr3RRDRbspFMhGN0rwRau6yUsKDSVnk0QDFNmA4Q==
X-Received: by 2002:a05:6a21:798a:b0:339:a6ac:a69c with SMTP id adf61e73a8af0-339a6acce4emr5522071637.5.1761222322927;
        Thu, 23 Oct 2025 05:25:22 -0700 (PDT)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a27d583970sm574079b3a.51.2025.10.23.05.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:25:22 -0700 (PDT)
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
Subject: [PATCH net] net: key: Fix potential integer overflow in set_ipsecrequest
Date: Thu, 23 Oct 2025 20:24:51 +0800
Message-Id: <20251023122451.606435-1-1599101385@qq.com>
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

The root cause is that there is an integer overflow when calling set_ipsecrequest, 
causing the result of `pfkey_sockaddr_pair_size(family)` is not consistent with 
that used in alloc_skb, thus exceeds the total buffer size and the kernel panic.

The issue was detected on bpf-next and linux-next, but the mainstream should also 
have this problem.

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
From: Cheng Lingfei <clf700383@gmail.com>
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


