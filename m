Return-Path: <netdev+bounces-256445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB3JNpJEgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:55:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C657DDE8D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3B330E3B6C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEA2DEA97;
	Tue,  3 Feb 2026 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VzpU1hyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37888299AB3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144585; cv=none; b=IuEvKf74HltzpG5KavU4vzKxTksgxUR38i2ELLa+QG4jqDpO2L6YmeWdFhcRgBD9Tor+9JrlErvtffAraZun3k5J3BOLSGT9oymyMJhB2ID6TpBdY4ZWyvxgnnVq61dNkOAPX1KlrUG+1Guk4j+7tD5cIbk2QKtc8n9rhUF1gf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144585; c=relaxed/simple;
	bh=NkyajNX39pjG31IpBQoNBHSV76fg0h2DjgLRSJpGEBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5ZfdM/ZinyHINb/RNao602h0WxubQQTxRQHCnhfLaerHorMd7hgK2II/cGrJ9/lOO6MgNmRavXE3DVD8rKwvfVQ3lf4jxD6eO+eqCSXReJHN7wSYM4cQbsmivcG4s0BNIrGI6ImHS7JAWzBfFKpx/cVFWcf+Gjn/AhhewbYesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VzpU1hyL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b88593aa4dcso824157666b.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144582; x=1770749382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=VzpU1hyLP4dIagm+6Ruad2lUDxJk7SCpF0hcGRX2t0Ve4K/1zCFs/SNXe4KnjOgetG
         azhYc6ltBnxf1/uczc1gynPDBOzeIRzowkH8E753kIiOSTVDGtXflgVm2YBT0B9L1Kke
         wuP0KqRfX9J5v21Ns/lTHQ1aWKQyqcNVS58gLW/qAtztRzdbzhC+6SCn+RG7zZJTvm+B
         qCvMDXaJqem/UaKq2WqSSQcf7YiXGGgQ+O0kLXsNpzyS6TA/9MJgJXwYb80IdxIfng5d
         DsIhjetCwTLkUx0RpneQ5sjhJBRB+5oInuPs+RAT4ckSrjE3Vw9qcfgOMT5BKKHr/xBP
         9ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144582; x=1770749382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=qC6BdG5DFYZPz+0xcVBcO/6DLCjjmA0QBHCAhgDj2hfrxtfr9+wSpPiybcpsI9KmvM
         lzNjXnttZZYsPA3fE3UTVfNOhwZdk0k/iMjksC3RpmjgEV5Gg5YrFURaxqzvh1u2TZHG
         t2urcrFrERbDetrfxeiQusq+pG6tQlN5h5GYgekVAZgXxlt9hO/8R5TieWiZxZOElH8c
         //iNZ86TVCqeMOl1gUtIL5wcrXcb6rOM39RNjmWGXQinAeSSMVL26/FOW+g8nBaK8Bwr
         y1dDE5u7GZxKUeksDv74x8k6v8p7WtGZlna6ziM+K+GyOxxQBTfZidrn6XTEe68zcUr3
         y9tQ==
X-Gm-Message-State: AOJu0Yzr7jG2WMZ820MCwXappzUo9rroefqKjhzv1FlhE9pzz3/MUCrW
	g1vYIM6q2lePpbr5e+/83kaEpDSZ8LLMydRdZsG8/BWiEtaToxeEl8xuJl8BwqrwlV06E9OxpDs
	afBAgrWEY4mERoatSjN9Nwtl5PbkQ5twRWdU3AI8oiaY/HLw8XWJyYH4RHioEtbpMbiL66kcdDJ
	Mn1i3SUvzFSghKPUl9IhZnld1GrNfLlV95PddKkbsQXpBk2D4=
X-Gm-Gg: AZuq6aKf8kuEiEbza4PqjzlmughoWLAFCt1+DJczt69dIMHe+fahU2OJZDVzC9Ka6YZ
	VNndbO3ASs6QOJ5jQZznpN/NMFdgSw7Fsp4t8HiirJx1LCgpskRnGpOFwCw0RknSG90fr+YX89Y
	VKAmsX/HGY0ZZ96Sipsvge3vEUdqmcoI5WSiJ9yrfBqWfYe49WrdkT/po7pcPJaqr5267KdiI4Z
	Izc0grN96+QlhwDh0FK+aHyrzwXzwdP5t5+jEXX37l/a/p+hwWUcGibK6pvrU26WcUsohA0xDqx
	A08/Tq43lU76VS011idP3TTmnh/bn2C3SfTVwRgeSscZayn6ULRPT/T2mAVxUkYzxZpXQX7ebp1
	3DUdX1FG05nklBe+fMMjwYENSeIipTPMOVoniJG5UCbWyjNO78RhKSg1sb78rSyP8pMT3IW/xsd
	Dn4rtEOCXDYjBGIXONiRWv+w0Kz5zYs/AZ6mgg
X-Received: by 2002:a17:906:4fcb:b0:b86:e938:1b26 with SMTP id a640c23a62f3a-b8e9f0bc141mr36427466b.24.1770144582197;
        Tue, 03 Feb 2026 10:49:42 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8ea004ff2bsm12107766b.63.2026.02.03.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:49:41 -0800 (PST)
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
Subject: [PATCH v6 3/4] mlx5: TLS 1.3 hardware offload support
Date: Tue,  3 Feb 2026 11:48:34 -0700
Message-Id: <20260203184835.3619101-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260203184835.3619101-1-rjethwani@purestorage.com>
References: <20260203184835.3619101-1-rjethwani@purestorage.com>
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
	TAGGED_FROM(0.00)[bounces-256445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 7C657DDE8D
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


