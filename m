Return-Path: <netdev+bounces-246707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBECF093E
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 04:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC27300F590
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 03:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F523D7DC;
	Sun,  4 Jan 2026 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrt/4vmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AD279795
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497008; cv=none; b=hRAGgIMpVi2hUdhfqMSXvMBiBjA7elBQgHhJmgd4wJol3ghNDY+Z+2wE/nhkUpNzFnxOo19e+4MLLZ6UqKc/xHDYurZgpY30/ivylKA0dsaUz++1siZT3LY+j9XW1mzuTwITgK3OcaVO8Zg74I3QZpFpDKN0sc+Omz8t6k24PRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497008; c=relaxed/simple;
	bh=iFOjWoPhxg3t7eBaMyFBLT+tXL3mjtPxiiafXceNxzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koX+AKIzSoz3wJQG5s/Kzfvs1RgocMG0nUNEWUaUYU1WAZjMaB5n962Q6eqOT8Jg/3SyH60kLgmCrLuXjhN0iXmBWJ1w/1tpPluYz6HYGyQ7Pl+UN/HGOwCVG2O+IkC0sJzkmxJXPgZfWkfb5mTWT/yt0nC2lyOX+sI5MwCBTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrt/4vmK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a07fac8aa1so141758305ad.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767497006; x=1768101806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=Qrt/4vmKLcBWFd8qIPznx5h3nS4DSeH4MgIfvYsZFyt424akY7dM9VkcTJD9T5b4SP
         zNRSz/OHYKavfqHf8yafHSQ5OAPnSNndRt1BuqyWiu4tZcTcdsy36xVTlntcYGMV7ehV
         8Nbk0g3Lt51+/Sr4poSyULJ6kTnBqfgYol+Vmt75nsqISrufU8ilWGc6BrlOlUXYUlbn
         ZgRpAnnFNJJYAUjEmgmbAS3m7ImeDRiyYHWenT6T1yFSf7Yjs1ZFaR9k8q3MJYVPpJzh
         UCtk7UVrZ6z8OZ8t06N9nSDHQkK6/t4T88yd0C3mlEdO7rHGLbsgaBk4cONPFgnkDNr/
         ZSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767497006; x=1768101806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=TSv02tYQEc0EtLp/pYTQ1rAEJnWA6G78SNk+v4QdKYu0liqERnoaGpjgD+kAsyVdt8
         7xe2/QPT+bLshEVqIdxaLmhm1jNGHal2QDtLW0Au6wuBNWqWJcxlsNVDRHlbQ3bbjOWl
         D9lg909JslLljQ6zpRQr00ybgsLsL8NEKGky6IDUfg2n0lBgbNyqPg27GmCydyiMC47T
         LXmc5VQtDYuGJDokNf5/O81bLhcUA2KMMNPnLx783TMAuztEVy8rMs3CAPye38V0gC2h
         WnC4Vp9+aX/2B28L84n8kQvJxvKiyHW/7waQXtHGSR+ClIJuubRyOaAfit1gXFWDWnom
         jmXA==
X-Forwarded-Encrypted: i=1; AJvYcCWWzznEpMV3z7obbWzI6SVXcwPYwHVsKJZfvpNrh2B0xvlWs9wwmW4wSgwFE8omWeGohF+df0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LKA/Msm2M7THQ9/Hw5YZo5XqgZ0l7nHaQoNiJDIVI6qYXgTF
	sQvx4rsQgz8rppSiQ2A1ndB3wcxmJPqpfuVZRS89naqArzOJhqP1dsOW
X-Gm-Gg: AY/fxX6lAE2NPvgHsFuNouVFklsEUl9UhV9rdF9hbyu3INKCs876oCwpWmduLrC7+5z
	om2xitcYLTbUxYlrpVFJw3i+8ndHkn/yWw7HYBWhaPrVvDEmixiLC7Muu7Lhf3Rq+FhGd1UQ4gM
	Z8aRysRFx+f3lO6fTneBWmGUV4UZ9XdQcPVqYv8R0d2D31Ehw3PVc23zjWUBmF/6frSPEbdpFfP
	cgjuAMhSxoY3nv+is7u+w1enL+xlTu+ZS/9vqE8cirGQ/tFtPeeyAy3Lco80nqITdMLRHK/pmCq
	rcCctaZUE4m4dSC/OF9so4ADmmmwOM6BFBDeSyeUYgtcv90uZe0j2QMbrxQBEjgZy7eJsefCqjL
	ah+cZPC/MxB1s7W4iPoZUd8yKxlfsbGY64EohTV+o/v/9C6P2hedM9Y8knw5D2RHc/lJ1Gttk+/
	mfFjUuxZl4lN2kq+hufwpd40eBGhqD8zIjR+/K2YCajToct5nEhFs1XATKxA==
X-Google-Smtp-Source: AGHT+IGr13ReutP5qE+ejFO23iRKdsVsI8sXEEpX3MmrgkrlkmT9JrGKSx2JjX38pbQ5xXYbt7wbJQ==
X-Received: by 2002:a17:902:f60c:b0:2a0:8966:7c94 with SMTP id d9443c01a7336-2a2f22262e1mr444079965ad.20.1767497006156;
        Sat, 03 Jan 2026 19:23:26 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6d557sm405852335ad.84.2026.01.03.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 19:23:25 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/2] xsk: introduce local_cq for each af_xdp socket
Date: Sun,  4 Jan 2026 11:23:12 +0800
Message-Id: <20260104032313.76121-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104032313.76121-1-kerneljasonxing@gmail.com>
References: <20260104032313.76121-1-kerneljasonxing@gmail.com>
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
 include/net/xdp_sock.h |  8 +++++++
 net/xdp/xsk.c          | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index f093c3453f64..f41e0b480aa4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1212,6 +1212,34 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+/* Initialize local compeletion queue for each xsk */
+static int xsk_init_local_cq(struct xdp_sock *xs)
+{
+	struct xsk_queue *cq = xs->pool->cq;
+	size_t size;
+
+	if (!cq || !cq->nentries)
+		return -EINVAL;
+
+	size = struct_size_t(struct local_cq, desc, cq->nentries);
+	xs->lcq = vmalloc(size);
+	if (!xs->lcq)
+		return -ENOMEM;
+	xs->lcq->ring_mask = cq->nentries - 1;
+	xs->lcq->prod = 0;
+
+	return 0;
+}
+
+static void xsk_clear_local_cq(struct xdp_sock *xs)
+{
+	if (!xs->lcq)
+		return;
+
+	vfree(xs->lcq);
+	xs->lcq = NULL;
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1360,9 +1388,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
@@ -1380,6 +1417,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
@@ -1387,6 +1431,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					xsk_clear_local_cq(xs);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1409,8 +1454,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
@@ -1836,6 +1889,7 @@ static void xsk_destruct(struct sock *sk)
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
 
+	xsk_clear_local_cq(xs);
 	if (!xp_put_pool(xs->pool))
 		xdp_put_umem(xs->umem, !xs->pool);
 }
-- 
2.41.3


