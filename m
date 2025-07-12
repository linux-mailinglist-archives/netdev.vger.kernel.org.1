Return-Path: <netdev+bounces-206317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC71B02A39
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C43A8ADF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD6254AE1;
	Sat, 12 Jul 2025 09:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88280B;
	Sat, 12 Jul 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752311197; cv=none; b=FA/Q3pfwml2ilWK3JHPnJgUAeNfd5rfar2/BfN7BFH4M1o8tV2muRXrB+Mlo4acZHTb2gnwvvNsTHmUypz75aNmbdbIElnCyWNpVyrK19Jc8c6V+1uXryqA0zDG6u+buRgAo7E2U1Z+o7sxlUKx8zSePxvR+BJLxgBo2OqabD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752311197; c=relaxed/simple;
	bh=tQCbXV1244LalYlPbpsFgDfSuhBQeqb37G3vQc2I3xU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFKYfe8yRjYYR/+m26wufYwBW/wSE0e99A9gIjE97yZZazU2uCFDi0AKZHWmqVxy+WGw08QIRYkqBWazhWOlKpsJrnb/nOKhn4Id2MOYChJtsiwyzY+4vx23h/HEZJsgm4jECLtkTCjBfsPvZWNnEgT6gID7HvzYp3uWZox1xH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bfN0q2sLnz1V44K;
	Sat, 12 Jul 2025 17:03:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E60D91A0188;
	Sat, 12 Jul 2025 17:06:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Jul
 2025 17:06:13 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_delrec()
Date: Sat, 12 Jul 2025 17:28:11 +0800
Message-ID: <20250712092811.2992283-1-yuehaibing@huawei.com>
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

These is no need to check null for pmc twice.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 6c875721d423..f3dae72aa9d3 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -794,9 +794,7 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 			rcu_assign_pointer(pmc_prev->next, pmc->next);
 		else
 			rcu_assign_pointer(idev->mc_tomb, pmc->next);
-	}
 
-	if (pmc) {
 		im->idev = pmc->idev;
 		if (im->mca_sfmode == MCAST_INCLUDE) {
 			tomb = rcu_replace_pointer(im->mca_tomb,
-- 
2.34.1


