Return-Path: <netdev+bounces-306372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kKMYBNYMUGpisgIAu9opvQ
	(envelope-from <netdev+bounces-306372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDE735B87
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:04:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=O76Lo1Ae;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306372-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306372-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953A930667EF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE23E0098;
	Thu,  9 Jul 2026 20:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D33E0C4A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630472; cv=none; b=dBzFsxUPVctIi8COCzK2inxpi1l7RQrSnzSG/038ZeB0Hv+qLl6DfjetpZN/WimbB3V8aUmsoE7mGUMjcbhMhYF1+6wKPhahG9dbZrzFgadCBRyIAS/SOODdhZRh98oMKC3LQDlzneWcBpPrDw3q2RwK0P4Qf0e0+FCxZgyFiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630472; c=relaxed/simple;
	bh=yAjBdtzSxZzqazK4I4MclvRDi3Z09oilBmO66u8JyE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUCnptHfZQ9rF/ZxXQOjRWVI0d7femesNf4cVyAyw/7BTNwJPfE+TumV2S4jMjzSImRxsk1g/du1/hT5TzXuRi+M0IWSeEyttjQSJyXjDtRkSuB9bkELORfHZ7iNf73oFrFs2KWmlMCZQ9w+LweNUR/ad7rMqTdVmIgUPaKgZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O76Lo1Ae; arc=none smtp.client-ip=209.85.160.47
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44cf70de986so91246fac.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630469; x=1784235269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4EweZDFw2PX/IG413UeHfw+AVFQCjkdSWjHShCzuwY=;
        b=O76Lo1AejIzn1ssAcDcbzn6z77wtby6AoQp92hhC/MlQ35QTNZ6/kQZJfj+SgEi3JB
         Oeu3rEMVhmYeZYrfdgzhp4naRyxF/zDyVqEjURbSfea1/POORsPt7teozGlCYvicqq8h
         92i6I+SH2+0fbCS83eA1TxS7jrA52sCLN5cNK4BwCMzKnxQHHF8bW8S4d9Xk7GBDWAYQ
         f23wpW6C+7CZ/2UkGwSiwewl/B1UO9U4wzP4tGd8EOa6VDJ42YOCeS+9POyOG+ljn5vm
         rubiWVOmQhMgX7RXa0VLwA/cyo1GdojWf0vZIoE0grGiMmmGYfRfaovcqDuNSRAo0eO9
         bHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630469; x=1784235269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4EweZDFw2PX/IG413UeHfw+AVFQCjkdSWjHShCzuwY=;
        b=tSRTbJeuCKu0aoRp2TuLRywkZw1RNPiij3AMuzRwHtn5SMrOc66IEa6f0ymZzdO0KY
         cHsutXhWPqHO/3ATcvG5+ZwgiA3mhLjU95w7Eg69EbCAVDQ0dPory7jsp+vX8FqOsmAU
         lJJp8TPLPLo8BzcpVZOuo/T3uq2tyliEm2RUXEkBoM+4IHchEY/lX4EJ3lEW1n7ZLcv4
         XP2Bz8u7rYIGiZvusydZHj8txGWrh4OAPCaFBJ8DTL9AGJzpeEyFNOiW+84l9dNlkc7h
         WlVG/Pro28SRo8ysQHhIVmJdffjqMVchB2hu4nGMAbZl+sJ7mc2pHBZ+pRQ4NrJlFYWd
         Zf0Q==
X-Gm-Message-State: AOJu0YyujQYPWoaSCg9TRqpms0QpihLQ6YFwMI9gLXpeenz9+aP1xj94
	8YD56FwIdQZe+VT4Ivlt42CsZXe6lhOhbaOSl1gdi9fT6IUuL1w52QOUQcHVENqUUvdK2OvAm13
	sTJmkahwv72OOob5G3ozvMAxL4lRg1dBdt54hvl/eEG2HortI6bcT1h8r+7H2QReohoGafiine7
	JpfYUcVdYRuqBhtpATPZXAvV54/MUbjhc4rNr0eLG5toMaodM=
X-Gm-Gg: AfdE7cnKjiVqFTXvUfkMyMqCrTh5nhcyKth3/dmzd8kTG1uXP7IHGZ3lJT+aEVJQL3d
	UKrR1SizoMrQ6pHus8s5TExHNSZVWkKx8E3wMIBzcf42xmL0WzT6Q7klJ7SvM5xtmoB54fWD+lj
	q7HSICsvYjzniflJbIRenduSLS3SkT3+csfCjDLRMiEW4lMpehay4dQC7PkzMdpjk7zk0Lj1jIr
	CwAbdqO7A3W4AOOs6uSqeYxkHx8XPbA2cpN4g4KxU8BFDy30LTFm1yrM8F3bJHosRx50huGdpI5
	hjDTlcmRSh/mYHKLsG3/RXQfalBAOubPM4QEqNsleeHSqFqIPpSduwN2RJVcv6BcTBZQuHClmDb
	ExxJCBJtStckgFDS4nj1lxayuJawM6Kuq1V1k/QDyoHX/GrX7G/0Ojte9J8ETFYSp/t9NFbrcyQ
	9PZiCQhLmpqYvo0IQjaBMhXLt4L9Nr3h4y13ngE/uqm72SSPfR12xBYFE28N0h6skRCm+Vo3PbY
	n4D7Olln8m767EricKWWbuiive0jLFnuUebNVrMFqE2fb/sh7TQBcBxoLp9b1fMn97ahnF71fnD
	n1E8D0XeKgTyF+UrhfTeC+H/2OFRJYvGeF8=
X-Received: by 2002:a05:6870:8088:b0:447:9474:df1c with SMTP id 586e51a60fabf-4516387437bmr6281498fac.14.1783630469194;
        Thu, 09 Jul 2026 13:54:29 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:28 -0700 (PDT)
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
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v15 2/9] net/mlx5e: add TLS 1.3 hardware offload support
Date: Thu,  9 Jul 2026 14:53:18 -0600
Message-Id: <20260709205325.1591196-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709205325.1591196-1-rjethwani@purestorage.com>
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:andrew.gospodarek@broadcom.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61EDE735B87

Enable TLS 1.3 TX/RX hardware offload on ConnectX-6 Dx and newer
crypto-enabled adapters.
Key changes:
- Add TLS 1.3 capability checking and version validation
- Use MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3) for crypto context
- Handle TLS 1.3 IV format: full 12-byte IV copied to gcm_iv +
  implicit_iv (vs TLS 1.2's 4-byte salt only)

Tested with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
Tested-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
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


