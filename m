Return-Path: <netdev+bounces-50669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179A7F69A1
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2039281378
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955D33CC2;
	Fri, 24 Nov 2023 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/TyGWxq"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBCA3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 15:59:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700783997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lsWV3qRFa6iQ1un0+vXx7QcSX+1weaN1DeztVeAMttg=;
	b=v/TyGWxqzp7MP21udfxhUYDV2Gqd+cUfQT92x0B6T6EOOmQhvl/m4XgA7Xpd95TxOpnay1
	AN3GuFJJTNw1v5EZNPyKRzaAWZisevycgIE5XfJJo6u7JSbPO2PdtDbE5I7t4wdp8iJmZ5
	+SCWnoWv1ryPUnwgdqHXNYXKR8iijl8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: netdev@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] rhashtable: Better error message on allocation failure
Date: Thu, 23 Nov 2023 18:59:49 -0500
Message-ID: <20231123235949.421106-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memory allocation failures print backtraces by default, but when we're
running out of a rhashtable worker the backtrace is useless - it doesn't
tell us which hashtable the allocation failure was for.

This adds a dedicated warning that prints out functions from the
rhashtable params, which will be a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 lib/rhashtable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..d3fce9c8989a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -360,9 +360,14 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
 
 	ASSERT_RHT_MUTEX(ht);
 
-	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (new_tbl == NULL)
+	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL|__GFP_NOWARN);
+	if (new_tbl == NULL) {
+		WARN("rhashtable bucket table allocation failure for %ps",
+		     (void *) ht->p.hashfn ?:
+		     (void *) ht->p.obj_hashfn ?:
+		     (void *) ht->p.obj_cmpfn);
 		return -ENOMEM;
+	}
 
 	err = rhashtable_rehash_attach(ht, old_tbl, new_tbl);
 	if (err)
-- 
2.42.0


