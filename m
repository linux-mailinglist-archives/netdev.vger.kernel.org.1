Return-Path: <netdev+bounces-282462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIzIEqtK8mnNpQEAu9opvQ
	(envelope-from <netdev+bounces-282462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:15:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0A498DED
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A1723027D9A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E713502A8;
	Wed, 29 Apr 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gINiMFmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7E3148D2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486314; cv=none; b=O1ZjxPgtbY6a7x1qKArxo2cyhBwlzxpMO+uqFf6o8ZFBhibEzzJPNyt1hjPxWTkImFYHn4nRbhTHoMJ2xziEdo+N8Kbfvac4TUoVajUj3YVyZC+S8zZxWbMrDnYUHeAIjjdChxya+e2OChWMVEuNJogTlclUwVSI/JKFadTBBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486314; c=relaxed/simple;
	bh=t2q54dSmGg/P9XU/0IB+SlhWx+nOeGh1AY4CpjdTCuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgvpgLTxvG5qLblNbNQu9ShWGZpPgEk2u8y2j4fyzV59yb5qzEVeDSCVS4jeweA+lONhO3P35l/JD6xaJX97VtZQCY8kHVqtuM0CnnI3DgVMQqcb1Jtf1MfwLsG4Psyu01bSNlRozax8P0cibinuQZMz/+XXzm/i+71c+QZ/ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gINiMFmG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso362005e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486311; x=1778091111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=gINiMFmG8p2tSMHwnVXZYKRYbSlr0wN0IY9hqusE0SW7Q546ERC++mk3+ejFuriq5c
         y77iwY5lk5mxf03YvOexJYPb3cvOxwDGOW/UtKZTbnENwwAUQztqkCN4kMW8O2mXrwwc
         2GFkX/7YIdMXVLmKOfO8kG/zCvd4jipVX5RGPvzN9pqzbUsBZYgSroY4BOt9qKgsa+t5
         cpkt6S1evTTI9MlxZJQOATksk0ivOc7auM4hRAh/o2kmrWiBRWbxvorXbCergStLXfHN
         zWObOsaK89JE2Z5MeEcaHWfSwUQmUWExf6/x6kdqQBjG38Qf4XY4dZciDpSUwd+K+Oy5
         JjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486311; x=1778091111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=hTflpHiw2y+t7xoI5fIxuYOTgRBbnbPVP2NJc8SogXhL2d2cIJThea6r0k5FbdL+Aa
         ssOjAFrxRpc8q9WZ7ELBNVuj+vjvjO+lRtbxqbP++XwO0Ks92wusD/kLL+Yb5gIDSrWv
         AJJpks4UZpZJVKUF0cuYEXHmUG4xATuMrLLxrbDy55uaF2e2nDu1eqT0UvZJen6m8Xwz
         0a3qi37DgnC7cgRITVTUv8Zx0jRqgExt+hfS3f9/14fqlJIjlYuCPprJCxuHUiNYAoRP
         b8DMSXKWfpd2iX0p38PC0hme1/XlCoR7fuY60bOiqiSL13rEynirSkt8gNycBNqOjyuJ
         UkKw==
X-Gm-Message-State: AOJu0Yx0Bjm95WefRKqckw80jUHydbF0Gd2H4XLEM8zkZWtwFRKQMOzq
	UYZuQlkjGAyieT/WJof4NyiA02lzmntI3d4gxGYKOC4x7Hh9FQ6qSL7xujL6sTiQl3kQSZbI/Sb
	hx7P7WKSKJmX4ya52l/CvI/ycyhqcDQU+vg6nQt/oZoXJ4duANDdIVhjWBGtZiJC3MSm5JRBMbb
	sXWk/tNMQF2ysxRqlNP554fOsz3bWGDCE+wcnknsqY+vUDtUQ=
X-Gm-Gg: AeBDietExZRcDOoniliBn36gIuyIdnAZgYNMXtHiEx6mG2mu2pZ5rzjAvrncGHQs7+n
	dujPIesKkPvuJWHB1zWK5AtLIKo4ruUK/7k33Rwrug0tYUg9Vq+MMt41A0Vse53UFTKnvFJXoYf
	mc3UaBmKLImia+X6WZUWmF/dQjM3DaUF22AYUulE5G9Xneh8ghaCepYxEhgyCloQ7GT0CJWHpYM
	KsQ/0vzBl0r4oVfUDp1TPD+vcGynC831+x/kQMLAXMmF1LJg5l8ZF/1udDPlsgw5zw7Exdjspp6
	hd7dfhaHcu0PUtp8T9cnz26AoWEXopSlTKB4SRc5gpYGpDU59Hl5fSJ+ePRHaTRMZfC8tH+j5YT
	k5sQ127S8BM+H4Et68rKNOV3aC29DTnN6UJpYFJXGUsC/CaVQtPu/AvVWX3oQUBVX9Y5i9nx3U/
	z/rLfwU3mzqumvE7e8D2JFDeWndOH1IlaR2EC3f8BlG4pTKEekHEXxptIegrWA3AXl4Dk=
X-Received: by 2002:a05:600c:548e:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a7b51b02emr81911365e9.8.1777486310549;
        Wed, 29 Apr 2026 11:11:50 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:11:50 -0700 (PDT)
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
Subject: [PATCH v13 2/6] net/mlx5e: add TLS 1.3 hardware offload support
Date: Wed, 29 Apr 2026 12:10:12 -0600
Message-Id: <20260429181016.3164935-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429181016.3164935-1-rjethwani@purestorage.com>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDB0A498DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282462-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]

Enable TLS 1.3 TX/RX hardware offload on ConnectX-6 Dx and newer
crypto-enabled adapters.
Key changes:
- Add TLS 1.3 capability checking and version validation
- Use MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3) for crypto context
- Handle TLS 1.3 IV format: full 12-byte IV copied to gcm_iv +
  implicit_iv (vs TLS 1.2's 4-byte salt only)

Tested with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

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
index 570a912dd6fa..f3f1be1d4034 100644
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
@@ -24,9 +27,9 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
+	u16 salt_sz, rec_seq_sz, iv_sz;
+	char *salt, *rec_seq, *iv;
 	char *initial_rn, *gcm_iv;
-	u16 salt_sz, rec_seq_sz;
-	char *salt, *rec_seq;
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


