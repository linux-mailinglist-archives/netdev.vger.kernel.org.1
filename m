Return-Path: <netdev+bounces-90672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C391C8AF790
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7989B222CB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B665142900;
	Tue, 23 Apr 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="H79s4Q/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5E1420C6
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901781; cv=none; b=TLnbZ4RTTqyAqBRSI2UfQ6t2FrSRUtFRA44OmEBsN8LxLdtGK9xqMRUw6lxXns2VJjlSE5FRCfMGTrYxadF+mIL6P72B6KNzB4M/x1FckrMMS99swPZ7WLYhWCV9hihFJM2u3s+xG8R/0feMKJYvgHgc6Lo6OKPiV7IZjmhprZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901781; c=relaxed/simple;
	bh=NAmZBz9KaDewSEn6UsfuFlFlWSCv9ZwDJZlG72i5LnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsOELs0Kg3CF6UfqBNXnG7nBzcyN2PAtADTcZls8xZAGTe++cWAIICDurB1gjWGKi0C/DlvHTjncEdbBf6rVFwReg1iLODRNZs7k/VCYZMp7bmJYjV878SIla2L0PldVMCtbk/B71uttujnmtjV/rv01YBOhVi1Gvidli5msN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=H79s4Q/R; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so5020314b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713901777; x=1714506577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XSEsaXMnYKVqcTHOSxPSgntkBLCcmZ9J5ASUc0dakk=;
        b=H79s4Q/RBaNSw0rrpw6Qp6qd61iAjvVhd9VStu1LP40yRnj4je7Q/QYbgcjlaHqLs7
         /gFTUuskAhWmlJe3FU5pLj+wKY+bMQWXdIDg8HgppiesxQl6RPLWyN9ntPvdjWJ/QwgI
         t6BcbuP5psZuSXsrByIgBQszexyRjR9oZ73W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901777; x=1714506577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XSEsaXMnYKVqcTHOSxPSgntkBLCcmZ9J5ASUc0dakk=;
        b=tV1gqvGNN9LsmAj0hLzL23Dg4ioHljLWtmDZXDTuPszXpDJJDzBB9dPtgl+Pws4Wqc
         Usy1qc1ZAA7x7Ma6CF15sm7jgbPQxXcE9sc3ttI7kRG0IgVDjGPZ+X/ptL0lZJ8Uhbld
         F2Cn6PGBs7yY0zRPg7yRNiE2ZHXP4o+l7aRhOBWZNDb0n+ekJVcyIwULMTRPlR1oO2Iq
         m5F2+OCuqQuloZFNW5I9ZcNUCSrn7iCSu76xqD9C0vaVSYCf9FLd/cSuPvuc/rLj9rqx
         dcClMDIgl/b3Xdf23uxsZQZIbR4Zu7NBNOd/i3CapwAr2+ZjK8+CKKsy7OpKLezll4IT
         ZnrA==
X-Forwarded-Encrypted: i=1; AJvYcCXjDXL5KeGkcLfkuSd2ps0tIOe1cGGkBbQi3JLqkoankA+qzBwHfHvMzICI17WrbEIkdJm3IMeZPFsWXK3iRI20cU5svJLa
X-Gm-Message-State: AOJu0Yzhe67p30qQ45sXiHrIqczrJ5HzGnAY9gibK0aN+ijNQTxSrvHx
	GGIRrZtedgTPbs+rqwJ48c/+KTBTY2aKrvy/aUH75fKEuwf558qrjS5rV8NsoL8=
X-Google-Smtp-Source: AGHT+IG6XovYKWAkwGpJrOjAuxe2PGxzyt0cRlqmXFkcgQRTJ+XKwTbwxnJkl3VTUBPWj80xsE85hw==
X-Received: by 2002:a05:6a00:8c4:b0:6ed:41f3:431d with SMTP id s4-20020a056a0008c400b006ed41f3431dmr779855pfu.0.1713901777469;
        Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm9995672pfk.215.2024.04.23.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Tue, 23 Apr 2024 19:49:28 +0000
Message-Id: <20240423194931.97013-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423194931.97013-1-jdamato@fastly.com>
References: <20240423194931.97013-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

struct mlx4_en_rx_ring has a dropped field which is tabulated in
mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.

This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
dropped field for the -ENOMEM case.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_port.c | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_port.c b/drivers/net/ethernet/mellanox/mlx4/en_port.c
index 532997eba698..c4b1062158e1 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
@@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
-	unsigned long packets, bytes;
+	unsigned long packets, bytes, dropped;
 	int i;
 
 	if (!priv->port_up || mlx4_is_master(mdev->dev))
@@ -164,9 +164,11 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 
 		packets += READ_ONCE(ring->packets);
 		bytes   += READ_ONCE(ring->bytes);
+		dropped += READ_ONCE(ring->dropped);
 	}
 	dev->stats.rx_packets = packets;
 	dev->stats.rx_bytes = bytes;
+	dev->stats.rx_missed_errors = dropped;
 
 	packets = 0;
 	bytes = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..573ae10300c7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->dropped++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
-- 
2.25.1


