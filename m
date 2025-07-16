Return-Path: <netdev+bounces-207500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D16B07889
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB941C40A4A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD92F5462;
	Wed, 16 Jul 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWRXze6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746932F5334
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677188; cv=none; b=YVAfvcD5y5S49QT7wCmcwj23ojndGq2lnvEWnbyY4k3iDxlaO/WMKJEY7wuPFHV3nyM/7eqbODcccVD/IbuGoMIypUHWf5bWvaKKxLPD/4HGHphKHf+cKzflUjDtrwsoHrvS7qYIgWvLjbNWYEOmM+Wtx77HFMpvvH7dpBpi5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677188; c=relaxed/simple;
	bh=WpI/cKl2Qsqj5515laGUH0IXAw/fqkTYZLBe8Uk8GFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX2+h66wqojisLEeEDmWiRvevTqDvkM4Ld4YGuTvxDQbe9f+QzhE7SyThplYNOhKMrzeuRTmXH8Z5BSh1ddLnKw32eEnq/SkPcl3LfF4nlShE9IBbh6nZgO83NpVA4cPJVbnHdvjIGcQffhIcASv61T14Gv7ryE/fE0NJZfZ4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWRXze6G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7183dae66b0so5606867b3.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677185; x=1753281985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=kWRXze6GtlD7C0fE4mwy4aOU3JEJ0PIEszze5YMCTFZStE04H+P3CKeCO0nwODCw3B
         fIOZBBfdWpW/4x0yPW9S3YH/lmOUBTPR0y9VZcwY7ShAkD4pbYqx6FWfjqPVc1kmYdo+
         Y8dZcobJt8oszorsME25PzFMk8gOiI/b3PRAgd/0ezVbhY1Aj5o8PhCBPukxE1J8l/Dz
         x4YMUt+Yg15+yC0SRWZ+Te3aosnruROefIIPZMPZgex1rxo6h2H5lziKuHYy+zu0RdhX
         p9PV/hdBGVvX7Y5bydZfyPTdxnHCZkI4MkpYlK79X7G3oHeIaLqFqZFooUddxf/LkO2g
         niJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677185; x=1753281985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=pF2nFq4/4Q2VgMPzyyyDH6GFcfw9tFyCUu8G7Kdu6Cc/E/8qQY/+Zvoj1q3n57hjZc
         +Lh1vjn0UdSy/7OPM42SPLhMMBPm2Kkvc/WJM2PZTJ+teUz0Rq74IGcoy11DamxEmtvW
         vLqqPx60MvhKYUOz7a68ZTBYDAn4NlTresbJs6zcCySvls0yYSrqUru79/gUakHWrtDv
         iYFQL4/p/c7PDGXnqfCrx0ZucO63qJsp4cWmo5dYH/mCpDyRvOTEkXE9YQ9RqdaNU8qv
         vn0YHX060IoavaCZZ33wkN7n1Nz61t2R+2rpU6LFycgQMWnx5iRouY4UEF/rA0WSMsww
         2aMA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEQ266EBgMGdrR6rtPj9v4u1UtbHSgSF+eFxl5bYSJA0g7L5hca9IyODLVucHQzF9MFA25ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxravt1qxky08+6x3wpg2h4eUxDx5e34fE6ys4OjMp6vG4VDU69
	YSK7fXXsVwtkJUyWQZbjpoPfBohWUzx4HvD2gWLPggJ8b3KNmgCRz24J
X-Gm-Gg: ASbGncubh8QFzZipBFILiaYV+Z3tUyLbuvOp/unER1EWBS3uoNs49gbzXDrx0gQXtEa
	ecek7nkKj0Khmzj8WwgSELRXEvn3hpybjpWhu2jGfFhY+wwN7ZgxrOIAs5vk+1eOQCQ1nm1apvP
	lyQOjY9L4af8KccDQC+mruJB4bzxRyBypNVcHfbVDpNxi2cZ5LEhuvnDyG10NeKMLzB/BUO5XYY
	cCHa6y8xIxnS1nhbQxzl6YGILwXIoFzh3Yabtd8B1jfk/nHgOXD8a2ieZrnL/HsciJANl7SWWe9
	eBOJA81kCCiNJ0GtbHlTDmvuvEMb8d/E4825+y2ucV/fqNreAfMbOn7C6kkyTR1P4AlZd3aSzPT
	bzvP6ar6eqgjXs4nQ/N8u
X-Google-Smtp-Source: AGHT+IGghTqs6zc/uaPjREBX9/AmVlvJtAEB4ajfl2gzs+Yd6TK2mfGAwTdh5fTNcLHuxJsBy8cSww==
X-Received: by 2002:a05:690c:700f:b0:703:afd6:42e3 with SMTP id 00721157ae682-718351afd7cmr51617367b3.37.1752677185415;
        Wed, 16 Jul 2025 07:46:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4d14sm29297337b3.63.2025.07.16.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:23 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 16 Jul 2025 07:45:37 -0700
Message-ID: <20250716144551.3646755-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-14-kuba@kernel.org/

 .../mellanox/mlx5/core/en_accel/en_accel.h    | 14 +++++-
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 44 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  7 +++
 3 files changed, 59 insertions(+), 6 deletions(-)

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
index 1d0da90d52ce..b044c475746e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
@@ -468,9 +468,6 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 	if (!fs->rx_fs)
 		return;
 
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
-		accel_psp_fs_rx_ft_put(fs, i);
-
 	accel_psp = fs->rx_fs;
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		fs_prot = &accel_psp->fs_prot[i];
@@ -496,11 +493,48 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
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
+	enum accel_fs_psp_type i;
+	struct mlx5e_psp_fs *fs;
+	int err;
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
2.47.1


