Return-Path: <netdev+bounces-219502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BEB419BE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAD5166783
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4402EAB65;
	Wed,  3 Sep 2025 09:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8342285074;
	Wed,  3 Sep 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891096; cv=none; b=rZ1gO7FVqgIN70u/dAgPevIwJz6STD4S5q5p+mIPjNyfEZ2UgZ1gAcU8UNpxmJr68Ms81uxwh7n3PjoAyJEEHa/9aG3yCO46Z1d8YrKFjyK0yFhK1dbTw0IkberQ8Pnx9tkokvxrWyj8zdmyqMmLZ8xg35m5ITUjq8tjOY+B+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891096; c=relaxed/simple;
	bh=L8kekbtlJ61/+0qI8FN7jAv35CVMrvcJVzR3Bq6Jpm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEPmxKZ9m1U3KCLr5QLVghVKb48jQSByq78JJ81ARvCbZ7PUPj31hrDvOUp3xn0J7afyt++/YpfoT7Ep9pMBfI6y3LqIXr4MJLlSrAM/PKTjEBeoEcTa5qAe15EL2eyG4rClzQ7xSXO5PFmoouCU/AhqSeNnBXVemCK0tcJCvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cGxlW1dlFz2VRgR;
	Wed,  3 Sep 2025 17:15:03 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 308871A016C;
	Wed,  3 Sep 2025 17:18:10 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 17:18:09 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: Add sanity checks on ipv6_devconf.seg6_enabled
Date: Wed, 3 Sep 2025 17:39:48 +0800
Message-ID: <20250903093948.3030670-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

In ipv6_srh_rcv() we use min(net->ipv6.devconf_all->seg6_enabled,
idev->cnf.seg6_enabled) is intended to return 0 when either value is zero,
but if one of the values is negative it will in fact return non-zero.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..87f14532cb7e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7193,6 +7193,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	{
-- 
2.34.1


