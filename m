Return-Path: <netdev+bounces-246461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A287CEC7E9
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB1BC3000EAE
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F042FB085;
	Wed, 31 Dec 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L4KQsk2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E22BFC8F
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209137; cv=none; b=Mgwespeosv33OEF9s4TLaT2p4pF0SGR+OMZGypzlVYCJEJicSpD6GV8PZ05EBKOS2rcCmY7hbYDfhWDhI2xMpMo6B6/Uli25wpoo9kvmCc/pewm0yenRQ2sTFB3VtbM4x2GUjMzZPZw3qfkZSBBFC705I6gvaM9EplXFdofWSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209137; c=relaxed/simple;
	bh=BysovoTsS9aahisMG0Fo3OYA2LgRbe8uEtOpbcmrixk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7Pnq1Q3UZFuDPct0deqLS4y2dA+fngH0MgjXC/v2xUIgWYONMu5j/WTHjj4EaH2R21IENtwrJPzzpMmheWErSANGD++iIKVjQNN0fzb9SDb2cRK9yAGQuDPzBe/EFKdQDJtCu032zcElI7KlgeF1E7/VkkXhLhqJIrxofqHMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L4KQsk2f; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so17644503a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767209133; x=1767813933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVG2LRqXdEkY98hT2t92ttyDjkn/XKR4IFPgZ1IFGPs=;
        b=L4KQsk2fcbJJuHA3Llye1m8TBo0zwDtjHJyRR0xrVZwUxm5/3Asp4w7Ip+Pu6fkEuI
         hGjOnsWx5u/Q/Ij4mQATWAA0snjtmqvYGe11UmsxKFrCYJ3t9TXZKBftkfr3Kt+A50re
         RGtwIFQPWfsAAF5QIcbPlB6AHHXc3+Mqoe5sVgnMjz00nzAw7VIlbJatDJD4MuwHuSTl
         SkngjMedf1u/5Q1SJwigx0XruJxIrZZHEihheyQBWAz8wraRLty4OwpJQO/RFJyp0k8V
         9QHZ1LSE+HHyYLmNtCmDhz/qAX+OOlZM4TP4SNaaRhXbrABj/C0jTbrp11AC4TilB5se
         JMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209133; x=1767813933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVG2LRqXdEkY98hT2t92ttyDjkn/XKR4IFPgZ1IFGPs=;
        b=mmyMeWrVXskNN1h2L4BbTodVitg7PLTa9vfzMX41mP+uQmlQS4x6DbzY/iPaTOgXQN
         PmQOwATDITOdm/HxvwG7/V8q53FjAaW7KC9JWwl5jFWQWmcfCmImhJZAik90xvvVcUfV
         E9GzjdSM8n5aHiDfmVBNEcFP1ho+GWAhnPZ+BWEwk5a/9Rig85tW40UrUIpVXtrKzN29
         WlHR6KvqnTqiBs6ZnWawFfKSbGsZ18Oya0aGWTcf87uui1vl731qIyQBxUJmMJOroz8g
         qwZ+Cva2XL9eANsjA1iukEPWBEhIvheF+oA4SMmovr3GSWVMQQsh2KQ0iL+j8/+ErKA9
         D4cQ==
X-Gm-Message-State: AOJu0YxQrkHgUESg01z4fAM30NI0cLpYeiWYzrRBRhk06jtO1HfYfFWu
	dpzGXbBX/PJ3LXF2D7R1pVQiDmO/vGTfHiDxycG/SC7WoRsA1oZJpf5MUZnfpy+sRDe6arFiYTa
	Cnx6Ef7tN7AbVse2YbaRy0wJ84INFlr6/QbT3vYg/MP5+sKzeXvDNNuErnPCaluRNKAd2oYJ2Ji
	mh1R4g6Sc90TO5TarmTAv8JA/6Aj2h2F5TODU0grE3QCUgj3w=
X-Gm-Gg: AY/fxX7Cr/kfbmM0r8y60hGyRu5eEP5hI83rBT8OX6q+YP7xPbu3A5Zb1D/VDQkEjE2
	+Y+V5LfWn59/c3aYk79Z+pH58ZRaBwIzb+gXcveWZNKZrbcLADjB7kdDa0eeVifuU1ST5JlwNf1
	33cXz538eLxMBcPlSYGRESDtOh3OnRfoPhXqCSA3R5VLJIJRfJF5yGhjhpQSHAlkUuU+ln9MCtM
	Q8joNznzOr7+Zc0al1TMDTS9v9y9Sq7rcivj72x3eRLBrjF52zdu8+liiCgNB1TKiaZDRjerM2V
	2SE5vLJeS5srK3rSqCiRpcboqEtItg53HQwgiNCChBuChqB2qZ/6TN4hC5WqS2OI9hrsfvmpuVY
	MPlun/FI9XKsBxBMpRR3ry82N9Skhj6+0VgVzxRmEHYoBQO4oRaoR4wwguNdT31fl66yijvq6st
	JS8k+wSf9pM5a7bLpsnB1dUvAbV0eOBMWd0ANIfwoRg7zKp1Q=
X-Google-Smtp-Source: AGHT+IGZPoWPFbH3XxiP8Flt8ASV3txXVj6qfD7lOEOnlkmQ/ai1p/r8zVFm+atRXcUfbFvSgqt7Sw==
X-Received: by 2002:a05:6402:234a:b0:64d:16ba:b1c4 with SMTP id 4fb4d7f45d1cf-64d16bac830mr30708112a12.19.1767209133559;
        Wed, 31 Dec 2025 11:25:33 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f5400bsm38680736a12.4.2025.12.31.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:25:32 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v2 2/2] mlx5: TLS 1.3 hardware offload support
Date: Wed, 31 Dec 2025 12:23:22 -0700
Message-Id: <20251231192322.3791912-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231192322.3791912-1-rjethwani@purestorage.com>
References: <20251231192322.3791912-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add TLS 1.3 hardware offload support to mlx5 driver, enabling both
TX and RX hardware acceleration for TLS 1.3 connections on Mellanox
ConnectX-6 Dx and newer adapters.

This patch enables:
- TLS 1.3 version detection and validation with proper capability
checking
- TLS 1.3 crypto context configuration using
MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3)
- Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
- Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher
suites

Key differences from TLS 1.2:
- TLS 1.2: Only 4-byte salt copied to gcm_iv, explicit IV in each record
- TLS 1.3: Full 12-byte IV (salt + iv) copied to gcm_iv + implicit_iv
  * salt (4 bytes) → gcm_iv[0:3]
  * iv (8 bytes)   → gcm_iv[4:7] + implicit_iv[0:3]
  * Note: gcm_iv and implicit_iv are contiguous in memory

The EXTRACT_INFO_FIELDS macro is updated to also extract the 'iv' field
which is needed for TLS 1.3.

Testing:
Verified on Mellanox ConnectX-6 Dx (Crypto Enabled) (MT2892) using
ktls_test suite. Both TX and RX hardware offload working successfully
with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |  8 +++++++-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c        | 14 +++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index 07a04a142a2e..0469ca6a0762 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -30,7 +30,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
 		return false;
 
 	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
-		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
+		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
 }
 
 static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
@@ -40,10 +42,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
 	case TLS_CIPHER_AES_GCM_128:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
 		break;
 	case TLS_CIPHER_AES_GCM_256:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
 		break;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..f3f90ad6c6cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -6,6 +6,7 @@
 
 enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
+	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 = 0x3,
 };
 
 enum {
@@ -15,8 +16,10 @@ enum {
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
+	iv      = info->iv;      \
 	salt_sz    = sizeof(info->salt);    \
 	rec_seq_sz = sizeof(info->rec_seq); \
+	iv_sz      = sizeof(info->iv);      \
 } while (0)
 
 static void
@@ -25,8 +28,8 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		   u32 key_id, u32 resync_tcp_sn)
 {
 	char *initial_rn, *gcm_iv;
-	u16 salt_sz, rec_seq_sz;
-	char *salt, *rec_seq;
+	u16 salt_sz, rec_seq_sz, iv_sz;
+	char *salt, *rec_seq, *iv;
 	u8 tls_version;
 	u8 *ctx;
 
@@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
-	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
+		memcpy(gcm_iv + salt_sz, iv, iv_sz);
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
+	} else {
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	}
 
 	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
 	MLX5_SET(tls_static_params, ctx, const_1, 1);
-- 
2.25.1


