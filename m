Return-Path: <netdev+bounces-59795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6581C0BB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2591C235D1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98878E9B;
	Thu, 21 Dec 2023 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LOxeG+0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495177F1E
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ba52d0f9feso901232b6e.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703196186; x=1703800986; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7l0mnqIPqOq/K5r8EEeydQcBixUFFKrKBkKyUSitwg=;
        b=LOxeG+0/NSvLCrlH/2XEmsbhLq/jY0NAN35KMGstUTjzyNfHNhj7803IjVmM8YACJs
         5YFbYyYJ4Kl1IWdbPnfsFJ8GyptXwRE0Snsw2An/W8cTr2hYAOHyCMIgqao4MEHMa6gP
         5+hBUyVhU9V0Ltll5SAsIIK9NUyG4ybbZR/2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196186; x=1703800986;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7l0mnqIPqOq/K5r8EEeydQcBixUFFKrKBkKyUSitwg=;
        b=wVTo/yF1T/v16msumD/x+mpCm3LMKR5YaWiJMCqaavvMoDhM9pdfJwGPmwGv6bGnLK
         LtkAN0U6xAP/1k5zy3r2T347GSsbIrsQQefCy35TiIJk0mYWx4M81ypG1LLZy3+SvD3s
         RQxrID3gYNzwvVImSK1VWy/W96nJ+l/zh/wRkIaRUiq2qDixPGM8LisDRVl7BluAKYEn
         t4CLHzm96mGzjHORKh9O52vM5YCGvTsZQ4GgGoK9ygJfFHhKk+7hVUrVxWPAYSmwXYWh
         LSl276xwEkZTPlZgYD4Qut1cgiM7NnBb+oeej0mFmwhDXEPdOHMY/Wz5ZzAmNI4x87fv
         Helw==
X-Gm-Message-State: AOJu0Yxu/Oqo8kD3CqDpnmhz1M8QS7Hx/WtoV8/Fw2nc2XJtVnQvk7Zd
	7+Vupx56CKAUs0IXhYDsJ24AEjsI7OVE
X-Google-Smtp-Source: AGHT+IG+YnyxbkyEzKi5JzZp9IBeSaYB3gMe41CP59dTGaQsMxHsWBBaFrCeDDFgNgGLQXRGZCq1ZA==
X-Received: by 2002:a05:6808:2083:b0:3b8:b063:5049 with SMTP id s3-20020a056808208300b003b8b0635049mr363602oiw.74.1703196185478;
        Thu, 21 Dec 2023 14:03:05 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ee14-20020a0562140a4e00b0067f712874fbsm905198qvb.129.2023.12.21.14.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 14:03:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 05/13] bnxt_en: Add function to calculate Toeplitz hash
Date: Thu, 21 Dec 2023 14:02:10 -0800
Message-Id: <20231221220218.197386-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231221220218.197386-1-michael.chan@broadcom.com>
References: <20231221220218.197386-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a999ae060d0c436c"

--000000000000a999ae060d0c436c
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

For ntuple filters added by aRFS, the Toeplitz hash calculated by our
NIC is available and is used to store the ntuple filter for quick
retrieval.  In the next patches, user defined ntuple filter support
will be added and we need to calculate the same hash for these
filters.  The same hash function needs to be used so we can detect
duplicates.

Add the function bnxt_toeplitz() to calculate the Toeplitz hash for
user defined ntuple filters.  bnxt_toeplitz() uses the same Toeplitz
key and the same key length as the NIC.

bnxt_get_ntp_filter_idx() is added to return the hash index.  For
aRFS, the hash comes from the NIC.  For user defined ntuple, we call
bnxt_toeplitz() to calculate the hash index.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 100 +++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  11 +++
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 31289803ff92..66ec7d4d1398 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4199,13 +4199,22 @@ static void bnxt_init_vnics(struct bnxt *bp)
 		vnic->fw_l2_ctx_id = INVALID_HW_RING_ID;
 
 		if (bp->vnic_info[i].rss_hash_key) {
-			if (i == 0)
+			if (!i) {
+				u8 *key = (void *)vnic->rss_hash_key;
+				int k;
+
+				bp->toeplitz_prefix = 0;
 				get_random_bytes(vnic->rss_hash_key,
 					      HW_HASH_KEY_SIZE);
-			else
+				for (k = 0; k < 8; k++) {
+					bp->toeplitz_prefix <<= 8;
+					bp->toeplitz_prefix |= key[k];
+				}
+			} else {
 				memcpy(vnic->rss_hash_key,
 				       bp->vnic_info[0].rss_hash_key,
 				       HW_HASH_KEY_SIZE);
+			}
 		}
 	}
 }
@@ -5374,6 +5383,79 @@ static struct bnxt_l2_filter *bnxt_lookup_l2_filter(struct bnxt *bp,
 	return fltr;
 }
 
+#define BNXT_IPV4_4TUPLE(bp, fkeys)					\
+	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
+	  (bp)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4) ||	\
+	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
+	  (bp)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4))
+
+#define BNXT_IPV6_4TUPLE(bp, fkeys)					\
+	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
+	  (bp)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6) ||	\
+	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
+	  (bp)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6))
+
+static u32 bnxt_get_rss_flow_tuple_len(struct bnxt *bp, struct flow_keys *fkeys)
+{
+	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
+		if (BNXT_IPV4_4TUPLE(bp, fkeys))
+			return sizeof(fkeys->addrs.v4addrs) +
+			       sizeof(fkeys->ports);
+
+		if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4)
+			return sizeof(fkeys->addrs.v4addrs);
+	}
+
+	if (fkeys->basic.n_proto == htons(ETH_P_IPV6)) {
+		if (BNXT_IPV6_4TUPLE(bp, fkeys))
+			return sizeof(fkeys->addrs.v6addrs) +
+			       sizeof(fkeys->ports);
+
+		if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
+			return sizeof(fkeys->addrs.v6addrs);
+	}
+
+	return 0;
+}
+
+static u32 bnxt_toeplitz(struct bnxt *bp, struct flow_keys *fkeys,
+			 const unsigned char *key)
+{
+	u64 prefix = bp->toeplitz_prefix, hash = 0;
+	struct bnxt_ipv4_tuple tuple4;
+	struct bnxt_ipv6_tuple tuple6;
+	int i, j, len = 0;
+	u8 *four_tuple;
+
+	len = bnxt_get_rss_flow_tuple_len(bp, fkeys);
+	if (!len)
+		return 0;
+
+	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
+		tuple4.v4addrs = fkeys->addrs.v4addrs;
+		tuple4.ports = fkeys->ports;
+		four_tuple = (unsigned char *)&tuple4;
+	} else {
+		tuple6.v6addrs = fkeys->addrs.v6addrs;
+		tuple6.ports = fkeys->ports;
+		four_tuple = (unsigned char *)&tuple6;
+	}
+
+	for (i = 0, j = 8; i < len; i++, j++) {
+		u8 byte = four_tuple[i];
+		int bit;
+
+		for (bit = 0; bit < 8; bit++, prefix <<= 1, byte <<= 1) {
+			if (byte & 0x80)
+				hash ^= prefix;
+		}
+		prefix |= (j < HW_HASH_KEY_SIZE) ? key[j] : 0;
+	}
+
+	/* The valid part of the hash is in the upper 32 bits. */
+	return (hash >> 32) & BNXT_NTP_FLTR_HASH_MASK;
+}
+
 #ifdef CONFIG_RFS_ACCEL
 static struct bnxt_l2_filter *
 bnxt_lookup_l2_filter_from_key(struct bnxt *bp, struct bnxt_l2_key *key)
@@ -13770,6 +13852,18 @@ static int bnxt_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+static u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
+				   const struct sk_buff *skb)
+{
+	struct bnxt_vnic_info *vnic;
+
+	if (skb)
+		return skb_get_hash_raw(skb) & BNXT_NTP_FLTR_HASH_MASK;
+
+	vnic = &bp->vnic_info[0];
+	return bnxt_toeplitz(bp, fkeys, (void *)vnic->rss_hash_key);
+}
+
 #ifdef CONFIG_RFS_ACCEL
 static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 			    struct bnxt_ntuple_filter *f2)
@@ -13862,7 +13956,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 
 	new_fltr->l2_fltr = l2_fltr;
 
-	idx = skb_get_hash_raw(skb) & BNXT_NTP_FLTR_HASH_MASK;
+	idx = bnxt_get_ntp_filter_idx(bp, fkeys, skb);
 	head = &bp->ntp_fltr_hash_tbl[idx];
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(fltr, head, base.hash) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5d67b8299328..3f4e4708f7d8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1370,6 +1370,16 @@ struct bnxt_l2_key {
 	};
 };
 
+struct bnxt_ipv4_tuple {
+	struct flow_dissector_key_ipv4_addrs v4addrs;
+	struct flow_dissector_key_ports ports;
+};
+
+struct bnxt_ipv6_tuple {
+	struct flow_dissector_key_ipv6_addrs v6addrs;
+	struct flow_dissector_key_ports ports;
+};
+
 #define BNXT_L2_KEY_SIZE	(sizeof(struct bnxt_l2_key) / 4)
 
 struct bnxt_l2_filter {
@@ -2413,6 +2423,7 @@ struct bnxt {
 	struct hlist_head	l2_fltr_hash_tbl[BNXT_L2_FLTR_HASH_SIZE];
 
 	u32			hash_seed;
+	u64			toeplitz_prefix;
 
 	/* To protect link related settings during link changes and
 	 * ethtool settings changes.
-- 
2.30.1


--000000000000a999ae060d0c436c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMPiqdQpy7m0pHYo7mE7TtTE/hqd2wZt
MlqXgUVb4IUlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MTIyMDMwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBbUSEdvXp18cHg1sx51L2Frn+t+tWl9tTnzQ+pBRyUFvO/9KQj
1FJ5ZOsl7gjorMEdMSeS5aqNMl73xI2dvyrhYaOEBBDLp8CtOrW4fB2JOa2+1/PhJm1JtgXruOJe
ygCDfoiDrbFWAeFinThKYyWFNO0fRBlFRuA9GoHr506YRiHqGm/gT3W8VwjvkHwUJAIl3VmeBYqK
Gvg1R1Hly+VrgJ/EkkPdajP6fBYtztI+3P2fTTlq3VcshyCLDrnGddcKZ6CbBP/MO9VHzMGKg+dA
5cEZW24mBiV3sZZyEkIgBhmqgsGzITQDRXKM4KDjlNvzZXfrLHUJWc0Ep3mkqniM
--000000000000a999ae060d0c436c--

