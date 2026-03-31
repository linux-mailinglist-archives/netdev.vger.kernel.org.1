Return-Path: <netdev+bounces-273395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FRINkEQy2lCDgYAu9opvQ
	(envelope-from <netdev+bounces-273395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:07:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 423103628EA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7FB030221C9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF14DF6C;
	Tue, 31 Mar 2026 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RciHCOBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301D40DFAB
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915516; cv=none; b=HRCj2mkZwpnfBDLNjK8vKCDx54L1887OSzG26aGpzwaNDD90sprQVvkENRzqtnReZr6+2nVw10P/P3IxsEkgRmQuTmxM4kI8+a0c6jNrC8EG+w4udWth1+CuWdCASrW40FCggqcHLbOQqDTUOaYSWpzIlAVq8o8ijUQJiTyB4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915516; c=relaxed/simple;
	bh=t2q54dSmGg/P9XU/0IB+SlhWx+nOeGh1AY4CpjdTCuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjJy6YnCf6UDnqlbkdj48WSUj9K9q/8yeYcaC2FVu6w/LC6DmqTj8EWuXeUqFWRhisHqfONusEpjzQMVh/e/q5R054bQ4ipRy0M8P4OkMuTsOvdszGF+trqJeZRnCjj8lHjvTVsXEznVSrLbVH/cRDcQ3Hv+hvjFuBdofL553Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RciHCOBK; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7d4ebccf7so4360108a34.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774915514; x=1775520314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=RciHCOBKhq7yhvPigzCn+YKSfSGHAF01TX2xuz7M7oM1pmupwcxG0rHM/5uWukSWGd
         qFBF0PdhCudlOPuVckInro1H9BDiOgDpuCGBlhs2qWVZ/lGZxEnEEGI7PZ3mqPftGlXF
         EcTztDm8Meqrl2ByEJK0LicyNXrMsEMPmmBgjJqFP0PJsMJZynb5shmumSlkBD89y5Sq
         hSwU1iHOzZDrDsDslJSRsSnp2KnDQZsyxdy6ZQYVVbtdAHyUQEkLLevywrfxqncK95Ln
         2aAG20vzi7VNIlTQmOkNZJElVyZT/r89ty7LGrT8Kl5cIdgk+L6x7/uQT7RpU+YlkTCy
         19rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915514; x=1775520314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=gUIEKaRhrYhcwHTjsJ3r7rJ/iLEQCSsrp5EIzmxIyW728WF/JBWZf21RFROyCwHHyL
         ynP4c0hIY4PTJq9l/XDvJVwJH818y9K7C7WWCxop9XAav2ycJZIK1OUO0s7ZAPTXHKEZ
         +3bnA31MtSDYfAtcuZ1vO1lSZs3BEzWnIblfv/eEdddRKteZVqVW742T26NvHOKFrFF2
         4c9oY5WQZrmEPku3DcXo1pu/s5wrbeOtlkUwh4GOOw4QnrV9MOncUHs2PUNcOt2MqhG6
         Xk54OLlXHYPAYuDDQRv7wl2qWQJLf20VXs9dhapbW24TvQqIP6GHuL4FZWTw+ErVhOl8
         +/hA==
X-Gm-Message-State: AOJu0YyB6wfq4NI74YrFQjrWNFhDMk0Y1UHYms5UvJkFOU70hnhFCkAr
	WggPEAXPBlWhKwaK78snHnT+xM9idC+6XGpKTSDUrwGt1453+bCPuaiwecFV+/T4BsrhhI7forT
	34UhuBH3Pg+kCL2WKSqIwo6TUqB5H5bA5GFqXH0CTWNenrHyJ86B6wHOCx+iwmMeUu4I3U4/tLz
	RoiJ0ILZuM4zGTjSqGXJ93vQYuIOqIWMXr/r+ogpD1CzH4H2M=
X-Gm-Gg: ATEYQzzQ1qECwo/a3eaUl51n/O6qEC8BaAzP5EeapQpvSGo1tSV+qyyWhTi99gz4c1F
	0or2cicw8UMViQhTSf8HavN4+yw1cvBnvjB+LaicDBiyfrUFy17ezNkZ2GUTfKcDugiozKFIu7N
	zWeR3JKfOtridNF+ElvEghFjXK8kkhq/O0n0uxEgHPI3YndM20iqkZQjVhlazDzHdDFpra5JUh6
	WvsFbzvHW4JAfvAF38/HI/nbJeKWzVVd3UOk5frRK3MXzHtjbNCubYtzw3Ei5rIlnrJFmmCUQ4e
	crmvX2iifPoADpOJ1yYQJkfsntNWdh6wq60DnTPGJlnndKzBhKiRhAwkxrfOCvEocHxaNoJ6rzE
	JzJ66VnesybWwKtsAozzqEp8y+ZwoCmnMc0SHXrNvFSN7Ra/uFfpfF1XQ5ffocy6QUwsAs90UOd
	i0qSV6t0GwbLqCZNmRrClIs6YqX4sIWaiPFciqB74SkwxQ/9GuRRPon6oxRqvIUqreznXPhLZ11
	+k=
X-Received: by 2002:a05:6820:1609:b0:67e:3100:2ba2 with SMTP id 006d021491bc7-67e31002edcmr3230940eaf.62.1774915513816;
        Mon, 30 Mar 2026 17:05:13 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-67e231cb2e2sm5627807eaf.12.2026.03.30.17.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:05:13 -0700 (PDT)
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
Subject: [PATCH v10 2/6] net/mlx5e: add TLS 1.3 hardware offload support
Date: Mon, 30 Mar 2026 18:04:40 -0600
Message-Id: <20260331000444.4103528-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331000444.4103528-1-rjethwani@purestorage.com>
References: <20260331000444.4103528-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273395-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 423103628EA
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


