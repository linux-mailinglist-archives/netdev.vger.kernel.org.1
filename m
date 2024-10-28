Return-Path: <netdev+bounces-139539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD479B2FAD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7128B23FF5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E01DB53A;
	Mon, 28 Oct 2024 12:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B11DA63F;
	Mon, 28 Oct 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117123; cv=none; b=LVHnPJ6VlqXu8qirS8/p9ngm0yKJW9NzGTu5t83Z3GR81Ym+E9Ae+mDbIOhgMP28SQOPOXyKRwQAPy3rxleumbsAQyqK3jbcydWDD9No8BKi3QxgC4K22+Ie0+yXmVxbHQNs9uJsWhNlQZWu1ApFB2issbLuF1YXf25P+ZUrM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117123; c=relaxed/simple;
	bh=n2aWV5GpPmQNzVvqbT1pVoei2SB7NfQNpzNfvRUG2PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hg/z6KUICZGoPqH/hCQjlKk3NOGaAv4PWt7uNtu2FSp8ON8vXKz4ay4uLTbQuglaVG3SU+euHTNO46A/chn5uDHRy4Uja66W417JGroT0ruklms6Eil3lnm5Ts6J0TyFpQX6jQLmNnThQvU+2i0PI3ksCENzkV3mhdiHXEX0QzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XcX992ZR6z1SDPT;
	Mon, 28 Oct 2024 20:03:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FDBD14010C;
	Mon, 28 Oct 2024 20:05:11 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 20:05:11 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>
Subject: [PATCH RFC 02/10] net: rename skb_copy_to_page_nocache() helper
Date: Mon, 28 Oct 2024 19:58:42 +0800
Message-ID: <20241028115850.3409893-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241028115850.3409893-1-linyunsheng@huawei.com>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Rename skb_copy_to_page_nocache() to skb_copy_to_frag_nocache()
to avoid calling virt_to_page() as we are about to pass virtual
address directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 9 ++++-----
 net/ipv4/tcp.c     | 7 +++----
 net/kcm/kcmsock.c  | 7 +++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..cf037c870e3b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2203,15 +2203,14 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
 	return err;
 }
 
-static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
+static inline int skb_copy_to_frag_nocache(struct sock *sk,
+					   struct iov_iter *from,
 					   struct sk_buff *skb,
-					   struct page *page,
-					   int off, int copy)
+					   char *va, int copy)
 {
 	int err;
 
-	err = skb_do_copy_data_nocache(sk, skb, from, page_address(page) + off,
-				       copy, skb->len);
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
 	if (err)
 		return err;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..d5d2fca8a688 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1219,10 +1219,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_frag_nocache(sk, &msg->msg_iter, skb,
+						       page_address(pfrag->page) +
+						       pfrag->offset, copy);
 			if (err)
 				goto do_error;
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 24aec295a51c..94719d4af5fa 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -856,10 +856,9 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_frag_nocache(sk, &msg->msg_iter, skb,
+						       page_address(pfrag->page) +
+						       pfrag->offset, copy);
 			if (err)
 				goto out_error;
 
-- 
2.33.0


