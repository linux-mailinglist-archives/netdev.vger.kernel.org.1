Return-Path: <netdev+bounces-229646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4855BDF3FB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636AD4837D2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10052EB5A1;
	Wed, 15 Oct 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO/Xyg0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686C2E5B11
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540454; cv=none; b=scLtNFUCOn91rVbM4cB2OAx3KS1+EybhGiUgk/Y0TJf1DptsfjDmWzlisEjvm8VgKPI5zzL2ddrxhaazc5FcEuu9WQGK1w4Cb/GkrnpZ/BhVGit98g8wgKUK+UrFaa7wHEbjorVLbt6l/g2b3D0rEZzA9uB6o7tbrTuOY2HEASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540454; c=relaxed/simple;
	bh=RwSzv+8gQB1+H127TYDuoUR0wJ+1TmPyBKKgVRzUJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/efYm3GeQ9wA9s6R6pVaJ0Z8QiExzf8zgf6dKJbSfUifoSD/ag33rSyiZR/jb6Sysb8Q/1DXy0yV5dpp6Kyctxm3NFV07c2BhqmPToD6TU/vwokhlKfzQG2lcFmzt2ssPyM3HA6T5e9+eyNwsoADimNNKGFYqJWP4iQGRa2Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO/Xyg0w; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b57bffc0248so833595a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540451; x=1761145251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm72wEzVMr9IsZ30OMPLzaYiRU5ZuIof9e+ZCzfB2E0=;
        b=QO/Xyg0w4qeP5j4izl1rOx+O+69bickpQlD22a2hPrnBnbJ5ooWh71q7FCvmyoiXcZ
         KyxmElcCQMqyga8p/IS75BR3BVDkxaLeHqYfyB1PBOropWz+V4YZoeT3p0EkRdsGmQoe
         IqsmlKZAeHppZt4LJ4qab4AG5K4yTPRTSv9GjR1fZdbVSaobVbGwA0LRGaD9GnM9LbIS
         TW9W1MBRHH3QLmKZfrfohf+2rWYX2AEUnsMyJpSaj5nZb1Ku7sTYcpCv3E2mqPfacRPX
         CVKJGGagmhL4qCkBvVmqdgqXAreaX60RqGl4U4kMxdjEomeaYe7fiRsxDx1dBJFaiHFE
         NUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540451; x=1761145251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm72wEzVMr9IsZ30OMPLzaYiRU5ZuIof9e+ZCzfB2E0=;
        b=cT645K11uEcGEHhx0RA8P9Wti+cAD1zS4KYQDGCOp5CGxKox4SzKmOCkBT2fjrRZlp
         cdt7JhqKdGk5OCTZ5MLxmRTQ2MXCKXrOg8JgdVARVeCgMg4him1Gdamw6qxZ/I4TKBiF
         o4wtFEsuV4uHdi5XfVuPWLy+Kblyi5j1gzqAGDIAd8+u1iK4iKKBLdYxOZYXfNOv+nTd
         QCmtxDkncWq9YpkZ64dY6jR1UiJwQAbV6xHZJj7Napzxc1c50WGOtO40gf+jwFeM4kqA
         Gr8rhhCT9f9ueTiPG6n9Twb5/t1T9Ly3J0nyJjNZ8SGNaqzMeKgF9cKEIHfZH0ruwd0u
         ep6g==
X-Gm-Message-State: AOJu0YzMXeNnXAS/9ERWWcf+2pyubCwt4RtWKDTKvV/FSfmdxGOq0gQ8
	u3khRHx6AfgQBZt6iqDO5oPlRu1enMVN30nyy7izlU+b+H0Y8vLhPZhE
X-Gm-Gg: ASbGncu3QJALEv5xkDEC2cAddJ7O+6b+/o7ZCLQ3j0P7QGaBIoZfMm1NFGCaWurilIO
	PV+FngRyNHAAWIATMNCSzvzQOBYuDyxVf92Z6q69mITkZAmMAcNd5ws85MtPdm3eDzYr4Ypb+BO
	/XlqKDyTVoNVM86XVCGsgKyLOjv+ziS4+R0KcXGxhi6UNRebZUrZaliHDpJ7Fv04uRzyJox7KeX
	4ZJbsQzWpXdwtevvcpOyfwk1naaJHBSIolkCJ5QqtE+qkGt+uqE1iWH/KAvEltPQvl0pPxk1Bdw
	4oz5p0IxW49WsP0rt7Jc4NAWWzVciRPbed4VE6/pKKTHTutRNLVV1VYOSIjiTmBRe8wrkVsks1L
	qtZEIFucCiP/kMIaVAtoHf2d5eUKZOTc4ON7zBaa/rjV/AgNQN2N8l+wE5ZApjx+rkxrFzvy3DA
	==
X-Google-Smtp-Source: AGHT+IHL1rGxPYL4gon+pNH5suaietGYpXTK0qY/tw1k5qOqO1eGaSYosHoMCad+WaJfRavoeJ3/NA==
X-Received: by 2002:a17:902:d4c2:b0:274:506d:7fcc with SMTP id d9443c01a7336-290918cbc9bmr5514205ad.6.1760540450611;
        Wed, 15 Oct 2025 08:00:50 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36408sm199642265ad.91.2025.10.15.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:49 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: ravb: Allocate correct number of queues based on SoC support
Date: Wed, 15 Oct 2025 16:00:25 +0100
Message-ID: <20251015150026.117587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On SoCs that only support the best-effort queue and not the network
control queue, calling alloc_etherdev_mqs() with fixed values for
TX/RX queues is not appropriate. Use the nc_queues flag from the
per-SoC match data to determine whether the network control queue
is available, and fall back to a single TX/RX queue when it is not.
This ensures correct queue allocation across all supported SoCs.

Fixes: a92f4f0662bf ("ravb: Add nc_queue to struct ravb_hw_info")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 69d382e8757d..a200e205825a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2926,13 +2926,14 @@ static int ravb_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
 
+	info = of_device_get_match_data(&pdev->dev);
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
-				  NUM_TX_QUEUE, NUM_RX_QUEUE);
+				  info->nc_queues ? NUM_TX_QUEUE : 1,
+				  info->nc_queues ? NUM_RX_QUEUE : 1);
 	if (!ndev)
 		return -ENOMEM;
 
-	info = of_device_get_match_data(&pdev->dev);
-
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 	ndev->vlan_features = info->vlan_features;
-- 
2.43.0


