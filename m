Return-Path: <netdev+bounces-252515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNbXILR6cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CB6D04B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85DAE3024118
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC0392B83;
	Thu, 22 Jan 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T1GsE556"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98036F415
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110171; cv=none; b=qFKxUMNeyfnCd+Jps4+lsn9K/hsrCVBZjAev4GsqqMquFEsSjiWY5STwjoKQJgHZFTodah1cbhcLe+ZEUlv0vnxH8kRzgCcsV86UghOB/MeNP/MS1apK/EaBbX+i73wSkT8fexCAkZqmFEAPefRDWmtwtnWaNLmRa8TpGzDtzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110171; c=relaxed/simple;
	bh=NkyajNX39pjG31IpBQoNBHSV76fg0h2DjgLRSJpGEBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIitPpHLnEI9H+ZHSDRfAu/3jYN4biMgTInnb+VK0HgFxfhkDXJ0AKgSd9N1Oyi8OO0UuihGGWBemyxEIg6RW8aqFiJ0HfbpExaHcgaTx5nllLltn1muw+kFoYrw7nCTKZxPrLitUsv4LDp/mXjK5cmbk59EmhCOoc0jFKzKJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T1GsE556; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65813e3e215so2592820a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769110164; x=1769714964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=T1GsE556hB4mZthozROl+TpZCQj8jYNZT4H2OKHh8ph4f24CuMhPaJDV2jAxxzLptS
         MUchh/SZBDC8lDZQJw0y5LABnlneRFcGXgewKp8hn1QaEMHvZnEehFqiMquim4O5JC/T
         mDerFbCmjOgOSSS4C/UwI7CnBhtLnvcMUBeX2ZF9f7CqAI/NprO6l4NYuAcz9PLA5KP3
         mLCpwizjd6J2Bn62n+A6luxwQz5hp8cJEmLWs8Qa6GsXlINhBq5CTQdafZKSKR9/k3Dy
         skxFV6Dj2ScfJnfzOrI1ZHifCH8jMqXLUIGtWuqfuHLYtXDObTcoP10xK5/dnfuHin1M
         BDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110164; x=1769714964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=EqC2bMGvMsCk7dolJvo/ohKlgcfobp8vXy9LZKwRbF4P7/EL1GL2prmCTkyhaOtyLz
         Bcb/PykCO0xBUUGC8IfG+O4N9XHqW0nxW02KC5F8JccL81vNFW5oDNeSdE2NGv3jy+BE
         Iy0V13IhvTQuVFPy0U79tZmG0BbNAGX2NX0EBD8ikTJmv8LGmQ1Felx2ycP5BvvuvHO7
         Hh+Oo5mzvAOjvbEg8HCp29HWPukljNPJoWXQs5ONIGMaMeUqiMhvS2QFTkcF0BqQORlc
         /bALpuLOMfWD5WR+f/HJDa1Ilr/MhkDvvWM+Wmhoesn8y8f1fIbGfH62p0holuDWkDSe
         DFwQ==
X-Gm-Message-State: AOJu0Yy3SGMRUH9QMpkVU+kxeiSdWZdQdjOKH0saD30bvDdXuCnXJS6t
	qt+0rkrM1ok44bFjZ0WJ3P+hFDlzG9hJ97Ha0mlVdx35a6j1PKlaWIk3NgXMWy7Z/C0gRUO3FiU
	ubAMdTRUzLZE4tFS6iykh49QCO/ZXNGqp6jTURbMa611CLBkfzMew/asHt6FG/Amv7FeKJeE0VG
	/OQ9un0giZdLzkuXgsw/YJVc5e460mSET7IHFyoHk1S9ZQ0D8=
X-Gm-Gg: AZuq6aKLxadG80Mxk9ymQoxrzJG+nQMqMYzLAXxGzKSHk8rCJ9sOXmQjACDNYA/Ibt9
	FbJoAsRVIee8pPDtbc90B3WpOqD9W8DTWoW0tZOyv5dqNjx9x86KqS2XxjFhCSw887FNAgOlBpu
	LENTE5BAEkhGga8KeyRUznLtarvFRikWGURqFAN7QM0DjKE6uyncc4HXCQjsRLPb5oz6mMVROTL
	rJayT/N7KTdQjwUdj6uWrrqg1hMrxiteqkyIXETATjBVLIMk556la/Mj+qgcPnuVSgzEspW2bSb
	Aby7SwQFA1b/Tz6JmC5B2Uy9CWvzSW+DUK3tmErT8QsaWR6SVBWYqZhPS2zNeqxUew/NoSAskEo
	ZDUAEoZXmBP8i7urk4vTc4KHQbVdsz+a03KDYL06Mqao4+9GULqKC9UKJYpD5OchI6WGKS96mzc
	KsDMRw7gTEfDy58uxe85tVPRGuXxaEX81tJsqP
X-Received: by 2002:a17:907:3c94:b0:b86:ff83:9e98 with SMTP id a640c23a62f3a-b885ac7a4bbmr25353466b.28.1769110163643;
        Thu, 22 Jan 2026 11:29:23 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b885b8011dfsm7925266b.70.2026.01.22.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:29:23 -0800 (PST)
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
Subject: [PATCH v5 3/3] mlx5: TLS 1.3 hardware offload support
Date: Thu, 22 Jan 2026 12:28:51 -0700
Message-Id: <20260122192851.86670-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260122192851.86670-1-rjethwani@purestorage.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: D70CB6D04B
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


