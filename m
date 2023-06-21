Return-Path: <netdev+bounces-12742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27F738C41
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB091C20F14
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB11B8EE;
	Wed, 21 Jun 2023 16:46:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C319E50
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:46:25 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53169E9;
	Wed, 21 Jun 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jTDGdnu+fG/6kslyclH2srz/sHr6MJEFetnoOEAqThE=; b=J7syLfgLtqZEvF+FaGdNCpIxYK
	FGrBsHrwiUgwuOgUEvOX2i7PWXG/ZXhqiAhW6CpfyR4l4rDqNGULpmdUDJAIMFqrXnlWMyJuuuQew
	CRIwuxDz6BodPG9A2vL0dc3r9jSUjJ096kbZOKhyXbwTEF5WnPbOv35W1YxmyI5xeO3eW9SZeu6Ui
	elEI4SaI8VG431yTXK/Agfd1OvARTxSno98kcl4XPxpk7V8Q46NmOwcGLYx7LMoOCYaku65I0hGaM
	vfxZSH7R76ZxcVPpw10enxxDEKsn/iEIr1hxmLFS6RNnFgRQiKGzIC7i3HzHCE4ZskLC1FZi9nT0k
	4UQzvpAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qC0y1-00EjDk-FK; Wed, 21 Jun 2023 16:46:01 +0000
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
Subject: [PATCH 03/13] scatterlist: Add sg_set_folio()
Date: Wed, 21 Jun 2023 17:45:47 +0100
Message-Id: <20230621164557.3510324-4-willy@infradead.org>
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

This wrapper for sg_set_page() lets drivers add folios to a scatterlist
more easily.  We could, perhaps, do better by using a different page
in the folio if offset is larger than UINT_MAX, but let's hope we get
a better data structure than this before we need to care about such
large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/scatterlist.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index ec46d8e8e49d..77df3d7b18a6 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -141,6 +141,30 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 	sg->length = len;
 }
 
+/**
+ * sg_set_folio - Set sg entry to point at given folio
+ * @sg:		 SG entry
+ * @folio:	 The folio
+ * @len:	 Length of data
+ * @offset:	 Offset into folio
+ *
+ * Description:
+ *   Use this function to set an sg entry pointing at a folio, never assign
+ *   the folio directly. We encode sg table information in the lower bits
+ *   of the folio pointer. See sg_page() for looking up the page belonging
+ *   to an sg entry.
+ *
+ **/
+static inline void sg_set_folio(struct scatterlist *sg, struct folio *folio,
+			       size_t len, size_t offset)
+{
+	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(offset > UINT_MAX);
+	sg_assign_page(sg, &folio->page);
+	sg->offset = offset;
+	sg->length = len;
+}
+
 static inline struct page *sg_page(struct scatterlist *sg)
 {
 #ifdef CONFIG_DEBUG_SG
-- 
2.39.2


