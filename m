Return-Path: <netdev+bounces-269668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEBsAyFtvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:39:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7B2D2C0A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A221F30CD706
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418763D9DC6;
	Thu, 19 Mar 2026 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f3I7frGs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9723AC0DC
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956211; cv=none; b=V2kaZp5NODeZxW4zkISgLFdMBT7OkYsOQ2wyNsGxmzAtB1GKNACBd70WzwJQ4ZdY/8fuOrtwGeH63g9Px78IeapcmJdtMiYvf/Sc2yd+//cYP/8+ra12txV3eSfauuFAhZwZrgubxRmDBwBK35Y/DQ+I4rECnReGtGoMQBBPEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956211; c=relaxed/simple;
	bh=pHOw6l3Z1g3s/oNyablVIAgU/bTwPW8pc6h9/Bz5COU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifVBK8jY2q/4VsJVvpfWfq63uK9Ck552EMxwemMZGcuUcH0OTP5k5yab7fFxpw6cEHX6/bvv5Xdhm4cCIYxm2J4ci/OQGbMq2LiXcjheRPZbnqjv1Aa7QWEh1E9795BaEngq4nkVwYrSvQcPnw9rsY/yKRpnv9//pk7fgYY10bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=f3I7frGs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1050712f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773956208; x=1774561008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6s9pHoVDlxdr5dwqD1zPuBxWr/GGAbw8Sd1DAvPnNc=;
        b=f3I7frGs22oenVQmc9yGSnlQQIyVkvy0eJoNxpxAXEErXXDxiTivUKYUyCmhtVMtU7
         cVGfjX8d8Z2ONVLwjOkc4hkIiOe6Ld4iQYlX8F24uq86VXkaKFHbUnTxAbVXiRtuG/C4
         Ty8nNO2M/kF7/QjxTf5K81KQkBolKVNMRtbp9dUnP//ZboFZshvP6X7VdBO+WHK0yjFo
         MYGJh0Olv/OKg1XaIrLy3MX8ugJ0qBehXboQwInMWeAcNTRwdjI+a4k0j4aGVL1/tTWe
         oAETmBzIyN8iaLxFMzTvMtdYwPxBW9NT/GH29t/ov8Is8nZxiERNakGYwIPCfN6GmmXd
         Zdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956208; x=1774561008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6s9pHoVDlxdr5dwqD1zPuBxWr/GGAbw8Sd1DAvPnNc=;
        b=dbq0iFiPFsgbQ0HoSIOv1foo01TEqesYB8woVi3VjKaj0lea3QteZz+QhbUSi382ym
         ADhWQcdOSEjVhBY5W0cnrTrywuaYO83tTWfFmImael6TUZ8DOlcMQ5zYigRA1R+SqiPN
         XY9jOvbg0B1feTO0uWridAW0JJxswv0jVI7hmsuVAEkjxCRcLfiyVNHPj5/05vucp02Y
         Q15J4pO4chNeWEDCGl1yN7LXBt4pfCscProoYSWN9B3ruuDVC5Vy1tkdjYlWdM6pFtu0
         /NowMOx8jzDTKjTtuEGZqhdoSydqtyW3A4kDzN9oODidvMkjIKz+9bgi5OUKy4Ke3NGK
         ZvIw==
X-Gm-Message-State: AOJu0YzKzFPt8JGOMNk1MU8/HkQ3RyqoU7cwbv+rqfFZrJHrveolzNJb
	gwc35RtnhM/jb2T74CNDMUEhAXt1YWdavSumPstZFXlQQKguta1jxD6q1HXJ/nA0CljMAwbAcgf
	K8oDBpKa6+1jkYzVIhViWtJjd1+ze5IXxWpy40ujaUnZevA8Sz6NQE2pv5kqhMCbcBDrv0M9Vcp
	XvYTHRs0Bz5igyxzZRNKlbiG3I1PPaXtlBX06N8DqKF5Q480M=
X-Gm-Gg: ATEYQzw6qnmfeUCgdvpg/GHY77fkxcg8gDdwcYZ2Vz3Zt1qVQYQsA0qRhsJpsfBKXhw
	SFIrNlo+Q2UpehgRX+/Ig9Tceq5NoudiBCbU3aHKg0YVrvAEuxu9xE2TgxfsBGVt1+3d6PRTFWn
	AkODKuwT640zlIZmlaoPcYUs7OwIpC/Mar/3cvR2/Or9H4iAkrIb1+YFL68tLKenHlCKsue0q5d
	mc8TnK4MpDpbJHcTYqLQGA8UjZjKoNmkN6ofZbixyoGfChmeSfRDqUdQK9Re0VX6HtsQPlsAqXU
	E6ZhzCvMaUuZgt0c6lHnBnrP1LAx5LCK4ojDduNYgl2qe5+Rz9L2B7uQunn5JF/uJrPEzQEZhRN
	42oqzN/wa/gjW8q/1AsJfQEatTh9MWTfVT8/ur7qLkUkd6ZNjPACa9vHeLYle2LPSOHJrpTfJUP
	tpv9dBOXFRIFpdyeQxscEnoFjGZSuJiorJ8eau95fR9ntutOX89bMtbaDxR8VDreXBG/trEKi6L
	HY=
X-Received: by 2002:a05:6000:248a:b0:439:b791:f914 with SMTP id ffacd0b85a97d-43b6424e64amr1399778f8f.18.1773956207730;
        Thu, 19 Mar 2026 14:36:47 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm1190659f8f.4.2026.03.19.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:36:47 -0700 (PDT)
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
Subject: [PATCH v8 2/6] net/mlx5e: add TLS 1.3 hardware offload support
Date: Thu, 19 Mar 2026 15:33:19 -0600
Message-Id: <20260319213323.235559-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260319213323.235559-1-rjethwani@purestorage.com>
References: <20260319213323.235559-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269668-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.922];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid]
X-Rspamd-Queue-Id: 62B7B2D2C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


