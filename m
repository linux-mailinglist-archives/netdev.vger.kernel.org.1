Return-Path: <netdev+bounces-131101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A298C9B3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827C61F22278
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770AE1E4924;
	Tue,  1 Oct 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I9CuXGuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049841E411C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826849; cv=none; b=VYWG92bsynLlDbUlJAtAcqEuR13coYiy66esjg+T5PYFmy9G3Pn8YNDCsmA00gZdZWmwq78V90Qk0P1JsgZ0BQOt84YqwLkLFn9cRylv2/pkNL82NmzBrb+FIWmaoNMy7Axkde9xVO2Q6X9cjrHQX6GGb1dvY5MGwF6m2DHZGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826849; c=relaxed/simple;
	bh=acO4k3Tl1873YqlB+9+oRM1/HbYr6wa8DEvdBbXxJoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxaFypc+NhPDgYk5D0vvlkprArEiWTJYQJ9xJVxXj73hQ1PNFZbmPZGj4CVWZx1emeIooTPIx43ZsJ2DhmrUkE0edET0OOv/RmPY0c1DE+7/2nWtc8EEgWH2ZfhdMIrk/7hWyqlUJ7yrpUbK8gHbJQ5tEXpNzfbe9yiYWH99csM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I9CuXGuZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so5043516a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826847; x=1728431647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGtnVysYWBB+XDp/kZF0mQyFvrv7Ut5AwNUz8on3uqI=;
        b=I9CuXGuZCTP3ykMhvyDAZ3l2VCzD+7AFe15fY10/SC64P7jfCeMu44RPAapDArvRNa
         +O9ayxq+2/5owICuq02oO5dZ9kAd00aJK+IsJ5aEuNo3NUOH/CRoN6i7UMAagl24I4Q3
         aJF29Wq5iOl8V13wSgyVBST713b896eQivgFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826847; x=1728431647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGtnVysYWBB+XDp/kZF0mQyFvrv7Ut5AwNUz8on3uqI=;
        b=ARzRRtDh6KEU9RAsWblAmJmxLjQd4N5noH0Yzk2ADuPHkuw+Sm6d5oWqThqPc8l/iQ
         3kxoMq8aU/MjhT+x2shSfS8PYoRFjWkZ97fpjHbMivXqD9fk93FilW9nrCkmzsa+IhAW
         GYD4vlknoNV+drCrHqfw518xsXc3kcohtniTdWGPlaHGpnLtLRjcc289Ismfe4DwwRsX
         rLsWNTUMhQb8kK1ZAApVU+sAc+U/BV4+crROlBFCfX53O86+vZdxrkFxGXZU29jaya0Q
         ajO3zTMatl9vyi2ULPjSpoRm1ZPr9OYw9VVpneawEyI+Cz+jXkNPfjEnWVRENgmjQkG8
         E4lQ==
X-Gm-Message-State: AOJu0YwwiG178joF7QbXDHePElM2/DGWk+ELdancphlCo2ImCTJrhwvE
	/hsMD0Jnh+LAxKP04MFDavSttilmVdXL47ieHT5OC8wuqlDWcaxQrQeBQODhacMnyxwpyGWMmYF
	2GWFPcnkJmaYAZwFkQ4okcdGgQ+XLi7kRyS8HjaehaI6CtHPyNA4N0i4f7FRkUqm3G6Y6loxADc
	5VtIMocu0ipdtL1ZFEx60cOp/A+EGSyUmQP2U=
X-Google-Smtp-Source: AGHT+IFCgBS+YgTB1iRrCXeD774tHuBkiuRdbbUI5qwujyFtDh9/oA9HeddTZv+rnPbzAgKNnb5EZQ==
X-Received: by 2002:a17:90a:bd0c:b0:2d8:aa9c:e386 with SMTP id 98e67ed59e1d1-2e18455c8e2mr1759138a91.14.1727826846920;
        Tue, 01 Oct 2024 16:54:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:54:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 9/9] mlx4: Add support for persistent NAPI config to RX CQs
Date: Tue,  1 Oct 2024 23:52:40 +0000
Message-Id: <20241001235302.57609-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing RX CQ NAPIs.

Presently, struct napi_config only has support for two fields used for
RX, so there is no need to support them with TX CQs, yet.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 461cc2c79c71..0e92956e84cf 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -156,7 +156,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
-		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_add_config(cq->dev, &cq->napi, mlx4_en_poll_rx_cq,
+				      cq_idx);
 		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
-- 
2.25.1


