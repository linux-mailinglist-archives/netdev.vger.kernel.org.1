Return-Path: <netdev+bounces-60045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E050981D224
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D581F23114
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD31866;
	Sat, 23 Dec 2023 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bmi8Voko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558649441
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f5132e8fcso16321886d6.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305358; x=1703910158; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPj9JeqzF2lbyQJdTWNGDNcfJ8lmKpqZ83bQ12tFo28=;
        b=Bmi8VokovorxrVOFPiQ90DRK5GihVlkJwKo6U9Qva3bjh/UpA7+P8nJ6d1unFvsHnQ
         8D9MMW6Hs5meYHfy8ubAMcZynek/m1Gjc+yD/G489CIf/ZiHPfah8Jb2eK+TVYItnKx6
         HYHxyYpZ/fQLB2jkfsEf4QRQs+nQtGmbAYiRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305358; x=1703910158;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPj9JeqzF2lbyQJdTWNGDNcfJ8lmKpqZ83bQ12tFo28=;
        b=tlVv82yZlAhx9o1Ag7Z3RABm51rByQyZXL8Fb51IjUd+FOsKVpJA0WRAAvkMQbqZLN
         dStFPHMYKQVM0r1K3zVQgqDL/kpuauuS/DND3G3EC3/1mt9ebTwofqoaLxs3w8EuLfTL
         nGzl7bE3o/w9M4bM5OkQ0axJQzCqWCW1Vqfsow3fynN9zczokapxrnp/ejPnv+UmqJPn
         QsnSPqJjQPC4EaxZtRstTICzQZQQ6SZgN1P5U+Uxalih4DmkDRactbIwIAy0ejgErLZf
         IDZq59VieBKtCGKTdbEiMV6YyDeM5we0CCB/9FQSJge4UGtbHpY7YdLcwjR9YHePhqed
         3s5g==
X-Gm-Message-State: AOJu0YwA1wXDY2n4lC6Ynzck7g2fdiq0eSBE2oHAY2zhzp4YcSH/UHQN
	oARfqDOBVEeWcD950kQ6UHALGdv2Kebk
X-Google-Smtp-Source: AGHT+IEN4Pv9AmRiFy7gUTAsa3n/4Ds3bCV/s/wNzZaVv77IpsiR4zAQp5ddQisPaHzDv2I2hacSvQ==
X-Received: by 2002:a05:6214:769:b0:67f:1830:b634 with SMTP id f9-20020a056214076900b0067f1830b634mr3659810qvz.93.1703305358128;
        Fri, 22 Dec 2023 20:22:38 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:37 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 01/13] bnxt_en: Refactor bnxt_ntuple_filter structure.
Date: Fri, 22 Dec 2023 20:21:58 -0800
Message-Id: <20231223042210.102485-2-michael.chan@broadcom.com>
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
	boundary="000000000000d69d4c060d25ae68"

--000000000000d69d4c060d25ae68
Content-Transfer-Encoding: 8bit

This is in preparation to support user defined L2 (ether) filters,
which will have many similarities with ntuple filters.  Refactor
bnxt_ntuple_filter structure to have a bnxt_filter_base structure
that can be re-used by the L2 filters.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 39 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 25 +++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++---
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1f956929191d..bf3b9b2cad76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4803,8 +4803,8 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool irq_reinit)
 		struct bnxt_ntuple_filter *fltr;
 
 		head = &bp->ntp_fltr_hash_tbl[i];
-		hlist_for_each_entry_safe(fltr, tmp, head, hash) {
-			hlist_del(&fltr->hash);
+		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
+			hlist_del(&fltr->base.hash);
 			kfree(fltr);
 		}
 	}
@@ -5301,7 +5301,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	if (rc)
 		return rc;
 
-	req->ntuple_filter_id = fltr->filter_id;
+	req->ntuple_filter_id = fltr->base.filter_id;
 	return hwrm_req_send(bp, req);
 }
 
@@ -5342,9 +5342,9 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 
 	if (bp->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2) {
 		flags = CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DEST_RFS_RING_IDX;
-		req->dst_id = cpu_to_le16(fltr->rxq);
+		req->dst_id = cpu_to_le16(fltr->base.rxq);
 	} else {
-		vnic = &bp->vnic_info[fltr->rxq + 1];
+		vnic = &bp->vnic_info[fltr->base.rxq + 1];
 		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 	}
 	req->flags = cpu_to_le32(flags);
@@ -5389,7 +5389,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
 	if (!rc)
-		fltr->filter_id = resp->ntuple_filter_id;
+		fltr->base.filter_id = resp->ntuple_filter_id;
 	hwrm_req_drop(bp, req);
 	return rc;
 }
@@ -13653,9 +13653,9 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	idx = skb_get_hash_raw(skb) & BNXT_NTP_FLTR_HASH_MASK;
 	head = &bp->ntp_fltr_hash_tbl[idx];
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(fltr, head, hash) {
+	hlist_for_each_entry_rcu(fltr, head, base.hash) {
 		if (bnxt_fltr_match(fltr, new_fltr)) {
-			rc = fltr->sw_id;
+			rc = fltr->base.sw_id;
 			rcu_read_unlock();
 			goto err_free;
 		}
@@ -13671,17 +13671,18 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		goto err_free;
 	}
 
-	new_fltr->sw_id = (u16)bit_id;
+	new_fltr->base.sw_id = (u16)bit_id;
 	new_fltr->flow_id = flow_id;
 	new_fltr->l2_fltr_idx = l2_idx;
-	new_fltr->rxq = rxq_index;
-	hlist_add_head_rcu(&new_fltr->hash, head);
+	new_fltr->base.rxq = rxq_index;
+	new_fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
+	hlist_add_head_rcu(&new_fltr->base.hash, head);
 	bp->ntp_fltr_count++;
 	spin_unlock_bh(&bp->ntp_fltr_lock);
 
 	bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
 
-	return new_fltr->sw_id;
+	return new_fltr->base.sw_id;
 
 err_free:
 	kfree(new_fltr);
@@ -13699,13 +13700,13 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 		int rc;
 
 		head = &bp->ntp_fltr_hash_tbl[i];
-		hlist_for_each_entry_safe(fltr, tmp, head, hash) {
+		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
 			bool del = false;
 
-			if (test_bit(BNXT_FLTR_VALID, &fltr->state)) {
-				if (rps_may_expire_flow(bp->dev, fltr->rxq,
+			if (test_bit(BNXT_FLTR_VALID, &fltr->base.state)) {
+				if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
 							fltr->flow_id,
-							fltr->sw_id)) {
+							fltr->base.sw_id)) {
 					bnxt_hwrm_cfa_ntuple_filter_free(bp,
 									 fltr);
 					del = true;
@@ -13716,16 +13717,16 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 				if (rc)
 					del = true;
 				else
-					set_bit(BNXT_FLTR_VALID, &fltr->state);
+					set_bit(BNXT_FLTR_VALID, &fltr->base.state);
 			}
 
 			if (del) {
 				spin_lock_bh(&bp->ntp_fltr_lock);
-				hlist_del_rcu(&fltr->hash);
+				hlist_del_rcu(&fltr->base.hash);
 				bp->ntp_fltr_count--;
 				spin_unlock_bh(&bp->ntp_fltr_lock);
 				synchronize_rcu();
-				clear_bit(fltr->sw_id, bp->ntp_fltr_bmap);
+				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
 				kfree(fltr);
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d0f3e74fa025..4653abbd2fe4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1332,21 +1332,34 @@ struct bnxt_pf_info {
 	struct bnxt_vf_info	*vf;
 };
 
-struct bnxt_ntuple_filter {
+struct bnxt_filter_base {
 	struct hlist_node	hash;
-	u8			dst_mac_addr[ETH_ALEN];
-	u8			src_mac_addr[ETH_ALEN];
-	struct flow_keys	fkeys;
 	__le64			filter_id;
+	u8			type;
+#define BNXT_FLTR_TYPE_NTUPLE	1
+#define BNXT_FLTR_TYPE_L2	2
+	u8			flags;
+#define BNXT_ACT_DROP		1
+#define BNXT_ACT_RING_DST	2
+#define BNXT_ACT_FUNC_DST	4
 	u16			sw_id;
-	u8			l2_fltr_idx;
 	u16			rxq;
-	u32			flow_id;
+	u16			fw_vnic_id;
+	u16			vf_idx;
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
 #define BNXT_FLTR_UPDATE	1
 };
 
+struct bnxt_ntuple_filter {
+	struct bnxt_filter_base	base;
+	u8			dst_mac_addr[ETH_ALEN];
+	u8			src_mac_addr[ETH_ALEN];
+	struct flow_keys	fkeys;
+	u8			l2_fltr_idx;
+	u32			flow_id;
+};
+
 struct bnxt_link_info {
 	u8			phy_type;
 	u8			media_type;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7e49953a93fa..65edad2cfeab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1024,10 +1024,10 @@ static int bnxt_grxclsrlall(struct bnxt *bp, struct ethtool_rxnfc *cmd,
 
 		head = &bp->ntp_fltr_hash_tbl[i];
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(fltr, head, hash) {
+		hlist_for_each_entry_rcu(fltr, head, base.hash) {
 			if (j == cmd->rule_cnt)
 				break;
-			rule_locs[j++] = fltr->sw_id;
+			rule_locs[j++] = fltr->base.sw_id;
 		}
 		rcu_read_unlock();
 		if (j == cmd->rule_cnt)
@@ -1053,8 +1053,8 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 
 		head = &bp->ntp_fltr_hash_tbl[i];
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(fltr, head, hash) {
-			if (fltr->sw_id == fs->location)
+		hlist_for_each_entry_rcu(fltr, head, base.hash) {
+			if (fltr->base.sw_id == fs->location)
 				goto fltr_found;
 		}
 		rcu_read_unlock();
@@ -1107,7 +1107,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		fs->m_u.tcp_ip6_spec.pdst = cpu_to_be16(~0);
 	}
 
-	fs->ring_cookie = fltr->rxq;
+	fs->ring_cookie = fltr->base.rxq;
 	rc = 0;
 
 fltr_err:
-- 
2.30.1


--000000000000d69d4c060d25ae68
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMJXDLzRcfRY1GeCv69tycrjZGh5ZIV0
5mo/nmJ1JpbaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjIzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCWgMVQx3v9NRW+RBhJHXPIlOzbqJ3oIwW3V+xphl8kvivEncaV
IRn41lOvsBAqi3RMAAMjZMYYYJnCHRHXdtdQ+/Pim91rJdAw4xHRRUer33kb9jnONKwUfX/Gb3L+
RAQ8jHJkx7PKr8Ao9mOsqTI43sx5FmE2q0JysAi0LLCocuAYqkgOm63ixlgnRoGirG4G4LC712WL
1kczt8iiByFWp1ZRyKYuezZAGhCNmdjlghZAAuXQx7bR2xdoHf8FvK1rBytsuTSee2YDy2/uJBsE
+/bKnREVCgyBtYYl4Wtd6MLMKV/2S/d8fq6cZf54+kMJtQBUfinlLU8RBHzgqoBk
--000000000000d69d4c060d25ae68--

