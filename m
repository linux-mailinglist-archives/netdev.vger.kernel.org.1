Return-Path: <netdev+bounces-201179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9616AE8540
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A753189F40C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C12690F9;
	Wed, 25 Jun 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d40thUTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8C268C63
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859551; cv=none; b=jU8pGzEOITyec9qxbSybY+PNNHfTbnoZxqURYaAU5bGpBXMyJ6FpI9g5+0k1ZdG4WOgk1RdqF7bjALfmiTxqjaZH6P6Cfsz/hNM8YCseBB5frmQqD+peHB1xRGDQtJyeff2JiZpcUAT91+Oe/fmJzpzpgler14H//YimIN0kyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859551; c=relaxed/simple;
	bh=DueHz38+DQpLZ0dtCVdAzmvwoilMzSC+ruKEY/DBP9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBYdFuUm9yZtWfqwj2ixUJemX1Z1PZhscMNXZyn13LZ0o9PMKAk1vSkE95jA3epolL60f1URBsRdx7y1hwGeueNcKWwh0BKzat4VVsSo9HIhjjf7KjS0UpAMjwzrgqZe6Qq7ONNVAXx9HV+uTRcYhMUFmHA9gz1ezlJHDCN4dCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d40thUTT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-711a3dda147so18663497b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859549; x=1751464349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OrTEnsplCHmJEUKsuBiPCdipRj/oDNCpQ+WzzvvijE=;
        b=d40thUTTKhw4/8kyrvBFhsUdBeoMIEgg+hD09hOM6phn8xBRa1jy80tiFYaPvirywJ
         L8fb0oPhex4hK4jen2R4ND+KiAUz0nVUXBt/7epz2Kf0Xiv5sz72K3YOFG8y6qDQRSyD
         nhadd68A5KpvN1z0doKuEcBQKcwe6NJY1jk1CGl70bxBp/HiBXmnYEd2Ye3e4ddTdyTQ
         HHDZvLCSC8vudV8BZM3oaGerTD1yD8N5iIANpqPjc0K4OXJHIR9JkD8Dvcc4yv65f28A
         u2o+UfZN0t8RCksV05VyD2HEHMaAQDlTIN3ZkDQYE0i49XrwRl761ARox0//WeFMAzzC
         Y6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859549; x=1751464349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OrTEnsplCHmJEUKsuBiPCdipRj/oDNCpQ+WzzvvijE=;
        b=kv+tqb+ux2n6iIdEW99DePwIV4h5mQE9pw1m/AG/Rges8+KOpDooCwvcwtbXl3/i/E
         04hMD6mffmppGKbGsVjzZAaHchOLxEabCFRC5jkIE3DQn8n1vBomm0vbTTEVunalhMGO
         ftmehBt2qfGYgxSziRPq9mK1H0dUIRL/djZ4lxckrc4YWG3AGaXBtgQyMD7UlTrB9wiE
         AG7xlCarp8tRTelW4zqSOb+N4TT+9Tc6oy5NJBc+DCw/W3Uwn1BZXnlbI4TgKk5B7zrw
         AUMhbS32v1zq8SL/HsljzTNr/n1OuJMgBSU73sypwh9HhWBCYNBoCLPP/HNomSwHXRFM
         wn9w==
X-Forwarded-Encrypted: i=1; AJvYcCUn2RgIpdii1blayHTjnR4njSd+iSjAdeWiisYsGUNyP+lCj/ZTk864nw1INythq4Vd/+onMc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvmyd6uYTThDRXS8v0M7TojJvNYB3+JAxNwIVGN/gsG3S5h2ep
	LCgaq0IQkbfUgE5K9dZzzQXMYPnfdyrAlnD4753hrQLrrEFqcb3U8GKw
X-Gm-Gg: ASbGncth5jYOGolu0l5nQgPjCJ0Yx8ODFBU8fiyV0GANfNOBd9eQVj7lN1C6WwGD57N
	lIage96cDCjOxHX1TqqZ0DH6yCIYbf574ebvdySZMp3KQOHhx8uPzxnCuA+5Tj+iCUoweJm0V1T
	TJiyttwTK+8ukKHlhI7W/7rM4RWIu89+WgvFW1ft0QoguRlmYVRRuBTEwIRbQgEIuBHIH59Z1Vn
	L4DBd1JUgdPNEHdE36914Q0liJF2UUCWZTEr47qlH6BB3T+jsW0EjeIBJMC7QRb341n8o5hCf0P
	mFj/WO/QJdWIN5U/j3gpRgEZrQqEVPJ+61zpcic1We9pK7i2sHgyiyX3jdwW
X-Google-Smtp-Source: AGHT+IHLi4C74YEmVhMY9on78MsxHsECGJghfn9fxHS+74eB6ITI/z+kw1ybrt0Luu3PvXGCUztK5Q==
X-Received: by 2002:a05:690c:b91:b0:714:256:7917 with SMTP id 00721157ae682-71406dd5accmr45129737b3.26.1750859548620;
        Wed, 25 Jun 2025 06:52:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4b965dasm24756557b3.60.2025.06.25.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:27 -0700 (PDT)
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
Subject: [PATCH v2 15/17] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 25 Jun 2025 06:52:05 -0700
Message-ID: <20250625135210.2975231-16-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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
index 789d4373c1ad..b3365ad5baf9 100644
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


