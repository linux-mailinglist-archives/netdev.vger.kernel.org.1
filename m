Return-Path: <netdev+bounces-257363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGEUBl4lhWlV9AMAu9opvQ
	(envelope-from <netdev+bounces-257363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:18:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92344F84EF
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194963020D70
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598333C50D;
	Thu,  5 Feb 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QPfjgpbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FD33C198
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333494; cv=none; b=h07poRfRRbcCO/p43PuZbvdrFGLOKdo1ZoYkH77er3dhIX2lKOz+TImIL8kjV4buwLTUx/pXPBX9YY/0oELM1Z2iLd1/bm2vYiy/BT9uKNOTpN5MKPeDnHzOQau+mv7AgY0FfCMmGVKlR2+LEkxIor0Iuw36ivgvzfg+HtmCuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333494; c=relaxed/simple;
	bh=NkyajNX39pjG31IpBQoNBHSV76fg0h2DjgLRSJpGEBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oh3ZKu37/4ldEfAegOUFCkJOtokgDHT7EljZm9SUm7Tk2iwImNdmvQWoiRT3bWoO9NP3qqKi+z4h5Zd0bKkToB5XsYUfnXwRXbCnBCm0huVfBwBrZs/JRJf1eXGZH1ue01hOshnuJLNxTN0PJW85XAx6K3oWX4Cl3Ev5yMdNics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QPfjgpbS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b886fc047d5so259806866b.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 15:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770333492; x=1770938292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=QPfjgpbS53/x6DH1Fhe/cm+8Wf114Nd8IKMsuHJgDnk7UmNLkWHzCQ66O2x3Y5UXEl
         eGF8heWklndQrGQy6Q2RmT9mTvlJKH6j6LjHibQkuQ+C/4Wh6yyuvqizpFRSfwKp3oM+
         rC0lIvdNDpA3+bvQBNlX3cIRC3oG/gSgR82igtRrog2w5uoF75dMfqB+a+GYpfdXTShh
         /LIz589RlkbvL1I6ZR84gbSvYP06cfRrbKiSbJPPe1gRnQd8aB5xDw9Bai5o9SP4zUKO
         Lrf7LeE6vNEcHUkrO1Hw7ndtnkYdACDx4Xri9SQG/bNNJtwUC/JWnA/2n+I05ubiwg8X
         ooyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333492; x=1770938292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=Q+t99seG+cMNAKFQV+Zn50skmp4dWDWJekDardgvOHbf9zIw5g6cpYX0NWEe8y8IyU
         LH3ZIrfPyU9nSBEh8uYwKVGUJAO6mKcf/uXuM2W95EhWY0nA72DQH6TU7LQT32LJiFtF
         mdb3ouZFkScDLM1r0A9wGd60UqktRxy80d2lWPIXYN5WnBC5E2HgGtKwn54WJ2KtEJdD
         Z0fYRmoJaHO20Qj2BmFpoDHN2BhuAiUZUOBIWYpoLGu7ZMO7D3exu0Efyx+QcmYEpeNQ
         ev7DV1TA68VK60CxDno3Eb+yzz0n9pY4/SN8HhovfZ422ZuFZc/8oAYa1vsAMTYYNoeV
         b7hg==
X-Gm-Message-State: AOJu0Yyq3qt77BpoUodtrbBy+KDV4SMb0Bh7DgVsMlqrqUsetK3UZiwO
	gU9lgLZlMCaAva5lWPs1tCd5BG1AVuchkLY1EJUw2BNZqFmKl0SK+E8BwQerv6KiCAYVT9yMq9L
	Lm2YJMoFRdy8CAkQXb/voJpBd1lsIMzoJwrnyAtqvHIsQNB4YhpOZrB1pZCzRDuMYPDAS92rOLm
	ZX7YTLT/7PPcBdf9TYbZFs3AZcU7VPlNeEsGAyNEPWtLkU30N9lw==
X-Gm-Gg: AZuq6aJD5+ubiCRqQiTW2BjLYgzv7zd4R5h98ctMEI3R+stCRZt3fqNl4UePs5aCcAa
	MhCGtEs+OruYkKCXP0bBzRzcQgfGADFlaPtimM6vC559w56kD8pzBLQMyP1iFDpKcM8IG9TYBWL
	YQ1vF5cjxwoGQOslkIH0vD5uNpc4dz9PHgyNQ0O/BdBOJgWFIOMdUPoAH4cDPBdei8/vM8cv88l
	CKFhVVt0w3CiF/CV6ObjrkIwxCgM5h3QQQWkOiM6tmtn/wBrwDZa9v579f9UaMeVwKXKQVoEiLY
	l9xg2NbwVpfeeRTTFFT+HDZ2x8yeSriZUkglmn2ds3p4sie/BiowmMrkSpMqMQXGUlJzwml+7iV
	HtO7ekHlF0k6d4hMUNdNb8mX28X9jmeEH33P5jX00h49uj4PS1d8WeOLmEXNJVlNPKe2yRfv3m3
	QQDO4vpP/CHYtXXbf2ix4mz8xNNduH4lQpxOWvoqVahw2SVwEOjd3MkrC1mKpJ5ENQQ642TvKoC
	w==
X-Received: by 2002:a17:906:6a04:b0:b87:35fc:ae6e with SMTP id a640c23a62f3a-b8edf376dfcmr35973366b.46.1770333492402;
        Thu, 05 Feb 2026 15:18:12 -0800 (PST)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8eda74c415sm26649166b.7.2026.02.05.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 15:18:12 -0800 (PST)
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
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [RFC PATCH v7 3/4] mlx5: TLS 1.3 hardware offload support
Date: Thu,  5 Feb 2026 16:15:57 -0700
Message-Id: <20260205231558.139818-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260205231558.139818-1-rjethwani@purestorage.com>
References: <20260205231558.139818-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257363-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92344F84EF
X-Rspamd-Action: no action

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

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128
and AES-GCM-256 cipher suites.

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


