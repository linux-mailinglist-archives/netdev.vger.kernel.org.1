Return-Path: <netdev+bounces-232260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5FC0379D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E3C1A64F87
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146C285C9F;
	Thu, 23 Oct 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ3eZKvR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F38280329
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253234; cv=none; b=YNLnM40vW3zYmOmWni9ieFWkeB02tZHw9LsMFWVmkDI+LQvbBCDAfc+GP40pZXAs1PrWOsSVMULktNyJV6R/NXeEz1+nhei6CM5TyYM/Z6PyTwEOJ+3qJ5h/5KWqvlS/osFHgqqxIK3UeqKGt5BLmtqI6G8UiwB8d+vyrNHKoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253234; c=relaxed/simple;
	bh=fdrJ2W7mBo4ScK0+ExdwCjhXZ7mjfmL0Ggt7KK74nGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCe0w+6Ce742W3ngLu6Ql6oRbKSeTDparJln6vLiFajSQSiFmJ1pF+FexlX9SljkLWNOpsYVy1k6s6D2Q076+tzTutujDNNqxZPE/KcJ0vmTGn6vH/b5XI1SA3eW7KdVb2ONcjs6CurnnD6F7eUJ5mnWe+mmi8zt8xTJBz74FFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ3eZKvR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-784966ad073so16923427b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253232; x=1761858032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=kQ3eZKvRsBKY5XC/POQc7DD156EHCuzDEgNAAbQ1B1cG/1b7gcFuZRF6glX3VG3PE8
         /hCUJ6i1yaCvU/SWZxTx2eCC89gOzosFVk5Ul2x5J9BMBJgWDv0lThMDnfzBiYmALuf6
         7fNzodT0F8SevgSYss/rOkXqNQBUW/pbQcALa91JkQ8LVExvw0lx0ihF+KnPAK6VyeJJ
         BW3L8J++emFpgpMAdnx4j2pviUIpmwUKmmJNUnmYHS69637o+KG8rjn6tLMqR+zYQdWJ
         S6rsPGLU2HlxXNpdYo/w/HNBDg0uQTdKObTxaZEhQOc0bHSYcqRffVL+ooWgKL2j6W+G
         +B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253232; x=1761858032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=vgGdeAh7uDbm+/ZUbt4/zncs6PDfrJh6omP84CqKkxtFa+PQdkXdisKsl5TWXPtWZK
         kCB+Ga4RV7WMYx6yePUpo+3oZliK5knV+JWggyKGlZGPS8RJUMUKu0l//oeV+0YNSGQw
         ICBqjVCoKj4DukpMdJHIBOhfMdSHqyEwQCYc7A7EcO1dWpmddMrPYquOyZk6K7P3tRIi
         gCIIHPD7ereva+wSBPEoHTKIHL+2Zf+26btNlZePdqKMer7iT4ByCd1vc7qz3ZylJSG2
         FfXB+rji7ZUqckwoAqt66IwJ6+43ImTAXlbXqmKgZZZVh7dck1KxwRsxXYtMBOV+XpUd
         ZpDg==
X-Forwarded-Encrypted: i=1; AJvYcCVdgEOQ8gvFBo9HRTSUu8e79RGQQa8B5jOTLfQq99GbwziQ1i80KCfUPA7w5nBDl3iEJQBMc8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/vXFny1rpSHAEzFx+WDlMrAxIaOg//S3poqrd6hq6SQL5ZOj
	NZt4vx/bZEtya1AH1IrvipPf7GkfrBY7k0+eJYiRfnUK37X4gei+q5/CqdSXqRhj
X-Gm-Gg: ASbGncshhnQw+UbT40QdxbYnrrjvoj4YE8JRezYbYeXSGxdruP7CTxisVo9aTxTjEZU
	z95823ld5RD2rpkYGnUzgsI09VPZS92EXF9DMLCDD1ckfMUrXKJsiVN0G/EqzdnIYzI614jbiMu
	eDPtgtWDhrx51yXD4G+rapT2/X/PBPbeF+JTHBWXGVB49IrlcfN42FhxHOocLL2aa7lgsDJAnXD
	eUao54mWSTn0pi09aqLRxN47gTo3/n4ntIxZR/zAaRg0Q98XbQmP+iBXXZ/K8NkC++HzVG/5Ony
	FDsXrKjAhAxnfkfEPB28kQf6eyHtw4E3RqFplIqREWYpnbbh7OkHwsucVxK09uWC2eigGLzZU0G
	wpf15IWJyGbW/+cEU+Hv0nmKj4UJPPwfbiwzfZ1eVZfZBFSCGxks3KelcTt9VSZIMUgpP4vnDUE
	xlniD90tOjfjZGku2aFGIxsQ==
X-Google-Smtp-Source: AGHT+IEme6ZRZ3QzP4u+9rAEIbdLf6rnEyW7G1AZ/Yr399l93wvEZVkFNB32e6E/kws7pH65k0i0bw==
X-Received: by 2002:a05:690c:6d11:b0:740:3210:6a9 with SMTP id 00721157ae682-7836d1e8357mr223105287b3.23.1761253231768;
        Thu, 23 Oct 2025 14:00:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6cc5cbsm8513077b3.38.2025.10.23.14.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 13:58:20 -0700
Subject: [PATCH net-next v5 1/4] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-1-47cb85f5259e@meta.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
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


