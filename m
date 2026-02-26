Return-Path: <netdev+bounces-261305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLBcLNEyoGksggQAu9opvQ
	(envelope-from <netdev+bounces-261305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:47:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD61A550A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4226300D162
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937E37418D;
	Thu, 26 Feb 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYAiz2WG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C57331223
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106151; cv=none; b=pjfIjtNhxVufAuJTsZhfVtTvk22HJv9x5zpOl4MLmqFReJq+Wdoc4mkWZ9tfXzaXbi38tu5TX32/o19PYq55ybKTB9OFfNtBTTgLq/WkduaXQ3y4VtPzPHZr0d0UyWyMrvIMMI5bUYv8wpjO5LtBHlga9UwQ7QYcSBUeuRqpIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106151; c=relaxed/simple;
	bh=IDrLfRtrqKE0vqLJeMWWDhA7SZYVBeN/uUxbu4C0CYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR0SIvAFS6n/FtpQ7PJA8/QD677qAokKMwTSmsizyLj+HPFjuXwjM8Op8Lh2Eyxs79EO2VlaHeOrKj1HpXMey0CZMurDUZSffq6eHkcPh5b7lmvHx/89/0UdbrB55yVY7W26lBKKRFqNXTldeFaB8MifBDVujbKsfW/rsH/TMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYAiz2WG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso498476b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106149; x=1772710949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qe/aj2KQhLNcuuoZGHRjm4hoJjeXJVcke9BH8aNmqhY=;
        b=QYAiz2WGorTExHGqpk/d4TvmnwhjuOwSixjrxD0pH2Z+sgBx+h6MaqOdLP3R0wF7cj
         kfzn9K8G7GX+FhqoLIaZII2wmVz9AVMJS/RGisG0NyDdrZRPl7Nm6vOmMgq4ahJByyg8
         FSLR4NkU0B8TkzAFqelaqVN10NFXHLI4dkl39JYw48nLJGemfwP7pLUp6Jl6yvT/a+Lh
         QKB2Vf47/XBFFCNvBEDcOknBx60WY9uICMRHA3axTmxg3Wtn0qHZm1fb0igtnmYOaZtg
         b09Xk9MRLWHIrZhkuunLMQnAFwH3mLd4QKtQ+6O0qWAij7q1ECDxpYULOVDdJDoLp3rk
         6hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106149; x=1772710949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe/aj2KQhLNcuuoZGHRjm4hoJjeXJVcke9BH8aNmqhY=;
        b=U9NwvdVfRiI9LFrxT70eeN5Wple5n4j0GCVnqG9QYwRs3K6TS58ocB8o3FzBXV8IK0
         r9eSYc06QxtG9QaLZr7XBcGC5IqNUeTb0lU/Bb8TW+0lMT+aZYvXN1mrFBejwaMQy/7l
         7m7kzcDS1Wy7fVALkpvnOEA9ARssgHRH6z7S9feqD/uTVfTyqUY+kimGPpc/g3AbbZbl
         IbBSdxg9yy0WxySbhvzWSfB+hnJwEg0FcO8PxIgqcarzfwRAKnr5VuyRwyzSc78cbBa3
         /xvx+1sIL5AXSb0Mpslk7zlHjPSELi6DGOfQKkmLYoRd1jCQ3rEL9yAMX+TzkTZAJEyD
         KoDQ==
X-Gm-Message-State: AOJu0Yx829aTmIJrYv4r1vL9yM1oqQZNSoPOo6mAXKOOUQIcg+NPGE3Z
	115FbGBz13z8qDN9EKt5fNWrcMV+j+Z9whQktY0novaR0bfWoI7+tltFa5ouNQ==
X-Gm-Gg: ATEYQzzwmEc5w3pZkDRLblAFemscgMl1Ug2FJXd46n5rGuEQBuCLGJknAapNNfWBGxo
	2DYsMx6NO10K+nAQlfhfKAwJqlMYSK3kZjJ8773cmv1dbFXaAS2BubcM2Lh4ydTLETmk6YitjnQ
	WuTCl05IKhCVZgDuboWyAegjMnUrpIktPwl6A/loB6aHPbKR9oghJkPUeahSEssMIDEF6uXrMg4
	HNNd4UnfRH2vYCNHzOyMQcDdi24g2sw7W46G+O2G6ij56b7SA8vIvYI0Av8ChLcxO+82JeU77IX
	3NunAmUC18qrV9PqIj1yTBC7KF1qhj4J4+C6hwPcMCpyyJHxXm8jMwIMO2YQpEmmo4PLMfxDgwW
	HQt7ZrMi5z7ZyXARltaGV0EOvvD5oDBlGmIovLYZRTnnb5Gdb1VokRQ8WBlj7x3TNvwa+e5X9ZF
	xmmIPr9iWoay60WZC1DaaScBqI9ySrGxq/XNFo2Yc4qC83iZdqPJ0=
X-Received: by 2002:aa7:88d1:0:b0:81f:4529:83a7 with SMTP id d2e1a72fcca58-8273368c2camr4149476b3a.15.1772106149409;
        Thu, 26 Feb 2026 03:42:29 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:68f:cc94:9882:f73d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm2985938b3a.21.2026.02.26.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:42:29 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Cc: leon@kernel.org,
	jserv@ccns.ncku.edu.tw,
	charlie910417@gmail.com,
	yphbchou0911@gmail.com
Subject: [PATCH v2] net/mlx5/core: Allocate ttc_params on heap
Date: Thu, 26 Feb 2026 19:42:19 +0800
Message-ID: <20260226114219.2111793-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-261305-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ccns.ncku.edu.tw,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19CD61A550A
X-Rspamd-Action: no action

The ttc_params structure is too large to be allocated on the stack,
triggering warnings for exceeding the 1024-byte frame size limit.
Consuming excessive stack space risks causing stack overflows.

Allocate the structure dynamically to maintain safe stack boundaries.

Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Suggested-by: Leon Romanovsky <leon@kernel.org>
---
Changes in v2:
- Use kzalloc_obj() instead of kzalloc() to align with the new memory 
  allocation API introduced in v7.0-rc1 (Leon Romanovsky)
- Link to v1: https://lore.kernel.org/all/20260226092857.1583984-1-yphbchou0911@gmail.com/

 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 15 ++++++++++---
 .../mellanox/mlx5/core/lag/port_sel.c         | 22 ++++++++++++++-----
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1db4ecb2356f..c3a4dc2b4a1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -966,27 +966,34 @@ static int mlx5e_create_rep_ttc_table(struct mlx5e_priv *priv)
 {
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct ttc_params ttc_params = {};
+	struct ttc_params *ttc_params;
 	int err;
 
+	ttc_params = kzalloc_obj(*ttc_params);
+	if (!ttc_params)
+		return -ENOMEM;
+
 	mlx5e_fs_set_ns(priv->fs,
 			mlx5_get_flow_namespace(priv->mdev,
 						MLX5_FLOW_NAMESPACE_KERNEL), false);
 
 	/* The inner_ttc in the ttc params is intentionally not set */
-	mlx5e_set_ttc_params(priv->fs, priv->rx_res, &ttc_params, false, false);
+	mlx5e_set_ttc_params(priv->fs, priv->rx_res, ttc_params, false, false);
 
 	if (rep->vport != MLX5_VPORT_UPLINK)
 		/* To give uplik rep TTC a lower level for chaining from root ft */
-		ttc_params.ft_attr.level = MLX5E_TTC_FT_LEVEL + 1;
+		ttc_params->ft_attr.level = MLX5E_TTC_FT_LEVEL + 1;
 
-	mlx5e_fs_set_ttc(priv->fs, mlx5_create_ttc_table(priv->mdev, &ttc_params), false);
+	mlx5e_fs_set_ttc(priv->fs, mlx5_create_ttc_table(priv->mdev, ttc_params), false);
 	if (IS_ERR(mlx5e_fs_get_ttc(priv->fs, false))) {
 		err = PTR_ERR(mlx5e_fs_get_ttc(priv->fs, false));
 		netdev_err(priv->netdev, "Failed to create rep ttc table, err=%d\n",
 			   err);
+		kfree(ttc_params);
 		return err;
 	}
+
+	kfree(ttc_params);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 1434b65d4746..b7525da60f92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -855,7 +855,7 @@ static void mlx5e_hairpin_set_ttc_params(struct mlx5e_hairpin *hp,
 static int mlx5e_hairpin_rss_init(struct mlx5e_hairpin *hp)
 {
 	struct mlx5e_priv *priv = hp->func_priv;
-	struct ttc_params ttc_params;
+	struct ttc_params *ttc_params;
 	struct mlx5_ttc_table *ttc;
 	int err;
 
@@ -867,8 +867,14 @@ static int mlx5e_hairpin_rss_init(struct mlx5e_hairpin *hp)
 	if (err)
 		goto err_create_indirect_tirs;
 
-	mlx5e_hairpin_set_ttc_params(hp, &ttc_params);
-	hp->ttc = mlx5_create_ttc_table(priv->mdev, &ttc_params);
+	ttc_params = kzalloc_obj(*ttc_params);
+	if (!ttc_params) {
+		err = -ENOMEM;
+		goto err_alloc_ttc_params;
+	}
+
+	mlx5e_hairpin_set_ttc_params(hp, ttc_params);
+	hp->ttc = mlx5_create_ttc_table(priv->mdev, ttc_params);
 	if (IS_ERR(hp->ttc)) {
 		err = PTR_ERR(hp->ttc);
 		goto err_create_ttc_table;
@@ -879,9 +885,12 @@ static int mlx5e_hairpin_rss_init(struct mlx5e_hairpin *hp)
 		   hp->num_channels,
 		   mlx5_get_ttc_flow_table(ttc)->id);
 
+	kfree(ttc_params);
 	return 0;
 
 err_create_ttc_table:
+	kfree(ttc_params);
+err_alloc_ttc_params:
 	mlx5e_hairpin_destroy_indirect_tirs(hp);
 err_create_indirect_tirs:
 	mlx5e_rqt_destroy(&hp->indir_rqt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 16c7d16215c4..d4e7bd3c2bf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -514,15 +514,20 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 {
 	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
-	struct ttc_params ttc_params = {};
+	struct ttc_params *ttc_params;
 	struct mlx5_core_dev *dev;
 
 	if (first_idx < 0)
 		return -EINVAL;
 
+	ttc_params = kzalloc_obj(*ttc_params);
+	if (!ttc_params)
+		return -ENOMEM;
+
 	dev = ldev->pf[first_idx].dev;
-	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
-	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
+	mlx5_lag_set_outer_ttc_params(ldev, ttc_params);
+	port_sel->outer.ttc = mlx5_create_ttc_table(dev, ttc_params);
+	kfree(ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
 }
 
@@ -530,15 +535,20 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 {
 	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
-	struct ttc_params ttc_params = {};
+	struct ttc_params *ttc_params;
 	struct mlx5_core_dev *dev;
 
 	if (first_idx < 0)
 		return -EINVAL;
 
+	ttc_params = kzalloc_obj(*ttc_params);
+        if (!ttc_params)
+		return -ENOMEM;
+
 	dev = ldev->pf[first_idx].dev;
-	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
-	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
+	mlx5_lag_set_inner_ttc_params(ldev, ttc_params);
+	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, ttc_params);
+	kfree(ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
 }
 
-- 
2.48.1


