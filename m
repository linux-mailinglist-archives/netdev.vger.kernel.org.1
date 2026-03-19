Return-Path: <netdev+bounces-269667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNU/FWlsvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:36:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE202D2BAF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 629483018684
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43D3D6CB7;
	Thu, 19 Mar 2026 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WE/6VTDS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30D3AB299
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956199; cv=none; b=ntEHZCwUz3v9zLdgyoYmcPThD7y/N9GbVlLDKj0sicdVw5I58XFg1cb/CeElE0XdWxKXCRGjqlUFKzuE+/fw6Tjmczp76fCqWg3s7roP7zLnrmIq5Z6L7XIqJUXa040zwLxStDaJATIRGrOs54EbhPAzcl4sqhhMB/s3qjn99RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956199; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEKBva4b0neUNXaxQXrTqR5yFA/75pfg/UuZpe3dPi7tnb4J8wh2Nt34vyB8udZigdclsC8MOj3b5fVboia5q/vc15QWwUIpDWZJ4s2X52kUXx3Wp70ffOE6tMKGz2G6qaD6/TWmiHx4SLNl866YiR0dol2fiHLzjv6Al123wYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WE/6VTDS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b4121c40aso930980f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773956196; x=1774560996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=WE/6VTDSEmGi4DRvEpqVUMyVVZRRFYMvtSHyOLA+UTAMx0AmBnPIYOWx8xhi+9ousU
         DYjnkkdDZinY+n0LbPNWx62GDf1FJA1dERCmYXR5xruuRfA4Sn/6E1habnm8Ar1nr+KB
         ZC6/+xfqBBkcGYDlVHhFW2MGdwsTm5QcRMEhh/OS4qnOhva+8jw2LX+Ipwe2pfBYg8Zc
         cY7kPquGALd16K0ZtLsTTIfau15F+QHv/0TPmty3ElA8Pd9zz4UOUdhOL/FgeO8lS6QW
         okPq3f2nIlDr5OplF15L8WbS0Ru7jWkmgR5C7iq5QfMVoMPTfba1rZGx9DdFdA1uKJTF
         T3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956196; x=1774560996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=jyck/r6PhkumzPopsU2iXuLrReRwfxHOzCi9V2ODukkWA7GXOWPPouVUfzysfYJ1ZU
         CyRJsZm9i5S+a1ydCHOTJwjmwvFLoIFhmG08sUIcKffDfrX/omoNfVNNYTe/7SLkMs1l
         flUtBfR7KKkj5p4C0jqJJ6ucH/SmxtTlxSMYf2ILSt56xIwG4odulC+WPpZeinpBXG78
         lD5Gu5i+QfKip9VFqfIvfFmzMABvldMJH4rdCj0hQxwtmuhNCDoXiPC8ObsmuD0pOb4I
         aIa4E/LAAZhS9hRK9bF5c92Id18tW9mRClaub7Uwcbe5eKvAK30fTN9lLTjlvXUQeDn0
         JAFQ==
X-Gm-Message-State: AOJu0YwWfoJra7lF0VFFHx/FN99WKvZtFHx7L3xTmxM9MeQ4+4tNKq5x
	iyniFPsAem73liWZGjhqLXAQT/4rUeAXYcmTYYKcmUQPueF9bC+r8NIGSwjcAyR6O4tC3zB7t53
	ufTOTKFRqBQhoOMjXbaZSXTXyhEohDgv5syRsdSJQJWf4OLmmNtYLD7L0YD2o8+R7B9O6o4IIcQ
	nYfEhKM+BQMt1FgKZIjk5rzVfDQXqY0Pen+6vf0nkpBvz7Ivs=
X-Gm-Gg: ATEYQzytDHi9NfD8DDMWzaLm6d48RrShLasPeNQlWifTH2XG+UmHVOPKX/scCfPozTT
	JZNNLNeY4r1ST9jbH+kdM/lBdswIb1BcCc7JmrZ7m+kE55rE/RUyf4n1l/zVyo90nG+B/NlSRwU
	oUBRc4ZP41s95woJbMBe82vTJslvtNmOTfm7WkZ5O69SM0gH29LXACmhds5QDQVRcaWvWy/X/qj
	S/8PbqxU1mFi7uIKQFkraGq5Wigp60L7mAXGbyGlTXyeGEnK8x9cmbybQS5NphWxAWx93fpS5GE
	s6kg183feGR5pZgrlj6/+rm+VdJOQiwpbvvNHowXNUdd3bv8m+GIWslvjvmb6sQYqE6XGm3jA0O
	tW+5qjAO4eyeCR408WN+c4FcEJ2rt7Ew0mhohN7b8lv4BON4+zBFeOhiCu5vUr12E+2BEvie6qo
	RUyO5eO0ax6zW2GFQ6KhM1E2aZNvHW4TZVce0GMZDbBkISyDb7IAT5S6IrgZFYm1VM3BbsOWWvf
	HY=
X-Received: by 2002:a05:6000:1786:b0:439:afea:aff2 with SMTP id ffacd0b85a97d-43b6425304emr1500198f8f.23.1773956195469;
        Thu, 19 Mar 2026 14:36:35 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm1190659f8f.4.2026.03.19.14.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:36:35 -0700 (PDT)
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
Subject: [PATCH v8 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Thu, 19 Mar 2026 15:33:18 -0600
Message-Id: <20260319213323.235559-2-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269667-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.941];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FE202D2BAF
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


