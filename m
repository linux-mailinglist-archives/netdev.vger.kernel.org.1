Return-Path: <netdev+bounces-221941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B62B52607
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F399A007E0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107B26056D;
	Thu, 11 Sep 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A06BScs0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244F25CC74
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555284; cv=none; b=f0HgN+o4ubu/lEsNVGEV73mSPhct0TBr0GX2SWNCPssOTv8fibZ9MSs/FyOZ9m9oXx0L91r9FypqqqgylSlFLd8jMB4x4uyMZcEZfe8j+a5zWivUIOY7w27IoIzkIv0mewyJNvbrlkUiuB993IgeE1scvTDpHDlMG6KOp/gOLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555284; c=relaxed/simple;
	bh=9DvafNw8cwYPpzZGEMdWSlROiZppkxClbq+lw9hyWNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrqM9xshcr1QAKjQH5ymo4YTIPlNjVlrBoJA4ZLgD3MgRLY3RxRZJDxVBiVeCVL/W9zxHu8VjE1mpPfYt7gRKqTOvWjdnzRSiy1MFTbnYQQ1MN03oLzABHWtnyN8IviKRLgupLG1toYo9zY946IAdMhELgG0gsI0EeQJVoL2+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A06BScs0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96d65194c1so107176276.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555282; x=1758160082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g79/U4urq71CTxSrw75vwBmOS/YmH5rjCGRyqNAYWuk=;
        b=A06BScs0/p24IPRit52Vj4aicPKkh1y20LQ0OX709VxPuwO9sfGwZBGkW7odvO3H2o
         rTNYrbyN6couLW0qYq+35OsuS5QYkN4nZ7e9HMUHWenIKUZoSuGUO9EMC+/RftT1VCQ2
         aESjoQGqQ7lyDGQ5VHeQCrRhHQuZr2ilYh0PkRu18tzxl4+VLlKE2CTzi/ByhqT2GdBf
         ZlJpn3ki40VHqV9361KYIGCSNp6QEIeqZRyamYCsi1kFJ2w7Qu5f47R6HMGp/mrJOroC
         ZbHEDtxmFdUSOD6XxhuWX06FSAjb8yN1AAC2JFqaapEZcMrcfiAiW2eStFukiCivc48S
         685w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555282; x=1758160082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g79/U4urq71CTxSrw75vwBmOS/YmH5rjCGRyqNAYWuk=;
        b=pJl0iv2yfns0sED1KF80CBLdgCvH1rwq4E/9L1UyJ/xHfYMlgFf1kNCsP3CS4A4YqL
         yQwxOovVCAdldflIx3dr2yoQ/g2DOc+aXqZTzCLE4i0Z/rDQ+CQAFVvtz155/xhI4QH+
         O8q0eOIKtkYrLUxbw2iZSV/bI4LjNu5s5sQ/X4sAOnsTtUhNgr5S0jMr1SercTLBEdwD
         +lIIyuPbFzXt9q5yWgRTJxHBQEgk1ntGKBresssT+kOW3Z4EsLQcE3rFqtsYl2qw+hsg
         K/aLr02ZK92KdzmNaRCuOE+rZN4/vUeEYjqoyD7HzO5Z8DF4OlawIPCFIBN83vITfxxJ
         g9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzou5nWBVfjPbIr5QbbdfYElgj3l4qSWwxm0aMrKUzzNGHcKPnKOMITj1nJJG5ChOU4ZOA+p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY7P70nDAu4mE+fAOYC9CQoYBAz1k/0cOdnavHlrxNYqXRXP4
	t3neMckc1kOcOsvjDe4Tm/TsVKGPwA5hAx3fAcs61bFO0ZCSDWjWByts
X-Gm-Gg: ASbGncuPPExwKcicsiU9jxsjlX8s6oklE34hrg7kpUYfV1zhRF6FhvatSd5GjjrPnHc
	jBttJB0gGjg24MZFHW+LTIsACP6vOb26Fn0ho5apWWwLGonTdyJ/0eMCbDe30wradhb4yHXHAtN
	aEhD3TGhN5YushXCK2PdSpukZMCNraLNX8MyjUnbfwK2/aSXjmuKlEPBoUE2f90yL/+EpvXL2hq
	pkRzPxfkwe2SQGq6yuElqZCyeKjmYRIImoE8CmK99hjyM+l8m1Oa+GIaLpCJ+qYz8hNbBwjK1OR
	4YXny1aD5ihry9VQX4d6VN2orbCEXa3uL49mPolvZjzR0d+6W1txeOp0AXgUij0GSL/9ZmVAosi
	5TfIHNgoH31fPRsrcry5xOL9CisrkxA==
X-Google-Smtp-Source: AGHT+IEnmNQ7dQpH1RblvnQOEj+XXBOnw1HzRB97lBhJb5mE8DPFBpgnkvkED3dj223FXFi4k0eiEA==
X-Received: by 2002:a05:6902:1882:b0:e98:9c6d:978d with SMTP id 3f1490d57ef6-e9f68e8d6eamr16343172276.48.1757555281606;
        Wed, 10 Sep 2025 18:48:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cf267a0esm64124276.32.2025.09.10.18.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:48:00 -0700 (PDT)
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
Subject: [PATCH net-next v11 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 10 Sep 2025 18:47:24 -0700
Message-ID: <20250911014735.118695-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
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
 .../mellanox/mlx5/core/en_accel/psp.c         | 43 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/psp.h         |  8 ++++
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index a5df21b5da83..8bef99e8367e 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index c433c1b215d6..372513edfb92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -460,9 +460,6 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 	if (!fs->rx_fs)
 		return;
 
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
-		accel_psp_fs_rx_ft_put(fs, i);
-
 	accel_psp = fs->rx_fs;
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		fs_prot = &accel_psp->fs_prot[i];
@@ -488,11 +485,47 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index fb3d5f3dd9d4..42bb671fb2cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -27,6 +27,8 @@ static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 	return true;
 }
 
+int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv);
 int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
 void mlx5e_psp_register(struct mlx5e_priv *priv);
@@ -34,6 +36,12 @@ void mlx5e_psp_unregister(struct mlx5e_priv *priv);
 int mlx5e_psp_init(struct mlx5e_priv *priv);
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv);
 #else
+static inline int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+
+static inline void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv) { }
 static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 {
 	return 0;
-- 
2.47.3


