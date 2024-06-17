Return-Path: <netdev+bounces-104034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4790AF02
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13501F26302
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B494199EB4;
	Mon, 17 Jun 2024 13:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB127199EA6;
	Mon, 17 Jun 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630266; cv=none; b=aqx5tL21d836cRuCip//G+cxzZtsnKAB+Nj8WdG222sh0q/YFwDFoZQq7IWdk5Sso7/iI3X1VCYjzUXd8FlFu0hPtAlFqcebHGOGVCDJwdH3HYgXAjtg7cxz8xUzvNorz/0VGDK1OJF/kmfz1AlSKc7YLHbsanFmYL2y9kEwl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630266; c=relaxed/simple;
	bh=LzqvXCakhbf2NL+qmrn9f8QQFB9OwWypJ35o/EahJOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ofp9JF0fsB+wVmqRNMSGt+2laTH+JXuJaL4q8SOmGdIwpKuzVf+KUMJ9ei1f2sLwnZdgUHMXXLaJArYp81rNr87GFFmkDrH9VqhmcnlWV31V8CyGJpfTaVc8a+6Nn+ckUSHdhR1pTEe4DP11RU7n3qz8K3LFc87oR7d7LsLSrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W2r161lJ1z1SCR8;
	Mon, 17 Jun 2024 21:13:30 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A00C1140258;
	Mon, 17 Jun 2024 21:17:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:42 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>
Subject: [PATCH net-next v8 09/13] net: introduce the skb_copy_to_va_nocache() helper
Date: Mon, 17 Jun 2024 21:14:08 +0800
Message-ID: <20240617131413.25189-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

introduce the skb_copy_to_va_nocache() helper to avoid
calling virt_to_page() and skb_copy_to_page_nocache().

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index b30ea0c342a6..1c2269446149 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2196,6 +2196,21 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
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


