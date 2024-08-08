Return-Path: <netdev+bounces-116849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684894BDE5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CAA1C23917
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008719004F;
	Thu,  8 Aug 2024 12:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381F18CC01;
	Thu,  8 Aug 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121002; cv=none; b=VG8TRJXHfnWA5KGh3uCeI1+DTWLhmLkahbGwFE/CP2WpNgQpOCNNutv83pkMfJjRWZhNlDiWunZ8X7S/7fj7HKiTiRdjigHi3hs3yLXcEJPHSbXVlOjWpmKUe+Anoq4h4Xt5Gc8uJ4o3ztJRXGgK4tUgEduE0DFcbyUL02NnITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121002; c=relaxed/simple;
	bh=f8mfWy+k6784z9chRfizQGDDtsVtxgPgTaHmBX9tNZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMXJMWdGlqygaeMa0u8bOHHasS3YZPJ2vvVoUZAQKem0ZKgFbr9p3B7mmpgZTxmaAc6PFbdZHkIjVI86UsOBrRKkh6rCGvJNpLpZM5jimrkEJU95Ifm6emGvnRck04zw2KQhxBVDdso4Y35D4hqtF/z1CX4TlIatrfZEPLUbX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfmrv0CvmzpT5p;
	Thu,  8 Aug 2024 20:42:07 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C09BA1800FF;
	Thu,  8 Aug 2024 20:43:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v13 10/14] net: rename skb_copy_to_page_nocache() helper
Date: Thu, 8 Aug 2024 20:37:10 +0800
Message-ID: <20240808123714.462740-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
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


