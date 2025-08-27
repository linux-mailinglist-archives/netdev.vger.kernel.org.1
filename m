Return-Path: <netdev+bounces-217363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C51B3871D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259987B407D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2A352090;
	Wed, 27 Aug 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhvyETXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3692E1746
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310042; cv=none; b=TbRbbJRi6nu6l/AJiCXJdsm5BF6MM4Wu/lJ8yr0yTcBgrZSjDIK03ZSejK4QKwKqZxRIt/DvKnM/ykaqv5K0I8Eydctp8SOxeZX43Ujdcfnfe/AyMHVVlULXpnLsBDsPnRn2PJ/1f9dhk0hI49+hEd5Y/dzXQLluJnAzZxUJ77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310042; c=relaxed/simple;
	bh=JFlh8IFAX6P6s2rGPz7XX4v9NOCsAuRerFpYCGXCZ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oscsUVrUUSVp+1Xk89jOOR2EYf14Z3p5MgSjYkQChj5GFlpM1wC4+owKkSoY5qC4Wu5N/uH9pCL7tkKZFdJosjfnj/tk/SkYLm9Z73Mm4xgqAZ0GSCQl/xCmuHwXBM+oKINytilWuluru9vdxqx57rrTe3tcTrx0Y4hitKmgH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhvyETXQ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso1170907276.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310040; x=1756914840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=BhvyETXQzd0ixUjFJ5K5srRclqJ0MOvTnNMbzGGakuMYN7qhgjY8BAgrYdS2gXpO6R
         iKyiZ/5L3iUc5tCbSLUsSvZuB279o0fpi0nEEFXlE4OZ12ClmMvmcy7n129YLfoTe3kp
         5b7LwtncJz9ZSJYrFh6JnKD/tWsWjl4SE91UI1vYp0snbs5cLEbGMuVXsn2SWHE5+JpR
         7aRKr2fy00fYnL8mplbb76U8AJyf2UZHHy7K5bIOMc4OD5zgLEId4qWhbdjer4Pe97PF
         YECZ2kL9vNvxoVrmn0tKAlsosaRoB2QbfH8Epo9Q2OhocFshJ1BpppOkL3nUMzs4rNae
         B4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310040; x=1756914840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=d0OagttWw7SlosfIGuYsPjFnhnOAxnTv7Qg84bkpwDa74FyQ+cr17pT7xxUps9dtgm
         r0dOn03r3T3NhIFNF8vGxQ0A0NUCxN3nMFIB9eMUuwzMMCV12xzgE3/C5bviKY/fElY5
         k7EjQbGgV8qsVpGkpNqP+LU4tdA/00o1MPqGsYLVE027Ud/PS6hhsmDhMwF2BilnufYF
         r+Sog3fqZdFHmvqf3Lg6pAxEYk5Ny0OKFiOKN+3I9XxnxVOG/513WpoiSioqKjs7mJsX
         Dguyc1Pu5UqFWLSTkha86PMhRHlKhqYxTOpCEVkCAjH9Mjb66ec9Aqttw3hFtBzueZF+
         hpEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+lgfxByfdZYyvS4pdsXhcsCdo3+V3J0w1tgfWW/nfJFoVx+NK1G4U5wSPOy9XOdVOcvHx15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDenjJ7Mqd3RlPV2gAyFHyssHczsZsOYceDlnVjyGEEkQvcuMd
	oD7S5Xa2mTy542GMTr5DyubD9lULw6MUXZEZM7/klB1WD8dEQdwOv6GbVHwmeA==
X-Gm-Gg: ASbGncvOfGNPVdLzLTuiody6AihSPz5uBfyCGnxmx3yY+s3A4NCifzFpYVNw5+JrVeq
	InYoLP5VKpdUhufSvt2r8AOdbkYW7W4t/xuzYQQ9+czpaRSnfFTZFpNSDUc7XI9o20Ern6XiKfI
	lNmb4yvlpyfkfTJ01g6JMjkp1xbVBRGUi3X5XRIyy2zAyUh2VAjv320BbhZNyZ7VUeGT0phZ9U2
	Vn7wlGt5u1C924azf+/kS+qQbuRyBQQ0wc6Ze6cdGXsueHHtoLCPtWbfPnRQoax5ZBeVhU0kOD6
	JeS+tOFIxk/8cGKt8ppIL4Kdin9AE1bH3+q9rowNBAaHbfZi49L7JpyONgCR3QISoNsOWvtHxyu
	w95s+Pxz8mYYaBr7N8g53OTDvYSHhaw==
X-Google-Smtp-Source: AGHT+IHjaxTlbhF+o0UDHgndVvFqaRlZRtSkfZ/Yb5mTe4cl/Tu1uVkNjROQKQ+qimPZDPwVuB5LZA==
X-Received: by 2002:a05:690c:a002:b0:71e:7a40:7efb with SMTP id 00721157ae682-72132cd78e6mr57416297b3.11.1756310039987;
        Wed, 27 Aug 2025 08:53:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f6585261basm3407306d50.3.2025.08.27.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:59 -0700 (PDT)
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
Subject: [PATCH net-next v9 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Wed, 27 Aug 2025 08:53:33 -0700
Message-ID: <20250827155340.2738246-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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


