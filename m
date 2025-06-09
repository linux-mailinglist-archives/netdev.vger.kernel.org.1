Return-Path: <netdev+bounces-195724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F75AD214D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72333188D25D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AD19F135;
	Mon,  9 Jun 2025 14:49:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D198F40;
	Mon,  9 Jun 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480542; cv=none; b=bx4hVoue3BHtXD5OugdUG2RsXFf5qT1IIjgNdOood4ycmSNjGbKy0NzKBew2WVTGdlHfZ+ZwW3RxaU4UYEdYbcM1ZoWvj65Ik+41UitkWJsBRH6cCr/F/JXGMeCIIaubhvr/IImOlfLX2vqg+5ra9M9aEJOeA8OU3ciE+rqbV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480542; c=relaxed/simple;
	bh=Mz4cpatBu/G0EeXnwbYRzzmWvkLtVoaBj2++JldmZpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIQTLgoBWl/LtsztJ6tB2O5RWRcBOV8kkjEbQy03yAn3H6spLmezuBOKzR2DLUts+WkvmNmIhV5Mmc4dMCR5EzHVGH0J9o4CCO6ySh5dF/PEDM6BH75H26+sO8laawViQ7xC0X/VXle9eGSoRdXJGh3x4/m2Qg+g2S2v+wepUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGFD46z8yz6M52d;
	Mon,  9 Jun 2025 22:48:36 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 602821402FC;
	Mon,  9 Jun 2025 22:48:58 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 16:48:52 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v3 1/3] queue_api: add subqueue variant netif_subqueue_sent
Date: Mon, 9 Jun 2025 18:07:52 +0300
Message-ID: <909a5c92db49cad39f0954d6cb86775e6480ef4c.1749038081.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1749038081.git.gur.stavi@huawei.com>
References: <cover.1749038081.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500005.china.huawei.com (7.182.85.13)

Add a new function, netif_subqueue_sent, which is a wrapper for
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
 include/net/netdev_queues.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index ba2eaf39089b..6e835972abd1 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -294,6 +294,15 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 		netif_txq_try_stop(_txq, get_desc, start_thrs);		\
 	})
 
+static inline void netif_subqueue_sent(const struct net_device *dev,
+				       unsigned int idx, unsigned int bytes)
+{
+	struct netdev_queue *txq;
+
+	txq = netdev_get_tx_queue(dev, idx);
+	netdev_tx_sent_queue(txq, bytes);
+}
+
 #define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
 	({								\
 		struct netdev_queue *_txq;				\
-- 
2.45.2


