Return-Path: <netdev+bounces-244798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C066ACBEDE9
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31404308EAEB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D932AAC0;
	Mon, 15 Dec 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic0eV62r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E032D440
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815255; cv=none; b=WePRqBWySA030lnQx3SckvgvROdkyyhV0PsV7B12PVSsLOKqDC/vaG9ITptoDNQA8dBZEvnZtUfbcG4agHIh5zN9DfFfgDmv7vDTq9Vs/vwQ5WmiCBcOIPJjxv5pGf+pvL5rVbsOPUtfCW7wZv9kQyoN8gjpHcHH7Z4oIXpLHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815255; c=relaxed/simple;
	bh=Ycrms0a27bWMQ9dWLzY45ujdY9fJv5SkqXco4JnMjmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkUh6Q7Kk1sg+fuMytVotwoyk2bOvFQUXVP6HYt0xO6RhiHF0vgwbcho23+L9NNtQmnHm07aY9pV+1KUmVBzEaPQsZOZIPk2V6bTlfEEjHGdtDAnjqXa/EsLtnPOtUUgFdNFfZOZKaq+k2+KblfB7iCGP5E9LrjRiKdR3EYlkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic0eV62r; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7e2762ad850so3746991b3a.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765815253; x=1766420053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gA1e7uwDpCK4A+8+gu2pL0WPEiNpjwE7K864c8JBFfw=;
        b=ic0eV62r7FXBAr+R+37YAqdsJE/Nj9/DUcnYPX8ZcQ0vsLRzm3hpWPQS3/oHimJChl
         Hs1blBlON0Op64HTMrnY687SH7UvuJs36xcIMhw4+92QDlnIgPiwcy5Bu85Z6nGsT/i5
         3rCuu/LigF4wtYOZStQ+4tV4oxWKpEWnM1V5HuJZ0kl82ZwG8z3i2myK6c8ISGFLuKKG
         V+GnqvrAI3lkn/DK/enVingCUaUu67ZsANyqkEoZULnmFdLaDjnUyeWSqm9d5u5qbIne
         OL7sTMRU7bzX8N5E4gYM35b06jQk8vsDPIe7ZGrkUVcUR6+vvC0UBHmVYB4y+kM0VH91
         U79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815253; x=1766420053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA1e7uwDpCK4A+8+gu2pL0WPEiNpjwE7K864c8JBFfw=;
        b=WqNbfhYz2mOAZ0qZCFNnoOSisGCgERxoL755sn8kUeUlV6XoFp0DDQaKFyPlobSORa
         K9FMLDDoDrd2G9iSCKXy5YOphNEor82nrns7kW8gMZ4GuBcEUO12eh3WlzVZHah4z4r6
         0abQeSGq58IX1+TedxZ0OanYRIT+gGpZy//3xazWSnCfjg54DWgTlA/TIA7IAEc4R5Ki
         EGLp2QRsWUPk/pnsDpuW+qQ14Zeo7R9TAu6GFpo+tuCwBvDlev9pXdOwZ3hVwj4bZ6XR
         lGfrymGgkndkXmQc1bnxBfya+2oyYzLd6qL6EeZehnuik9lSTnpuAKIDGL7Ox54oQh6z
         Vf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFbw2Heu79qAy+BR2esu3vFXiNAnrmgZBUrwPw8tJeQuw1Vd0uc206ZwgDhJYg2iXqgMVWXrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/sHAsyUUB6I8JNdd7LoRPdXta7HIHXATveDlvY/9n0aPz/xQ
	dH7ka9L/bQGTYiarmnUrdGA8sD9NF2FioJ2HKfOkmn0fa5VJaYRVv5uP
X-Gm-Gg: AY/fxX6Bsy7pXJzaHTYcRr0ISNe652hwje4cyzS0RMC3tUAzM5VO0w1uD/yzNrz+wn5
	nGPu1ePdnnRX6rLkLSKj8+YhjTpTLrRrOMWpxdmwtX144pcucM7QFxrvJtr8wbpVEJzSUZVahTI
	QZtIcgZOXS+fnWTK6KQtME3cpzBQG4TtwcCJGxgmA4zbHMYU6KKbhBnenF4Yy/ZCL6EkqcL+veH
	arJc0Mfe9GI8ieYIpkmXa7ZwFsRgR3Z4+E3M/idUuJGdyjDmN5V92udVWlj5XAY21ob+5FfRBcr
	5SmpVZpw+BL9fr65TiK5xowjmcLJHn8ixLPuZxYlpsUkUkWH2pyXhSvSd08bQ3Wna75MVWRE6ER
	POFi3tQ0qJyT9K/yXSkCALkuRdwEvVM/1hjs1w8j+lRxCMH60NPP5fyHHycGAIP5lHVnzMMIiya
	p+futlLmuXT9ss+/bb2kop5H3caUvmik79m7Z6zK4=
X-Google-Smtp-Source: AGHT+IG05KYfUs6yt+TONl4lbgKDBzRuK0eG70yfvO3dI+h/ZXRRw6BYmY3LHRmA599VLprJoi2cAw==
X-Received: by 2002:a05:6a20:7344:b0:341:5d9f:8007 with SMTP id adf61e73a8af0-369b00eb6d9mr13585208637.57.1765815253028;
        Mon, 15 Dec 2025 08:14:13 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e3casm13371814a12.21.2025.12.15.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:14:12 -0800 (PST)
From: "weiming shi (Swing)" <bestswngs@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	"weiming shi (Swing)" <bestswngs@gmail.com>
Subject: [PATCH net] net: skbuff: fix usercopy violation in skbuff_fclone_cache
Date: Tue, 16 Dec 2025 00:12:31 +0800
Message-ID: <20251215161230.950750-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net: skbuff: add usercopy region to skbuff_fclone_cache

skbuff_fclone_cache was created without defining a usercopy region,
unlike skbuff_head_cache which properly whitelists the cb[] field.
This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
and the kernel attempts to copy sk_buff.cb data to userspace via
sock_recv_errqueue() -> put_cmsg().

The crash occurs when:
1. TCP allocates an skb using alloc_skb_fclone() (from skbuff_fclone_cache)
2. The skb is cloned via skb_clone() using the pre-allocated fclone
3. The cloned skb is queued to sk_error_queue for timestamp reporting
4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb
6. __check_heap_object() fails because skbuff_fclone_cache has no
   usercopy whitelist

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


Fix by using kmem_cache_create_usercopy() with the same cb[] region
whitelist as skbuff_head_cache.

Signed-off-by: weiming shi (Swing) <bestswngs@gmail.com>
Reported-by: Xiang Mei xmei5@asu.edu 
Reported-by: weiming shi (Swing) bestswngs@gmail.com
---
 net/core/skbuff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..419bda42560a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -622,7 +622,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
-/* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
+/*	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
  *
@@ -5157,11 +5157,14 @@ void __init skb_init(void)
 					      NULL);
 	skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
 
-	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
-						sizeof(struct sk_buff_fclones),
-						0,
-						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
-						NULL);
+	net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
+		sizeof(struct sk_buff_fclones),
+		0,
+		SLAB_HWCACHE_ALIGN | SLAB_PANIC,
+		offsetof(struct sk_buff, cb),
+		sizeof(struct sk_buff) + sizeof_field(struct sk_buff, cb),
+		NULL);
+
 	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
 	 * struct skb_shared_info is located at the end of skb->head,
 	 * and should not be copied to/from user.
-- 
2.43.0


