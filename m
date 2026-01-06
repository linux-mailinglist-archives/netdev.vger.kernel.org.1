Return-Path: <netdev+bounces-247490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C037ACFB3F0
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE98A3052ECA
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59DF2DFA46;
	Tue,  6 Jan 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZCSJydTK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA62D94A3;
	Tue,  6 Jan 2026 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737985; cv=none; b=WHtoIIAk66m5CcvUqDwPqNazji3b/Zid1QZ4qIkv187F4rjo/UL5ZyLkJ0BUmsYtq4c1PZoQ+OqxMG6BQnnpAZ6bPn6Hxm3PoxMb+SS5Tztf3+l+HFWWFut5lOGnVM+aHUAevRf1pg2pPkXng5iBl/rCNHGWRaX/LVYHuw92PKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737985; c=relaxed/simple;
	bh=Ppia3aRkBL+zwvoOlp89kwj2ZRIDIGVwmdOOAige48M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSaXmGtlWOOretLz2hLh1acqFY46fzlfo7GqcjJf42gsJJxC0b7IoQmRhZR/IMCebPuTLZeZgCfaZgoQD92nNe39x5CkKe8LPK9LbGP8x2x5hEdiXdiPqWw/muH3/mBl8fMqEZCX9gERPosDfBnHmgBWJc7+izU8LGCB7jsiSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZCSJydTK; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606IqnTH1802704;
	Tue, 6 Jan 2026 14:19:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PeF88+FM6QURusx97ZlDbQegPUu1QQQt1VzkELLyx0M=; b=ZCSJydTKtcL1
	OIAHaLp9AdWBZJD2mQHwWZj0gOO2HEFS0KbgpO9bZVZ/wiyyiXm0bl0ylCtn/2CO
	aOXzN7o7eKq781wCA7sl1/86SNUviXWKDG4TNbV8n19IBRXWzFsgMd9uIxO3No7w
	Uic/+bTVYLZ67/pSSbkaNCP0PAeFh/4+dXbPbfouym2nwR0G03LotfRbBEbB6aKT
	iETwuMjwMRyAqA7uqWejEwHIPylfiT8GOchRnG0puP7D4jErao6d/n+1IQSZolCD
	08AwbBC6r/LDDz6Mz0/TSDOV++GyAGtXVLjHpn+bU/rsv1MJx6JRQCerb0cdn9PR
	Wo1K4sZzTA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bh14vd8cp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 Jan 2026 14:19:29 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.29; Tue, 6 Jan
 2026 22:19:28 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] virtio_net: add page pool support for buffer allocation
Date: Tue, 6 Jan 2026 14:19:23 -0800
Message-ID: <20260106221924.123856-2-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106221924.123856-1-vishs@meta.com>
References: <20260106221924.123856-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dtPWylg4 c=1 sm=1 tr=0 ts=695d8a71 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=gD-bKePctUg2aiC0oG0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: R2qSMBeIWkGuvulpD_EIXvPECPtMz6_p
X-Proofpoint-ORIG-GUID: R2qSMBeIWkGuvulpD_EIXvPECPtMz6_p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE5MyBTYWx0ZWRfXy2/UboZZMjwt
 A4ckb74kW478WUgLbdRpPWLGEi7En0qfPhw8hE3P2MhMjl7q0a/xyzHg61E8/E4uy3RJdnZkyLS
 NaoX+b1IcvZ44+TIdyj0/1sU/g+0W2Lzr7aQmy0xAMkcxPRC/sIKW9OG+F++E3al+G6/NX2E307
 yWbnj9HSiDU4aBrLeFiaa6WeoH/4Rgrl6R+r/Ul9xcZ70pj2/49AvYFGCmlIat0AFhhW3poB2Og
 kZZn0a8tEKryFxVx8NcdTjA+oJnn3V0NRejhXV5+5hMaiXbOFw6+1ZMrij3DefiRIyrIBIdC6Ag
 BgV9kztEW9vqW2A91y1wG4xouUGs+0qZIJ0UOLIB+zTBBlEg7ttERliRB3yt0Nt/3SyoqdSfRKB
 sIqDlq+aBbv2VOZ19EWcr7awJDtVk+qQiSALD5Ahf+IT4jMGnXeN2LbhxXTByYTlkMysLCTM2IV
 h6sKmGsvYgzkD1sqNCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_02,2026-01-06_01,2025-10-01_01

Use page_pool for RX buffer allocation in mergeable and small buffer
modes. skb_mark_for_recycle() enables page reuse.

Big packets mode is unchanged because it uses page->private for linked
list chaining of multiple pages per buffer, which conflicts with
page_pool's internal use of page->private.

Page pools are created in ndo_open and destroyed in remove (not
ndo_close). This follows existing driver behavior where RX buffers
remain in the virtqueue across open/close cycles and are only freed
on device removal.

The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
sending control virtqueue commands while ndo_close is tearing down
device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
page_pool_destroy() during close, and concurrent rx_mode_work can
cause virtqueue corruption. The check is after rtnl_lock() to
synchronize with ndo_close(), which sets the flag under the same lock.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-------
 1 file changed, 205 insertions(+), 41 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22d894101c01..c36663525c17 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <net/page_pool/helpers.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -359,6 +360,8 @@ struct receive_queue {
 	/* Page frag for packet buffer allocation. */
 	struct page_frag alloc_frag;
 
+	struct page_pool *page_pool;
+
 	/* RX: fragments + linear part + virtio header */
 	struct scatterlist sg[MAX_SKB_FRAGS + 2];
 
@@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags);
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
+					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void free_unused_bufs(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void virtnet_put_page(struct receive_queue *rq, struct page *page,
+			     bool allow_direct)
+{
+	if (rq->page_pool)
+		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
+	else
+		put_page(page);
+}
+
 static void virtnet_rq_free_buf(struct virtnet_info *vi,
 				struct receive_queue *rq, void *buf)
 {
 	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
+		virtnet_put_page(rq, virt_to_head_page(buf), false);
 	else if (vi->big_packets)
 		give_pages(rq, buf);
 	else
-		put_page(virt_to_head_page(buf));
+		virtnet_put_page(rq, virt_to_head_page(buf), false);
 }
 
 static void enable_delayed_refill(struct virtnet_info *vi)
@@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		if (unlikely(!skb))
 			return NULL;
 
-		page = (struct page *)page->private;
-		if (page)
-			give_pages(rq, page);
+		if (!rq->page_pool) {
+			page = (struct page *)page->private;
+			if (page)
+				give_pages(rq, page);
+		}
 		goto ok;
 	}
 
@@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-		page = (struct page *)page->private;
+		if (!rq->page_pool)
+			page = (struct page *)page->private;
+		else
+			page = NULL;
 		offset = 0;
 	}
 
@@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
-		put_page(page_to_free);
+		virtnet_put_page(rq, page_to_free, true);
 
 	return skb;
 }
@@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	void *buf;
 
 	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
 
-	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
-		virtnet_rq_unmap(rq, buf, *len);
-
-	return buf;
+	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
 }
 
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
@@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
-		virtnet_rq_unmap(rq, buf, 0);
-
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
@@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		truesize = len;
 
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb) {
 			put_page(page);
@@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
-static void put_xdp_frags(struct xdp_buff *xdp)
+static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
 {
 	struct skb_shared_info *shinfo;
 	struct page *xdp_page;
@@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 		shinfo = xdp_get_shared_info_from_buff(xdp);
 		for (i = 0; i < shinfo->nr_frags; i++) {
 			xdp_page = skb_frag_page(&shinfo->frags[i]);
-			put_page(xdp_page);
+			virtnet_put_page(rq, xdp_page, true);
 		}
 	}
 }
@@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		off = buf - page_address(p);
 
 		if (check_mergeable_len(dev, ctx, buflen)) {
-			put_page(p);
+			virtnet_put_page(rq, p, true);
 			goto err_buf;
 		}
 
@@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		 * is sending packet larger than the MTU.
 		 */
 		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
-			put_page(p);
+			virtnet_put_page(rq, p, true);
 			goto err_buf;
 		}
 
 		memcpy(page_address(page) + page_off,
 		       page_address(p) + off, buflen);
 		page_off += buflen;
-		put_page(p);
+		virtnet_put_page(rq, p, true);
 	}
 
 	/* Headroom does not contribute to packet length */
@@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
-	struct page *xdp_page;
+	struct page *xdp_page = NULL;
 	unsigned int buflen;
 	struct xdp_buff xdp;
 	struct sk_buff *skb;
@@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 			goto err_xdp;
 
 		buf = page_address(xdp_page);
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 		page = xdp_page;
 	}
 
@@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
+	if (rq->page_pool && !xdp_page)
+		skb_mark_for_recycle(skb);
+
 	return skb;
 
 err_xdp:
 	u64_stats_inc(&stats->xdp_drops);
 err:
 	u64_stats_inc(&stats->drops);
-	put_page(page);
+	if (xdp_page)
+		put_page(page);
+	else
+		virtnet_put_page(rq, page, true);
 xdp_xmit:
 	return NULL;
 }
@@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	}
 
 	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
-	if (likely(skb))
+	if (likely(skb)) {
+		if (rq->page_pool)
+			skb_mark_for_recycle(skb);
 		return skb;
+	}
 
 err:
 	u64_stats_inc(&stats->drops);
-	put_page(page);
+	virtnet_put_page(rq, page, true);
 	return NULL;
 }
 
@@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		}
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 	}
 }
 
@@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		offset = buf - page_address(page);
 
 		if (check_mergeable_len(dev, ctx, len)) {
-			put_page(page);
+			virtnet_put_page(rq, page, true);
 			goto err;
 		}
 
@@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	return 0;
 
 err:
-	put_xdp_frags(xdp);
+	put_xdp_frags(xdp, rq);
 	return -EINVAL;
 }
 
@@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 
 	*frame_sz = PAGE_SIZE;
 
-	put_page(*page);
+	virtnet_put_page(rq, *page, true);
 
 	*page = xdp_page;
 
@@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
 	unsigned int xdp_frags_truesz = 0;
+	struct page *org_page = page;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
 	struct xdp_buff xdp;
@@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		if (rq->page_pool && page == org_page)
+			skb_mark_for_recycle(head_skb);
 		return head_skb;
 
 	case XDP_TX:
@@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(&xdp, rq);
 
 err_xdp:
-	put_page(page);
+	if (page != org_page)
+		put_page(page);
+	else
+		virtnet_put_page(rq, page, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 	u64_stats_inc(&stats->xdp_drops);
@@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
+					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize)
@@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 
 	offset = buf - page_address(page);
 	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
 				     len, truesize);
 	} else {
@@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	}
 
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
+	if (unlikely(!head_skb))
+		goto err_skb;
+
 	curr_skb = head_skb;
 
-	if (unlikely(!curr_skb))
-		goto err_skb;
+	if (rq->page_pool)
+		skb_mark_for_recycle(head_skb);
 	while (--num_buf) {
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
@@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_skb;
 
 		truesize = mergeable_ctx_to_truesize(ctx);
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
 			goto err_skb;
@@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return head_skb;
 
 err_skb:
-	put_page(page);
+	virtnet_put_page(rq, page, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 err_buf:
@@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 			     gfp_t gfp)
 {
+	unsigned int offset;
+	struct page *page;
 	char *buf;
 	unsigned int xdp_headroom = virtnet_get_headroom(vi);
 	void *ctx = (void *)(unsigned long)xdp_headroom;
@@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (rq->page_pool) {
+		page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
+		if (unlikely(!page))
+			return -ENOMEM;
+
+		buf = page_address(page) + offset;
+		buf += VIRTNET_RX_PAD + xdp_headroom;
+
+		sg_init_table(rq->sg, 1);
+		sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
+
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+		if (err < 0)
+			page_pool_put_page(rq->page_pool,
+					   virt_to_head_page(buf), -1, false);
+		return err;
+	}
+
 	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
 		return -ENOMEM;
 
@@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 	unsigned int len, hole;
+	unsigned int offset;
+	struct page *page;
 	void *ctx;
 	char *buf;
 	int err;
@@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
+	if (rq->page_pool) {
+		page = page_pool_alloc_frag(rq->page_pool, &offset,
+					    len + room, gfp);
+		if (unlikely(!page))
+			return -ENOMEM;
+
+		buf = page_address(page) + offset;
+		buf += headroom; /* advance address leaving hole at front of pkt */
+
+		hole = PAGE_SIZE - (offset + len + room);
+		if (hole < len + room) {
+			/* To avoid internal fragmentation, if there is very likely not
+			 * enough space for another buffer, add the remaining space to
+			 * the current buffer.
+			 * XDP core assumes that frame_size of xdp_buff and the length
+			 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
+			 */
+			if (!headroom)
+				len += hole;
+		}
+
+		ctx = mergeable_len_to_ctx(len + room, headroom);
+
+		sg_init_table(rq->sg, 1);
+		sg_set_buf(&rq->sg[0], buf, len);
+
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+		if (err < 0)
+			page_pool_put_page(rq->page_pool,
+					   virt_to_head_page(buf), -1, false);
+		return err;
+	}
+
 	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
 		return -ENOMEM;
 
@@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 		return err;
 
 	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
-					 MEM_TYPE_PAGE_SHARED, NULL);
+					 vi->rq[qp_index].page_pool ?
+						MEM_TYPE_PAGE_POOL :
+						MEM_TYPE_PAGE_SHARED,
+					 vi->rq[qp_index].page_pool);
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
@@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 		vi->duplex = duplex;
 }
 
+static int virtnet_create_page_pools(struct virtnet_info *vi)
+{
+	int i, err;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+		struct page_pool_params pp_params = { 0 };
+
+		if (rq->page_pool)
+			continue;
+
+		if (rq->xsk_pool)
+			continue;
+
+		if (!vi->mergeable_rx_bufs && vi->big_packets)
+			continue;
+
+		pp_params.order = 0;
+		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
+		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
+		pp_params.dev = vi->vdev->dev.parent;
+		pp_params.netdev = vi->dev;
+		pp_params.napi = &rq->napi;
+		pp_params.flags = 0;
+
+		rq->page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->page_pool)) {
+			err = PTR_ERR(rq->page_pool);
+			rq->page_pool = NULL;
+			goto err_cleanup;
+		}
+	}
+	return 0;
+
+err_cleanup:
+	while (--i >= 0) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		if (rq->page_pool) {
+			page_pool_destroy(rq->page_pool);
+			rq->page_pool = NULL;
+		}
+	}
+	return err;
+}
+
+static void virtnet_destroy_page_pools(struct virtnet_info *vi)
+{
+	int i;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		if (rq->page_pool) {
+			page_pool_destroy(rq->page_pool);
+			rq->page_pool = NULL;
+		}
+	}
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
+	err = virtnet_create_page_pools(vi);
+	if (err)
+		return err;
+
+	vi->rx_mode_work_enabled = true;
+
 	enable_delayed_refill(vi);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -3251,6 +3405,7 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
+	vi->rx_mode_work_enabled = false;
 	disable_delayed_refill(vi);
 	cancel_delayed_work_sync(&vi->refill);
 
@@ -3856,6 +4011,8 @@ static int virtnet_close(struct net_device *dev)
 	 */
 	cancel_work_sync(&vi->config_work);
 
+	vi->rx_mode_work_enabled = false;
+
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3892,6 +4049,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (!vi->rx_mode_work_enabled) {
+		rtnl_unlock();
+		return;
+	}
+
 	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
@@ -7193,6 +7355,8 @@ static void remove_vq_common(struct virtnet_info *vi)
 
 	free_receive_page_frags(vi);
 
+	virtnet_destroy_page_pools(vi);
+
 	virtnet_del_vqs(vi);
 }
 
-- 
2.47.3


