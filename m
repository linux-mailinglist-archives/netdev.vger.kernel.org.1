Return-Path: <netdev+bounces-206680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB8FB040CB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11F517504F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02777255F26;
	Mon, 14 Jul 2025 13:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18A255222;
	Mon, 14 Jul 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501502; cv=none; b=QbSizUNlJEL6UZ8i1L58ewxBGnT0zC4NdeiqHnvUZo+mPf1pq4yAi8+RarsFZEBrnZkB2vNfhGaVcu5KQfmz42rWVm1g5Yn8NYiWItSx3dFokzs2ZTVs9KjRQCXvp7TLXX0FbE9zOGYsDiRrhfnzlWddTRjTQeOdfqsDEwrV1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501502; c=relaxed/simple;
	bh=cbQD77zOpDuh21Lhn8qdoh9hYv1nwfrqrIX0n5vdZzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8uabmT6MZlxdo/QKESHOsT2z+/GUtYs6mFUAe9/9sqHx/Djh76CDFGCmqp23A3prPuQC0SuQ+OiD1fSot6+X7fh7xYSMjdner2suklBPS4pg3Jnym0ixUWMz4g0YNHlIjaTg8/wfC//wincm2ee0PcMFwAuG0GWf3kp6lCyL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgkNs0LZ9z29drm;
	Mon, 14 Jul 2025 21:55:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 90565140230;
	Mon, 14 Jul 2025 21:58:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:58:16 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ap420073@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
Date: Mon, 14 Jul 2025 22:19:57 +0800
Message-ID: <20250714141957.3301871-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

pmc->idev is still used in ip6_mc_clear_src(), so as mld_clear_delrec()
does, the reference should be put after ip6_mc_clear_src() return.

Fixes: 63ed8de4be81 ("mld: add mc_lock for protecting per-interface mld data")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 65831b4fee1f..616bf4c0c8fd 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -807,8 +807,8 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 		} else {
 			im->mca_crcount = idev->mc_qrv;
 		}
-		in6_dev_put(pmc->idev);
 		ip6_mc_clear_src(pmc);
+		in6_dev_put(pmc->idev);
 		kfree_rcu(pmc, rcu);
 	}
 }
-- 
2.34.1


