Return-Path: <netdev+bounces-124191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5A96873C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6D31C23432
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B321C188;
	Mon,  2 Sep 2024 12:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218D2139DC;
	Mon,  2 Sep 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278965; cv=none; b=MJ3MBV9NhJKui1id2r5Im0rIVQ3UC7UlOtmp164sC8cZuTynhofs87NLtMV/+8M7zBtct2blz9DWdXeMiE4PSpW+otjkOe68SqTZJnc5NGi54nQMRij575IGuGOhL7LrTCKsyVPNOpDhuvKczN0kTxZ4kAD/1ddz+/mxg0NRV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278965; c=relaxed/simple;
	bh=kQfD/jZBGpPXapWUu9MKRZmjW0FDIN7FETm6sxPdfvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5BgWBPKcWhrGKavpKy5egfbGs+54kPp0h3yJkZFVNYmix74tZmnOHUu77L8qCT938Z+QUz1ewQa5Zaby28DDK/EdGtgt6PpbovEL24CTFVnGXBYaHnXsG8JxqQExYXjnZ0Mwd9SrZDSP92EYVWiKFJlkrNmYkCqanIyKUDOBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy6xD4SMcz1j7y5;
	Mon,  2 Sep 2024 20:09:04 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 495FE1A016C;
	Mon,  2 Sep 2024 20:09:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:22 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v17 09/14] net: rename skb_copy_to_page_nocache() helper
Date: Mon, 2 Sep 2024 20:03:08 +0800
Message-ID: <20240902120314.508180-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240902120314.508180-1-linyunsheng@huawei.com>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
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
 include/net/sock.h | 10 ++++------
 net/ipv4/tcp.c     |  7 +++----
 net/kcm/kcmsock.c  |  7 +++----
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f51d61fab059..5adcc77de422 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2183,15 +2183,13 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
 	return err;
 }
 
-static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
-					   struct sk_buff *skb,
-					   struct page *page,
-					   int off, int copy)
+static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					 struct sk_buff *skb, char *va,
+					 int copy)
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


