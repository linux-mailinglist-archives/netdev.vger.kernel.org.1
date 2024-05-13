Return-Path: <netdev+bounces-96114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A08C4602
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE201F21B9C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6432575B;
	Mon, 13 May 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="krpBOLQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EA20DF4
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621359; cv=none; b=faPZTt93gbdG4bb5+notHxkSSt/FCPz3j2JRtiARpnie4bH8qbnGI1pZesbMeXpo1jdNiOhmlf9Nq1NwFfla8IXJC85ho0GDC7bQQXTXzHAdi0WLZ0LcChqIcYDusQINqXMBX2BF93lBdsKA6b+g6ekQ9+ih2mA5TmgOyYRzvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621359; c=relaxed/simple;
	bh=WG61YN2Nk7u7U7P0fO8v+PMiI3q/l4RfJSzMoJVrZSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3tPVagf7io3Z6Bt8u1h3gRLTi1Nsf4IQXsKXBM10ZoQ031HI9eP2AvjZ/bCxWEAKPgj/HdMle6zeCTG33TmHeukACQGKY0/PTdWx8LUDwDMonH7iDBK6OEO76j1DNTGc8TMfCJje67P7UhvBP090HGLAO9zGDAAyBpIsL0IgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=krpBOLQM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee42b97b32so37054185ad.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621357; x=1716226157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prTLobfW9EKFUcdfFKM6P4Zgx11iA1pn2v87YJC+EGA=;
        b=krpBOLQMp5px5k53sqHorpJOHLfWSh6/oD7If8Tu30EBtb4KUFYs02xap1vgsry/dZ
         yWy9nBqzTE9uTf298ET05OKpS7OzAfPI4ndC8KxfihllDzOCs740GK2fzWean1fQpsHs
         1JDsPYljok6wfS2EMgOO02ZvW0Q5LFKb9WIqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621357; x=1716226157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prTLobfW9EKFUcdfFKM6P4Zgx11iA1pn2v87YJC+EGA=;
        b=v8ywd3r005PvSQJKow65BVy1pdlAUP82hACXBDQfHtU8iV9OFsR2TFfLR4YgVHWB0i
         +nZAcgAgIcRKWjTnG1Js1gLM3Cf3VkYQ2iIpZWC/krBbJTi6sDZy+4ARrCpbYChIN4hs
         C4FE0tfO4/jaQ5yjjv7bTSiJAargp36JzAsN8vzFXpbCf9xBGbDqsExbziBCHRC+237p
         m0BRAQ0so5FPt1rftZfXnuqiV+j32mXvabwcP/df3R7t4Rd8XhM5ojZe4+sssvmbEm0S
         KRqtk+DUKe3398BHyKhFCl5LahK/ieB3opQDYblQApeKFcecV0xdq9Utq2IhucV6zA82
         JINg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJBEBiWswwqCRJ5XgRhKIM5UdNuxQRYwEAFcW1RN/ZOy0dJGVPkFgmR/k1JNb9TxTTQ8xv209u3WstSS8y7VtO9KANLIH
X-Gm-Message-State: AOJu0YxpVQWOeK9LqbgxUFo7w4wm9MzuZmgwxneemjmyrev4yx1X02bm
	Bjai2XTDao2ZlwBDpcNSA9ATPChg+fRC4hCUmaInYoF2wvfZAmSvP6UW5o8G0rs=
X-Google-Smtp-Source: AGHT+IF46wCZ1KQeIgtuYfMcqauDYMnMH2aXWUlfUF/ZIORIOH/ffVUgIGrqxIkotET62+M6MUa2bg==
X-Received: by 2002:a17:902:eb8b:b0:1e5:5ccd:30e1 with SMTP id d9443c01a7336-1ef4404b81dmr120238405ad.65.1715621357397;
        Mon, 13 May 2024 10:29:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1663sm81948995ad.6.2024.05.13.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:29:17 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v5 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Mon, 13 May 2024 17:29:06 +0000
Message-Id: <20240513172909.473066-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513172909.473066-1-jdamato@fastly.com>
References: <20240513172909.473066-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

A new field called alloc_fail has been added to struct mlx4_en_rx_ring
which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c     | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 4c089cfa027a..4d2f8c458346 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2073,6 +2073,7 @@ static void mlx4_en_clear_stats(struct net_device *dev)
 		priv->rx_ring[i]->csum_ok = 0;
 		priv->rx_ring[i]->csum_none = 0;
 		priv->rx_ring[i]->csum_complete = 0;
+		priv->rx_ring[i]->alloc_fail = 0;
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..15c57e9517e9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->alloc_fail++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..cd70df22724b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
 	unsigned long xdp_tx;
 	unsigned long xdp_tx_full;
 	unsigned long dropped;
+	unsigned long alloc_fail;
 	int hwtstamp_rx_filter;
 	cpumask_var_t affinity_mask;
 	struct xdp_rxq_info xdp_rxq;
-- 
2.25.1


