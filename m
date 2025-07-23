Return-Path: <netdev+bounces-209531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3FBB0FBB2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAE8188EF5E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D59247296;
	Wed, 23 Jul 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcS3Jqym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C73246BC6
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302942; cv=none; b=sBNZyDyhKBoqPPwGDy/1YK3AKb7SQ3LoLVtX1NQCvwjTZ+D18TUU8b/IVAt6bP9DQn86dT93tDALhNZWHdrImpFzGZT3nUfFrno6xGBV3eb5lnODRtJ3yQ+iYKtiXLnEtWO2hkHGOBzv/eNBlsDNzvGxhNeVtgRefbOe36aCbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302942; c=relaxed/simple;
	bh=WpI/cKl2Qsqj5515laGUH0IXAw/fqkTYZLBe8Uk8GFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIr1lgGD1t6Cpib5ORHX0g20ybq/6vaRxtlMx5lVV1PDU2+5x4dq4sWmcY1zyaVmBhBg75pepm5hRS+4jMnEMgC8tHxb3Pa7GFPf0hNSDNdLzbT3e6e1NnnxEpsMG83SFk5d5Y3R8B2H+ByUd8z3lhFlqfLQ0PqBvhRzsNeTrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcS3Jqym; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8d2c331bb5so1108525276.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302940; x=1753907740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=fcS3JqymTjL2qezg01TR0+hxv35sC24qEGd/5ce8BEOKC2/GOsUcXR4wSTVCSg6yl5
         8Vxg3QnwWr1Re36WHJs2byvM8XoxY6LgEeG5j19gZ5YDJwuyxKMOvhQ340IDLAePdt+w
         Xlv4pTXTrhUm7vuU48kA3aa3/sQ3f/LsH7kKVldp59g+XoTJvPu2HZxRdJWjY+h0hLg6
         ZBfL8G3czlXf0Kz47vItq4Zj3gtovnA71Z5mGdclh2xKi/utPxPVSrKz3AWkKLXq2nI9
         uDT5+Bzdvu3ilZvai3hz2+KPOEO4sfmLKzTowt0YhtaU1EMaOgSsUxCt87v7uCQTPf3U
         ticA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302940; x=1753907740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW2vID7G9n8O8S/92XJBCdbQf2oii8hOmXQRKK/xYtI=;
        b=DZwpJzcnrX9Eax54JnXu9aSA9VEC/ifk0L7Y7tD9oUJxwrv01KlRCrm49q++mdEVDR
         OkkfRuV9PNZCeXTDGzAX84RDfmGbE6mx+SEVzFFzcXQ9zuBk1aD/jmxNtl+MTJBMe1rs
         ZG0vJM/xWyxEToN7mxhqkFPNI8wnDzUqWb6W2B/rAdqo8ZgpM0uDiOrLqUZz5Z7zJMR8
         GwQScmyg+12OKcZLMZ4XSon3lb5nOdJzbA4L6SU8L3hSGUuPsdS4fzDULhOKcQUxS6jn
         DRDiGDPDrpMMn8Eb5cmeYKylSqZFwZvMdqJWxVEp+KjJqE5jbI8A4+2z3+oYPhSBurUQ
         5lMg==
X-Forwarded-Encrypted: i=1; AJvYcCUCM+Rku4ulROTn3M4sctTMWSknsv75rUnLnWOb0hdyL1pI+PvjQiOn3SnTHkS8fQ24CltavFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEp26JgPjiouVmJDEGT16pDcobU7fhag2GeMkp2pe/pxq/d/N
	idEgcvcc1OWY6gC7UhKL3QnEPn6pGmC3J2EyxAikm1WJsqPwsQIkaoP7
X-Gm-Gg: ASbGncts5yAwcrZ7WdSVUwBd4b3t1boiqWGCe631g9UaZLapeXPCdJmXjU6ZL9du+3g
	OPYLl6m1C5W1FuOW42QyAZCLagkCrBoET/3mpMgqwhHz7uRKLnsI0FF307EwJotbjNwN+aR4yNg
	5Ws2bZSjqaqUeGpABxDeLuWFvmkSHLpF0IJqCYGPvsoslUZKKhzqRFhh7z3soNrnkCctCsChUO+
	zCO3Oac7rf3zdXmLMgTIUwOVXonLD/xJT381FLguseW+jbHtC0nSrFGwVbRhjKJhBpmsbsBnLX2
	sp62NF5lbQumFE5PUqRWVZLWp3N5NWm0NgVESbL8rZBJ9703u4c56XIV4JtDjQv/3yIxBTYFdd2
	2+KcTmjX7e9nyfksruHE3FZE8FXkTpss=
X-Google-Smtp-Source: AGHT+IELVSqJkMPDCKtZSM/6MO3MLRVpMCBuJIBs+c4j8ImyDGiJhJSWiQauKi2AWG+SQdXGy5KzXw==
X-Received: by 2002:a05:690c:600b:b0:712:e082:4300 with SMTP id 00721157ae682-719b4ccab3bmr53107507b3.14.1753302939945;
        Wed, 23 Jul 2025 13:35:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195313977asm30896147b3.27.2025.07.23.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:39 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 23 Jul 2025 13:34:47 -0700
Message-ID: <20250723203454.519540-37-daniel.zahka@gmail.com>
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


