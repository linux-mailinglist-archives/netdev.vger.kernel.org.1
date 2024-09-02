Return-Path: <netdev+bounces-124208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091A968870
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFB91F2365D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818F187355;
	Mon,  2 Sep 2024 13:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7F19C56C
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282347; cv=none; b=IOfeygDshWqRzMMbpO4HyW4xVFr0VrOqcnyXKHdTDRuH+jdHL0tdtQXNo4lyxQpu5vH2yk6MEnpqBEgJeXHpHaFIesESOo22pFMlwq91S5MsTEU7RurhOvIkT0NqeDLRawjrpQTLo4StPJz23+3l8QRlwuOP4EQ6o0FcGeMEV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282347; c=relaxed/simple;
	bh=ZNOhIVoCBGBGna7/cnqfPsTlcjm5F16n86WTFRfFF7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uuXxfkO1gGlf+W0iZl4CqoFrHCTrHg77JxHppKc0USy62u1B4vfies9ggByXQZq6st3+X23ftKoCjgTWvXhPowlAsrIDo95Rr4FF8cNgClG1pbsvGTcEfprvxWN+KNtwMs0XYBBCHR8rM/HJNnUzPBeLyvQf+TRRqI2D1Hq+ZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wy84v5BNVz69Ms;
	Mon,  2 Sep 2024 21:00:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2755B1402DE;
	Mon,  2 Sep 2024 21:05:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 21:05:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH net-next] ice: Make use of assign_bit() API
Date: Mon, 2 Sep 2024 21:14:07 +0800
Message-ID: <20240902131407.3087903-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

We have for some time the assign_bit() API to replace open coded

    if (foo)
            set_bit(n, bar);
    else
            clear_bit(n, bar);

Use this API to clean the code. No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 46d3c5a34d6a..e3ad91b3ba77 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6522,8 +6522,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_HW_TC) {
 		bool ena = !!(features & NETIF_F_HW_TC);
 
-		ena ? set_bit(ICE_FLAG_CLS_FLOWER, pf->flags) :
-		      clear_bit(ICE_FLAG_CLS_FLOWER, pf->flags);
+		assign_bit(ICE_FLAG_CLS_FLOWER, pf->flags, ena);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
-- 
2.34.1


