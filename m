Return-Path: <netdev+bounces-226743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F9BA4A54
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D194176E16
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4F2FB97D;
	Fri, 26 Sep 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKr5izzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F232FB095
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904300; cv=none; b=nERctfreGyxs4rWK1mEym0GUt0vfd8OFrRCddlX91OaxF8Sc/SzYWvJF7kQSnhoWS3X1PmtNBSYvMGEIcPjrz3g9gzk9ARrrw+pQg/fr/eiLHZMwS13a6WYvYEIJIFgF6kexu5Uhqw+akFWtMrbP7QxMHrkVi4CTUHIWf8sr5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904300; c=relaxed/simple;
	bh=fdrJ2W7mBo4ScK0+ExdwCjhXZ7mjfmL0Ggt7KK74nGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ai+Tl9XRaQtWEDvjs3+Du+b5gjdBHCQjRACflNXJoH2paINeCslLtRjN1hz5Hb2soYOcZ7T+XycBjYYZlT8ROZAVo8+wIDa6SvUtnkPw4gpJDmlvoalPCjM3wGtaztsH3gW4OsZ8Q5HeAVpgceWK2+uRc7rkAdLpTzTCKq+42i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKr5izzV; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-636d5cefab2so1604154d50.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904298; x=1759509098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=dKr5izzVkHdIqYFrdHrWNN9CKKrO9An8m9qa2FpWpFiaNsLfcAS5P5uauLgFeUHai8
         N5ETzZkCCV7AHq+nwIeDPPTyXv0JMKnCLEWMZxyg1QDqW56/LLoQkz5kBlBm8K5TfyPH
         TBvQsD/hw3MI4vW6L2jQJWaEb/0RsiiQ/PAH09ufx1PwvF+xMBPGL7oyY5pUqZb1emfI
         pBZonB+rnsXbdDNqpturXxHG+2UqsV3mntQT9dESTkT3+AZt5xtGZco87sih20m4I8hF
         /ALKAOzfuDmvu0npXhy/Of48Q/k54aX7b4oHHgSs7c7w45E4gkU5xC+b86xglPgL8OYm
         3isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904298; x=1759509098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJXxA4eRg+MQwHOWJI8nle9db3f24EujzoUrSFcpQz8=;
        b=Cg2VyZ7hk9Jm35IIoyZhG5lrGEPNimqr0u41X6pFyVwFWJ+lKNeOaaHCNelpC4F/et
         uCJ/bNOW5hbJEOeho3noKEpv7GKcIf/LSR+nNfZXbxcefru8/bwco/g3HhJxRkG4oetx
         q+5+MnyE6nBjafZCzZSunVSanajfpGkdmf6WZpD+oxisht2+5qiuP3MzGZdXGjze7syw
         olpiwnExhaa7FBanZVtiXK/dwH37dbyFN5g5Iv8t7AJfK0ZgOfS6m3ijbjNc6YQhcXaF
         jJ/3r9sQ11yjrABGhsd11mWrreMmE9Iq/wDNNdYgoSqjcB01DmVRUFqaOOkOGaubKUqo
         kL1Q==
X-Gm-Message-State: AOJu0YxPug4w0RcS1dezYW/sKWy0jHzMSMu0dforFVAYxELwNfbmqIGK
	1w1bWPHJFPZOqeNv6COZM671Zo/zawWFIpxKcBEytBsRBmgcbkg1Qdbw
X-Gm-Gg: ASbGncsO3Om1vRbxT4i9DEsU6ROcZbt/JvMqsUhyFZtPZBmyeDFGJxToBZjZtbU5GQx
	QjlgHgcDXLsJYNhwV8kld8TsiQ9p1GYr/wbIMZTadvgtm5FsHuNhx+HkAwWufW0mf1bCulw89lt
	Nn9SOdbyt990WRWEOCTdlp1vhpAeHCD4TVQIYjQUNG9w4mjzdWZ7RjPJ0uN+vQt3V4AIz8Jbwqg
	HXM3b0qkUBBoCzmDQ7rgXLJ/xLSOHfnOqKs8sE2y7/lcAekcFh+02lUgqrcFTAUvNmcwAbJ7bYC
	2V8/NaAD66UpQYhxDusYyW408ad337JHmyxLIQdnwOmL84GV4Yo2zGIoNBO2PaOyjS9J3cWNjk0
	nn1WoezW2xvznsgQ38fRXUvv5rrUlPfHy
X-Google-Smtp-Source: AGHT+IGgf0LInGO2FgPKF/qZPEg+wvtbY55Rmkh2td5aYcvJhlHNnAbaa8nq5hAyjPwUopZSPdvbKw==
X-Received: by 2002:a05:690e:1607:b0:635:4ed0:5730 with SMTP id 956f58d0204a3-6361a862bf9mr6602221d50.52.1758904297608;
        Fri, 26 Sep 2025 09:31:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb38384d7b9sm1483770276.6.2025.09.26.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:31:37 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 26 Sep 2025 09:31:33 -0700
Subject: [PATCH net-next v4 1/2] net: devmem: rename tx_vec to vec in
 dmabuf binding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-1-39156563c3ea@meta.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
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


