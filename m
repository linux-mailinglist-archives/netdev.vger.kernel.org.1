Return-Path: <netdev+bounces-245911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15006CDA8F6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006203089451
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967EA3164B7;
	Tue, 23 Dec 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCNdZTx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C8315760
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522183; cv=none; b=k9reWP/kyYCjAF8WowLGefhrsV1KwEKTqZNDEbckfry/1hOvxUv5lBPBhnRw2QpgpHFXk+1C4j9uPZQcddaHXtx3uef37Hc18oKxqd4gh3BXwRQJWeN4n1+nnWLW3rIZthc4IkBae8hdA5tPhZyKbHVrouOfGVOEbLBhFb3yIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522183; c=relaxed/simple;
	bh=/Nccpglg2sCNvCsF7vVOy9nrDSxd6FnWQS59wgWVhtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJU5IN3oZ5MbTvs7WY1Y+nWlTPbEXR/3u2CYkUhakjZxqd2pgAlVkJbdO0G+0xpNiT21/ygWKK5HPfB6ir9RjIB9r0lodiSw99LVth730pRsrvvkD30cgGzhGGvdo4pFRdhE+cX/WQXK6/SwPJ8En/D6CFAcWHpf34+efPe006A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCNdZTx2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d5c365ceso67720295ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522180; x=1767126980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8W0pAdXDwSRhdNtMWGqkI9+0Gzu+9fko+sM3+ZxRRks=;
        b=mCNdZTx2ojHNEWkI1YZBFecoT0TZ+u+TvBfE+FzagYl0njXisdLIYjFv5g9tqW0U0F
         hR2XcJjYA9lqQMvopoiP7KZYl4RFvhsAAeFgiiVfI9mY3FdWWQzpmyEp7SER+4VwgJSl
         dB6GF2cyluF6DV6BFnPfmeyFnbGkjTfjKRuYKGXbAY92jYwHlAy8EJS/foNdT+heVVk9
         M0wJPCetbdikz2cCyN0yC8Iik6nPtifUz52SddIIML2ExcGtAtPLReUS+8MOMU8lIIuh
         FDnlsuShEDIEsLyW5b4OgkRXFY5ozB6Q2JJ7VnR13vTHYteg1xg622lkVVXNUNHOhlCC
         9u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522180; x=1767126980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W0pAdXDwSRhdNtMWGqkI9+0Gzu+9fko+sM3+ZxRRks=;
        b=H8x4Z4K53EK9DSmPaXhi0JeRj+1Pz35Pq/qXo50vM2OrLsEZMxDpzjHzhpt+Vm4WWr
         ojB8mQxD5eNeTENcuyD9A9ilvNhOYSfcKmAmQEUesnLxVbS9FwzIyFHR/zDrTfs2JR7O
         b3SjSOrFwvu1wzCmaNoYpEXuJKb7oD2/EcuogpQSJgyctY+w8hcBl/PbA/Mb6+Ec7hB7
         qc1sKgEWgjhXltZX99qII6eY6OJdF/m59PtqXg971TjvuqWE70Bw/LRMGzVAyWO5BJ7h
         ywXrVm2WKlM5TnC4Sq1Hlfz1W3QcYvEKaMZMyw6V9VF63viVit1/6lWYb0JhjLU9paBe
         RrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwkp+ngWFXBkeNMMYjkUfEEbsIQFOe4YRc6NR7EDaz/Vv3m7c8DdC0+ElGLI3AQ5VJ98HxrZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFsssp3pOo9KoW+C9zeBCGLx8DXYtwqVCNdaS71+g8S02CEoh
	JnfeQtEDf59QVsvqC9iwuii3P6fRVHd6cuVh/fOwEHk8aLoP3bxQ42Dp
X-Gm-Gg: AY/fxX5ixW3LHNHM2lbZMhYz/CpiR8COH+4olcsxU+vaLUyOmC6yaWBbZNSDlufXlMN
	HfeJlOQSw4h46Yo0zaEgH0+wZ+JO4wnSFtEEUOPDCyRQ7ePUi9jjMVDRH+swX6PITLmknNbN5UR
	pnWjDKlbcFSvwto7cM/qtY2o9uCC+2seZ5yGfSkpyYa/Q2oOuNzopyxWZIzhl002WXQdqriY8M6
	RLuwnBjrf4vk+d/YeLVefzrYCkwLzFCWR6QkhLNjZZOATouDd2WWq1dU7ctg4WfarNC4fNekWtT
	3tmspiko+5WzbKPcc/FrlEJniEVGTTjt0/nXx/rR4o+rIFr/56AQtFfU6F30jKq0J3Nw9YsLbvL
	w1b74wveqNFSwSLb3DAHOTVX9iwScVQSEh/ccIig2Vwsq0JhywuYkGCBpUAzXMvU66MmuSip54M
	7GFmQYyKHRvdUghRg9PtR0gPG5gGzgVNvoeRnIhEc=
X-Google-Smtp-Source: AGHT+IEWmGBvaWT9oSau2/R/fh/7OvDd5bOP9C8tPlI4eGo18oCy4AueFhwKRM0vwQ0K6zZg/1vwXg==
X-Received: by 2002:a17:902:f684:b0:2a1:3ee3:c6ae with SMTP id d9443c01a7336-2a2f293faedmr142818705ad.59.1766522179629;
        Tue, 23 Dec 2025 12:36:19 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm137245175ad.56.2025.12.23.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:36:17 -0800 (PST)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5] net: sock: fix hardened usercopy panic in sock_recv_errqueue
Date: Wed, 24 Dec 2025 04:35:35 +0800
Message-ID: <20251223203534.1392218-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

skbuff_fclone_cache was created without defining a usercopy region,
[1] unlike skbuff_head_cache which properly whitelists the cb[] field.
[2] This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is
enabled and the kernel attempts to copy sk_buff.cb data to userspace
via sock_recv_errqueue() -> put_cmsg().

The crash occurs when: 1. TCP allocates an skb using alloc_skb_fclone()
   (from skbuff_fclone_cache) [1]
2. The skb is cloned via skb_clone() using the pre-allocated fclone
[3] 3. The cloned skb is queued to sk_error_queue for timestamp
reporting 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb
[4] 6. __check_heap_object() fails because skbuff_fclone_cache has no
   usercopy whitelist [5]

When cloned skbs allocated from skbuff_fclone_cache are used in the
socket error queue, accessing the sock_exterr_skb structure in skb->cb
via put_cmsg() triggers a usercopy hardening violation:

[    5.379589] usercopy: Kernel memory exposure attempt detected from SLUB object 'skbuff_fclone_cache' (offset 296, size 16)!
[    5.382796] kernel BUG at mm/usercopy.c:102!
[    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12.57 #7
[    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
[    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <0f> 0b 490
[    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
[    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffffff0f72e74
[    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff87b973a0
[    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff0f72e74
[    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 0000000000000001
[    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea00003c2b00
[    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) knlGS:0000000000000000
[    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 0000000000770ef0
[    5.384903] PKRU: 55555554
[    5.384903] Call Trace:
[    5.384903]  <TASK>
[    5.384903]  __check_heap_object+0x9a/0xd0
[    5.384903]  __check_object_size+0x46c/0x690
[    5.384903]  put_cmsg+0x129/0x5e0
[    5.384903]  sock_recv_errqueue+0x22f/0x380
[    5.384903]  tls_sw_recvmsg+0x7ed/0x1960
[    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.384903]  ? schedule+0x6d/0x270
[    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
[    5.384903]  ? mutex_unlock+0x81/0xd0
[    5.384903]  ? __pfx_mutex_unlock+0x10/0x10
[    5.384903]  ? __pfx_tls_sw_recvmsg+0x10/0x10
[    5.384903]  ? _raw_spin_lock_irqsave+0x8f/0xf0
[    5.384903]  ? _raw_read_unlock_irqrestore+0x20/0x40
[    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5

The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
  - sizeof(struct sk_buff) = 232 - offsetof(struct sk_buff, cb) = 40 -
  offset of skb2.cb in fclones = 232 + 40 = 272 - crash offset 296 =
  272 + 24 (inside sock_exterr_skb.ee)

This patch uses a local stack variable as a bounce buffer to avoid the hardened usercopy check failure.

[1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885 
[2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
[3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
[4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
[5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719

Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Reported-by: Xiang Mei <xmei5@asu.edu> 
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: Fix the Commit Message
v3: Add "From" email address, Fix "CC" and "TO" email address
v4: Fix The Patch Code
v5: Use a bounce buffer for copying skb->mark

 net/core/sock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 45c98bf524b2..a1c8b47b0d56 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3896,7 +3896,7 @@ void sock_enable_timestamp(struct sock *sk, enum sock_flags flag)
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
 		       int level, int type)
 {
-	struct sock_exterr_skb *serr;
+	struct sock_extended_err ee;
 	struct sk_buff *skb;
 	int copied, err;
 
@@ -3916,8 +3916,9 @@ int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
 
 	sock_recv_timestamp(msg, sk, skb);
 
-	serr = SKB_EXT_ERR(skb);
-	put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
+	/* We must use a bounce buffer for CONFIG_HARDENED_USERCOPY=y */
+	ee = SKB_EXT_ERR(skb)->ee;
+	put_cmsg(msg, level, type, sizeof(ee), &ee);
 
 	msg->msg_flags |= MSG_ERRQUEUE;
 	err = copied;
-- 
2.43.0


