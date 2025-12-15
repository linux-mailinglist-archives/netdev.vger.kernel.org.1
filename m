Return-Path: <netdev+bounces-244826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C8BCBF5E9
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61FD530046DB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C173396EE;
	Mon, 15 Dec 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy8sho09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C312339713
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822168; cv=none; b=H4GQYuJU6y9mpwop9681JgOPdVmrPZsqvDfAehaEsYmP1oQLYEVBNyGUP4hwHtkk6yWbxqlIyd19pHiBJm5184EdbPU8E5N4orRS6FxhtUQ4PLyjcqmy9+LTHUET2SbGBVR3vaa84uPmcT2y4Fxprhgzluc4AU5bngT6xAEd80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822168; c=relaxed/simple;
	bh=AY0TkiefWWJxabFgVI1H9Em9SIdHO9Ae7VODUrXYkn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwAocBvuJy3hoEj7yqm8wD0lSFB14rjV8/7+EzAu09nw/hY9bQ3xNqgL+EL42jPZgofuVeW0K4Y3hvhtJi0Gso7VMBGMpcnEfl3MErxDwQggYXW0c+zOx46HN4c/wt/hh+HjbWHH8bpU3Yr8UluHuvFA+ZdG2zNnitu2UdFI85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy8sho09; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2950478b3a.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765822165; x=1766426965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKn5YS5dI6hedLIYw2DaM/TDp6sjQOBZVfOejLbhZto=;
        b=jy8sho09cDND/7sYU3u/Mu4hLyi/eOlNTTbMw4NenurAqbSZx8TtIEdLH8n31hV7u7
         XGmSfvXGXpnsMmQNArPXHh1fkpOk1QaBJRWSFpNS/Uej1sz9J1GvB+0b3pCTAwUo4ehq
         KNDs4Jc+X+IEHDXrNMXHcljfKgsZnv2uGU9Eeqi9z9DbYdDUmRyBzFduwUJaYwRVHLA/
         ADKYimfBhVlbbSEOBICVOfqYW3qgLZuEWzEmMN6cgixqvBrTISAVKQuHdXl3PYwanJl3
         DGOMu4z1AjruhNCKSUo62AFksV+VG9DZDgtoaCpZIyHESIG7xfDA+SB4ktgo1Ck95X34
         QrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765822165; x=1766426965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKn5YS5dI6hedLIYw2DaM/TDp6sjQOBZVfOejLbhZto=;
        b=qmgqTYF3TuSU73b79RHQrWWLIQ2B+vUA/8aMpSK30j8N24LhYJc71v6x5Nr0XZQr6w
         RucTXmD8CApV2scgh8/JrV79eSMPCFJ+JnkW9zG58LFICHk5OsXkKWWadNNf0x3EIU6F
         Mh1tMcAS5Qo0C/6Xq2sVQ+qu7K6tU1+C9V/ptIe+rqizAHp63tNvvT4hZRbHwSuGDCTY
         KHEUVkZ/7/v0X+jMVMh5ps3oyEMwPvKnmuUsNqaxGnA93ef9ezgbmPjJsefW5VzNwFyA
         vHTSg4fE/rmf9ClUecQND6wSV+YruV5iwJMWPBcyGDaeO86VaG8PNlHvBxnBNBqevIO2
         EdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVzGmG2nqjSZCPY3yHxIYJb73kSF85hDPo9Ixt0U//V2jJtLFAIkPWIpfFAf1z37kDHmgovCVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylKc+uIG2pShMkBJJ0BUjZwtvumvumhmsDWGSTHeRxf9SMNIe
	qkSeMJtXQa/j3C5k+utPwnYXG7oEa6PbkOKRz5HgfXxmqJORPNQtSk6q
X-Gm-Gg: AY/fxX774bcb3tc2gadWRLPbaH4y0AUPYNuhQbtPHUG2tmrp7Ocl1FNlwnyFI65YH5i
	rMXdhe0OUjtEHeeHnH029wd3oXi+YhV37S7Z1xyqyyzk/m05cH0OxuIS2eVQxh1u6G3LmU82BqO
	43SWOs5ZGMkCIk3I6TQIaMUcdQG0VPZC32rZnJQfdSGfJaxICaOIN7wevJn8VuVV05IKvBG6jbE
	uyJnYgI2OLL1UpbtlqPhCT5cfPYG02WAEkHeFTVbyMeWNLA75AW3ccZXUDqedEUqKuc0Z0v/pEs
	WBXOZSkwoM2yFPWbelQZNP4lkfhoWdpu9hN1n8L5ovIuX0pTfHxx0jH4qPuoowtGzD38mi2f5U/
	05zrkuocmPWt/8W1YMXfnhJ2zKsl94Olgb75GWnhO6k0ER19/i6tQWFO15aZ/KE6XR73LMDaVGq
	MKDnYeuQyB/nuIM7sGSNZHleJhxxLcfH9yNucKKvh+FvQDSjo6SQ==
X-Google-Smtp-Source: AGHT+IEdIn7/Xx2gZxK7oHVQGuBMB5XT5BC/9BQW5pH0KKPL02QkjBMaOLjCbrdxGlRAY3qDNRZF3g==
X-Received: by 2002:a05:6a20:3d8a:b0:366:55c4:c5a8 with SMTP id adf61e73a8af0-369adad45a1mr11687148637.25.1765822164871;
        Mon, 15 Dec 2025 10:09:24 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e346sm13138947a12.23.2025.12.15.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:09:24 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	"Weiming Shi" <bestswngs@gmail.com>
Subject: [PATCH v2] net: skbuff: add usercopy region to skbuff_fclone_cache
Date: Tue, 16 Dec 2025 02:09:04 +0800
Message-ID: <20251215180903.954968-2-bestswngs@gmail.com>
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
1. TCP allocates an skb using alloc_skb_fclone() (from skbuff_fclone_cache) [1]
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

In our patch, we referenced net: Whitelist the `skb_head_cache` "cb" field. [5]

Fix by using kmem_cache_create_usercopy() with the same cb[] region
whitelist as skbuff_head_cache.

[1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
[2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
[3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
[4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
[5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
[6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=79a8a642bf05c

Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reported-by: Xiang Mei <xmei5@asu.edu>
---
 v2: Fix the Commit Message

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


