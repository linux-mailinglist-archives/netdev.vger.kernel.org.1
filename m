Return-Path: <netdev+bounces-244079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77697CAF5F1
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 10:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C450D3034EC6
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86D23AB88;
	Tue,  9 Dec 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv2bziyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E575217F33
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270817; cv=none; b=gJDhYcLFlVX5x6BKC+DLPuJsgSdKfu0nfnx7/Vucx7Xv83XHtPT0axO+oCMkVM5rclkeqNo/FMH0oaNjLag+cGIWyuSRMTZHrtKpV34Lc3Wo/JyopZmfidsEApQGoutJM8pjEAyRSiwA8d8DXF7TCuls3eE0Q167S8IkMPKIaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270817; c=relaxed/simple;
	bh=JHroTEMyfupq29vOrRue1xESuHqQKAvnMhx8CcDwX7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IS7WRgF3swimxuBuqcDkIqeFf10ufgnVm33lcGvQccGuZcDDzqAqVukQE84kaJRmcKtN5mOLr1jSKPxmh4l9RUOlYH91g/LQZAgGRCbcUDF+pC0X4p2tnrr7J6IhNBousMNvD4p9wv+7FEU6PBT2CPA8JHmwYG3SQs6s/Ntinxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv2bziyd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f1243792f2so239308b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 01:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270815; x=1765875615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bTNvoH6Cqb4MH/tDk1J6yCXGyoeCOCFXoYiPhKgWss=;
        b=Rv2bziyde30rwo7yZ0w+2ALOS1T8uhdrMhACH5Mi3Ty0HeafoQoCB6eNA9289puLAc
         E4kSdQmWPz+de3VCQGhVEeileh4NYfJ1/kxtW4GYmofbH+FEudkdYaZfEQwwCNsuStrG
         nUhob5N8qwFIuHnbM5qhgEMbAbUV+t0W3GKHJ2ndlYggoxY4bVS6DnULRsGAJTt2W5PS
         hk627QLCEuT8v0AiQIp0jL58HSC29NIsexsSbn+kwT5ce8CWmfa5WrPAMT/16SAnxM/3
         3z9dvdpqS02nOygtJx7cTGObS5nCGhgJ9+TxgIP1zLgR2SEP78PQ4yZWpqf3BKrQAPyd
         ZdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270815; x=1765875615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bTNvoH6Cqb4MH/tDk1J6yCXGyoeCOCFXoYiPhKgWss=;
        b=iJave+6DGuoZ0Sc/GAKXp/xmvg20hDEulTU2YeFhh5f0YvQET+sZMVEaTNC2iGW5Yd
         flS71/knqgoI3E3mBsgVyFDskuL93r9mB8LmatdBnWY/uSc2mIgMT+kpzVsLfMd7ZAOU
         jqMuuo4dmGpR7symFM50M8qSFaczeImEM31yOeT1bECiA1gkN/GKoC27Mjkd1pX4F9NC
         AbwO+lSBusPMaX1xBn1k7Vqis+LWkN5CDSHZHpUhvq3b5HKVLDLZLuF+u/vo7Df98xbG
         4cEGnbPey4boXfq80ZHC1Um8axubrGHbOfZ2ZnUPoKV3l/0P2UFu019XRdL59SyCkmWP
         HVew==
X-Forwarded-Encrypted: i=1; AJvYcCX6lbFGGRCcSkhZ6j1fgBmp/ANnA7AMTLhBj280/4Iasuc2l01AeIs6hBQtQ4S9lg1k09OaThg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWj4O4Oac0Yb0RNkjuokxiJOyJ6LU0MOdgl9c201gtXgBlqhbw
	Gi0XNAw8ag2daqS6IEnq97dObTyfmg5U3iCt038SSEZTQ2uIs59YQW0T
X-Gm-Gg: ASbGncvGAQpweU3e6D0TGawrJCuLoobq5D+QhS7tHcYohdLWSd+y8bBMdXwjQpXO1EW
	dX5w+NHAkQO8XIjf1QlImu7Kf9sJcVqnj4plE7wRXWPNZ73MAYCpCIgNO+2m0lqFvuMNAlIFLfR
	HE775+h6GsgEsJMMHaNTevKk8k5e2UUXf92CCniRCgKHtq6Y/DhOTbECwvXduINRQbpAdY6VdEd
	Be5eTUMvd0B1/6NYBEQznVkgs+GV3oqxjPXtuGc6Ws/Ty6FkX10QrfVlr/VcArdvjn0PgdSabkP
	PFqytgoegl1aigk26QLOst0soEsnyBt+31oFdIT5QKkgIKKa7d5sb9yLHozdO6EmEa2+QSpnbs+
	o2jdXGeArgPo/OjqUQc8Md2A9IRgMrJ2OccJs+JYxG0LD0Dt+W014SmpgArbk47LHI9VT3ZFZFo
	l7Ent2dLvrcxT5kSUH3FnGJtv95wly6d8e3RDcrxASBk5Kk4cldVZgvXsIKg==
X-Google-Smtp-Source: AGHT+IGtumZERLJe5umYw0NAN/Hzo1RXCgUM9ubAGmgLDKCtZb2zhPULGxHRli/Er/2rBYD3unFxZg==
X-Received: by 2002:a05:6a00:234c:b0:7e8:43f5:bd36 with SMTP id d2e1a72fcca58-7e8c3909157mr9096188b3a.34.1765270815417;
        Tue, 09 Dec 2025 01:00:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm15529015b3a.7.2025.12.09.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:00:15 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v1 1/2] xsk: introduce local_cq for each af_xdp socket
Date: Tue,  9 Dec 2025 16:59:49 +0800
Message-Id: <20251209085950.96231-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251209085950.96231-1-kerneljasonxing@gmail.com>
References: <20251209085950.96231-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is a prep that will be used to store the addr(s) of descriptors so
that each skb going to the end of life can publish corresponding addr(s)
in its completion queue that can be read by userspace.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  8 ++++++++
 net/xdp/xsk.c          | 44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..c53ab2609d8c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct local_cq {
+	u32 prod ____cacheline_aligned_in_smp;
+	u32 ring_mask ____cacheline_aligned_in_smp;
+	u64 desc[] ____cacheline_aligned_in_smp;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,8 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	/* Maintain addr(s) of descriptors locally */
+	struct local_cq *lcq;
 };
 
 /*
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..ce165d093105 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1212,6 +1212,24 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+static int xsk_init_local_cq(struct xdp_sock *xs)
+{
+	u32 nentries = xs->pool->cq->nentries;
+	size_t size = struct_size_t(struct local_cq, desc, nentries);
+
+	xs->lcq = vmalloc(size);
+	if (!xs->lcq)
+		return -ENOMEM;
+	xs->lcq->ring_mask = nentries - 1;
+
+	return 0;
+}
+
+static void xsk_clear_local_cq(struct xdp_sock *xs)
+{
+	vfree(xs->lcq);
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1241,6 +1259,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xsk_clear_local_cq(xs);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1360,9 +1379,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 				goto out_unlock;
 			}
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_destroy(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			err = xp_assign_dev_shared(xs->pool, umem_xs, dev,
 						   qid);
 			if (err) {
+				xsk_clear_local_cq(xs);
 				xp_destroy(xs->pool);
 				xs->pool = NULL;
 				sockfd_put(sock);
@@ -1380,6 +1408,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			xp_get_pool(umem_xs->pool);
 			xs->pool = umem_xs->pool;
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_put_pool(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
 			/* If underlying shared umem was created without Tx
 			 * ring, allocate Tx descs array that Tx batching API
 			 * utilizes
@@ -1387,6 +1422,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					xsk_clear_local_cq(xs);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1409,8 +1445,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			goto out_unlock;
 		}
 
+		err = xsk_init_local_cq(xs);
+		if (err) {
+			xp_destroy(xs->pool);
+			xs->pool = NULL;
+			goto out_unlock;
+		}
+
 		err = xp_assign_dev(xs->pool, dev, qid, flags);
 		if (err) {
+			xsk_clear_local_cq(xs);
 			xp_destroy(xs->pool);
 			xs->pool = NULL;
 			goto out_unlock;
-- 
2.41.3


