Return-Path: <netdev+bounces-206584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B8CB03897
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9353717ACF0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C26233712;
	Mon, 14 Jul 2025 08:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0991E5018;
	Mon, 14 Jul 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480046; cv=none; b=STNlCWIFnxTRcU3VoAIxCJDNDal/tGF6fJiP0lN/mg1JlsbjnmQqt7Ib65c4RoGbmSY5ONZMw5M+S1ERpr3wm5C5JcRjgDCv8vDXOzF2lC09g3aQo12AqAELUDtjdoN2gpvf3BjyePcs6Yr8pYPetmwYWCiT7j9UWgJJLyIfteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480046; c=relaxed/simple;
	bh=ovdHmcxQBDLvdoPNAvCtEcdM4Jq392cLtSD1+SWOnXI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lA7MvyqQO7hyhjPrmjSXdnMsIKksJMghNsZXJWYh2B1wErpas3Eh1y0semYU2X7LywIyr/cU39rhr0O0DXsrVQGXwakonVvDwoFfO26WMgOHrJadNCSjYMXuHL/ctVNFGJWX1qvQ1sVaP1vzpZ/eTtWSqpPYjHsUWQHPXmYcgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bgZXL6xm8z2YPsC;
	Mon, 14 Jul 2025 16:01:38 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D7071A016C;
	Mon, 14 Jul 2025 16:00:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 16:00:39 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <kuniyu@google.com>, <Markus.Elfring@web.de>
Subject: [PATCH v2 net-next] ipv6: mcast: Avoid a duplicate pointer check in mld_del_delrec()
Date: Mon, 14 Jul 2025 16:19:49 +0800
Message-ID: <20250714081949.3109947-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Avoid duplicate non-null pointer check for pmc in mld_del_delrec().
No functional changes.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: early return if (!pcm) true as Kuniyuki Iwashima suggested, also revise title
---
 net/ipv6/mcast.c | 52 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 6c875721d423..6d737815d0ab 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -789,34 +789,32 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 			break;
 		pmc_prev = pmc;
 	}
-	if (pmc) {
-		if (pmc_prev)
-			rcu_assign_pointer(pmc_prev->next, pmc->next);
-		else
-			rcu_assign_pointer(idev->mc_tomb, pmc->next);
-	}
-
-	if (pmc) {
-		im->idev = pmc->idev;
-		if (im->mca_sfmode == MCAST_INCLUDE) {
-			tomb = rcu_replace_pointer(im->mca_tomb,
-						   mc_dereference(pmc->mca_tomb, pmc->idev),
-						   lockdep_is_held(&im->idev->mc_lock));
-			rcu_assign_pointer(pmc->mca_tomb, tomb);
-
-			sources = rcu_replace_pointer(im->mca_sources,
-						      mc_dereference(pmc->mca_sources, pmc->idev),
-						      lockdep_is_held(&im->idev->mc_lock));
-			rcu_assign_pointer(pmc->mca_sources, sources);
-			for_each_psf_mclock(im, psf)
-				psf->sf_crcount = idev->mc_qrv;
-		} else {
-			im->mca_crcount = idev->mc_qrv;
-		}
-		in6_dev_put(pmc->idev);
-		ip6_mc_clear_src(pmc);
-		kfree_rcu(pmc, rcu);
+	if (!pmc)
+		return;
+	if (pmc_prev)
+		rcu_assign_pointer(pmc_prev->next, pmc->next);
+	else
+		rcu_assign_pointer(idev->mc_tomb, pmc->next);
+
+	im->idev = pmc->idev;
+	if (im->mca_sfmode == MCAST_INCLUDE) {
+		tomb = rcu_replace_pointer(im->mca_tomb,
+					   mc_dereference(pmc->mca_tomb, pmc->idev),
+					   lockdep_is_held(&im->idev->mc_lock));
+		rcu_assign_pointer(pmc->mca_tomb, tomb);
+
+		sources = rcu_replace_pointer(im->mca_sources,
+					      mc_dereference(pmc->mca_sources, pmc->idev),
+					      lockdep_is_held(&im->idev->mc_lock));
+		rcu_assign_pointer(pmc->mca_sources, sources);
+		for_each_psf_mclock(im, psf)
+			psf->sf_crcount = idev->mc_qrv;
+	} else {
+		im->mca_crcount = idev->mc_qrv;
 	}
+	in6_dev_put(pmc->idev);
+	ip6_mc_clear_src(pmc);
+	kfree_rcu(pmc, rcu);
 }
 
 static void mld_clear_delrec(struct inet6_dev *idev)
-- 
2.34.1


