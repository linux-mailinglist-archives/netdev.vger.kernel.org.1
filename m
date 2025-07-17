Return-Path: <netdev+bounces-207669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FAAB08242
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A331A61E1F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4AB1D5CC7;
	Thu, 17 Jul 2025 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJz6t8iI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBA10A1F;
	Thu, 17 Jul 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715750; cv=none; b=JOPg4GPyehlWhaTfN56NsnUrllFCgygPp4sPh/8O0ZB74PzSMe9dHGgYXbyYtpJV1YMvt8gdn5pHWUVXhyBifvfTPd0Mv430V8A+Ftm01oVs+3Dw/nZ66x3g3XjNV9i2XV8thOMZ16A65Yh60RMhhizmui/RWwuChQYYdF6AaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715750; c=relaxed/simple;
	bh=UlrrXtM8tNgFfq6xMaaCzyH7cU2VliG3j5sCapi28T8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxkQ5bi07sYdadY4hc1sExiQV/LZUUVUQ29PoeWlyB4ZHl8Bw4toZC8WpX3AYqNErj00+0hMIpUQG3yr/SD4qZ7ykjW32422Pe9pnf706E+4gshXDudyza9mHujYfdT0tqzV7tAxuVBlLkUlFvsUDeg8MuZFr4nxGbDfMzREPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJz6t8iI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2352400344aso3618765ad.2;
        Wed, 16 Jul 2025 18:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752715748; x=1753320548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwOSrzQE9qPX9JEungps87v4vTnwvCojVTgK5M1yuaY=;
        b=iJz6t8iIN9PYOEGib+rntqsDD21Tuj/ZvgojGAsdA2Gs/uHRzaiOQRsLbu6S2TVbPz
         DW1LxIhcem6LKE3KL45ZjVJeBOQ8eiqvbrI4HeqFpiwp7K18GMve0UWnlec5OLW8SUUT
         tSFOF1Wf+kCIjI644vc/Zb2hXWIeher33S9RgX4NgoH31Ol2SWVFbLZbRZaIWY/pm/1z
         QwoM96t9qrzbE4r5Dm9IB+lb+y22ofX91tdCL4iZCow3WDwBvcIfSCiEtZHBGYGPPNjA
         jWNPOeewSRAxqq0t0Nq1P4OZiMGwd5qpUG+itVAsHpv34AKYGGQ4csTvw6NsuY1aldCx
         lYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752715748; x=1753320548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwOSrzQE9qPX9JEungps87v4vTnwvCojVTgK5M1yuaY=;
        b=oItgDRzuoIDgokFkej4mWjCZEUoraCOgLt7xyg/1nRWsFOwvk6ku7MQXRsrf9snpNn
         +ZNNjDm4/X3slByW8UPjo7WbtXNvdM7Wy9WL4VXQCy0rfc+RkB35gXNZ+o2+gbL3p3aw
         zbMh8AzrqAK9sDQNutMKlChhxMKtgV6/9O+T/mFuMNsq1Hv2+f0ZHKsAiL7tU4WumDHz
         FvfvtMusY1fHcOvvcAuXtEmnZyBX2Mo+2g9M+QTBUecs9VIZMy3PYKrQTOR9NlNvuofe
         1hWFD9uNqufpw2cAzQaj4hLVJzOsnH4c2FLY5ToEfNFkfqRJFMxh/q3Fa5OiRe/26KQb
         3SFA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4DCCt4X5H6BZmjmkzLnVGqzzSUvPt4XqtV2yBDGYJC9luzov6lK+QoIPi3PxMEaO68ctcRr6VmHvmvk=@vger.kernel.org, AJvYcCUpJ5RFzMUXhGJflOcpMUL4lz9yjoFkkTXIPiznkfgZcG42PxJW9eVWg3ST+uYoMzQM1qJSQXA0@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQu3IJIHUfApx7GptkD6XN0uakmK3KMaNne3+H/SImgRpOLZ8
	YRtp+nUXDFFqH+WN0NqhQWC2uq9jAEJ9kuDPE7X5H3pPLKQKRnz+nrBi
X-Gm-Gg: ASbGncsjgNpqR3o1McjmvRRarDVCUha4YQkp99ejUT+5sZqT6qF/3ySNnIS4igRXU+A
	Zpz6v2i1rJkSoaBuhJOmq/2ofri7xtM71vRmgL+i/zdi3tgOLilg+PR+1AgnitsN/AVLrj7/jh5
	1LH4iO1XaJYCLx0xRL5Zn84zM/7gqOgUzNaYl2jYAya3ACYSLTPTqNVnraB2HQ+tF+6KNCmhzNT
	y3PcsPQ5Iq4xBI8Tsrk5QNN9Ts3LNiV8l78ehh+hMOgo7rebhP+fh04vaxKz4WQJ4Ht6sZG0am1
	ySQSUs/CKbzG7OdlLkK7pbD06QUj7EIDauVfer2xHOivohezEKpTdIy1zwTUu7FqtJ6FysSjGer
	noro1I+wXezkgoouj5ZAi28Wid35A
X-Google-Smtp-Source: AGHT+IFiWdV+Lg1jc5P98VoSBUHlA5igYTnjK8SHdtNmFOzxSkxzCZ/E5suiMJV2mnv6a8/JYCstTA==
X-Received: by 2002:a17:903:2451:b0:231:e331:b7df with SMTP id d9443c01a7336-23e24fbef13mr75425575ad.29.1752715748330;
        Wed, 16 Jul 2025 18:29:08 -0700 (PDT)
Received: from syzkaller.mshome.net ([8.210.121.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322dbdsm134632855ad.127.2025.07.16.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:29:07 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: kuba@kernel.org
Cc: Yeking@Red54.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	hxzene@gmail.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH v2] net: appletalk: Fix use-after-free in AARP proxy probe
Date: Thu, 17 Jul 2025 01:28:43 +0000
Message-Id: <20250717012843.880423-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716072241.16edbded@kernel.org>
References: <20250716072241.16edbded@kernel.org>
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
index 9c787e2e4b17..4744e3fd4544 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -35,6 +35,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
+#include <linux/refcount.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -44,6 +45,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
 /* Lists of aarp entries */
 /**
  *	struct aarp_entry - AARP entry
+ *	@refcnt: Reference count
  *	@last_sent: Last time we xmitted the aarp request
  *	@packet_queue: Queue of frames wait for resolution
  *	@status: Used for proxy AARP
@@ -55,6 +57,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
  *	@next: Next entry in chain
  */
 struct aarp_entry {
+	refcount_t			refcnt;
 	/* These first two are only used for unresolved entries */
 	unsigned long		last_sent;
 	struct sk_buff_head	packet_queue;
@@ -79,6 +82,17 @@ static DEFINE_RWLOCK(aarp_lock);
 /* Used to walk the list and purge/kick entries.  */
 static struct timer_list aarp_timer;
 
+static inline void aarp_entry_get(struct aarp_entry *a)
+{
+	refcount_inc(&a->refcnt);
+}
+
+static inline void aarp_entry_put(struct aarp_entry *a)
+{
+	if (refcount_dec_and_test(&a->refcnt))
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
+	refcount_set(&a->refcnt, 1);
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


