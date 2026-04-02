Return-Path: <netdev+bounces-274775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ3RLTgCz2mBsQYAu9opvQ
	(envelope-from <netdev+bounces-274775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:56:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E638F56C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D977030269BB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3701E3B5305;
	Thu,  2 Apr 2026 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U3jFt7xO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6237881C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174184; cv=none; b=bMFF9Vd3DDaQ/FVnCa8mPSijzFRedovCN9AIkb300h1bBzez+BZgWyl3IsaApVqiBbuap+1oLM9rsmJnXP4m1CQx1sn7GkIQdbzk1V4WDKzFZHZG1APkjJewD2M476h6bI3xLJ+iQzCG9oGjctKpXK3K7hebKHhXyWFpQ1EPq5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174184; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9Df2q3yaQQoNuxRon9flbg9R8Uei1LAJjgwhXpsGL8f5vOXg6ApEC3HadS/3HGqNMYtah4x+Fh84N7Z5wSOws5XikDPlgm/WfH7tuDxqGaj1oJ6u43KKqeLfPLEkUEteVHQDrWliCwKHuHWundyUbDARyNkdAHoP+bVktDWsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U3jFt7xO; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46a9ae3f857so476856b6e.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775174181; x=1775778981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=U3jFt7xO2ae0rIPIc6ek/ROziSbFsbMKEp6YUnikyNX4czC+8ebNzhexzLsjNvlGmG
         fIGhv9vUQxp0NFB2f1ke1asmHWb4obY1pG/AKIMuH6FmHdzpneULTnd8uy1HZd45W73U
         tkZJI28BUVhOU5sQoadHEYGdDrkirLv3QG38Ivu9XIMJjr+H3sYoXM6aCw9MCALVPD55
         PcdeiRI9HE5ySPJYT0iwLe/Zewe3agrxJYt0E9PtGMiSkRAg5x9B+NhXeLPCURGbpitQ
         fK05KuGsSurk3hcgKSnY7OKWNY9pt41IYanrv3TKWx+7gRwqFtyTWZr4uXm/p1wybFUg
         nlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775174181; x=1775778981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=r78/tBzcIltUyhUA9WM4SRQ9/wC8jpZC+rHih6f+zBitvGWERfcuuOa8HTu104LvLH
         ELGy5K3dHPqG7FE6uaVOuAG+oP20pJ2e4jzi/viDxaWrwv/11svF/A0yiHU8t4F9rRig
         EEbEnC2OiciUB+JjN2zm08TQ021kp5G4mg7KCeaZiJWa12I28ZLI+LlnqRL4nLCzopGj
         1PWoPqCy3KqceVKd5hcLNdLC9ptL9KQ1pZTP35nR4DzK5Jn5YF52cplTkks4peTr9+TM
         EOBh9BOTV3BUAxJRVHBffbMchwFjhPsqZctJSsQ8PoxzZ4MFuhcbyS8F0LvjmFXV+Eb5
         rMtg==
X-Gm-Message-State: AOJu0Yya48AbAW2x1kRZK59vVYkBukYbEKtBU5GwmXc8oFGrwi7LO3OA
	sgCYUt3QLj8qe+lYULCHgmSs+rrxf7xBZumLvUnC9hEo7QclYLoPuTFtGBEXDxJ8Ko+mEYXll2R
	lCHtgbBlT+m2I8lnx2r2csye8ab2SCfnJ+R0xVSgnlSIvdg+5liOtycYm6qmueVwNQqr4CkQqcQ
	MOgYtbAiavQQnG6srCtbe/h1XGwoHtJKiWsHNhQ4qxuVP32iU=
X-Gm-Gg: ATEYQzyeuOjMf5kxz1pTISpzRLQVyix2OlMVc5PCTffqtNafwdBS8bBQzHG+iCZv1jN
	8hcEAXvOpj4BVqQApdr75w5OPAg2qbDawC6AfBUPcEzf5gEvzACh4hUp88YTyTLYq87bOFXrgFf
	MG1gGTn9eH0Ysn2MK0rIvEbBCd7ksipEPV6iWgOTAxUT2W/M+2gZuMmvljwkcKEsgU2kc05ZmXK
	ZhBKdV6mSPdGu4WNvQFCSn3nCpHmCM7Spla8NjgJna1XiDSHtL3fw0AJpxylr0u9qbNqqxpB9bh
	OpQXCLRAUVS2kGDTjcFQSkzI9K/fJ2k9pArD1BXFaXKR8ptO0MdpmGO5JlHNNWV8qx2/XdhIQwg
	nk0hiMvsvxv6qSWotHjTO/IDrE9C7QNhazhvpaTlc6VykjP+yKzrMqZif3xdfeRTWvu5qossUWU
	RymLK6NhiwKMTF0sk8XbQZbzrXgnqe4K795tNwp8ur0Lqh5BZ6SuC9EL39snn9qjzu25LZkyhGE
	mE=
X-Received: by 2002:a05:6808:c1b8:b0:467:db23:28f with SMTP id 5614622812f47-46ef60f150bmr644389b6e.24.1775174181438;
        Thu, 02 Apr 2026 16:56:21 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-46d8f9609bfsm2394775b6e.3.2026.04.02.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:56:21 -0700 (PDT)
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
Subject: [PATCH v12 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Thu,  2 Apr 2026 17:55:06 -0600
Message-Id: <20260402235511.664801-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402235511.664801-1-rjethwani@purestorage.com>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274775-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A5E638F56C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


