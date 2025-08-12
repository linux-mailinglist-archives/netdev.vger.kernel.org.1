Return-Path: <netdev+bounces-212690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13AB219D6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1476A1A26078
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4D2D876D;
	Tue, 12 Aug 2025 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa8OG7F+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092D1F936
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958632; cv=none; b=lyVp/W/lE2MSoZ5i8ktCC+8G2j4Jk5uVIqCi5fdezDU9DDyo0ZUBFbrEn22z2dhJmOaKp6wIwUM/CZp7DSYBEiRh8JvOtehbc0SQ7Ussti72jIPkY/PbHCl/9n052hBHzItwDBLEOEVZGrrmKeRj9a1neZFHgWpTabHioFhmQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958632; c=relaxed/simple;
	bh=JFlh8IFAX6P6s2rGPz7XX4v9NOCsAuRerFpYCGXCZ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLfrf0JWTN45UuDP+Az9Al560dFIKRp1H4n1IJ8iZeYVtLA6uii8jYpEkgvsXtG4tCLOic0Avw+y6RKUZOdvRAuZvm74YlW2DbnJ6JCDWaC43Mrj5ptZ4GC5uHzs1ohagHk2bL4TJqunY5Xp9IiZ/HRwWrUrzXOQvjvsKgSDnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa8OG7F+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71a455096e0so36118127b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958630; x=1755563430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=Pa8OG7F+1DdsgfrId2fSqgU+tdQp5zrSYpZ+Dup0Fb/IIk6uraB1C8cIPdE4yX4Cuo
         7KrcABRW4UkzgCl8cnWgbWpIRhl55um4TetXw9M9Q7Aw7frblCwjd28I+8g0V6ORh6be
         bP591kw3orOv5fO7CKpogc86vS/m5v6f6ViP/idLJ5NpMMVPEi+iaFGGFuNo20BE85bi
         gzgFBCxJkfUa3SiZOPGIg748s2o2emWzOa6QEAssfrsM2CLKdHDyqigTPcNiLIBT1i6s
         iwRMR77YUwzD7+h/lidV5gNW6CRbhRfofA5DhUPXm8FwlC74UZiV3BexUSSnceVARJ3h
         45lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958630; x=1755563430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHZTltHpHac+2N0Ut7U/5EQqA25GtUwNdIcLRaQF6Ok=;
        b=AM8pc/+LsujWh+QKUMsCsYLn36ihXc2kOjyZAXGCWAShj4/ngnGjsxdqASTzZV9PmX
         SYY9kcUNjJYLS7OUl5l4MIWLwlEIEg9wt/9ks7jMSyZm4WCJ5/v1Elqg18E3HYyHEwhh
         O/ko8jM7k4fLfwQrqJSLBOCbEPzfwa3XfGMDMF1U6EKS/rT1hByx6O+pH7uJYWfdYTCO
         yv0jJ1Mme1XVbQomWv/TB3Ns6sWtpkt/ZY2bRAygkD2NhSuor8phR1Wp9EwtRa/5+0s8
         EMywaiDml2AVxi/cWYqGkikUl4WXrtx8KOJobS6XYeV+LkeGU+SMtGeqFzU13DbbNJgz
         JX1g==
X-Forwarded-Encrypted: i=1; AJvYcCXtlc+aBimni4X9ixTBgsjedLGUiIlQNvoRKB5iJUr3bbC7Z9sQQdBHzmOG2eTTlniEAG5OVvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSgK0dxA4JjmSx3MKuHT0UaHyUafAEmYx/uX288DUwnoa8Jip
	yp6XLmzCffIVA5si+UwxsEsjJJ6xliW/3IFTe8y3tUDtQ+k42vzW6CBb
X-Gm-Gg: ASbGncuWnJ8T75xIsHWIq5ZhYzhI7Ibtubp/beXg/TM1LhEaS+4lwJ18SR3p7rwHPAb
	IjG1JSZZAzDwE2JzVqsS03/V7y8/u4L/DlfQZHW67wrFS845Cn1nB61dBLR/FxVxnFeam9z1CNM
	jccyWT6Kr3Bx5hR8ZQkQ7rUdutpu/QJ/XLuZGSUefosPGC2XQypoIq6mdP9TS79U6uIvDQuz4cn
	u2g6NEhX4XE8rxCE4S48k4G0lxT9KM1wQusuMzTarAFcKmwZEQOOSstVUcEYBwvNB6k7Dv8dDYI
	rIhUhIoH+5pWuv2bQyX+KJNRFOpU8Lu6f07MDOhGZxusZfSk1cEXMirvFn7GzCuJ3zCmHtim4O+
	gJW9nkC/mmzhYMOK8aqxW
X-Google-Smtp-Source: AGHT+IHEqy7WAkI4W174qRKQJ5THBmxPYJNVM/1NtcGPaEZWTd5r3idVnRxQ8X7uKvS1BWdS7GZhNg==
X-Received: by 2002:a05:690c:9c09:b0:71c:1754:2697 with SMTP id 00721157ae682-71c175435d6mr109360837b3.26.1754958629623;
        Mon, 11 Aug 2025 17:30:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6cfdsm72522167b3.24.2025.08.11.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:28 -0700 (PDT)
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
Subject: [PATCH net-next v6 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Mon, 11 Aug 2025 17:30:03 -0700
Message-ID: <20250812003009.2455540-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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


