Return-Path: <netdev+bounces-25143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26937730D8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4DA281A49
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6B174C8;
	Mon,  7 Aug 2023 21:00:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47604435
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A638EC433C8;
	Mon,  7 Aug 2023 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691442054;
	bh=xyhc7uYOwR1uHTjuKhwupluWcp1R6kmDB0U4P1Hz5i4=;
	h=From:To:Cc:Subject:Date:From;
	b=JsjlTf/qesJUj7RmbTB1W8LwqN2klTMsbTWXQw0UIfa2gEYxl+3Ti/nAQNNOFhnJb
	 Z4RbmywV4o1J4MqPrZlUy5PBs66K9lDrqqSIyEy663O6I81AQvFcs2OfzZIoBIPzfB
	 uwG7UUgz22JAGZRMHv0wbIdZaky5sYsjqTVWWJdC65wzXNr5qN39ufsRB+Ksdp7Vcy
	 8+Xj+I+8+ROdP6WidnNCXf7fCGSGl/04E8F1OOD2L1nZmgcczIeq8j+14V0iAf4vV+
	 ZJ1aJzUmAT9lLcWkvofzG53uaE4ecbbJ6l4/ue2ABN9Tv8FLwnO32UrBseKLVzDdqs
	 XLyGkyUfDSlVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: net: page_pool: de-duplicate the intro comment
Date: Mon,  7 Aug 2023 14:00:51 -0700
Message-ID: <20230807210051.1014580-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 82e896d992fa ("docs: net: page_pool: use kdoc to avoid
duplicating the information") I shied away from using the DOC:
comments when moving to kdoc for documenting page_pool API,
because I wasn't sure how familiar people are with it.

Turns out there is already a DOC: comment for the intro, which
is the same in both places, modulo what looks like minor rewording.
Use the version from Documentation/ but keep the contents with
the code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/page_pool.rst | 18 ++----------------
 include/net/page_pool/helpers.h        | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 68b82cea13e4..215ebc92752c 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -4,22 +4,8 @@
 Page Pool API
 =============
 
-The page_pool allocator is optimized for the XDP mode that uses one frame
-per-page, but it can fallback on the regular page allocator APIs.
-
-Basic use involves replacing alloc_pages() calls with the
-page_pool_alloc_pages() call.  Drivers should use page_pool_dev_alloc_pages()
-replacing dev_alloc_pages().
-
-API keeps track of in-flight pages, in order to let API user know
-when it is safe to free a page_pool object.  Thus, API users
-must call page_pool_put_page() to free the page, or attach
-the page to a page_pool-aware objects like skbs marked with
-skb_mark_for_recycle().
-
-API user must call page_pool_put_page() once on a page, as it
-will either recycle the page, or in case of refcnt > 1, it will
-release the DMA mapping and in-flight state accounting.
+.. kernel-doc:: include/net/page_pool/helpers.h
+   :doc: page_pool allocator
 
 Architecture overview
 =====================
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 78df91804c87..94231533a369 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -8,23 +8,23 @@
 /**
  * DOC: page_pool allocator
  *
- * This page_pool allocator is optimized for the XDP mode that
- * uses one-frame-per-page, but have fallbacks that act like the
+ * The page_pool allocator is optimized for the XDP mode that
+ * uses one frame per-page, but it can fallback on the
  * regular page allocator APIs.
  *
- * Basic use involve replacing alloc_pages() calls with the
- * page_pool_alloc_pages() call.  Drivers should likely use
+ * Basic use involves replacing alloc_pages() calls with the
+ * page_pool_alloc_pages() call.  Drivers should use
  * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
  *
- * API keeps track of in-flight pages, in-order to let API user know
- * when it is safe to dealloactor page_pool object.  Thus, API users
- * must call page_pool_put_page() where appropriate and only attach
- * the page to a page_pool-aware objects, like skbs marked for recycling.
+ * API keeps track of in-flight pages, in order to let API user know
+ * when it is safe to free a page_pool object.  Thus, API users
+ * must call page_pool_put_page() to free the page, or attach
+ * the page to a page_pool-aware objects like skbs marked with
+ * skb_mark_for_recycle().
  *
- * API user must only call page_pool_put_page() once on a page, as it
- * will either recycle the page, or in case of elevated refcnt, it
- * will release the DMA mapping and in-flight state accounting.  We
- * hope to lift this requirement in the future.
+ * API user must call page_pool_put_page() once on a page, as it
+ * will either recycle the page, or in case of refcnt > 1, it will
+ * release the DMA mapping and in-flight state accounting.
  */
 #ifndef _NET_PAGE_POOL_HELPERS_H
 #define _NET_PAGE_POOL_HELPERS_H
-- 
2.41.0


