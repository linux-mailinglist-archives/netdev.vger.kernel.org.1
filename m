Return-Path: <netdev+bounces-96560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0F8C670B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB041C2247A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721F12F5A4;
	Wed, 15 May 2024 13:13:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218412E1DC;
	Wed, 15 May 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778789; cv=none; b=CNu7AU+B0TxpKh8LWcT0i7jmw6Z0WzojNEyV6LaQRg8guPgT+ggbN8/BgPA72ViV2PV8pbZHBS/3qBn5D8VLYLClfgr7SGoUuO3w1o+EA56xq2YxPHKMrjgGKlEMX3SQkdGMRO3O9L2jDkujoY2WBjnv2WoXtNBV9tzayhj2LnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778789; c=relaxed/simple;
	bh=1cSzT3pvCmXcsrHWza33+AomiBd6dzul6WthXh/J898=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnyfZxVGeBpHU8iif3Itb4NslbmPYeiWD3OSaNXsOrdsAYVgECCJoteeAgeMETd2rAnnH+WpOofqc8N/uaS0leMYYx6UMw2CaXn7wS2zB20GsoMOkhJ99o0dxmXz5bZ3HEGIg6+cveW9kTlDCH1ADBVzmrPvoy571EGzxiaMzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VfYTr5j8KztXJY;
	Wed, 15 May 2024 21:09:36 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3EA18007D;
	Wed, 15 May 2024 21:13:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:13:05 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>
Subject: [RFC v4 09/13] net: introduce the skb_copy_to_va_nocache() helper
Date: Wed, 15 May 2024 21:09:28 +0800
Message-ID: <20240515130932.18842-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240515130932.18842-1-linyunsheng@huawei.com>
References: <20240515130932.18842-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

introduce the skb_copy_to_va_nocache() helper to avoid
calling virt_to_page() and skb_copy_to_page_nocache().

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0450494a1766..57421e680cce 100644
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


