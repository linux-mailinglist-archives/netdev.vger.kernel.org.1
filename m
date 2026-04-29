Return-Path: <netdev+bounces-282461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHD5LftJ8mnOpQEAu9opvQ
	(envelope-from <netdev+bounces-282461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:12:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE5498D1C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 562D3303BB1C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAB41323B;
	Wed, 29 Apr 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HMl4ZU1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60F37E2FD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486308; cv=none; b=u32HG84tX9cB0Qg/3TIeQxak9aY/BafxJMd6T2zJy0+fO2MiY+bePFxQ4Qq2q4NAf4M2UL32q85enlFMLtOdDxK1Sz5KGB0Cf7/J4UMIgn16TfY+VmE6qiKQcIQGxYQXoiuYnto4V2tOFqEDXBe4mPR01OxYfHadlphrNkIg3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486308; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqpUBwSwvanttucyvWCZc0jXdpXfcw0RzxUBhyk5KiPsO9QC1JNMstplmrLSQWWxtEA6lZye1u26pLMuBV2chVlXyFr1ECj7FKQjwGKpgkAYqpxBEovA3ejL3Cpv7wRq5B/R4U3bk1i6hmAykD3HY5vAxKlS6fGymaCXXE0Qm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HMl4ZU1C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso484515e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486305; x=1778091105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=HMl4ZU1C6QieCyVMm5OmdT528f5AP/Wm1MsxIqVDABAl7CZf7ITX9Zt9rVFX/x7rkn
         BXKqvAhSyzsbfUvkoqHqQelvzc07rgDsLgk1qAFbNxLUxCKFXS9isUMqdVwMgx+ICHTU
         GVNws9XlDanRbdIzJa1nM+gh/TDA3ziNgck9J6hGawTaJ/kk/8hVAvV/sBlR4BWqsI54
         e4vlDyF7GoKk69uKq/3zbMycNHciL/PoM6yFkVbQHcIH2uqr9zv6b1NvdkGlXcP2Tiv/
         wRtw/JdxUFAFaS/Df9zfr0N82iRhDX4YCmywHnJ7NxwcAuky7KTxhzHLqZoXg4yB6UOG
         PETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486305; x=1778091105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=F8fKTPq1Y0ACJlGnfivvEfQZU/n+5USHqIQ38ikJvlvVwvqkdAKRj+/1KsdeM72yAb
         +cs4Rv0Z3S99irn7a4cpawxuxjGTnOeOAp/jRxw4NNCgsOhIIyBsEgL9i6cbGYE7/lNq
         Qs5pVuo2fVlkntPxWGSXtUyn/M47uaJRPk+m14GHyBcSX3xT7bovKiePV11++HIDe/Ee
         GKSSIxojNLWPn5f0rs7gLN9szYWS4Y83fW+zrDuJoSgtE2AfH+tS1IV2qwz91wQWVtNh
         /6JVhmMxj69/JC50iKzAAh/rGpbMNA3pSkTX1JUIYYfjKnfsJvoZXb9v8LlR/PZcpCvx
         KK5Q==
X-Gm-Message-State: AOJu0Yzd5NwELyDEbBeIW6I80OoSngZC+CtD1FYgHJXghCmmrTthet+7
	+PIVh9Vs+ca7P6ZsrVDyLX9FUsAWEs4AxiM8GX1lo+P+EqQhHO/Lq2Xq932cCiX9Av/O0LBRHIG
	AhjTVWO+FEhGdnvbYg1CZV0pM+4Isxz5PoN2iGpyjY6pxPMoIqwx2/F2m53BSZrjlH3Ale0gBNF
	Zfpt0vXC+gx8ObL5ZIWyBNAkBurYEffGXDu6OaSwLrROSHoAI=
X-Gm-Gg: AeBDietwogDAMTijvixr17bJCzcYnigQ7T/fy6rr5WII25XEaDIXDBwWqaaeJETBJBn
	YOvuDZvXwjfK6dmAHT9doIiE8c6QmGsNJIb171/bx44LKPyUoFVwXdhrI4jx8FGb8TPaEsg75od
	aHHr9wU95vs4dAOVM67YwWLZle8PRMFoYGfStPygjS3kjxVV0mCpLsCnbiE5egtUpplb0cdxTnl
	GcKcxSN0V08nONULgZdTKQ/c05dyPI4kNDz9h/9b6RDYkYSZRBT850h9eHerQycu5s+kpXV1uyR
	oSLE6M3/4/QngwlBRrHxEtRkT9oiDzaDvTQLueDOKPQfM909/Vwcw3v27fd1fEFm+UQp3Q+gLMK
	HyIoXBy0vnbtQH520oETExxSY7qF/2YKjp/fvuaLnwdvhxBVWP7KQH07vyntqZlrraHJ98apeU1
	XQp7oTgG42bdmNVf7AJNuMoH3ngkwEr04wwDUBnGeA5aqlOvHXF9GNQeCmlq1oJ2NsIUY=
X-Received: by 2002:a05:600c:5247:b0:489:e696:836f with SMTP id 5b1f17b1804b1-48a7b519485mr83371085e9.10.1777486305014;
        Wed, 29 Apr 2026 11:11:45 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:11:44 -0700 (PDT)
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
Subject: [PATCH v13 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Wed, 29 Apr 2026 12:10:11 -0600
Message-Id: <20260429181016.3164935-2-rjethwani@purestorage.com>
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
X-Rspamd-Queue-Id: 42EE5498D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282461-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]

These drivers only support TLS 1.2. Return early when TLS 1.3
is requested to prevent unsupported hardware offload attempts.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 +++
 drivers/net/ethernet/netronome/nfp/crypto/tls.c                | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index f5acd4be1e69..29e108ce6764 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -431,6 +431,9 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	atomic64_inc(&port_stats->ktls_tx_connection_open);
 	u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		goto out;
+
 	if (direction == TLS_OFFLOAD_CTX_DIR_RX) {
 		pr_err("not expecting for RX direction\n");
 		goto out;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index 9983d7aa2b9c..13864c6a55dc 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -287,6 +287,9 @@ nfp_net_tls_add(struct net_device *netdev, struct sock *sk,
 	BUILD_BUG_ON(offsetof(struct nfp_net_tls_offload_ctx, rx_end) >
 		     TLS_DRIVER_STATE_SIZE_RX);
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		return -EOPNOTSUPP;
+
 	if (!nfp_net_cipher_supported(nn, crypto_info->cipher_type, direction))
 		return -EOPNOTSUPP;
 
-- 
2.25.1


