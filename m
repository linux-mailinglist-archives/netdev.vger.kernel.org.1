Return-Path: <netdev+bounces-243308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C814C9CC63
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210E03A1569
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 19:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0402D47F3;
	Tue,  2 Dec 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TccvJHCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C31DED49
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704091; cv=none; b=lfqiZkVgHM4jC+5l+2xBXe9uRqChEzi4EmnU1wD9ujnHn2dtq8Aq+UgP5DKua3A6s8hy4HD8c85ilSq2z6bxh62cVmkgDYdYKbQ1hJp/rLGDr0dQJKy6ZFukvvDJiPmD0rIz8SJjQ3BarbP7uqW2q0aDQv1uxW5eWyEG1aGOCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704091; c=relaxed/simple;
	bh=fcyNJ7pAcnLA20wRvsFdOU7fm172cRoj/qNvIB8hORk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uht24qkrhwyuyY77e0xsesJSIEduYEDuwYtF4SOsb6Wa16exYKFQWr4W0j2JIIhnP9siLzEsT/2NaTtlUyXdx1gKVEuY2gE/mh+2NH6xrYDWdmcPXd9XwLgjNbJ5dVMHmDz10Azv0fKb3b7635JK2dd1cOU2gKdVpn2MXLgK4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TccvJHCd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787d5555274so57822617b3.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764704089; x=1765308889; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VEGSOhmz0nAR98pKXmGNz+Y7vH/5odvfWJ2rgZfmuU=;
        b=TccvJHCdNzGWlsoDxqldkI/O/yURoOlGNtqoTQUYX7logWhJcFhfw+z+OJYJfGeJPi
         PAULw4j2h4vMyRJFKczerIA+IaQfuCJnTHslkhMemVJYrMnSMLZxgSdeb5yV8FkzpLYo
         XvAdmGmIa9kx2OnYXy/jW7KfwhmQyszxD3p4/iWfPgcWRYWSJjuSKKAdr1c4Jw85t300
         4Yy2m9GHmNSHWf0ZVobNbpBllUmT7AVSlBlu1dx4q8zXBm7CVSy0+tX1351O8XB2Pshw
         L4aeUkw6os73Ks1EKvcCAkPQG+QeqwYF7vR9IKkQ6upAlN/BYkbrBoDalfS0zU56CwFi
         qSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704089; x=1765308889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VEGSOhmz0nAR98pKXmGNz+Y7vH/5odvfWJ2rgZfmuU=;
        b=kojGrxYIJ+YZo1duBYI/4UQrNWHG5hmgTSvQT7h7XbkoHhRWYrsXT0dg/uPB4ow/0M
         YrUyAwLgAl+2t8xj2A5UF9JBCZUVN5KaSy0A+IArAuY7UEapVYoW+APc/66s1ECV+mSe
         R0EL0Vk/yAhG1CqENGhqHzgb1IqlhQhRPSLNgqvTtJx4+ohJVCtT763zyiNr30Iw4/My
         90C9Y9RcZ/llADjND9K/JcoqC2a2Sc0ZAXAUctfkT6Lx5LhW1XLym62k97iKYtudLV2N
         FOFhclg/XJEkqiEICw7aKzypUCnm4+n7DQcWiPeBP6UcMVzP3bbkM0PSO/HRyFB5wU0G
         ml4A==
X-Gm-Message-State: AOJu0YzE9lT3mX1ogBfrPL+/Vf4JuNE1qDG8t+T2fULII5Sw9LG8/THA
	UH2DjhcDHy4Bg1+A2+M2pdI4+ZfqfK3uloIKddVa6hHVUTnDttIpXTtI
X-Gm-Gg: ASbGnctdYM+LG3AlhI+G+rZvvvGOZR8rb43OrZ4F64OG49+DT5Utn7/2eCcfYsQK+Ew
	tClmAQcHu5mtgS0z/HLxJ634OHfs0cdJptdS83n6fLpDdyWJhCywEe0QA2U0xo/EjAJwk5mHTi/
	Yl5MW6DjA/DOlP9/U7yd9EG6wG+0zjHy8FVn0f7zKsTlb7mos7ZyPoKYD7i9KemcWGG9C54GTv0
	eO/rcGPjo+ivmcgLWNs+U+zjiayka/XHFfQtI5h6GfPQzjjfiMkl3u35JGZ1QfvUNKhacHN6Lfb
	k0bkMPgUAjQLi9FAobC/FMyIW7bT5l3+UtnWTPe2whk4j9yt+95PXQKQC9HUpUXx88PZ6nRQYhA
	+N0vn5WQuUalh2AKjIWRGoAIK9yRVdDn28N6QAHzI2OWRRWtzwM5+THZm+JxJdnvMDwTLX7qd1Q
	Bp5Y5eXuF4VUpuBrefzPNLtw==
X-Google-Smtp-Source: AGHT+IHamzi87hcNUu5q6QsNlFOyKe2O5bZE7tJ2WcAqtiT478fK9YlBRKe+aaXZ6v5bTKa1gq6dIw==
X-Received: by 2002:a05:690c:708b:b0:783:cfa0:3b69 with SMTP id 00721157ae682-78ab6d7cd25mr274241977b3.4.1764704088875;
        Tue, 02 Dec 2025 11:34:48 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0c25ae5sm66464217b3.0.2025.12.02.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:34:48 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 02 Dec 2025 11:34:17 -0800
Subject: [PATCH net-next v2] net: devmem: convert binding refcount to
 percpu_ref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-upstream-percpu-ref-v2-1-4accb717da40@meta.com>
X-B4-Tracking: v=1; b=H4sIADg/L2kC/33NQQqDMBBA0auEWTvFmVpLXXmP4iLGsWZhDJMoF
 vHuBQ/Q9Yf3D0iiXhI05gCVzSe/BGgMFwbcZMNH0A/QGOCSH0Rc4xpTVrEzRlEXV1QZsSrpzs+
 x5r7qoTAQVUa/X+obgmQMsmfoCgOTT3nR77Xb6Op/5Y2Q0Inl0r64p2FoZ8n25pYZuvM8f/W4Y
 2u/AAAA
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
reference during bind/unbind normally book-ends activity in the hot
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
Changes in v2:
- remove comments (Stan and Paolo)
- fix grammar error in commit msg
- avoid unnecessary name change of work_struct wq
- Link to v1: https://lore.kernel.org/r/20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com
---
 net/core/devmem.c | 23 ++++++++++++++++++++---
 net/core/devmem.h | 10 +++-------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index ec4217d6c0b4..17ba386c7f67 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -54,6 +54,15 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
+static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
+{
+	struct net_devmem_dmabuf_binding *binding =
+		container_of(ref, struct net_devmem_dmabuf_binding, ref);
+
+	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
+	schedule_work(&binding->unbind_w);
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
@@ -75,6 +84,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
+	percpu_ref_exit(&binding->ref);
 	kvfree(binding->tx_vec);
 	kfree(binding);
 }
@@ -143,7 +153,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
-	net_devmem_dmabuf_binding_put(binding);
+	percpu_ref_kill(&binding->ref);
 }
 
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -209,7 +219,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
 
@@ -220,7 +235,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-		goto err_free_binding;
+		goto err_exit_ref;
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
@@ -322,6 +337,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 					  direction);
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
+err_exit_ref:
+	percpu_ref_exit(&binding->ref);
 err_free_binding:
 	kfree(binding);
 err_put_dmabuf:
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 0b43a648cd2e..2534c8144212 100644
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
@@ -125,17 +125,13 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
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
+	percpu_ref_put(&binding->ref);
 }
 
 void net_devmem_get_net_iov(struct net_iov *niov);

---
base-commit: 3c4159b3019cc3444495f54c18083cda579cba84
change-id: 20251126-upstream-percpu-ref-401327f62b4b

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


