Return-Path: <netdev+bounces-138442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748979AD98A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A398B1C2176A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9613C689;
	Thu, 24 Oct 2024 02:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04F1CAAC
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735443; cv=none; b=iDrqxoAQaAwi3hbHsSLakZZztX2m4p7DrtihUZEb7vn7eGBFoOV2GINvFao0iCrbOc1ywaBX/BV4Lww7VJqjQEqkntxFMcmcBcG7r0mD1+si7DhIGaannJEwjPgteQj69MXmMDrHsH7J3/2ujM6GSbYc9g2HaASrZwS9bPhG/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735443; c=relaxed/simple;
	bh=sCx5v/g5c/vl881k3lHZ6MEwPkK5N8967V0HHcGOIrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUgJIvQD0hMYz+lwBA/yN12E0EIlFO1BKI+jPVd9yEzmu5hbpQCKNLznP4saf4+IyefuzlXJFp02xdz3QtVnmG672Xwbi7ubTxhb2KbznXSLGEdtz4nzrEUHttjQwPw3i2QubiOgtxprvqKALKh5T0UkIU+/B3R9FINtdKprXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XYq0h4CRHz1T98x;
	Thu, 24 Oct 2024 10:01:56 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 174541402E1;
	Thu, 24 Oct 2024 10:03:59 +0800 (CST)
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
Subject: [PATCH net 2/2] net: pse-pd: Add missing of_node_get() before of_find_node_by_name()
Date: Thu, 24 Oct 2024 09:59:09 +0800
Message-ID: <20241024015909.58654-3-zhangzekun11@huawei.com>
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

of_find_node_by_name() will decrease the refount of the device_node.
So, get the device_node before passing to it.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/pse-pd/tps23881.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..f5c04dd5be37 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -216,6 +216,7 @@ tps23881_get_of_channels(struct tps23881_priv *priv,
 	if (!priv->np)
 		return -EINVAL;
 
+	of_node_get(priv->np);
 	channels_node = of_find_node_by_name(priv->np, "channels");
 	if (!channels_node)
 		return -EINVAL;
-- 
2.17.1


