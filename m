Return-Path: <netdev+bounces-242194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034EC8D424
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E3BD4E6553
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868F31B119;
	Thu, 27 Nov 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRROUa4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189F1CEAA3
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230069; cv=none; b=Zki58a5L0pnZ76NYg2iw2on4Lxn4qNg5ocCs8apS/zyB1xfdffX0fSlG+67kqehre1RrwDQvrlSyOhCuvMmFqHELU3XzY3zlZoXNhzg2iNxXeIf4fPU5uDmZlt3jFTQeoenlEUL1ZvDaamyvNT8W2WpPWmDOGR1iiPKul2xB4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230069; c=relaxed/simple;
	bh=jtIPHiez4pNfNJwNn+Tcs3nlEgaw6G3HtFCcbT8vEtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BtgU7cDKSwbYP9N6gtHCFnCDIJ050da0lnxU6SkajrH4Lpb4ORcVieWSmSoeDihxN1QNGnL7ifZ5omWk6ecMt8otGnR09+65eL5glQi0P8+CDZfr7uSwzaPOgMerRt/SfSWDo3dxNHHpyyUZwwzRVkNvXH4y9ZlNuiAf9RI1zlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRROUa4V; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-642f3bab0c8so480375d50.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764230066; x=1764834866; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J21c0SFwjvOls4fCeNe/hpOZUTNpwp8lQ3gEdB1glDk=;
        b=NRROUa4VkyvqbTqqfdLLFI81nMQ8fwK1G24zqZ1vnxjvkziOztACggJlUS7e0gNVcU
         0MnvNS4nBYfZ83N5Ihwc21PHN51vwzfV0NqxInw2wSVPccTMEDj5hfsl5xrYjw9RWK5+
         JPSA8ZSBbAa1BCzxGxKtjUZOUu3hYlFr4RA5sUCEcECWEDZ6szRmIv+w8qHBsrTLQSaG
         TmGtmPjnVq0/FDA19KpQF4R08OKykFh0QIHfCvtl757RfJskJFQg59XbMMwHzAT46qyi
         JV5SmqZ5UJ3u8vIGSx7aZSs/MrKPHYRrttaPAIsBFILCF2l/ostNVc+QNPH7PXarstAq
         7GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764230066; x=1764834866;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J21c0SFwjvOls4fCeNe/hpOZUTNpwp8lQ3gEdB1glDk=;
        b=CaydZeJctdy3nlP4932Gn9nfvn9BAlc0EfHkDgi5ZQ52pV+WScz2dTaCYqmS3wvZi8
         iJ/I6fPwIr9ZHAUdyhzvxFvs8EXiYRL415cVSiduFc5inWAPnC1/1PkVou7B6X+VsuJC
         ktWEJlXGBSnaxjKGKQVceoUtmiBO5PjuIAmiAhB2TbKikQTPJX3FpmfC6ulHRfZMQFBT
         Vx0mSHN6ACEgj7en/3PiE7SExA2gtPLNGgiF4/oosyo5KKH9l3Gd1oPo0dd/Mz/NkND9
         4/avXwefltokFv/LdpmSWbKtpHcGt6U9yKzRkmCoOhOL2m334W24JI75cte1dGJbof9S
         uykQ==
X-Gm-Message-State: AOJu0YyML9AHOQzcAgnNtKdSgMzRBcxhPbgdwvzBVv+iLr53sOKHzXsx
	TBejRgbNw6ATQxSiQ99p27TuLEhBu7y75COExHSarQbdGigWW0qOXrTa
X-Gm-Gg: ASbGnctUAfSxN6+VHAqeHcmVCjAHzFmC8eu5IGTCqDkH13vB88xGmfFwmXnCgexe58U
	EdcCVNxcU/Gndf7HDIGDZxN404cexZbI1U/85pq3jV4gi1uqPXd5GFXwLF2/nF91qeUkppaRLDD
	9Qy6wxhJ4USWdy2OO1LgNtVmB7spw+O0iqDolK+iByHCEqbsYfAlNmj+KWbOY9ERIQa9IeCzaOt
	BDIZg+k5HcP73QUJihHC3wcjA/nuX3Xs1vH0JOZ9BrojPFLuwuxpcyKZ8hLHIjo7ojOE+YScz/S
	pV2PLomIubEKzCDwuozkvnuFJq5L0Eyz3Zxx8BHlRgqfHqThQ39dEv8WFp1bW0IuaPY2RfxCCwi
	vL9YrulUPyDl477HXQuAO8zVRLwR9rc9xHwB9NlngjAx32KWPUnrxiIxuSdW87BpcIWtnmtpodK
	w0i0aB5LhtmIuJTAs1NF3c9w==
X-Google-Smtp-Source: AGHT+IFFjMFqEP9GE8COVStTPFQJuwJSEEJT/8ZMyoULLlScwHYfhnjbD/EpBsWGAz/bNseNQw7grg==
X-Received: by 2002:a05:690e:154d:10b0:642:836:1066 with SMTP id 956f58d0204a3-64302a2fac6mr13278573d50.6.1764230066154;
        Wed, 26 Nov 2025 23:54:26 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5f3sm3188607b3.8.2025.11.26.23.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:54:25 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:54:14 -0800
Subject: [PATCH net-next] net: devmem: convert binding refcount to
 percpu_ref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com>
X-B4-Tracking: v=1; b=H4sIAKUDKGkC/x3MQQqDMBAF0KsMf+2AmVoLuUrpQu2knUXTMIkii
 Hcv9B3gHajqphWRDrhuVu2bESl0hOU95ZeyPREJ0ss1BBl5LbW5Th8u6ktZ2TXx0IeL3NIo8zC
 jIxTXZPt/vSNr46x7w+M8fzZyL8lvAAAA
X-Change-ID: 20251126-upstream-percpu-ref-401327f62b4b
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
 asml.silence@gmail.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
to optimize common-case reference counting on the hot path.

The typical devmem workflow involves binding a dmabuf to a queue
(acquiring the initial reference on binding->ref), followed by
high-volume traffic where every skb fragment acquires a reference.
Eventually traffic stops and the unbind operation releases the initial
reference. Additionally, the high traffic hot path is often multi-core.
This access pattern is ideal for percpu_ref as the first and last
reference during bind/unbind and normally book-ends activity in the hot
path.

__net_devmem_dmabuf_binding_free becomes the percpu_ref callback invoked
when the last reference is dropped.

kperf test:
- 4MB message sizes
- 60s of workload each run
- 5 runs
- 4 flows

Throughput:
	Before: 45.31 GB/s (+/- 3.17 GB/s)
	After: 48.67 GB/s (+/- 0.01 GB/s)

Picking throughput-matched kperf runs (both before and after matched at
~48 GB/s) for apples-to-apples comparison:

Summary (averaged across 4 workers):

  TX worker CPU idle %:
    Before: 34.44%
    After: 87.13%

  RX worker CPU idle %:
    Before: 5.38%
    After: 9.73%

kperf before:

client: == Source
client:   Tx 98.100 Gbps (735764807680 bytes in 60001149 usec)
client:   Tx102.798 Gbps (770996961280 bytes in 60001149 usec)
client:   Tx101.534 Gbps (761517834240 bytes in 60001149 usec)
client:   Tx 82.794 Gbps (620966707200 bytes in 60001149 usec)
client:   net CPU 56: usr: 0.01% sys: 0.12% idle:17.06% iow: 0.00% irq: 9.89% sirq:72.91%
client:   app CPU 60: usr: 0.08% sys:63.30% idle:36.24% iow: 0.00% irq: 0.30% sirq: 0.06%
client:   net CPU 57: usr: 0.03% sys: 0.08% idle:75.68% iow: 0.00% irq: 2.96% sirq:21.23%
client:   app CPU 61: usr: 0.06% sys:67.67% idle:31.94% iow: 0.00% irq: 0.28% sirq: 0.03%
client:   net CPU 58: usr: 0.01% sys: 0.06% idle:76.87% iow: 0.00% irq: 2.84% sirq:20.19%
client:   app CPU 62: usr: 0.06% sys:69.78% idle:29.79% iow: 0.00% irq: 0.30% sirq: 0.05%
client:   net CPU 59: usr: 0.06% sys: 0.16% idle:74.97% iow: 0.00% irq: 3.76% sirq:21.03%
client:   app CPU 63: usr: 0.06% sys:59.82% idle:39.80% iow: 0.00% irq: 0.25% sirq: 0.05%
client: == Target
client:   Rx 98.092 Gbps (735764807680 bytes in 60006084 usec)
client:   Rx102.785 Gbps (770962161664 bytes in 60006084 usec)
client:   Rx101.523 Gbps (761499566080 bytes in 60006084 usec)
client:   Rx 82.783 Gbps (620933136384 bytes in 60006084 usec)
client:   net CPU  2: usr: 0.00% sys: 0.01% idle:24.51% iow: 0.00% irq: 1.67% sirq:73.79%
client:   app CPU  6: usr: 1.51% sys:96.43% idle: 1.13% iow: 0.00% irq: 0.36% sirq: 0.55%
client:   net CPU  1: usr: 0.00% sys: 0.01% idle:25.18% iow: 0.00% irq: 1.99% sirq:72.80%
client:   app CPU  5: usr: 2.21% sys:94.54% idle: 2.54% iow: 0.00% irq: 0.38% sirq: 0.30%
client:   net CPU  3: usr: 0.00% sys: 0.01% idle:26.34% iow: 0.00% irq: 2.12% sirq:71.51%
client:   app CPU  7: usr: 2.22% sys:94.28% idle: 2.52% iow: 0.00% irq: 0.59% sirq: 0.37%
client:   net CPU  0: usr: 0.00% sys: 0.03% idle: 0.00% iow: 0.00% irq:10.44% sirq:89.51%
client:   app CPU  4: usr: 2.39% sys:81.46% idle:15.33% iow: 0.00% irq: 0.50% sirq: 0.30%

kperf after:

client: == Source
client:   Tx 99.257 Gbps (744447016960 bytes in 60001303 usec)
client:   Tx101.013 Gbps (757617131520 bytes in 60001303 usec)
client:   Tx 88.179 Gbps (661357854720 bytes in 60001303 usec)
client:   Tx101.002 Gbps (757533245440 bytes in 60001303 usec)
client:   net CPU 56: usr: 0.00% sys: 0.01% idle: 6.22% iow: 0.00% irq: 8.68% sirq:85.06%
client:   app CPU 60: usr: 0.08% sys:12.56% idle:87.21% iow: 0.00% irq: 0.08% sirq: 0.05%
client:   net CPU 57: usr: 0.00% sys: 0.05% idle:69.53% iow: 0.00% irq: 2.02% sirq:28.38%
client:   app CPU 61: usr: 0.11% sys:13.40% idle:86.36% iow: 0.00% irq: 0.08% sirq: 0.03%
client:   net CPU 58: usr: 0.00% sys: 0.03% idle:70.04% iow: 0.00% irq: 3.38% sirq:26.53%
client:   app CPU 62: usr: 0.10% sys:11.46% idle:88.31% iow: 0.00% irq: 0.08% sirq: 0.03%
client:   net CPU 59: usr: 0.01% sys: 0.06% idle:71.18% iow: 0.00% irq: 1.97% sirq:26.75%
client:   app CPU 63: usr: 0.10% sys:13.10% idle:86.64% iow: 0.00% irq: 0.10% sirq: 0.05%
client: == Target
client:   Rx 99.250 Gbps (744415182848 bytes in 60003297 usec)
client:   Rx101.006 Gbps (757589737472 bytes in 60003297 usec)
client:   Rx 88.171 Gbps (661319475200 bytes in 60003297 usec)
client:   Rx100.996 Gbps (757514792960 bytes in 60003297 usec)
client:   net CPU  2: usr: 0.00% sys: 0.01% idle:28.02% iow: 0.00% irq: 1.95% sirq:70.00%
client:   app CPU  6: usr: 2.03% sys:87.20% idle:10.04% iow: 0.00% irq: 0.37% sirq: 0.33%
client:   net CPU  3: usr: 0.00% sys: 0.00% idle:27.63% iow: 0.00% irq: 1.90% sirq:70.45%
client:   app CPU  7: usr: 1.78% sys:89.70% idle: 7.79% iow: 0.00% irq: 0.37% sirq: 0.34%
client:   net CPU  0: usr: 0.00% sys: 0.01% idle: 0.00% iow: 0.00% irq: 9.96% sirq:90.01%
client:   app CPU  4: usr: 2.33% sys:83.51% idle:13.24% iow: 0.00% irq: 0.64% sirq: 0.26%
client:   net CPU  1: usr: 0.00% sys: 0.01% idle:27.60% iow: 0.00% irq: 1.94% sirq:70.43%
client:   app CPU  5: usr: 1.88% sys:89.61% idle: 7.86% iow: 0.00% irq: 0.35% sirq: 0.27%

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/devmem.c | 38 +++++++++++++++++++++++++++++++++-----
 net/core/devmem.h | 18 ++++++++++--------
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756..83989cf4a987 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -54,10 +54,26 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
-void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
+/*
+ * percpu_ref release callback invoked when the last reference to the binding
+ * is dropped. Schedules the actual cleanup in a workqueue because
+ * ref->release() cb is not allowed to sleep as it may be called in RCU
+ * callback context.
+ */
+static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 {
-	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
+	struct net_devmem_dmabuf_binding *binding =
+		container_of(ref, struct net_devmem_dmabuf_binding, ref);
+
+	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
+	schedule_work(&binding->unbind_w);
+}
 
+/* Workqueue callback that performs the actual cleanup of the binding. */
+void __net_devmem_dmabuf_binding_free(struct work_struct *work)
+{
+	struct net_devmem_dmabuf_binding *binding =
+		container_of(work, struct net_devmem_dmabuf_binding, unbind_w);
 	size_t size, avail;
 
 	gen_pool_for_each_chunk(binding->chunk_pool,
@@ -75,6 +91,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
+	percpu_ref_exit(&binding->ref);
 	kvfree(binding->tx_vec);
 	kfree(binding);
 }
@@ -143,7 +160,11 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
-	net_devmem_dmabuf_binding_put(binding);
+	/* Switch to atomic mode and drop the initial reference we acquired at
+	 * bind time. This will invoke __net_devmem_dmabuf_binding_free if this
+	 * is the last reference.
+	 */
+	percpu_ref_kill(&binding->ref);
 }
 
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -209,7 +230,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	binding->dev = dev;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
-	refcount_set(&binding->ref, 1);
+	err = percpu_ref_init(&binding->ref,
+			      net_devmem_dmabuf_binding_release,
+			      0, GFP_KERNEL);
+
+	if (err < 0)
+		goto err_free_binding;
 
 	mutex_init(&binding->lock);
 
@@ -220,7 +246,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-		goto err_free_binding;
+		goto err_exit_ref;
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
@@ -322,6 +348,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					  direction);
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
+err_exit_ref:
+	percpu_ref_exit(&binding->ref);
 err_free_binding:
 	kfree(binding);
 err_put_dmabuf:
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 0b43a648cd2e..e9f900dd4060 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -41,7 +41,7 @@ struct net_devmem_dmabuf_binding {
 	 * retransmits) hold a reference to the binding until the skb holding
 	 * them is freed.
 	 */
-	refcount_t ref;
+	struct percpu_ref ref;
 
 	/* The list of bindings currently active. Used for netlink to notify us
 	 * of the user dropping the bind.
@@ -82,7 +82,7 @@ struct dmabuf_genpool_chunk_owner {
 	dma_addr_t base_dma_addr;
 };
 
-void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
+void __net_devmem_dmabuf_binding_free(struct work_struct *work);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       struct device *dma_dev,
@@ -125,17 +125,19 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 static inline bool
 net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
 {
-	return refcount_inc_not_zero(&binding->ref);
+	return percpu_ref_tryget(&binding->ref);
 }
 
 static inline void
 net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 {
-	if (!refcount_dec_and_test(&binding->ref))
-		return;
-
-	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
-	schedule_work(&binding->unbind_w);
+	/* When the ref count reaches 0, the percpu_ref release callback will
+	 * schedule __net_devmem_dmabuf_binding_free() to run on a workqueue.
+	 * More often the dmabuf is still bound and so the reference count
+	 * remains above 0 here. Consequently, the cleanup is typically
+	 * triggered by net_devmem_unbind_dmabuf via percpu_ref_kill().
+	 */
+	percpu_ref_put(&binding->ref);
 }
 
 void net_devmem_get_net_iov(struct net_iov *niov);

---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251126-upstream-percpu-ref-401327f62b4b

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


