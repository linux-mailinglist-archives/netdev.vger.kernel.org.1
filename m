Return-Path: <netdev+bounces-232740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC96C08829
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB6D4E48B6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF5219319;
	Sat, 25 Oct 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1XHe9DCb"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADC1DA62E;
	Sat, 25 Oct 2025 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356847; cv=none; b=gR1o8CLZCXidH9U1Z2przdReC4BVWFkUihd61Ihx4bccx+x33ruDLJPsE5UFyP/jIBOJGVvuQauqoYws+na1z7wcO//GhavuZ0pu0yU3F9uiLnsnY6g47cUBr8dJVUdoGJQk27yEnMiaj8RPBqJ31NQ+Z4poeqPBMT5+3GiTaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356847; c=relaxed/simple;
	bh=J1uZkfaWrvaux38c12zl9+pVendtf3jGjVFWGVSQJMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSVVY3vWEb9eneSJO8GquH5wF5x9LwwSEXDkCL2UrrVBO7A0SYxkzca1AJISl4JZh4C7GGyh+raVYFpNIzt7OG9FQLakeB1l/HsU55lr2Ihu+/2Skb+xzAkB8os0grGZOPbNBDSOvVoGiM6geARMYyCNlFOVfn3tKS/OJcNuYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1XHe9DCb; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gJueltyOf64DMeM5RS+Oi6ralG4WrDpwTC4Mey1u4Uc=;
	b=1XHe9DCbjiz40Kv9nrzo0W42KKrLKZlTGvXpS7Dt3t+WIKwpxduewH7UHXV4KXBcRZWLCVskH
	Q2nhRViE9FfIS1cY4M63BevIJGyFq+wSiWwySgPfEmWl+rNkffoaeaG3Cwi+wboVm47yr4I91Fm
	S4yVhZQq4Y35zZ8m6GZqea4=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4ctjKq2grjz1T4Gl;
	Sat, 25 Oct 2025 09:46:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F6DA180B69;
	Sat, 25 Oct 2025 09:47:21 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 09:47:20 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jacob.e.keller@intel.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 1/3] net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
Date: Sat, 25 Oct 2025 09:46:40 +0800
Message-ID: <20251025014642.265259-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251025014642.265259-1-shaojijie@huawei.com>
References: <20251025014642.265259-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

irq initialized with the macro HBG_ERR_IRQ_I will automatically
be re-enabled, whereas those initialized with the macro HBG_IRQ_I
will not be re-enabled.

Since the rx buf avl irq is initialized using the macro HBG_IRQ_I,
it needs to be actively re-enabled;
otherwise priv->stats.rx_fifo_less_empty_thrsld_cnt cannot be
correctly incremented.

Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


