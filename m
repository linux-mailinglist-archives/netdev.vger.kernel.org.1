Return-Path: <netdev+bounces-234197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C24C1DAC2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26EA1897933
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F030F937;
	Wed, 29 Oct 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Jchfgv4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A92FE589
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779820; cv=none; b=ChJKh71BoCfpUcmbFuhwFj/3wCQcYCd4BLe/TNOJnKCMOiKEEv3c4ir+LcAscEknTnR+RTLoYw/5N4lU9K8VuaLNjwhocxY8zgLd4yNQmcIj08vqa65hQhSlG7S4gGKmSlqjVNUj0cWZ7wAKteRkv+KLsNn/RsbXJNgMgdLJk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779820; c=relaxed/simple;
	bh=gA7TUjGBhry0GpbgloAHEvEJpy4ppVgDBtIVzeT1Exg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ7nSdguH2iRf0UVhqm7q5EmEcwKSfh8j1+Ji3UXTs+xqj+AfTCBlq9hRhZswhZvWin6d50uyDYco0gPKMqHhYIkCr8Lj7Pco0Ug7QHKAyXcXqZkekzui3/CmnKR/uztCwBuCQ9TTBF6xzOpfnTl9uQRsMaF64+83iJOtB2y7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Jchfgv4m; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c5333e7099so247231a34.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761779818; x=1762384618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9dBObmRT406lllHDqDAxRG0zqFNY+U9LLvr5n2IB7I=;
        b=Jchfgv4m0eKE1nrzbX7EwgLM6H/TRMgkTJfYR5ZqxF2IO3soeS9/nj5GzPutnRTw7p
         lV3dqPPwyK5D0G4K6VdlTsT4QwSZdlz3TU0+WN8ughU1IUa359vpEKIzZ6reok5mimtG
         EubAhlFbDKY0U+lHQ2v9bhnA9LqHDUaTyt+WjHMXvK6m6a7TJ5YJIO4lpwjeo8sGZejD
         AwuxkpotFUJtafF9RXy9JztHmIv6RhGcki8pR9rizrfUsARjMU2Ve3KQaAMbMWR6n8S6
         SXt1b81TRZ7ZqoNQ+8jDtZ4uGzF6iIbP01dbrajU+Jx6xDm5B3sS0JvUs9CP8WuRxbDU
         jeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779818; x=1762384618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9dBObmRT406lllHDqDAxRG0zqFNY+U9LLvr5n2IB7I=;
        b=uOlHeFtNlKIKj/rW/6tei+EhKcU0uvYPDhnJx1uJlaRx1Kl6GDFZCMr49P3KiHh4fi
         7ftis/KAZWD+NBROcM3HfXKGfmBnzWziLSRCAkk/pZ2R8K+OdXFwYYMaq71QZiO1kg/I
         hTgogKFWSy6/IagNWtL+oiNr2pJXhRPAT3OZTjFkD7hzudbYMMVckZoCMlUW2FQ7h0q6
         ZqP4J71DupdVmqv1H2kWtNa6dgb/kzWBErclNRdFz3fvzICbtiUQL4gjY1UzGzAPWZit
         yWhIKLDA5jK3mUHzxlu92kwK2l4BWSSQ/4nahG5QkJ34GfEfLNKIjgE905S8WKDjn9T0
         NX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWAUa8IcfrpZS1Ab+L7HaNjdJBFoMxJ38ZMVnl1d9mwnmdE2Gp+HN5FAb4waDB+JzZ3iKqXO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp39O78hneOk9ZiHlaTqfLyFhDrtmJvXBXXE409akwxqOq44Tu
	vMmmiCPAjokU/FpdDkHrYThVIXe696qIy74ExP7WZtBgRmHBepDMJBftItP4WQDWrR8=
X-Gm-Gg: ASbGncu3AY/gRqgEKUCnxi2xp6EpJJfuSJkPSF3OEN6TXsibahYxYwuuEf5ktVXBmQI
	KpO3ql8pY0rHUSTz8T2516vaqzYF63Gmo9Pt0noucYHJnWHpMs9mscYVZRBeBW0AnEvaaeTW+NY
	CH3DthuYrHHBWgF1GRGqn8Fh1uV8HaVrhHcha6KaZl6su47CMRfFI7ubZhenYDFFvl3L0jT9g+e
	FYIXlPG5qfCzbJJQB2DTttBKbI9SHTHXWG6lK0/OZORJUc9mfg+/0yX33LFlUrV1rr0kqE2s0Kg
	uIgG7eDxBjAV0CfZ3uH79dhwtGGc1lqEsfWZMMzdJPV56aDFpty2bjSpPrZB2+2/cB2QICXYsp1
	oegEzXyOPEYY0+BXRSrA7lEKPz1wGFXHTXP5VS0GdIecphdMnoFtgIXt/RPfoCE2ELc+BqMvEd3
	SDkyc3tTm+yI++09XxMDo=
X-Google-Smtp-Source: AGHT+IFJkj7+xbfX8hP+Td6bz47/ohTUh2Zqo7qhyKw9Ic8u2t9liRmn2YQ34bw1MVMGvzYzMYSmjA==
X-Received: by 2002:a05:6830:6d08:b0:745:a21c:6a57 with SMTP id 46e09a7af769-7c68cf4bae3mr622971a34.21.1761779818248;
        Wed, 29 Oct 2025 16:16:58 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c53013505asm4567333a34.12.2025.10.29.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:16:58 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 2/2] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
Date: Wed, 29 Oct 2025 16:16:54 -0700
Message-ID: <20251029231654.1156874-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029231654.1156874-1-dw@davidwei.uk>
References: <20251029231654.1156874-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev ops must be called under instance lock or rtnl_lock, but
io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
Fix this by taking the instance lock using netdev_get_by_index_lock().

Extended the instance lock section to include attaching a memory
provider. Could not move io_zcrx_create_area() outside, since the dmabuf
codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.

Fixes: 59b8b32ac8d4 ("io_uring/zcrx: add support for custom DMA devices")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..5599883f8941 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -599,27 +599,28 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	ifq->netdev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
-					  &ifq->netdev_tracker, GFP_KERNEL);
+	ifq->netdev = netdev_get_by_index_lock(current->nsproxy->net_ns, reg.if_idx);
 	if (!ifq->netdev) {
 		ret = -ENODEV;
-		goto err;
+		goto netdev_unlock;
 	}
 
 	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
-		goto err;
+		goto netdev_unlock;
 	}
+	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
 	get_device(ifq->dev);
 
 	ret = io_zcrx_create_area(ifq, &area);
 	if (ret)
-		goto err;
+		goto netdev_unlock;
 
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
-	ret = net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param);
+	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
+	netdev_unlock(ifq->netdev);
 	if (ret)
 		goto err;
 	ifq->if_rxq = reg.if_rxq;
@@ -640,6 +641,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	}
 	return 0;
+netdev_unlock:
+	netdev_unlock(ifq->netdev);
 err:
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->zcrx_ctxs, id);
-- 
2.47.3


