Return-Path: <netdev+bounces-263881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABWyASpUqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:47:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F220334B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D702930696F8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0DD34A79A;
	Wed,  4 Mar 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDA//f9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7F340A7D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639031; cv=none; b=MBS0MkkEVXAviUZNIHYbw4rY8qVzmQfr044ESaU3KyeqfbPHSU97Se7xM3Y1nQcn0OPR8TQMw1dBkgVXF/4UwaP/grgS0WaC/MgBknGwlQPMPTFPxTuqzQfjCnVczw4+0qXjA6kzGcyTi93iyXY41xwITg0LGPLyWqMHZOgcDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639031; c=relaxed/simple;
	bh=qlxhEf7og7XY0BAdORZmSlDcPIyHYlLNMY9NqLmZ/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RH9akJxULyfUmm/dbF/CGozzyJvyBdmDhAmTBZap3igPm2n3x+EBpndf2/Hxr/MGVSXgDJqzU7zamIjPeFanrqWmEfNkcmNfSWY3/T8LCgo+/i4tLESSwfIawawtrJ6iQyFJQdDIVUE3IDCyJarFh+QiMmtb003C278D3Pstfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDA//f9v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3734592a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639030; x=1773243830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo7Dt9cz18bSdlnkGrgHpe/DU8igK0QAeFj626A+mxo=;
        b=hDA//f9v9L9tw2LY9LlThT56q0VE1o+3BswXG/X3ecYFbMnyl5s+5cL6lMsjdaN8mH
         NslPjSv1s4kktgiJH0gsJxYEOm58Sgk8rss98dU9EQz5FyKSmxk1eNMM4/2NGruJmwB2
         5+WSJs4i6wex7Qez5Qg3f+JrRq0GK47FE35AcPc87LJHgAi+qMc/KCg9C4NJ9huf5KKA
         tf14Rpq9S4dZR4twhu5q+QNJXxyDhn1nAodHBjRnTO8j12AvyJ28IdStRmPYzDJX6Ivv
         xqg7NsSKzPrqosYGeqzHae6O/Pw3gaSCjr+Z/PG2RY2Tuir/N2b51nJMQC4seQAL9wkC
         jvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639030; x=1773243830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7Dt9cz18bSdlnkGrgHpe/DU8igK0QAeFj626A+mxo=;
        b=ZlzwzGN/H6OpQO9rCX6N3m92u4LlGQiEfiOQU3mFRx46bwO3gW9P4vofV3w6cFeQ81
         +hIOcHk2d9fbN2U2c+sVJN5chS40sl6cwpnYAbJHRM6UUNLfv0yAyNKvxdCdJgCnMbSG
         b1UblguBtqCSpGFhi9knlu1+xW8tgDvzOLj4XNVFvJ2s5GZIYoN4K/b33WwQ5M2GYSXD
         9ZbEmeioTkJ8KW0YfEsWcJokN1+BJ1HRvxON91w4zJl8YXBVwo32xFlQT46ls+MsnifB
         o/mtV2klW6XdoyGQXxm7pmy1Peqf/6dA+sEFmEOa2AXpaxxA9EkRFkUnNi5pJiL+pBpo
         hLhQ==
X-Gm-Message-State: AOJu0YxWgTe4MOBwslQvVJsr1aX13CL5Rov3T242Nfa3SS+jIIQMZPbA
	Cfsw5r+WeX85dfAZRVkLtAL48ZK0lVpUiEgpN89O+iLUk47zpLbhARs7aaEj91JPRqc=
X-Gm-Gg: ATEYQzxB7SMyDNntEaEyM0QDW21NChe3GeEpgXlRyiheBSjWoLVLecYsrZpuriwS+g9
	ftjW0JmryfO/gwIGoGPznkEYvXbmGLzu2M+1vpcwkBk5NY2pYLVSRAnVXoug7VPom8j0uXP1+2r
	ubZXukvuU3cZ+zCO4FZjH49B4E76EnxWa0dfbwdtI8XKtd9rPtwuaRF9adJvwPjwNy9QeB2fbwf
	4MH7jRioRHwNFDgu5Fw9SrZsoCMOsOfUAMA3lgl2EDFxKwc2eXmilJyJvBw6ml7KVGNxGaBMYUZ
	BMPc1KTqdu1weFKZhrEgksMmvH2hKTZ/Re++r9w61QrB10Cz/1NAjy/F0ZjUv6ExWyG/cK2xOHj
	PPxJomHpZnm+3vRwWu8X06FaKATv1gorBHsvlUuXpXaCY7VkS0KnhKHw/Alrc+XaixwN7pubgvz
	iag9n9QA6ey3rL1JUqMQBrhddgO3kTa8QN/ba4s85PH7RYctFzZQ==
X-Received: by 2002:a17:90a:d40d:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-359a6a51d09mr2171432a91.25.1772639029637;
        Wed, 04 Mar 2026 07:43:49 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-359a91522e5sm631547a91.2.2026.03.04.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:43:49 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v3] virtio-net: xsk: Support wakeup on RX side
Date: Wed,  4 Mar 2026 22:43:17 +0700
Message-ID: <20260304154317.7506-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A34F220334B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-263881-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
is allocated on RX side, allow RX NAPI to be descheduled. This avoids
wasting CPU cycles on polling. Users will be notified and they need to
make a wakeup call after refilling the ring.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v3:
- Update the comment of try_fill_recv
- Link to v2: https://lore.kernel.org/netdev/20260302164158.4394-1-minhquangbui99@gmail.com/
Changes in v2:
- Fix the flag check in virtnet_xsk_wakeup
- Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..4f4f4046a760 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	xsk_buffs = rq->xsk_buffs;
 
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
-	if (!num)
+	if (!num) {
+		if (xsk_uses_need_wakeup(pool)) {
+			xsk_set_rx_need_wakeup(pool);
+			/* Return 0 instead of -ENOMEM so that NAPI is
+			 * descheduled.
+			 */
+			return 0;
+		}
+
 		return -ENOMEM;
+	} else {
+		xsk_clear_rx_need_wakeup(pool);
+	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
 
@@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent;
 }
 
-static void xsk_wakeup(struct send_queue *sq)
+static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
 {
-	if (napi_if_scheduled_mark_missed(&sq->napi))
+	if (napi_if_scheduled_mark_missed(napi))
 		return;
 
 	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	virtqueue_napi_schedule(napi, vq);
 	local_bh_enable();
 }
 
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq;
 
 	if (!netif_running(dev))
 		return -ENETDOWN;
@@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
-	sq = &vi->sq[qid];
+	if (flag & XDP_WAKEUP_TX) {
+		struct send_queue *sq = &vi->sq[qid];
+
+		xsk_wakeup(&sq->napi, sq->vq);
+	}
+
+	if (flag & XDP_WAKEUP_RX) {
+		struct receive_queue *rq = &vi->rq[qid];
+
+		xsk_wakeup(&rq->napi, rq->vq);
+	}
 
-	xsk_wakeup(sq);
 	return 0;
 }
 
@@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
 	 */
-	xsk_wakeup(sq);
+	xsk_wakeup(&sq->napi, sq->vq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
@@ -2816,7 +2835,9 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 }
 
 /*
- * Returns false if we couldn't fill entirely (OOM).
+ * Returns false if we couldn't fill entirely (OOM) and need to retry.
+ * In XSK mode, it's when the receive buffer is not allocated and
+ * xsk_use_need_wakeup is not set.
  *
  * Normally run in the receive path, but can also be run from ndo_open
  * before we're receiving packets, or from refill_work which is
-- 
2.43.0


