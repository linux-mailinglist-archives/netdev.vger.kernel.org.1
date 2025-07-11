Return-Path: <netdev+bounces-206104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68BB0181E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071C27BCF87
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2F27BF7C;
	Fri, 11 Jul 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ezay3wyx"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD727A444;
	Fri, 11 Jul 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226413; cv=none; b=g859AcVCzjSre5sgNo+DdK4EIp4AcBXkas5umZKF8nmYrXn/oHSCtPV+4FZhiKj8bT4OMmCoG2JBVx61Nl14wrRJJzcgUkUW5Mwltd1ERx8iYVBLpFFTb7D7Q2NZ6pL3O5KxXbrc/T7CgsGoyl4cO6YD9hAaDf6V6HkfOqh5Mfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226413; c=relaxed/simple;
	bh=1NeZgEFsBKaBaZqfwzcR8o3Yb9H0q1+Xw/7s6j/OppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC6iDmy4o9MNNUt3LL4g7eV4f8lWe0ibznVxsigUgGjERY/KfJBQQvyhHeH9VmkvJnBheqWdYoMdtMJkp4tkhIdpHTGltlVG9RIkzP8qHlWVeXcv6ckEIqny8EaWvMya0h6l25y3WhGsJmJrRMJ51hMSnqOQyinychMPjAFxBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ezay3wyx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tw
	XTILwLVnAYzCmxKNYpQPuWrjXfHKZFN8m69eh0GOE=; b=ezay3wyxm4pDhFhksg
	rjfa7iGXNIBf4J9G4hNY60texol/wqJA0kIYohV+EigGH7uB+4yEnKGU2k7do/DQ
	8/6eHTRgFQ6hvmCsIB/Spfyg+7VJDKGRP9CWWwFPbkJAHpY8rIOx04EWoA5dMc1y
	aNrygGJDWFijXudElw6QvFKtY=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3hOpP2nBo+FkNEQ--.57493S4;
	Fri, 11 Jul 2025 17:33:03 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Fri, 11 Jul 2025 17:33:00 +0800
Message-ID: <20250711093300.9537-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711093300.9537-1-luyun_611@163.com>
References: <20250711093300.9537-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3hOpP2nBo+FkNEQ--.57493S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xXFy7Zr4rKw17Aw1rtFb_yoWrKw15pa
	yYg34av3WDJr1xt3yfGa18Jr10vw4rJFsrGrWkX34SywnIy3sayrWIkrWY9FyUZFZ7taya
	vF4jvr4UCa4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVSoJUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxCHzmhw1QaoGgAAsj

From: Yun Lu <luyun@kylinos.cn>

When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
pending_refcnt to decrement to zero before returning. The pending_refcnt
is decremented by 1 when the skb->destructor function is called,
indicating that the skb has been successfully sent and needs to be
destroyed.

If an error occurs during this process, the tpacket_snd() function will
exit and return error, but pending_refcnt may not yet have decremented to
zero. Assuming the next send operation is executed immediately, but there
are no available frames to be sent in tx_ring (i.e., packet_current_frame
returns NULL), and skb is also NULL, the function will not execute
wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
will enter a do-while loop, waiting for pending_refcnt to be zero. Even
if the previous skb has completed transmission, the skb->destructor
function can only be invoked in the ksoftirqd thread (assuming NAPI
threading is enabled). When both the ksoftirqd thread and the tpacket_snd
operation happen to run on the same CPU, and the CPU trapped in the
do-while loop without yielding, the ksoftirqd thread will not get
scheduled to run. As a result, pending_refcnt will never be reduced to
zero, and the do-while loop cannot exit, eventually leading to a CPU soft
lockup issue.

In fact, skb is true for all but the first iterations of that loop, and
as long as pending_refcnt is not zero, even if incremented by a previous
call, wait_for_completion_interruptible_timeout() should be executed to
yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
the execution condition of this function should be modified to check if
pending_refcnt is not zero, instead of check skb.

-	if (need_wait && skb) {
+	if (need_wait && packet_read_pending(&po->tx_ring)) {

As a result, the judgment conditions are duplicated with the end code of
the while loop, and packet_read_pending() is a very expensive function.
Actually, this loop can only exit when ph is NULL, so the loop condition
can be changed to while (1), and in the "ph = NULL" branch, if the
subsequent condition of if is not met,  the loop can break directly. Now,
the loop logic remains the same as origin but is clearer and more obvious.

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Cc: stable@kernel.org
Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v5:
- Still combine fix and optimization together, change to while(1). Thanks: Willem de Bruijn.
- Link to v4: https://lore.kernel.org/all/20250710102639.280932-3-luyun_611@163.com/

Changes in v4:
- Split to the fix alone. Thanks: Willem de Bruijn.
- Link to v3: https://lore.kernel.org/all/20250709095653.62469-3-luyun_611@163.com/

Changes in v3:
- Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
- Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
---
---
 net/packet/af_packet.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7089b8c2a655..be608f07441f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2846,15 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check the pending_refcnt.
+			 */
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
 				}
-			}
-			/* check for additional frames */
-			continue;
+				/* check for additional frames */
+				continue;
+			} else
+				break;
 		}
 
 		skb = NULL;
@@ -2943,14 +2949,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 		packet_increment_head(&po->tx_ring);
 		len_sum += tp_len;
-	} while (likely((ph != NULL) ||
-		/* Note: packet_read_pending() might be slow if we have
-		 * to call it as it's per_cpu variable, but in fast-path
-		 * we already short-circuit the loop with the first
-		 * condition, and luckily don't have to go that path
-		 * anyway.
-		 */
-		 (need_wait && packet_read_pending(&po->tx_ring))));
+	} while (1);
 
 	err = len_sum;
 	goto out_put;
-- 
2.43.0


