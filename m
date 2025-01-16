Return-Path: <netdev+bounces-159088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04844A14549
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF58816B38F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718A2459A6;
	Thu, 16 Jan 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2ABNWw9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF5244FA3
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069444; cv=none; b=Hrs/do1iuBUa9If5asJWnLrVmBeyhOBYpHmmNzNWBK2CMEkm5UBcosbr4gTlmCtbVmlRewMTAvNvEEqe4r2QEEJ+YoxAaUHR+4eGepmsNNcD+MeMFvHRCQYvhNy/cLKodjTqoXFUxk+K7AbAWKEc7GvLRoNxOjmy27AYzh1c2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069444; c=relaxed/simple;
	bh=moxT/9tlqEGGqkvg89jEl7qnqkLxWddMi6wsJk9KyOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbWLDV/WEQUAtMM48HCHOexxhzzKX2wKHgErVU/mFM3cbuPVPPRvmGtQU91eFa0Vddz7KeN5Ce02mNhTibqqQGMgqy1jdLH0e/QosB6FBik+krOSryyU/LKRSEPhJ4JWVbRHO0xoCBcm1ezmVVsW3w23Mq2VbXGzOfhCKGTjlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2ABNWw9r; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2181679a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737069443; x=1737674243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6McXPFUQHYSYEvRYSRp9lVm8DJpoafPAg8IZnzA+YUI=;
        b=2ABNWw9rdgCycN+Zslx78MFL7Pm8surhUpDO7v+4pGWVRF+Hvz+s9GUBYQVsACOaJ8
         CKcwXv4/MEse5qNxtzEdGiagQ/1r9XvhIKlM8FNB4+9RYMarpFTyOauGREvNK7vTO93T
         i8mg/WVYz27Wyxqq7o7jsLNEQ5FstSVCD+GqJfbo/HLRTZgAW+zAJaPD0UIah0bteK4K
         qR59JCikTmDS2PVQ0LlgAdvQCkKooTPGHQ5h8ukqEeEPp0TFsUJvDFeCRGmdEihLJKDx
         GcuE3tXxlym7gceFaBbR8V+M8f/x+UBmKCjexPuDM/bxXNJobu3ThC8fjujPnsrNOHaJ
         TlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069443; x=1737674243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6McXPFUQHYSYEvRYSRp9lVm8DJpoafPAg8IZnzA+YUI=;
        b=PJ5CanVJ52xb8HxyVsMCFlx1aE/lTQvwZPl0kRiVViUpOE2F+ezPNq7ma+O6w7q8gX
         wL7u/rRiU6BHe8ar3QKWtdNtEYkhQujC0PBc3Jb+4KPXtoa42qLDsD1FnTVo2apnxCTt
         0sce4xp2no2Qmqml8OIdNVMutNaNrbqONyRUsR+kbNGqQLPaqk3DUfR1hTC8gP1ZCytr
         XKJ+g9U4i6+8cHnoS9Y7YPTHlKl4jZZOz0ocpD4X+9DTxafxeEEL4G/2HvualR+W41Zr
         /jEI5FGfnHsZuH8ynNQ48ah8h542cOmRguDryG1eEGt7Wb9ETBeyvmV4aZHMlHL4nXvj
         OICA==
X-Forwarded-Encrypted: i=1; AJvYcCVCeaR/3LXPyzzbWrZkQWvVrphBvx/HmwjWQyjBmRKIEb5tojuqYTi7vpfDxdvm703r/0D8kqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWa7vpoUj2EN/q3P58ZeI9rMnT7lULiQ0BrCKZrudzdQp6Tbrt
	XDhZjheE6JGaAzRC8HXibKUoxf9DOgODDr2R52Ydvr6+s/m4gn88t6sLwQWADj0=
X-Gm-Gg: ASbGnctdeX6KoXeMjuUvhD69PKqsmhEhzPq2/KYMUXhT13ggeegPaJ/uPS2kY+8afZU
	iHQPul21I2RRa0WVfnGDe4qpQckj6Pg9SxXJ8d11M1bQ7KxLJKiQm6ceH/bohh02jsBFOMwK/hb
	e/Ju6841mW1GziJuSHS7IyDHc07vdz63VuP3imETlTOkh4cxU/vZRc8rqUuvhPnOo9jsO/deh+k
	Ax0n8kocA7fdywXp92nYba9h8IL1fxNKbvTjjESVA==
X-Google-Smtp-Source: AGHT+IGqq7ZxkRc3/1V0W4uC5/iqUYVT44pqYaPtChWDnrvoE36MzzgrU5K+BZPNWwgUmJqah9EJaw==
X-Received: by 2002:a17:90a:c2c7:b0:2ee:693e:ed7c with SMTP id 98e67ed59e1d1-2f782d9ea43mr631647a91.33.1737069442711;
        Thu, 16 Jan 2025 15:17:22 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2f31d6sm3840917a91.40.2025.01.16.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:17:22 -0800 (PST)
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
Subject: [PATCH net-next v11 13/21] io_uring/zcrx: grab a net device
Date: Thu, 16 Jan 2025 15:16:55 -0800
Message-ID: <20250116231704.2402455-14-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116231704.2402455-1-dw@davidwei.uk>
References: <20250116231704.2402455-1-dw@davidwei.uk>
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


