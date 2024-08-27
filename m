Return-Path: <netdev+bounces-122213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDD96061D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F15B1C202E2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECFB19DF74;
	Tue, 27 Aug 2024 09:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22919D8B7;
	Tue, 27 Aug 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751893; cv=none; b=LsbgE7Xv5+43/V26tdTqwGUwURU+mbiadkRS60Myex4c7aEZTtthVEXmlJY9AL4FgKeia8RZs6lzZQx/n6zmhyuMsh+mUoYJ1K5sFX4byWPe4+IbTdfBCHstBLTWIW2Zhekep8h+PWhhY6v6zRxEOVkfxksJgEVrucRnU7gI4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751893; c=relaxed/simple;
	bh=fBrS/5wGtoX/V6EBhE2hmsyUkyri4zlyiAlyJgDUHUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glCdd/BxPei2HlP5P73QkPczooIr0knzoa7Dzu4oZeyaiT1iQ6HsubIm3pCtfBvdOR7r2grpAY/OBhtS177pTVQgkTYeJWmlEO9ZBEcIqxPHG4uMh++D1nkIXJA4wlN7vTzA9N7P8omHBvgaJ8T4hWQrjFYTMVLEU5mBD92C6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtMz74sSMzfZ36;
	Tue, 27 Aug 2024 17:42:43 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 182F5140137;
	Tue, 27 Aug 2024 17:44:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:44:46 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH net-next] net/sunrpc: make use of the helper macro LIST_HEAD()
Date: Tue, 27 Aug 2024 17:52:18 +0800
Message-ID: <20240827095218.3913172-1-lihongbo22@huawei.com>
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

list_head can be initialized automatically with LIST_HEAD()
instead of calling INIT_LIST_HEAD(). Here we can simplify
the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/sunrpc/cache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..4f31e73dc34d 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -731,11 +731,10 @@ static bool cache_defer_req(struct cache_req *req, struct cache_head *item)
 static void cache_revisit_request(struct cache_head *item)
 {
 	struct cache_deferred_req *dreq;
-	struct list_head pending;
 	struct hlist_node *tmp;
 	int hash = DFR_HASH(item);
+	LIST_HEAD(pending);
 
-	INIT_LIST_HEAD(&pending);
 	spin_lock(&cache_defer_lock);
 
 	hlist_for_each_entry_safe(dreq, tmp, &cache_defer_hash[hash], hash)
@@ -756,10 +755,8 @@ static void cache_revisit_request(struct cache_head *item)
 void cache_clean_deferred(void *owner)
 {
 	struct cache_deferred_req *dreq, *tmp;
-	struct list_head pending;
+	LIST_HEAD(pending);
 
-
-	INIT_LIST_HEAD(&pending);
 	spin_lock(&cache_defer_lock);
 
 	list_for_each_entry_safe(dreq, tmp, &cache_defer_list, recent) {
@@ -1085,9 +1082,8 @@ static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 {
 	struct cache_queue *cq, *tmp;
 	struct cache_request *cr;
-	struct list_head dequeued;
+	LIST_HEAD(dequeued);
 
-	INIT_LIST_HEAD(&dequeued);
 	spin_lock(&queue_lock);
 	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
 		if (!cq->reader) {
-- 
2.34.1


