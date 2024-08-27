Return-Path: <netdev+bounces-122120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88295FF45
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00FD28313F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89C1754B;
	Tue, 27 Aug 2024 02:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81211185
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726701; cv=none; b=oYDZCLLSydcopc3TjHcYjcRHxIvXWwg0HL3meJB/xXZL7kDQPChaTfUI0ocS3mA/eh+SOJOPltWUDbvWLiWYuxPsSu+Y/FG/T46qIbmnxBc6+PloXsU/CYfVdlIWE+STSyFykIKJxIoSaqgdlGhaS+PlHEynHDynuUcieOrHHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726701; c=relaxed/simple;
	bh=h2UukjmGU0/aG4gaa+uCHV7OpV88skuBkXYcNYUxV3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RayoTSU9Z7Mokm4ogxQGhiU1v9nFbUoHUv7w2UJsCJTbW+ZGJqVwP+kb7MPvoaq0U/rWDyCb5UX160P6rqxYGetooqQ589S07RshOB4Zd6DZqRCwNBOMKqIsEix58ktT1Xzav2OHOK//kJ0sbtfWSse7gLHPJnBRHLwyx+jVs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtBfk2gJdzfbYx;
	Tue, 27 Aug 2024 10:42:54 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A04091402DE;
	Tue, 27 Aug 2024 10:44:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:44:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] net/ncsi: Use str_up_down to simplify the code
Date: Tue, 27 Aug 2024 10:52:46 +0800
Message-ID: <20240827025246.963115-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827025246.963115-1-lihongbo22@huawei.com>
References: <20240827025246.963115-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As str_up_down is the common helper to reback "up/down"
string, we can replace the target with it to simplify
the code and fix the coccinelle warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ncsi/ncsi-aen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..25814f06d7da 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -75,7 +75,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	has_link = !!(data & 0x1);
 
 	netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
-		   nc->id, data & 0x1 ? "up" : "down");
+		   nc->id, str_up_down(data & 0x1));
 
 	chained = !list_empty(&nc->link);
 	state = nc->state;
-- 
2.34.1


