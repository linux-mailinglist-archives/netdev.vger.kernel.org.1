Return-Path: <netdev+bounces-180759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFDA82565
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FB43B96BD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A1265627;
	Wed,  9 Apr 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bijmABSU"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06348263C78
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203143; cv=none; b=Wc6FN7sZ0O8iD4m1cqGQgDVf145ffCdNJSvCuCKDDzNrzQRwH4yk5Z/7mtPCOE956/v1czj0EnGd3R8eZBqDyZ4U+CG8KiHqzayojG+Q6ldscb7GqiOkycK1BSvRz4bmcr/BBB8mP0atAFYtB+U1vpADQiDig6UygjoJM2lOxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203143; c=relaxed/simple;
	bh=VRVdHQosnpdghOkblzY+Q6O7G0A0ldhMteIRbIkzuHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LoiMhBUyMNIULzo4iyzbE0uB4oxO9h1cG3R6HM+NMhShgb6sG2Wnq7+qIMW7DOmyK2V5HCjMKwmYQvNmF48jV4cxYJ+tuNH41yqHGGPcZfYtcbNxXSkA/v8sfKzH1ltTmeE2Dpc8aX77ZzGXXaKyeEFkbRrIsaG17qpEReojvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bijmABSU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409125216euoutp02eea09b511faec6adf44bc306aed1e8ef~0p4MLFJ9X2353723537euoutp02W
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409125216euoutp02eea09b511faec6adf44bc306aed1e8ef~0p4MLFJ9X2353723537euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744203137;
	bh=d4Y7SWFI4qVzd8NlSNxlD8Ff/ZD2SwDfY5q3CblmY7g=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bijmABSUltROHCz0+LgBRXSBu6ooK+6V9Mfi0Y6T6YQg2ukPCjjX3JI+/JQcW9o5/
	 ttLfd8MJEtizuMnzT3rjazezu4zvbzHGmp1AIVPMGEgk0+X+0KBjB2BKes7D6/Frhx
	 lXL6lonKnJJa+ir9cqnqXff3BBN9+bYyATM2XtH0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250409125216eucas1p1453b5f9e90636a05728dcc6173dc4531~0p4L8PL5M1939619396eucas1p1i;
	Wed,  9 Apr 2025 12:52:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.22.20397.08D66F76; Wed,  9
	Apr 2025 13:52:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250409125216eucas1p150b189cd13807197a233718302103a02~0p4Leaiy90659606596eucas1p1V;
	Wed,  9 Apr 2025 12:52:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409125216eusmtrp11e8b63b62e7462829208962a12713787~0p4LdzomC0724607246eusmtrp1j;
	Wed,  9 Apr 2025 12:52:16 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-53-67f66d8050f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.1D.19654.08D66F76; Wed,  9
	Apr 2025 13:52:16 +0100 (BST)
Received: from localhost.localdomain (unknown [106.210.135.126]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409125215eusmtip26ea0b30a2e1e7930bd611bbc1d4e540d~0p4LCrRvT2770527705eusmtip2u;
	Wed,  9 Apr 2025 12:52:15 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH] xsk: Fix race condition in AF_XDP generic RX path
Date: Wed,  9 Apr 2025 14:49:50 +0200
Message-Id: <20250409124950.58819-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87oNud/SDa60qVpsfb+KxeLB7KXM
	FrvWzWS2uLxrDpvFzePPWSxWHDrBbnFsgZgDu8fOWXfZPRbvecnksWlVJ5vHwXd7mDw+b5IL
	YI3isklJzcksSy3St0vgypj07AZbwWPpip7dF9gaGL+LdTFyckgImEh0Pf3E3MXIxSEksIJR
	Yv2j74wQzhdGiUsLPzOCVAkJfGaU2LSXB6Zj/8XFrBBFyxklTm78BdX+lVHiwLPbLCBVbALG
	Ek3f94PZIgIWEpsWfQPrYBaYxSixZM8usISwgJPEwpV/2EFsFgFVib8n74LZvALOEgdvLWCE
	WCcvsf/gWWaIuKDEyZlPwHqZgeLNW2eDbZYQmMsh8XnSFTaIBheJ/imbWCBsYYlXx7ewQ9gy
	Eqcn97BANDQzSsya2ckO4fQwSqy5egVoHQeQYy2x9qQtiMksoCmxfpc+RK+jxNFZD9khKvgk
	brwVhLiBT2LStunMEGFeiY42IYhqHYkbF59DbZWS+D5zM9Q1HhJbT+5gg4RorERn1wKWCYwK
	s5B8NgvJZ7MQbljAyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMNWc/nf86w7GFa8+
	6h1iZOJgPMQowcGsJML7duKXdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8i/a3pgsJpCeWpGan
	phakFsFkmTg4pRqYhLQ4FqZMSeS9Piv8QuexfZvKNWOWaLMdzk1tCbdds+7VYcv/8wKqfjoq
	fTaV4nKwOvPStul020T+q8ahP5IMt+vf3DVxUcF7Nc7KDYY3tR32WK5aFqp+/mhTkpVlxP7u
	c/0KZ76yRWVNqj584MAtH5kl34JzT23ZfdPjW59btPb2k++byg60Z0tN1crxMFynWlE/Z84j
	yZYlO+vuqJ1n4XQ5L3z42E0m5syXOquyJ61V5axPvZN5t1zl4spCDo+gnYXXMjsCPf80mKRl
	eKSZr+8vNq98tHBOzOEMx91ng/Z736lgcOL8LPRI3K3Hfr5rS6h2uNq5335pnbx38nZ97UsN
	N3z57XF1sGr9mZNKLMUZiYZazEXFiQBV1rXYpAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xe7oNud/SDaZ8ZbHY+n4Vi8WD2UuZ
	LXatm8lscXnXHDaLm8efs1isOHSC3eLYAjEHdo+ds+6yeyze85LJY9OqTjaPg+/2MHl83iQX
	wBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHp
	2Q22gsfSFT27L7A1MH4X62Lk5JAQMJHYf3ExaxcjF4eQwFJGiV9fZzFCJKQk/qz7wwxhC0v8
	udbFBlH0mVHi+5QudpAEm4CxRNP3/SwgtoiAlcSD2/+YQYqYBeYxSszZtZ4VJCEs4CSxcOUf
	sAYWAVWJvyfvgtm8As4SB28tgNomL7H/4FlmiLigxMmZT8CGMgPFm7fOZp7AyDcLSWoWktQC
	RqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgUG+7djPLTsYV776qHeIkYmD8RCjBAezkgjv
	24lf0oV4UxIrq1KL8uOLSnNSiw8xmgLdN5FZSjQ5HxhneSXxhmYGpoYmZpYGppZmxkrivGxX
	zqcJCaQnlqRmp6YWpBbB9DFxcEo1MHFV926sZDTeJxUsrPHggY3Ckr3qvSFrs9J3ni6XvVpc
	6Z1Qmhw5MXFx78/0k+v3nRSouyJ7U/Kj1pNpUl9KasRM1PhNju2ZeuqTRO8q60mH59V2H2d5
	lcH1p3DNyx/z8ufXl57LTwcC7/9pFRLLJxq0m3xkYFkpufbfZ5+/pR9K29LKrk5LvrShTYfx
	Oe+KbbNn3uA8sr3CTKUq7stRc8u7Oqdtr83J1WG9WDG9yp1N4HSeGb+iSO7HKntR2+fKl8JZ
	754UiLeLDLVZHGiW5Px19+xLOxls97FtmSNo+OxzpMd2lke8O77eDF5fJR/s3BXioF79e1ed
	67H2jrU/UvMrlnesrxZ/pVO700uJpTgj0VCLuag4EQBCJHS2+wIAAA==
X-CMS-MailID: 20250409125216eucas1p150b189cd13807197a233718302103a02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409125216eucas1p150b189cd13807197a233718302103a02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409125216eucas1p150b189cd13807197a233718302103a02
References: <CGME20250409125216eucas1p150b189cd13807197a233718302103a02@eucas1p1.samsung.com>

rx_lock moved from xsk_socket to xsk_buff_pool.
Previous synchronization didn't take care of
shared umem mode in generic RX path where sockets
share the same xsk_buff_pool.

RX queue is exclusive to xsk_socket, while FILL
queue can be shared between multiple sockets.
This could result in race condition where two
CPU cores access RX path of two different sockets
sharing the same umem.

Now both queues are protected by acquiring spinlock
in shared xsk_buff_pool.

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


