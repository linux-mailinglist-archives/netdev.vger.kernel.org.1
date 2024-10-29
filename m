Return-Path: <netdev+bounces-140116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BB9B5462
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C4A1C21389
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0025A209F47;
	Tue, 29 Oct 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLWDT5TG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD520969B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234754; cv=none; b=Z/yRYTrPsEGVlFpemEGSUnNIn995niN1LE7hIpcnW/OGkPODttQJGdkbX7gYLgBjwqeowfeInDLTChosNY+SbEkvUI1/5MnFMZ1X7QBTaxyEcbao423h6hCjBlvVdtoc4Ce5ZlYZ+KfKVbflUICJtya4K/tO7sCakEKaYWFk/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234754; c=relaxed/simple;
	bh=6eTzR/9ZOnj5CYN8SmYXPKii2L+YcvUeqGgZJmywDDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EK/acgfg8dNZoRL6aD6S26cKItjBIxu6KLxtq7LmJ7RFPRQxgIQZBC37/AZ/1efFHv8nNictzQPAqGz+dKq+ivomCYxdzoyq5JOgTp9vqKfYBHkxxd68IsHJBPNtIY9KIhuZLv7K43cC9KmYk5Ib+a9EL0ygfkUKhnn0Fjuz0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLWDT5TG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a7ca60so1242639276.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234752; x=1730839552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWvEuGXnU27PXRSp7zy0hKeJv9z9WHLclRxJOt6bNk=;
        b=JLWDT5TGrTXJ8jpHQp59sfhfFyiJzlVBaq+Tc30SkEPsRaNfzWw0r+01ild5la3tSs
         YRhPY6GsCiMOSoJRdwnyWahtl6/LOv+r3V0LLsgHm7z3Y74Ccavius8QEGK6MvjcOAo+
         1C5m2Mj5NfJevwd/4e3BXCDPs7IhnPakgYvHMAjSyPvQj+3X22A0KtzJu31nH5DoQ3mL
         tMwjp+XIRfAh+P/fbWu+b5dLw+/3cxZXYeZbK1SCgNJXYmRr8NgohLqH5GO6btNNc2DC
         Id10C7m7O4lOlqpFKQi9tFK6YIXSb+o15QATOqbnPpRaszeQIHeOAaMrgBk9O/WojsuA
         MDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234752; x=1730839552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWvEuGXnU27PXRSp7zy0hKeJv9z9WHLclRxJOt6bNk=;
        b=iljHlAWXnMNIjEtjaBTra2OAOxjMlJvzXWdrn92TBAmXt9YOpoR9nYt438gPsuWQQJ
         B3ccrj8r2jY7Auyb/oTJBD/vAn70MDzV0p861OOtWQeWLX/iDVQaOgFw5sGLZ96KTJlT
         BtlhjSzngwFeUxHRyuO3+wpGjv1rgt+3lfjPTNaEJwHphGGv5DNpHrvUQ0oACR7MpWdj
         Kscspn7EkY9EHkcs5FVTqY68KGvTx90VX+cfPCI7H9x5sGxc7LEd/XUO8QTK31oxQVK6
         aEFsv9Dlg/ZXkifK3LFpGgUBWqyzsLuUDOBcBnhVQHFUJ42S+0q1d+zw+KDc1QPZbS8O
         cexA==
X-Gm-Message-State: AOJu0Yx5mZHs46pQYcp3vkmWhzkHKhhwFWjAgqs/h5xACCRzcZ3zFZDo
	G3HZAfnbJitA36BRuLarQFw9Ylh+rhENYx2Wu8ENnw1YfOjpQGXYt0m5XLWX2QBqbk1PBD9tGQ2
	btX+gWgL+qZskMP0rW7oY8Alnhq9upbETMGnKIpdejxSSJ7y64QIrQle5kXni7adsNJp1A48ALa
	7hB73YYNxAclzXslyvZHnN4Z7thrSCH7fxPx+w/sNwTl8fat4bO8ub4bzebF4=
X-Google-Smtp-Source: AGHT+IH9DOKv8lVSkF/qC/v3j6pptyY01q0mblnOxpf7Wr+4mvSOn1+/x8RXmICWDZSdFxzfx8BIVffTqN0qBKCV1A==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a5b:bcd:0:b0:e29:b6d7:20e2 with SMTP
 id 3f1490d57ef6-e3087736bf6mr83545276.0.1730234750854; Tue, 29 Oct 2024
 13:45:50 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:38 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-5-almasrymina@google.com>
Subject: [PATCH net-next v1 4/7] page_pool: disable sync for cpu for dmabuf
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
its the driver responsibility to dma_sync for CPU, but the driver should
not dma_sync for CPU if the netmem is actually coming from a dmabuf
memory provider.

The page_pool already exposes a helper for dma_sync_for_cpu:
page_pool_dma_sync_for_cpu. Upgrade this existing helper to handle
netmem, and have it skip dma_sync if the memory is from a dmabuf memory
provider. Drivers should migrate to using this helper when adding
support for netmem.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 8e548ff3044c..ad4fed4a791c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -429,9 +429,10 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 }
 
 /**
- * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
+ * page_pool_dma_sync_netmem_for_cpu - sync Rx page for CPU after it's written
+ *				       by HW
  * @pool: &page_pool the @page belongs to
- * @page: page to sync
+ * @netmem: netmem to sync
  * @offset: offset from page start to "hard" start if using PP frags
  * @dma_sync_size: size of the data written to the page
  *
@@ -440,16 +441,28 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
  * Note that this version performs DMA sync unconditionally, even if the
  * associated PP doesn't perform sync-for-device.
  */
-static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-					      const struct page *page,
-					      u32 offset, u32 dma_sync_size)
+static inline void
+page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
+				  const netmem_ref netmem, u32 offset,
+				  u32 dma_sync_size)
 {
+	if (pool->mp_priv)
+		return;
+
 	dma_sync_single_range_for_cpu(pool->p.dev,
-				      page_pool_get_dma_addr(page),
+				      page_pool_get_dma_addr_netmem(netmem),
 				      offset + pool->p.offset, dma_sync_size,
 				      page_pool_get_dma_dir(pool));
 }
 
+static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+					      struct page *page, u32 offset,
+					      u32 dma_sync_size)
+{
+	page_pool_dma_sync_netmem_for_cpu(pool, page_to_netmem(page), offset,
+					  dma_sync_size);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.47.0.163.g1226f6d8fa-goog


