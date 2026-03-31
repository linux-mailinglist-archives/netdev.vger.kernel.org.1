Return-Path: <netdev+bounces-273699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGfRDHn8y2nDNAYAu9opvQ
	(envelope-from <netdev+bounces-273699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:55:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5030D36D68F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BC42302EA82
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3985426EB7;
	Tue, 31 Mar 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gdnl5/R+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC1426EDA
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975136; cv=none; b=MgairkLkUmwW9aSDBRrTqvZJzJ+E9nJHftnNkdubS+yBNXHHzlQBQQJCm0W9cVp71P5V6bXcYVR+p1AgXBxxltFm8IsBVXl+MipzvCSZoYlSTWNYATx2qIltjJfnIyb8CpiSzvz2oRZGfjGpn30Wa8NqhrCZrwZxAWTWyLEoaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975136; c=relaxed/simple;
	bh=t2q54dSmGg/P9XU/0IB+SlhWx+nOeGh1AY4CpjdTCuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNiUKua7h9L0oumQ5dE78UUf4A4532v5P6a8a3ahTgUSHGv0GJ9K6BTI2W0Lp/VSRsQGgoLm1QnlvpoPPVO6F91GX+Dq8490fTWM9NL+w/xzVO0+vOOsaBej8b+1joMbUsZVZPoADoTLWam7R3tf7l3DFMYvnpwoFfmbIhtPx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gdnl5/R+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d744d9acbeso2428061a34.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975134; x=1775579934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=gdnl5/R+oaDuaMvwDOUIyFYfp6qP8Yw2o6FiVUH2jNw5pRY4k3qzuZOE2Vh+bq0LVw
         wmB4sVp31HB4Anpf23g6FNHJrIqY3FtAnULqkCfCabSn7TVKOf1r/ihr1ONVuQ8YYfpf
         gc/JtvWo7XqDAad49EetDpvFUpm1NoQ4jUcuvYh8kNxInMO6dM2BgbfJ58z4MH+92FJb
         sdr1/KkpMoyHrSy1dRYL6Td8HWEMP+zw4bxzeIGpqJIuPqjmBCjY4Du0jx5DRKmL/Rgp
         G6wJejvdznZYXK7PyusZosbnTg+3RsK2uOolO4Gt5lom9JEcUm4oDfwlvdqnTtNHyXHA
         9/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975134; x=1775579934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=D/b+lQoQxCmHWUMj5Gz1jLpwx3y7NZXoMUWFVejLY6N1I2rBgjcZvWZhnbP+savnII
         YK2ehY0rNNbp7g+AIFdA3OZFI/StwEG8GP8hpYFXgvzgx8rXcVGGi+lHteqHo7HqdzDb
         hJN62/4lNZkJhxZN+z4hw5KIpEmABFxM5dRNf3i7oZgV+eIOxEDlVoweIpBYIe+njeyH
         5visj3PEj0ey0LKDmQrd5TDtWP4waKMbd6qxRSYZGEdZgzFEusAk1sX91e4rJm7bCLKp
         dAVTjvsQaah7fGc3EywG6jbPQxPTbJ9dQiZAihkgZOylhCyk1bz9q+6oyWjvrShCvVXI
         NXxA==
X-Gm-Message-State: AOJu0YxdZsjJr1v9zX/H3idliLFB6Lxi+QOodCv74WNzShP3mbcI/Wue
	Gg8Pq784Ib8wDoH/cbtwMddNodmPFF+71qQvBeGdRIqiAedUTBcUQdAj3XSXdG+Rd7Ca50fjpOp
	UiO9/Ck6RO/hlaYMdPB4w5Ob3eOztn/FBF/ZpRgZFJnP9o9TgSWXKQptRTUKmKPp9yhDDkT7Y9D
	FJ9ALsV5TB2ztkJ2am0AZe9MKGYsJhUPLMXCetIGA+8qHMLj8=
X-Gm-Gg: ATEYQzzl9wqEPXMkYlKf1qa8uQR3EsuZio9Ex5PAjSb1bYhRnUlh6zu84PJxm7g03Sd
	uMXJWafUr6B2kDVEdxKSAGuRid19lAG7HDfWDgCNpLiDfDV33QMFtBnm6zdxIFHFZc9NriyZEzf
	O3Z6Zu+2vfUDxhi+Fxjl+1TlA+8OMkTH7EgI2+Q7i55gpSV0yJoc2ihUji9boIyOSR1yu19DsAm
	xR4T3F5Cmzj1ahD2Mm1kVp7FF/Fwx3NSgGIcDiUIYPb/Dv/BnPLt/jlwDVC7WWKntRk+NBJ7XiY
	88rt9eErJwGBts7vwWtB25RvSfTJEKWKWsN2LcAxr7u4puIwwhgIe0c6/4xy8i9V7mSIITiuCiU
	s1evrBkUy5T/BecjowxoxtPRrlbdQ9ZFLr5rfRMFPIHcNAphEMyL2wR0DMB20PFSBK1waGWnRPQ
	+lR5o+c1W8HkdJ+betH7Z3Ys4Yg4vY/7oDuiIezNUjz+gjhmQO5YTeVp0X5CPCyC+3WlrAhQtBs
	1k=
X-Received: by 2002:a4a:e918:0:b0:67c:2a22:8b49 with SMTP id 006d021491bc7-67e1863f1e4mr9361890eaf.20.1774975133931;
        Tue, 31 Mar 2026 09:38:53 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:38:53 -0700 (PDT)
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
Subject: [PATCH v11 2/6] net/mlx5e: add TLS 1.3 hardware offload support
Date: Tue, 31 Mar 2026 10:37:53 -0600
Message-Id: <20260331163757.149343-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331163757.149343-1-rjethwani@purestorage.com>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273699-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5030D36D68F
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


