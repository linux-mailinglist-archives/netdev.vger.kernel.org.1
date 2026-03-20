Return-Path: <netdev+bounces-270116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCnmIY7fvWk1DAMAu9opvQ
	(envelope-from <netdev+bounces-270116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A382E26C3
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8780F306A3B2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A01396D1B;
	Fri, 20 Mar 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YyGhpYSf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A13876B8
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051106; cv=none; b=ZuJziGI8wGhqTY8lsfIFLMqCVJiy08T423TupXNcF92k5xyg3L3uiV9vp3fE7jTZPG3/EFdDf/XjXWxDg4o8dAv6TcvHKsEuvWoDgUtSYWOQ71lXQ3W8c+hYMycIeKpMRrZbiY3W0r4kBWyTZmIR+L66W5TyB2PqnLQ+Xki23GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051106; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9pgLwdP3ZICyZa+Jf4r8DoA2dtE/bpuXmroFanxV4ws6Vt+lC6BnxjQ9YGuApM4Zpx3sRnuGoxDP3Yrznc/1bnbjvt3sLlQNs7XJX+U6w3/Nq+k8FrBD813fKs7UF2OLw0OpBWT4WAEVAl+VKdDDS5XSnZjSm7o+/Ibv56Fw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YyGhpYSf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so6254495e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774051089; x=1774655889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=YyGhpYSfWrEK0QJPehA8zE/6mFHDaPvmdQ9jhib+OeMPt6F1I59SLSYEIvK5TafmyI
         FivZTaWLGpXHZRiYu+jU1WKqkzTvGR1SJk1rY4Y27M1HVH6Vt6wD9G+Uu/Ch9ZyoiVnx
         +hqth5To/9RsglEODB7zqvk8swhpwijUpC9IunH8hKYCXIahcwePB9gSLZGMgVyyek+i
         /yWmwNAFEV/7BT8mn67tfnWGT9fxA+tOu8t7ha36y5eKEY7nf+kW6sLvWcSp+yf+VFqL
         gvFk5AuiSbHV+GYwf+e1iWODr51xqAnAknvcEzw7Z6wCnSdMD1tpGzQ5uHPudkjGNX6X
         91jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051089; x=1774655889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=DMRmCh0rFHI4JzdCXNX6g4L005MbUS69mDlfWSfdyZlfePwZSmV+ZURTRFjsOS4zGe
         i3CHmx3ykJxLWzNeCMt+AISkA/onkG/rb4IGt2LeX7/as9sLttVS3u7Zv4j1zddtaXHB
         h9a2ulUd3x1PCx5WTZxoIQsuJzEIJyOTpKpnXdEP0Lx5T3V/fE+jgtl1lj19U6j5q9wr
         8dFvuJyFCBEkkz3DENfpHOhmxqT3pbETIiklWxD5TBO6OP44hjG3lbVtyJPPijoH1m1q
         acscu9zpUMgJ8m89FOC/PA+gu5HhxkncaUQQ1ayYJu20f2PwOUx1Ov8VO434rzfNStwG
         /T1Q==
X-Gm-Message-State: AOJu0YzDfQVy9WiYOospuyXhnzcGPMIyvm9VFeFpco3Sh01+MWmyZbQn
	9jeczO+giMk8NAsqIyiHlfKHPhM/W9ToE0AB/hqfo9Nev5dhhebEGHlE9MqIZ0gd5SVIIFwVV7t
	UVnxhBK1HwtiFqjIgJV1NHD9pA+FlFyo5iJmxm5g8oVh/xROhAAI2afwtu4pYD8NhfRSqBRkTTZ
	ctBHPacRmtlzwaA42Yh8sICZmLgdur4BIEC9PfiGIkMbSm7+o=
X-Gm-Gg: ATEYQzyfhOSl/5RjZJnuefLF1gcPOTjqESjWwlpJknLKGb5MvM0KltmaJWavOgpjRtw
	C8fsmvEP0Moo30+o9blWLRhjMlQhUQkLmNs65mBHbwJSEYmsofqsBx0mS9ROlmTG69Q5jNlsS2w
	ciM8blM/wNilOw0ZhEvhzf2MSFmc98h4N6/YnagR1nOVEa/TTjik8cTGmb+VfphmZg2X55cfM0k
	aw6cAWJh89MlUbnWjeEcJ71SVDEoFGvLYiPEWkBCZvMryf8cU2LmUtphXwUeDd/bMjjmT7nsZjK
	bjz8jFcT4kh+jog8uZW6yBIltIp0DpuQci4RzpweDlDBnPeTI3kRSfMtjiocJ4jyeBsj/RYxuit
	f5Or/RoTmOMZ0Uc9Ex8MCPFOLXPeGFWec4sOoYsM3XXOm2D0u1O0yMeRb5OY8F+pvCuH4avGbB+
	WwZP1bEHhp07tJ8WckW3tHyvtnlkk/Z5IomXCFDoyEY6m3gBUyvHqh2UksTS7kxwxgNSa0KT1i4
	qs=
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-486febbc648mr67294465e9.1.1774051089195;
        Fri, 20 Mar 2026 16:58:09 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm28704635e9.7.2026.03.20.16.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:58:08 -0700 (PDT)
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
Subject: [PATCH v9 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Fri, 20 Mar 2026 17:57:01 -0600
Message-Id: <20260320235706.636531-2-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270116-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05A382E26C3
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


