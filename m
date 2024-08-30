Return-Path: <netdev+bounces-123662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B49660A0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F028289267
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DA11AF4F7;
	Fri, 30 Aug 2024 11:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389901AF4DE;
	Fri, 30 Aug 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017097; cv=none; b=ZXS2dz/Ltv9vOVyoz2SYhqdV3QY2UNwu0bFx4eGq//9kO25IXIe8VPkXOmxWn6ketu3sYpfz9ewVtyzRagmIPXCh2gfsoCBHD4HcYRRSz6RmC2bTbklhRJQg07XcPISJu+zCLDwh3IPmlJQK4KYVpV8TyY2SDWhppYM7d04NWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017097; c=relaxed/simple;
	bh=YdI5WJxIqmlyN94FXbB+a4XSMiJoFNn59KBUnnrzQ+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ1cXca9bquP9oj2VlsDTbR/48KIUAD0Y0qll/gQswX4wQBXRGyb0NEDEDiscZo0nhylIwU/d7pPoOUVgfz9V8F78+DjsQS7GJciF3sMS9KhI+8QkFyVuqtMxzZwhHAIgtjUdIrLIM9pz69L9UHxWb2Ss7IwYu2hwrr6qFDdmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwG3M2NqFz1xwVF;
	Fri, 30 Aug 2024 19:22:55 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DD9E01400D7;
	Fri, 30 Aug 2024 19:24:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 19:24:53 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v16 09/14] net: rename skb_copy_to_page_nocache() helper
Date: Fri, 30 Aug 2024 19:18:39 +0800
Message-ID: <20240830111845.1593542-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830111845.1593542-1-linyunsheng@huawei.com>
References: <20240830111845.1593542-1-linyunsheng@huawei.com>
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
index f51d61fab059..5069813895c6 100644
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
index 8a5680b4e786..8bf8ce656b0a 100644
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
index d4118c796290..f4462cf88ed5 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -856,10 +856,9 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
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


