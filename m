Return-Path: <netdev+bounces-246612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14744CEF341
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB8C43003FC4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02EF315790;
	Fri,  2 Jan 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q7dbXDYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFA215F7D
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379702; cv=none; b=t7ce0t7Qn6GWL/SdMwT/pufIeCGYhToTfucEMlrGUnjzXskP8IEoHceslq2AajcnReTTk2QNxVlrY6px+Wz9g8AcJK8WEuzXSdJdFzWD5myzsTNCz+Mc0JUf4z0q9olYODO6JWla78QWz/SrSa4J7RNbIYvNK7FkdCPNHvvLZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379702; c=relaxed/simple;
	bh=BysovoTsS9aahisMG0Fo3OYA2LgRbe8uEtOpbcmrixk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT5hdo58a0x/nt0h5GW2DUhGU/QeHfK543R7B7ks3ZzNfT8zsKWlpJ4Lg4ODhWOE9Ygl4aIZC41JDFyfsQVd+v0W/NaH6yyHn7UqjNMFtDbprIVr2tD8aFr8PllqSiNzrM28qqLVrHUsS4RlyJg6vqp3VA4GoUYkHXLbX+wqGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q7dbXDYA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso15526680a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767379699; x=1767984499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVG2LRqXdEkY98hT2t92ttyDjkn/XKR4IFPgZ1IFGPs=;
        b=Q7dbXDYAE5aQNhZgYWVPgjhnwKax7sRepgqf2RdlR4blMtv+1A9LwRXU+pbiJGbOBB
         Um14XXxuSNdiIdlzlrk5IKHh+JDKcRFvxX0SMWQl4I3MMY5UomZEQuBBvWwJhzI5wIPD
         WRSG4dtsHwOP8uBrThoOcM1OzRSOAsjajqQxx+kpAFjh8UYshikc3lcT+ZieQjchVYeW
         TpwceINYipI47uLgUY/oo+SokhbXIHnZ/SNPvMVAevH2mUvvJvZgh1N7x06agOtjBLve
         cco+dGlt6Vgv95uUNjMh4WqtrARcL4OSc1zkvC0jUTrTnCBWk70V9l0B5+j1nif0kLnW
         hxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379699; x=1767984499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVG2LRqXdEkY98hT2t92ttyDjkn/XKR4IFPgZ1IFGPs=;
        b=u/xzIcBbCx2LCWFSJ5mlFMD5vVsR5CMcDS8fhzcVs8Nkcib6w0kq3z5HnzMRdmTuD+
         7Bfmvn0MuNuEoZphM0OK64iu14eYqqCWs1OiCZz9Iji4RlMM1Vuywz244gV70nSqx/88
         XAdIwnX+/agBak4+tI+QeDn48CeT8SuFGHP8YDutaZoUho5z2eLGiSP9e7jZctpzUa1b
         Yl+tnYUg2uvCyqVj3vy5+tK0BadtB88/0/e7VtlTrGwtLz5FiDD36ZBT/POxSNkBGuuI
         nTwdXiYxmNDab9fgctOHGMFE1GyAAOGtykqkDtl39fgfWBWp96O7FEjejEGwzVrox0dg
         ls9A==
X-Gm-Message-State: AOJu0YydxpDKNa6rrV/Fl5tgZmJAIfbMb5O4NmvaR4HMVNFMDy64Vlok
	IWBTXGHDwRVJKAlcpk2r63ZyunGA0a0eU6wuv5Uq1Ea6jhwKH3QoDLvqkvVMoSJ26vphQQEZ+xo
	KfnTTpu8/YK7HclyPvOZKdC9XFkyXcystuEb/8KBfCt7OPrYLR5LrsZJdyauwE1dwDJoKtW4le/
	qSjGsgY6Ibr85JXBr1wYG57M1KxCR4/lUKg93XcAb9Ij+nMK4=
X-Gm-Gg: AY/fxX7L1eBvxDRAJlmkKQ6qXl0sBQuc0Sl6rTCUcFFM5FOPkWvYE/z+xURDepzI9s5
	9XBVeU6GmrsLsMENiDQFBIbrFt5gyi8TBGCDO3wCGw409nEc2ZyE+dfHGnUm5V+FIYHtnR/9C7X
	HphfPTlSHWI0ny73huPMtnTqugh+OgH03KoYiDGwP4XNKQMAsLoq+z3ZKEQlii/pY/3AN4ItK5b
	/py5ImJjVjyE5u7K7RL6F788tzrjoYQ4KIg1uLqJk32pa2NcArP0tR4pachobA6CtQSXB/1rIOR
	wnS5MWpI8jwxMo/wU1ACppBqKMoR7nSt2sxpyjQwFVTf8PtGNK9at7INroyd1XnqqIszdmwzIKv
	zVcgRc0mNuh9x1YYbIx6jJTaRohOYUQjmfzWhNBXOvp5jW4u+9YhQORBozoBCT8RLUHwa+n1cFM
	h5CuDsNZ+ky+0Rdnb07Q/6DBpPweNJ3W87C+7N
X-Google-Smtp-Source: AGHT+IGtB3BPEjsdrm5xP54GB6qu1pJyQqHvRLtm8FAIXBU+cf6HLiVOHPC4RnRKlSgWU3YP7rt1DA==
X-Received: by 2002:a05:6402:3550:b0:64b:5885:87d6 with SMTP id 4fb4d7f45d1cf-64b8eca9ba6mr35107854a12.24.1767379698640;
        Fri, 02 Jan 2026 10:48:18 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c03sm44625214a12.18.2026.01.02.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:48:17 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v3 2/2] mlx5: TLS 1.3 hardware offload support
Date: Fri,  2 Jan 2026 11:47:08 -0700
Message-Id: <20260102184708.24618-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102184708.24618-1-rjethwani@purestorage.com>
References: <20260102184708.24618-1-rjethwani@purestorage.com>
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


