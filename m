Return-Path: <netdev+bounces-198871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB587ADE16D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 05:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32C41899702
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2106C1946A0;
	Wed, 18 Jun 2025 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k+2Jkpvm"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441313E02D;
	Wed, 18 Jun 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215973; cv=none; b=Mx78RvX1LguoORUwTBI5l3Ro/wIAQVl/miPpJBJN8tu79rRI2ofxDPU0PGc1h8xxTuc9DBChiQRrmKcFbqqJnYCmYZ+OGvFLwbzGnAlYULozJt8tKMdpAzSYQqf5k27+Mxl13+ATysiGYOWWNQUEq/lscVpInERFZyuDKKnjBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215973; c=relaxed/simple;
	bh=QL/4KRWb+Eb99LdlmW0FWVyAOQcTQchrPVSpQl3cLHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aj8Swl4cGLJCpVAq+GJXwZymPLsL+6dkgB9Rs//0rFOz8R4r02VME94f3j3bfk0C0550BnjjQ/3rxYM3qVczIafAUzG381ZDGPcVIafT7nejlh7rQgQ/vTzl05xLGTCp9mxhjVwtag18khnrwLa5bL1BQdOL3isn+0rjv9Zd/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k+2Jkpvm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9s
	xZpWGMDtvzQWDkps87/gtbTx/0wlDsgpbiAR5Zn1Q=; b=k+2Jkpvmbm7FNi4kyG
	rBZMceiZa1E7R1X9z2uyNcf7zjbnZtNn+r4R5CO7/Xo59EGmvKEMFVG0cLkY0pBj
	93pvRlA5mXknfLqOJcsbtR/BYvvJD2fFQNTcMKVgO6cnb7V9pOQBx802/CJRXwfr
	lBzpf4qK6dWQs+U4xXh/yiR38=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDX_84DLVJo98pqAA--.16005S2;
	Wed, 18 Jun 2025 11:05:39 +0800 (CST)
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
Subject: [RFC PATCH net-next] skbuff: Improve the sending efficiency of __skb_send_sock
Date: Wed, 18 Jun 2025 11:05:37 +0800
Message-Id: <20250618030537.28394-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDX_84DLVJo98pqAA--.16005S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry8Cw4fZFWrAFW8XF4xJFb_yoWrtr4kpa
	15W398Zr47Jr1q9r4kJrZ3Cr4ft3yvk3y5tF4fA395Ar90qryFgFWUGr1jkFWrKrZ7uFyU
	trs0vr1rGrn0va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbzV8UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiThlweGhSKSe2kwAAsO

From: Feng Yang <yangfeng@kylinos.cn>

By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
For small packets, the performance remains comparable to the original level.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 net/core/skbuff.c | 110 ++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 58 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..19d78285a1c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3235,82 +3235,75 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 			   int len, sendmsg_func sendmsg, int flags)
 {
-	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
 	unsigned short fragidx;
-	int slen, ret;
+	struct msghdr msg;
+	struct bio_vec *bvec;
+	int max_vecs, ret;
+	int bvec_count = 0;
+	unsigned int copied = 0;
+
+	max_vecs = skb_shinfo(skb)->nr_frags + 1; // +1 for linear data
+	if (skb_has_frag_list(skb)) {
+		struct sk_buff *frag_skb = skb_shinfo(skb)->frag_list;
+
+		while (frag_skb) {
+			max_vecs += skb_shinfo(frag_skb)->nr_frags + 1; // +1 for linear data
+			frag_skb = frag_skb->next;
+		}
+	}
+
+	bvec = kcalloc(max_vecs, sizeof(struct bio_vec), GFP_KERNEL);
+	if (!bvec)
+		return -ENOMEM;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | flags;
 
 do_frag_list:
 
 	/* Deal with head data */
-	while (offset < skb_headlen(skb) && len) {
-		struct kvec kv;
-		struct msghdr msg;
-
-		slen = min_t(int, len, skb_headlen(skb) - offset);
-		kv.iov_base = skb->data + offset;
-		kv.iov_len = slen;
-		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT | flags;
+	if (offset < skb_headlen(skb)) {
+		unsigned int copy_len = min(skb_headlen(skb) - offset, len - copied);
+		struct page *page = virt_to_page(skb->data + offset);
+		unsigned int page_offset = offset_in_page(skb->data + offset);
 
-		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
-		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
-				      sendmsg_unlocked, sk, &msg);
-		if (ret <= 0)
-			goto error;
+		if (!sendpage_ok(page))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
-		offset += ret;
-		len -= ret;
+		bvec_set_page(&bvec[bvec_count++], page, copy_len, page_offset);
+		copied += copy_len;
+		offset += copy_len;
 	}
 
-	/* All the data was skb head? */
-	if (!len)
-		goto out;
-
 	/* Make offset relative to start of frags */
 	offset -= skb_headlen(skb);
 
-	/* Find where we are in frag list */
-	for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+	if (copied < len) {
+		for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
+			skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+			unsigned int frag_size = skb_frag_size(frag);
 
-		if (offset < skb_frag_size(frag))
-			break;
-
-		offset -= skb_frag_size(frag);
-	}
-
-	for (; len && fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
-
-		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
+			/* Find where we are in frag list */
+			if (offset >= frag_size) {
+				offset -= frag_size;
+				continue;
+			}
 
-		while (slen) {
-			struct bio_vec bvec;
-			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
-					     flags,
-			};
+			unsigned int copy_len = min(frag_size - offset, len - copied);
 
-			bvec_set_page(&bvec, skb_frag_page(frag), slen,
+			bvec_set_page(&bvec[bvec_count++], skb_frag_page(frag), copy_len,
 				      skb_frag_off(frag) + offset);
-			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
-				      slen);
 
-			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
-					      sendmsg_unlocked, sk, &msg);
-			if (ret <= 0)
-				goto error;
+			copied += copy_len;
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
 
 		if (skb == head) {
@@ -3324,11 +3317,12 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
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


