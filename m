Return-Path: <netdev+bounces-166619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FFA3697F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BE17A37A2
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509441F957;
	Sat, 15 Feb 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Hv2y3sGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1EC14F98
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578205; cv=none; b=Zn2Ix1vIWt8DQhFJ9jQLQBNIpvNaNZoIarherHpZSoLF6pbT0ASkmCzTZSpEnFBpt7BvVABFw+7pNRyR4ZRuZ9GeQL5tSeKJdEs7VU4MwY59bsnt8WPYZykMW9WcFjcabk3pp7SybvTm8jnvNvVOdhW2e9fDjBGssDHu7IjSexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578205; c=relaxed/simple;
	bh=moxT/9tlqEGGqkvg89jEl7qnqkLxWddMi6wsJk9KyOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILIBK+Ub5FtFQJJZFJlC2h1XtFJuDmtA0tMj3jhezSwWsSOhCIClvufdGTImT/0aKXIu6juZdB1yElEtRmq/DxOEEUiSYo8ruEP/aXt4oazU7ZqtnEIdy4HNaonGKNz86rYR2M0SVEd/bxcXF8vrGsQxnLcfhh6Qwzm0T/RH3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Hv2y3sGr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8cf98bbso52232425ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739578203; x=1740183003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6McXPFUQHYSYEvRYSRp9lVm8DJpoafPAg8IZnzA+YUI=;
        b=Hv2y3sGrOOkWb/VZEERGqAG1vj1LIOJtaU+Du3+TlUbZG+TRBGgoPBY8poq9aU0MC2
         F0xUvANubrw+8DOTH4WkW6QPXAbR+BTgGdxBc/FW/Uwk4SgENLhR6kULK+SPHJHc2V6B
         XZ0eIlzXxrJyXxVHKPuwcYwCRcnMkxyA0D3ad1GpuZ4f++Zl/zyu18R1KS/+16XoeYyu
         Y9S/h24CLzFCWid8xyQmKhh6pSV01lIZBsFqN4jbZRGBIcvn1OMejYs9pmpSBO8Ucq+9
         xZERpSHyM1jubM5rU333XtgJQQAsJrD9jLiZdCx7nafq2BK3GCU70uaciqgzeiG6aEaR
         1Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578203; x=1740183003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6McXPFUQHYSYEvRYSRp9lVm8DJpoafPAg8IZnzA+YUI=;
        b=GBLfdwAvzvFkPcAAabyF5YZpyirja7I6TKKRJ5+VkWlnDt9ATolGGM04SiyKwlKHhg
         0yFcx19roKxIotaN+nf1JCrd10czfQzUwRq6/bEPhjw+aUKJEAjF/ig1SJ3BQgfW+YLg
         dCAEmJNoBnk+TnUilrKzKVGo2LdfNxXkZ8YBk6Gw/paVJ13lTF6RppZ9kCfEo2MGvonJ
         kY1As/MRdE8On6+1BgL94Tagi3e1kAwDNF1u6guKmJ3QCGbWTxqAo5Z58YGD46Fp/Y2z
         sQeaM38zjWQ6obPKddN9zKGxWPeHXl5xrb677d6fOK+OzLhj00Jdbb44lu7+/zrlV33d
         7h3A==
X-Forwarded-Encrypted: i=1; AJvYcCWt83kmasNKhI0iec6npw7uSOO94gmVQ1S9vbrpNDs0dw6rnu1ffghoqsTzXd/zPs557nypFQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgMVpSm8ph0OMVdYcocj/mpI5QvfE9F+PXRjudgr2knL5FqzP
	F8uhh5ScNnYttAPYN61D5mE9BR21wN8Kf71kikU94YAYPo6YL1gDTOpHiQp4XNs=
X-Gm-Gg: ASbGncv5Rj3HE6+G7A+RiS8acBT/CxftEcRfM35Zor28tFALJzvTUWNH6hnd+gXe9CL
	WK50P1rGwYlQh+j13h4ej0Tq/qumw986tU+5H5M/P7r3nzNNxnWonElAbLxnmbzoutIbuxDjFo9
	nwsCObBSHbdCPxYmFs67zwDj2tQVpeHl0QBN+dVa098G0Swg8eRsX+g2KDKZ98bwaKYphKpYkF/
	O6zqbyEQDd7/yQYgHqkW4UMIhBdPm6cogdrga89n2w8D55BoERRcVCUHro5kKziwwRKNAVME6A=
X-Google-Smtp-Source: AGHT+IFevbVH5i83MykE+u/7tPFQvttGF3Y4A0qYLAhpnjloJAQZ2GzCkWB/VjCLdy7ev7yQpcrcKg==
X-Received: by 2002:a17:902:c411:b0:220:d078:eb33 with SMTP id d9443c01a7336-221040ac0a7mr18352845ad.36.1739578203042;
        Fri, 14 Feb 2025 16:10:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53643d2sm34229195ad.57.2025.02.14.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:10:02 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>,
	lizetao <lizetao1@huawei.com>
Subject: [PATCH v14 03/11] io_uring/zcrx: grab a net device
Date: Fri, 14 Feb 2025 16:09:38 -0800
Message-ID: <20250215000947.789731-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250215000947.789731-1-dw@davidwei.uk>
References: <20250215000947.789731-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Zerocopy receive needs a net device to bind to its rx queue and dma map
buffers. As a preparation to following patches, resolve a net device
from the if_idx parameter with no functional changes otherwise.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 28 ++++++++++++++++++++++++++++
 io_uring/zcrx.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 04883a3ae80c..435cd634f91c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/io_uring.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -128,13 +130,28 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 
 	ifq->if_rxq = -1;
 	ifq->ctx = ctx;
+	spin_lock_init(&ifq->lock);
 	return ifq;
 }
 
+static void io_zcrx_drop_netdev(struct io_zcrx_ifq *ifq)
+{
+	spin_lock(&ifq->lock);
+	if (ifq->netdev) {
+		netdev_put(ifq->netdev, &ifq->netdev_tracker);
+		ifq->netdev = NULL;
+	}
+	spin_unlock(&ifq->lock);
+}
+
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	io_zcrx_drop_netdev(ifq);
+
 	if (ifq->area)
 		io_zcrx_free_area(ifq->area);
+	if (ifq->dev)
+		put_device(ifq->dev);
 
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
@@ -195,6 +212,17 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	ifq->rq_entries = reg.rq_entries;
 	ifq->if_rxq = reg.if_rxq;
 
+	ret = -ENODEV;
+	ifq->netdev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
+					  &ifq->netdev_tracker, GFP_KERNEL);
+	if (!ifq->netdev)
+		goto err;
+
+	ifq->dev = ifq->netdev->dev.parent;
+	if (!ifq->dev)
+		return -EOPNOTSUPP;
+	get_device(ifq->dev);
+
 	reg.offsets.rqes = sizeof(struct io_uring);
 	reg.offsets.head = offsetof(struct io_uring, head);
 	reg.offsets.tail = offsetof(struct io_uring, tail);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 53fd94b65b38..595bca0001d2 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -4,6 +4,7 @@
 
 #include <linux/io_uring_types.h>
 #include <net/page_pool/types.h>
+#include <net/net_trackers.h>
 
 struct io_zcrx_area {
 	struct net_iov_area	nia;
@@ -27,6 +28,10 @@ struct io_zcrx_ifq {
 	u32				rq_entries;
 
 	u32				if_rxq;
+	struct device			*dev;
+	struct net_device		*netdev;
+	netdevice_tracker		netdev_tracker;
+	spinlock_t			lock;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.43.5


