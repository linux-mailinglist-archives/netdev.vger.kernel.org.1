Return-Path: <netdev+bounces-75234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BE868C38
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F28A28A629
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5817136651;
	Tue, 27 Feb 2024 09:28:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58013665C;
	Tue, 27 Feb 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026086; cv=none; b=CvcGLnNor1Mx28u4NG9al8jry6fOmwlVGq8IUYVNtLNP220XxwrQma4bcimMJG+93RXM2QzOOIeYB5Zvwjs4p+tx1wh7wV6OsNfjvY2q52BhA+YsYN5l2Lrr9+u/IsbZfVlfGAns6dZ3qBhsNgmU07Zrm87alhaEqS1xAq6HFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026086; c=relaxed/simple;
	bh=Zbvn6ZhoUbnLmX0A3Zm9N0pbkE8+2Ni+LdZohLEciOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lrc5fymaRAQOtiTp1H0LU0gT5gVxcvIkA9hEwfFv4AKua7lMX3LhrIM5wc0J2IoVqxG3e6DfY6n1CIyYfzpz170hDU2mRax22clsQ/qDyzdyP0cIkG56Z7l83aRlyJEy9RF+UPFBZDH/iB9Y2xY8VbhPNSflzZqSw8FJayvGfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkX8P0GRQz1b14C;
	Tue, 27 Feb 2024 17:23:01 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C8CE1A016B;
	Tue, 27 Feb 2024 17:27:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:27:58 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <paul@paul-moore.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] netlabel: remove impossible return value in netlbl_bitmap_walk
Date: Tue, 27 Feb 2024 17:36:04 +0800
Message-ID: <20240227093604.3574241-1-shaozhengchao@huawei.com>
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
 dggpeml500026.china.huawei.com (7.185.36.106)

Since commit 446fda4f2682 ("[NetLabel]: CIPSOv4 engine"), *bitmap_walk
function only returns -1. Nearly 18 years have passed, -2 scenes never
come up, so there's no need to consider it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv4/cipso_ipv4.c        | 5 +----
 net/ipv6/calipso.c           | 5 +----
 net/netlabel/netlabel_kapi.c | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index d048aa833293..8b17d83e5fde 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -864,11 +864,8 @@ static int cipso_v4_map_cat_rbm_ntoh(const struct cipso_v4_doi *doi_def,
 					      net_clen_bits,
 					      net_spot + 1,
 					      1);
-		if (net_spot < 0) {
-			if (net_spot == -2)
-				return -EFAULT;
+		if (net_spot < 0)
 			return 0;
-		}
 
 		switch (doi_def->type) {
 		case CIPSO_V4_MAP_PASS:
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 1578ed9e97d8..eb8ee1e9373a 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -657,11 +657,8 @@ static int calipso_map_cat_ntoh(const struct calipso_doi *doi_def,
 					  net_clen_bits,
 					  spot + 1,
 					  1);
-		if (spot < 0) {
-			if (spot == -2)
-				return -EFAULT;
+		if (spot < 0)
 			return 0;
-		}
 
 		ret_val = netlbl_catmap_setbit(&secattr->attr.mls.cat,
 					       spot,
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 7b844581ebee..1ba4f58e1d35 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -876,7 +876,7 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
  * Description:
  * Starting at @offset, walk the bitmap from left to right until either the
  * desired bit is found or we reach the end.  Return the bit offset, -1 if
- * not found, or -2 if error.
+ * not found.
  */
 int netlbl_bitmap_walk(const unsigned char *bitmap, u32 bitmap_len,
 		       u32 offset, u8 state)
-- 
2.34.1


