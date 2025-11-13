Return-Path: <netdev+bounces-238188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F5C55983
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2AE3B12BD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368B2877DC;
	Thu, 13 Nov 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WDs+8zSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDA7E0E4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005991; cv=none; b=Z2Qys7xfRbXSbUuhu2fJ/2clSmD2F3xnxE2O8wPdCPwsFXiSnWaBZEgf/vYrvsJTxFNm9L+NhxnLBz9KVMrwmx6Qc3qocbsB68Jes5qPkADdo1pMkiWxvLPK4XYdbTKADIfOdYUFF2CygRiHBxBjtg0BtzTABx1NbY/yU3+q6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005991; c=relaxed/simple;
	bh=Q1YWvuDM9f63aNcGtSyZvwbh7ysP4xRz5DzZV8K3rfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tO70UPEYDGyryY+J5+/2YjRWtiljpuCpfwU/L9pCfcGcmSSd8pYRBOec091bo6erjAUqOE9k6UvSIkQ+sGHuYnSiu4+7NWovah5LG4mfOPsGTnBdYNfKPJK4QIN4byR+hKU78EJiWFeb2XTUIrZwfw/18EjzrKDYm6eOrczrits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WDs+8zSE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c68bfe1719so124056a34.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763005989; x=1763610789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caCuzpiBlKkYiDUgrdd42Zl/DdzHOq3t35PmX7TkYt0=;
        b=WDs+8zSEYF1B1yeFgQwUM32p7QREY5gdogCvgvhn2SSBIdqHS0psXH0Om9szwvWxik
         9IRxyuSEokzIbSRBw1Mt3wtecaNy+yj9pBVk0w9WyJ6rWo5WPBU4oxGXUolndQ2olzVy
         MdBjKFHxUCbp3qRqZ/IUJ2y3IlCNUByEXPlY4t6bVxabdpeH9CxWKE4aybQzERCZlrcW
         z03sHQFwvl9kWf2CTx/diNPUR4hgRx4otXysrR2PnHzqwSWgVi30/kMDKRJhVLb2fIw6
         GMFGzux/xQESYoaWQ5GxI2pw4SREVa4l7IHroaBNAZHsUmSK31syiP1M+M+HYBUnx4W1
         2ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005989; x=1763610789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caCuzpiBlKkYiDUgrdd42Zl/DdzHOq3t35PmX7TkYt0=;
        b=LZpMCesiThcreF8TDtS6fgag7nAOTeXt/kzwv25M4zYkOWNm7l0pkdBovUprNAHuY2
         0a5wn8uQvmx2ko5VWKymESjNQjsEFXUQR+aHHYgkB5ZyVy6FCn4Iim6pGgtmCerXdxn/
         uIS8t3ej6+sHBLHOdZwOApDro3Vadrlq9e4ZUQcIjO/WZpDXkv6nsI/ZewvmsGTyGDA8
         6n5zbS2IPIFZniq0XoKxj3+aLlvC789EjEvL69Z6muvPSqVVUE7nwEQyNBEpcVDYQ5+9
         tyYq+bpaYdd0fJ9tI6WTTxylU8fuMyfMWy6GCjRvNuNyKbv3856IIkGdsce0XZ2AnN7N
         v85g==
X-Gm-Message-State: AOJu0YzIq8x7JXHgMb+h31fQhetrKRFxAc59Bo0AjMrDtyziOFkJZAx7
	pRPQKINwzE39mfZJzPZ0B6jHSniTUO9qHu4nYejaIlaOnn0IZ/cucaiMxNDHFVWfrg==
X-Gm-Gg: ASbGncs/fC7lmYnMbp2pZCmMsIvUVVTljTutfyjLvd6crMvr0zydcmVhGVRFLXjNb4g
	6YcirKmagqeIXblugF9ey3RhGZ0v2oqHBEi9NdVazjXfm+2QAcbq6gmj81k44vsyMnxlzxHL4uW
	v2nBxEfTiEu4g2TFbYFiCUB9pZAutf6PgFVm61uHrgnGdHLJlOJNfAuBAM2+B4/ore8UjJ1xZz8
	ybHyYlm0t8W6vxdyWhVFuIyGYPEYRwF4a+GX5+fM6M3mEGvsKQ0ocNZFxjMzBCaDBH0KsA/iA4X
	GDWA9LFrXVEjwTzG0NY1KkMyzIdAkwkZmgDt/cKYEvv/Ql6zl2eSMDB5EL7E3FfLX4npSO2B886
	LcRECEhr2EfRozyryJwjTmt9SW9dF7ho2H1kY+E8WQ9FwYBziRXNFguArNz4N6dCnxs7qJ3S6zP
	/zQhKhqkKTudT8SUlW5gHyMpauY//N+NySbD8CLD2V
X-Google-Smtp-Source: AGHT+IE2luF+rjX/JkLUxs9uL/f2+K18J1dp2UU3f3l59WkOKXnh/MsO3gJCC0+/Ax1GTVQ77a0ZIQ==
X-Received: by 2002:a05:6830:34a5:b0:7c5:4005:fff3 with SMTP id 46e09a7af769-7c72e3e5ca8mr2222124a34.29.1763005988809;
        Wed, 12 Nov 2025 19:53:08 -0800 (PST)
Received: from p1.scai.dhcp.asu.edu (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a283c41sm471470a34.6.2025.11.12.19.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:53:08 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
Date: Wed, 12 Nov 2025 20:53:03 -0700
Message-ID: <20251113035303.51165-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cake_drop(), qdisc_tree_reduce_backlog() is called to decrement
the qlen of the qdisc hierarchy. However, this can incorrectly reduce
qlen when the dropped packet was never enqueued, leading to a possible
NULL dereference (e.g., when QFQ is the parent qdisc).

This happens when cake_enqueue() returns NET_XMIT_CN: the parent
qdisc does not enqueue the skb, but cake_drop() still reduces backlog.

This patch avoids the extra reduction by checking whether the packet
was actually enqueued. It also moves qdisc_tree_reduce_backlog()
out of cake_drop() to keep backlog accounting consistent.

Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: add missing cc
v3: move qdisc_tree_reduce_backlog out of cake_drop

 net/sched/sch_cake.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c2..179cafe05085 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 	sch->q.qlen--;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
@@ -1750,7 +1749,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx, tin;
+	u32 dropped = 0;
+	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
+	bool same_flow = false;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1927,24 +1928,31 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (q->buffer_used > q->buffer_max_used)
 		q->buffer_max_used = q->buffer_used;
 
-	if (q->buffer_used > q->buffer_limit) {
-		bool same_flow = false;
-		u32 dropped = 0;
-		u32 drop_id;
+	if (q->buffer_used <= q->buffer_limit)
+		return NET_XMIT_SUCCESS;
 
-		while (q->buffer_used > q->buffer_limit) {
-			dropped++;
-			drop_id = cake_drop(sch, to_free);
+	prev_qlen = sch->q.qlen;
+	prev_backlog = sch->qstats.backlog;
 
-			if ((drop_id >> 16) == tin &&
-			    (drop_id & 0xFFFF) == idx)
-				same_flow = true;
-		}
-		b->drop_overlimit += dropped;
+	while (q->buffer_used > q->buffer_limit) {
+		dropped++;
+		drop_id = cake_drop(sch, to_free);
+		if ((drop_id >> 16) == tin &&
+		    (drop_id & 0xFFFF) == idx)
+			same_flow = true;
+	}
+	b->drop_overlimit += dropped;
+
+	/* Compute the droppped qlen and pkt length */
+	prev_qlen -= sch->q.qlen;
+	prev_backlog -= sch->qstats.backlog;
 
-		if (same_flow)
-			return NET_XMIT_CN;
+	if (same_flow) {
+		qdisc_tree_reduce_backlog(sch, prev_qlen - 1,
+					  prev_backlog - len);
+		return NET_XMIT_CN;
 	}
+	qdisc_tree_reduce_backlog(sch, prev_qlen, prev_backlog);
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.43.0


