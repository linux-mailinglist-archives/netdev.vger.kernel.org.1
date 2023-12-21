Return-Path: <netdev+bounces-59798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3C81C0BE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB61F236FE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C179485;
	Thu, 21 Dec 2023 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GxUfd6eU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD778E96
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f91d48863so1870046d6.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 14:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703196190; x=1703800990; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8gGcfNNc2KAPI3HEk9A1doa8CGHlSv5HW4n1p8PaIw=;
        b=GxUfd6eUEpLa3He7eztwYv9VnZd1VFPnev2Ij99WumLNeupa0vI3ue9w4JlzMd4rGr
         MvN1PNakXAVJrVnwDYczef2V7sud54+1Ce22p6PUB1e+tzdvI21HrDFOei6kor85cpHb
         trRFqsRE38UsLhYcXK8jVAhlEVQ5hPA+7Vw2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196190; x=1703800990;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8gGcfNNc2KAPI3HEk9A1doa8CGHlSv5HW4n1p8PaIw=;
        b=mcEOPofwh52cPn4G0lvHZoDX0Xms5mW8RGPYJ5hIIXHF0jiD/jPPfomiO8kqXv9LMx
         uksCZuefSHQAY5Kg1xNjv0vv5tvSFlnhRvhiBO1DAUsrWHzPHnO8h9fjj5hLsm+lAmfA
         uZxM3EguvzImmQlS77Ya1JNICYZIlnZW6Ki15Oh8jhijsUhv6gItw6k9XV5Yw86DkHjt
         CXcQzFgl6xlh/13dNyGxKlu3gHKP163eMq5DjCpI742ZwYTqeZZcEq8lKBVc+sji0y64
         taJV7qWwNvB0shcbO6sSVr01zFS6mdwQ2TO9imtNOceV2ZiCe+YpkS2CkdzcZsquVyd+
         zXVw==
X-Gm-Message-State: AOJu0Yze6HHsCX8lN1NocV1/BQyDZTVO+a74WZyfY0vOAfjFSuUA94ip
	Vy3b7bcyC9W8bA5TnXRRs3Nxun/SnUXRud4PTURmgqD2FQ==
X-Google-Smtp-Source: AGHT+IE69cprUHrb8APYVFl/GgChehUQNievYpvtZSeFQiI2dnf6Msq/mv9XIYoYbw3E7aJSjylbiw==
X-Received: by 2002:ad4:5d6c:0:b0:67f:35bc:8e68 with SMTP id fn12-20020ad45d6c000000b0067f35bc8e68mr553027qvb.11.1703196190553;
        Thu, 21 Dec 2023 14:03:10 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ee14-20020a0562140a4e00b0067f712874fbsm905198qvb.129.2023.12.21.14.03.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 14:03:10 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 08/13] bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().
Date: Thu, 21 Dec 2023 14:02:13 -0800
Message-Id: <20231221220218.197386-9-michael.chan@broadcom.com>
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
	boundary="000000000000f1756b060d0c435d"

--000000000000f1756b060d0c435d
Content-Transfer-Encoding: 8bit

Add a new function bnxt_insert_ntp_filter() to insert the ntuple filter
into the hash table and other basic setup.  We'll use this function
to insert a user defined filter from ethtool.

Also, export bnxt_lookup_ntp_filter_from_idx() and bnxt_get_ntp_filter_idx()
for similar purposes.  All ntuple related functions are now no longer
compiled only for CONFIG_RFS_ACCEL

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 87 +++++++++--------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++
 2 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 16eae3bd90e5..f5d6c746f677 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4800,7 +4800,6 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 
 static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int i;
 
 	/* Under rtnl_lock and all our NAPIs have been disabled.  It's
@@ -4828,12 +4827,10 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 	bitmap_free(bp->ntp_fltr_bmap);
 	bp->ntp_fltr_bmap = NULL;
 	bp->ntp_fltr_count = 0;
-#endif
 }
 
 static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int i, rc = 0;
 
 	if (!(bp->flags & BNXT_FLAG_RFS) || bp->ntp_fltr_bmap)
@@ -4849,9 +4846,6 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 		rc = -ENOMEM;
 
 	return rc;
-#else
-	return 0;
-#endif
 }
 
 static void bnxt_free_l2_filters(struct bnxt *bp, bool all)
@@ -5611,7 +5605,6 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 	return rc;
 }
 
-#ifdef CONFIG_RFS_ACCEL
 static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 					    struct bnxt_ntuple_filter *fltr)
 {
@@ -5715,7 +5708,6 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	hwrm_req_drop(bp, req);
 	return rc;
 }
-#endif
 
 static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 				     const u8 *mac_addr)
@@ -9673,7 +9665,6 @@ static int bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
 
 static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int i, rc = 0;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
@@ -9702,9 +9693,6 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 			break;
 	}
 	return rc;
-#else
-	return 0;
-#endif
 }
 
 /* Allow PF, trusted VFs and VFs with default VLAN to be in promiscuous mode */
@@ -10032,7 +10020,6 @@ static int bnxt_setup_int_mode(struct bnxt *bp)
 	return rc;
 }
 
-#ifdef CONFIG_RFS_ACCEL
 static unsigned int bnxt_get_max_func_rss_ctxs(struct bnxt *bp)
 {
 	return bp->hw_resc.max_rsscos_ctxs;
@@ -10042,7 +10029,6 @@ static unsigned int bnxt_get_max_func_vnics(struct bnxt *bp)
 {
 	return bp->hw_resc.max_vnics;
 }
-#endif
 
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp)
 {
@@ -12156,7 +12142,6 @@ static bool bnxt_rfs_supported(struct bnxt *bp)
 /* If runtime conditions support RFS */
 static bool bnxt_rfs_capable(struct bnxt *bp)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int vnics, max_vnics, max_rss_ctxs;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
@@ -12192,9 +12177,6 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	netdev_warn(bp->dev, "Unable to reserve resources to support NTUPLE filters.\n");
 	bnxt_hwrm_reserve_rings(bp, 0, 0, 0, 0, 0, 1);
 	return false;
-#else
-	return false;
-#endif
 }
 
 static netdev_features_t bnxt_fix_features(struct net_device *dev,
@@ -13857,8 +13839,8 @@ static int bnxt_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
-static u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
-				   const struct sk_buff *skb)
+u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
+			    const struct sk_buff *skb)
 {
 	struct bnxt_vnic_info *vnic;
 
@@ -13869,7 +13851,30 @@ static u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
 	return bnxt_toeplitz(bp, fkeys, (void *)vnic->rss_hash_key);
 }
 
-#ifdef CONFIG_RFS_ACCEL
+int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
+			   u32 idx)
+{
+	struct hlist_head *head;
+	int bit_id;
+
+	spin_lock_bh(&bp->ntp_fltr_lock);
+	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, BNXT_MAX_FLTR, 0);
+	if (bit_id < 0) {
+		spin_unlock_bh(&bp->ntp_fltr_lock);
+		return -ENOMEM;
+	}
+
+	fltr->base.sw_id = (u16)bit_id;
+	fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
+	fltr->base.flags |= BNXT_ACT_RING_DST;
+	head = &bp->ntp_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hash, head);
+	set_bit(BNXT_FLTR_INSERTED, &fltr->base.state);
+	bp->ntp_fltr_count++;
+	spin_unlock_bh(&bp->ntp_fltr_lock);
+	return 0;
+}
+
 static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 			    struct bnxt_ntuple_filter *f2)
 {
@@ -13900,7 +13905,7 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 	return false;
 }
 
-static struct bnxt_ntuple_filter *
+struct bnxt_ntuple_filter *
 bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
 				struct bnxt_ntuple_filter *fltr, u32 idx)
 {
@@ -13915,6 +13920,7 @@ bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
 	return NULL;
 }
 
+#ifdef CONFIG_RFS_ACCEL
 static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 			      u16 rxq_index, u32 flow_id)
 {
@@ -13923,8 +13929,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	struct flow_keys *fkeys;
 	struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
 	struct bnxt_l2_filter *l2_fltr;
-	int rc = 0, idx, bit_id;
-	struct hlist_head *head;
+	int rc = 0, idx;
 	u32 flags;
 
 	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
@@ -13977,7 +13982,6 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	new_fltr->l2_fltr = l2_fltr;
 
 	idx = bnxt_get_ntp_filter_idx(bp, fkeys, skb);
-	head = &bp->ntp_fltr_hash_tbl[idx];
 	rcu_read_lock();
 	fltr = bnxt_lookup_ntp_filter_from_idx(bp, new_fltr, idx);
 	if (fltr) {
@@ -13987,33 +13991,20 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	}
 	rcu_read_unlock();
 
-	spin_lock_bh(&bp->ntp_fltr_lock);
-	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, BNXT_MAX_FLTR, 0);
-	if (bit_id < 0) {
-		spin_unlock_bh(&bp->ntp_fltr_lock);
-		rc = -ENOMEM;
-		goto err_free;
-	}
-
-	new_fltr->base.sw_id = (u16)bit_id;
 	new_fltr->flow_id = flow_id;
 	new_fltr->base.rxq = rxq_index;
-	new_fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
-	new_fltr->base.flags = BNXT_ACT_RING_DST;
-	hlist_add_head_rcu(&new_fltr->base.hash, head);
-	set_bit(BNXT_FLTR_INSERTED, &new_fltr->base.state);
-	bp->ntp_fltr_count++;
-	spin_unlock_bh(&bp->ntp_fltr_lock);
-
-	bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
-
-	return new_fltr->base.sw_id;
+	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
+	if (!rc) {
+		bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
+		return new_fltr->base.sw_id;
+	}
 
 err_free:
 	bnxt_del_l2_filter(bp, l2_fltr);
 	kfree(new_fltr);
 	return rc;
 }
+#endif
 
 static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 {
@@ -14066,14 +14057,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 }
 
-#else
-
-static void bnxt_cfg_ntp_filters(struct bnxt *bp)
-{
-}
-
-#endif /* CONFIG_RFS_ACCEL */
-
 static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 				    unsigned int entry, struct udp_tunnel_info *ti)
 {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 867cab036e13..73e2fe705caf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2678,6 +2678,12 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc);
+struct bnxt_ntuple_filter *bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
+				struct bnxt_ntuple_filter *fltr, u32 idx);
+u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
+			    const struct sk_buff *skb);
+int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
+			   u32 idx);
 int bnxt_get_max_rings(struct bnxt *, int *, int *, bool);
 int bnxt_restore_pf_fw_resources(struct bnxt *bp);
 int bnxt_get_port_parent_id(struct net_device *dev,
-- 
2.30.1


--000000000000f1756b060d0c435d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBLoWV/dH/12s1xD0eyXVzVubh8G3l2e
HzWVqpmF6ypKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MTIyMDMxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBRvVbmn3S28ZIAtiEzVPp5vLZ9xSq8EG3AXnJ9ad7/6B8N5krj
VmS/ICOwkTmvafEEt6KAPrdpPBfZd5Kwpk9E0uGGXCdABtpYAzKUiBB3/Qit13omM2ShvAqsgyBH
vKfM0fQBAc/WQFFhauc3g87wa8nhXntCo+39hXYh5nqKjDq5IOBcbedmAHRLVswvhB6eAC+hCuKC
3SW2CKDtUrTWESRPS0RetChtMXZZptHPMhBS4XRGPX5eJ7QDzRAaguxw//cvVll4dLqThui204po
k3S4ANkPDzTC9HxFuD3tn1tSgxde1yPv1O09UovpoLZNWel2XScVu1MouGJKjXOx
--000000000000f1756b060d0c435d--

