Return-Path: <netdev+bounces-234816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3BFC275FE
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0974247A1
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FB255F5E;
	Sat,  1 Nov 2025 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QTHANDRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9986257851
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963896; cv=none; b=FFu6ZNuHxoevVTvfMK20/Z0ifDti1DHSXw/4x0ia4wGAZrIEjgk8BD5MKl7xK5k5OZ5rbj6CAWeLPSYbolyKdRL4/q+zz6NvV/KmeI6GK+9uP+5gduaRjWBGurpJXJbs3NHzaayCPLcY7M7lK2JRnxt6VEJ+AotBHEhS0X1xGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963896; c=relaxed/simple;
	bh=b5yo7g3MZU1FijxRkUhNS/q6XXJNwXad+y5lAYbqm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUDx/W5v0V8njUiu20R76d8rqyl7oBUkvemvHAud3fCbF5MlOtp54XECcQzDgbvcTSUtRFLp/mWsYzkJwXcW0BrO5TVa8iyYTIn1hbfQNMKfIA9Cb+A6NII7KD+B6JhY+LZlQufYfq8Y4OlT+FT4abgkcimLLU9z0Jepip3LBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QTHANDRW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44f783add60so1620678b6e.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761963894; x=1762568694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMtSUVt3oTxs4d8Yt4wZTEMxA2A6WcjkTSoUILrkV8c=;
        b=QTHANDRW2sNLFuuot7DkLuBz7ojrlt6xEsVKBG7HNKWdfXbEYVjcJUoxa/jIyp+NGI
         Zai9Vwp2TRG4C286PG0CxRBUmd1MfrC4eZ0dKqYtYwCZqbH6N58hTp5ny9L/AC1G2R0F
         N0ikg1NzI3oRf5JEV91UF4eIQox2NUi3DgI+/4AmK6TP8u8XDLWMXdP9vIKoyyALqelI
         upJmyQcIOAXYmRzF3Xm+vc0GPSnftGY5d1scVLlgpkiBLxzJgdiRPwcyJ1Fkeh9OXmOB
         RxtOWyXEO6S3rM71vm3OY6yFrfWGHs+bBe0UvwOkR09KLUqyCBaSQPh798V9+4FiTWBs
         zv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963894; x=1762568694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMtSUVt3oTxs4d8Yt4wZTEMxA2A6WcjkTSoUILrkV8c=;
        b=f98a6+ZXPXi7upe9RdRCBwBH1Otwoy+2kbW/ff84OBcyqTmrbeKZOsrysbliKa6V/8
         pozldBKxKFpn7KthQ62Q8ghIQX+VFhwbqmeKtDBPTGcN1dPd5l6rZ2/regJjsPK9+QVj
         4bUXykIAIoS2NpW5t93E3Sc3sIlcTp7JQm5/ZO/sGPcXAY0zACKE3eJCyLk5GBm8k0a5
         4N6H15j68IdxKn+W+I+rX9j4dTYacoEWM0jVun/dLhLgMOGHgnr84dWdV9NuIqpwE+ok
         r2/j7nDdjUe/Tj0rJ6w3hx3i/6wMcgNkloI/Rfcz5PSQzIwwaJ6jJ7UiEJrcdPn/ni0u
         xGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV8etW4arU4VCNTt9AhjX1CJABg48BjTG2XN/x47u42XknB0lhhDGjrD1H8sxoJWrmFB1fErw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NRUPNisle6JM/EXYqLaopqCnkZgx81eNZeoxQv+t8GmV2/w2
	kmzauAue5XZ8Mb7t3U9E3FfdSR72tBbaBG9z/Rg86gPrMIumZoEgVuV5EbaX5E2zYIc=
X-Gm-Gg: ASbGncur8CvcSsHCLGWm3qao+g3PjwgOsPv8ocV4fSKOLDXoBruibvOTwEZ9UBTgEyr
	D5pwBjQezkuCuLuJ9moGzCRIdFsC81Dkee9R6Tihb9olCFerUxgDMpH7TRLAQg1/pBKjsL5K2jO
	VjdR6SElk5nVjQrb8lUa0fIg0MNXrOE5alQxcXYOuxEf7rI6BL15NjEIWq/Gm4zObbvQsPsmEZE
	cwoFyrwL3xPruaSzwzevMkFrhFJJWQ9lJiIbQof7ovZmuHeuQKQdqnEaj6JwuDsDa6hhI3eu4CK
	pBHkqzt7FFAFD5nEOwHiCWb+oB8fSOze6ehRSyCyl5Od17A0qYgdbGNfv9Z4ZRA5ot7jfLOZpnT
	LPkZSYEU77dFoKYGeel9pg1yX4aqlVjJcIXrfSduD0WOf1xHjv6j6eG5pdLKeSVS+B2PCAajW6N
	gMolhNDAB+izyAc4jmekk=
X-Google-Smtp-Source: AGHT+IFZuGg22ixwVqdlXJEvkn+nh1eIMRzgR50YHgoqPtaBQRHCnOKhXy2/NXZYs/uhgBqjQUJOuw==
X-Received: by 2002:a05:6808:508e:b0:44f:9513:3dc0 with SMTP id 5614622812f47-44f960413a0mr2643162b6e.61.1761963893682;
        Fri, 31 Oct 2025 19:24:53 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c699d9f305sm1023372a34.22.2025.10.31.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 19:24:53 -0700 (PDT)
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
Subject: [PATCH v3 2/2] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
Date: Fri, 31 Oct 2025 19:24:49 -0700
Message-ID: <20251101022449.1112313-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101022449.1112313-1-dw@davidwei.uk>
References: <20251101022449.1112313-1-dw@davidwei.uk>
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
 io_uring/zcrx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..4ffa336d677c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -599,29 +599,30 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	ifq->netdev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
-					  &ifq->netdev_tracker, GFP_KERNEL);
+	ifq->netdev = netdev_get_by_index_lock(current->nsproxy->net_ns, reg.if_idx);
 	if (!ifq->netdev) {
 		ret = -ENODEV;
 		goto err;
 	}
+	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
 
 	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
-		goto err;
+		goto netdev_put_unlock;
 	}
 	get_device(ifq->dev);
 
 	ret = io_zcrx_create_area(ifq, &area);
 	if (ret)
-		goto err;
+		goto netdev_put_unlock;
 
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
-	ret = net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param);
+	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
 	if (ret)
-		goto err;
+		goto netdev_put_unlock;
+	netdev_unlock(ifq->netdev);
 	ifq->if_rxq = reg.if_rxq;
 
 	reg.zcrx_id = id;
@@ -640,6 +641,9 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	}
 	return 0;
+netdev_put_unlock:
+	netdev_put(ifq->netdev, &ifq->netdev_tracker);
+	netdev_unlock(ifq->netdev);
 err:
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->zcrx_ctxs, id);
-- 
2.47.3


