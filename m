Return-Path: <netdev+bounces-223814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76200B7C515
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A024146140D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFD1C3314;
	Wed, 17 Sep 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq/LxN9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838221ADC7E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067818; cv=none; b=NB2wU5CQcqTNcq9M7l3BRjH4YctX4fIJwlg9P70jrQeyas7Hym+JmuF7FFWbG3JdL2eDqtxA3E10yUHMoWikqlGtmPZgddN9D370bt0PSq/7AoMyqxOGzJm4uC5eLxV+Yzk05ECseDgLfQvO5/sa0Zg3G3g1J/0a44TIIkvOkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067818; c=relaxed/simple;
	bh=9DvafNw8cwYPpzZGEMdWSlROiZppkxClbq+lw9hyWNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnqWnrhWOKNAPQzms7Mcguq/pPsyEvtLlIWc1lyrNggKp8g+sT7N8XOIXN4b+DJbHj0EPnPiZl4aCQiAqVn1N1dXrwxpG59K6en1oGrz2LvCMUqi+YK07B29CX8/x2dcaWx2eU4VU9rKsAROlRQPcUOayyGfdeZ1u0O0YRAuGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq/LxN9t; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso4565749276.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067814; x=1758672614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g79/U4urq71CTxSrw75vwBmOS/YmH5rjCGRyqNAYWuk=;
        b=Eq/LxN9tIErnLZAzZmNyLUq2zb8v7oe5Vx0uU21DaJ5o0/korQnRigMdNP8u7n0Xan
         pq2SCL35BPjuHTGbe5DKMe8pZT1wnGiBRR7fj1I3+Ur9jBO/S0LWn/fG0EzNO+QYxroV
         hWdCnYylgb2P9KgiAXvE8Xd2umIdNrHT0TQORmqHyrqfsRHXcTnbwoocddYQWQ9JvA9/
         CjqNXQPbjRkl2ErK0aXjlFL7lhVxtCJMgrkkEHiFbKwJSznGs1T8x/jMd872FhJfWuo2
         XgBbCIWgCCEDkYO/t8PvQu7+SeNZnmA4YgL0MtPUF0auRKrYGg0+1PTNAYxPVdSVkwm4
         WHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067814; x=1758672614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g79/U4urq71CTxSrw75vwBmOS/YmH5rjCGRyqNAYWuk=;
        b=PnquK5dl85tU5FBWLAGxmPtP9mwptnb+Wa/xlnS9t5tVEpvakz1VrvdKpBLVF6l9GJ
         fuuZea/35vIU2eSC+ONnC1asRKjfw9GFf5hx2G5XHLGxBfcoimHUXCiSC0d2XXOEKDCe
         i6eliqyqRE+ZbXEDcEK3Z4VR+bBcgSRQ4WCF6Lj7VPxyDJqor950AfUomdWiI82XWff9
         bI0ZaGRoRzbFT2IOWK4yaE8/xpbtFA50vxI1Jyuhvf+AuCTbs4HRnswFq/PVUcR2QWaS
         di8De3wVvNvfc58B7pLOilRr4lW6wu/Nj4QPZr2Ca48fJ9CJUFoTyW3rAtPzsO7jwoQn
         OQbw==
X-Forwarded-Encrypted: i=1; AJvYcCWTRIAHqNS66nDG7NO/5m9bLOG8E05G8vIixZQDY+ZQvLsGXBcOp6oVAUnukxMGErFsX6zij2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAd09gRmgqDx5DsYfTOz5WR+fHR6TqdsgP6XjW6C8IndTgu5i
	ib6WN7JWWfNHcKWbUgkKjlDCZW9b3YquCI98ue4VmDZkCwLizLHVVIGa
X-Gm-Gg: ASbGncs/UiaJTHUZaOBR1Y0lT1RFKIt0XrmroRfHRrgOdIcBYnLYW7uAXjZjkUaf4qa
	NsOto7M2wzREXU775Np8OeTRjxFzlOgt0+Gpt1HYq2e6s3840nD/LXIUbnna7GDjW4gJOBRPxAq
	/+WQbVVRcQ9H4vnYSuPQLNB8hBDK9LHA73aS+8PJfZwLIuzNdyMSSXKowrgOZts0e3UCbMu/pHu
	ozUi0qd04Shn+ky9z4KQxtssMU+fa2oalwF/XMEZI1CdqjfhIJNWbVllk7p4Ldjuu9HCGE0kVYG
	G9p+cUZAsA6xKh0+EdL4SgqPWko8R2ehC2kd5nH6WVEX5vogTS4zLfXfUfg2HEnaKQ5ghAmrJvn
	eQ8fGglCPxDYlJ+QivXcr
X-Google-Smtp-Source: AGHT+IEOifu8AymFNhuJtvvV4PCpwYMP9Ly5a+YEeML+3nFk01ekMmhANEaWFl7uymINThZJnA9dng==
X-Received: by 2002:a05:690c:9988:b0:723:b330:3dd6 with SMTP id 00721157ae682-738907bf689mr1755537b3.12.1758067814287;
        Tue, 16 Sep 2025 17:10:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-62482271efasm5376638d50.4.2025.09.16.17.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:13 -0700 (PDT)
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
Subject: [PATCH net-next v13 16/19] net/mlx5e: Configure PSP Rx flow steering rules
Date: Tue, 16 Sep 2025 17:09:43 -0700
Message-ID: <20250917000954.859376-17-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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


