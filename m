Return-Path: <netdev+bounces-306371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cipoCdEMUGphsgIAu9opvQ
	(envelope-from <netdev+bounces-306371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:04:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF1735B83
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:04:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b="TwPD3/7n";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306371-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306371-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8FDE304971D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC33D3337;
	Thu,  9 Jul 2026 20:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9F3B6C11
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630469; cv=none; b=EIf6+2YpXkvSZHPycD4BnUqM8F0eeF6n5RYLBmkCRVfJh2bjQLN003iYIEayl5g8gUwCJdwILkyi5V0+qUsonoQwgUlWhrgYe3gynhsp0cMpcxy3fGV7uBbpm8zb3JKzV4Pumai5NCH4V917zizW09370/KnVbtcQZgDj/YzucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630469; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aijQvGyqHQ2K2/yfHsOj11463iLlsNxOAvL3kT8ldhrL85P3CksTQRDFgpR50RPV5mDCUH8pNdf/LwhWRhQ6W9twDhGQzvDLqu7wk1iap0E2GhzH1eCUlS5Pm8x6RYo1eOBZLVxV2YJAGzAicuQi1VX8vox2hu2CA7QCcmHZ9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TwPD3/7n; arc=none smtp.client-ip=209.85.160.44
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so90087fac.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630466; x=1784235266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=TwPD3/7nfhZ/nQClOdqR6SW6C0cE4uSXc4tUsT5BktKU4ajqLEL/g33cyBee8W/PtJ
         Ze23dseWRexxcKqLa5zq1vPo383bSiLuTvQ+z+gs98Z0WP6Xh8UeSsri1plP+Q8I6INg
         NbHFYHm3h85SwigWpg456U9cV8sLEAr1I9mN/fHaDz+2c6fpeytYSUA95JukwahhdPvU
         VJEvI8zsvHpixhCHArdpcqWG3Is6W/rtECcDxDzLsnX90k782EV2mjnVUc4DVo8/WyYz
         SQslsdux6QRFaTg9hSmXdtgSpyhJM5RnLGOGbpC40bpzNO2R1uSgqQ7umJgwYRMzZcbY
         HN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630466; x=1784235266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=g76wJ6a3JL/Ow5UCNlC59YBCfU2nwUy7MmrR+rhyAeqFEoaiwO4+xWZmVJ0/lYV2tQ
         7IQlIAIGvPDqWN8vSX4HAskq4zNbP/OWOhbwXL5Avp5j4an+j6qtfI1nXr0yWQ0GbiUa
         uHGmtxdB2QGlGufwv6Ywg5ww4sG+xwQgjqlrjDx2ULRljq4HxvpAvkHfL202DLkPIR3h
         m++ClMhAhA0Kia7Jo/vF5f1HXHz48BxCkp3663aXVlqjxLVG5CLB8WhJyQkt8r4ywyIu
         1T6ZJh0DC3tM8oT/rQZOM+EmSRiTnKE7bKJCHllePYZU9kHrhjcwNor4wcSEXuXTPcyO
         Fhcg==
X-Gm-Message-State: AOJu0Yz8O5KlvdOU+Z/MwPAUBjNkBFLD03whbJOp53wOVS94FahDVjvw
	FgonCd2yPkZKh6ZhWogFuMVLl7VSWcOgNV6bLaoeWqLqvRKn6YkZC2MXfHImCj8GF4TdWV3cKAr
	WBc9o4rTsthgEcs71RC2uheU/l0DCZ+FyHkyja04JTL1vwRQ5/Jkx69KwmhRac+P7lBA21sit+q
	+lKXaIvzjD1qzZlyUQLajImtFi6UWoVb8y4s30BqiHDnpl2vE=
X-Gm-Gg: AfdE7cmYrTldIjugHlF1Uxn4goLKD4bItfzsI4xNDmQXAEU8QUi0Uk9JKcWxJq6mfM/
	DYjlRGsUZV/t+5vLfAw9f3t21NcnwDlD7v2vVx3f8LS6EXcbPm8c1527KiRQOBaDWL4fYzSuVIi
	gX+pToy0jMMuiR4NKReammTxg3IbAyOEiu2uGnnA8AdxQ/y+ezeonHwO6HLe//i+cCz2XBQ2ibM
	m174PPysSkaNVHGScYG+Bn7T4lZQ9GU1WufDKboexpgx/mBSvusCFrELmA/VBPc00x0CDqw7uuz
	BQtwcVeI+kIL4wfPUWKJvr+H/imI9M95j/rG6xGVYwTbrxYb+sROgv357qw18ppPghSzVmYznRd
	4hsqVn36ZNqtTIoaLnoHxqu34RwoInYRrmhdSKBh8tzaKePIKVxFLrqApfs9ldhH4yGUswKLVDA
	8I+hRxsSQKciwEy8hqVArNyngv3NfSc7BckZPI0v3bVjAQxKGjtKhAmVezEGLNU3Gaz6K67x7bo
	wxr0RXDg7e100mU7mQ5brUGMxD4p0Q1GSG68jBR7f6Zh1DV7utw9NDwqNN051t6qpvArFXPgdjL
	dOiQNgiTbjowva87GPsTMiT3826Hew9iRiU=
X-Received: by 2002:a05:6871:7414:b0:447:48b6:83c6 with SMTP id 586e51a60fabf-45163a9a71dmr6465057fac.24.1783630466241;
        Thu, 09 Jul 2026 13:54:26 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:25 -0700 (PDT)
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
Subject: [PATCH v15 1/9] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Thu,  9 Jul 2026 14:53:17 -0600
Message-Id: <20260709205325.1591196-2-rjethwani@purestorage.com>
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
	TAGGED_FROM(0.00)[bounces-306371-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57BF1735B83

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


