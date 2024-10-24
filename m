Return-Path: <netdev+bounces-138441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562139AD989
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855151C21748
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98813BC39;
	Thu, 24 Oct 2024 02:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871A2AF09
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735442; cv=none; b=oxjFt/+4uyWSyAdXW2YxBa6b4j2AU6uO9GZhyyO8L/+hrm26CzPuQ2wFT1N/Usj4n8tdvHRme3YKmjD7ZgSlacicKcCPdSEQJYebS98B5FA3Qa2/ZBgqL7MYBxyTPwHt4LO0FjoD2FHY3R6cU7C0yC1AmVkYnI0hFqTJtyZc/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735442; c=relaxed/simple;
	bh=hA2ckDoFx4DgvYUJrbDpXVTEJVcI8+i1/52TH1ZQ1m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZk6FFU8q7O1v965tZWEHFounemOtaUSf0AI5k2Joa5TUAlrznaQ0L+C9ZYAsjVephJfB4mQDCeTihqE3jgqjr/lLEi+4TPckcrmLLfeTedUsj/SWyRTYbDYYzvRFyzW15fsoO0gWgeAUhHNyxCnWYPLq1YeVNUjacf300GW0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYq1Q27MHz1jvqb;
	Thu, 24 Oct 2024 10:02:34 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 198C1180044;
	Thu, 24 Oct 2024 10:03:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 10:03:57 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<kory.maincent@bootlin.com>, <horms@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before of_find_node_by_name()
Date: Thu, 24 Oct 2024 09:59:08 +0800
Message-ID: <20241024015909.58654-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241024015909.58654-1-zhangzekun11@huawei.com>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

of_find_node_by_name() will decrease the refcount of the device_node.
So, get the device_node before passing to it.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 297c2682a9cf..517593c58945 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1367,6 +1367,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	bcmasp_core_init(priv);
 	bcmasp_core_init_filters(priv);
 
+	of_node_get(dev->of_node);
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
-- 
2.17.1


