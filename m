Return-Path: <netdev+bounces-207370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E088B06E67
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFC41A6205E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DB289350;
	Wed, 16 Jul 2025 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQSfSJIf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F7286D46;
	Wed, 16 Jul 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649279; cv=none; b=TwZzlmrChUVPVGnlh/2k7BqLVhPqfaJGSZmwMFnMcOKO1AbtriAW5AkkJ9b7tQ5vo+8+IqwjPNWcrZ1g0Tz0n2dwb7TMIA34XHiQWvzDUizfKAJ/gRX9IZFUsDTriU51tbWT9EQ5GY+aA3QVhQaBaXT6GAqT/3tAowWyjMO6uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649279; c=relaxed/simple;
	bh=2va2SQScBnnEYYo9gevadfn0UAwMFkcSFusOEtW5pSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sm+/hrOe9SodgPvqo/nsJGwGmWoCqr/FYdtUL2ciDIoDhSyI4NKLGbSdPUcsCtdB0bkcO/tjC15F/EmcNjVcWD4ggP7Yyk3Cs1yCiEAOW2L17qfLahYAzC9Ey9KVx3SBGsJ2ts6ocDDlaWI1NpMb51oZ/RUf+C4rJGfXY5jkLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQSfSJIf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3998680b3a.2;
        Wed, 16 Jul 2025 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752649277; x=1753254077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+GPfnHGx9m/PlNdIJKdtphvgV6qX+JOK9jrldM8AhU=;
        b=fQSfSJIfH9W8KDg3z2zxGpPWU8qY3k+MmjZg+WkwnUQgAGQV+jNLALL24fdFZb2oyR
         d7G+9/1dEvlktEXJyL+1i5SbxZxCO8tcijBURFehOZSlCvuZLucEvEBFvjR5OcI42CN7
         VaZH9IUc//1BJOKiFEHEQlJxAPr7HO+OYnL74J2e6v2Wm7wkphdOCCQ/0ngQyqaXdRjX
         1BUgo0oCztWR5gU0q8J510GbrE9AAcS9H+uF5wVvkuBdav6f6gygTxfPmK6LgNfYCmoQ
         ufALGiaieRmjhikQA3TRLfDy3P1YIhTsBv/8IYXPciQu0Zpxy8MG4Oh+SjyEful4Zf+E
         sPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649277; x=1753254077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+GPfnHGx9m/PlNdIJKdtphvgV6qX+JOK9jrldM8AhU=;
        b=GctA+qkQex8zyghi3xV1r5SezbbsCL4LtPzf/SYdmv10GKGZvJZjCMzRhTwnkHN+Pt
         7+rlQNq3c3e9z/MFtpnrDCK+qM50Ul0qm7/cF4vGO5rcvTNXv/QB4yLB7ITwwsJlCehD
         l0CTj4UUaCGzvAEkf3rAPU8HbHvaSInno/iw13u+I0Mm7fHrrCQwajlYmuDpZHAqqh4o
         t+rL+meSOO/rnBszoYCNpeRMNKOcLgFEBWUsA2ecpVoK9WCwCD0ldWYKONdSMlxuZWVn
         SoWJ+J7xvJ8LABl+DceExWisikcicFp1dlJyk9JUFtRfnOmgnMX3xQzDV+la+M1VpQb4
         Ijzg==
X-Forwarded-Encrypted: i=1; AJvYcCUjFcuOHkFiJMJbtPEIudmAWBXc1Xuohm6EwO4itOeXBwTQu4NwtP5LSOXJTgHk48ntXJjpMF0r@vger.kernel.org, AJvYcCVF73x7DiDtREahijgoeZecs3i5YF/bKhvv9GxvSiZUKUFaswp6zXpBemM/U12CBJXVrNMoqO1IRnYQ53I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIU+O6gKELYyMhP1y5+WDproIuwLHoT89rajnl802+dMFFtJH
	BW5cB4ocr4NNp+lUeK5v8j2gbb1vYyWg3DQC54Kt+dmSS/YUFdztE3l1
X-Gm-Gg: ASbGncuHFC/ibroFuDsAoDPck4QFAdu6CvM+4PK1rL+O2MgJxlPIG303eJKSQ5VxOZ2
	2iIx1KY/HR/S2CH1mSNI9iN54fiLYFiK7t/nseb/EcZAv53IftQxBsd6Hvyq5PC6GZJG15JzDRz
	N7nhjCHNA9v6pJ5qSJtBdW9yh12bLqXY5T6DTpt9cjHMKDk5pEeNzF83yMfdRQq0IHE72o2gHjP
	LIZdpcbUr5KpVBRPXWTEsY7dsSCfy/1GqLctRvVj7U6zGoGzX4HPeS/cODo3cJym57d6PKCzlpc
	lcngU6FSTtII+4lTjHuX1rtKNmtyKYQ9rsxU+QH1Hf8XbVLcLfzQKsbvmcftWFqHp5L8xEAIbh0
	1fx5096Ecqb5kzgwUb+ihrRrMTlUw
X-Google-Smtp-Source: AGHT+IEvysHCfTX8GcAbRXR3uUaPUplrWU9r8SBAcB4WDnm4IiwmzS05fEwdydHXp4qwARtYpVbPMw==
X-Received: by 2002:a05:6a21:6f06:b0:234:86ce:9de1 with SMTP id adf61e73a8af0-237d5a04ad2mr3260363637.17.1752649277528;
        Wed, 16 Jul 2025 00:01:17 -0700 (PDT)
Received: from syzkaller.mshome.net ([8.210.121.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7341sm13720073b3a.15.2025.07.16.00.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:01:17 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: davem@davemloft.net
Cc: "Kito Xu (veritas501)" <hxzene@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: appletalk: Fix use-after-free in AARP proxy probe
Date: Wed, 16 Jul 2025 07:00:58 +0000
Message-Id: <20250716070100.708021-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AARP proxy‐probe routine (aarp_proxy_probe_network) sends a probe,
releases the aarp_lock, sleeps, then re-acquires the lock.  During that
window an expire timer thread (__aarp_expire_timer) can remove and
kfree() the same entry, leading to a use-after-free.

race condition:

         cpu 0                          |            cpu 1
    atalk_sendmsg()                     |   atif_proxy_probe_device()
    aarp_send_ddp()                     |   aarp_proxy_probe_network()
    mod_timer()                         |   lock(aarp_lock) // LOCK!!
    timeout around 200ms                |   alloc(aarp_entry)
    and then call                       |   proxies[hash] = aarp_entry
    aarp_expire_timeout()               |   aarp_send_probe()
                                        |   unlock(aarp_lock) // UNLOCK!!
    lock(aarp_lock) // LOCK!!           |   msleep(100);
    __aarp_expire_timer(&proxies[ct])   |
    free(aarp_entry)                    |
    unlock(aarp_lock) // UNLOCK!!       |
                                        |   lock(aarp_lock) // LOCK!!
                                        |   UAF aarp_entry !!

==================================================================
BUG: KASAN: slab-use-after-free in aarp_proxy_probe_network+0x560/0x630 net/appletalk/aarp.c:493
Read of size 4 at addr ffff8880123aa360 by task repro/13278

CPU: 3 UID: 0 PID: 13278 Comm: repro Not tainted 6.15.2 #3 PREEMPT(full)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc1/0x630 mm/kasan/report.c:521
 kasan_report+0xca/0x100 mm/kasan/report.c:634
 aarp_proxy_probe_network+0x560/0x630 net/appletalk/aarp.c:493
 atif_proxy_probe_device net/appletalk/ddp.c:332 [inline]
 atif_ioctl+0xb58/0x16c0 net/appletalk/ddp.c:857
 atalk_ioctl+0x198/0x2f0 net/appletalk/ddp.c:1818
 sock_do_ioctl+0xdc/0x260 net/socket.c:1190
 sock_ioctl+0x239/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x194/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Allocated:
 aarp_alloc net/appletalk/aarp.c:382 [inline]
 aarp_proxy_probe_network+0xd8/0x630 net/appletalk/aarp.c:468
 atif_proxy_probe_device net/appletalk/ddp.c:332 [inline]
 atif_ioctl+0xb58/0x16c0 net/appletalk/ddp.c:857
 atalk_ioctl+0x198/0x2f0 net/appletalk/ddp.c:1818

Freed:
 kfree+0x148/0x4d0 mm/slub.c:4841
 __aarp_expire net/appletalk/aarp.c:90 [inline]
 __aarp_expire_timer net/appletalk/aarp.c:261 [inline]
 aarp_expire_timeout+0x480/0x6e0 net/appletalk/aarp.c:317

The buggy address belongs to the object at ffff8880123aa300
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 96 bytes inside of
 freed 192-byte region [ffff8880123aa300, ffff8880123aa3c0)

Memory state around the buggy address:
 ffff8880123aa200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880123aa280: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880123aa300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880123aa380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880123aa400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/appletalk/aarp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9c787e2e4b17..b70a73b6ebad 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -35,6 +35,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
+#include <linux/atomic.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -44,6 +45,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
 /* Lists of aarp entries */
 /**
  *	struct aarp_entry - AARP entry
+ *  @refcnt: Reference count
  *	@last_sent: Last time we xmitted the aarp request
  *	@packet_queue: Queue of frames wait for resolution
  *	@status: Used for proxy AARP
@@ -55,6 +57,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
  *	@next: Next entry in chain
  */
 struct aarp_entry {
+	atomic_t	refcnt;
 	/* These first two are only used for unresolved entries */
 	unsigned long		last_sent;
 	struct sk_buff_head	packet_queue;
@@ -79,6 +82,17 @@ static DEFINE_RWLOCK(aarp_lock);
 /* Used to walk the list and purge/kick entries.  */
 static struct timer_list aarp_timer;
 
+static inline void aarp_entry_get(struct aarp_entry *a)
+{
+	atomic_inc(&a->refcnt);
+}
+
+static inline void aarp_entry_put(struct aarp_entry *a)
+{
+	if (atomic_dec_and_test(&a->refcnt))
+		kfree(a);
+}
+
 /*
  *	Delete an aarp queue
  *
@@ -87,7 +101,7 @@ static struct timer_list aarp_timer;
 static void __aarp_expire(struct aarp_entry *a)
 {
 	skb_queue_purge(&a->packet_queue);
-	kfree(a);
+	aarp_entry_put(a);
 }
 
 /*
@@ -380,9 +394,11 @@ static void aarp_purge(void)
 static struct aarp_entry *aarp_alloc(void)
 {
 	struct aarp_entry *a = kmalloc(sizeof(*a), GFP_ATOMIC);
+	if (!a)
+		return NULL;
 
-	if (a)
-		skb_queue_head_init(&a->packet_queue);
+	atomic_set(&a->refcnt, 1);
+	skb_queue_head_init(&a->packet_queue);
 	return a;
 }
 
@@ -477,6 +493,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	entry->dev = atif->dev;
 
 	write_lock_bh(&aarp_lock);
+	aarp_entry_get(entry);
 
 	hash = sa->s_node % (AARP_HASH_SIZE - 1);
 	entry->next = proxies[hash];
@@ -502,6 +519,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 		retval = 1;
 	}
 
+	aarp_entry_put(entry);
 	write_unlock_bh(&aarp_lock);
 out:
 	return retval;
-- 
2.34.1


