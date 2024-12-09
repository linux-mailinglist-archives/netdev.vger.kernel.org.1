Return-Path: <netdev+bounces-150295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484DA9E9CF4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236E22805F6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECC1E9B1A;
	Mon,  9 Dec 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHJs3bmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B441C5CB2
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764999; cv=none; b=A2BEHVaiXWSym7cMVtsM41fg6xDXkjmJjO65o7NLsc5zdCrmTuWLWqnbbgnnsaJfEpek7k2FeBuuHiuY+LbCPHQpvGTRQNCJJA58B+Bps9OJPY7uFlVy1xE7rNGGnpZ+LuEcQfcio96zmRfM3RdeaVmp3hAouonxLQtBFkK7KFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764999; c=relaxed/simple;
	bh=y+0q7ecX2wfaSQV7x9AchYm6ieZy/G+mBf9VGu8ONlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJhRsTbYZH0S9Znfkk3crsW0koL9jcVW7J+NC/X1YO2gUwdv3p18oHjbF4jWHwSBUFWLdmSqVbpwcsFvWa5BbVzePKChRsnqHvm+Zh/aX3y115n6FWBT5QLHzd2feM+55yQTD7oJZapcTRBN8VIPKn9KMZciE8M5JksPPlZqFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHJs3bmg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fd4ea959b4so1206791a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764997; x=1734369797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEh1qYJ/M3HaDxH8qCrcRAqwO6cCUt0cVdPWB5Prhx0=;
        b=SHJs3bmgl2cB0JZqcqagGJO+E83vGRMPHyZG396n7NfZhMrxm75zhkKmyG7g7x6S/O
         9TYRUXScKSVuQ+c7/I4DE3PU5Q4N4136scn87HtHjS25KS/ClfHXQT5CC1EdBavib7zR
         BMF81G/Q6Exo8wbmxFVESFbQRwB+xnv9z89OXlvHQPOTPtA9ulmeWamG+wmZRqV4pXKi
         TUqXcXQA39SAO3vhXSKpgSy5LNywLask9SEH7epCnAoTp6JdpY6W2IAWCZOBU3lFxTfK
         U2sat8PyrZa8NvPxPXb5d4RLC6WSfsVElWeYOg1uA5S05xuXRUDO83m3p+DzU1QelYEJ
         KJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764997; x=1734369797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEh1qYJ/M3HaDxH8qCrcRAqwO6cCUt0cVdPWB5Prhx0=;
        b=Bb31cfIA0TH175Xk5IcfGFM3axKIxSA8Ex6U4PkBl39zestwh7UQqXXfdInWDX3QE4
         E3FhnzCfsHN7Pf9AsCkL0DW5KD+VJm5ECZes8hgdH/c60YTLfrh/y6hBFmUk1O3tiNN6
         WPQH/IUhI4WT5pcn//vCT+6BiS//btw5gAJvmS0wvd3UFRynNCeGlAXZedrOy5RhCMeX
         qI7q1LkgCyYYXJaCQvjinNTvEEwL1r4S0cIpB3HjROte2v8R7PrAdnXvofoSMWVEorts
         95vR/Zivi6ARW6Jodka0Dks2MAGLQV+hxKkrd3QLR4zh9rUUJZ2PY8zqbbM/z5Dj27Gk
         L9KA==
X-Gm-Message-State: AOJu0YycGHww/60RpuOo5CXqCGaPRAxkHSkN5Trqndpb4zLOs/kWLUmA
	JLqU1b8qzpzkSF6cN7Zr4REdbWK+dnMy87k8wLvp5YW8l+n6npz+JHMUME6wmvEau9nUBxw9903
	XKmInPcQs6bw90E2VNwZqzyyKiJu5O1o/b91YTJbez2rAcxaHkhy0lS9FCG6u0ZDmP618vBNFVH
	eyWkwUEKtkG+mT1xAJ1gslL+ixXtegyrnflouPYymGiPVM0reQ4lyjKWd1Nmk=
X-Google-Smtp-Source: AGHT+IE6zUeqCaOyPCPklZj3KhVRjOXzVz21jDuksCVu1g7fyKjAxUFvqujb6+uRlACw/CE7XgWaGIQwyzBhd7b9wQ==
X-Received: from plru4.prod.google.com ([2002:a17:902:b284:b0:215:94db:1290])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2447:b0:216:3d72:1712 with SMTP id d9443c01a7336-2166a0a0bb1mr18781945ad.48.1733764997374;
 Mon, 09 Dec 2024 09:23:17 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:07 +0000
In-Reply-To: <20241209172308.1212819-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-5-almasrymina@google.com>
Subject: [PATCH net-next v3 4/5] page_pool: disable sync for cpu for dmabuf
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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
2.47.0.338.g60cca15819-goog


