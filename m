Return-Path: <netdev+bounces-106496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7839169A5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A796B24AFA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC2174EC6;
	Tue, 25 Jun 2024 13:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96775171E7D;
	Tue, 25 Jun 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323746; cv=none; b=Su4Br1qnaJnrZ0nHx+qVLlISCrgfwe61sKIbrf6VbtR3XPQjtS9ZGCQrU1oqjgI93WP4msfDBn9pnWH/z+MY7IHptuSV8+LuH5AWIzG/aJFz1XTQwLKPkqxIZZf8TfT9KmumL5FU2zvCQ+lpc/++b4vJ7SYXPlicbN13jmeiDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323746; c=relaxed/simple;
	bh=H6oSKzpWrJB+XFfmOt3I8gFC7XnrqHMPyyxig9RaxNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unK8bIyW+rk64YpMf+OkDL5+ndOmunHP5vHr39CymwglOZcaGP3sAZVPlGUDQAqDUKUPvDjcvHK7XcJdnkovSe4p57otQ1jl2rXKZs/JLulUYgwhjqubkpq4AUwg2uEy258QL23HJxcJgE+Auy8x3lkz/Dj0kNLnXswQ7+FhINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7mXK0fKszddBT;
	Tue, 25 Jun 2024 21:54:09 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 94027140155;
	Tue, 25 Jun 2024 21:55:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 21:55:42 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>
Subject: [PATCH net-next v9 09/13] net: introduce the skb_copy_to_va_nocache() helper
Date: Tue, 25 Jun 2024 21:52:12 +0800
Message-ID: <20240625135216.47007-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240625135216.47007-1-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
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

introduce the skb_copy_to_va_nocache() helper to avoid
calling virt_to_page() and skb_copy_to_page_nocache().

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..7ad235465485 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2201,6 +2201,21 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
 	return 0;
 }
 
+static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					 struct sk_buff *skb, char *va, int copy)
+{
+	int err;
+
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
+	if (err)
+		return err;
+
+	skb_len_add(skb, copy);
+	sk_wmem_queued_add(sk, copy);
+	sk_mem_charge(sk, copy);
+	return 0;
+}
+
 /**
  * sk_wmem_alloc_get - returns write allocations
  * @sk: socket
-- 
2.33.0


