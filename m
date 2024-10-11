Return-Path: <netdev+bounces-134660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDFC99AB73
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0218CB21711
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801111D27A0;
	Fri, 11 Oct 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yKZY1rdR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5F1D1F7F
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672376; cv=none; b=m1Ke6ej/PCxzfrPHQRUoVrMJAOaN0Ds6kAtZ4AoTie7WcZSC51MtX+Pd8OMfzE5XmJHBE1PWupVuQK1hebrkGgsBGIufqBNUIEgKcvRZgHHfWm8dpuVujrd5wp3Er2qYiyg3bKPayYrYD/oDNP/jFqeV6tLyY4WUvAHOq8u95Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672376; c=relaxed/simple;
	bh=RIFYUWJWd7bN5cBhz+koUNJF3wVi5EIvLaiIKSbtO7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f40HjfZQh+jVX2uwtiORxtLoONxQ+5jPEjX0mK9aqJXof+XdfB4R89h8hhYsucs+DsS/6rMKUaEa75trBaMa3JCpeoVO9ogHTXri+XSpPIl6+qpjfbO0kQPf+q8BsnL6yLzfVRbGDR87mteV6GCFqySyNmHdOj9FoabmeljiJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yKZY1rdR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so1639471a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672374; x=1729277174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qutnxq+9ITQDx+pSqPE3IDGupovZNJJRS/Je9OZgZtA=;
        b=yKZY1rdReVg9EwvUDrb1RBtzzj36Fswmrf8LZvEUd57owNUUHS7k785/TEtPZopCJr
         lKjFUT1frA/bwPFQ59W9n28WeLpoDNQAVwcuDKQkBWcBrUNYgjs+wIy9OVCzKabxkPGN
         dhjnS2YLbXw0xaQ40w27kDUj3MWHZKa/QhQW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672374; x=1729277174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qutnxq+9ITQDx+pSqPE3IDGupovZNJJRS/Je9OZgZtA=;
        b=duMcHtdM8vMxW49lKs1k4lNbNsvKSumIX5P1KDLuG4fJTX8E6CA6W9BSyT1IcE/3Id
         oKPXbsNRa47+XWeEPbhDQAbsp8TNdELBeuWzJwCC4zguTgUQWGw4I61gZ9fCBDwH7PIb
         K/CnTeQASYZe2rsgy/MGZyDVcTrQYrgHDtAuzL6Q6g9Fr3eoeh9X6Cvgl5ECYe2Xv3I8
         HHT1hAlCCkyMVYWGPPysDrYkrV1mNS4MDkrfIzos+mWg9Qg5TdNz0ZbSrleoFjY7H0Mr
         AB6dXKXOwkSFcUvQ/4duDZSf8dKt2w15wMQry8W8Mg/+4kTbDkg+uT93GRJ5XzCsGayi
         Ju8Q==
X-Gm-Message-State: AOJu0YyLlpzlZKKqtd2C/5ACI8yV/lapRkbPdNKhh2MfXYZeMSuLbOsn
	yttVOwgS5ZKVSZ7gyD+mWNyR3h7HKoquZ8yKVtTrURglRQ5u8Dg/kxtlR+QLHiNvjN0XWDvFeMB
	IlIY223sZ2IJzoxxdY86Te7Gv+ZBlICdTQWY2DO92dYrIc6l/SF5pUiAkea4fiRpCwznROE3mDy
	xVumq7iQaOLKsHSAKrv11zteVx79HCTLyKR+Y=
X-Google-Smtp-Source: AGHT+IGSvRqPkZgaNg6prJZocJDduEg5S2p6+ufKif1tZ3kYV8SUhwDPKkp2QencXRLwI99kDBw/Xw==
X-Received: by 2002:a17:90b:3b8c:b0:2e2:ac13:6f7 with SMTP id 98e67ed59e1d1-2e2f0a4d6b8mr5021240a91.4.1728672373888;
        Fri, 11 Oct 2024 11:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 9/9] mlx4: Add support for persistent NAPI config to RX CQs
Date: Fri, 11 Oct 2024 18:45:04 +0000
Message-Id: <20241011184527.16393-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


