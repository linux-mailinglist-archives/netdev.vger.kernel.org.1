Return-Path: <netdev+bounces-112201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAC49375DE
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970012845A6
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F41465BE;
	Fri, 19 Jul 2024 09:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CB145B03;
	Fri, 19 Jul 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381841; cv=none; b=LKEqhiVtMNjFKmADz23mQ8eAxb7A4UeIHTcNwfUHUoAFNeD+EdK61zltOZnW/Udw4c1j+GJcM10B3MhPVYuqNp6PyK5h+KB8gTNgjB+cmKsxSG8WmNkAqAx3hoSx/VI1xbc7D93OzSCMCtberKvNIUsLcaKC6WJk85Pu0pkRpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381841; c=relaxed/simple;
	bh=f8mfWy+k6784z9chRfizQGDDtsVtxgPgTaHmBX9tNZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1xSuC+eFLgvfKgApPajOfaLvMIDI6cG36hdTJNxdNEzQyrEXjTs9wYdEk8mNLrnZLHfGOgFkKo1o/2q/noBkpuycYLr2p7G6xnnkBRwOC+WKBbqArEeVjYaaq8D3ra/BN0cDFRXcxfSNcehYCHbcDK/XKMnaGtIN+upr4Y+97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQPh53gkLzVlP2;
	Fri, 19 Jul 2024 17:36:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E6EF140109;
	Fri, 19 Jul 2024 17:37:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Jul 2024 17:37:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Subject: [RFC v11 10/14] net: rename skb_copy_to_page_nocache() helper
Date: Fri, 19 Jul 2024 17:33:34 +0800
Message-ID: <20240719093338.55117-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240719093338.55117-1-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Rename skb_copy_to_page_nocache() to skb_copy_to_va_nocache()
to avoid calling virt_to_page() as we are about to pass virtual
address directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 9 +++------
 net/ipv4/tcp.c     | 7 +++----
 net/kcm/kcmsock.c  | 7 +++----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..b5e702298ab7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2183,15 +2183,12 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
 	return err;
 }
 
-static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
-					   struct sk_buff *skb,
-					   struct page *page,
-					   int off, int copy)
+static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					 struct sk_buff *skb, char *va, int copy)
 {
 	int err;
 
-	err = skb_do_copy_data_nocache(sk, skb, from, page_address(page) + off,
-				       copy, skb->len);
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
 	if (err)
 		return err;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..7c392710ae15 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1215,10 +1215,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     page_address(pfrag->page) +
+						     pfrag->offset, copy);
 			if (err)
 				goto do_error;
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..eec6c56b7f3e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -855,10 +855,9 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     page_address(pfrag->page) +
+						     pfrag->offset, copy);
 			if (err)
 				goto out_error;
 
-- 
2.33.0


