Return-Path: <netdev+bounces-121254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0295C5DA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195F91F238C4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDC55894;
	Fri, 23 Aug 2024 06:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925B53E15
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395987; cv=none; b=mKxAuMT6IhSG44KpVfJs3dvhw275gyRBEEmWmNRiekqNJZVkbEOX+gZyAB6hY5WrzeXoN0i9EacvmQ8YAC2a/pfnM1mazlgu2qMtd9V58PEQZsghf0M8yR0XY+EBuwnMl5rEPHATIayJBZKPdCzEObAB2jzUylaHKNyFnpe8tPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395987; c=relaxed/simple;
	bh=Li9jLLVGztu7s9HpsH4coq2z+6yS49pZW3lyxASzD2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMTNGuIjFBQBuEngfiFQzlOaW9q2O9cnzR/j6hTMcKgtPSSFyjQI1YRyL6JCGdxixL0ZoEflOsQqRCR21IvVflyLIgMu0496PWAhaLGSghXQmFnbqGgKG5DqDafXpXMHUDFutV9eR42V8NSDzErR70UgFwIblFmqIPW7sTzjYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqrP703ldz1j71T;
	Fri, 23 Aug 2024 14:52:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E87E1A0188;
	Fri, 23 Aug 2024 14:53:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:53:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next 1/2] net/ipv4: fix macro definition sk_for_each_bound_bhash
Date: Fri, 23 Aug 2024 15:00:42 +0800
Message-ID: <20240823070042.3327342-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The macro sk_for_each_bound_bhash accepts a parameter
__sk, but it was not used, rather the sk2 is directly
used, so we replace the sk2 with __sk in macro.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 64d07b842e73..ce4d77f49243 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -236,7 +236,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 
 #define sk_for_each_bound_bhash(__sk, __tb2, __tb)			\
 	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
-		sk_for_each_bound(sk2, &(__tb2)->owners)
+		sk_for_each_bound((__sk), &(__tb2)->owners)
 
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
-- 
2.34.1


