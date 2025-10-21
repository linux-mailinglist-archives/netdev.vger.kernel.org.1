Return-Path: <netdev+bounces-231281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2217BF6F1B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B557B4F0A19
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0109A33B96F;
	Tue, 21 Oct 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="f3rOvkGP"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF933B962;
	Tue, 21 Oct 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055251; cv=none; b=Ku85qkGeaSUcEAKtmSuCmAAeKyfw0hNgixjTmwxi6n1kd/oYclVtcbthxGGVbLoOBMAqHml/PRnkxn4Ac7lHVTxgELrgv9F8soBR02mnaAoLYZ1l5c/nSdu/rJGqUL6bcivJ+U1caKEZJQkxPn2Aa0NdjMH5F5I7VRzb86+DC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055251; c=relaxed/simple;
	bh=EnfkgqqK3xwtWurI53NBT0VHCNA4DyaNgjxfw0MCWLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCbQ3rPIssY5Uje3/h0o8KO/6esscCcJFB6AZ9rgSWgpZZIhW6EZw7vs0uNPH8R60i7wUI8tsgcNZYyzo0itI4rUFRe+mSg37rVc99wPtKvKV5y2yZY7H1VCorJJtWMKjYuO15ERGwXad0i/1EDTFlsf96jB8HH8KsG244+Y/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=f3rOvkGP; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tLIoJWBipdWp8OO0fBqhvZFWq5wU9ioxaDDeO6NlDpg=;
	b=f3rOvkGP5Us3mzzQiKWUYHxOxVP66IN00w/sKk+nsKF9/1fwjrsGSkLE4GLzVt8VDQaIHL224
	/avRp0kNSwU8r0XQd29s6n3kUkF5AtLLi47NuEnwYEYOmvZnU015+3MJLNSQLPypOtWBIh5LMDi
	yGZXa6+LrLbNqEFG73UD/Ds=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4crYnf6zghzcb1s;
	Tue, 21 Oct 2025 21:59:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 97369140155;
	Tue, 21 Oct 2025 22:00:44 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 22:00:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
Date: Tue, 21 Oct 2025 22:00:14 +0800
Message-ID: <20251021140016.3020739-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251021140016.3020739-1-shaojijie@huawei.com>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

irq initialized with the macro HBG_ERR_IRQ_I will automatically
be re-enabled, whereas those initialized with the macro HBG_IRQ_I
will not be re-enabled.

Since the rx buf avl irq is initialized using the macro HBG_IRQ_I,
it needs to be actively re-enabled.

Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 8af0bc4cca21..ae4cb35186d8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -32,6 +32,7 @@ static void hbg_irq_handle_rx_buf_val(struct hbg_priv *priv,
 				      const struct hbg_irq_info *irq_info)
 {
 	priv->stats.rx_fifo_less_empty_thrsld_cnt++;
+	hbg_hw_irq_enable(priv, irq_info->mask, true);
 }
 
 #define HBG_IRQ_I(name, handle) \
-- 
2.33.0


