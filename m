Return-Path: <netdev+bounces-69341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160984AB5A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 02:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE3286705
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AD818;
	Tue,  6 Feb 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Sr9CGfdi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F31367
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181434; cv=none; b=GtQnOnvszrXpLb5Uge2UUAH0e1ugu4n3s9Lr53xsN8yZsjvxLJkTjdQ9MquB7a4annop9TVbGBpKc0aKiJpedSwPchZrTURrX16qOx5TycB+nK36/mGRV53GYWI7E+Fnjh478/mY7lp7mDyUn5V2rSrucndLEZ5YgraHuoW7+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181434; c=relaxed/simple;
	bh=GN8pFqxw1wkOflxj3+uwoDX9l7KpSO5N81FIcCJW+eY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HvTRbq0SJ1iPK2emqQ4pLUnxKTiU+qADlns2fOVEZ4Z0V3D8SIndfzM5X0wCIA0IFciVKnFsNZVYlvGN+UNGSAA89Z+Xu1Q1iuAalIOzX77xdYv3NIhXLbXUnuQl7k1nDV8hiFI294JiiZ8dSY0y7Es2OBh92HXk5MdLQ8kHh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Sr9CGfdi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d98fc5ebceso10968615ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 17:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707181432; x=1707786232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UpGK/8quWyQ2jfJsKee0WYTf6UqcAk23gt4egweK5Y=;
        b=Sr9CGfdiyiylYk2PxRtg/ABeAok/vi8IdQs1wXthyw2BFAadyD4MrXuhMADIHh+yG7
         uVsSMHgpE5XqErbQrNTxibsemvpXz218rKjhs6c5aq8LmKSk2719IqsGxkWuS5JX9GU9
         9y/I7tx5/vQXTF4ILP7J9p4rB+GxFyM6r5acc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181432; x=1707786232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UpGK/8quWyQ2jfJsKee0WYTf6UqcAk23gt4egweK5Y=;
        b=Xm/EMJEmxmjZwAvtlLGDa1CQYcN3IHY6HCF/dFPOl4uU8Gtw3oq0/sc5yMfB+uPwCu
         OyczCfFweJVTtW9zEIrI05krDYLMs5gin2f3413J9J+OJ2LtGKuqjJvmGv8bdIXCn20n
         xUabX9AeYLUOKrpeBeuhdtCdJ+k0dKOOhGlatVs+rveIFJi9hfVrDLefwEsKCNYwOy+E
         H7QwHRHdOJltSvTVckNVu0QUnyd0y25cKfNMoAd5itIQTt0h/L0HgaEX24dCMhBCChG/
         1OSfHYDDAFw3D/iifYl19um4/Zz+rLG1rUPnR1+eBCFPvkJdPET6T6Tk9qlXgqF30ntG
         sW7Q==
X-Gm-Message-State: AOJu0Yx1iwoljHLAnkNE6OShlcu2jvJO0dPXpS/dVm1BK6ImrIx1YgjK
	TZN7qtNyXb8jx60D5V0TDAcYEIcz+4CQQ04yBRPfKioRAFe2/uwvpDVMf67wUp0=
X-Google-Smtp-Source: AGHT+IGgcWKaGbgQ+OjYAeU+VZ6tswEkbpCphRzNKQlMBlsDElczklUlhg16I57yYDooF6YpELuxsw==
X-Received: by 2002:a17:902:e84c:b0:1d9:7e40:6c2b with SMTP id t12-20020a170902e84c00b001d97e406c2bmr199379plg.32.1707181431916;
        Mon, 05 Feb 2024 17:03:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlW1QEUwNY4j6T1hK2c9iDQA5IhUDHQHMqlyZHZMjEnpOwP9l+AnmF6h0ehaDH3TNRd2wv5Dsv+RRuG/jkLvtU0Fzsm7NzyXbZICIafDj17ZnkatMKv/D8diuSEniq54y1b48ufvKd9JxhQ331+zod1iPCyJf5tQKA7jrh3P5QRrPWE3XQ5UVdatKfz7wmmQnTVR9+6bHif1o3nwC377N3YJh6kwzqPNE55+AhGfEFAQznGuLC0oxriP/G/qFyMJvrmQqOeDVhQVE/lfCrOhEJTBHP0L8OCW88kjZrAqOy0sUNaIuODVMJ7ojYmqasLXJiiUi1M0s9P3ESurRcYasI
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001d741873e4bsm517838plb.95.2024.02.05.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:03:51 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: tariqt@nvidia.com,
	rrameshbabu@nvidia.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next] eth: mlx5: link NAPI instances to queues and IRQs
Date: Tue,  6 Feb 2024 01:03:11 +0000
Message-Id: <20240206010311.149103-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx5 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55c6ace0acd5..3f86ee1831a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -768,6 +768,7 @@ struct mlx5e_channel {
 	u16                        qos_sqs_size;
 	u8                         num_tc;
 	u8                         lag_port;
+	unsigned int		   irq;
 
 	/* XDP_REDIRECT */
 	struct mlx5e_xdpsq         xdpsq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c8e8f512803e..e1bfff1fb328 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	mlx5e_close_tx_cqs(c);
 	mlx5e_close_cq(&c->icosq.cq);
 	mlx5e_close_cq(&c->async_icosq.cq);
+
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
 }
 
 static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
@@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->stats    = &priv->channel_stats[ix]->ch;
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
+	c->irq		= irq;
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
 
@@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 		mlx5e_activate_xsk(c);
 	else
 		mlx5e_activate_rq(&c->rq);
+
+	netif_napi_set_irq(&c->napi, c->irq);
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
 }
 
 static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
-- 
2.25.1


