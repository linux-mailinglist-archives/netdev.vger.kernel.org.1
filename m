Return-Path: <netdev+bounces-278015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAL3Fx673GliVwkAu9opvQ
	(envelope-from <netdev+bounces-278015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35583E9FD1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6434E3004F13
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E443B19BE;
	Mon, 13 Apr 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmarTFv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03313AC0C4
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073500; cv=none; b=uZ7KVTtZF4ZKsjFs73egCUgFnE9BSNyXxFo8U2kbTDmlWR9vCms5x3ErsATfy0cho8SSNeXJAhK7dqvqxhwi2XPGZxZMZ9nrLzohKUWWAcp1G9vkZQLFjJrO61e1A9cndIuRYP94bqEwOIyUR+WPCAq05fT4nm/95W4Qq29WtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073500; c=relaxed/simple;
	bh=Nc909uFZwrvDpDkljFoOIFDI9jBrVfDU0iQ79B6kD3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GifUE7J8pqoT9IsQ0uHFMsaklBC/Jt1qb8albRWKtpV4hTbtEtdbmCeyacIJiT43Bap3urpQhl7oxWB0+FzhfQogOiB+0mBQIwmSBTJ1Ck1FWmoh+5UjoGo48La+MIOtat7znQiV5xx06xthY9WcKU5Ei890tysMq+PdUevnbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmarTFv1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1505938a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073497; x=1776678297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnxXZAcBu9e0QRRC10glkhFgZL7i6Zh7Fpi2VeYiurs=;
        b=BmarTFv12Lxvd/mxjUjmJh/J0F8fORi5TfsuYUq/VBZkt4BpcHhRBfPmGm14pU9OKX
         O6i2WLxb1CzxRBky99xCA2qV+kWvlKXE8prJMzvGwogt5O/OYTsLcR3Q4ok0F/+UA14+
         q92JXtUUJwzKxqk2sl3yMKz9hjBm2RLgCfbYmDbeji1TIGUS2SyuFtyqMDl1wQBxovDz
         E4HG/HdEprTXcAIlRGBJIHrx2wPseIXLf9nf9nuLo1nygTNNVLGkK8+Wu7rNk+e1Sa/N
         C+TiibLx6tiCSpzn3PvQyri+DcnCvtopOEucGXRCYzekuzD3+SSpkr+v9DMU4bd8xJu3
         qzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073497; x=1776678297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnxXZAcBu9e0QRRC10glkhFgZL7i6Zh7Fpi2VeYiurs=;
        b=HUgvKO3dMnHZ7I31OsmAl6SsnIRcXt6+FaTuwg/UbrOdSBMdxIxEwkA1yJfWHfOJJS
         D0f8XMGic5SzNtEcHXRgFOiJptwQ475KKomuBKN8khzjfZ8mTHkUz0ZwjrlTa9xxZWVI
         wIeQl6riQLxrZNG8UF6ojsQthmEPie/VELhWR0gsGW2HNDMbQHHL3e83ydhYNetWIRzv
         nZKUVKlJCeihK+M/EMnqfdfSGMzDkqZtLX67sz71ql4GnNSHXSEXmgzfR8hjIffty1kt
         yXOsmaf1zlcqw8pBETSP7Mefab5oWDh7ULAq+6hAF2wZI9Yp64yO9gG2BjQ5JISv8v8S
         mJPg==
X-Forwarded-Encrypted: i=1; AFNElJ/VnJXzmmg5ZwU5i8onUQG6mOS5yyrs8c0t3zALS5/5rKDbjCc+QrPHQR34rf2/aWjWnoYG+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQic6JSN1Bhd7yImXO/wRp4sJOi/4PiqUl5gbslvy09fnGkcEn
	uLDLa2Kt/zXIQpwkzcDU2h1rzUMrJIo5vm8uh+Mkj0gzzkTsM7azTxyy
X-Gm-Gg: AeBDiesekSdtAo+/qE7P3JnV9fjwKseRs9VRng9u6LKr9pIjGNXkHN9hKeWDs/QtxJ8
	REK5uWYNtzQBt0ljCkp9xznxkOnKSj4FsfR6c9UqOSjq9CJntvMiDsiJpXeZKkAxg8UaMUzwonU
	QLMNjjZ2BjzYXriDncbsgcdtbt6vd+qYgdbrYrJR3XrC2Xl66P5OIQVCKbti4dO442kiTTWkSPo
	GH8CO7ZuCM86VCUrXhbFks5fMEgMhHI4NEAvVD8H1qmZ/SRL6nB8alToKjSv/B+Wt2waSOxaf+K
	iBSZKWdo94/pAsM4zfT4wZcQeC+eVRpVb7RK/MZsPKZ5EBNyUCWsrt3OTLqyzsyl6B+HMiTREe0
	07oKrNV45v5IwhG0qW09aH2DJ+pq+JTfJsKkPDF6lK4m54wzucQyDiJGyTDn0To7hnCooslF3VY
	VPzQNgjAqT8FzLONspQubY8/bAiECDL+H6
X-Received: by 2002:a05:6a20:12c5:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-39fe4603847mr11679426637.17.1776073496997;
        Mon, 13 Apr 2026 02:44:56 -0700 (PDT)
Received: from localhost.localdomain ([117.186.117.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm10711799b3a.24.2026.04.13.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:44:56 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [PATCH] net: sched: teql: fix use-after-free in teql_master_xmit
Date: Mon, 13 Apr 2026 17:44:47 +0800
Message-ID: <20260413094448.2263828-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278015-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F35583E9FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

teql_destroy() traverses the circular slave list to unlink a slave
qdisc. It reads master->slaves as both the starting point and the
do-while termination sentinel. However, the data-path writers
teql_dequeue() and teql_master_xmit() concurrently modify
master->slaves without holding RTNL, running in softirq or process
context respectively. If master->slaves is overwritten to an
already-visited node mid-traversal, the loop exits early without
finding the target slave. The slave is never unlinked, but its memory
is freed by call_rcu() -- leaving a dangling pointer in the circular
list. The next teql_master_xmit() traversal dereferences freed memory.

race condition:

  CPU 0 (teql_destroy, RTNL held)       CPU 1 (teql_dequeue, softirq)
  -----------------------------------   -----------------------------
  prev = master->slaves;  // = A
  q = NEXT_SLAVE(A);      // = B
  B == A? No.
  prev = B;
                                         /* slave C's queue drains */
                                         skb == NULL ->
                                         dat->m->slaves = C; /* write! */

  q = NEXT_SLAVE(B);      // = C
  C == A? No.
  prev = C;
  /* check: (prev=C) != master->slaves(C)?
     FALSE -> loop exits! */
  /* A never unlinked, freed by call_rcu */

  CPU 0 (teql_master_xmit, later)
  -----------------------------------
  q = NEXT_SLAVE(C);      // = A (freed!)
  slave = qdisc_dev(A);   // UAF!

Fix this by saving master->slaves into a local `head` variable at the
start of teql_destroy() and using it as a stable sentinel for the
entire traversal. Also annotate all data-path accesses to
master->slaves with READ_ONCE/WRITE_ONCE to prevent store-tearing and
compiler-introduced re-reads.

==================================================================
BUG: KASAN: slab-use-after-free in teql_master_xmit+0xeae/0x14a0
Read of size 8 at addr ffff888018074040 by task poc/162

CPU: 2 UID: 0 PID: 162 Comm: poc Not tainted 7.0.0-rc7-next-20260410 #10 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl+0x64/0x80
 print_report+0xd0/0x5e0
 kasan_report+0xce/0x100
 teql_master_xmit+0xeae/0x14a0
 dev_hard_start_xmit+0xcd/0x5b0
 sch_direct_xmit+0x12e/0xac0
 __qdisc_run+0x3b1/0x1a70
 __dev_queue_xmit+0x2257/0x3100
 ip_finish_output2+0x615/0x19c0
 ip_output+0x158/0x2b0
 ip_send_skb+0x11b/0x160
 udp_send_skb+0x64b/0xd80
 udp_sendmsg+0x138c/0x1ec0
 __sys_sendto+0x331/0x3a0
 __x64_sys_sendto+0xe0/0x1c0
 do_syscall_64+0x64/0x680
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888018074000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 64 bytes inside of
 freed 512-byte region [ffff888018074000, ffff888018074200)
==================================================================

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/sch_teql.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index ec4039a201a2..2e86397a5219 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -101,7 +101,7 @@ teql_dequeue(struct Qdisc *sch)
 	if (skb == NULL) {
 		struct net_device *m = qdisc_dev(q);
 		if (m) {
-			dat->m->slaves = sch;
+			WRITE_ONCE(dat->m->slaves, sch);
 			netif_wake_queue(m);
 		}
 	} else {
@@ -136,19 +136,23 @@ teql_destroy(struct Qdisc *sch)
 	if (!master)
 		return;
 
-	prev = master->slaves;
+	prev = READ_ONCE(master->slaves);
 	if (prev) {
+		struct Qdisc *head = prev;
+
 		do {
 			q = NEXT_SLAVE(prev);
 			if (q == sch) {
 				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
-				if (q == master->slaves) {
-					master->slaves = NEXT_SLAVE(q);
-					if (q == master->slaves) {
+				if (q == head) {
+					WRITE_ONCE(master->slaves,
+						   NEXT_SLAVE(q));
+					if (q == NEXT_SLAVE(q)) {
 						struct netdev_queue *txq;
 
 						txq = netdev_get_tx_queue(master->dev, 0);
-						master->slaves = NULL;
+						WRITE_ONCE(master->slaves,
+							   NULL);
 
 						dev_reset_queue(master->dev,
 								txq, NULL);
@@ -158,7 +162,7 @@ teql_destroy(struct Qdisc *sch)
 				break;
 			}
 
-		} while ((prev = q) != master->slaves);
+		} while ((prev = q) != head);
 	}
 }
 
@@ -285,7 +289,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
+	start = READ_ONCE(master->slaves);
 
 restart:
 	nores = 0;
@@ -317,7 +321,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					WRITE_ONCE(master->slaves, NEXT_SLAVE(q));
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
@@ -329,7 +333,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			WRITE_ONCE(master->slaves, NEXT_SLAVE(q));
 			return NETDEV_TX_OK;
 		default:
 			nores = 1;
-- 
2.43.0


