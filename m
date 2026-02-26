Return-Path: <netdev+bounces-261519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOAGOUCOoGkokwQAu9opvQ
	(envelope-from <netdev+bounces-261519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:17:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B001AD74C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3347C307D64C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B032C859;
	Thu, 26 Feb 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZvIw+X9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5621771C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127988; cv=none; b=PkFbMpKAN6yz7IHCflkR2pXs7eSUZaCEIUKpKIQovLDgtERJCaSLiY/A7YSFyCGqrdRLLx9poIodzzy+zMqz0PQ0ZtkH9wb1Uec1Y/F9Pb7qmC+jh4LnaUOIppVaHCsOoD3PKg1YXoILBlSL4018rpSKbx4eAqTNZOYhxCeTkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127988; c=relaxed/simple;
	bh=pKZqKKQwJCAkd89rQhF2Ve0LGbB1hesFuzBIYgpvcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoSnJO0qFQvaP7TGun5v55XoNwnPc5boLQvHEEoBZJYfyqwxLTzzil7hSq98PxfEk2xw/6YG1E5Uc1bsbUT3DlJaLYmKCA9QagCevrPpvuoJ721tpbNapLezUYzzXlmoTkX8g4RcG5SYpYMKwzMEG65YgTVYQNG/DJRMPzzWNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZvIw+X9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab232cc803so6049545ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772127987; x=1772732787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRZ2Eml6cqEbSjmSH4gNnw/hDUEA02qhnCxOoOJRX/0=;
        b=BZvIw+X9KmG8lxB1rv4MJ0cz5Ibgf8J7Or6YN98gbQW6lZnH/nqmS45O8IF1ux+iY8
         Y1G4fB2zgqNwp7vcypCZTM2KR1UD9GVTd4AaGH1OmqsJnBTsZgCTTdOBrBSDpBsq4vD1
         ouCe1o7DX5UmfXCigMnsU1YSuLECCOv4bVzPvxAziaLkPUMndN63BviHyeTtiWM8zFNS
         +o28KzgfSIgNDxPiEefNw0/zGuTGSR0QxOvD25AsdsJd2gMaf9FP9n0nlYouUzgS+vJX
         g0l59N3ac7EoaxaACPJ47xUja0ypYfYVXNvnOmv+b3WgQ4QkUNKC7WvqHhEJ5zdgl4md
         /ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772127987; x=1772732787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRZ2Eml6cqEbSjmSH4gNnw/hDUEA02qhnCxOoOJRX/0=;
        b=XPQ8oiHoUI8e+KnUfZSOeb23RVY5ozGBlYj2O1pWawIeSWRHcuSGxxHQsVYz3fYT7e
         K89Xaj2g1uLy9Y8Ha7X1y4ELlro2wTpN32/BbzGeXcIn9ExQyQfivqO+/NZV0cGzJb7T
         MLXgxgYFA4hm/CaPIgzSRM45LAPeU7htZNmGKOTtOfQLxXUzcnZIBtz1fjaptIOUiNVF
         X5gpNGNCcj7h9vYJQ0vqgbfwybSRHo8rSnaNr71K4bXgeUq+DDnNuoapzgjZLo28D1b9
         7oykvS8uXCuM95JsT7nswKCLx2cRK29YmMRjhnuVLrMjR+xopSB64AUueNF+vcsxUg5A
         ieTw==
X-Forwarded-Encrypted: i=1; AJvYcCVl/wRFdTG2Z04ffdDIR89F8VhEprKI03j0Ru7CDxF0m+h9MaIE6w11aS5/2gmjuzaVLpuzD8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+j5liuG1GbtbOYMEAlzsTk/Kfi+dIhym79rPfTa2z++L01i4
	oUjie9fYmq7dffbr9My5nkhI6M1RhRHyK35Az1QPFyD98GmDPGncyU9A
X-Gm-Gg: ATEYQzyb+xhUJRZxABn+xsftOk7hwlnO4ZR/M2Rgr+aBDMKhN9cbhs8uxtqptElij06
	V+D4zYQtReWnYbijvZEqwVrd3sZ6BoD9S/dSiYPlevP0XH06qsno3XSGmxUtMhPif7YOY02SLaJ
	tJzemyxQE8tA1Zz9Zcjbi+S9iobUCgwz0ZO/w2kmorwWIDxEMKeujOJYCum99/BfoiYVVwB8U4G
	dpHewhPXBLfwrEpgwDnuQi2I/Jjp4lgQwtbzqT34orLQdgYVoC9ojzMnJZZQ55Fd37VKM2UiPbF
	4HRwRl44/IFjWpo4aidg7ekcbkSZFn8TlbMWcZhoVvW84JePUR8RMABFGnDXMJ/GuUZNtMIqNda
	NUBiVBUT3iHHECgYVJbkYSG2PK8dg7S9jivpKFqsAkU3HSc6YPq9SNTv8sgKaTOhg08JttCS0yh
	JU+MgXhlfLDXHrZu/yHsrTgQYq3GLZeUP6eQzldtlpnmf2s88t5qFO
X-Received: by 2002:a17:903:1b6d:b0:2aa:d5e8:f4e2 with SMTP id d9443c01a7336-2ade99bec80mr50020955ad.18.1772127986604;
        Thu, 26 Feb 2026 09:46:26 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3a30:b81e:3e07:2fb8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fff3sm32940595ad.48.2026.02.26.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:46:26 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: yphbchou0911@gmail.com
Cc: charlie910417@gmail.com,
	jserv@ccns.ncku.edu.tw,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v3] net/mlx5/core: Allocate ttc_params on heap
Date: Fri, 27 Feb 2026 01:46:01 +0800
Message-ID: <20260226174601.2120282-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226114219.2111793-1-yphbchou0911@gmail.com>
References: <20260226114219.2111793-1-yphbchou0911@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261519-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ccns.ncku.edu.tw,kernel.org,nvidia.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08B001AD74C
X-Rspamd-Action: no action

The ttc_params structure is too large to be allocated on the stack,
triggering warnings for exceeding the 1024-byte frame size limit.
Consuming excessive stack space risks causing stack overflows.

Allocate the structure dynamically to maintain safe stack boundaries.

Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Suggested-by: Leon Romanovsky <leon@kernel.org>
---
Changes in v3:
- Use tabs instead of spaces for indentation
- Link to v2: https://lore.kernel.org/all/20260226114219.2111793-1-yphbchou0911@gmail.com/

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
index 16c7d16215c4..a8fc1b920e0e 100644
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
+	if (!ttc_params)
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


