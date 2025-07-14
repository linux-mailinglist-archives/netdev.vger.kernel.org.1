Return-Path: <netdev+bounces-206578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACB6B03870
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B376317267B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C965236A9F;
	Mon, 14 Jul 2025 07:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FD2367C1;
	Mon, 14 Jul 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479763; cv=none; b=AmTjnxanjvrG8bEai4xu8SxZ+jQyA3JFbT4XOvR3xDnOxyhkvcG3jIVJCEuZcoYSRFCLLRjcOGq9fqIkJW/oksXZ66Qn5fL7U/cS7dQehU15D1S1Cz4/+HIDtki+7GtJPDUikDuzpSWXNLPYz/YQDisS5QW50+OESOaDDKM6gAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479763; c=relaxed/simple;
	bh=xKRHNZ4V1eRw0DkVaCsQJatsr+2Qc4y2EHspEjPCxjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dmtLtrkcS6krfoZ/JSkTYueXC2TxvDlReJdriW6aM0q4MV5xCX7XmSKgEnMFnoSg++oM4+GF7FgSNq4sDjI4hbzxEOzX/KiPN9vB3x/W3WE6SqLS/PewY9X/+XLCxcM79nORx/2OkOKSMQvxnjQAgqnt3LzRI4JI+AjFb+X4WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgZMR0R6sz2TT1l;
	Mon, 14 Jul 2025 15:53:55 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AEDA31800B2;
	Mon, 14 Jul 2025 15:55:56 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 15:55:55 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in ip6_mc_find_dev()
Date: Mon, 14 Jul 2025 16:17:32 +0800
Message-ID: <20250714081732.3109764-1-yuehaibing@huawei.com>
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

These is no need to check null for idev before return NULL.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index e95273ffb2f5..8aecdd85a6ae 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -329,9 +329,6 @@ static struct inet6_dev *ip6_mc_find_dev(struct net *net,
 	idev = in6_dev_get(dev);
 	dev_put(dev);
 
-	if (!idev)
-		return NULL;
-
 	return idev;
 }
 
-- 
2.34.1


