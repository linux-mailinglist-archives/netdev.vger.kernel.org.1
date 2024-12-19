Return-Path: <netdev+bounces-153213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653649F7340
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A2C1893D70
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069C8633D;
	Thu, 19 Dec 2024 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BSJ/lE73"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB61754B;
	Thu, 19 Dec 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577943; cv=none; b=PU1dFbOqqb3C+uapPOYS4U53+/2tkE23lDTGFRPYQhRlvb6bRJsTcwlmBpWU41CM/LDjUW0kWvc/WW9Mf8WyQAvZEQCS50Vw7EhG7NC2K5M5oWHHbwYhIIz8WSQD9Tn8QnLZdmbltUOi4zZccGsa4p/4WirH52TrzqQyNIb7id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577943; c=relaxed/simple;
	bh=o2rluJOejY3fIMlZmcg+lb5/E+OJoLqdkVy4F6hIBng=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oySjKHrxqq7iFVuyl3vzVkqlMFS6qgodteJJwnEBSSsA6CV5FtRVnciV/eguNxb8HgldB01Lt2ZFHjsfbwYgas+5JNuSHPEfnG2Nx7wOYpCMH+GY1aB1y7tx4xioW0pwnw5boUt6guEeleA+dkayEnAzCpcEUpiniQjdiViSs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BSJ/lE73; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1734577922;
	bh=lfdgkWbHqjIjc0L78/mI4rC+k0gs8aD4PwQ1zsrjhrA=;
	h=From:To:Cc:Subject:Date;
	b=BSJ/lE73/7xuRtOQ1gC2az0NGK/hDbqCeQYvYOF+gkaC33wo5yb7GW8CLtglykCa4
	 YFQB5E2fxIpLpB89y3i6EPSmCBz71ccEIyrYSEHjLVBvXsxxvaYFUjAphY74KpvXQ1
	 SRpAjsMEZP12+fD+Ej+sRHzyga15Vev2DN4FkuOA=
Received: from anakin-virtual-machine.. ([2409:8a1e:99b0:9140:f7d6:ee5e:2399:3a52])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 2FB20EB0; Thu, 19 Dec 2024 11:11:59 +0800
X-QQ-mid: xmsmtpt1734577919tx84oz3uo
Message-ID: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
X-QQ-XMAILINFO: NAU3xrec257RVV7jmeJwebjn6N9gr++Rzvc1ip+tlVtWkBgUeG0XWHLVu92OZT
	 E7y2uebwJVKC3Cpdtj/TSEq/eUB9tU0xBqGlkE0p5nRNjC/bQKy0myMdyq0JhvDzMj6IeVQqJTAd
	 oMGYmR1F8Khh4tYZstqGEMTk/uEIyaQBytVUa4ZXPiIo/dM+VLqROKMEqP8LZsnqAy/oWOko8W5t
	 gKOOtcIqZIwTo7P8O49DqqwoOavwAMof22pz94eji+hw8LPnJKsU+j5wN47lqQ/l64u3WXbGij7P
	 3dcewn52DiSYMZPWhkDkeDauAFYaQrrjNlmhDmASBUGqQ65iq3i9SzhTPtlyjU5kySYOu5ds3cNi
	 Vk0Yzv9nbuwnwnjT6vEnMDbFC+dG5AjKJEqItUBrJVV52nwenEJe6IeHbkJZ40DHXbj9b7JxSysr
	 KIi6Nj1SuW5jL/k3ztzkYYiLPQ/AzVBjp0+Da2TuEJTJgOw+nTWUuRhcWZwOr7jA94Jf9K+DL7dO
	 rpbW62hNjsljQKDlyeymhZAc7WSLVj7HJiOUE1G2FGbewz/hwDZtnFB/EurA9UZAbEz57KFfStcX
	 CFSyAprDYjFJkqlAO0zKepbgeKMhewhLsVQzXpzWLtBOgOzh6zA7MVNPXvnY5cRlvrjynyDGBFDw
	 PCwA4DBjPu7leV0i51o4En2y172HMsCIu4WLFJ5jJlU0g7bnLrn4RpNA8tHd5ZZ21Glg4IyrYXIU
	 vkpMls/edPou7eUu1atD/sQrC6sILhf5XL3CEDgiKWRizzfxv7HnGjfNhi5czZaXMYdbudZJTEdE
	 0kIIAttorZ/4kKr5XnNhjc/+78dYhSzf4f1UmAuAg/cIHarTMqoScp2RdQUDIZ+RnG2aN88i90IS
	 Itu/4IJXHxdAQTffNutKJGB1wmt1KBKoTI4lrXcOEwkQ188+vDPeDht5ua+joQ+ALqfE8TkmwhYU
	 x6AuJZQVWXS31828M163Fjr9KJGL+I
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Guowei Dang <guowei.dang@foxmail.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guowei Dang <guowei.dang@foxmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: page_pool: add page_pool_put_page_nosync()
Date: Thu, 19 Dec 2024 11:11:38 +0800
X-OQ-MSGID: <20241219031138.3759922-1-guowei.dang@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add page_pool_put_page_nosync() to respond to dma_sync_size being 0.

The purpose of this is to make the semantics more obvious and may
enable removing some checkings in the future.

And in the long term, treating the nosync scenario separately provides
more flexibility for the user and enable removing of the
PP_FLAG_DMA_SYNC_DEV in the future.

Since we do have a page_pool_put_full_page(), adding a variant for
the nosync seems reasonable.

Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Guowei Dang <guowei.dang@foxmail.com>
---
 Documentation/networking/page_pool.rst |  5 ++++-
 include/net/page_pool/helpers.h        | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 9d958128a57c..a83f7c071132 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -62,7 +62,8 @@ a page will cause no race conditions is enough.
    :identifiers: struct page_pool_params
 
 .. kernel-doc:: include/net/page_pool/helpers.h
-   :identifiers: page_pool_put_page page_pool_put_full_page
+   :identifiers: page_pool_put_page
+		 page_pool_put_page_nosync page_pool_put_full_page
 		 page_pool_recycle_direct page_pool_free_va
 		 page_pool_dev_alloc_pages page_pool_dev_alloc_frag
 		 page_pool_dev_alloc page_pool_dev_alloc_va
@@ -93,6 +94,8 @@ much of the page needs to be synced (starting at ``offset``).
 When directly freeing pages in the driver (page_pool_put_page())
 the ``dma_sync_size`` argument specifies how much of the buffer needs
 to be synced.
+If the ``dma_sync_size`` argument is 0, page_pool_put_page_nosync() should be
+used instead of page_pool_put_page().
 
 If in doubt set ``offset`` to 0, ``max_len`` to ``PAGE_SIZE`` and
 pass -1 as ``dma_sync_size``. That combination of arguments is always
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index e555921e5233..5cc68d48624a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -340,12 +340,14 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
  * the allocator owns the page and will try to recycle it in one of the pool
  * caches. If PP_FLAG_DMA_SYNC_DEV is set, the page will be synced for_device
  * using dma_sync_single_range_for_device().
+ * page_pool_put_page_nosync() should be used if dma_sync_size is 0.
  */
 static inline void page_pool_put_page(struct page_pool *pool,
 				      struct page *page,
 				      unsigned int dma_sync_size,
 				      bool allow_direct)
 {
+	DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);
 	page_pool_put_netmem(pool, page_to_netmem(page), dma_sync_size,
 			     allow_direct);
 }
@@ -372,6 +374,21 @@ static inline void page_pool_put_full_page(struct page_pool *pool,
 	page_pool_put_netmem(pool, page_to_netmem(page), -1, allow_direct);
 }
 
+/**
+ * page_pool_put_page_nosync() - release a reference on a page pool page
+ * @pool:	pool from which page was allocated
+ * @page:	page to release a reference on
+ * @allow_direct: released by the consumer, allow lockless caching
+ *
+ * Similar to page_pool_put_page(), but will not DMA sync the memory area.
+ */
+static inline void page_pool_put_page_nosync(struct page_pool *pool,
+					     struct page *page,
+					     bool allow_direct)
+{
+	page_pool_put_netmem(pool, page_to_netmem(page), 0, allow_direct);
+}
+
 /**
  * page_pool_recycle_direct() - release a reference on a page pool page
  * @pool:	pool from which page was allocated
-- 
2.34.1


