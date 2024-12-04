Return-Path: <netdev+bounces-149093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254519E428E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4657283233
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65D2144D0;
	Wed,  4 Dec 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="L4wKlChl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19052144B6
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332969; cv=none; b=QRNZ1lzLJnrsNnyCpk0zvMzgD0VbLs90FbrwCFCtVFpdf2sy/NZrrKOp8q+XGPtsguBpB3zPZbJ/pjpIHkpSWi0t7YYhGn/ZoqNz0KcMAQ/VS0m7plvCbO4W/OP5LkwRZfLIVXh1PB0HLqIaY5J25l5gMOPqDKuNX+dAmFL1N6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332969; c=relaxed/simple;
	bh=P7m2r+GGyBrkWHJpfb3T2MQ50jGabcCk7WvGavxVWCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiFnRwirG5Y1yuBbTNg6iWSDoZe3G+DGUvasJE13wkQUZ8mInx0TmhAi4Jc5ziCUiD5kt4cGhUDhxBM3ZtvBQt+VpeYPxF6lRJwhSHTxXmxQvAfb+RqL48vrvxEklmMahThkVuah+O8A546rNsozRpnAzKNPwMCb6QuyAI/oxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=L4wKlChl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso24838a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332967; x=1733937767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAFZQHh3Txu/JunB7wOIdrBL3yg0y/5ImZqDpMhl7A4=;
        b=L4wKlChlne7SjUQA/cuIChLwVQE2Xn+SuaXU6hUSAeGkyVOKs7VmpuRja+i6qTHLG4
         Up0ezqegZNT1qbPmEgNRUoULn6hvSsWRm7SFOPSvL1Z/RCNVLmoKzsgDRf6LAQ5uj6qb
         rshnPg5qFY4TiRJ1v5TIBmTcECCZ5PWoFI8kPa+tOmt3cEPeG4C5sw4Gu7vX/ypH9lOa
         X1JyMI9uN44hsUxavD/CwqkhF0Fp6LDENOLj5gkXKmai9HdlYUjUBKeDcHWrNe6kldP/
         hgRuCArQSQAXMkaA4aDh7Jj+5lu2LF7G/0xETJ86iMKqZ3ppyv9DWuD1J9m5RnW1YyDV
         7A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332967; x=1733937767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAFZQHh3Txu/JunB7wOIdrBL3yg0y/5ImZqDpMhl7A4=;
        b=Y7KxDX1wKeEiiYHoLtf+c5IynCkpZ1CaXBYggwjoGgllGVBmjF5xSeL30VNSU4fJYk
         LZCpB3PM2RZhRoKxJRGWj34fGfaS6g7JVyL3UguzChhfsephE2Sn/klVH+JkuMpNLdSY
         E4xC5ua9y11nf9V3bbQ60al+XmztnIFOR5N5GpJqYGEfzDJacXJcx7Cr80kJhYHMbPJt
         oc4yMBTyvW/2a7kr1noBTFqHLE54OLNI/VyGtnLCHbQ0ueM1vN3MAKNpb/3T4A7vnz+N
         ESHbTREKsvme4jPS5PIYNm/AiRCdGL1U8/psbTuNUd+kJZYYhAlnuSb7A6reU0WHeBMx
         mAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW88Q3oIITe+OFNJzqTleREUq/aTKkQujMjzW31m27VcFWTcyL6CteMJcEMrYt4YP0E02vvdCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTedcC3pLoIXRNwcSKQBOuL/X2++blg/AMDO3doe5xMGpeCbhA
	wNzgcKeys8va8OZ9NcFahTQTdDJAyuuOVXTWrzxPZkZo8/NKyDsILFkv4cL/kuU=
X-Gm-Gg: ASbGnctk1RNLxgKJth9Bm3MYk82dhKBbSSsFUttlMKXuQH5xLS6dLEvw9UGs5B45Xy7
	OFWoBx622rgU1JyonRMjdU2IRKPbOF3NQgNedz2GDvwIxRuitBmsMhTa+LaPaEOrTi9xWtJ91oX
	MAVx9pCW7ufdtrx8iRBs1pSiw/c/5rVQuBtEwlaoAdJKLw99RURzRGyVkElIjbFlwR0/ro9BmDq
	aS7xPIzgN6GotCo/kRRfrHakGA4b+G96Pg=
X-Google-Smtp-Source: AGHT+IFVRKzIKF0vxlA7OrnnNXDfVXr1Fm5L5r0h9paEQoDxU+ErYnNastbW5tDfNZhy9/bW+sQkqA==
X-Received: by 2002:a05:6a20:2587:b0:1e0:d766:8da1 with SMTP id adf61e73a8af0-1e16541097bmr9838822637.39.1733332966818;
        Wed, 04 Dec 2024 09:22:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849c1csm12572290b3a.200.2024.12.04.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:46 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v8 04/17] net: prepare for non devmem TCP memory providers
Date: Wed,  4 Dec 2024 09:21:43 -0800
Message-ID: <20241204172204.4180482-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204172204.4180482-1-dw@davidwei.uk>
References: <20241204172204.4180482-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

There is a good bunch of places in generic paths assuming that the only
page pool memory provider is devmem TCP. As we want to reuse the net_iov
and provider infrastructure, we need to patch it up and explicitly check
the provider type when we branch into devmem TCP code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c         | 10 ++++++++--
 net/core/devmem.h         |  8 ++++++++
 net/core/page_pool_user.c | 15 +++++++++------
 net/ipv4/tcp.c            |  6 ++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 01738029e35c..78983a98e5dc 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -28,6 +28,12 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
+bool net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops)
+{
+	return ops == &dmabuf_devmem_ops;
+}
+EXPORT_SYMBOL_GPL(net_is_devmem_page_pool_ops);
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -316,10 +322,10 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 	unsigned int i;
 
 	for (i = 0; i < dev->real_num_rx_queues; i++) {
-		binding = dev->_rx[i].mp_params.mp_priv;
-		if (!binding)
+		if (dev->_rx[i].mp_params.mp_ops != &dmabuf_devmem_ops)
 			continue;
 
+		binding = dev->_rx[i].mp_params.mp_priv;
 		xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
 			if (rxq == &dev->_rx[i]) {
 				xa_erase(&binding->bound_rxqs, xa_idx);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a2b9913e9a17..a3fdd66bb05b 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -116,6 +116,8 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+bool net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -168,6 +170,12 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline bool
+net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops)
+{
+	return false;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..604862a73535 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -214,7 +214,7 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	struct net_devmem_dmabuf_binding *binding;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -244,8 +244,11 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
-		goto err_cancel;
+	if (net_is_devmem_page_pool_ops(pool->mp_ops)) {
+		binding = pool->mp_priv;
+		if (nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+			goto err_cancel;
+	}
 
 	genlmsg_end(rsp, hdr);
 
@@ -353,16 +356,16 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *mp_priv = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-	if (!binding)
+	if (!mp_priv)
 		return 0;
 
 	mutex_lock(&page_pools_lock);
 	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
-		if (pool->mp_priv != binding)
+		if (pool->mp_priv != mp_priv)
 			continue;
 
 		if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b872de9a8271..f22005c70fd3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -277,6 +277,7 @@
 #include <net/ip.h>
 #include <net/sock.h>
 #include <net/rstreason.h>
+#include <net/page_pool/types.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -2476,6 +2477,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			}
 
 			niov = skb_frag_net_iov(frag);
+			if (net_is_devmem_page_pool_ops(niov->pp->mp_ops)) {
+				err = -ENODEV;
+				goto out;
+			}
+
 			end = start + skb_frag_size(frag);
 			copy = end - offset;
 
-- 
2.43.5


