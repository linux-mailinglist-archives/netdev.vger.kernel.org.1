Return-Path: <netdev+bounces-203461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F46AF5FA8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4218E52130D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A9F309A6E;
	Wed,  2 Jul 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL4r35DJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EB309A61
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476429; cv=none; b=ryD0dU5uhfxp5nf7rPCWLPWxUFWGY+Y/DIlSx4pHOKEKbCwDHzcDVkNFDVXJYMDLkEXjMXvIcP92rMJHlcf6uQjz106dqOuqQi5SB+ocduSjBbQdNEvpkCpsoyJwqJwxtavDiiQ75sjX6gUSj/TCnsH6ZuAuIhXntBTWfPgQHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476429; c=relaxed/simple;
	bh=DueHz38+DQpLZ0dtCVdAzmvwoilMzSC+ruKEY/DBP9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJoltyvhx4lpE4x/78LqMpo/XrHLs+wR+WuKLeQW4HVaHyxrGS8Jz7DJzLxGewPmTzRGOb+l3p3xJ4782pZOY1xSMWEG/KAXTQNAugJtUmEd8WPpmYvW4eL8XKUvXMIctrFL+v3nSTKVXhd+2FHTdW1euaPw83SeiLhND8UQYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL4r35DJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81749142b3so5579458276.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476426; x=1752081226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OrTEnsplCHmJEUKsuBiPCdipRj/oDNCpQ+WzzvvijE=;
        b=OL4r35DJxn/JKc/AK6w8aUnQ2zOlnIETkF9Fz7A2up2P1DZJp5GYXYOb1AwgQkV1Nc
         h3Owgmr64huQrlKYPd8WS+99zwEDXB8/qIuuEbj7P8LkhFEeIYf8L66zoYwT+0d8i7G3
         pWRoU3RBrfvEXSd+4bIouJP7+KZ/0aEPuDYLxi72d75zUp0nYdOwY5Z8/D5EQzKBi7Jg
         RXTe93E/scyriv45OzM9gK30Q/O+HP5+RrfTP9vxlGgSaeC5IgRCImDa2ZcTc+2bRrpt
         7ON7mFUsS/PzNBgYsQufvxjOF1pOt5OGfuAME6nv2yQUyeQ4du1ENHvFJlaVvglGDRlx
         wjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476426; x=1752081226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OrTEnsplCHmJEUKsuBiPCdipRj/oDNCpQ+WzzvvijE=;
        b=pbvoVMPd5nTFmjcthNYGY1veMjXn2COEVCopsOI78FbUuq9OBExtGQjvIwh8evNnMx
         LSok8h4zyXzTqwKtl+yteeDSCMprtzC9E+s29xG/NYuFLvQOyHLnjiujr/rH+tUktZNw
         mKGuPDOat0nrJ0EpX0N0oSWR3YbrjHqZcRt0sIBVFvCqVSlw7Eheub+5q7Eq5pw+rjcb
         9h8G1hhoH++iVVXhLy9mqW0mFL5wsW/L3jdP5WW6ggKbTnJWMnLRR531IsWekAMtH4SU
         CvM252l3aSUiLDfm8XIcUCkcxoTNCwQ+pPPlJ6MQMBrKIuqUObxgZr9Zx+zhWVfcYGQ2
         H79w==
X-Forwarded-Encrypted: i=1; AJvYcCX+fx2bt3wi0ZLhBPyxKuwciAdew5MDWIFKYUD9Gsq4dGdk/uat4rSAM585VCKDQQr56LNpGyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/dDBFWn2goaxAo6xLIPpOPZZqDVLK2nIvkCvSS174OQkSrFT
	IENRKzLuuFfdao1ix952rKm9e3c/KKhoEp8a5TY7S+VUYx1f38ItQQau
X-Gm-Gg: ASbGncvmrHKTxvWAvDdfFvUfDX+EstPPXGZz0mW7WGFqWotQCD8BX12kUynRXdNhTFT
	W61k1Yz662Hh8nsTtXN/9hDyzbMuwf0T402LiH7MOHSobAqoFjR9UGbpvFjD6EX03js9d3tjVsj
	DUtbwY1906TbhYl4Mk8d5vdw/FJKrUJCbALUNVNwMT+aO7p7Vb7fsHLKgLiOMU6yYk44YPbZ4YE
	QHFq60LrxolKQgAnmoYJHS9Fajr7T+eBlGwoY+kw2pb0lcCgNqiSO6NtwAF/r07YI5WwG2S8Ne6
	UpHkb2Va6DP7dLydroXPhHIq2IAsNXDZXLKFwSONez2giXetgx8RikslIpyo3uYfersXPDQ=
X-Google-Smtp-Source: AGHT+IFxNuPlAHp7yTF3GO5RyBrVJwPb34cb1WSkTPUrr1XqcGwORzyjQDJCfcfO4lJ6n5sUkDW7Uw==
X-Received: by 2002:a05:690c:630c:b0:70f:88e2:c4ae with SMTP id 00721157ae682-7164d56d689mr48681007b3.37.1751476426336;
        Wed, 02 Jul 2025 10:13:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bf0a8esm25576897b3.10.2025.07.02.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:45 -0700 (PDT)
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
Subject: [PATCH v3 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed,  2 Jul 2025 10:13:21 -0700
Message-ID: <20250702171326.3265825-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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


