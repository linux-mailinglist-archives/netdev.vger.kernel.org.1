Return-Path: <netdev+bounces-149103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD19E429E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B55169CFE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AC21639D;
	Wed,  4 Dec 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0dCaU245"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A92216385
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332982; cv=none; b=FpHTsW8CtvGm9AHrWzxJe0pzu5zIZ8111Q/Rdue2D7nJRsXjXE8bivplm012EARXyoV4fNdgODiJXgZ/aMrXcXbTLeEyrgZilgL2MmW7WRd3gc5H1ENMcfiprCgE++hagvmPtZK/NU7Tgq0udZmn0AFRtqvK1nEyhNJSyvAlXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332982; c=relaxed/simple;
	bh=rqdrXpLj1vIPDgTAK8qHnKFLuAGob9uTJRFFgJSyn4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMbuKyIBEi/P1/+RAWSQHrutdAGLZkrGuu2mOmOVLQOvoDwMlXFLxZKCY3YcVS3hfXUxlI34q3e1l8h+KMuSxEKK4PJAol6vQ+E2O51viPScHA60eO5TTM8xts3GDg2f//HZP+uUpK5IYKkresMxAO6w63QIE7yT1p9WC8iQeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0dCaU245; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7258cf297d4so53555b3a.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332980; x=1733937780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHjD95dIspr2lkyny7hIYIXcPHOLxQo/POPnhRJUUBQ=;
        b=0dCaU245sodU0B2+bwRSrY0GYK1cWCOgxxDeelrUQAqTFHzeoot0g0utQdaWZ0oO8Z
         9xExC2KJb4BynD939eyHojT6PdLb+9/O2tnTfngN6eXQvQghPLv73JmxO5/Vnn7jKvdg
         a2DoToYucCI3WbozveGe4oH9s784+XDMuOfoD2RT7FwfNJYAS5Fx8u7NshrV/aj9JjpP
         KLAwip7AXRmZd1F4yOdKhkUPaTelloNwS7aw0Vsb87R1/5UYUfHfcvKxALtjcIIqy5dG
         aT2SvwZnVCxuwhGdaslZAktNvZMzEQnezLntoQ8QjFceW2nnJCXFIxv70ihTcBVOmpCU
         9ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332980; x=1733937780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHjD95dIspr2lkyny7hIYIXcPHOLxQo/POPnhRJUUBQ=;
        b=opNSG0BIBfGgoDovbtfyZW6DuGUhuhfkl2uWVaTm9qrfY137gJMHw5XSlumm/RPOUj
         wfwsqWX1UvFZDmQAVwHkJ3lL5zWcH3vjx4+UsAmvy+zSZ0uu/d7CiZQ7SSAECF9G2EU4
         zJpuHOA1NjYcou2hOQ6V50TV+L4Zk4SaBioKB4FcfaOlA+A5HAtzBUbzUhu+Hq0iAvHR
         NhRphwgpv/adMyiRzb9ciZhkx7HWK0odKua+7kSEgo8Ef/BVaz3N3vO1V16kQBM/HR5r
         PPpUuOfHb3AxignGd7Eg2LNvaRvIm2DwfeSnQ1JPhlQnpjmjc5VVY9uxA/xEOzJkySoa
         JJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpXBPD61DOWu6tGEYjR5UYiUKV9jIRRc9Xatj6u6aGmzJHQ8Fxy9gMBLI7B4IL41DFJrT4qvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+srMenkD5JbkidQ3wWX/GlOxoc2Xrhqb0cCn4/kk0GIbex00y
	Tu/VVzCXul+94jxPfg5eRdXrR1U6nM6RXpSfL7gadNhAES264mCFshjRZaHoMck=
X-Gm-Gg: ASbGncuyHkh6bdkV0lEJR8qbf0VddmsXX4PzGTE7ccRcpWoYu6piZWn2kRa9b6Wn3DU
	cNUfuNQxyp70q51mhGmAR8BTiYwgWBpJltnKoeSg2j4UPFH2WBXdtPWPkP3CznH6l2WlvjHTp9Q
	dCjYF4tZ3SVJ+mC9YOQXzWr9HC1LymLE9gsh+ghdfOnjOxELjrlwgnWSnU9T2RsHG9wDA8DZmX6
	vOJXIipfDIfwGfzXwuqtNBCr468kzsO8As=
X-Google-Smtp-Source: AGHT+IFnS4P+EH2EQ6LLJk/1czqV13bbkASeblrjfxdxcHB07RmxAQGEPfiCnXUTpbfx5SrA4yO9+Q==
X-Received: by 2002:a17:902:c94d:b0:215:5f18:48ef with SMTP id d9443c01a7336-215bd201e95mr78718725ad.34.1733332979972;
        Wed, 04 Dec 2024 09:22:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f2bsm115331945ad.93.2024.12.04.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:59 -0800 (PST)
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
Subject: [PATCH net-next v8 14/17] io_uring/zcrx: add copy fallback
Date: Wed,  4 Dec 2024 09:21:53 -0800
Message-ID: <20241204172204.4180482-15-dw@davidwei.uk>
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

There are scenarios in which the zerocopy path might get a normal
in-kernel buffer, it could be a mis-steered packet or simply the linear
part of an skb. Another use case is to allow the driver to allocate
kernel pages when it's out of zc buffers, which makes it more resilient
to spikes in load and allow the user to choose the balance between the
amount of memory provided and performance.

At the moment we fail such requests. Instead, grab a buffer from the
page pool, copy data there, and return back to user in the usual way.
Because the refill ring is private to the napi our page pool is running
from, it's done by stopping the napi via napi_execute() helper. It grabs
only one buffer, which is inefficient, and improving it is left for
follow up patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 133 +++++++++++++++++++++++++++++++++++++++++++++---
 io_uring/zcrx.h |   1 +
 2 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0cba433c764a..8e4b9bfaed99 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -5,6 +5,8 @@
 #include <linux/nospec.h>
 #include <linux/netdevice.h>
 #include <linux/io_uring.h>
+#include <linux/skbuff_ref.h>
+#include <net/busy_poll.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <trace/events/page_pool.h>
@@ -28,6 +30,11 @@ struct io_zcrx_args {
 	struct socket		*sock;
 };
 
+struct io_zc_refill_data {
+	struct io_zcrx_ifq *ifq;
+	struct net_iov *niov;
+};
+
 static const struct memory_provider_ops io_uring_pp_zc_ops;
 
 static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *niov)
@@ -37,6 +44,13 @@ static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *nio
 	return container_of(owner, struct io_zcrx_area, nia);
 }
 
+static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
+{
+	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+
+	return area->pages[net_iov_idx(niov)];
+}
+
 static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
 {
 	struct netdev_rx_queue *rxq;
@@ -59,6 +73,13 @@ static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
 	ret = netdev_rx_queue_restart(ifq->dev, ifq->if_rxq);
 	if (ret)
 		goto fail;
+
+	if (WARN_ON_ONCE(!ifq->pp)) {
+		ret = -EFAULT;
+		goto fail;
+	}
+	/* grab napi_id while still under rtnl */
+	ifq->napi_id = ifq->pp->p.napi->napi_id;
 	return 0;
 fail:
 	rxq->mp_params.mp_ops = NULL;
@@ -530,6 +551,7 @@ static void io_pp_zc_destroy(struct page_pool *pp)
 	page_pool_mp_release_area(pp, &ifq->area->nia);
 
 	ifq->pp = NULL;
+	ifq->napi_id = 0;
 
 	if (WARN_ON_ONCE(area->free_count != area->nia.num_niovs))
 		return;
@@ -544,6 +566,34 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.scrub			= io_pp_zc_scrub,
 };
 
+static void io_napi_refill(void *data)
+{
+	struct io_zc_refill_data *rd = data;
+	struct io_zcrx_ifq *ifq = rd->ifq;
+	netmem_ref netmem;
+
+	if (WARN_ON_ONCE(!ifq->pp))
+		return;
+
+	netmem = page_pool_alloc_netmem(ifq->pp, GFP_ATOMIC | __GFP_NOWARN);
+	if (!netmem)
+		return;
+	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
+		return;
+
+	rd->niov = netmem_to_net_iov(netmem);
+}
+
+static struct net_iov *io_zc_get_buf_task_safe(struct io_zcrx_ifq *ifq)
+{
+	struct io_zc_refill_data rd = {
+		.ifq = ifq,
+	};
+
+	napi_execute(ifq->napi_id, io_napi_refill, &rd);
+	return rd.niov;
+}
+
 static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 			      struct io_zcrx_ifq *ifq, int off, int len)
 {
@@ -567,6 +617,45 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 	return true;
 }
 
+static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+				  void *data, unsigned int offset, size_t len)
+{
+	size_t copy_size, copied = 0;
+	int ret = 0, off = 0;
+	struct page *page;
+	u8 *vaddr;
+
+	do {
+		struct net_iov *niov;
+
+		niov = io_zc_get_buf_task_safe(ifq);
+		if (!niov) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		page = io_zcrx_iov_page(niov);
+		vaddr = kmap_local_page(page);
+		copy_size = min_t(size_t, PAGE_SIZE, len);
+		memcpy(vaddr, data + offset, copy_size);
+		kunmap_local(vaddr);
+
+		if (!io_zcrx_queue_cqe(req, niov, ifq, off, copy_size)) {
+			napi_pp_put_page(net_iov_to_netmem(niov));
+			return -ENOSPC;
+		}
+
+		io_zcrx_get_buf_uref(niov);
+		napi_pp_put_page(net_iov_to_netmem(niov));
+
+		offset += copy_size;
+		len -= copy_size;
+		copied += copy_size;
+	} while (offset < len);
+
+	return copied ? copied : ret;
+}
+
 static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
@@ -574,8 +663,24 @@ static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 
 	off += skb_frag_off(frag);
 
-	if (unlikely(!skb_frag_is_net_iov(frag)))
-		return -EOPNOTSUPP;
+	if (unlikely(!skb_frag_is_net_iov(frag))) {
+		struct page *page = skb_frag_page(frag);
+		u32 p_off, p_len, t, copied = 0;
+		u8 *vaddr;
+		int ret = 0;
+
+		skb_frag_foreach_page(frag, off, len,
+				      page, p_off, p_len, t) {
+			vaddr = kmap_local_page(page);
+			ret = io_zcrx_copy_chunk(req, ifq, vaddr, p_off, p_len);
+			kunmap_local(vaddr);
+
+			if (ret < 0)
+				return copied ? copied : ret;
+			copied += ret;
+		}
+		return copied;
+	}
 
 	niov = netmem_to_net_iov(frag->netmem);
 	if (niov->pp->mp_ops != &io_uring_pp_zc_ops ||
@@ -596,15 +701,29 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_zcrx_ifq *ifq = args->ifq;
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
-	unsigned start, start_off;
+	unsigned start, start_off = offset;
 	int i, copy, end, off;
 	int ret = 0;
 
-	start = skb_headlen(skb);
-	start_off = offset;
+	if (unlikely(offset < skb_headlen(skb))) {
+		ssize_t copied;
+		size_t to_copy;
 
-	if (offset < start)
-		return -EOPNOTSUPP;
+		to_copy = min_t(size_t, skb_headlen(skb) - offset, len);
+		copied = io_zcrx_copy_chunk(req, ifq, skb->data, offset, to_copy);
+		if (copied < 0) {
+			ret = copied;
+			goto out;
+		}
+		offset += copied;
+		len -= copied;
+		if (!len)
+			goto out;
+		if (offset != skb_headlen(skb))
+			goto out;
+	}
+
+	start = skb_headlen(skb);
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		const skb_frag_t *frag;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 01a167e08c4b..ff4aaecc560c 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -38,6 +38,7 @@ struct io_zcrx_ifq {
 
 	struct io_mapped_region		region;
 	netdevice_tracker		netdev_tracker;
+	unsigned			napi_id;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.43.5


