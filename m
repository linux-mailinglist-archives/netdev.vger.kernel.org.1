Return-Path: <netdev+bounces-261262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIWVCcMVoGlifgQAu9opvQ
	(envelope-from <netdev+bounces-261262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:43:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0AC1A3A34
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EED31DF4DB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A43A0EA4;
	Thu, 26 Feb 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6lgVBTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8739E16A
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098150; cv=none; b=EZ3V1gF0MfqqNrkJvhRMSm8aR9JT2o4xaEL0irF0ItxB+8VOOtRdEiwANBWidpzA2OMTCVQTU3vQFMYYhspnhVor39AZRp7zWXZg5lyxexzPf7mzwHWjegxEMNiNr7mkgosLTGDsc5o4zflJWqzakbQ1Yn1IHHWd/RqHEgEHdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098150; c=relaxed/simple;
	bh=7m50hlnAJlw0ejfe2xmll7ZviiXgOenOVChAErGDKDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LW/cwTa86puFERGbcPH95itolYZ+WLAnv6Y19C9/FbGlB/MmsGVXKlfPkyFw6LANktoDBH2PLbPAsBBqryN6uTA4f+TSvC3n27wdnLei6MM5oQrEZWCqYStbp7ez9jzPuTXqMBN6Z1JtrJxIYHb0vH1J08J4nFt0K1WGxe+/ZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6lgVBTb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2adbfab4501so2635455ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098148; x=1772702948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4977eYK3uQ1HpOkmH+UeKrM2TzMOPhtbi4y/GtnY8Rk=;
        b=V6lgVBTbYTw3i7q+wDy5/4AH0x7Q86fWE7/bfxsrKpoloDRzYf8ll06KRcvgPjsjxo
         4IxThn/kP62jEbUneQ9M9iOIx/fXX3fG4iJEF+Xfluhr7osebu0qTrPEg1WrQancC3pU
         bcOHSfWX2rWOAictD/SRIiWb45yXwsUK8EPzMjvd5nrEIfeLnTE2GhEve1CkLRmA/JKN
         gpxZt5yB0L4/PxCACY52WwUJigOcCzvyZR18UuH5GXY/mtsG/PnP5hItxKVYe7GxjnwE
         93TM+ooQfSFnmzYQ8iiwL6kjmjPPh5vtMNmA00nC5TUUJGBh86cvX2cvEE1i6EVYI6DC
         TwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098148; x=1772702948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4977eYK3uQ1HpOkmH+UeKrM2TzMOPhtbi4y/GtnY8Rk=;
        b=WPu2GQxRVyM1MWq16rhDtql7fAFDWmeTdvJ+/CeFuMDWtp5gHBwUyjTr+pa5b0+r8t
         JxdqJ3bqJcUWNq0GooD/neMLzy0HqsihMdVg3XlJqTNsLdp0aFw0kDnw57hIFU7I1tsq
         gz58pfb6ExL7O1FAtY2VOcbH3ze9JXhtyhUMlyR99gkiLguAQ5DTNWij+LKR4eb27nA4
         JBQy9JBgPoBlDINERwAKe606utBUxSPYTp2wUwrozy7Z2uLrozmY6hRYpvjssn9p0yVr
         bdOwA7wa8tKyAlQ/bCzCKsCi2qqkPWeguXneRTnXv+3tD4F1CB90Z48GE2v8fP35d5fE
         M3kw==
X-Gm-Message-State: AOJu0YxiO8K8Qpyh6d512FzrpLOAnHdExAeU6+aLMpqOJPRuBlVq9SXb
	CJWRo/atBnaRXqosbAZ0FlF0ok+l9HVCMOyqMYZX94DojvGiaZIn1KI1J3l7VQ==
X-Gm-Gg: ATEYQzzJU7837pFT9p5sDgYN98oB+eAkWrd5GkQ2KqeoHkxWFrSOpwqHnO0tyPHgb9q
	1XvF1m7bRZUZtPfqwoU1iALQ/kYl5DVmaTX8ix0wGUqMHBH/bE1/siezgJClzGcGAIcjIE/4JPX
	ydskJa83OtrjOsn8sQSa+mlyI3p3Tzy782OdspOsYaorX8NXebTVkM85/VPKmjtTD9+IdJbrlgY
	pSzU43cM78v32TyO+VUf9vW69QSwsn+DbwqnkQUfrhFecfYt7SmrrOXTd5vUoMKG2rdxAlyKqlB
	2vpimjEObX9U4NV8wD8gVG4yluxi4TvHiAQ373MLSqbW4zP8uAKOWQLH1urlG93pBkNw+Sf6JIt
	BXFvC/CDNH1MhYitdYrco0OAK0LddcJuTKIRUcEyfTd6CNMS7cexEFk1a8jWbj9nkbPidiaVuOS
	ZFhrEgrjiPSU7C9fgRs32qugwVoeqmM58o5oCB2gHWzK1NKeV9vpa2TzqgPM/2FQ==
X-Received: by 2002:a17:902:d2d2:b0:2a0:c1ca:20f7 with SMTP id d9443c01a7336-2ade99bd62bmr42471555ad.15.1772098148167;
        Thu, 26 Feb 2026 01:29:08 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:68f:cc94:9882:f73d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6cab92sm18846935ad.73.2026.02.26.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:29:07 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Cc: jserv@ccns.ncku.edu.tw,
	charlie910417@gmail.com,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] net/mlx5/core: Allocate ttc_params on heap
Date: Thu, 26 Feb 2026 17:28:55 +0800
Message-ID: <20260226092857.1583984-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226092857.1583984-1-yphbchou0911@gmail.com>
References: <20260226092857.1583984-1-yphbchou0911@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-261262-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D0AC1A3A34
X-Rspamd-Action: no action

The ttc_params structure is too large to be allocated on the stack,
triggering warnings for exceeding the 1024-byte frame size limit.
Consuming excessive stack space risks causing stack overflows.

Allocate the structure dynamically to maintain safe stack boundaries.

Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 15 ++++++++++---
 .../mellanox/mlx5/core/lag/port_sel.c         | 22 ++++++++++++++-----
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 6eec88fa6d10..8e3862f5b563 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -966,27 +966,34 @@ static int mlx5e_create_rep_ttc_table(struct mlx5e_priv *priv)
 {
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct ttc_params ttc_params = {};
+	struct ttc_params *ttc_params;
 	int err;
 
+	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);
+        if (!ttc_params)
+                return -ENOMEM;
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
index 424786f489ec..83a6fd052155 100644
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
+	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);
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
index d832a12ffec0..69fc596e9188 100644
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
 
+	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);
+        if (!ttc_params)
+                return -ENOMEM;
+
 	dev = ldev->pf[first_idx].dev;
-	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
-	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
+	mlx5_lag_set_outer_ttc_params(ldev, ttc_params);
+        port_sel->outer.ttc = mlx5_create_ttc_table(dev, ttc_params);
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
 
+	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);
+        if (!ttc_params)
+                return -ENOMEM;
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


