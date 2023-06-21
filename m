Return-Path: <netdev+bounces-12741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1512738C3D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187792816F3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC61B8E1;
	Wed, 21 Jun 2023 16:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFF19E50
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:46:24 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4419BE;
	Wed, 21 Jun 2023 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KFMiCla2naG7Z7vKPwGKVD4TrVn4emFE0PLxxevs+7o=; b=OU4HmcXWzyUGQD65hDOdwkgu0o
	u74l9DMZxcBXT5V4Z5qLLe5pROXO6krjW5ruc1DT0SkscC1GAv6CUiRHqoT/xZNB+FTYdY7HTZcSC
	1nPv6XnNmEo7hrUJxM01iosMG8Y0Ym2VcY6jvvzCBkvQC7lZJfWEJjt8YGSGMlqEn7izRDRm51hz1
	GMTsyqcMH1J1dyYFMGFeU3Saag7AZyuOX2CkLBm+3ksa29C3VbudjYZzIgY5yxIiJcoHDGi0dytI4
	BSi9r/ik6bNx2dBlS0BKcqh1/yQ1YIwWVl75bC6VUoMpy4h0Khgb2dDFrfbmsM3CyCJYXba2lPTTt
	z9KQ53Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qC0y1-00EjDi-Cc; Wed, 21 Jun 2023 16:46:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 02/13] mm: Add __folio_batch_release()
Date: Wed, 21 Jun 2023 17:45:46 +0100
Message-Id: <20230621164557.3510324-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230621164557.3510324-1-willy@infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This performs the same role as __pagevec_release(), ie skipping the
check for batch length of 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index f582f7213ea5..42aad53e382e 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -127,9 +127,15 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 	return fbatch_space(fbatch);
 }
 
+static inline void __folio_batch_release(struct folio_batch *fbatch)
+{
+	__pagevec_release((struct pagevec *)fbatch);
+}
+
 static inline void folio_batch_release(struct folio_batch *fbatch)
 {
-	pagevec_release((struct pagevec *)fbatch);
+	if (folio_batch_count(fbatch))
+		__folio_batch_release(fbatch);
 }
 
 void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
-- 
2.39.2


