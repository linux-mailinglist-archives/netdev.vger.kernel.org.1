Return-Path: <netdev+bounces-156468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85455A067E7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2F11888E9C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCA205516;
	Wed,  8 Jan 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fY7a6lvR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA862046A9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374043; cv=none; b=CU72rFiryb8sQkfsmu11/Q15hL6vfuudsRks4ZSt/0z5ffNPGBolMlugc9mwXITeORp0vYpOqOlY+64jk6Pk+WMZOYKcUkYcsZ0NicZxmtXCHZeL8poC8TZLlbWu6r4TbCwpNCdSvLR19+8bDiMK09Zpp30dWnEiDnV7LfXcnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374043; c=relaxed/simple;
	bh=47+zvc2Ici6Dhxn2E8wYQnSlqsBoCJHtk3I1q+12dkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKOvYB39v+mRrJRWCr6HnUI1MapUs7TnxXuqD9orlULdhBbbNTQnHvlEZJ6rcxSnsRvAI8k9moXXHGBKcGJDfaJ0JD6lZ77A07xqUCWyl1Rc7Kix0KJ7a6b2er9PI03ibjzPLFoCm1XP/a8/ZMzXPQkEDKVXBWA73q4vbVu6ddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fY7a6lvR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so369867a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374041; x=1736978841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrJyIoqHvwSKUkoZTkSSHSYdDjrfAJzArFg5r7V7N5Q=;
        b=fY7a6lvRS0yQ/8igCbORVvnbC20kjRKmiv9ZyDCLgvONapvgXvFFddzINSFAjy2BSn
         OJv2FecVTUqm6npLoqbZYIZ/lb+cMErknQfALPCbdh5LS3KBreFjOsvL+2PNasoZ8FO9
         DCWPqi5+wug6eO3kv/fvBe/3PJOBcy0IOCp0OZvQqh4A+C/fj+ekLClw0xpMfc/xH/yR
         5kzYc1uKFXEZpP7EzdhAGDIGMxA3sfwW4MPwkPNoOsUNNXDkdEyIIJbPofsrKS0pDFgZ
         K+dYeCB6MyGhNVK3b9O/ZyAflPYA9QywqKmyN6GPjnHpGfxC0hPhDRUbR3Vx4OTz89gR
         QXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374041; x=1736978841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrJyIoqHvwSKUkoZTkSSHSYdDjrfAJzArFg5r7V7N5Q=;
        b=Hqn2gSe2uezf6smppsjy6dIad/5sylHK2dl0F/cXqYNFihXcNQm8W1RjunJJqettBf
         IRgRFESGZVpVFSYiBKixPTwsMHca8N87XeT5Jcky1UDhwC4IkBasqej73psuKYdblQO0
         zKa8xAJlh1FRY3npLWTeGXmzIC4OpIUbtS10Wc49/wzoVBoTi3+9DcpVJXZMeZXrL2m9
         Wpr+p4bXH1sbdBKNXnhe4Ofz4TjOfkgE1CfUtdj6z5lhPbExBW8RIu5CfXLXW247wJ2J
         M52mokhQwGurBkMCkOp5wsSEjoMLw3m2MPOLAKVm05mQqOToLpyEJw1eivA9j0pvE/kb
         Rl/g==
X-Forwarded-Encrypted: i=1; AJvYcCWgj0BvzWREYrSpgepSofc38gnhL+2ak5OFeGojXWcTW86dG4UqH8yejStyCyuIv9dQuQcK8sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/XZ24IGdMhE4UY9POwOkgj6XoHz3JwWPVxb97I5wshgH1r9F
	LStNK7e5Sp14bEWYIqjXy8DX5ZYYSfNrIkGYPNtV/qvltO7P1+2zLH3GuwNnPa8=
X-Gm-Gg: ASbGnct4pTLJLMJwYzyOd12ORhTg8UoF1jEzAk+q4jDMwjqWrTp0u7Mwb3e3+0gf3PP
	BQAWQSgFOI+fMdrGm7yXKPFQuprHW4CdBEfF8L/83iMDZ6YUfQbch4WEl5kNZmb7Ql6kmnhZFy6
	wuerpmGwM7kX/FUpEfakgSfntxcIOJpY+2oW+MXHToI7GEsommxGRh6Za+7vXgZAi5znziYWPih
	DfgiRPJl09lnrhZRDRvnvMbpbhmZN55DAPnlN8oUQ==
X-Google-Smtp-Source: AGHT+IGvmLmr2nz6de/uaFySICL6uCdtyb6A3NlfWNpmpXbniS3AxufBFSiNq5oEiDX1paYwMwTzCQ==
X-Received: by 2002:a17:90b:2f46:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2f548ea6488mr7112436a91.8.1736374040952;
        Wed, 08 Jan 2025 14:07:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a265db1sm2306594a91.1.2025.01.08.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:20 -0800 (PST)
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
Subject: [PATCH net-next v10 14/22] io_uring/zcrx: grab a net device
Date: Wed,  8 Jan 2025 14:06:35 -0800
Message-ID: <20250108220644.3528845-15-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
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
 io_uring/zcrx.c | 10 ++++++++++
 io_uring/zcrx.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 04883a3ae80c..e6cca6747148 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/io_uring.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -136,6 +138,8 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 	if (ifq->area)
 		io_zcrx_free_area(ifq->area);
 
+	if (ifq->dev)
+		netdev_put(ifq->dev, &ifq->netdev_tracker);
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
 }
@@ -195,6 +199,12 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	ifq->rq_entries = reg.rq_entries;
 	ifq->if_rxq = reg.if_rxq;
 
+	ret = -ENODEV;
+	ifq->dev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
+					&ifq->netdev_tracker, GFP_KERNEL);
+	if (!ifq->dev)
+		goto err;
+
 	reg.offsets.rqes = sizeof(struct io_uring);
 	reg.offsets.head = offsetof(struct io_uring, head);
 	reg.offsets.tail = offsetof(struct io_uring, tail);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 53fd94b65b38..46988a1dbd54 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -4,6 +4,7 @@
 
 #include <linux/io_uring_types.h>
 #include <net/page_pool/types.h>
+#include <net/net_trackers.h>
 
 struct io_zcrx_area {
 	struct net_iov_area	nia;
@@ -27,6 +28,8 @@ struct io_zcrx_ifq {
 	u32				rq_entries;
 
 	u32				if_rxq;
+	struct net_device		*dev;
+	netdevice_tracker		netdev_tracker;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.43.5


