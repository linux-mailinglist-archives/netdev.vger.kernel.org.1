Return-Path: <netdev+bounces-211459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA45B18E71
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E4AA3655
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467B22FAF4;
	Sat,  2 Aug 2025 12:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10448836;
	Sat,  2 Aug 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138400; cv=none; b=g5G0QajZSLEWfxEViTLx0Vytss0s4nIdrwYysOj7DgUCTJkLEt3kHR/52MuZPl1suOYf67BzmcHRTIw2cj/fV/DVzsTPKAzJAP7hhHHyDoOJqoBUjQFPeqFaSw39ahgas5s6S+3oerYruMNkdBykrdGLu/uc0wEGRo/4WO3IwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138400; c=relaxed/simple;
	bh=1S/c0JL6iNY5Biih3RZnR2wqtR8143r+az2eHc5zX84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF750OnVrhZ1K/IOLWPTkKx+NPIx0ymcGoE7FX8W3kKbVD9cTEbLfqzpXu4PSaMX4wNORwyAUJf3UKyxPkMM8+Yx3Neq9icXyEILmj+s/l2EVZ7L3dSeXzIhd95bUcptAwekAAwKw5L/Z3mO1GTiDBT4aK/iDrh6zQP36c9FTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bvMj04mJDz14M4t;
	Sat,  2 Aug 2025 20:35:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 28C1A140278;
	Sat,  2 Aug 2025 20:39:55 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 2 Aug 2025 20:39:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 2/3] net: hibmcge: fix the division by zero issue
Date: Sat, 2 Aug 2025 20:32:25 +0800
Message-ID: <20250802123226.3386231-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250802123226.3386231-1-shaojijie@huawei.com>
References: <20250802123226.3386231-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

When the network port is down, the queue is released, and ring->len is 0.
In debugfs, hbg_get_queue_used_num() will be called,
which may lead to a division by zero issue.

This patch adds a check, if ring->len is 0,
hbg_get_queue_used_num() directly returns 0.

Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
index 2883a5899ae2..2aecc73f3d49 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
@@ -29,6 +29,9 @@ static inline bool hbg_fifo_is_full(struct hbg_priv *priv, enum hbg_dir dir)
 
 static inline u32 hbg_get_queue_used_num(struct hbg_ring *ring)
 {
+	if (!ring->len)
+		return 0;
+
 	return (ring->ntu + ring->len - ring->ntc) % ring->len;
 }
 
-- 
2.33.0


