Return-Path: <netdev+bounces-250443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754ED2BB83
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C552330115E4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F934B190;
	Fri, 16 Jan 2026 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzDqk8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8D348895
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539802; cv=none; b=R/SuV+wdHlyI8CyZLFr7+k+1NqoT7ZGQq+pIkI4fYIOD1+12YKmLOHoQDwojjPAlU6EsBP8euNTy0dV/Xlc1/iMVIaJ1qI2KPAFZrMxxU7n04UWW3QNMkcGrcGbYQNymkuDA+56yX7voN53eAxM0EFjZj5aWKno7FHwJeoXYUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539802; c=relaxed/simple;
	bh=QnAdtI5+4DFmxFeKdHgtB5jd0gU6PEbg0bZ2tI0AuZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jell5ChC/67N5ytURL6PNMFNR1mVxM3IUW3RgkaWJzVz35fICfUec2C7i5NH2lEwfqsGfL12QZiKMRS/MKZyJMOga7LUuYzaByVRy4FCp4rxp9cpiOUzwxanKRi8qT24kAmwCEBC7pS+GZyXB6fjRPhkIkaRkfr7tyn38Vqo4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEzDqk8S; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7927541abfaso16557697b3.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 21:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539798; x=1769144598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=SEzDqk8S9FbFi4okuM3QhTEkgb1CvBaR8TdX18wRjKo3y/8v+5mIWiVLIRsTys8hQ+
         Fxp29xgE5cu9G3CTO1dnoKauUbaJ6Fsxvp1yfjRf8DFi/5+iAa46PLKBxJh51Y9VkGox
         gJ/IqdV/BucrfCk+Lh5nOQGK2Y41f1XyPzodQ6iCoT8i5pbxo9y8lZ0z9y8Ya2V9SPxP
         FsNUTItvBPFo+XRoX8QfbbjxH3INN+I/j29YOREy248d5eTLufj2nHJzPxm+w9OPOSCX
         BGzzp3I6cKfuy0weAzH2e+9xe6ZQ8MmQD+idbQBfpdsS7g0Fy/25U8+unSGMCc49GhoP
         iZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539798; x=1769144598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpPfAIHBzai3/e/zMri/UCW5j7V8nMCJkbV5OCQGhRA=;
        b=rWqQjAXAgSDTBlPeGuHu4QPDarUMur5PisAbcXUPNhKb6ITvxbxBA7zPU4bctJSk2C
         EqPfy3Cjzt15tnWu+d6HjzdRZcAMlDW7cCf0kmw/KXr2LRiLKDi6YChdjuLVtJfA8TXW
         bOxn60G2jboG6mPfMCbHVo0KN8z2rrQzesOlrvLHq65zT2OiSQOoOiV3bs40oAG1VO8f
         3LkSVT326MuX+5HVPeik4d7Q5EHVh6XUvdUw8PLxq38uHTfQ3qf2vjgzevYIRFaIdLd0
         p1IFasi7nVXMhp10Dtat4ZrLodokaRZsceQnHRTD4xGb0l630B6WkByLPpblJlu4sTQG
         vLJg==
X-Forwarded-Encrypted: i=1; AJvYcCUgjLCdhD3LLhm2sQfEd3Y1YRP7qW/EW4fZ5RLsVzrRQQqiNfYY1uXE+CPNw7kqqa7OrAWs7b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurOXnfgxKBdIK5DgOWNUtMK7Y4X5TicYMgTmpJDnf04FmdCHX
	0ATdiL+O4khmt1Y+MUILinc7F0p+hFUKCqSU7rEXNTu9byMzMx9A8ZeW
X-Gm-Gg: AY/fxX74svaJUqHCubiwLNv/Go3MNjFEnoUQGLcju6BCtPoldXH1yibB71cfuhp0PGA
	puPh0/F3Qqx3LtSXwaYXgmrwYXerEGJUkq0Sz0zAKU3EJhFmDnUfZbvTnHmDmOeeltdFwYnMo80
	kVKocHNqvU2kz8SBO5eItP+Em1XKbPUkuavivD6VxkFb8jL8EagBuLQon1nyg2fMsVcaSo/+z6I
	EavFt2/tBaoP6xnPCG1nIfYt5JjFv/HGUpr2nYEW2FJroXtvJGmb0pd46FYbbLwsyPP6m1Nqs3u
	yhICiKopTJYIwiSqiF2cTOlyfff3vclDzDe6itlXXy+6J7amQrDiZz2PefUXkAkR9eoITV6xX2C
	h5+QRJLNQpHXtncEioMTxV3rGSfPdQaghWVgV2/55MLytwKFMHD/R17GYcLZoo/eIVaIeDZwUWa
	7MHiHwlT2S
X-Received: by 2002:a05:690c:6f10:b0:793:afdd:e63e with SMTP id 00721157ae682-793c544d6ddmr17343937b3.33.1768539798065;
        Thu, 15 Jan 2026 21:03:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c72aesm5327037b3.11.2026.01.15.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:17 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:12 -0800
Subject: [PATCH net-next v10 1/5] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-1-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 185ed2a73d1c..9dee697a28ee 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,7 +85,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -246,10 +246,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
-		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-						 sizeof(struct net_iov *),
-						 GFP_KERNEL);
-		if (!binding->tx_vec) {
+		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+					      sizeof(struct net_iov *),
+					      GFP_KERNEL);
+		if (!binding->vec) {
 			err = -ENOMEM;
 			goto err_unmap;
 		}
@@ -263,7 +263,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -309,7 +309,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -329,8 +329,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 	gen_pool_destroy(binding->chunk_pool);
-err_tx_vec:
-	kvfree(binding->tx_vec);
+err_vec:
+	kvfree(binding->vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  direction);
@@ -379,7 +379,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -430,7 +430,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2534c8144212..94874b323520 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -63,7 +63,7 @@ struct net_devmem_dmabuf_binding {
 	 * address. This array is convenient to map the virtual addresses to
 	 * net_iovs in the TX path.
 	 */
-	struct net_iov **tx_vec;
+	struct net_iov **vec;
 
 	struct work_struct unbind_w;
 };

-- 
2.47.3


