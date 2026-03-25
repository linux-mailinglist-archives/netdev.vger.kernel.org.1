Return-Path: <netdev+bounces-271725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG2LFdlBxGlvxwQAu9opvQ
	(envelope-from <netdev+bounces-271725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F276332BAD9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78AB03060AE3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F2369229;
	Wed, 25 Mar 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CS7ncloX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB11684B4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469516; cv=none; b=b9plrt1v9lMuOx3VZT9biR25Snnwt6JnD3qFklWFBRI1gyhdH2i1EQxorjx12C1cec07Xk+ui4PQZxy27O//DTtYgQdeEn/M4nteT9aDcgAjAhfugOqmLkMyDodmfzCtGMDnRTQT8iSmibTjGH032wCgx9zQ8gp9ZpTUXumfIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469516; c=relaxed/simple;
	bh=jIxC9Xt7KvY7NNn0gWbjTmqKfFhpD9LFvV6uzbCPOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpfdPJDDW3TKevchTqPqCXsOKdcr3ECQYjgNoXPzE+TM644fuDA0EmfUk2opNpPz5iRAH2InD3sYxsXRJwDkrHYKpxG/J2w5sKjD9lliT4ccy9JgLgW6xf5GijRaeK7TN8bGIJURdGLsGjH3shguRUSDNAneSaB2U0X1QBsSwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CS7ncloX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-66f747175d8so197788eaf.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469513; x=1775074313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5EAW/dU3xcgcEergLpQb05bDeYWfWPBoj8NevQL9y0=;
        b=CS7ncloX5zdvFIq11FCjDx3lP/9gUs9CP++KTSWymmZxQGj0UOBhhjY0B+cazHNeTR
         YlnAzJjRHWiHYvsi49lTzBsFipuqFVj50O45LqYDP2lwVgBMvtl7hUWh7/yh+F+/7aQw
         0fxNeCsHu3mJXpb4gYjwa47XX1+fKsHLwKqS7e5b9V040gliv2CqN+6/ZUvASDxbAmqR
         CF/UrGxlxctZxYQnIgktkoso7W5/qTlkkOatVB54nQwQQGioLq9fjU0Aw0Q17sViWtjZ
         esaFA4YVTThmhx+jpCe04JWEhrgms5Tpu5947q9h/ejywTmPgGDulPtAZaOYkt1nP6bA
         mTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469513; x=1775074313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5EAW/dU3xcgcEergLpQb05bDeYWfWPBoj8NevQL9y0=;
        b=WdJFa5UsaHLRJ9NJLikd3J9RGQuB0FSJnNGtzbzXVkxV6kxCFHnBxEOKaULDAZonPe
         b4YjbO0K72QZfXyYVQpY+ou1OiUC5eyjL2GrjubFc8wg+evkDsCP4kWfDSSoAzh66RNr
         hipVqMAqm+rHdG/XDFZSHAENxLjs/4bTxcopvabEQp9gg7dYWfcLnUaqzFAh3VOFkQdr
         UkAamaf7S2dlsdltXMZqOfay1HV0r4iVM76QvwrAGdpULcNRCrq0kap1KDO4UMsWE9tD
         LPciOG7ATAwwvun81NJ+1zim1JeMqhMTguXrqPwlWAqKGTmU8IKtFCqfISqQxZ/tHb23
         bceg==
X-Gm-Message-State: AOJu0YyGVBKQ+0iqkqvXAyYYpkZhIeZsA7r+xL3KlwzWAfy1EXoTo3Su
	rJFCTDxcuaLM/8Spwjv3e0wf1B5HVAO6BodpFYtgnIGMAHW2x4V6l6pHQqyCxFyHVAJIWu3qavf
	V5CNOzoshrQ==
X-Gm-Gg: ATEYQzyVpxYTWEG6WBo5Y53bc/zzqAS4VSh+KO3Qux6ksGnCPq0JNNXGGTKZvjyBVv8
	/kPSUzFev5p3qJVhmTyYQoc1GZMk7pM1h02o02IZH00LGvH1hfBngzyNGVh0mX5t+PhfQ3jCsMg
	GBHUBwYYqyXb6Rg1MFkFtt1qLY3L7iUfO/UsFlrjqawzx8ODs6MqBYGbLoqVNExjyshNjXdEJ9L
	du7uw//zT2iJvquhi64QTL/Dyh++MciJ1Zvss6klNyvhjSvhJPL/P4pe58v1CLTBZNbjFdkzTEj
	aGSQgTeN3E7qgaHaNRYBzyEcsAK2jebiPoob/3t9oohhtsiegCQ0IdyhkySQ71waKfBG3CgoVuk
	mT9obzPZZ/9WNgeAq0s1fQW96mwBb8DYDfly/9AJgTwH13xMWQDbrylKyIQQ65Dt82M2BB91IVI
	a9mIJ1+gEpgb0XMGpatzx56LU=
X-Received: by 2002:a05:6820:1614:b0:67c:2857:e0e9 with SMTP id 006d021491bc7-67dff51458bmr2535712eaf.44.1774469512955;
        Wed, 25 Mar 2026 13:11:52 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:52 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 2/6] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Wed, 25 Mar 2026 15:09:48 -0500
Message-ID: <20260325201139.2501937-3-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271725-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: F276332BAD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for extracting RSS hash values and hash types from hardware
completion descriptors in XDP programs for bnxt_en.

Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
addition add ITYPE_ICMP flag for identifying ICMP completions.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
---
v4: no changes
v5: no changes
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e70fd04fe5f3..d15548dfd4a3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15911,6 +15911,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
 };
 
+static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
+	.xmo_rx_hash		= bnxt_xdp_rx_hash,
+};
+
 static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_rx *stats)
 {
@@ -16795,6 +16799,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dd0f6743acf5..99f45686ed09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -232,6 +232,7 @@ struct rx_cmp {
 	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_ICMP			 (7 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
 	#define RX_CMP_LEN					(0xffff << 16)
@@ -311,6 +312,7 @@ struct rx_cmp_ext {
 	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
 	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
 	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
+	#define RX_CMP_FLAGS2_IP_TYPE				(0x1 << 8)
 	__le32 rx_cmp_meta_data;
 	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
 	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 85cbeb35681c..1f920464b426 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
+
+int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+		     enum xdp_rss_hash_type *rss_type)
+{
+	const struct bnxt_xdp_buff *xdp = (void *)ctx;
+	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
+	const struct rx_cmp *rxcmp = xdp->rxcmp;
+	enum xdp_rss_hash_type hash_type = 0;
+	u32 itypes;
+
+	if (!rxcmp || !RX_CMP_HASH_VALID(rxcmp))
+		return -ENODATA;
+
+	*hash = le32_to_cpu(rxcmp->rx_cmp_rss_hash);
+
+	if (!rxcmp1) {
+		*rss_type = XDP_RSS_TYPE_L2;
+		return 0;
+	}
+
+	if (xdp->cmp_type == CMP_TYPE_RX_L2_CMP) {
+		itypes = RX_CMP_ITYPES(rxcmp);
+		if (rxcmp1->rx_cmp_flags2 &
+		    cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE)) {
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		} else {
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+		}
+
+		switch (itypes) {
+		case RX_CMP_FLAGS_ITYPE_TCP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_TCP;
+			break;
+		case RX_CMP_FLAGS_ITYPE_UDP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_UDP;
+			break;
+		case RX_CMP_FLAGS_ITYPE_ICMP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_ICMP;
+			break;
+		default:
+			break;
+		}
+	}
+
+	*rss_type = hash_type;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 8c66698bde11..fb4f9143929f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -41,4 +41,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
 				   struct xdp_buff *xdp);
+int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+		     enum xdp_rss_hash_type *rss_type);
+
 #endif
-- 
2.43.0


