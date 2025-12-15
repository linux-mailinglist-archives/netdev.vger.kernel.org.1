Return-Path: <netdev+bounces-244828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648ACBF6FB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C32D30053DA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0E2D6E7E;
	Mon, 15 Dec 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwqzu3wY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25B19D8AC
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823487; cv=none; b=J62j24B3d7ejk4eCm2fVpBRvldX18mF5GMRAZDzob0EcRn1zfW6/Nnitl+v4RubCnpRW4Zx0U1SMDvwBHHQWqD6NZmkF+sM2WEYKBzyV4n8UbjHqCkOI/u+r0TYd2CJTd5UchejFEzc+pa9KWxl12uUHwt79vEPfKm57HzTugRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823487; c=relaxed/simple;
	bh=4fD5Zg3iwUVMs3vNint5/CmO4+UYUPnmOSzpBuFjcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZobEYYG18pnWfB4D+gfgUUCYY5ST2s3V2kwC3KwItqO5GuM1K17suJDWIbGKDL3xLxKvao8eBc04BA6EV+ZFrx2/sqq0a6MU40MuFy5xu7B/KmLjK3/wr36qcRAiRwUU8sE/ujOPioUuLgYaBODVZYRmgECpG9Zp4B7IsatdAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwqzu3wY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0bb2f093aso18880835ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765823485; x=1766428285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts9vx4lbDf7SIWRrocd9S3ZEWBKTDnibYwQZiHwQQnA=;
        b=Iwqzu3wYzIrLRRbeGmdGNkfRIRvkmFWjMEuPMjfzeipJPElGV5mVzYrGi/26+RFzni
         yCc/eZYYzU8a5NLTsbAPV4Nk9HYjDSRb5zNW0hqVqdXEAu28FHWpHE6/c5dFHeccRxUB
         rmp795w+gjXOBe27f5RV9wDokdguyNNpYUNwIGAaZjEDKX59MBIr8hVg61hKaD/HemCC
         pHggowl9YIOyLceHTuXWZ4ujfAn+nkjsAlnV96zEV16l76BxRlhtwkBIK5UbGhDsRAmo
         CN6iZD40spLLzJ+tQ97R/BhbFIg2Vh+JXoJLemHOr8qHf7ZL/djkfZocad27rluqONjy
         PpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765823485; x=1766428285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts9vx4lbDf7SIWRrocd9S3ZEWBKTDnibYwQZiHwQQnA=;
        b=PNsQEWsdNoz5rS9RW+siUmewlFW1UqV/UkX/dtCRiIq5eQKSZzQXMv39XuVd4GKS/q
         o/iHBdb4IttCAitSixoZPo8IwiflCTrl+HdrEPf9y6M+UUOAG+a10Z3PHt/pcgeQwhWt
         HYnAPk4YyWczizZmPmbG8rOszv8cXghHAxwqAyy5aY71Ivu9v30Yr1y2Xf6Ua0q+Eykj
         Wsa2MELeNmmJpTQb32kWiS54PbQVzDyuDKGEqC6eOYHt33r+ggef5Dk7eHIzgsxNok5t
         gWkSCMGxAsFqYeBP37FhAU9T+czmlN3Znm33mnKBT8XVcsLLcFJ035EqzMSG+FPSlCoQ
         X5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxCpz16GqXvWPsfVDEJXhdyX32QbyTf4AQ4ZmHsI5aw915EETKyAcLvj53sDd55H42yjjS/YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEevKon7HCzNhKg70F4/0Fuwt59adK2ZbythoRnOXrJNDJc38s
	A1jVk75Wlo5dmLWJVz4xRj1BoCu8QKvsrMR1HSyCtpP6l36QGLAgbGF4
X-Gm-Gg: AY/fxX6wNOjz+5vEvkpkOFyCZ7AxFHsiawMGxAlHhb0W3IFyurH/2+nMz5LlF9iZJJs
	z8R2FL0dyEMOWJ/hW81oifHviZf6R+HP0+rWa1FKHZ0QCFypk4EKczeMQ78w+eiuRfLBUIcYbEt
	9mOnr5PKxql0kU19L5fKiRB0N7xGnhET7RMUNSDTXKVzdqaeVUTQenTxIXVFvodfZnvaC7jdq9v
	Dl2OeS+y/OPt08S78m6RJaay34Ey5gu5e4w1L/JXLm9/8ApIVhCmbUwiFDs+7Jm2gnzwbp9tQ8m
	Z1SvXpRiQfSyZFXSmDyoIkBrsYRfytMDS8QEwcvzZKlxwL4oyCy49/DPqAU9X0qWaCRj7zF271m
	V8S9lkyqbmlR/lvbKB1LCwgnewecjhQKiWcdlNthuga373xzeFl4V2esrvxjPSzxgqXJlfwAu2v
	xTs54DNu2vKCjB5gdCJxImn4yRNRnOYJDkLLOgJ4Y=
X-Google-Smtp-Source: AGHT+IGRPeyH64m1e7ktoJoSQ6oCxFED9RrNQpBKEfyYSaGdXux3w5BCzl6rn4QI1bw6oBNRL8uY/A==
X-Received: by 2002:a17:903:40c5:b0:298:4ef0:5e98 with SMTP id d9443c01a7336-29f23d2019dmr116659585ad.56.1765823485320;
        Mon, 15 Dec 2025 10:31:25 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f25cb1609sm106467285ad.57.2025.12.15.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:31:24 -0800 (PST)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	"Weiming Shi" <bestswngs@gmail.com>
Subject: [PATCH v3] net: skbuff: add usercopy region to skbuff_fclone_cache
Date: Tue, 16 Dec 2025 02:29:14 +0800
Message-ID: <20251215182913.955478-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Weiming Shi" <bestswngs@gmail.com>

skbuff_fclone_cache was created without defining a usercopy region, [1]
unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
and the kernel attempts to copy sk_buff.cb data to userspace via
sock_recv_errqueue() -> put_cmsg().

The crash occurs when:
1. TCP allocates an skb using alloc_skb_fclone() 
   (from skbuff_fclone_cache) [1]
2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
3. The cloned skb is queued to sk_error_queue for timestamp reporting
4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb [4]
6. __check_heap_object() fails because skbuff_fclone_cache has no
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

In our patch, we referenced 
    net: Whitelist the `skb_head_cache` "cb" field. [5]

Fix by using kmem_cache_create_usercopy() with the same cb[] region
whitelist as skbuff_head_cache.

[1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
[2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
[3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
[4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
[5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
[6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=79a8a642bf05c

Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 v2: Fix the Commit Message
 v3: Add "From" email adress, Fix "CC" and "TO" email address

 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c52e955dd3a0..89c98ce6106a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5157,7 +5157,7 @@ void __init skb_init(void)
 					      NULL);
 	skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
 
-	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
+	net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
 						sizeof(struct sk_buff_fclones),
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
-- 
2.43.0


