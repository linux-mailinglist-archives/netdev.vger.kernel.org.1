Return-Path: <netdev+bounces-68882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B99848AAF
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4F21F24814
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE71878;
	Sun,  4 Feb 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bwlXnTLH"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90510EB
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707014152; cv=none; b=p/+e0cZnwYMOTeN0pmUO6nMcUgmNofJq7mKOaZiaJ2ZiF23n9aCgppO9c+kk/KMddfo0+A7KB9ozMQ0jDojjUAH5Qkxno8sLx2IM4dAEyw6nANDLAj8yLG/GSrqe/lrNa8k0dBidhKyTktoWKjojbtlPMUZAEowE8BUAZ6Tm4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707014152; c=relaxed/simple;
	bh=eXGrpUkM4UG4cBvAJQ7Qgo/L2pXhU3blLDwhWRms55k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlzIz2hDuPTGPPojOi3Lk4aL2+/TM+0puK5hOzow+Q14HWIg4qs3nKMVlBUIAGZ4NnbuFIf410j7GHFvXskgPeoM5MNFKPRlNMH9raSWv0eBjZbCoGHp1e3xgh4yMolhckB0HzLePOOZvmCzTpiJuNI4YHStUqBNwKMjhV3n3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bwlXnTLH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707014146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b7S8ENIwTw6+9bm+IefdHUPbMFwYSdb9IyEZNWuDgq0=;
	b=bwlXnTLHBbiARtjYG0PC/ic2kQthw/7x4CWl2f9jvhImeSZFCI9NAI7uk8QkKk+ev6OSyB
	RXp3HsUXJ9EnTkNIMBGAIg1vtq1zlhebAxQ2550ZDmOjNAoAl6X/AkoSUWc4Dqh3kncgPw
	mptpAmoAGFUTggvx4xNnw8JnyV0Cp8U=
From: George Guo <dongtai.guo@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: George Guo <guodongtai@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] netlabel: cleanup struct netlbl_lsm_catmap
Date: Sun,  4 Feb 2024 10:35:31 +0800
Message-Id: <20240204023531.2225264-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Simplify the code from macro NETLBL_CATMAP_MAPTYPE to u64, and fix
warning "Macros with complex values should be enclosed in parentheses"
on "#define NETLBL_CATMAP_BIT (NETLBL_CATMAP_MAPTYPE)0x01", which is
modified to "#define NETLBL_CATMAP_BIT ((u64)0x01)".

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
V2:
Yes, I understand what you are saying.
Actually, there is a compile warnings on "#define NETLBL_CATMAP_BIT (NETLBL_CATMAP_MAPTYPE)0x01"
which is missing parentheses.
---
 include/net/netlabel.h       | 7 +++----
 net/netlabel/netlabel_kapi.c | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index d74f21f528de..0d04a8ae3811 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -145,15 +145,14 @@ struct netlbl_lsm_cache {
  * processing.
  *
  */
-#define NETLBL_CATMAP_MAPTYPE           u64
 #define NETLBL_CATMAP_MAPCNT            4
-#define NETLBL_CATMAP_MAPSIZE           (sizeof(NETLBL_CATMAP_MAPTYPE) * 8)
+#define NETLBL_CATMAP_MAPSIZE           (sizeof(u64) * 8)
 #define NETLBL_CATMAP_SIZE              (NETLBL_CATMAP_MAPSIZE * \
 					 NETLBL_CATMAP_MAPCNT)
-#define NETLBL_CATMAP_BIT               (NETLBL_CATMAP_MAPTYPE)0x01
+#define NETLBL_CATMAP_BIT               ((u64)0x01)
 struct netlbl_lsm_catmap {
 	u32 startbit;
-	NETLBL_CATMAP_MAPTYPE bitmap[NETLBL_CATMAP_MAPCNT];
+	u64 bitmap[NETLBL_CATMAP_MAPCNT];
 	struct netlbl_lsm_catmap *next;
 };
 
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 27511c90a26f..7b844581ebee 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -610,7 +610,7 @@ int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
 	struct netlbl_lsm_catmap *iter;
 	u32 idx;
 	u32 bit;
-	NETLBL_CATMAP_MAPTYPE bitmap;
+	u64 bitmap;
 
 	iter = _netlbl_catmap_getnode(&catmap, offset, _CM_F_WALK, 0);
 	if (iter == NULL)
@@ -666,8 +666,8 @@ int netlbl_catmap_walkrng(struct netlbl_lsm_catmap *catmap, u32 offset)
 	struct netlbl_lsm_catmap *prev = NULL;
 	u32 idx;
 	u32 bit;
-	NETLBL_CATMAP_MAPTYPE bitmask;
-	NETLBL_CATMAP_MAPTYPE bitmap;
+	u64 bitmask;
+	u64 bitmap;
 
 	iter = _netlbl_catmap_getnode(&catmap, offset, _CM_F_WALK, 0);
 	if (iter == NULL)
@@ -857,7 +857,7 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+	iter->bitmap[idx] |= (u64)bitmap
 			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
-- 
2.34.1


