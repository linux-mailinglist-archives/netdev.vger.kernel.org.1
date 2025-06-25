Return-Path: <netdev+bounces-200901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA1AE7498
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229DC7A255D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511622083;
	Wed, 25 Jun 2025 02:04:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07070A31;
	Wed, 25 Jun 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817055; cv=none; b=XyGKeaI+1eO2EjNuN6arsUNCLIqfs0aKVYQBwMA/2wroLp2ndZZMN0COXJ8ZBJ5ZrxWxTwBDUi0BkgbVGIL2NGPJActKQhhOjXt47THXgPM4IrToK96gQPS4usaoXcSvRElAiaRFlg3NFfbVd829qDSC6oKF4KKd7GtFiVnM/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817055; c=relaxed/simple;
	bh=jwrXniQ29yzeVwdFRhFL2lJ1UY/qZ4FD5cjDhU77lE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LTQQit8clRWrqZQ3FCpkDFXZPHtv/aGDH0pXRQ1ykfeDJ5Mkf//duwQZ9H+KwcsFMGzNVOHiIUFye6loQGJUKG6uStQ7hHnRidkzF4soP+69OGyNPjZWimhb1C9wduM4pqu0psp7tEAMaPOONgUKOpRiwG7JmkOnmMVvFmqshN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bRlRn0XT0z1W3V2;
	Wed, 25 Jun 2025 10:01:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CD0951A016C;
	Wed, 25 Jun 2025 10:04:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 10:04:07 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] ipv4: fib: Remove unnecessary encap_type check
Date: Wed, 25 Jun 2025 10:20:59 +0800
Message-ID: <20250625022059.3958215-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

lwtunnel_build_state() has check validity of encap_type,
so no need to do this before call it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: Restore encap_type check in fib_encap_match()
---
 net/ipv4/fib_semantics.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f7c9c6a9f53e..a2f04992f579 100644
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
-- 
2.34.1


