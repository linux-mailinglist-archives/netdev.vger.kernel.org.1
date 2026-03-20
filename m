Return-Path: <netdev+bounces-270117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL8AM5TfvWk1DAMAu9opvQ
	(envelope-from <netdev+bounces-270117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D55052E26CC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24E253037FE8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95143A1CE6;
	Fri, 20 Mar 2026 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gUG9ORmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EE3DBD42
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051110; cv=none; b=AMhUz6NJ5niYY9nVj+3Qcxhob+jN7nhXR7Ujs9NFTtH/yoEm/9AT0CxFNE2TXPoRTr/mxx8DmhL2S+ZGCuYg1c1llOtDDq7tHHrDO5ADld6RJf0EXJPT0IgJplWsr3DQAVsip3oFXtDZrTfJ+KyI5MnsnLoBkuty4sOVJZzsTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051110; c=relaxed/simple;
	bh=pHOw6l3Z1g3s/oNyablVIAgU/bTwPW8pc6h9/Bz5COU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+rDGcdBbu21/4N9kh8U1qjO6xl7ZQa79ql/VPVmRhct6h8W1/hNXAcU4TOkyw17qBeknY25+jgVieVmjJp0RqvS89/Y4y8+DbSKajU0JcWbAwTPvNpeTO7VXqM+Nq8yrn1ziOJQjR6OWdDSb37He7sRhcRxZmAcJYr7axjgLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gUG9ORmS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so9471695e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774051095; x=1774655895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6s9pHoVDlxdr5dwqD1zPuBxWr/GGAbw8Sd1DAvPnNc=;
        b=gUG9ORmSh4E+DC0JkVSii/hzqiwQxS9J5K6VJV9WhIc64ad1wZ4sNDYVmJF4ZfRJdK
         H4VGydj1rFXUZ0dW7Z0vWOycpSzxviYYjPoMgYQ1Hcx82qEqOANMbSDiQPSBl/tcGP3h
         5hPgccoadi0utn2uatKPsVg3mxkU8lQ+eEHf12UZebZyplsNYXPXbaLSG2zca45GOPaF
         deqRvqwjPrYPNVCRbGL29ff8uj1m9HVilvHh6w1kWfP1MfI5NiKXgyOkCbiMmxLsVFQo
         Bo9JttqlJd56YTBC2wWjPgSQdcu1KR9lqfl3bOpiuSThFTFNv9XXt+5IXBlZVSFuEp7o
         ynhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051095; x=1774655895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6s9pHoVDlxdr5dwqD1zPuBxWr/GGAbw8Sd1DAvPnNc=;
        b=sbNb1loY/KRxn3UyUigV0iLcmg70L0FQCABQykfsQDXKV8dB6jU6G99Dc2MqDIMfTE
         47v54vAOuKzbVCNUVxhiQrKrgwBrG02XodcDPm5tlAHnNKqG9pq9YlxxGkEYj0UrOZar
         gsE8Asck8f8aqgO5NjNSsYKjQu6wAJ3VPXeJcW7ZyVgbntcEa5AYCf+wneRflVcC1ueF
         ttwyGwRzH8oLpBsVKUxlGdSwv6/EEQURPbKYo24t7sdN7nog1X7sGvmPwoKGU4t1YqSO
         hscIYRon9jUFgNvqNOJ6Y84KcpoXESgaESZ7p2S50X+p0xoQJ6n+H5DMPLIyUY6QLyWM
         teYg==
X-Gm-Message-State: AOJu0YyFnlfT0TEaqzopn6RsEf6u64EFYgSAH5mlm1T9RwQq/nKqMXiW
	svYpnW1HS/FC75aOK83iBalBr3WrAzY2+sdr/TTskm+NfB5AM70I3LKicrQrVUNmtEB0pjG2aNN
	Sogaisr0+bbGVSaABviXvMJ/6rwFVKYdXgh05TCqHB6q4wZvDelkBQZghTOD+osqhLY9DwTK51U
	LbpsuAzK3mdODE4hAjS4LyTZs1STf2RSsKIz4j3f5NX8zTJEo=
X-Gm-Gg: ATEYQzymJflRABrHG1zBbMJHrCUNzT9wlZoBDoXaSf1PSDjlKgHFeDhodybojF436J5
	MAs5YvTq1h2hcNOvCSYTHkVvwUKPdW/Ek+JnJdPTFuL1p3dWLO+c10syij4/SE9jcISJylNNvxk
	PqOZPyZsGIRvCXaAny8npwNP6wbHAzSAoM6TUUY91Q40MBdJwe3UWA0zLXZfeaZVPpD9bkzZe7u
	PXfSSkVMw1KtZW4/uDldIbJqbXdhkeFzLb154Z5+Ns0D5JbDF/VQ3cRnBACXa1llnm+HuZMYxKw
	dEf1Sf8/11iP/bHsrz+3XUjZWHC9o57yr9DcoKIKlekcBn5XuyU89/dBzuN03robi4PYAKJrT8D
	lmCaADIdqS96R/5U9UAEwjcMTu2OZ2oo5gMvDJhI52RIGYVts7DTQ5O/5Buwa1SGABSdau1pJue
	56IJNpYzvCa+Mgu6o+vTDdsKZeQ+rncWahRNw2k5dFUZBR4lAO9EIhx92g0M+GMXwENRdFBQ29h
	NEYJqISYPQ5dg==
X-Received: by 2002:a05:600c:1c0a:b0:483:7783:537b with SMTP id 5b1f17b1804b1-486fee29560mr68302205e9.24.1774051095463;
        Fri, 20 Mar 2026 16:58:15 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm28704635e9.7.2026.03.20.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:58:14 -0700 (PDT)
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
Subject: [PATCH v9 2/6] net/mlx5e: add TLS 1.3 hardware offload support
Date: Fri, 20 Mar 2026 17:57:02 -0600
Message-Id: <20260320235706.636531-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260320235706.636531-1-rjethwani@purestorage.com>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: D55052E26CC
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


