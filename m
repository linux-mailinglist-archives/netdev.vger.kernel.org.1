Return-Path: <netdev+bounces-183218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A2A8B69E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD35A167B27
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E6238C10;
	Wed, 16 Apr 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QP15S4T6"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647E22157B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798772; cv=none; b=GJUfJlEc1+Ap5EgO/+vDhp/Ux/kACTURo4sue8J2jjTkdi8bTV9csxKVcWa+9ryLBcdEW19Sv3mNoxzp0Pnmb4vongE1mglPRnCMRap9idzMW/Djc7C8XMDb3M7y55B4aztLsgDE9q3sBgFNiJ/YTQ46bdJf7C2O0nGK27WAeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798772; c=relaxed/simple;
	bh=VajtxdZtXPXZJIMdUBloDGEwDgBVx6vtUYVnxS9bPMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fhs9CYZO17gBY0W0+mvMmJbQRF+k325YlyhBYJrE9KlxgtCKdtBJ2RknnKkpvwI6N18R4TclFy/T7VdFDmeKFCFplIN1KfTMrxdkh3tCy4KYKYwXoAb9MjGiyrHmXmVjPw3Z+JMtNNQH0KeIhjD0yVp/sArsirXowXnmCMksZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QP15S4T6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250416101927euoutp01588d56f58a6605fbffdd233d3474556e~2xTwAFHeR3141631416euoutp01P
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250416101927euoutp01588d56f58a6605fbffdd233d3474556e~2xTwAFHeR3141631416euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744798767;
	bh=Fnu34OTKoZur1MRsDH3t+4o7UeBrOio4PhVkGpMtUqc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QP15S4T6B1Iq85biHOzkGkkGbv7XKKTSra6QMZdRoBfuipojsbeH4pg95Mvu+lGfa
	 xGsNIaOo7qfRvb3+72NFg8GsESHMB/s+y6nBLYqxlSHc2xaWsIz2yQwnao1A8U76NQ
	 /fbw5dS6Q21oyqkuZvCr2W9QDHrBoE3Cv1ictRvw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250416101926eucas1p18efc08375e0478c1442f84ef4c4de7c8~2xTvqbTaK1096710967eucas1p1I;
	Wed, 16 Apr 2025 10:19:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.B8.20821.E248FF76; Wed, 16
	Apr 2025 11:19:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250416101926eucas1p193c52e72b20321605905f1c465c8ac06~2xTvSxVEK1095810958eucas1p1P;
	Wed, 16 Apr 2025 10:19:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250416101926eusmtrp2c2afe5b64e1b5996223adbbb2c7f3e75~2xTvQi6gt2819328193eusmtrp2K;
	Wed, 16 Apr 2025 10:19:26 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-43-67ff842e7292
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.6F.19920.E248FF76; Wed, 16
	Apr 2025 11:19:26 +0100 (BST)
Received: from panorka.. (unknown [106.210.135.126]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250416101925eusmtip2ee6b878b35adf1a9a51f147fa7f6d3d8~2xTuosv7W2622326223eusmtip2G;
	Wed, 16 Apr 2025 10:19:25 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH v2 bpf] xsk: Fix race condition in AF_XDP generic RX path
Date: Wed, 16 Apr 2025 12:19:08 +0200
Message-Id: <20250416101908.10919-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzneV29lv/pBkcadSy2vl/FYvFg9lJm
	i13rZjJbXN41h83i5vHnLBYrDp1gtzi2QMyB3WPnrLvsHov3vGTy2LSqk83j4Ls9TB6fN8kF
	sEZx2aSk5mSWpRbp2yVwZWy9upStoEum4kLfecYGxpniXYycHBICJhLvz79n62Lk4hASWMEo
	seLTV0YI5wujxKeOq6wQzmdGif55S5hhWr6sX8QMkVjOKHF43mqo/peMEpf7zoNVsQkYSzR9
	388CYosIWEhsWvQNbBSzwCxGiSV7doElhAU8JV5/aGQEsVkEVCWu73/MDmLzCjhLTL2/nQli
	nbzE/oNnmSHighInZz4B62UGijdvnQ110lwOiUcPlSBsF4mJb25D9QpLvDq+hR3ClpH4v3M+
	E8gREgLNjBKzZnayQzg9jBJrrl4BuoIDyLGWWHvSFsRkFtCUWL9LHyLqKHF/Kw+EySdx460g
	xAV8EpO2TWeGCPNKdLQJQSzSkbhx8TnUUimJ7zM3s0DYHhLX+rawgpQLCcRK3DnAMYFRYRaS
	t2YheWsWwgULGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKaZ0/+Of9rBOPfVR71D
	jEwcjIcYJTiYlUR4z5n/SxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2h/a7qQQHpiSWp2ampB
	ahFMlomDU6qByaKct8mi88ebjLztnZbfQqYxzXv4YilHesTZF7XR1iuVgpbM6ng2l3HfxFPb
	BT3l42Rl3LYz2fM3NhrfVVqw3daPLe1b6RuRkFnFaeJHq76sqWtedvAO+9Xd4bsbGTdk3/WY
	al++y+NZZ/c07vq/OyUf3rV1sD1bF8xYVqV4objcsaev+sPXx5vaedosbRltTmeGilp2Lk5a
	9MX+74bq9c98F+ZPnszWfva6p9CKfQ5JZz1WvJ89qXU6w7rsiFI5rs2r41ZrFnY3ps1Oi7l6
	vTL2/U5jmfRn3W7it+7MKHlhPTcwWTzJ87VzsNV1m5vv5lkuexrSvJFpwd+W3yFTbSKm3vyp
	Jn7nmVsn24c1SizFGYmGWsxFxYkAKRsdMaIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xe7p6Lf/TDT6cFbTY+n4Vi8WD2UuZ
	LXatm8lscXnXHDaLm8efs1isOHSC3eLYAjEHdo+ds+6yeyze85LJY9OqTjaPg+/2MHl83iQX
	wBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H1
	6lK2gi6Zigt95xkbGGeKdzFyckgImEh8Wb+IuYuRi0NIYCmjxKnOr8wQCSmJP+v+QNnCEn+u
	dbFBFD1nlPjU8pAdJMEmYCzR9H0/C4gtImAl8eD2P7BJzALzGCXm7FrPCpIQFvCUeP2hkRHE
	ZhFQlbi+/zFYM6+As8TU+9uZIDbIS+w/eJYZIi4ocXLmE7ChzEDx5q2zmScw8s1CkpqFJLWA
	kWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJBvO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJ7
	zvxfuhBvSmJlVWpRfnxRaU5q8SFGU6D7JjJLiSbnA+MsryTe0MzA1NDEzNLA1NLMWEmc1+3y
	+TQhgfTEktTs1NSC1CKYPiYOTqkGJv/Sg8u2KOyrCa8+MHmH6alUe74kxaKMVp6+6iqWGwEe
	rwUZZZRCJ+/fl8G4vHFB+BrfU0kNEntnqpcbRuklufFc2Hj5XX7roozd344c40i6t1NVVYBH
	m0nFnvPKeYPLLverNkZyrvg5Z3efj90JTgOvH7Ns8sPSd/Xyc3cr3/zwc2u3m43jHoMc9fJz
	Wb1mj36l7Uj+4TknPO7v4nVnWbdNrGv+XDzd1+NKW/EslyjJ/OUXLMzcU+e15bi+3rCYu82e
	cbNy1yMPq5jJwdICP2Q5G64xhC1g/DXb+ZDDD6Vl+h+FC5qNebvTQybZZX75v2Nu5FyPm53v
	Hn5ZrXzq/uvw29n7n+ns1qnZwR2txFKckWioxVxUnAgAgmxoJvsCAAA=
X-CMS-MailID: 20250416101926eucas1p193c52e72b20321605905f1c465c8ac06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250416101926eucas1p193c52e72b20321605905f1c465c8ac06
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250416101926eucas1p193c52e72b20321605905f1c465c8ac06
References: <CGME20250416101926eucas1p193c52e72b20321605905f1c465c8ac06@eucas1p1.samsung.com>

Move rx_lock from xsk_socket to xsk_buff_pool.
Fix synchronization for shared umem mode in
generic RX path where multiple sockets share
single xsk_buff_pool.

RX queue is exclusive to xsk_socket, while FILL
queue can be shared between multiple sockets.
This could result in race condition where two
CPU cores access RX path of two different sockets
sharing the same umem.

Protect both queues by acquiring spinlock in shared
xsk_buff_pool.

Lock contention may be minimized in the future by some
per-thread FQ buffering.

It's safe and necessary to move spin_lock_bh(rx_lock)
after xsk_rcv_check():
* xs->pool and spinlock_init is synchronized by
  xsk_bind() -> xsk_is_bound() memory barriers.
* xsk_rcv_check() may return true at the moment
  of xsk_release() or xsk_unbind_dev(),
  however this will not cause any data races or
  race conditions. xsk_unbind_dev() removes xdp
  socket from all maps and waits for completion
  of all outstanding rx operations. Packets in
  RX path will either complete safely or drop.

Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Fixes: bf0bdd1343efb ("xdp: fix race on generic receive path")
---
 include/net/xdp_sock.h      | 3 ---
 include/net/xsk_buff_pool.h | 2 ++
 net/xdp/xsk.c               | 6 +++---
 net/xdp/xsk_buff_pool.c     | 1 +
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index bfe625b55d55..df3f5f07bc7c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -71,9 +71,6 @@ struct xdp_sock {
 	 */
 	u32 tx_budget_spent;
 
-	/* Protects generic receive. */
-	spinlock_t rx_lock;
-
 	/* Statistics */
 	u64 rx_dropped;
 	u64 rx_queue_full;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 50779406bc2d..7f0a75d6563d 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -53,6 +53,8 @@ struct xsk_buff_pool {
 	refcount_t users;
 	struct xdp_umem *umem;
 	struct work_struct work;
+	/* Protects generic receive in shared and non-shared umem mode. */
+	spinlock_t rx_lock;
 	struct list_head free_list;
 	struct list_head xskb_list;
 	u32 heads_cnt;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..e2a75f3be237 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -337,13 +337,14 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	u32 len = xdp_get_buff_len(xdp);
 	int err;
 
-	spin_lock_bh(&xs->rx_lock);
 	err = xsk_rcv_check(xs, xdp, len);
 	if (!err) {
+		spin_lock_bh(&xs->pool->rx_lock);
 		err = __xsk_rcv(xs, xdp, len);
 		xsk_flush(xs);
+		spin_unlock_bh(&xs->pool->rx_lock);
 	}
-	spin_unlock_bh(&xs->rx_lock);
+
 	return err;
 }
 
@@ -1724,7 +1725,6 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
 	mutex_init(&xs->mutex);
-	spin_lock_init(&xs->rx_lock);
 
 	INIT_LIST_HEAD(&xs->map_list);
 	spin_lock_init(&xs->map_list_lock);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f7975b49657..3a5f16f53178 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -87,6 +87,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool->addrs = umem->addrs;
 	pool->tx_metadata_len = umem->tx_metadata_len;
 	pool->tx_sw_csum = umem->flags & XDP_UMEM_TX_SW_CSUM;
+	spin_lock_init(&pool->rx_lock);
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
-- 
2.34.1


