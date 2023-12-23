Return-Path: <netdev+bounces-60047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C681D226
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1226D1C227E0
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E84C85;
	Sat, 23 Dec 2023 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bGCGuJUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9C469E
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f8a5ed1a0so11116956d6.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305361; x=1703910161; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcsTa7bRud7e3sZv2VpHzDuK9M7W9RmOTUL9cMcaBKc=;
        b=bGCGuJUR7iOuOI6v+EWiVAYr7XGKM0DDOAfdVHhqm5Bb4aeghKMP1aELO3yhgjsLam
         eDLEYwvBGjcfSL8zdSukrhMGqRn6IRzqIufA6CDa0jgQj0Az4naojKsdqrtjq6hvvq9n
         Z/+S49mC2NVyROAxd4/w8f9v6g7JWG0hRbAF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305361; x=1703910161;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcsTa7bRud7e3sZv2VpHzDuK9M7W9RmOTUL9cMcaBKc=;
        b=HTLhwzhxHM6ZWG1B1FXFMJGzGV7ReA2Jcw03P7wN1WvbKieGfyrVvF+PjbOywnFqck
         zxy3hS0F3KFvXlehtcqsvGt5XRfuAzK9LdH9xW5kOjm3Bnv7CZqBIxTsJ9gO/o1xAikN
         us/MvIJM9hgRd5tAZBf8hTAwl1x7hVV2G1NWi2zmAhs6r5uF/4Az0EV4TI2K8HB8ZFEs
         q9gk6AGiBTa1HDQQ/x3V4BYQ6SKZjzcyBtBHRk2ODy3q1SKN0Mpw4CVIQ1YmZOnTz68F
         NoGj+GhAuLfXxy4Gq6srigMahRDx2XMtEC83uEanW2IGktwrcpxiUYQiaWbEWTyGlTP3
         Ki4Q==
X-Gm-Message-State: AOJu0YyrG+HtUxXvCxatSCb8QwkHdRAa6JzEDItJ6mb/7lavTk21NkwB
	gqwv42WlciJqKiwpRb6dNnmuEt7cwzcNT5DkJJFS3gygGA==
X-Google-Smtp-Source: AGHT+IFmF/QwTNShr/BtSFwMqcNwO1wU6+9JhYvHV0g8e2AM5LLgSjVYuXoUupqhCYVkN6nWR5q18Q==
X-Received: by 2002:a05:6214:1d03:b0:67f:2fde:1678 with SMTP id e3-20020a0562141d0300b0067f2fde1678mr3623274qvd.42.1703305360912;
        Fri, 22 Dec 2023 20:22:40 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:40 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 03/13] bnxt_en: Re-structure the bnxt_ntuple_filter structure.
Date: Fri, 22 Dec 2023 20:22:00 -0800
Message-Id: <20231223042210.102485-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231223042210.102485-1-michael.chan@broadcom.com>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000001b178060d25aff4"

--00000000000001b178060d25aff4
Content-Transfer-Encoding: 8bit

With the new bnxt_l2_filter structure, we can now re-structure the
bnxt_ntuple_filter structure to point to the bnxt_l2_filter structure.
We eliminate the L2 ether address info from the ntuple filter structure
as we can get the information from the L2 filter structure.  Note that
the source L2 MAC address is no longer used.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 62 ++++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 +-
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8e9a02629450..62e4f35c6f0f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4804,6 +4804,7 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 
 		head = &bp->ntp_fltr_hash_tbl[i];
 		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
+			bnxt_del_l2_filter(bp, fltr->l2_fltr);
 			if (!all && (fltr->base.flags & BNXT_ACT_FUNC_DST))
 				continue;
 			hlist_del(&fltr->base.hash);
@@ -5373,6 +5374,20 @@ static struct bnxt_l2_filter *bnxt_lookup_l2_filter(struct bnxt *bp,
 	return fltr;
 }
 
+#ifdef CONFIG_RFS_ACCEL
+static struct bnxt_l2_filter *
+bnxt_lookup_l2_filter_from_key(struct bnxt *bp, struct bnxt_l2_key *key)
+{
+	struct bnxt_l2_filter *fltr;
+	u32 idx;
+
+	idx = jhash2(&key->filter_key, BNXT_L2_KEY_SIZE, bp->hash_seed) &
+	      BNXT_L2_FLTR_HASH_MASK;
+	fltr = bnxt_lookup_l2_filter(bp, key, idx);
+	return fltr;
+}
+#endif
+
 static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 			       struct bnxt_l2_key *key, u32 idx)
 {
@@ -5432,7 +5447,6 @@ static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 #define BNXT_NTP_FLTR_FLAGS					\
 	(CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_L2_FILTER_ID |	\
 	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_ETHERTYPE |	\
-	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_MACADDR |	\
 	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_IPADDR_TYPE |	\
 	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR |	\
 	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR_MASK |	\
@@ -5463,7 +5477,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	if (rc)
 		return rc;
 
-	l2_fltr = bp->vnic_info[0].l2_filters[fltr->l2_fltr_idx];
+	l2_fltr = fltr->l2_fltr;
 	req->l2_filter_id = l2_fltr->base.filter_id;
 
 
@@ -5478,7 +5492,6 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	req->enables = cpu_to_le32(BNXT_NTP_FLTR_FLAGS);
 
 	req->ethertype = htons(ETH_P_IP);
-	memcpy(req->src_macaddr, fltr->src_mac_addr, ETH_ALEN);
 	req->ip_addr_type = CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV4;
 	req->ip_protocol = keys->basic.ip_proto;
 
@@ -13730,8 +13743,7 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 
 	if (keys1->ports.ports == keys2->ports.ports &&
 	    keys1->control.flags == keys2->control.flags &&
-	    ether_addr_equal(f1->src_mac_addr, f2->src_mac_addr) &&
-	    ether_addr_equal(f1->dst_mac_addr, f2->dst_mac_addr))
+	    f1->l2_fltr == f2->l2_fltr)
 		return true;
 
 	return false;
@@ -13744,29 +13756,32 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	struct bnxt_ntuple_filter *fltr, *new_fltr;
 	struct flow_keys *fkeys;
 	struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
-	int rc = 0, idx, bit_id, l2_idx = 0;
+	struct bnxt_l2_filter *l2_fltr;
+	int rc = 0, idx, bit_id;
 	struct hlist_head *head;
 	u32 flags;
 
-	if (!ether_addr_equal(dev->dev_addr, eth->h_dest)) {
-		struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
-		int off = 0, j;
+	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
+		l2_fltr = bp->vnic_info[0].l2_filters[0];
+		atomic_inc(&l2_fltr->refcnt);
+	} else {
+		struct bnxt_l2_key key;
 
-		netif_addr_lock_bh(dev);
-		for (j = 0; j < vnic->uc_filter_count; j++, off += ETH_ALEN) {
-			if (ether_addr_equal(eth->h_dest,
-					     vnic->uc_list + off)) {
-				l2_idx = j + 1;
-				break;
-			}
-		}
-		netif_addr_unlock_bh(dev);
-		if (!l2_idx)
+		ether_addr_copy(key.dst_mac_addr, eth->h_dest);
+		key.vlan = 0;
+		l2_fltr = bnxt_lookup_l2_filter_from_key(bp, &key);
+		if (!l2_fltr)
+			return -EINVAL;
+		if (l2_fltr->base.flags & BNXT_ACT_FUNC_DST) {
+			bnxt_del_l2_filter(bp, l2_fltr);
 			return -EINVAL;
+		}
 	}
 	new_fltr = kzalloc(sizeof(*new_fltr), GFP_ATOMIC);
-	if (!new_fltr)
+	if (!new_fltr) {
+		bnxt_del_l2_filter(bp, l2_fltr);
 		return -ENOMEM;
+	}
 
 	fkeys = &new_fltr->fkeys;
 	if (!skb_flow_dissect_flow_keys(skb, fkeys, 0)) {
@@ -13793,8 +13808,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		goto err_free;
 	}
 
-	memcpy(new_fltr->dst_mac_addr, eth->h_dest, ETH_ALEN);
-	memcpy(new_fltr->src_mac_addr, eth->h_source, ETH_ALEN);
+	new_fltr->l2_fltr = l2_fltr;
 
 	idx = skb_get_hash_raw(skb) & BNXT_NTP_FLTR_HASH_MASK;
 	head = &bp->ntp_fltr_hash_tbl[idx];
@@ -13819,9 +13833,9 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 
 	new_fltr->base.sw_id = (u16)bit_id;
 	new_fltr->flow_id = flow_id;
-	new_fltr->l2_fltr_idx = l2_idx;
 	new_fltr->base.rxq = rxq_index;
 	new_fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
+	new_fltr->base.flags = BNXT_ACT_RING_DST;
 	hlist_add_head_rcu(&new_fltr->base.hash, head);
 	bp->ntp_fltr_count++;
 	spin_unlock_bh(&bp->ntp_fltr_lock);
@@ -13831,6 +13845,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	return new_fltr->base.sw_id;
 
 err_free:
+	bnxt_del_l2_filter(bp, l2_fltr);
 	kfree(new_fltr);
 	return rc;
 }
@@ -13871,6 +13886,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 				hlist_del_rcu(&fltr->base.hash);
 				bp->ntp_fltr_count--;
 				spin_unlock_bh(&bp->ntp_fltr_lock);
+				bnxt_del_l2_filter(bp, fltr->l2_fltr);
 				synchronize_rcu();
 				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
 				kfree(fltr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 77c7084e47cd..72e99f2a5c68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1355,10 +1355,8 @@ struct bnxt_filter_base {
 
 struct bnxt_ntuple_filter {
 	struct bnxt_filter_base	base;
-	u8			dst_mac_addr[ETH_ALEN];
-	u8			src_mac_addr[ETH_ALEN];
 	struct flow_keys	fkeys;
-	u8			l2_fltr_idx;
+	struct bnxt_l2_filter	*l2_fltr;
 	u32			flow_id;
 };
 
-- 
2.30.1


--00000000000001b178060d25aff4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPfWdfQuSia4bP9M2nU1BBBQg5mw5mbW
iAgx6xfuGZc4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjI0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCyFLQwZKX5UiNmluBFvu7LmFK3yMeAX30TcBM8a8W/XQFT2heb
6i+SHgnSBPtEu5YeLm8wSuOl4y0x1Uo65haf2ZmnLQGouZ17QIdJerkkNBXRpQPjTFB9klnIYFPh
yFuMnDtwaohjlvxTSUC6llXCu02Hj6a0vjo2oDXyJY23+n2WqIWlotefw8CjhdLIzsAmgnbTOPAe
UATf/mHy+1U6U+905hIWmM3gvDKeTll3p1TI8ElBsFM0tCS+qoQO9Om67k15+u8GmGA8QYJeuHpF
DWQsfXV5ZfvrET/zgqIDJIbbRndTh/fdtYGmB6qbp23pcopJjN/P+sqRL2mi9n/y
--00000000000001b178060d25aff4--

