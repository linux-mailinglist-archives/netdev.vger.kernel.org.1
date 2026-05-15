Return-Path: <netdev+bounces-288458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG35I4eRB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5155831B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30CB3044A41
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9A405C3D;
	Fri, 15 May 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aeXtF/NP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC33405C50
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880526; cv=none; b=ryJQ4HctZVYE3jKBcCLGgcuZlw1BSslQ+eCOTtk24z50X0dyGI7Y/2VP9oW0ZwWjpzzpb6VgTGZEdevsGiJDmL73uN3eSmmBIDfZWNtlhw8wYkKLvEl851OUfps+JClsVwbKuMmZohQS9w7m/F+wzzjt/xvPuVVgbyIGTgnJ5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880526; c=relaxed/simple;
	bh=t2q54dSmGg/P9XU/0IB+SlhWx+nOeGh1AY4CpjdTCuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZPZHhavwPFad0JR3pKkggCgNcPSOgzG9iEG/0DjNMNTGqJZWYgVFWQs8MIcyjbhVe9u0mwyQHR0tWuR//wB8a9Hc3FuF/ZEHsI6qUkD8T7AKbYC2w3BSTqb6k5KOeunInhgNdOBe0QWDlNWxXEzSTnvUEltsNcdXm23wB22udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aeXtF/NP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4e6c5a30so466189a34.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880524; x=1779485324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=aeXtF/NPItC0huK1iQgSuOr/VOAkGih9uLitrLpw9N+leT8oTSKTuteyn+VYrV1kBn
         wqiw0IcqrPd8YOcvzFi2ZDgdSoXxCcxVZZbbFYwo8+gBdWmES98AV4occeO93musLq/a
         V0lhcI0ZookcPQB/NJnQvqPjpRPwYPRifBj4PO+f4sdjvVeNGM9RBWrptj/piSlbr4m6
         edlf4MPVfweJLdcZHP0q/nFbhAiUc7S1J5Ap2TAZujMab51rOOrY55xeK92oaryuBp2O
         fnBDX/+hM5na7ohUMA6b+gaFuW2hEwq/wXPpmN/zYr4nejwsVmQ15s3QXp04RtA5Hhdb
         RJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880524; x=1779485324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUYswyn48cyLyzm2NTizcwnGHwsK5SZG4hQrEOA7tkU=;
        b=h11yr3Wn2gMAHN10JG0q9L5x7Z8WPCop6K+vu7RgvPKQkhQzlOaknmnh6kWT38G+4s
         f+JheTcoE7jyEou1E4ZCP9tYQDlRdcOwtqN8s4ZNT0cu7XP/jUWswQY9MG75hS3PHd+X
         W2D5Rx8UOXzrjdoL04cCQgHIjVhBzd9U3Ghy+elFjjPmcQwoFKb4+010RTnoY57ueSyA
         PwnD6FQGN5FbIcMEQ+8fAzuc0BF79EFdLvP4NK7ous85sxGT9giMfpx+v99PzVzg43e5
         CE50X8UZoc7s8rA2sJjMBc4SO3NUJdBsKwUi8phHNNgj0Hzpkp5qJV1ADiQFCZfMZoeP
         2NMA==
X-Gm-Message-State: AOJu0YzERl3AWtX0BGCwGsqQ7o4gpfWV9tRF94yN/6ofeqCqSBInxiM0
	y3fwfdoANbMIku+2KpKU2r08FvcRNvvb+Qs/B9PTDAB3DQgDPLnPimjc9nr55suZjVeywQOAio8
	/6N5qQSv0l9C5DSXhmFIE9jvHJL6Sk+ZiIkaf1S95cyo6UtwKxrHV6Oi3PDo7zT+Gg3M5wCelML
	gcHltiwTXM219k4tRhbMrW+KF7ahJU3kqiuHI5BGB/CCLSb4I=
X-Gm-Gg: Acq92OFCP7FcZSRFX0P2ixRrFrv8vqUJzCRX2Gaz4CXPtmL9QGS5kHAjYvPUz6navih
	hc/diInQurohVDkZBpyt9v6C56fG+D5fFRdiQ5Tc6T8ay+f65Q1y+8JGctV9iVCplJwnMiylWLR
	Pv7Mo9apfscNfMd4DH2rQfsT0qQx45kR/7LgPOo8xMU+bytfUoJmPU82HGeeHz+DSpxyHrNxL8u
	OP6Ez+cSy1BME2g3b4ljhFtdR558b/jwvptWiWxDexfwHCiQ16c8CcXUemWsKKAnGZTU817OOOn
	UDMXNr2YujvNCdu5BGSkMe/5Di4LcQMdhVyoYOB9OuREIyhI98k+ai9L7r6pRQa0gYMGL9K1Kvo
	w5p/7M9GWKInRRmvmB3/BQ5/Wf21qNgJYIy1RG1xNLwLL5afTmBUuISnDiCLyKSmDoE0IIJT3FK
	4VyUFp/L7bNdK7+2s0PKa3wonG0zvpeQ5ue8vnc1E8+MBwoxh0GIvtOAafRA==
X-Received: by 2002:a05:6820:1986:b0:69b:5696:e69d with SMTP id 006d021491bc7-69c9bfc7b32mr3797727eaf.58.1778880524218;
        Fri, 15 May 2026 14:28:44 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:28:43 -0700 (PDT)
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
Subject: [PATCH v14 2/9] net/mlx5e: add TLS 1.3 hardware offload support
Date: Fri, 15 May 2026 15:27:08 -0600
Message-Id: <20260515212715.3151307-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4E5155831B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288458-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

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


