Return-Path: <netdev+bounces-254420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO01N2tcemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:58:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A4A7FD6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74BE3049EEF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061FC374733;
	Wed, 28 Jan 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Su+Vou5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE237418F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626653; cv=none; b=r3EQ7x4TZQEI1mCptij1Tlnc4VgsgN7BYV3ZYPTCRh28ZV8GA5/6Ppw/nryDEn6joF8s0IppQ4ovBJYlyGykU/gJmpkU7qT5BB2hwxIXGeSzW9A2DpqSqLVtxMVEeDK3TxuJH/9f00j0WduvJx/LdUXozRwIVuLhvo4r4SD2+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626653; c=relaxed/simple;
	bh=P6NQdhvSGOiOEaZnIgzwu82OeAsyfH7kGJEwellkPqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+i6QgNpFcatUhKO2kMJIaafxHtyQaYtWH+GJ4qhdNlmvBHlv8KawcVoLkBCUHYAy0cppj0xX3B3avoBmEN71UXUtFo89JLyQm3Uis1LsVXs2s3TaE/I/NMEAWb5XByANPnrFFLUJBdYUmR20ofdgAOWBke9+d23+Sbj0e/3fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Su+Vou5i; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8947404b367so2116006d6.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626651; x=1770231451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAAzkfzFSB7WTgu4dHa6SgmJadc1G5A9GOoFDZhQpTY=;
        b=G6y3KSn7oeO0bZ879/1esxIzGiOeuOmi7fttk5n3HFU/7C+r0a+rMK924Gv02MhQep
         0JuvWU9Ezr/S0C59YuZctCoZoc1MetT3YtspFnfghrH3238ijoQfgc8gWBIb/5Hk7lNj
         gLk9W0FA9AbqFVjWbE8KzIka+fLS1dDFG53dG66R/+TlHmE0MRhuzq1iL9D5H3rQ5uHt
         EfXgFK3NZt7iZLEdi495pG5VlbpNRkv6xa9cfOAPw9XMAAZmKgdPsWwvzSy6dxu1i3Si
         QBz/bcl3KWhm7HghEI+Ea3VkeHKrBPRp5FRgssbK1eM5uNoOZekSAR0+TuXlIbocMJEk
         YhZw==
X-Gm-Message-State: AOJu0YykyR5uKGE4He/0Ktj88jU0H5i/x6mpgXI8TdEW/4uKMHf1gbHj
	GcDvK0HxApVyaFKvwVF26cqBf1tsqDZSB9B2G6/svkzFf8hCmFLHC/cpbkhhaBU4SSlZ9kf2MD7
	mgFknxFMrKuPWWwyDSDga9SttkB2DQ0gJHKs7CQY+JJnCUnWVKz4147KtUy0r6At7uzzYHIaIEB
	SVSiwL0e8NMMDeNv4BquPe7yNvtDqdKRJvMFUVO1xSa+71SFC2EbuZqc3P/9DuqcPb8laup3ZZV
	AgLNpLwzsC94nR+4g==
X-Gm-Gg: AZuq6aIk31PUnWad4V5T4hIEKooiFuMNLZ5DvKYcmHMBdIvyYxTWJ2LgKP6zUXJp/uI
	92/ut0N9CouY6jeb3BsgSMOpgnvN7VABujKiad2uvF45fDzHh3f+3BHtWki9bsFobFmSxixFOdy
	kYYqSNLMuianup7B+Zwji/HWLBvccLyTt5SkA0Bz1caC7Kfr6lS6lxhNvyzQjH7v22b+Hy1G/B7
	WaUJyA+HvA7YgtbfQCuKgYz2Q2F2D14JubGxT+bV0qfA3SWD0E24MOTvaIPwd+HXsFDE2M0v/Se
	gkpBe3nOXlnTMi7gRwGF3iXfR+M5B7HkuwK/RJrLU+8wq6TmIbdfdoSTx6Ce2GtaeRv1JnFgK+N
	ervGrrOYB1/Ey8Y483iUjtf/qmGIFOof0gYOpTYY8SLSlb7uvP22jpmyxtvKy63AoVHIYdbxLFH
	gVOEYzvSPCXQOlJTu1+2YVbpJnkQpg2NTr2ghd5ybBTKjD3aR6XVI=
X-Received: by 2002:a05:6214:d04:b0:894:8211:b025 with SMTP id 6a1803df08f44-894cc81e458mr99017176d6.18.1769626651152;
        Wed, 28 Jan 2026 10:57:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d35d888asm4003676d6.0.2026.01.28.10.57.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso118100b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626650; x=1770231450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAAzkfzFSB7WTgu4dHa6SgmJadc1G5A9GOoFDZhQpTY=;
        b=Su+Vou5iTAEfvVr5yVFkzw2JqRbKItAadRy/Oh/l3W+sKvMLKRvOXH5y075ZWaRQfX
         bcOx+CLVQyil9h3/B0WAD2aBQ+Y82xFfAddmQYeZTivQn8PDM0im957eJ0nX3e7yklKK
         GrmDY+G8trruxS2YeRErIJfR/T6m+h89FIiqw=
X-Received: by 2002:a05:6a00:2d84:b0:81f:852b:a936 with SMTP id d2e1a72fcca58-8236917bb29mr5795981b3a.15.1769626649988;
        Wed, 28 Jan 2026 10:57:29 -0800 (PST)
X-Received: by 2002:a05:6a00:2d84:b0:81f:852b:a936 with SMTP id d2e1a72fcca58-8236917bb29mr5795963b3a.15.1769626649623;
        Wed, 28 Jan 2026 10:57:29 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:29 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>
Subject: [v7, net-next 5/8] bng_en: Add ndo_features_check support
Date: Thu, 29 Jan 2026 00:26:20 +0530
Message-ID: <20260128185623.26559-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
References: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254420-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D2A4A7FD6
X-Rspamd-Action: no action

Implement ndo_features_check to validate hardware constraints per-packet:
- Disable SG if nr_frags exceeds hardware limit.
- Disable GSO if packet/fragment length exceeds supported maximum.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 24 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 78f04db3c597..fba7f6a73b85 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2421,6 +2421,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_features_check	= bnge_features_check,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 261b071a8bd6..312b5cbea2a5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -966,3 +966,27 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
+
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features)
+{
+	u32 len;
+
+	features = vlan_features_check(skb, features);
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
+		features &= ~NETIF_F_SG;
+#endif
+
+	if (skb_is_gso(skb))
+		len = bnge_get_gso_hdr_len(skb) + skb_shinfo(skb)->gso_size;
+	else
+		len = skb->len;
+
+	len >>= 9;
+	if (unlikely(len >= ARRAY_SIZE(bnge_lhint_arr)))
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 81a24d8f9689..32be5eb46870 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -119,4 +119,7 @@ irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features);
 #endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


