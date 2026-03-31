Return-Path: <netdev+bounces-273394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIoHCDEQy2lCDgYAu9opvQ
	(envelope-from <netdev+bounces-273394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:07:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1C3628DC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D4A3018BDA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5CDF6C;
	Tue, 31 Mar 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wl7NfIXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6C40DFAB
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915513; cv=none; b=tuQbZcI4MdUFkcTfl/f6ouANfp8fry8RjqzYEDccjIRoi/68N/Szo5RuvPZ2LhtQAatgdBs/7mQIrp3IJhzICOW9Rw7IAOT5irKQ3p2voPDlv9BaWNUDjPxUWLwJapv9RPbYfY3BvQeSerPeHvdgdu8oWX+itodu/0Y5fZq/E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915513; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pr3tPOVx3L5ws94s9Fq+UAqIL7qhhMjzbo69x0FZB3goNwzWyvUAg9kGv8w8jYO2aNrfhI1GmYv/Dz0LdDQXs6i84faLEYD+wOfMwsaIq6RIRu8Siziu3tW/KMWojJTk9I+soFpIEpVqAgriI1YFwIC69g6F3BqOFshsk4jx4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wl7NfIXI; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67e02b821cfso2910242eaf.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774915511; x=1775520311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=Wl7NfIXIVMnfByucO5kpwJFhHxNIyUDx1m2f4iKH6IC70KVWyhUflLsEaPgTlicg74
         r4x5ZzOzTJfFEOHAvqQ+uKEG2AZ2WOMCLUDBjSBMp8Ih1ODVEt6pgsrBMjyfaNL+DBQY
         MojIswjy9FejXoShaZM1E48j+siPTsTuJgkzBXmZ9e8lpctev9VHJB036w46VDoYsRYJ
         j8MtwDVURNPGfc/lEOpnEXAyxKmTS46V+H1xeMvJayUjLYhlpRSyMWWUWesS4305Kkw5
         Wqhcbz8eH3ReJhaEShMtStIvHFucw6XUe3F5aZere5XfcJmgguFVb43XrSrR79Zrkkuo
         0Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915511; x=1775520311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=s7kVbfI5EZxYglCO+r645AY7i91jDzFjCrBQwJxWtsOj73yIqPDKCD+Te/06kF+2FM
         OaY3k95vZN8GDvhqyaZbKQ+9eAA7VTjB+WK/hQ4OGMt0Rv5ZD1DTLbLl+OXCd5ShpeaO
         cFLu/ZF2bgCzvWa8jGgYDK7SLn+lLVPABgSABq2xv+CTx9PYX4SFvYYh7veGltIQYVND
         j2jp+WdxpXuiDiW7Bar1UbONtZxJ0I+BpzFXgG26EQfN831TObzOIWnJqRXyAZA2zMB1
         YgUsoGsYUvM0cMaiwiBDteChHHFXWrlFUUoLWfBMTwHvokiDSRaNdkQTTbf56GNWhvLr
         /Vlw==
X-Gm-Message-State: AOJu0Yxtin9CY8cqOZYqvm23Zor7nwcHu0d0uya3qv7w+BV8uXy4W3le
	P/vFKPf7Olpc7K5RrfsL07lOwWzbOzxoA5kYHdn04y2YmnhvYd77fsIl3ZmXhKGloip4q1YCqCR
	2exXkr4UcGiV6m4hKZP7OhOOz2KTEVnK9COUk5rj6LYaR/XChqaJiFs1pLr0KRkO2XUIKUmtC8z
	h7QRJp/wtSjvPBUKW11+fC8X7BI7RZgJ7W+tHQTTOov+ZFNbY=
X-Gm-Gg: ATEYQzwa5oj75jbLLlZj8RtmuzuYyIBGJoMzpobaYsJAsZVZ6R84mHcQPYmBP6UrHnH
	DvTuCof6U2a/PF0Wg53tScwGz/9PmZixYHRU68X5OzJHxXiiXwQ8bJSulAcymvMtbRe3VEOSRkd
	KFx5le5EWpew9r8/OoyBpxyaM9QKlE8D7KYfJQYkLwZEPaZkQMOnmiOSvV8mTNgqpe0E1Qetc/J
	mK4RMAvSUpBVnyesz30H8wc5xbDnQtR2ro8KHw+TlvnPgbYmHQhZG1DmOP9syfWReaW/OA/VOw+
	uyPaR0VuxIB4qR7aT+QerIUIilV7exDSEhgHOekOcjT0s74L6o08LZu0B5iVoz94OKVLV7baayL
	RUy23rv6D0oM/beoj2JmblJ1BkGb95Ks2OEfRDRoHy6mOUSW0zhiCP0Hk/FKFfX6Fr+uQVOi3FL
	z/99h7GS9d64PvR8qEPppxqUw4e0leQ8Cjfv4XapK1mSaeasIu300QbxljWrG2hy8i1BNT0f+im
	AY=
X-Received: by 2002:a05:6820:2227:b0:67e:2f4b:5ef with SMTP id 006d021491bc7-67e2f4b0cf5mr3880443eaf.53.1774915510764;
        Mon, 30 Mar 2026 17:05:10 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-67e231cb2e2sm5627807eaf.12.2026.03.30.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:05:10 -0700 (PDT)
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
Subject: [PATCH v10 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Mon, 30 Mar 2026 18:04:39 -0600
Message-Id: <20260331000444.4103528-2-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273394-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AB1C3628DC
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


