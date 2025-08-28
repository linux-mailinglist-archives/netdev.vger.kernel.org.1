Return-Path: <netdev+bounces-217920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B5B3A65C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17AD1684C5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D883375D4;
	Thu, 28 Aug 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIUswZTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF832A3C5
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398619; cv=none; b=ozRHQmlMd2yJ/DTytdAy///KOynTzzurLDshlwDenptOZyQC0f8X8y4skv0G7OMMC8DjhOa1p9UokOf6CHpOPQo6mULsUTWFqVW76mfHzcORHmolByGsJEaJZ6DeaDXdGZLxYkXDhiYQLLrHMMTOSXIw/ViTKe/RG+N+LKIRJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398619; c=relaxed/simple;
	bh=JFlh8IFAX6P6s2rGPz7XX4v9NOCsAuRerFpYCGXCZ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJqW7fFMcDYP/OVzIcNnObCwK9eeKxVE9HG9VSSOoyduku94hKr81KpxNRxpDkjh3uC2C+F4wilIawcPzvBvRJgQVd63e3sGsGN1nL9uICODIoHuwk3ZzJ8aioFwsmJiXCENZk9RYQEBRPULpq3PJQHAiABBJ3EERog32NSjIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIUswZTo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d601859f5so9266027b3.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398616; x=1757003416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=TIUswZTo1qLjwz174lZZy0hyxPkH9O6imRo3UEhWBqsPs/rUXVPGmkHAUnNOCtC+5C
         KoYBEVtpIwEFsoC/uCqSepSL80mUSuFaJL4Z7fxzC7yc4gIb6hQAK1YH0oC0psXBBt8R
         dmj+CzMgANBJVBu5OU1NKQYMu+/qxHPVchbB2wwpNWyMTOABzMettXbawx1zKZ1DvY/s
         JjhoR9g9SkpprBa1S8GsksN6MCRZUele9hoEc57oLoFvvTlg/ySoOh3Tame3c1uWF4FY
         8qD6ZFr6hTE0awTOfs42LGWx9NEKSVLMmZs1zk1BenZDjzMYczcRpKLA+l+XU1xit/AH
         wjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398616; x=1757003416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=dVHuAk6Rl73wQ+T0wIgUF4eMeilc3FLeL/TOiDxrF07pV6FktuK2GqiFnqPMRKyFel
         9BNrK1/VrcpvuYqBEK+xb76D9wOHCUSDDtcI5XJwQ6x9gZ+VLK7LvIcTHiD1xcWMspQ2
         7Jl0NSHqls2N71A53qwCi23XT911Ip8fLSO1y8eoWg9BoQHIQMeeTR5+Ywst5FiS19nY
         GnZAX6DjA1UGBG+ylWsrABuv2eUmTWfRGGNHIhDyiwcEaqQAxdvocTVeaR39t2A1Uuay
         t8cbgfKqE00xukq1BLbNGvzrSgWVpB3aiCqpKYU3Y26e9DXvuE/tzDrHo2iiB0xPt4+R
         Htdw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTs98RssQo7LmUPBsRQY0lV91kZjnHdF6KPoRQ9Bwz1Kdfc37Nablexq2JlkIlF2VePcqeRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvULlSMMiK0uwPmOBNSuyHRaYEIiUu5rq85CO1hcPx/Gs5SkCE
	6m3c6qJNKEErnNWyjVd17AEKCg+kSXyNr3y2SW1Hpa9nqe3JDCBrVgZR
X-Gm-Gg: ASbGncva8pxcuD1e9tvaVEEOqym4GQM7dokuSQMIRWPzLkOTDMMWoSWZ7M2OtDcreUX
	Nn8XvhoG0X4U/FOAbWFNLPArb5txk1EopGRTSg6eypf3m/5cwoECkKq97Dwnf5C61hNFF194Rat
	oOmSnIXlKKI1vX9cxbgKGZ/fGpMAds2tymVhPkRh07dys9zT9YPuj5I7FKC1/5Do0gTh+MWGyaH
	EY3P7+hvMKPEssI8CyGwc4YLvNuZ5pmJ8f0ZSoO6TR+msYx3Znke1JYIeWdW+t53FHyo01fOv1w
	3x2AKnQKEB8uXyVWffYCtL/e1aFxAT/1u9z0fTBHVwsUmpJJDHOkMSEpWH2DWydLfLdYCbuG4RC
	6Xe6X7/V8k6jxwo8V260a2ReN/tcgn2o=
X-Google-Smtp-Source: AGHT+IHgtAfUF0jN2tjsjP0Oi2AiQ807+w5Qo1D2b6uXCVY/vkHsuqWup1ktElK3c+rNsYIBGywkNQ==
X-Received: by 2002:a05:690c:600d:b0:721:562c:381e with SMTP id 00721157ae682-721562c43a0mr53471447b3.3.1756398614592;
        Thu, 28 Aug 2025 09:30:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8f22624asm15963d50.8.2025.08.28.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:14 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Thu, 28 Aug 2025 09:29:42 -0700
Message-ID: <20250828162953.2707727-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Set the Rx PSP flow steering rule where PSP packet is identified and
decrypted using the dedicated UDP destination port number 1000. If packet
is decrypted then a PSP marker and syndrome are added to metadata so SW can
use it later on in Rx data path.

The rule is set as part of init_rx netdev profile implementation.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v6:
    - change loop index in mlx5_accel_psp_fs_init_rx_tables() to int to
      avoid relying on udefined behavior.
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-14-kuba@kernel.org/

 .../mellanox/mlx5/core/en_accel/en_accel.h    | 14 +++++-
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 43 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  7 +++
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 86496e332b03..f1ff79c863d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -237,12 +237,24 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_ktls_init_rx(priv);
+	int err;
+
+	err = mlx5_accel_psp_fs_init_rx_tables(priv);
+	if (err)
+		goto out;
+
+	err = mlx5e_ktls_init_rx(priv);
+	if (err)
+		mlx5_accel_psp_fs_cleanup_rx_tables(priv);
+
+out:
+	return err;
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
 	mlx5e_ktls_cleanup_rx(priv);
+	mlx5_accel_psp_fs_cleanup_rx_tables(priv);
 }
 
 static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
index 22809fbc5b43..f3b05c4f2fc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
@@ -469,9 +469,6 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 	if (!fs->rx_fs)
 		return;
 
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
-		accel_psp_fs_rx_ft_put(fs, i);
-
 	accel_psp = fs->rx_fs;
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		fs_prot = &accel_psp->fs_prot[i];
@@ -497,11 +494,47 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 		mutex_init(&fs_prot->prot_mutex);
 	}
 
+	fs->rx_fs = accel_psp;
+
+	return 0;
+}
+
+void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
+{
+	int i;
+
+	if (!priv->psp)
+		return;
+
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
-		accel_psp_fs_rx_ft_get(fs, ACCEL_FS_PSP4);
+		accel_psp_fs_rx_ft_put(priv->psp->fs, i);
+}
+
+int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
+{
+	struct mlx5e_psp_fs *fs;
+	int err, i;
+
+	if (!priv->psp)
+		return 0;
+
+	fs = priv->psp->fs;
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		err = accel_psp_fs_rx_ft_get(fs, i);
+		if (err)
+			goto out_err;
+	}
 
-	fs->rx_fs = accel_psp;
 	return 0;
+
+out_err:
+	i--;
+	while (i >= 0) {
+		accel_psp_fs_rx_ft_put(fs, i);
+		--i;
+	}
+
+	return err;
 }
 
 static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
index d81aeea43505..02215ea67a2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
@@ -12,6 +12,8 @@ struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv);
 void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs);
 int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
+int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv);
 #else
 static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 {
@@ -19,5 +21,10 @@ static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 }
 
 static inline void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
+static inline int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+static inline void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv) { }
 #endif /* CONFIG_MLX5_EN_PSP */
 #endif /* __MLX5_PSP_FS_H__ */
-- 
2.47.3


