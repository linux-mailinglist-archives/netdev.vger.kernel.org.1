Return-Path: <netdev+bounces-223936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD7B7DA40
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68011C05849
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A356F362987;
	Wed, 17 Sep 2025 09:58:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121135FC05
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103111; cv=none; b=CFDEuibUGZGEvBzzvJM4BtdUx03TfOX1gRx66bm+tbKEDPN35E0O9c8nOH342tAhfULAeGOsNfUrg3uIUHvtFOHoTo9qEPRHTPTUEdGamMcdTdNw8DJQfqda/iBVZ8NffcvcdaMdYXESp45u/dJtC0Q8R/iqVD24n+0XsKt0qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103111; c=relaxed/simple;
	bh=XORibMK+HoTqfv4y9FVPPOq9ONbLbN3AR+BVl4Gb9Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ru46msgWEP7rbEnY/pNrKGN3hj7Gid+shcKhOwuq+K8Ev3DQbHGPAQVzqZYlhMGVkq3WDPRY5SE5G9lWK3BmLuKPBLVToDNYzamEn0K7TvbDMlual8HC4K5GujQXQFhNpXDDpaFEpJIbqcOSKg/qRhvwcrScLk/IC/SIyx/K0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0428b537e5so881095666b.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103108; x=1758707908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEFtILFHyV3cwaZ5irPCMUES0101pMsbpssc+ihdXEQ=;
        b=acIbbh778JRad11swk7MDPOocRmWEksoKM8mv4NxKOPzl9SVyrQaXjtvG5fyA/TmvQ
         reobQBrVH4Hv3cbWuDInb5vJm+XArgyR0R2aG7MdL4937SHTQFLZV9h9kNhBaFFC3phZ
         e9z4bsfOzoep5l6iabP2BV4n73PZpxImaS/80UNSbP0wVMstO07ctb1ZrL4YKV9qza1/
         wWoZDC3aa8TNmmwyXNO9IXFuERCwXbt66Fmnc0M6u9ehYpeQ4Qi5hGP+PIN4SpHDoshw
         zqsvGj4aFYq/dMH090YrOhJAvgdPekpubrXMuiU6OSnkGuET0J7x+XSCE9SeLTPcP6Lc
         SpaA==
X-Gm-Message-State: AOJu0YwJbHZY0eyPlD4tJYhtyx/QR8wxtP0FVfZs/t1YWGddrzr7plHq
	3GOq0LuufyiOpRbPq6FSOsNnQaW5I1SKB2lqE+jnxfuXzEHv6n2Xs6DF
X-Gm-Gg: ASbGncucxOuvYWRu266AZ0ALfMDrpz8YvEEdj8tnmTHOtAeqG3VDRrec+9oWuMxZepH
	wLr5HidlUzFEIjv6YTvH50rzAgzmZQ5Kdw84BcvUNr7XDZpEGqrXsTJ5CL+GdKNdcNNNI03AVDm
	UTzhcthGmOddLeOpYf28aJxUxdfuHV7WF4gZ/g0lbg2jJu+m9SHuRBPU7+RK7JAVNRvNZUj1tWk
	LCbB5hOe3XIs9+Tr9xPczbw75EXT3sMTIYpw1OnguyDpauNte/w7Sw7sO0hdSLK+iPwGcUXS1YC
	uIXadEzEanAVrOB+0qcguAu6q79BcWSQIeiZ+DzCgJXTmKJEaVdjrF1gycoGopozq24XCz3IF2V
	uS2cWYd+qh22gXxVH3WRL
X-Google-Smtp-Source: AGHT+IEqeQhl1HdnaOEdPXXYr8xFvU7BK+9Cs56y4h7GmNKdlAOvFfnmqWDD7Q+i2v4rGlEWhLskZQ==
X-Received: by 2002:a17:907:bb49:b0:af9:a5f8:2f0c with SMTP id a640c23a62f3a-b1bb68035d8mr197119866b.28.1758103107998;
        Wed, 17 Sep 2025 02:58:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da327sm1350226766b.11.2025.09.17.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:15 -0700
Subject: [PATCH net-next v4 8/8] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-8-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=XORibMK+HoTqfv4y9FVPPOq9ONbLbN3AR+BVl4Gb9Yg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY3Xg2ReWutpzuplHGRfOc58F+2D2T7u15Yu
 VNzmPJhOWuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNwAKCRA1o5Of/Hh3
 bQMzD/9wTBbNV8xsjWexX4c9iyGc5EdKAfyO5JoJCa/IVGqwt7eQbgeI8pVT5ObPGfkHf792BKu
 v+QMwY5lTXAECKDHzhz17Bt9md6UlQx+UITRER2/LtiBuDjXz+NJNgsm1K6TotMDAMzYuTjNque
 j7xgaNpF/dT5iYOjqi5GTDHW8C7rYOzUHA70UwKG7wFx7Jf/p9PMnomGBqViqOL6fPnr6fvKeVB
 NNwsJRLjDIFYWhtPMdrqdQ+k5b4hdMyGuv54EDzCvLl6a2OW5CDxU/MkLrAro4gNGvZdwjnXuUn
 YVKPkAxxX/UABmL7moQB1MDhvJU1TfnpQBvH5o+5YvNckkjBLqKhjOwCjHlPqj8OrAkBBY9/AFL
 759QQNjsFlTzpL2qmRD2CiNCQqacNIKkl+CJ3xcJ9HxsF+4hlAzgUAlLDGBpKzvZ4LL8/UXbb5t
 +mRQwyDYyAMtaz3YeJN61qBPV5v81++PK030sJOFR+N11hXfJZpMlts19iDyAEzcKBQj7xQdoFQ
 T7oNCn7VXR3fvGBZsF0Yb1xTAllLIGv4vNhJJ18eQILWQUHNerQ68+WikirijPjz7+fv+beMm8E
 pXMdOfKbKuAVE9HB43kkUcQdq2bi9Zg7H0U4xKbvrQTx1kVZXZSHyhUyMAK4HqAKDIMRHuHujLb
 90PeNk2Cn68l6KQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 06708c9a979e6..7da5a37917e92 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5609,20 +5609,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5650,7 +5641,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


