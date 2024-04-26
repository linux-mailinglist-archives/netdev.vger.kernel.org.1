Return-Path: <netdev+bounces-91802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B708B3F5E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B59287D1E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773A46A4;
	Fri, 26 Apr 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KL+zdN+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815814A96
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156451; cv=none; b=U71qU4rnLKxFbT8kzuC76FfG1og9oOCZ2Sohnddc38ixkpyGOdtLX+ExI+9m6CwEfs9uf80+W/p4qhEbUJeZwBTiK/Vixspf9uzkjXzscjcLGJPHR/ATZdI3b+CKk+WDF6l+uKuPtvM2mM3tuKgpOujM0CXxS+mBVwEFebRLeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156451; c=relaxed/simple;
	bh=z7MYz1SqSvvk6nW/0aA7VzXJvv/C3aolR9fi0nj1t1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kqe58yf5nl8yNyDJYU3RWMHDtGjOM8ld4q7xr8iWkRXMwVOFMDioo/dbhu6H+bzN81qBjRcXYMzbrhiDmnLBjZs08ZbYfqR00zyIGoANVlNxhzDeYX07B5GFECaDhsO/VsVGj9Y9vO6pISdPyLcdwmFrMgf0+BYxP7uvtbzADA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KL+zdN+O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so6376075ad.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714156450; x=1714761250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fnj34GfYIADDHYe9QxZ0tA9OymLxhmbsRufEPA1lFlk=;
        b=KL+zdN+OIMESqIa6bHCDBUP0MeSrePl/9WrD9dDeQyUV38WjUjwZVZkegN9eicu1n/
         C5AlXmcUSk5/K+vhkRbKprDH9VKAUN18Rm5ObjKMNAU/jXidI+ZNCjk5daJjHc98tNbY
         CqDsu57b/mMsZ4aZPGRdRdfK+K8ijGo1FrVXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156450; x=1714761250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fnj34GfYIADDHYe9QxZ0tA9OymLxhmbsRufEPA1lFlk=;
        b=TLGp6p/iRkZVrHlPoWE6tLcDrqoi1rpTAUhty3CfRDVhrYxmysvFEJMh/oPONw0E6P
         tLkAMU+mkumDa7uvOms2gTCIOzd/0ObHtlLcJy4KN6WHiSmlw8csRCgFGvKkWuzQ3o+g
         9rKKPmWWcpV6IYfe/omtABuUMsRLZHYUDj+F2WgKQk2HFLTH+IL97u29czms6zKnafSn
         2e4c89s3LbE1RGnu1mYqpUnvIPOXUZtoVst8b9UWPQRqqEe3yuwg+bQOF7orEmNSmP7R
         UTF7N0Zi2f5xmQ8iTbQaUcVuM5iFfCUbkObZnzVzQ9LJj8Q1YFcgxKXNx5fMWdlgv+RP
         O+AA==
X-Forwarded-Encrypted: i=1; AJvYcCXHt3UqN+ajo53xugcQs8UaZI1QKcVhMl6+B6SXFomhJq/TeDuJTMdsU3l5bGG1JQBhfnoCoOHX7YhQ+++udalpZJAoXQuj
X-Gm-Message-State: AOJu0YxdACyo0J3uX2rqRQ+RBwzP8BpnmcrMvBvSOoBgAUTb52gk0FI8
	1nHsr/LAieX70UvNrINAmUKezSLU6i61NibQhtP+IuFIPvmvloFV/fKGoWTJ3+g=
X-Google-Smtp-Source: AGHT+IGZIOzj2H8FqiVmmHXgMXRX0ZqydYegzeUCwj981ToCy0Qyjz0/sEw94VO7ZNVIcGwOrkdcCQ==
X-Received: by 2002:a17:902:b20f:b0:1ea:fb65:a0c9 with SMTP id t15-20020a170902b20f00b001eafb65a0c9mr3018377plr.20.1714156449597;
        Fri, 26 Apr 2024 11:34:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm15713152pll.100.2024.04.26.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:34:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v2 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Fri, 26 Apr 2024 18:33:54 +0000
Message-Id: <20240426183355.500364-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426183355.500364-1-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..461cc2c79c71 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -126,6 +126,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq_idx = cq_idx % priv->rx_ring_num;
 		rx_cq = priv->rx_cq[cq_idx];
 		cq->vector = rx_cq->vector;
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
 	}
 
 	if (cq->type == RX)
@@ -142,18 +143,23 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	if (err)
 		goto free_eq;
 
+	cq->cq_idx = cq_idx;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
 	case TX_XDP:
 		/* nothing regarding napi, it's shared with rx ring */
@@ -189,6 +195,14 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
 	if (cq->type != TX_XDP) {
+		enum netdev_queue_type qtype;
+
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..896f985549a4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -379,6 +379,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1


