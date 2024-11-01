Return-Path: <netdev+bounces-140918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40619B897C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2150E1C20925
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599685626;
	Fri,  1 Nov 2024 02:53:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012725D8F0;
	Fri,  1 Nov 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429633; cv=none; b=LW++gAH/HF9RkuvgvZNJhdZvaiANe9YK8NWN3HB8r857IQm5rSuERWYj+suplG4oslTWh6ZiX5cLJu6qRNbdRhB0MpDjvmDiu6J3XLWbuVghFDCr3RMEdfCzeGBmkuN3l2WAgU582vemz5ii0i4+ckyo3qTkG8xDRUHW90uY2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429633; c=relaxed/simple;
	bh=875L2+sRPUazwPMeu4JQsnPyKUQSBqGBuFBQRu1CL0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGCNYwbfF9WIWBduJsKfTjyjpri2KDbzhjTRFYF0/ZeZs6JBQBA0FXSZqYXqrW0mc8bSGT1HNh3BGpixMbjHlZTLh6pBS1KR5Nm3LOHrV+rVSBoG2XBVcVIGEpXsTzxsFOqjT1YEVklBOgfQni0UIHRYdYoV4Se4/x3fNsNhgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfllZ1nDqz20rHq;
	Fri,  1 Nov 2024 10:52:42 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 62220140136;
	Fri,  1 Nov 2024 10:53:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 10:53:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chandrashekar.devegowda@intel.com>, <chiranjeevi.rapolu@linux.intel.com>,
	<haijun.liu@mediatek.com>, <m.chetan.kumar@linux.intel.com>,
	<ricardo.martinez@linux.intel.com>, <loic.poulain@linaro.org>,
	<ryazanov.s.a@gmail.com>, <johannes@sipsolutions.net>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v3] net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()
Date: Fri, 1 Nov 2024 10:53:16 +0800
Message-ID: <20241101025316.3234023-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)

The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
allocated and mapped skb in a loop, but the loop condition terminates when
the index reaches zero, which fails to free the first allocated skb at
index zero.

Check with i-- so that skb at index 0 is freed as well.

Cc: stable@vger.kernel.org
Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Remove suggested-by.
- Use i-- to simplify the fix.
- Add Acked-by.
- Add cc stable.
- Update the commit message.
v2:
- Update the commit title.
- Declare i as signed to avoid the endless loop.
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 210d84c67ef9..7a9c09cd4fdc 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
 	return 0;
 
 err_unmap_skbs:
-	while (--i > 0)
+	while (i--)
 		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
 
 	return ret;
-- 
2.34.1


