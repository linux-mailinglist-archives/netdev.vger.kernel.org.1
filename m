Return-Path: <netdev+bounces-12733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F00738C10
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32C61C20EDD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5B19BA2;
	Wed, 21 Jun 2023 16:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F441993B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:46:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58A1BCD;
	Wed, 21 Jun 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5w9pZnjuH0cui0+bbF2YOmmpAFWEgjcRmo7ue1AvTtQ=; b=jUfm5Cn2cwJWNOM2prgSqprGkR
	LmBwKRhuxKAUtr8BE0MWy123wKScLJoAtBpp0gWtFk3qBzdvXx83AHH41KrVC1zrHidgkWPuXbrUN
	WfjD0ZrDlse8jhsHm3mVGDt2m2kicLbSXaIYsdsLwQGBh+zoXbupr5MgiE7h5bsNCA2miJz2l/Fzn
	JGs/PkNFCac9dJLJDLKFksQrmKWOn8+imY/f0PkCnuqNBHAGKE/4jhmFP0h25e/UcAXoK54snBzmr
	ASDFZdUINRldKxUu0XLKMVMG+6bqx2IQgdu4zsWwH2B//OzYxwHJGhCgXv+2qTr4vXqFF+Ng3qqub
	1asVHOzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qC0y1-00EjE6-T3; Wed, 21 Jun 2023 16:46:01 +0000
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
Subject: [PATCH 07/13] pagevec: Rename fbatch_count()
Date: Wed, 21 Jun 2023 17:45:51 +0100
Message-Id: <20230621164557.3510324-8-willy@infradead.org>
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

This should always have been called folio_batch_count().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 42aad53e382e..3a9d29dd28a3 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -105,7 +105,7 @@ static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
 	return fbatch->nr;
 }
 
-static inline unsigned int fbatch_space(struct folio_batch *fbatch)
+static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
 {
 	return PAGEVEC_SIZE - fbatch->nr;
 }
@@ -124,7 +124,7 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 		struct folio *folio)
 {
 	fbatch->folios[fbatch->nr++] = folio;
-	return fbatch_space(fbatch);
+	return folio_batch_space(fbatch);
 }
 
 static inline void __folio_batch_release(struct folio_batch *fbatch)
-- 
2.39.2


