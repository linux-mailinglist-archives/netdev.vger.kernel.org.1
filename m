Return-Path: <netdev+bounces-152605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BF9F4CCC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6056162810
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A01EBA02;
	Tue, 17 Dec 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSeB+avZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6991EF1D
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443487; cv=none; b=d+jC6y6G+D8ZW+mcmZYCyRuLHcmPD541dkXFr8u9Dua8FhIea/3Ov5XJcjfTQl3lP0StCPIteE1F/Hb8xpdl0wpT4NW4o8j+uoPW5T8qyCSKWWmwbF5wkNHSWj6isZca1xUI8oWI3JLW0tt+PrvwzpW329kNTOaemHJqQlbTvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443487; c=relaxed/simple;
	bh=lBRXwpkWLeE1RLmLVARpc36+37La47SraS1AnFBNUPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QCv6XcGqMOBynrOlCLJh8etQZB9R2tiAVpFfwLl9JonGResgtgkbR0AmCx0UdLPwz6pwQsTWv64XcRrPncCrFJFhY5xDQQ1+1MPbAopr4iHZIVZSJQOxblA4oSiHsNAULisaaUsO6Trudzell8F7BQ/TMTIGXzTcHdIXc2tvM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSeB+avZ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e9fb0436so29190885a.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734443484; x=1735048284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E5QtgPZELSLDmD36CV1+ESqanJXxgk9EjYyo4jMAuUI=;
        b=LSeB+avZ3Pmo0HwfxQol878uvUZsakuVlTRyiVJLtcyc4BFHvJtEh7bXO+6oH949eg
         lsgtkvP3q9YpWxRyNmUm0JdRZ/ACbXYNAC4Aj7Z8FHG1RjlDYdXRDdWGEGNde47jAEQ+
         TSIzGfnSR8tc3h51/w0KLYCSCb3txjZ7yKc8F8kTvz1MSBaFuQ+HJnXUDRkGy8LXySAg
         aYzDwLijnGPw4JMwizpyu0k9odBe32gWLj6jPr8znk4RGer81efiQT5SXPKhlWxLzkdb
         vQvQU2dGt2wza/s5OSBCSUBfqyRDJ3PT/MCNzWscChPPShzzsNzxWYoGXAVhkcWdaP3T
         VbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734443484; x=1735048284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5QtgPZELSLDmD36CV1+ESqanJXxgk9EjYyo4jMAuUI=;
        b=Xb2Vgdr/Bcipvh8PM116K+FYakZnZzvenIREw/64tO53LZEPKSwp0bvlNPNX3LCteB
         /AJc2WPRV5VStyeZoXVAEvdC6OLGrMt01gIr12m4n4fHGWygIJ12Y1BglBAwMRhWTfCa
         2Xa9D6mZaZCrlQM1eOKSOpX417fsIB01Fs/rtFmFNgVE50andF23AznCv7ohd7KhAPDc
         OPiFarCRozPSXaCW0VvBeL6iOB/WJfCPnr+0uTYb9ZYhtvHCEm0dn6UiTXfkGe07eaX5
         kQvYtETX1aUckwO0kYycOJ4AhdeRzCzDQu4rdqi2ARyAjGuUKwTKqdi7Hf4H+FN889sT
         ddYQ==
X-Gm-Message-State: AOJu0YyY5pleSkLL0qpvisJyMSOdCtti6Ni8/C2eMLTwB7f5bBzQ53YR
	QdShwxzIugzRnAvl0C1hh1lySdaS9bTlPcqLUPjs72T6zr87VKC0Uo4s9iPOpJKzb6uhElLkeZn
	tlQ6BXOJ1wg==
X-Google-Smtp-Source: AGHT+IHZqiKykTQFCy+Ipy7gEHGeTGG0/D5Enb22yI4ZWimS+wHwLCZhilWddyD8JQkzYkUJvN+YA+aRw0MOuw==
X-Received: from qke16.prod.google.com ([2002:a05:620a:a110:b0:7b6:6c43:27ce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:198c:b0:7b6:c6f8:1d29 with SMTP id af79cd13be357-7b6fbf3a770mr2905377285a.47.1734443484647;
 Tue, 17 Dec 2024 05:51:24 -0800 (PST)
Date: Tue, 17 Dec 2024 13:51:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217135121.326370-1-edumazet@google.com>
Subject: [PATCH net-next] ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Jakub added a lockdep_assert_no_hardirq() check in __page_pool_put_page()
to increase test coverage.

syzbot found a splat caused by hard irq blocking in
ptr_ring_resize_multiple() [1]

As current users of ptr_ring_resize_multiple() do not require
hard irqs being masked, replace it to only block BH.

Rename helpers to better reflect they are safe against BH only.

- ptr_ring_resize_multiple() to ptr_ring_resize_multiple_bh()
- skb_array_resize_multiple() to skb_array_resize_multiple_bh()

[1]

WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 __page_pool_put_page net/core/page_pool.c:709 [inline]
WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Modules linked in:
CPU: 1 UID: 0 PID: 9150 Comm: syz.1.1052 Not tainted 6.11.0-rc3-syzkaller-00202-gf8669d7b5f5d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__page_pool_put_page net/core/page_pool.c:709 [inline]
RIP: 0010:page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Code: 74 0e e8 7c aa fb f7 eb 43 e8 75 aa fb f7 eb 3c 65 8b 1d 38 a8 6a 76 31 ff 89 de e8 a3 ae fb f7 85 db 74 0b e8 5a aa fb f7 90 <0f> 0b 90 eb 1d 65 8b 1d 15 a8 6a 76 31 ff 89 de e8 84 ae fb f7 85
RSP: 0018:ffffc9000bda6b58 EFLAGS: 00010083
RAX: ffffffff8997e523 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000fbd0000 RSI: 0000000000001842 RDI: 0000000000001843
RBP: 0000000000000000 R08: ffffffff8997df2c R09: 1ffffd40003a000d
R10: dffffc0000000000 R11: fffff940003a000e R12: ffffea0001d00040
R13: ffff88802e8a4000 R14: dffffc0000000000 R15: 00000000ffffffff
FS:  00007fb7aaf716c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa15a0d4b72 CR3: 00000000561b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tun_ptr_free drivers/net/tun.c:617 [inline]
 __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
 ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
 tun_queue_resize drivers/net/tun.c:3694 [inline]
 tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3714
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9024
 do_setlink+0xff6/0x41f0 net/core/rtnetlink.c:2923
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550

Fixes: ff4e538c8c3e ("page_pool: add a lockdep check for recycling in hardirq")
Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/671e10df.050a0220.2b8c0f.01cf.GAE@google.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/tap.c         |  6 +++---
 drivers/net/tun.c         |  6 +++---
 include/linux/ptr_ring.h  | 21 ++++++++++-----------
 include/linux/skb_array.h | 17 +++++++++--------
 net/sched/sch_generic.c   |  4 ++--
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..5ca6ecf0ce5fbce6777b47d9906586b07f1b690a 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1329,9 +1329,9 @@ int tap_queue_resize(struct tap_dev *tap)
 	list_for_each_entry(q, &tap->queue_list, next)
 		rings[i++] = &q->ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       __skb_array_destroy_skb);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  __skb_array_destroy_skb);
 
 	kfree(rings);
 	return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8e94df88392c68c0585c26dd7d4fc6928062ec2b..41e3eeac06fdc7d4b7cd029a60dc2acc7e447c4a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3701,9 +3701,9 @@ static int tun_queue_resize(struct tun_struct *tun)
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       tun_ptr_free);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  tun_ptr_free);
 
 	kfree(rings);
 	return ret;
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index fd037c127bb0713bdccbb0698738e42ef8017641..551329220e4f34c9cc1def216ed91eff8b041a7b 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -615,15 +615,14 @@ static inline int ptr_ring_resize_noprof(struct ptr_ring *r, int size, gfp_t gfp
 /*
  * Note: producer lock is nested within consumer lock, so if you
  * resize you must make sure all uses nest correctly.
- * In particular if you consume ring in interrupt or BH context, you must
- * disable interrupts/BH when doing so.
+ * In particular if you consume ring in BH context, you must
+ * disable BH when doing so.
  */
-static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
-						  unsigned int nrings,
-						  int size,
-						  gfp_t gfp, void (*destroy)(void *))
+static inline int ptr_ring_resize_multiple_bh_noprof(struct ptr_ring **rings,
+						     unsigned int nrings,
+						     int size, gfp_t gfp,
+						     void (*destroy)(void *))
 {
-	unsigned long flags;
 	void ***queues;
 	int i;
 
@@ -638,12 +637,12 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
 	}
 
 	for (i = 0; i < nrings; ++i) {
-		spin_lock_irqsave(&(rings[i])->consumer_lock, flags);
+		spin_lock_bh(&(rings[i])->consumer_lock);
 		spin_lock(&(rings[i])->producer_lock);
 		queues[i] = __ptr_ring_swap_queue(rings[i], queues[i],
 						  size, gfp, destroy);
 		spin_unlock(&(rings[i])->producer_lock);
-		spin_unlock_irqrestore(&(rings[i])->consumer_lock, flags);
+		spin_unlock_bh(&(rings[i])->consumer_lock);
 	}
 
 	for (i = 0; i < nrings; ++i)
@@ -662,8 +661,8 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
 noqueues:
 	return -ENOMEM;
 }
-#define ptr_ring_resize_multiple(...) \
-		alloc_hooks(ptr_ring_resize_multiple_noprof(__VA_ARGS__))
+#define ptr_ring_resize_multiple_bh(...) \
+		alloc_hooks(ptr_ring_resize_multiple_bh_noprof(__VA_ARGS__))
 
 static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
 {
diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
index 926496c9cc9c3b64c6b2d942524d91192e423da2..bf178238a3083d4f56b7386d12e06bc2f0b929fa 100644
--- a/include/linux/skb_array.h
+++ b/include/linux/skb_array.h
@@ -199,17 +199,18 @@ static inline int skb_array_resize(struct skb_array *a, int size, gfp_t gfp)
 	return ptr_ring_resize(&a->ring, size, gfp, __skb_array_destroy_skb);
 }
 
-static inline int skb_array_resize_multiple_noprof(struct skb_array **rings,
-						   int nrings, unsigned int size,
-						   gfp_t gfp)
+static inline int skb_array_resize_multiple_bh_noprof(struct skb_array **rings,
+						      int nrings,
+						      unsigned int size,
+						      gfp_t gfp)
 {
 	BUILD_BUG_ON(offsetof(struct skb_array, ring));
-	return ptr_ring_resize_multiple_noprof((struct ptr_ring **)rings,
-					       nrings, size, gfp,
-					       __skb_array_destroy_skb);
+	return ptr_ring_resize_multiple_bh_noprof((struct ptr_ring **)rings,
+					          nrings, size, gfp,
+					          __skb_array_destroy_skb);
 }
-#define skb_array_resize_multiple(...)	\
-		alloc_hooks(skb_array_resize_multiple_noprof(__VA_ARGS__))
+#define skb_array_resize_multiple_bh(...)	\
+		alloc_hooks(skb_array_resize_multiple_bh_noprof(__VA_ARGS__))
 
 static inline void skb_array_cleanup(struct skb_array *a)
 {
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 38ec18f73de43aed565c653fffb838f54e7c824b..8874ae6680952a0531cc5175e1de8510e55914ea 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -911,8 +911,8 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
-	return skb_array_resize_multiple(bands, PFIFO_FAST_BANDS, new_len,
-					 GFP_KERNEL);
+	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
+					    GFP_KERNEL);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.47.1.613.gc27f4b7a9f-goog


