Return-Path: <netdev+bounces-246391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FDCEACB2
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 23:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF523017F1A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481512D7DD5;
	Tue, 30 Dec 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WMrJIfM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD002D7D41
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134538; cv=none; b=MXjyaH/cwBR7v74DwEqkm5l+Njyoe7kq8kFaOZfahBGGz0I89kU7CYXRpvPbnpvGduYL1bwn8NFBqPUm3xuWkgdD57+vrOTd/hu0wXNsppUiUGMtE1IBvEIk/JAoJmjhaClMl71Oqv/9AVRpyCSINDVCwTnCNV73UkEAbMpeOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134538; c=relaxed/simple;
	bh=ytti8HfhjEI7qz2E/SV9wToGZyResVG1xMQaZNVMCqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fnwl/sPmeQ+aIkrItwChWsH89ezx4/oEwm9F8LKK7wNLs0l1U4z/EfFb7DgCNbH+fuDXdO+DiT9PVsQZ2NA6j9JruH9Ga/jEQk9/fKCqQhJifg8qBtiAaH2LDGyujQWA6dO1LiSfctlhrUSMLvTW0G31xRs1h0y/tUyEBcWkBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WMrJIfM0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so13361982a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767134534; x=1767739334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9U9LNkjVXjPqNZ8Lhy0u5mczUvv7Up+w00WyQpO1Dc=;
        b=WMrJIfM0pzkHRV+KcsuhKdTrtHSniFOIfjYxrliVHOiByA8WZ2YpQH7A2iFXM2fsc8
         NnQLFycWWEsRHcEam0HSUkVg0rgugodgFk+Tpljcb21Upeb7da0x5x5+BNnQBx3ppCJu
         1LcDAIxtG5GuuD0Gx1jHMWD4ThtKvTHkUta39DcYn7PR0bLwekLbF9wLGusHQxWd3jvK
         3gA6Y5jCSKjzSx3Rsz26Pc8ni29hAIJn87r38O5eIKt8gc04Ul/ZKJNQd1bOClLF8Bt2
         Cb91Af6TpljyjWJd+i+mH05gFRA0szRLyyRaYRdvxPMMEhY39QO7k5n++sXsMOhQsYIM
         ukEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134534; x=1767739334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9U9LNkjVXjPqNZ8Lhy0u5mczUvv7Up+w00WyQpO1Dc=;
        b=iFCO+jf/SCIZyMCrZjzl5qIZBeGWroHi0O7bxCS/p3lb2J/0ELfda8niTdbOudbIi5
         dRfunoQED34zykLayKBjPggfiCG97i0uxYRBiuOAMJo0osmPfvXyAouMoLeN0H3aBl1O
         gh+WxrOZlRA296iDwJz2nNjWb4D+iPB+VbsxAv8ECO917j/CRtUsAt6TIAawHOOvpU8m
         qWhFIazkCfHKcjD90MutWpuaW+dUVfCN+PkdRE8IhbG3M9ONmS768WCoukjO0fWKlA+D
         qouoTFTP8gexYyCw0K10HjzMb8iKItTg7jAPieX96PDIMYLpwBKTRLMF65aC7/z9B1Te
         BeNg==
X-Gm-Message-State: AOJu0YzgrY5XMlvypT1FmoE09tkj29hF+YNZ4R/m29ceaz34CyBl7vfo
	3VpOOC+gVNU/UOaD8pbBqL5/7V8XRuM4GPkTaT4dtKNsvPSZLCzrTKhmrob/XNe2QZwNwLA9ePv
	7v2NKCFF7gwiij6aBA9R1w8BJj+akLxLEW2eC/ObkzXusdMEpDkKhTTV8b+UfRxI18M1pLdFhkW
	DWICbhAvzhp4929KE+H+wX0qdeAohz4tKoIGR/Rq3mhydEaJHAKw==
X-Gm-Gg: AY/fxX7rQ4rjA/GxOhZjNUnsvdpZIR/GxJ7Gb5zpcVPjmTKXWDHVKYULyyqaJoSQY33
	6Fcu5mNF4YgfqOOHbZrQgqo7+3pn5VMrBSHGrbaU3HoPrVNoAMUe+jg6BdYtwcqbRyreoRNv57P
	Y5fwfYinzpyMYRy+YvGtDbccp0lg/IIwcRckkWPwHJRUPmGCtNyxaXev8+mmmjuTIi1+XCJQ7qx
	Q1nirydOUXDABAD1Pg5fMobw7eKljOOQnEfbIEgEPbDnznOO+Y68YEfojvDrZZ65mg71WwJfk1w
	eCKJyqfSOgXPqA72BwEwleOoP2Ev5Sdqju9CgadZXbcvKaAkWNw5mAcK1c+psgpZb2QGZ+23e4L
	GCfeMN7gOUg8CFUqLyMNi0Aw2FFa22AzHIlBvYwn829duP9B9hJsR2IFoToVdsKUeWfCdUEALl6
	kxHw/lAnB09ShHw/Kip9iu2TYXuNis4BXA817q
X-Google-Smtp-Source: AGHT+IEehrvR3CHpzcz0HwMMxyJNPnJfQ5bw7tqFn605K5zJWwbvlcA29fEL5wspmrqrpvsU3Da/3A==
X-Received: by 2002:a05:6402:34cc:b0:64d:498b:aee7 with SMTP id 4fb4d7f45d1cf-64d498bb3ccmr23212270a12.9.1767134533954;
        Tue, 30 Dec 2025 14:42:13 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599844sm36214651a12.25.2025.12.30.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 14:42:13 -0800 (PST)
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
Subject: [PATCH] mlx5: TLS 1.3 hardware offload support
Date: Tue, 30 Dec 2025 15:41:37 -0700
Message-Id: <20251230224137.3600355-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251230224137.3600355-1-rjethwani@purestorage.com>
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
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
 .../mellanox/mlx5/core/en_accel/ktls.h        |  8 +++++-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 14 ++++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index f11075e67658..b2d4f887582c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -29,7 +29,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
 		return false;
 
 	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
-		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
+		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
 }
 
 static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
@@ -39,10 +41,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
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
index 570a912dd6fa..2e845f88a86c 100644
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


