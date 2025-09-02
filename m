Return-Path: <netdev+bounces-219323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B6B40F82
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E775429A5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53735CEA1;
	Tue,  2 Sep 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMLjnBTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706F35A2BA;
	Tue,  2 Sep 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848994; cv=none; b=L76VDNSpiZ7Vxz/aPuVvEf7H+xFfECaPbPqrwYBijE1MxYrJZJ5uc2de73hn1TCuYu3kcjrForUC825DfkU/QnIkR5aRu6Ie+O6/kC3fsVTTdGMEg173cIhDGlsBVTk9zBTnxv28cwy3WF2Xp8sNOQGqzcd/PVE/8Flki234GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848994; c=relaxed/simple;
	bh=fdrJ2W7mBo4ScK0+ExdwCjhXZ7mjfmL0Ggt7KK74nGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeQXQFtV2yw4jALUndh4EErUSPUEJ9ju0oLE8fTTKNxVmTtmPPdoCdVgZuQCGSaTh4wHsiRlJcvCi6uKD5zza9hlu9oEvlyNu5MUihleS9DXUSSWAulxbdp0oOA0uPwNwG6KwkHqMKKEFkkLNXUtD5ZrFXmYSAIlDdUyW3pmrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMLjnBTu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051afbfso51054047b3.2;
        Tue, 02 Sep 2025 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848991; x=1757453791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=DMLjnBTu9tTY4bslRwWwVmJ9ytoKaXUhN7Yx8J3ErwR/e+ImlkF5MkjwiS5Hu2spmM
         RgypImw/Lfzd7JNyc68ym065W1hhS1g8vngE806zrfpDofCUxp1obWxcKuRcgXI56W75
         KIP2piRB/VaX7qZz6hLrgFHLehNjy34deXtEY+4jLlbgUxms9JhFA3kSScLoWO2qvtAM
         fty+IzdZDQAn9l8CutT13saRxKws7koXfacnY/8VZK1tQa09+6oQyiOdtURvHthVIGoT
         s1xFT05SMyBCgi1DbzKr4f8R/3vO4fFF7LwbebSh0/YeDJDoU65XLiJ2hGCrVytkgXAR
         9tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848991; x=1757453791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=BEywz8CONUgpRE61wrgTpMxxpee59rqSSQIr8YKEQE1NKcdlaqvrtDeSyxqD26UqhQ
         hngTKw69sfraHJB6suB5PgQN1znC93oG18jUhkw1ZlR3bAiAeZUYtFFswFtcc6nROfz7
         zR3/il/VE/mMGYU9mEJ/ExyxGel6UQunh+UlcUM+vxsOqdVc+dR/7IW8+VZlSoSiQYQd
         nYYA7dI5v9IP1XG2C2OiqRMICUxrwi3JdX28geB6HwdzAWF+28ZOZeEBYSSemlaIbVJ5
         wNwLH1T3qoNqdxxrgz7oT3yOGiwwtIFHbrVKLyCzApEb8eud/BuMxZmfG3KZT98Hk+Xd
         sO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV68VYoijIsRzoCd3zsvdMXweiaif29mqv3R6J4okhvuX2MuRAlRjkNfvrEO2f4N6vdfYnt6co7/Q6edi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDt6Siufafw1s5n3GZXhG2aYoFCPIOXy+2mBU1/FDpCmvh0Z5
	iGa0xck1LdSgvdmN2dawcrkOH6g3R5SHS4AWWuTqp4I2o/xvPDrAwzjw8abAtOXb7Y/8DQ==
X-Gm-Gg: ASbGncvPcBhg8U0SPxMQ2MHYlnTVS58BzFxI4zqYJj9EWoDlhpew7IJ5Qkjyd8HfL3V
	C69Rev8ejWrhNYGMGDUeth3xlpYQ/Fd7yiCkngNhVJcd0oEtvr2w3+6GmQaXKJycASPSqiLnTLJ
	0Y9wC06pQJLhIDN9Mfds/oY/oMf8rQPuyNcItGte9zg7/K3Cn55DaIhQUQXUJ2iqiZDifazlj9g
	0Bjb49Iwe+m2sHQO11GPg9byTQmTTVnxWDw2XHUWjuRHWnGvvl2cB283AY01K4aSYnZwq2Fugnk
	kysLVjWIxN6j5lkOLS6SCxevnph0q7OxfzVwjwf0hl+oiCSU8HAr5qj64qFGpulwTTmjPH2XLUz
	dnDZzAlQyoqHZylrz6wdQvB/XGqmhYESi
X-Google-Smtp-Source: AGHT+IHyJpIlYF9ANPLU+rz2KTwrmDh36UhiTNL/ooNr3MJ/3kVhcKvSodxLu1SJEb5ZcEJwsDoYoA==
X-Received: by 2002:a05:690c:8d14:b0:723:99e0:8edb with SMTP id 00721157ae682-72399e0c158mr74032667b3.30.1756848991271;
        Tue, 02 Sep 2025 14:36:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a831fcc6sm8459897b3.16.2025.09.02.14.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:36:29 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 02 Sep 2025 14:36:27 -0700
Subject: [PATCH net-next 1/2] net: devmem: rename tx_vec to vec in dmabuf
 binding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-1-d946169b5550@meta.com>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
In-Reply-To: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
This field holds pointers to net_iov structures. The rename prepares for
reusing 'vec' for both TX and RX directions.

No functional change intended.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 22 +++++++++++-----------
 net/core/devmem.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index d9de31a6cc7f..b4c570d4f37a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -74,7 +74,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kvfree(binding->tx_vec);
+	kvfree(binding->vec);
 	kfree(binding);
 }
 
@@ -231,10 +231,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -248,7 +248,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
-		goto err_tx_vec;
+		goto err_vec;
 	}
 
 	virtual = 0;
@@ -294,7 +294,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
-				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -314,8 +314,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -361,7 +361,7 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->vec) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -393,7 +393,7 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 	*off = virt_addr % PAGE_SIZE;
 	*size = PAGE_SIZE - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->vec[virt_addr / PAGE_SIZE];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 101150d761af..2ada54fb63d7 100644
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


