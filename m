Return-Path: <netdev+bounces-228795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E823BD3F1E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E3515009A4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A279312821;
	Mon, 13 Oct 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwgEaukU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C473126C1
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367233; cv=none; b=hfHylQ7nkrdAAeMhZ79u+DY98O4HvdFOwUKs9V+oc1zHA4wnpSBhjmbTKeN7L83aBvVAT3QXMx/hQQBPQJQTEGXsWTATjSoSr3LOa/XzjcZAUf8I5+79aWrYMss13sPcw0u1vyhrFZUPaeZgfwXKY9Obm3oRIdLTqK+Pss5LIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367233; c=relaxed/simple;
	bh=D68sIcGcW8AD97DUUABnw+4SAHYdP99w8kG7MJxPpuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1k3Sbh+L0gOuM8FxUIeJ8ZKC3/ZsgUbibwgX+8rgx1N5kspQY4xcnGEqzwRQKeay346Qg8eRmDyKxXoK/CYll3n+tq6QuH/U31hyS6LpkH8IOzG05KT6hzWIfOgZhBHdCf9XxGY7w4HkN+YNJKlhnluHCQ9Ny4mNhEOQrjEvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwgEaukU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so2530561f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367228; x=1760972028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=fwgEaukUjhYVnmQ8AVW6BNlVQE0cMo3BWtp7IVfC1O9B0iLe1lhk8FxlPVq1fTRKyb
         pBz4705SNJ6SLjEATAjDzJVeK4rsXJcyRUwRkyQ9F0h2mV/D8f+uBF/vNIMLlOu9LK3A
         alb0iAvwxGsR43s6gCBb6VGXijw46omDMwcUd7DzijeTnXsWuAnI2Rc6KsPEmxvhjgV4
         xK40mJjVCKZEXies9kmVueGSl0BcuIArtqE429PstvO2mFo7/HdoYdNJEZFi4aDJC3wC
         0yXeBoiQxfhgRE8I3sroNOFrYTfjIa6k/VY/L8xbiCb6hEUgapWQc7FQDuj3CJP2XO+e
         3Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367228; x=1760972028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=xT9PX1xZwiU8JwH9L+kBeg+i61llAouY+XIdEon4PZoibWrXoFYhEa1lpa/K3T2uM2
         zUKGomZR7Mxaa52Cq/U0TREG6HkB7YpudTPUhL8l057a1KOUXa+1cATlpiVAM184Gq4H
         1P3L+yjvQIaoMYwa4fHm1hV9iQAZRkU2dSK+3MvquJdy64suWSmCt+cGGhq3MVsv5hQS
         qfBTjgG0ZDpa2sIjw5pfV7uFFvRzK/aoRyoJxucpXWfxo0bpDSBRnPYTtQqBqSZHOQxz
         YIpzbh3FegOMWa3Q+w1DTDItZvtuREIfRYPgoXa5x+kupR1qajH7wBM25IADfhbNyz8S
         gvZA==
X-Gm-Message-State: AOJu0Yz/3cQZUTizbJImchNXqwIFfmPuj17GyRwSY4SU82FxE8v/W/dH
	Vz8DLdYzxOi37RSOKctFko693sFPjO6VWnbpJHtPMgSgU4EkiXmbLyjCYr6RwMEL
X-Gm-Gg: ASbGnctM2rlPvGDAAb/YHVyYyQvG86tzb7XLxWzCM1mU+NaZdF6EObgQIx6R0MG9bww
	IiLM6Fa6V6IzSPJQ9hwv/jDdzn52FN9rtQrs+4DoBI2S4OPwGwcJpCBXCiS4MYPc3q7IryO3fpR
	/pIkcwZEkqgW3EDM3eMFGqfFaGhrrzsuCTX4pskDhi4ewI2Y6B4/q4X57eNgmtjhafkM6aOcYoZ
	ALvuAEL/Cx2YUKgGhG1QHp9Fkhy7GKrX1Nl2fwFUomxbhJ6b73gKTqxmUuexb6GczG8G62nv3io
	kmFn0wp/Iml1CvyLj9fiHgE5+yqcFJVqBPiAnp9mEvkZewqGlbYDXxYTuNYJZ4uP9p1bcC/rVAf
	Kz8BWSD7ryadSG223n6FaSTqU
X-Google-Smtp-Source: AGHT+IGhdCNMbexhcA+WKt1V3KL/FuPKgFmigZrXjQ1ZszoP38SE47hCNbYpQqpsjRmxatSSV4+luQ==
X-Received: by 2002:a05:6000:4b1a:b0:426:d818:e46a with SMTP id ffacd0b85a97d-426d818e49fmr5836115f8f.60.1760367228006;
        Mon, 13 Oct 2025 07:53:48 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 14/24] net: pass extack to netdev_rx_queue_restart()
Date: Mon, 13 Oct 2025 15:54:16 +0100
Message-ID: <c7bc7d4cb8e3dd6b13f044495ed9efef8aab294b.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/netdevsim/netdev.c            | 2 +-
 include/net/netdev_rx_queue.h             | 3 ++-
 net/core/netdev_rx_queue.c                | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d7a9d5bc566..61e5c866d946 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11570,7 +11570,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr, NULL);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 032ef17dcf61..649822af352e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -886,7 +886,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	}
 
 	ns->rq_reset_mode = mode;
-	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ret = netdev_rx_queue_restart(ns->netdev, queue, NULL);
 	ns->rq_reset_mode = 0;
 	if (ret)
 		goto exit_unlock;
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..a7def1f94823 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -56,6 +56,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index f6a07fccebd1..16db850aafd7 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -19,7 +19,8 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
+			    struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
@@ -143,7 +144,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 #endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx, extack);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -186,7 +187,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, ifq_idx, NULL);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.49.0


