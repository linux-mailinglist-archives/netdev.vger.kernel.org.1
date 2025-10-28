Return-Path: <netdev+bounces-233657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA5C1700C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 941A03572C4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D705354AC4;
	Tue, 28 Oct 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="sttCoi5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC83590C8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686805; cv=none; b=kkj/M804VW4EOy9c4ST3GAMaImsBciYZwxmLLhxHdpwIoO/5nTvoR7gq0CCKLqhczPOeFz55KHOGsPCF0AESm/1OxAQFmjQCvhgds73OLP7iqX86OIg/L8kw3qxrA0Vo7qlyR98MApTa7C3Um9GXeCogxxAkw3RB+bi32CmrZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686805; c=relaxed/simple;
	bh=NmfWWel/uLUgCXqnYeSfad/rdE/DuSTaCZQZtXRF7oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMLex6aQlgGZNsE9+MtReh/PtaCMztdmNNmDmGPHZiben5BuRBNJ/CwvO0DvQmEWolbVWDCWcIpNXcY51+BgiBICF6u+MPKcpvx6fRd0acSuRxpbNEmqQMWGhUzJ18jN+OtZbG+t7HD4Av6cheWtv/DZ3XeZog+2P4PiMEj6XQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=sttCoi5Z; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-654f5173629so196493eaf.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761686802; x=1762291602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lf/qKvY/6grSieEmtDItMT5V+0zB1kmOa/TLCMeokX8=;
        b=sttCoi5ZqHaBXmZ5VukAcK1rOBqtNq7ci2Reos64MRiWgp7CctXWsWW5SrvGa45wQi
         jxzVvz9lsxpx3F36zc+tBEptR0AQa2TQDG41FEFnxffbChiABG0AoXGzvRCfjQMsyzvx
         pYrAn6lbm2zJIPn7lPrfWRBKnpsZm9otJG7N0GM7F/uWmamJbOykB47Ki32FN6EBuCqO
         8Z7wC0oviS+z6HUVYtx2qJ3ATCyuGcIA44KWMVSwr3QFP4XgD21/HB9jsITkqVFN0XXJ
         M482A2No6ZIQhHpVyox8veUB3xQdsqRKhgwkBIj55/vybKH4P+xuHG2pLe4Yg9GtVPoe
         Gd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686802; x=1762291602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf/qKvY/6grSieEmtDItMT5V+0zB1kmOa/TLCMeokX8=;
        b=Fvk2nwzsH/bJsRCzKQfuQMVOVr3c5boD+a+1mhkhu8o8cIwaxX8s8ac7oWh3D6lmwc
         GmG+Yno1szunwHFF/CTxsp8X92OB9q/AeLCsxhNUm5P+owelNOZtgitqodrFwagP6KZY
         1RFQ8wtyADUvmSoyIJnszzMtlO5u0hUDmeTOyAOWlYxx2I0XK7EqAWx3MLU6J27AwI1O
         RowbE1cwc2rr5ht41fZRvplriGH1lP5vdRWwIpnHbffQeIWi++VEUZQ2As/nTMcVUWcd
         JEALavGGKvYUoLasS2JGkJkKB7B16W6x0qLTJefHBr5mUjcpLpCcfvOFwiWF5tAz/5Ar
         FGLA==
X-Forwarded-Encrypted: i=1; AJvYcCUJSxcQ9wyLEbgWwwaEcWpyNL1gYlL6cj0YF9Lj0r9QcmDS9m08JkO2Wm9/OPcLr8R0lF2FZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4YLi5j5bnmBztI//ZhqkHH1AiVH3IcaURTrEMtm3vHmNJRuk
	sugnSqclvHK/S5GyW/+v73z/538uG6eL6Q3B9hQvTgK8X7/ZjX3t5s88f3Rbe/zZ1ddiq+LQn8m
	XVxUK
X-Gm-Gg: ASbGncv3pet2CxktZXDtmnIuVLUl8GwwYpbEdB/xXCUKIVMFtT7ovjjT1qewm2UFbvH
	9i8jpFJqqiOU6xtnSr8vnDPv7b93cRqi/QTxAfjxsNas78P8D98LTT3Qrm45h75FAVx1H+6tdvo
	EC6CVAbUhruM0h57Y3lnYsEfn+NPvQnC92w/O5YWmt72tdCdzASg8e8OYHyah65HT8/qZ3cyBtj
	yO4XmzrpmLA/IDG1gP23qXLP1PQUlVy//1Yg4axSJjHCYGjfP+BemDuzszbYZ7yYbH/np1LX37Q
	EIY/R5JHNuK02s7/oNWwlxwhW7EvP7xvT1NbfgqIcMRyXdA8oQgaxA1lfLOWhkLY6v9kspMc1bf
	FfWv4awokH6RvLjRajmcfjNDn4tckNY+F0v30FM5dAA3J3pQ6tY0anPVQgN0AymOG6DCTDvJ8Zp
	S4fbXulFqSCHrvCZc9lB8=
X-Google-Smtp-Source: AGHT+IHuy9AWJkX2b6nDcGaVqIeZlLjcxye366RNKuvVZD0nP8aoe4Til19GdVTLQr4y4RAQuo6r5g==
X-Received: by 2002:a4a:b684:0:b0:656:3197:ac3e with SMTP id 006d021491bc7-6567011505dmr1374207eaf.2.1761686801746;
        Tue, 28 Oct 2025 14:26:41 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef2ae0d8sm2972050eaf.12.2025.10.28.14.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:26:41 -0700 (PDT)
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
Subject: [PATCH net v1] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
Date: Tue, 28 Oct 2025 14:26:39 -0700
Message-ID: <20251028212639.2802158-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev ops must be called under instance lock or rtnl_lock, but
io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().

Fix this by taking the instance lock.

Opted to do this by hand instead of netdev_get_by_index_lock(), which is
an older helper that doesn't take netdev tracker.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..55010c0aa7b9 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -606,11 +606,13 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
+	netdev_lock(ifq->netdev);
 	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
-		goto err;
+		goto netdev_unlock;
 	}
+	netdev_unlock(ifq->netdev);
 	get_device(ifq->dev);
 
 	ret = io_zcrx_create_area(ifq, &area);
@@ -640,6 +642,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
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


