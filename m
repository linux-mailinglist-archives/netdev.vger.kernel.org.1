Return-Path: <netdev+bounces-200644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15836AE66E8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B295192184E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022F290D83;
	Tue, 24 Jun 2025 13:46:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D31ACEDA;
	Tue, 24 Jun 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772783; cv=none; b=XRgQiujx+NRlT5PAHlzqTsLpZXcXxnGqmFYGZ+rw5I0egtcS2qpes3ImQNGii+RqUU6ISCHJbpjxOtPJvm0C1YrhiI8OwpkJH/qjYFO7ScODlvZmPz9ULS3G3HgtNjDBckGvi7HVK3HSk67aJOFdYGlifX2t6EJkBKzVv4yJZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772783; c=relaxed/simple;
	bh=eJvTgi6lIVBYJ9TiVue54BRirAbrvN1qTa/4L803Q84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7JDK9wGERtptzGfGFBJe6ADyRSyfqG+3sAM5qqKR7CJ1pawbERiG54RDaAzgDCRIqBw7aMvGKHO/spPcM9IexydmzujuYRrK4UE7ZReA2Q6hz8uNtYvFEQh5FjrG/JHDONW3WAYHYIhX5zWsaGdLTli8eWtRUXIxFODvb9w7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bRR2c063FzPt9j;
	Tue, 24 Jun 2025 21:42:16 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C695180237;
	Tue, 24 Jun 2025 21:46:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 21:46:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv4: fib: Remove unnecessary encap_type check
Date: Tue, 24 Jun 2025 22:03:15 +0800
Message-ID: <20250624140315.3929702-1-yuehaibing@huawei.com>
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

lwtunnel_build_state() has check validity of encap_type,
so no need to do this before call it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv4/fib_semantics.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f7c9c6a9f53e..475ffcbf4927 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -625,11 +625,6 @@ int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 	if (encap) {
 		struct lwtunnel_state *lwtstate;
 
-		if (encap_type == LWTUNNEL_ENCAP_NONE) {
-			NL_SET_ERR_MSG(extack, "LWT encap type not specified");
-			err = -EINVAL;
-			goto lwt_failure;
-		}
 		err = lwtunnel_build_state(net, encap_type, encap,
 					   nhc->nhc_family, cfg, &lwtstate,
 					   extack);
@@ -890,9 +885,6 @@ static int fib_encap_match(struct net *net, u16 encap_type,
 	struct lwtunnel_state *lwtstate;
 	int ret, result = 0;
 
-	if (encap_type == LWTUNNEL_ENCAP_NONE)
-		return 0;
-
 	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
 				   cfg, &lwtstate, extack);
 	if (!ret) {
-- 
2.34.1


