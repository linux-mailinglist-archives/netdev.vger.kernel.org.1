Return-Path: <netdev+bounces-192538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BDAC04AE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABBF8C1AA3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A35221FAE;
	Thu, 22 May 2025 06:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A41ACEA6;
	Thu, 22 May 2025 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895877; cv=none; b=D8MNSAZT7kaItFFmhi0gruSCc43NfhLVBErb5VmTCIW7PT4fgMNxpU/DZZcguKSKzf0VLovLVU0yIcukR1Bqw9Ze3uCXHK9y3dbxblDUmvb1xdXAJFStiscnwOcjgtcW+nZ0m1nPrU0otUXfIZzP7/beVqmnso35bnX23z5C42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895877; c=relaxed/simple;
	bh=uBlSAeu0InLqUwHqIpbqtlkDc3mvWJhwhxVYmOdp14M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz2TeHm9oeXvbwPgISO/C8joG1Ef2Hq2kMjdTTppNONwJxgJG6N0Rb2gV6b7umV97kYKBnxBAuQneGAClleaamUMZzEAW+f5sstDAinmA3/P60RZchDqSDvePEUfOq/Wg0iQwjyUs6YVApXgKMBTdoibgDS7iJ2T9Mx7yrwCilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2z4Y2gJHz6GFXc;
	Thu, 22 May 2025 14:33:01 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id C46F01402FC;
	Thu, 22 May 2025 14:37:53 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 08:37:49 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v2 1/3] queue_api: add subqueue variant netif_subqueue_sent
Date: Thu, 22 May 2025 09:54:41 +0300
Message-ID: <19057ca470251f5c48d90f379edafdb639278339.1747896423.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1747896423.git.gur.stavi@huawei.com>
References: <cover.1747896423.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500005.china.huawei.com (7.182.85.13)

Add a new macro, netif_subqueue_sent, which is a wrapper for
netdev_tx_sent_queue.

Drivers that use the subqueue variant macros, netif_subqueue_xxx,
identify queue by index and are not required to obtain
struct netdev_queue explicitly.

Such drivers still need to call netdev_tx_sent_queue which is a
counterpart of netif_subqueue_completed_wake. Allowing drivers to use a
subqueue variant for this purpose improves their code consistency by
always referring to queue by its index.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 include/net/netdev_queues.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index ba2eaf39089b..7b6656ee549f 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -294,6 +294,14 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 		netif_txq_try_stop(_txq, get_desc, start_thrs);		\
 	})
 
+#define netif_subqueue_sent(dev, idx, bytes)				\
+	({								\
+		struct netdev_queue *_txq;				\
+									\
+		_txq = netdev_get_tx_queue(dev, idx);			\
+		netdev_tx_sent_queue(_txq, bytes);			\
+	})
+
 #define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
 	({								\
 		struct netdev_queue *_txq;				\
-- 
2.45.2


