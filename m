Return-Path: <netdev+bounces-234774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9CC272A3
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C989A1885698
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C436329C70;
	Fri, 31 Oct 2025 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Odo3N2Fe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CB2E62D0
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952248; cv=none; b=PatakgUkPDj2KNpdXo/G0Dj03ZNGEZ+ncaaexpzYPRvxilfDzP6NgFYiQiCqhIKIf52tzV0R5AF0ciAqZq1vTyEdCYVlE78/+l9sqr/PHyIz5GdjH7fj/VHU6lTqFO19EmjZDkBq/EQ1b2iwpBrzk69eEn/ENr782RQD6X691Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952248; c=relaxed/simple;
	bh=gePEBRsQ/i/1Ka8b16jtecelobNP3sRDbgMBhiWzUw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTcpPyU+5+5+8GThfYvoxXoZACFVn6Ut937I8QOKJrb7vS+YYIqsSHBalqHhyJZKQyIIKeUItIlT//2SWzZ5UALnktn1it3+SVbh3YCCk4lmelUWGNB50H4w/NRYlbcih/UeF441YtMbo5HMNpAI1vNAS43bgK6nc9GPQG/dfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Odo3N2Fe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso2247218a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761952245; x=1762557045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K08GZ0LCmslCHnnNwAA1FyvRJukn3ovKGVTyIMK9RD4=;
        b=Odo3N2Fe8hc5KZt/E4e974z6208iCg8FzJrfgYViTjsfnIOkct+V7hqjt+0q8ZjXaa
         mHmTKxXMOztnuyNILanBhjGiWv27atV/0nHJvw2EQRNgiu/gEKG8XBz8PrOoj4sxtkYn
         xqkoXd67eqnOEH5FciQtJXlvy6MWiBxy7UI6H7uHNeYWfHxym/POhATCr0t7FjSXFIqk
         kF0r2Aive7mz6QKwPiY3Re3abADnWaro8GRHvxRSxMc2kxGllcVMvuvHjTaGpO9MKf5x
         CwPt9CFKcbq5/nXOBNUZ+vnQ/vlVdd6qIjrJiSaXwwwioXySWW0YR+m3hukMQ6BBqEc6
         o38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952245; x=1762557045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K08GZ0LCmslCHnnNwAA1FyvRJukn3ovKGVTyIMK9RD4=;
        b=rh6aaCEr2iZDA9BSYLzIg4xKnapUEpvXPE6pF+X8fwhSL5z4q9vonkro4zAzFoGqGT
         K1ELRxz1rulwFrYVK8rMhVoXm6Arz+kH1advxNlmhaxoNug1tGNbZoFHfHXb+7RVFZpC
         Vzrijf0UgTEixV/2sHlnGjTdAtj4jiUKb5c3FmYeyvoXfUnwov5X7oXoTZdzVoCg+Dk2
         lB5hP+ryWHn8WUMyVsPP3AUYbmifKpYUCFIIkmYGh3iQ44SyEODhhPZlT44vy5pQS1dv
         G9TjiER9uj7R9lAj/ZobOK7r0vqfKOojIvhDnbCekWUs8B9fiMc9KtJfdFMt22Kwy59J
         MruQ==
X-Gm-Message-State: AOJu0YxnMTukhEVxwb8eVjzdNttaiKhgol2SWTiZWV0xvFjRDZxxwbWF
	6uxLi0bdwmu88sLKkTN86cy8KAv9XxDLxncFlvtYXN8770bGTKi2JCZXQpTslttUYG9YOR9f5l6
	TzBj/zr8=
X-Gm-Gg: ASbGnctGrn0uFCIec8RjJmNinT2zel86emgk3OM8TVeD6DECPchwzcrT/jm/Xg+t6+T
	ZeewosokKvTaW2VRpzVU2q2hXTyjovBL1+7iRYIcUbPRzpsDyGBh4XInLkUoL1jEbwpVBhsT4BJ
	oCcEBthwbUzCZa3YKylbY1LQZSG4PrPNZ08rCwY2liRSmNAhDdD199nEXzR+Iw/3gi9FL7lJ/QT
	YWPV6dBJLpEbqnNi7cODBUdmfTDAXT6C4MNlNVJood/JxYYX1XSukRd61zY6ZU3H8HBV2Q+uteu
	dHhDNffmH0UQksfURPu0vFhXCcJXwdMkU+kuOIXsjil0QSTDrjQIHWfuZnbeVIQrzGulVhFxEJN
	QEa2Dtdge3ydjFy/gajpNK/oINsZPEDdpAA71svkYv4wv1zWOUy8s7/BYumgYoWDk7VgfOwoonm
	iOI8+7M1O2kamadxs=
X-Google-Smtp-Source: AGHT+IHNaOrXqW6Wtu/aNWUjfmMIKoU5JDS5R0Gu78tQTu5Mb4K2n7BK/ABP0tuFQlCWE+ph0l08PQ==
X-Received: by 2002:a17:902:da84:b0:267:912b:2b36 with SMTP id d9443c01a7336-29519b9ef78mr60313815ad.23.1761952245081;
        Fri, 31 Oct 2025 16:10:45 -0700 (PDT)
Received: from n62-107-016.byted.org ([71.18.7.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295580723fdsm15475ad.72.2025.10.31.16.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 16:10:44 -0700 (PDT)
From: Zijian Zhang <zijianzhang@bytedance.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	gal@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	parav@nvidia.com,
	tariqt@nvidia.com,
	hkelam@marvell.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
Date: Fri, 31 Oct 2025 16:10:38 -0700
Message-Id: <20251031231038.1092673-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing XDP_REDIRECT from one mlnx device to another, using
smp_processor_id() to select the queue may go out-of-range.

Assume eth0 is redirecting a packet to eth1, eth1 is configured
with only 8 channels, while eth0 has its RX queues pinned to
higher-numbered CPUs (e.g. CPU 12). When a packet is received on
such a CPU and redirected to eth1, the driver uses smp_processor_id()
as the SQ index. Since the CPU ID is larger than the number of queues
on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
the redirect fails.

This patch fixes the issue by mapping the CPU ID to a valid channel
index using modulo arithmetic.

    sq_num = smp_processor_id() % priv->channels.num;

With this change, XDP_REDIRECT works correctly even when the source
device uses high CPU affinities and the target device has fewer TX
queues.

v2:
Suggested by Jakub Kicinski, I add a lock to synchronize TX when
xdp redirects packets on the same queue.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c  | 8 +++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..2281154442d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -516,6 +516,9 @@ struct mlx5e_xdpsq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+
+	/* synchronize simultaneous xdp_xmit on the same ring */
+	spinlock_t                 xdp_tx_lock;
 } ____cacheline_aligned_in_smp;
 
 struct mlx5e_xdp_buff {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5d51600935a6..6225734b256a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -855,13 +855,10 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-	sq_num = smp_processor_id();
-
-	if (unlikely(sq_num >= priv->channels.num))
-		return -ENXIO;
-
+	sq_num = smp_processor_id() % priv->channels.num;
 	sq = priv->channels.c[sq_num]->xdpsq;
 
+	spin_lock(&sq->xdp_tx_lock);
 	for (i = 0; i < n; i++) {
 		struct mlx5e_xmit_data_frags xdptxdf = {};
 		struct xdp_frame *xdpf = frames[i];
@@ -942,6 +939,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	if (flags & XDP_XMIT_FLUSH)
 		mlx5e_xmit_xdp_doorbell(sq);
 
+	spin_unlock(&sq->xdp_tx_lock);
 	return nxmit;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..ced9eefe38aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1559,6 +1559,8 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
 	if (err)
 		goto err_sq_wq_destroy;
 
+	spin_lock_init(&sq->xdp_tx_lock);
+
 	return 0;
 
 err_sq_wq_destroy:
-- 
2.37.1 (Apple Git-137.1)


