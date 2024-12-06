Return-Path: <netdev+bounces-149702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D559E6E42
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0331883731
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA0204F91;
	Fri,  6 Dec 2024 12:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218A205AA4;
	Fri,  6 Dec 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488349; cv=none; b=Lrs8Ze4tSZ05hh4VKQY+XFTnq6n9dvshOVuf7SdNff8wg8ZM5gci9o43LD3lINqgb92S8Ai+dOw9/Yak6UBOrZzclq7rxY9XDjgN8RKUlfeONrseWv9xQM2HN3K8ij6UDlks0un1ybhGlMbhbfFQsWELBGmm+Y8tD2kufCSYy04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488349; c=relaxed/simple;
	bh=xejgqni1EIbh5amZT9zq8y15En+rGnH1JwJI8AwQOiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsxJ5gydzCNbX9np3PhHBEj5OZggFJJvA+aWHAkExlTZqEKQmRmf7+Q4vYBXDt/FoqUDX1gqLDZoscqwqjGeXsPjvJf+xUbnowWmfavHKRrRdGxlSYVeB/tOkAF+J0erit4Bbn9HC2r4QdJ4AMnWdLibZ5LKGYtk20OJZRZe6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4Vvd0Qjyz1kvJB;
	Fri,  6 Dec 2024 20:30:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 60CC41A0188;
	Fri,  6 Dec 2024 20:32:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 20:32:24 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Alexander
 Duyck <alexanderduyck@fb.com>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v2 02/10] net: rename skb_copy_to_page_nocache() helper
Date: Fri, 6 Dec 2024 20:25:25 +0800
Message-ID: <20241206122533.3589947-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241206122533.3589947-1-linyunsheng@huawei.com>
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
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
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
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
index 0d704bda6c41..0fbf1e222cda 100644
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


