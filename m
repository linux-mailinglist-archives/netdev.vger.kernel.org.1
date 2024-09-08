Return-Path: <netdev+bounces-126297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234B9708B8
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338EE1C215F3
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163218005B;
	Sun,  8 Sep 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HWjZbpdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC017C23D
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811747; cv=none; b=fdPrg8+V85h+j+MUf3SBi4IsDNtDuT9Z1lKn90J8t+44Ja5A3A1dirCy42rHVzS7PnvHXqv/mDgEAIz3il1AF1fnSlG1r1Kcf1Q0KWRWoHt8ELqgMe1yssukB8BuO6dwHdOIEHYtvr4Aje0Hf4j//VXK7carIO6Ea968raUS8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811747; c=relaxed/simple;
	bh=HIV7bkoPSQ3rxlaFpK7J86ATOFDCNnMGhMFf+TgF5jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4JyxgvzGj8kSsnY3WsMmZOxL5Y+Y2m21+2gumdkWv10pFq/QH5lI0dH+27MDUmNWRI1RmJlqlnPeHLbh0DJjR8b6LMMK05G3kfN8TPNS5uNS6EFGnh7QdYAQZ4BrA5OZtOLFa7YyeZjHUbbp8ntV8SnnxtonspLRun2qBbQI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HWjZbpdC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206e614953aso26464945ad.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811745; x=1726416545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGhj6cfvUKa56g6O8vcdWhred6v1jtnORdUuxs2iulk=;
        b=HWjZbpdC7/EXlidULkCI1N46DMduufGoO6rTjl3UCirvdYy7vu0090SK7CU5KXtYZt
         LULa/5pt6JfNsFH3Fvp2r+q60+X4ywZI50F4rPBhMuAUM5/X8mL+dP3NXOThjnejSvsX
         CIT5tqU7SGwlOqZPOzZsoBnGR9xT1bcQ5o8YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811745; x=1726416545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGhj6cfvUKa56g6O8vcdWhred6v1jtnORdUuxs2iulk=;
        b=egERvb/3+V9ddLnSTP19VFnrFFd4lrulEhX0AJzAECD67Aj5IzKr8zVBgrBGEBEVYf
         +5pahrpqLipx2h1zEVvydtxbX4B+bb9Qb+UeZYW4iMKnuDCh/xMRqRAhJTUFMjpg3C9a
         FYbCQ0O664xvaPGEq/o0Imar2S6cEFjRYCz4DY0Iw9rcUYcJBxYlsrizdsF4aa/CZJ7R
         o74BEhgx3aEPhneLPK8TWISdoqW+ksLiU58waP4EhBf/uyKJ+LEmIW8WO7F9AXR/ffwA
         wm1kC2zMB45J+DKSIruNdFE2v30FNkdNFCrf1L0dopjfbS9Aw08ZkuuN14SKBrLsBbby
         LA1w==
X-Gm-Message-State: AOJu0Yw7E44LJMHDshZaM4wvUuAbVDLnCYrE3KvVth0/slcWRq9wKMfC
	HmxrM8CdJ0KxLnyUl0hRQDYSsOToCfiO8b+mE/ki1jxGFm0yXksDUx30k+r+OrTQza4T5Emsh/u
	LG9PcRtfFKLXKGc2nVIunQZUrHiaxB7895a2I+B4Lhw+Qj46D46jPQdZ8mup+agFlpcEi8e1xIe
	XdUWcBd0D3ypxFdGsAhh/g+sCJKXPFjq+EfSC0edMD
X-Google-Smtp-Source: AGHT+IFQURgAP0IwRMpYNE1DAaAqoQ3640I7A6bdcacvbt4VU16dYwn8Pnh0y3O4wA8pyPK8qtXIIA==
X-Received: by 2002:a17:902:c94f:b0:207:c38:9fd7 with SMTP id d9443c01a7336-2070c38a075mr77160875ad.22.1725811745045;
        Sun, 08 Sep 2024 09:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:09:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 9/9] mlx4: Add support for napi storage to RX CQs
Date: Sun,  8 Sep 2024 16:06:43 +0000
Message-Id: <20240908160702.56618-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
RX CQ NAPIs.

Presently, struct napi_storage only has support for two fields used for
RX, so there is no need to support them with TX CQs, yet.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 461cc2c79c71..74f4d8b63ffb 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -156,7 +156,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
-		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_add_storage(cq->dev, &cq->napi, mlx4_en_poll_rx_cq,
+				       NAPI_POLL_WEIGHT, cq_idx);
 		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
-- 
2.25.1


