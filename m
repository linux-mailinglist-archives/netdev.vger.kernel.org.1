Return-Path: <netdev+bounces-209511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73EB0FB9E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F9B1C82F93
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7923D2B5;
	Wed, 23 Jul 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7lnQRoi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2623BD1A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302917; cv=none; b=Xayn3C7m3Yq4gPBvAGrFxqM+foQY1pU56b9aJkdENR4Ug8BiU/IhJVz3i58ExCkoJY3MkpX13Fcew3zCPPSX96JGj533gYxQbHTaX9C8MIYqqt5Zm/HqsS70KHwm6oQw5Q3RFVmdDnLhVULLPgA0LU1MMXnOIoME8vJrVD/Cj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302917; c=relaxed/simple;
	bh=WpI/cKl2Qsqj5515laGUH0IXAw/fqkTYZLBe8Uk8GFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El6Wffz3Xx5upamMPWtiQlVzYaBnAHg7QZNQ8XEKcKMrMnHReNm2OCydeOt68hnCa13CbpptXNtsBaQbnZcy/VpzNPyqV7G+vSQ0VmB2/WEKSdd34gv9K9oRXFPHawvRU4J1moep7qmOsHxlY18+YOzZw0S88Whm48shUD24peA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7lnQRoi; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bc571ce7aso197150276.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302915; x=1753907715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=M7lnQRoihpnPhf35U+dlmv5IcvlExgCeGRSBHldghKZu8JEATYk3SD4A8fvp2X21du
         8W0R/zQRNDLPqFo4PathuMD4IagpSnCdyX2qmNIzWsDZBmzMK6PwmzBsvOZDjZH837ID
         n2fK0sDQU1Vw66FwnYQCvrRIw1E+pPJg+ln3oiXI/qbQ1uYUlwufd2m2fwktECzN5J3X
         Q9jGSSXiFmaqAp7HD4u4qwtiKb6OKC8jvY1VFoGCxCsbJGhY+wA2iW6ySCKIE7cYE4a3
         l/kOS+WqsLV+PpZNUY2dJA80zM6v8XttNeZ1GSwR1XgKBjTfdFtwr+ImhTrhgjZ+PwKW
         fOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302915; x=1753907715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=MJMj4sG1ZfKfUqlYkryW76hxnXvUuU0eRYte6UKV3ZLoJ/frVI+u4d+JrhHVvryeXx
         vJ2WGn9rzFXyg0baXQ/SUKX+6bZgVeuIP+bHVYjzf+eIg1L+hJBVjJ46NK9VAkWBNK3n
         XNDv6g4S0FKh4znULNWJZjs5nkT5bjn3tqOnw/lNJOYRaOhYFl3nTFyp2fK9ruYZ7Lq8
         /Vs9ao7M7UQWyU2VL2jY75Lu92RYsHfgNO1KiV+Xb7Zb9Qa2ObTYapxevBOgmW8b34xV
         ar/qS84sgaJKZctxowYgVp5D+RNFgrX6w14EEc5q0erA/vT/McRpagyeEAbLjLdA5wUO
         D1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUSVTyN1mKT8F9Qy0BFbJahvVLvyyMQhdnHSVwQU/FDktlW1O8n0lR1lGz8HqQPgs+sf+lvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUEiQJ9eljiXWJl0rRsQ5d6Qv1vkLlWFX3ROlBAOLMakhjJ7b
	7pXtYb4oMlmSZj9UaToSpe1ryf9ZEiZJTJHZHLTckU2QNQ7w3XO95MBt
X-Gm-Gg: ASbGncugFn2rxVuxB2scKXS27MUgQirqzq94XLNLioAV9+hCAEFdDquGcpY7WCjMn7V
	qI75/Zwem6I9GYHzM6eEy3Ukvelhaq0LO0ZMWyDVLLSHmfeFsYswdfAJviAMBUIySro/ryWY52g
	/BUrJnZjHbGc3h2z9Yu8Jd8OFL4BpWyTY5LhvhnLIViXfmJMowo+GpW8AMaAsIDoiD7enuNHj6t
	kd52ezcSqPOUX8FMfIVVK9ub1vXdHQ78y4NWvWsNTQhEffxoGs6ulO/uOz4jh0tvzTQ0+CvmB4t
	HV8xERIWMmcoOiIV/G4BVcxOn57Uv0/BAKxcw9Y24bPpLrP3fAQ1PA+DV2b9tFcyc0NEcMayiRu
	1NYTXRkEdpuCWAjBZmDyy
X-Google-Smtp-Source: AGHT+IFrj5RwOtxuzS0qs33uDDOl6HxeA7EcEq3yIvWnSdmr0whiqVMSr0hLcUTTQqI5kOyzU/p+tQ==
X-Received: by 2002:a05:6902:160c:b0:e8d:958f:7271 with SMTP id 3f1490d57ef6-e8dc584c2b6mr5532577276.12.1753302914688;
        Wed, 23 Jul 2025 13:35:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce4d2c2sm4190921276.40.2025.07.23.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:13 -0700 (PDT)
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
Subject: [PATCH net-next v5 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 23 Jul 2025 13:34:27 -0700
Message-ID: <20250723203454.519540-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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


