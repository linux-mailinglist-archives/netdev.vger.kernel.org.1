Return-Path: <netdev+bounces-200169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE392AE38C0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E83B16ADA5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F122E406;
	Mon, 23 Jun 2025 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZxIFzSp4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54622DA13;
	Mon, 23 Jun 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668191; cv=none; b=C3Gpr9sWfMCgZBinb1Atjm13ogTrntR8w+cVYdF9B1GdSX3WPC+xtAyk87YJbq2BtVK1Wwslt3BzFSvBuy7p9DPGuCdDM3rTEs3/lSDx6ZWY1B/P1+SW7QZwM6kin26jTgcxiUYE2suD7n2exUaAVH7kiWvYLMPgcFdBv8AW1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668191; c=relaxed/simple;
	bh=oQRMDCdcMegdU5hYLSnZk8x5ET4aYnFd5PUa0/K3HHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPCYY+Njqqzg7eR7ZbkqUi3TtwkpfQCxcBKDXzIyHrR3CU3BtgJaAp7HZkUBBVPTwNpZSu734YE7DBMKB79Yadk03sWuGL0b5M/RYBaaXIypSnnQ59u2Oq0Uvd46c4uBxW9yIy/5SpwDxPLI4Tdo62UPYs9sne2L6B8Uw3P1d+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZxIFzSp4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pc
	LyQgfpkZOe/VVi2jLGn/MqWXCgSsOjKU9DH2PDAyo=; b=ZxIFzSp4Ok80YaGoS3
	xR1N/DBZcjLBMOY2Nhj80+jC5fpp+E8iae1VNEIJRP5UdldTsOBsrurYEOpg/rjN
	Au4/m7w6STJ/WCEhDj4Rrm+oyWBzbWl/EaZOLaA+kFwfWQJRcTRtCfBlarqkJtCH
	UUnG0UE8cqB4cU0cQLK+qJWdY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3G+dkE1lok0AzBQ--.57844S2;
	Mon, 23 Jun 2025 16:42:13 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	almasrymina@google.com,
	kerneljasonxing@gmail.com,
	ebiggers@google.com,
	asml.silence@gmail.com,
	aleksander.lobakin@intel.com
Cc: yangfeng@kylinos.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] skbuff: Improve the sending efficiency of __skb_send_sock
Date: Mon, 23 Jun 2025 16:42:12 +0800
Message-Id: <20250623084212.122284-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3G+dkE1lok0AzBQ--.57844S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry8Cw4kGrWrtF45Zw1kKrg_yoW7Gr48pa
	y5W398Zr47Jr1q9r4kJrZ7ur4ftayvkay5tFyfA39Yyr98tryFgF1UJr1jkFW5KrWkuryU
	Krs0vr1rKrs0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUpnQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVhl1eGhZEJ5dpAAAsE

From: Feng Yang <yangfeng@kylinos.cn>

By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
For small packets, the performance remains comparable to the original level.

When using sockmap for forwarding, the average latency for different packet sizes
after sending 10,000 packets is as follows:
size	old(us)		new(us)
512	56		55
1472	58		58
1600	106		79
3000	145		108
5000	182		123

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 net/core/skbuff.c | 112 +++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..664443fc9baf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3235,84 +3235,75 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 			   int len, sendmsg_func sendmsg, int flags)
 {
-	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
 	unsigned short fragidx;
-	int slen, ret;
+	struct msghdr msg;
+	struct bio_vec *bvec;
+	int max_vecs, ret, slen;
+	int bvec_count = 0;
+	unsigned int copied = 0;
 
-do_frag_list:
-
-	/* Deal with head data */
-	while (offset < skb_headlen(skb) && len) {
-		struct kvec kv;
-		struct msghdr msg;
-
-		slen = min_t(int, len, skb_headlen(skb) - offset);
-		kv.iov_base = skb->data + offset;
-		kv.iov_len = slen;
-		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT | flags;
-
-		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
-		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
-				      sendmsg_unlocked, sk, &msg);
-		if (ret <= 0)
-			goto error;
+	max_vecs = skb_shinfo(skb)->nr_frags + 1; // +1 for linear data
+	if (skb_has_frag_list(skb)) {
+		struct sk_buff *frag_skb = skb_shinfo(skb)->frag_list;
 
-		offset += ret;
-		len -= ret;
+		while (frag_skb) {
+			max_vecs += skb_shinfo(frag_skb)->nr_frags + 1; // +1 for linear data
+			frag_skb = frag_skb->next;
+		}
 	}
 
-	/* All the data was skb head? */
-	if (!len)
-		goto out;
+	bvec = kcalloc(max_vecs, sizeof(struct bio_vec), GFP_KERNEL);
+	if (!bvec)
+		return -ENOMEM;
 
-	/* Make offset relative to start of frags */
-	offset -= skb_headlen(skb);
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | flags;
+
+do_frag_list:
 
-	/* Find where we are in frag list */
-	for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+	/* Deal with head data */
+	if (offset < skb_headlen(skb)) {
+		slen = min_t(int, skb_headlen(skb) - offset, len - copied);
+		struct page *page = virt_to_page(skb->data + offset);
+		unsigned int page_offset = offset_in_page(skb->data + offset);
 
-		if (offset < skb_frag_size(frag))
-			break;
+		if (!sendpage_ok(page))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
-		offset -= skb_frag_size(frag);
+		bvec_set_page(&bvec[bvec_count++], page, slen, page_offset);
+		copied += slen;
+		offset += slen;
 	}
 
-	for (; len && fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+	/* Make offset relative to start of frags */
+	offset -= skb_headlen(skb);
 
-		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
+	if (copied < len) {
+		for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
+			skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+			unsigned int frag_size = skb_frag_size(frag);
 
-		while (slen) {
-			struct bio_vec bvec;
-			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
-					     flags,
-			};
+			/* Find where we are in frag list */
+			if (offset >= frag_size) {
+				offset -= frag_size;
+				continue;
+			}
 
-			bvec_set_page(&bvec, skb_frag_page(frag), slen,
+			slen = min_t(size_t, frag_size - offset, len - copied);
+			bvec_set_page(&bvec[bvec_count++], skb_frag_page(frag), slen,
 				      skb_frag_off(frag) + offset);
-			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
-				      slen);
 
-			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
-					      sendmsg_unlocked, sk, &msg);
-			if (ret <= 0)
-				goto error;
+			copied += slen;
+			offset = 0;
 
-			len -= ret;
-			offset += ret;
-			slen -= ret;
+			if (copied >= len)
+				break;
 		}
-
-		offset = 0;
 	}
 
-	if (len) {
+	if (copied < len) {
 		/* Process any frag lists */
-
 		if (skb == head) {
 			if (skb_has_frag_list(skb)) {
 				skb = skb_shinfo(skb)->frag_list;
@@ -3324,11 +3315,12 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		}
 	}
 
-out:
-	return orig_len - len;
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bvec_count, len);
+	ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked, sendmsg_unlocked, sk, &msg);
+
+	kfree(bvec);
 
-error:
-	return orig_len == len ? ret : orig_len - len;
+	return ret;
 }
 
 /* Send skb data on a socket. Socket must be locked. */
-- 
2.43.0


