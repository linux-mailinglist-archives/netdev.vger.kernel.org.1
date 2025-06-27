Return-Path: <netdev+bounces-201854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6EAEB336
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF621C212B9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578B295D87;
	Fri, 27 Jun 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B4vJJFHh"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9329824B;
	Fri, 27 Jun 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017492; cv=none; b=Tqn8kftfBIHtrAz2vYYRhPCD7vxWeRNdTrGwtjquHbDwbWEBVkYLXomQkHG5T7nMnZYLIY02T61qBYSal2D2jrOb8Ao5uu0uoq7EARFfFza6ktysYFjg4RcMdXt3CfgdAuQSl+OUC98RaU+E2JdJgzu/If+eFLjNc+uhKXx1gBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017492; c=relaxed/simple;
	bh=uFNN6WF+H4Pq7J6XkgwEd0a4t0kU5I+jQ1ADTybJaFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B31FFbRC31Uq8aVPvtTDGusxiJs1HoZ8ZUlKs85fvWcisfAhvAfLdrfUa5kcFLDkcr5zf8CG7hWDV4+lo+gwbGQSBhVvYBpEHFW5b3GNlbJVS/6ijPt9IhcyCDZQZ6HT1odFhC8/WioWTErU+k04J1pNK3BVdnSajbIabPRzNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B4vJJFHh; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=a4
	vzSTntLhgG4uuZm3+r1/iBQ1fisyq3I7ghN5hcb6M=; b=B4vJJFHhdygvHP8MCz
	sJxyb4SvkDTF7PVn+HSAfx03b8M5LqOItVkKbu05Hijr10rwWfodrmbuHCwAn8Hq
	kWEFKK91F+91I2fAhK33G+GUHcIng1BmIifVC8U7l3+s14wDTJwiEbhW6BWi/CN8
	LKsMzd3YWzA4QCGu9kt+Al8W8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnbwXmZ15oG_bRAw--.14450S2;
	Fri, 27 Jun 2025 17:44:07 +0800 (CST)
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
	aleksander.lobakin@intel.com,
	stfomichev@gmail.com
Cc: yangfeng@kylinos.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] skbuff: Improve the sending efficiency of __skb_send_sock
Date: Fri, 27 Jun 2025 17:44:06 +0800
Message-Id: <20250627094406.100919-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbwXmZ15oG_bRAw--.14450S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4xAF1fWry5JFWxZw1DKFg_yoW7ZFW7pa
	13W398Zr4UJr1qqr4kJrZxCr4fta9akayrtF13A395tr90yrWFgF18tr1jkFW5trWkuFy7
	GrsIvr1rCrs0va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUVysUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQp5eGheYdG5CAAAsZ

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
Changes in v2:
- Delete dynamic memory allocation, thanks: Paolo Abeni,Stanislav Fomichev.
- Link to v1: https://lore.kernel.org/all/20250623084212.122284-1-yangfeng59949@163.com/
---
 net/core/skbuff.c | 145 ++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 77 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..aae5139cfb28 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3231,104 +3231,95 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 	return sock_sendmsg(sock, msg);
 }
 
+#define MAX_SKB_SEND_BIOVEC_SIZE	16
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 			   int len, sendmsg_func sendmsg, int flags)
 {
-	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
 	unsigned short fragidx;
-	int slen, ret;
-
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
-
-		offset += ret;
-		len -= ret;
-	}
-
-	/* All the data was skb head? */
-	if (!len)
-		goto out;
+	struct msghdr msg;
+	struct bio_vec bvec[MAX_SKB_SEND_BIOVEC_SIZE];
+	int ret, slen, total_len = 0;
+	int bvec_count = 0;
+	unsigned int copied = 0;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | flags;
+
+	while (copied < len) {
+		/* Deal with head data */
+		if (offset < skb_headlen(skb) && bvec_count < MAX_SKB_SEND_BIOVEC_SIZE) {
+			struct page *page = virt_to_page(skb->data + offset);
+			unsigned int page_offset = offset_in_page(skb->data + offset);
+
+			if (!sendpage_ok(page))
+				msg.msg_flags &= ~MSG_SPLICE_PAGES;
+
+			slen = min_t(int, skb_headlen(skb) - offset, len - copied);
+			bvec_set_page(&bvec[bvec_count++], page, slen, page_offset);
+			copied += slen;
+			offset += slen;
+		}
 
-	/* Make offset relative to start of frags */
-	offset -= skb_headlen(skb);
+		/* Make offset relative to start of frags */
+		offset -= skb_headlen(skb);
 
-	/* Find where we are in frag list */
-	for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+		if (copied < len && bvec_count < MAX_SKB_SEND_BIOVEC_SIZE) {
+			for (fragidx = 0; fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
+				skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+				unsigned int frag_size = skb_frag_size(frag);
 
-		if (offset < skb_frag_size(frag))
-			break;
+				/* Find where we are in frag list */
+				if (offset >= frag_size) {
+					offset -= frag_size;
+					continue;
+				}
 
-		offset -= skb_frag_size(frag);
-	}
+				slen = min_t(size_t, frag_size - offset, len - copied);
+				bvec_set_page(&bvec[bvec_count++], skb_frag_page(frag), slen,
+					      skb_frag_off(frag) + offset);
 
-	for (; len && fragidx < skb_shinfo(skb)->nr_frags; fragidx++) {
-		skb_frag_t *frag  = &skb_shinfo(skb)->frags[fragidx];
+				copied += slen;
+				offset = 0;
 
-		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
+				if (copied >= len || bvec_count >= MAX_SKB_SEND_BIOVEC_SIZE)
+					break;
+			}
+		}
 
-		while (slen) {
-			struct bio_vec bvec;
-			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
-					     flags,
-			};
+		if (copied < len && bvec_count < MAX_SKB_SEND_BIOVEC_SIZE) {
+			/* Process any frag lists */
+			if (skb == head) {
+				if (skb_has_frag_list(skb))
+					skb = skb_shinfo(skb)->frag_list;
+			} else if (skb->next) {
+				skb = skb->next;
+			}
+		}
 
-			bvec_set_page(&bvec, skb_frag_page(frag), slen,
-				      skb_frag_off(frag) + offset);
-			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
-				      slen);
+		if (bvec_count == MAX_SKB_SEND_BIOVEC_SIZE || copied == len) {
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bvec_count, len);
+			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked, sendmsg_unlocked, sk, &msg);
 
-			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
-					      sendmsg_unlocked, sk, &msg);
-			if (ret <= 0)
-				goto error;
+			if (ret < 0)
+				return ret;
 
+			/* Statistical data */
 			len -= ret;
 			offset += ret;
-			slen -= ret;
+			total_len += ret;
+
+			/* Restore initial value */
+			memset(&msg, 0, sizeof(msg));
+			msg.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | flags;
+			copied = 0;
+			bvec_count = 0;
+			skb = head;
 		}
-
-		offset = 0;
 	}
 
-	if (len) {
-		/* Process any frag lists */
-
-		if (skb == head) {
-			if (skb_has_frag_list(skb)) {
-				skb = skb_shinfo(skb)->frag_list;
-				goto do_frag_list;
-			}
-		} else if (skb->next) {
-			skb = skb->next;
-			goto do_frag_list;
-		}
-	}
-
-out:
-	return orig_len - len;
-
-error:
-	return orig_len == len ? ret : orig_len - len;
+	return total_len;
 }
 
 /* Send skb data on a socket. Socket must be locked. */
-- 
2.43.0


