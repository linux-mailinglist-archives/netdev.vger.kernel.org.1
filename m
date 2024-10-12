Return-Path: <netdev+bounces-134827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C799B453
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591141C22F1B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336320409C;
	Sat, 12 Oct 2024 11:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F92038DF;
	Sat, 12 Oct 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732597; cv=none; b=nqrddBhMWZ/DarwKQSSkdUXLj80nxRNQX6OvdM0TmsF64Y2MIRwFXclJvz1mWEVJqndCj8wJ6UCEGhApz4ZmOsnmIMEw/LwT+FIJ3vxJ5wfG1ugXLaleQveS/pqOU4MmVar+OnU6S0Zk3ly2Wexxn6dW4VTt7zp/I2VE+j7qhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732597; c=relaxed/simple;
	bh=FhJctuhqAL+G2HMI2VT/Wj3eV1K7uIYjkz+D9MWLBwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn62wSJRK53c9eEr8udw7oiU1+mdFIZIxxv4KlCB9GVIVZu/uSYDarbx7EHUOojVsQ2nHmjI9NctEzXLnWsbBxNHPbNweZYsvK9EAScQ8XkVbQcosNRRYGnjurJyrp/Z43q5rDF2kMF7Eru4IxlGFJfiUx/yo7XMXD80SSfylkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XQh8l3NjpzQrcV;
	Sat, 12 Oct 2024 19:29:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 853981402CB;
	Sat, 12 Oct 2024 19:29:51 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 19:29:51 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v21 09/14] net: rename skb_copy_to_page_nocache() helper
Date: Sat, 12 Oct 2024 19:23:15 +0800
Message-ID: <20241012112320.2503906-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241012112320.2503906-1-linyunsheng@huawei.com>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Rename skb_copy_to_page_nocache() to skb_copy_to_frag_nocache()
to avoid calling virt_to_page() as we are about to pass virtual
address directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 9 ++++-----
 net/ipv4/tcp.c     | 7 +++----
 net/kcm/kcmsock.c  | 7 +++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6da420ab1ee1..3d9c8949a02f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2194,15 +2194,14 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
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
index d4118c796290..051fbddbf0a6 100644
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


