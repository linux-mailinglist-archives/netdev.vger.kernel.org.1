Return-Path: <netdev+bounces-60048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AC81D227
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261641C22AF8
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42224469E;
	Sat, 23 Dec 2023 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YytfycR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B14A3E
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f8d9fe99fso11710896d6.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305362; x=1703910162; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vntG+VJ9MwzzkGrqeL/xHB7Z0gMdEBgBANUl1EKMJNQ=;
        b=YytfycR2Wxs/Wd0M0gqiNvkz3zsX9WXRmXJHDcLcO74gpWD8SKdnf5xiXApA6vmgbV
         gt0olMsq3fI7XZYNysWQ0EXj/5BW/Kq0P3gGZ6DnQJxciy9hQuTl5oAXgbfcwEI22/R3
         idr7AG0ywdxTY46pxJ/LBsIj6XHPU9h+KB1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305362; x=1703910162;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vntG+VJ9MwzzkGrqeL/xHB7Z0gMdEBgBANUl1EKMJNQ=;
        b=iBLj5dQ/CmrgSQ7yTr5XHD10zll80jTGshEbSXMcgiIwyBTvALtkfbVF2qfLO9gEk/
         BbpU9gqwvKsYREGb1G4AP5/E4oRNnwZosK0XsIFuSeggogYqqPhjjOsZbJcKL4Q0vS0O
         ou3rdDRlbNHQyJIZHHFQp5p8pMp49HEtD862fvPnmZJ88Ph2XeBwq/3P61Hg0O2JTdMq
         30bnnm1Hq4/LmGGsvS7D1+FArzOgvolsDUBlilBmfGFBcbFEcxG80r48Gqc6G9SV2+LF
         R64d+J/yRGFpZu4eNOiPwSITEyJHRWhvXi6YEDQpu+LJNqvSRAjh/2bhfxaUS91PH5wB
         vkcQ==
X-Gm-Message-State: AOJu0YyXWqHuixcwAFtzR0Y6JbmPTApQRyUg4vCa6FCW6kgiv4NQz/yt
	fRlPtP6kvRJGAyiFPgU0ZG4ESTVfrUu3
X-Google-Smtp-Source: AGHT+IGwCW3Tx6pos/g8W2I8W0EkKFxldnJHL/Ac18rH2LkgUz5wT/g/p8f17W7zyubzZW11XDzV+A==
X-Received: by 2002:a05:6214:258d:b0:67f:7599:84ad with SMTP id fq13-20020a056214258d00b0067f759984admr3505153qvb.84.1703305362311;
        Fri, 22 Dec 2023 20:22:42 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:41 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 04/13] bnxt_en: Refactor L2 filter alloc/free firmware commands.
Date: Fri, 22 Dec 2023 20:22:01 -0800
Message-Id: <20231223042210.102485-5-michael.chan@broadcom.com>
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
	boundary="00000000000016199b060d25af5e"

--00000000000016199b060d25af5e
Content-Transfer-Encoding: 8bit

Refactor the L2 filter alloc/free logic so that these filters can be
added/deleted by the user.

The bp->ntp_fltr_bmap allocated size is also increased to allow enough
IDs for L2 filters.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix compile error when CONFIG_BNXT_SRIOV is disabled (reported by
    kernel test robot).
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 163 +++++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +
 2 files changed, 112 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 62e4f35c6f0f..571f2c443c2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4834,7 +4834,7 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 		INIT_HLIST_HEAD(&bp->ntp_fltr_hash_tbl[i]);
 
 	bp->ntp_fltr_count = 0;
-	bp->ntp_fltr_bmap = bitmap_zalloc(BNXT_NTP_FLTR_MAX_FLTR, GFP_KERNEL);
+	bp->ntp_fltr_bmap = bitmap_zalloc(BNXT_MAX_FLTR, GFP_KERNEL);
 
 	if (!bp->ntp_fltr_bmap)
 		rc = -ENOMEM;
@@ -5396,6 +5396,15 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
 	fltr->l2_key.vlan = key->vlan;
 	fltr->base.type = BNXT_FLTR_TYPE_L2;
+	if (fltr->base.flags) {
+		int bit_id;
+
+		bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap,
+						 BNXT_MAX_FLTR, 0);
+		if (bit_id < 0)
+			return -ENOMEM;
+		fltr->base.sw_id = (u16)bit_id;
+	}
 	head = &bp->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hash, head);
 	atomic_set(&fltr->refcnt, 1);
@@ -5429,6 +5438,96 @@ static struct bnxt_l2_filter *bnxt_alloc_l2_filter(struct bnxt *bp,
 	return fltr;
 }
 
+static u16 bnxt_vf_target_id(struct bnxt_pf_info *pf, u16 vf_idx)
+{
+#ifdef CONFIG_BNXT_SRIOV
+	struct bnxt_vf_info *vf = &pf->vf[vf_idx];
+
+	return vf->fw_fid;
+#else
+	return INVALID_HW_RING_ID;
+#endif
+}
+
+int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_free_input *req;
+	u16 target_id = 0xffff;
+	int rc;
+
+	if (fltr->base.flags & BNXT_ACT_FUNC_DST) {
+		struct bnxt_pf_info *pf = &bp->pf;
+
+		if (fltr->base.vf_idx >= pf->active_vfs)
+			return -EINVAL;
+
+		target_id = bnxt_vf_target_id(pf, fltr->base.vf_idx);
+		if (target_id == INVALID_HW_RING_ID)
+			return -EINVAL;
+	}
+
+	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_FREE);
+	if (rc)
+		return rc;
+
+	req->target_id = cpu_to_le16(target_id);
+	req->l2_filter_id = fltr->base.filter_id;
+	return hwrm_req_send(bp, req);
+}
+
+int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_alloc_output *resp;
+	struct hwrm_cfa_l2_filter_alloc_input *req;
+	u16 target_id = 0xffff;
+	int rc;
+
+	if (fltr->base.flags & BNXT_ACT_FUNC_DST) {
+		struct bnxt_pf_info *pf = &bp->pf;
+
+		if (fltr->base.vf_idx >= pf->active_vfs)
+			return -EINVAL;
+
+		target_id = bnxt_vf_target_id(pf, fltr->base.vf_idx);
+	}
+	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_ALLOC);
+	if (rc)
+		return rc;
+
+	req->target_id = cpu_to_le16(target_id);
+	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
+
+	if (!BNXT_CHIP_TYPE_NITRO_A0(bp))
+		req->flags |=
+			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
+	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
+	req->enables =
+		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
+			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_DST_ID |
+			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR_MASK);
+	ether_addr_copy(req->l2_addr, fltr->l2_key.dst_mac_addr);
+	eth_broadcast_addr(req->l2_addr_mask);
+
+	if (fltr->l2_key.vlan) {
+		req->enables |=
+			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN |
+				CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN_MASK |
+				CFA_L2_FILTER_ALLOC_REQ_ENABLES_NUM_VLANS);
+		req->num_vlans = 1;
+		req->l2_ivlan = cpu_to_le16(fltr->l2_key.vlan);
+		req->l2_ivlan_mask = cpu_to_le16(0xfff);
+	}
+
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (!rc) {
+		fltr->base.filter_id = resp->l2_filter_id;
+		set_bit(BNXT_FLTR_VALID, &fltr->base.state);
+	}
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
 #ifdef CONFIG_RFS_ACCEL
 static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 					    struct bnxt_ntuple_filter *fltr)
@@ -5538,8 +5637,6 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 				     const u8 *mac_addr)
 {
-	struct hwrm_cfa_l2_filter_alloc_output *resp;
-	struct hwrm_cfa_l2_filter_alloc_input *req;
 	struct bnxt_l2_filter *fltr;
 	struct bnxt_l2_key key;
 	int rc;
@@ -5550,66 +5647,33 @@ static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 	if (IS_ERR(fltr))
 		return PTR_ERR(fltr);
 
-	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_ALLOC);
+	fltr->base.fw_vnic_id = bp->vnic_info[vnic_id].fw_vnic_id;
+	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
 	if (rc)
-		return rc;
-
-	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
-	if (!BNXT_CHIP_TYPE_NITRO_A0(bp))
-		req->flags |=
-			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
-	req->dst_id = cpu_to_le16(bp->vnic_info[vnic_id].fw_vnic_id);
-	req->enables =
-		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
-			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_DST_ID |
-			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR_MASK);
-	memcpy(req->l2_addr, mac_addr, ETH_ALEN);
-	req->l2_addr_mask[0] = 0xff;
-	req->l2_addr_mask[1] = 0xff;
-	req->l2_addr_mask[2] = 0xff;
-	req->l2_addr_mask[3] = 0xff;
-	req->l2_addr_mask[4] = 0xff;
-	req->l2_addr_mask[5] = 0xff;
-
-	resp = hwrm_req_hold(bp, req);
-	rc = hwrm_req_send(bp, req);
-	if (rc) {
 		bnxt_del_l2_filter(bp, fltr);
-	} else {
-		fltr->base.filter_id = resp->l2_filter_id;
-		set_bit(BNXT_FLTR_VALID, &fltr->base.state);
+	else
 		bp->vnic_info[vnic_id].l2_filters[idx] = fltr;
-	}
-	hwrm_req_drop(bp, req);
 	return rc;
 }
 
 static int bnxt_hwrm_clear_vnic_filter(struct bnxt *bp)
 {
-	struct hwrm_cfa_l2_filter_free_input *req;
 	u16 i, j, num_of_vnics = 1; /* only vnic 0 supported */
-	int rc;
+	int rc = 0;
 
 	/* Any associated ntuple filters will also be cleared by firmware. */
-	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_FREE);
-	if (rc)
-		return rc;
-	hwrm_req_hold(bp, req);
 	for (i = 0; i < num_of_vnics; i++) {
 		struct bnxt_vnic_info *vnic = &bp->vnic_info[i];
 
 		for (j = 0; j < vnic->uc_filter_count; j++) {
-			struct bnxt_l2_filter *fltr;
-
-			fltr = vnic->l2_filters[j];
-			req->l2_filter_id = fltr->base.filter_id;
+			struct bnxt_l2_filter *fltr = vnic->l2_filters[j];
 
-			rc = hwrm_req_send(bp, req);
+			bnxt_hwrm_l2_filter_free(bp, fltr);
 			bnxt_del_l2_filter(bp, fltr);
 		}
 		vnic->uc_filter_count = 0;
 	}
-	hwrm_req_drop(bp, req);
+
 	return rc;
 }
 
@@ -11898,7 +11962,6 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 {
 	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
-	struct hwrm_cfa_l2_filter_free_input *req;
 	struct netdev_hw_addr *ha;
 	int i, off = 0, rc;
 	bool uc_update;
@@ -11910,19 +11973,12 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	if (!uc_update)
 		goto skip_uc;
 
-	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_FREE);
-	if (rc)
-		return rc;
-	hwrm_req_hold(bp, req);
 	for (i = 1; i < vnic->uc_filter_count; i++) {
 		struct bnxt_l2_filter *fltr = vnic->l2_filters[i];
 
-		req->l2_filter_id = fltr->base.filter_id;
-
-		rc = hwrm_req_send(bp, req);
+		bnxt_hwrm_l2_filter_free(bp, fltr);
 		bnxt_del_l2_filter(bp, fltr);
 	}
-	hwrm_req_drop(bp, req);
 
 	vnic->uc_filter_count = 1;
 
@@ -13823,8 +13879,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	rcu_read_unlock();
 
 	spin_lock_bh(&bp->ntp_fltr_lock);
-	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap,
-					 BNXT_NTP_FLTR_MAX_FLTR, 0);
+	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, BNXT_MAX_FLTR, 0);
 	if (bit_id < 0) {
 		spin_unlock_bh(&bp->ntp_fltr_lock);
 		rc = -ENOMEM;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 72e99f2a5c68..5d67b8299328 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2398,6 +2398,7 @@ struct bnxt {
 	int			db_size;
 
 #define BNXT_NTP_FLTR_MAX_FLTR	4096
+#define BNXT_MAX_FLTR		(BNXT_NTP_FLTR_MAX_FLTR + BNXT_L2_FLTR_MAX_FLTR)
 #define BNXT_NTP_FLTR_HASH_SIZE	512
 #define BNXT_NTP_FLTR_HASH_MASK	(BNXT_NTP_FLTR_HASH_SIZE - 1)
 	struct hlist_head	ntp_fltr_hash_tbl[BNXT_NTP_FLTR_HASH_SIZE];
@@ -2621,6 +2622,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
 void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr);
+int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr);
+int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
-- 
2.30.1


--00000000000016199b060d25af5e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMvOPC8vYnWe6UpN7fy2pILEn5Lol9eB
kUu/LTR6m92cMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjI0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQABHzHsHLf1fmbk8k/FHDd+1zNEispUe1SU69+WsTGAIBIR5BCk
By8rtcz4QJo3/5AzUI8SKUlGCiQ0LvNTdYOLgFFryaHP5ji9Aema513lR/2662Glk7pEdv9xox4R
IF4NsjsnwORuyzbnMHCza6fUKHh3MldD1o6ZkAgUYvhxsOukcJTn7qA+4JClEwq11hzCmrJOG5gg
H4+cQBuxqv3lE1G9gSp8Rl2pOUxIzDqfLVxsMih0m1GjrSPM6WWkcQOMxGi+5dzr681w20jXhMUQ
7KkZF93X44IjLqam6IKUcEAvoe3fC9WCZ9AggoKIMaIsQniZ/9155DTUSRqyFiKG
--00000000000016199b060d25af5e--

