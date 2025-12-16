Return-Path: <netdev+bounces-244910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B0CC1A80
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E787B30287F6
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D0339B5E;
	Tue, 16 Dec 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5Tp6w5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4B338F4D
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875076; cv=none; b=EA6mdPtakE/EOPD/XaS2feh0RfaSqggUMNXdZcmoGm0CQaV7FtvSBj6TzJmBnxMC6pKRL7fX5MAPowxjVCfs92LpL5HJlc3wElBY5t/WSFlew5fQioSu75UMqTiOdHsMvRg3WWjxbG3mUvrM8/jX/SJ/vL425OuUFczzJ99fnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875076; c=relaxed/simple;
	bh=4Hj5ham1yB1eJb8Cp2KcS7etleyA9oP/nilhtpYkL6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B340oPjPjJZhP/lSswUSKp6dmBJiAxIa/MntsWTtfYesn8pt0JaP6V3KB6NMrCRXZsbcT+JfYRtPh7fdOTka1kPsOdGxkDY64yjvqSUD3S5oY1BHZ/q0c0TFrTWVB8zCFTEhV+9z+0CBPeNIzJ0upv5I+kdmgZRyQBkst8B8iJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia5Tp6w5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c902f6845so2495958a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765875070; x=1766479870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGWmoJurnVvqEVK0D+SFZwQpY/ou5W+h7/78vJETyRI=;
        b=ia5Tp6w5BVfVc8FYyx9Q8/Obd1vJ3+s9HPVRTg0tsAew8wSfyX/DPbW3+/lUim359s
         Qrw2Vx7u8rNFhKiOokL8KtK51ltYSmTJT0HjHxjk0XVZHkxHT01Mf8KsEHvfkm5FBpK6
         qkT7xtpPF0UThNFNQ6CJZIzmuVWq0Cxbnho0ZvHDVgHPbbzsKVq4uYRBXiU3K7BNs1Pd
         WHepyI1zApNoC92pI1olMiSjfpiEyVpjcS6NhwzmlEqsd0wuRchek2TblOTjW4gqtPIV
         XK2tH5PQb1kBFl1Cy0tqI/pwRAWFt6biIWB5/gP4PpUBGdtYrv1HSgnL12ANQcpqccmn
         DDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765875070; x=1766479870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGWmoJurnVvqEVK0D+SFZwQpY/ou5W+h7/78vJETyRI=;
        b=XGXst+qRNmcL95jsBh3lpzL1wPOrqJBT3PuKExddcKQGbH+S5/P+UvvJsiIh419mXR
         AjInKwA7Hwyk16+6rF+PPNismcaZ6JxV7gAAj474okyf5iYDZSxA83kMzKLSaNz5KbzV
         mVajtx+AsSUJJeVI3j0d9722gsXSKUefAhoggqOs8Xe45PYWFyw1+LM+t+7sVOsgs8sZ
         R40x//hXGktunCpHC7kO1Qebe9aH3UYzfRx4CiFITnGfy0JsLr4hOZKKENR5PZrXqXp1
         BSCTTU1aC9+N3v32+9GaX0pufNHOdcup3PYzjx98R7zOUjNddkxGSO9f6q2bEl/7EsCk
         v2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUsWFUbwr4osg/7gB7A805xC3n/tmHzTezRr2TeNt8KXf/FdCBs2Ryd5al9+NuQ1HSK7S6sN30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ynBhrc3rfST6UstG2Ux/KIVJTYwQ30xtyO00GiPfPBZYZgyV
	lK6Gr8eK79aV+JrTG8gRTuDUQuTgFM2N9UeLZK5LYypXBJFAlS0kf/hy
X-Gm-Gg: AY/fxX4zxm4y58FUYjNVxEQLMOKXUXv95gCt0cTYjjR3v2eBe+oJ8EzzsRVToNt3dIi
	kr5XIZ/d0yQ/fcbRmKa+KFIkrFzyarBieFsoZXGPzuI5GpT0Jn5vRYRd/2MNre/a/rzfMa1c0c+
	N75ndMLhQPGXZ3PPmJjouwgb01gUPjhR78agmuuglteAd0LXbyX69JCoyDsW5Wuezkn0GdFZjRc
	BJJIz71eX0hy/1Meo61gOK99HQqnq5TDiFwYyQHkGTDnrf6OlrOlxRlXgPIZMPIptBYxGkFccPw
	/aAPho+FmeA9Ntn/cLHSPHbYIHV0hfcOND/oyrEsutjhtrsWz87mnRucedIKBQKnkJloFKQDk2e
	xlKcAFLZkuj88Vj0MDHLkLQ3MwGJtxAVIFxQPF86rQRS6Y84trIf/btiundCzlBdO2p+d1hpk0T
	opDdU0/Bv+tfWL/exBhWWqpYnRUSKbEqAThiN4JnA=
X-Google-Smtp-Source: AGHT+IFoCThpDRd18a5JG43yNWaLywFxfYqEY0/mqIY+G1ArW6D9zHCWGonU2iGv07Usmgh5KK5Wbw==
X-Received: by 2002:a17:90b:2692:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-34abd7bad4bmr15301690a91.37.1765875069844;
        Tue, 16 Dec 2025 00:51:09 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b9d81d2sm14683175a12.26.2025.12.16.00.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:51:09 -0800 (PST)
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
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4] net: skbuff: add usercopy region to skbuff_fclone_cache
Date: Tue, 16 Dec 2025 16:44:53 +0800
Message-ID: <20251216084449.973244-5-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

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

The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
  - sizeof(struct sk_buff) = 232
  - offsetof(struct sk_buff, cb) = 40
  - offset of skb2.cb in fclones = 232 + 40 = 272
  - crash offset 296 = 272 + 24 (inside sock_exterr_skb.ee)

Fix this by using kmem_cache_create_usercopy() for skbuff_fclone_cache
and whitelisting the cb regions.
In our patch, we referenced
    net: Whitelist the `skb_head_cache` "cb" field. [6]

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
v3: Add "From" email address, Fix "CC" and "TO" email address
v4: Fix The Patch Code

 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..89c98ce6106a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5157,10 +5157,12 @@ void __init skb_init(void)
 					      NULL);
 	skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
 
-	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
+	net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
 						sizeof(struct sk_buff_fclones),
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
+						offsetof(struct sk_buff, cb),
+						sizeof(struct sk_buff) + sizeof_field(struct sk_buff, cb),
 						NULL);
 	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
 	 * struct skb_shared_info is located at the end of skb->head,
-- 
2.43.0


