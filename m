Return-Path: <netdev+bounces-288457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lQnALHiQB2oW9AIAu9opvQ
	(envelope-from <netdev+bounces-288457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D4558232
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19CB5300E2AF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A469405C3D;
	Fri, 15 May 2026 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fvv2QM9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D3405C35
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880524; cv=none; b=ZXgi2wphIJpYkz31VHepV2vtPLQCZH0CKPwyk71M/ddBCFKlNHkzwpblt+qGmI4Hu7SUFirPym+rUym4NFh3h5PK4ZMWrmM4r7q7fpknzRjDgnAo8Bq6UCb9yb3YRsY4MIiyl3uvk/p8zM3BwLV9YGvtA1dSzNX2vYbooe5N3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880524; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1ugv/6RWzMTqShfMO71f6nwDMo+MTVD2xzX7oatiN/4ieutdSGRMjjhoX0RnJaZ0X2gAMHMk9eLFVmg6Af+o5sYMiPxOiSA127cVHWF8Vha4Fl7vZ7YTVqKlWO/3T9LacR0XwiMfxx0BeY5IoFsC+Dqc/fhxacI8geMCBCsSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fvv2QM9S; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbccf6a23dso297998a34.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880521; x=1779485321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=fvv2QM9SDRWtXCG25xxgxwNr2wiRcpi+9yPWnU923YSlqSq5jIkPNfLelKjbRR2yL+
         vo8hPEMlw5Ma0phgLA24wNC5Ah6b894pIMscmmPWZybO8YfxiSl2IbK6tlyRYqttscT4
         +h2c4zFQdzILOzc5kb5nVZBBDpHY7htQL9PurR8Nckqo7Bj5wolBOyve7A5KWzgMLaNA
         zcIrnpVgef8/Cd/IxWi+MOhVenlt9GiTSUfC4pocoql246iFdMxZculcfiADOC44oJFq
         SgrVLLWMwa6Obr8B5kCxUFyHKLIryU5ABLNMF9IzVJAMbxXfIwLdJSWi66cL+Mh9mcxg
         ur4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880521; x=1779485321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=RVe5ajzHdb28foOe7Qvj4vJITCFhoku/S2hEIO73OWN4DjNHHqBybk5tphRa7FUZ8L
         Lkwtx/Z10p5vtpj4PomnZcGVCzoX2+x43gq9ZvKm+A2sCw7THz8xmJsokOO5kLgFWVAf
         T2NLsYGfcmt6abfUe5uOyDMT6RRR1CR6ZjWydtI1zvSn464HbCGnzq2sarqU5E4bgQ+0
         m+315OB0dpPye/1V/ShWx+aX5Q+ePDIequ1b1kO2ImGC2zq+51GT0wLKw6zmzy3FYD5G
         7Rv9Ct8Fv2llOvGywFdQ8xv3ctMU+vHkUuVZT83ElYYBeJZJxZ0Rz60cjYT1rgBW6h+Q
         vtyw==
X-Gm-Message-State: AOJu0YwYTwigdZNiPzzg6KnRq/QgHd0XD5mbjG5zikNjcX7iEbFfwgyo
	P8+VcRBgN4lV9rxduOyMEYHB2G92RXM8ZkAXBD1wrllmsdSHRNOB8gejQyyUBaWg61hy+3w9fav
	1lUYKtvzVohT9SckcNAgyk7YpEMYozuh1IUeP68sO3n+6N2E6nzaiO/2KEO3ak4OuMPUQMWe5UV
	SKkO96gxHDmcBu/u45xKqPTAHubscHIC7Kg8EJzui8Ql28Gqc=
X-Gm-Gg: Acq92OFBEndrieI9s9nrssnlsRgyRPQe/VCMXzDPF4c9jUauCGW/I37Ck8b1+STp3aj
	DNAtTmwKjh1Yh3x/UX3XkLda39fOGcgvQh4++ECR2pafuRQ0YrdM0oxcMXCtu14I8yjH2Mlltq7
	5mq4DCUcHo+6+tIuR1j0L1hBSGfgkdJMuT6vmG9Pillp8QujU1WeT+k2qtBaiXXVC2pYBNXRD5u
	RcpEguE0e/ewDHfEhHMvUbTi5TYcM0y4L//johVDanX6dUkq6OB0T20RWbsC4pwO7B7oLqwgq88
	Mixae79HpLXdSBKjIPhLRJVAbs+ZueZhlZjjAhbZlbS5dX0Xo6r0Q6j1Wpqd7fH2taDSZLlJC9/
	b9Vi/gVX+7MtFLfMmt0GF1RTlNmX08wXwBQR+D0/spKlYys/diAlwb3/7VBpES+ZVSqgXTvv8yG
	X8gbyJOwSYwKBJknB516XrZBPnKo1cMDFbZ05wfy1vqaAUhwrtXfQ+iW3f1OWGJZi6t75n
X-Received: by 2002:a05:6820:811a:b0:69b:8ded:f92d with SMTP id 006d021491bc7-69c9430101bmr3845524eaf.21.1778880521395;
        Fri, 15 May 2026 14:28:41 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:28:41 -0700 (PDT)
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
Subject: [PATCH v14 1/9] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Fri, 15 May 2026 15:27:07 -0600
Message-Id: <20260515212715.3151307-2-rjethwani@purestorage.com>
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
X-Rspamd-Queue-Id: 691D4558232
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288457-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

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


