Return-Path: <netdev+bounces-73466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF185CBAF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86E11C21C68
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347C154C15;
	Tue, 20 Feb 2024 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gmF3r3pJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3B154C0E
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470237; cv=none; b=MjyBm4rt1YnHegx+TGQU6J/BN1DJverPvzVncA0PmKjzpBvfQhS6bjAJjGjjCGNvN6CPO8qrpqiMK+b7qtAV0eAHPkHV6ZGEYluDqIYuHc+Fu1aB8iuZgXUhQUyaA+9+dk7iAFJGCgiqjRHKoOGWCHgGLegBV3S/MCElTiCmF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470237; c=relaxed/simple;
	bh=w4Nl9sHHKsuyYm3brdsL9kmui3o6RADEGnyaUqJ93QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJrNnFo63XqvivJ9UOU22r2CBsqKV0IhBdMTKzJsZY8JBFRTEH18pKZ0lcBwIMRBHMZUHtY9uLvQWV/HzxfqQFrw1hp8xtCGMDJ/8JR01URjqWUKNgvliJvGIg1PHwrFbaMc4Fkhs/sPgeCi/pvIlkQnKSkK0GSc1iNVoRoOBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gmF3r3pJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-781753f52afso343051285a.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470234; x=1709075034; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGQIYjEJxbGPZDM4ujdjmNENn+YM3XOr23MWC+kDCBM=;
        b=gmF3r3pJJsxjq7dp/lcmRgKaOaz19i7MPGK8AEd9U5XRIyIDXfxL62zyBqQevw+B/2
         X41gCghN9sweH4vt39ozI1ikJ4e3teECX8ufOmohCc1U3R3oomjipWRv6EVzGyrNU5Cs
         PBnI7CiqanVYyKBzeKXv4YCtjnAluQCSQRI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470234; x=1709075034;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGQIYjEJxbGPZDM4ujdjmNENn+YM3XOr23MWC+kDCBM=;
        b=pDlhwUT/6gI20QGNVhuT+krPoo4Krt7ZVJ2CVlhBs6V+Rr/L+Lv9NIHzp49prl5cn8
         VHstyahy3bpXyzY2TzI2BpcE2MSiODJHyMB5SDB6LZPTllAt7EGUE26W6V2c+uV1A/JF
         9QJ4JUt8bvLuWoNnItzHDzbIg4C5Qiyo2fe1oikHQcideImoGteQLZSD4k8tDS0/7qJ1
         DXRRhapXD1o/1t9SJK1z6RWTq/19m7gor+65PHrxQ7sqeBrBIX7fcOMEjf5PAiKdxKFC
         O18QtOHA3dTVkE3vmLIxA1PqQAWpIBgqN0gckkvBPBe1ABMMhMJTJTLp5ygF8jrMQ2Sm
         bNWw==
X-Gm-Message-State: AOJu0Yy31k5UiwiQP+QA9fnXRefN4GgX3Uvij8AFkrGAomMNzUJJyyw1
	DPUoW7MvnqT7mPxcPmwGnjOmMlzfK17gy2upuvBe9zwv47fNfOdPIm5qpUQhkw==
X-Google-Smtp-Source: AGHT+IGwBr7id8EbyRYXheaAuDToLybRpu48ry14WZeEareJyeJ9KoW1sGUbMvnjzxTAWwWi1ccXuA==
X-Received: by 2002:a05:620a:34a:b0:787:2b66:a088 with SMTP id t10-20020a05620a034a00b007872b66a088mr18134122qkm.1.1708470233994;
        Tue, 20 Feb 2024 15:03:53 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:53 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 07/10] bnxt_en: Define BNXT_VNIC_DEFAULT for the default vnic index
Date: Tue, 20 Feb 2024 15:03:14 -0800
Message-Id: <20240220230317.96341-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240220230317.96341-1-michael.chan@broadcom.com>
References: <20240220230317.96341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007471320611d839a5"

--0000000000007471320611d839a5
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Replace hard coded 0 index with more meaningful BNXT_VNIC_DEFAULT.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 39 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +-
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2fe5262f6c41..8877043febd2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4229,6 +4229,7 @@ static int bnxt_alloc_vnics(struct bnxt *bp)
 
 static void bnxt_init_vnics(struct bnxt *bp)
 {
+	struct bnxt_vnic_info *vnic0 = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	int i;
 
 	for (i = 0; i < bp->nr_vnics; i++) {
@@ -4242,7 +4243,7 @@ static void bnxt_init_vnics(struct bnxt *bp)
 		vnic->fw_l2_ctx_id = INVALID_HW_RING_ID;
 
 		if (bp->vnic_info[i].rss_hash_key) {
-			if (!i) {
+			if (i == BNXT_VNIC_DEFAULT) {
 				u8 *key = (void *)vnic->rss_hash_key;
 				int k;
 
@@ -4268,8 +4269,7 @@ static void bnxt_init_vnics(struct bnxt *bp)
 					bp->toeplitz_prefix |= key[k];
 				}
 			} else {
-				memcpy(vnic->rss_hash_key,
-				       bp->vnic_info[0].rss_hash_key,
+				memcpy(vnic->rss_hash_key, vnic0->rss_hash_key,
 				       HW_HASH_KEY_SIZE);
 			}
 		}
@@ -5000,6 +5000,7 @@ static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 
 static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 {
+	struct bnxt_vnic_info *vnic0 = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	int i, j, rc, size, arr_size;
 	void *bnapi;
 
@@ -5128,8 +5129,8 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 	if (rc)
 		goto alloc_mem_err;
 
-	bp->vnic_info[0].flags |= BNXT_VNIC_RSS_FLAG | BNXT_VNIC_MCAST_FLAG |
-				  BNXT_VNIC_UCAST_FLAG;
+	vnic0->flags |= BNXT_VNIC_RSS_FLAG | BNXT_VNIC_MCAST_FLAG |
+			BNXT_VNIC_UCAST_FLAG;
 	rc = bnxt_alloc_vnic_attributes(bp);
 	if (rc)
 		goto alloc_mem_err;
@@ -6178,7 +6179,7 @@ static int bnxt_hwrm_vnic_set_rss_p5(struct bnxt *bp, u16 vnic_id, bool set_rss)
 
 static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct hwrm_vnic_rss_qcfg_output *resp;
 	struct hwrm_vnic_rss_qcfg_input *req;
 
@@ -6282,6 +6283,7 @@ static u32 bnxt_get_roce_vnic_mode(struct bnxt *bp)
 
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
 {
+	struct bnxt_vnic_info *vnic0 = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_cfg_input *req;
 	unsigned int ring = 0, grp_idx;
@@ -6311,8 +6313,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
 		req->enables |= cpu_to_le32(VNIC_CFG_REQ_ENABLES_RSS_RULE |
 					   VNIC_CFG_REQ_ENABLES_MRU);
 	} else if (vnic->flags & BNXT_VNIC_RFS_NEW_RSS_FLAG) {
-		req->rss_rule =
-			cpu_to_le16(bp->vnic_info[0].fw_rss_cos_lb_ctx[0]);
+		req->rss_rule = cpu_to_le16(vnic0->fw_rss_cos_lb_ctx[0]);
 		req->enables |= cpu_to_le32(VNIC_CFG_REQ_ENABLES_RSS_RULE |
 					   VNIC_CFG_REQ_ENABLES_MRU);
 		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_RSS_DFLT_CR_MODE);
@@ -6409,7 +6410,7 @@ static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, u16 vnic_id,
 vnic_no_ring_grps:
 	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++)
 		vnic->fw_rss_cos_lb_ctx[i] = INVALID_HW_RING_ID;
-	if (vnic_id == 0)
+	if (vnic_id == BNXT_VNIC_DEFAULT)
 		req->flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_DEFAULT);
 
 	resp = hwrm_req_hold(bp, req);
@@ -9896,7 +9897,7 @@ static bool bnxt_mc_list_updated(struct bnxt *, u32 *);
 
 static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	int rc = 0;
 	unsigned int rx_nr_rings = bp->rx_nr_rings;
 
@@ -9925,7 +9926,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		rx_nr_rings--;
 
 	/* default vnic 0 */
-	rc = bnxt_hwrm_vnic_alloc(bp, 0, 0, rx_nr_rings);
+	rc = bnxt_hwrm_vnic_alloc(bp, BNXT_VNIC_DEFAULT, 0, rx_nr_rings);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic alloc failure rc: %x\n", rc);
 		goto err_out;
@@ -9934,7 +9935,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	if (BNXT_VF(bp))
 		bnxt_hwrm_func_qcfg(bp);
 
-	rc = bnxt_setup_vnic(bp, 0);
+	rc = bnxt_setup_vnic(bp, BNXT_VNIC_DEFAULT);
 	if (rc)
 		goto err_out;
 	if (bp->rss_cap & BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA)
@@ -11594,7 +11595,7 @@ static void bnxt_cfg_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr
 
 	if (fltr->type == BNXT_FLTR_TYPE_NTUPLE) {
 		ntp_fltr = container_of(fltr, struct bnxt_ntuple_filter, base);
-		l2_fltr = bp->vnic_info[0].l2_filters[0];
+		l2_fltr = bp->vnic_info[BNXT_VNIC_DEFAULT].l2_filters[0];
 		atomic_inc(&l2_fltr->refcnt);
 		ntp_fltr->l2_fltr = l2_fltr;
 		if (bnxt_hwrm_cfa_ntuple_filter_alloc(bp, ntp_fltr)) {
@@ -12148,8 +12149,8 @@ void bnxt_get_ring_err_stats(struct bnxt *bp,
 
 static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 {
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct net_device *dev = bp->dev;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
 	struct netdev_hw_addr *ha;
 	u8 *haddr;
 	int mc_count = 0;
@@ -12183,7 +12184,7 @@ static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 static bool bnxt_uc_list_updated(struct bnxt *bp)
 {
 	struct net_device *dev = bp->dev;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
@@ -12210,7 +12211,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
 		return;
 
-	vnic = &bp->vnic_info[0];
+	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	mask = vnic->rx_mask;
 	mask &= ~(CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS |
 		  CFA_L2_SET_RX_MASK_REQ_MASK_MCAST |
@@ -12241,7 +12242,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 static int bnxt_cfg_rx_mode(struct bnxt *bp)
 {
 	struct net_device *dev = bp->dev;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[0];
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int i, off = 0, rc;
 	bool uc_update;
@@ -14081,7 +14082,7 @@ u32 bnxt_get_ntp_filter_idx(struct bnxt *bp, struct flow_keys *fkeys,
 	if (skb)
 		return skb_get_hash_raw(skb) & BNXT_NTP_FLTR_HASH_MASK;
 
-	vnic = &bp->vnic_info[0];
+	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	return bnxt_toeplitz(bp, fkeys, (void *)vnic->rss_hash_key);
 }
 
@@ -14176,7 +14177,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	u32 flags;
 
 	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
-		l2_fltr = bp->vnic_info[0].l2_filters[0];
+		l2_fltr = bp->vnic_info[BNXT_VNIC_DEFAULT].l2_filters[0];
 		atomic_inc(&l2_fltr->refcnt);
 	} else {
 		struct bnxt_l2_key key;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4ff090981809..328bbf72acaf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1213,6 +1213,8 @@ struct bnxt_ring_grp_info {
 	u16	cp_fw_ring_id;
 };
 
+#define BNXT_VNIC_DEFAULT	0
+
 struct bnxt_vnic_info {
 	u16		fw_vnic_id; /* returned by Chimp during alloc */
 #define BNXT_MAX_CTX_PER_VNIC	8
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index dfb5944683f8..1d240a27455a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1314,7 +1314,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (!new_fltr)
 		return -ENOMEM;
 
-	l2_fltr = bp->vnic_info[0].l2_filters[0];
+	l2_fltr = bp->vnic_info[BNXT_VNIC_DEFAULT].l2_filters[0];
 	atomic_inc(&l2_fltr->refcnt);
 	new_fltr->l2_fltr = l2_fltr;
 	fmasks = &new_fltr->fmasks;
@@ -1763,7 +1763,7 @@ static int bnxt_get_rxfh(struct net_device *dev,
 	if (!bp->vnic_info)
 		return 0;
 
-	vnic = &bp->vnic_info[0];
+	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	if (rxfh->indir && bp->rss_indir_tbl) {
 		tbl_size = bnxt_get_rxfh_indir_size(dev);
 		for (i = 0; i < tbl_size; i++)
-- 
2.30.1


--0000000000007471320611d839a5
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF7QMqkAJ7GYaU98HApcGcMk7O+jn/+b
6BrgSEYpa8BbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBL6rqMwdmSRWf8mnGbkczO9DtbqCWXo63G4R9QrfyeQMJE+VpN
6F84IPlBqo1FAjEdI5IoAkA3ZVHjWOGSj/8wyCibIDsitzHL5cx7LO13AysMOm8nL2xaZiVv6taB
cf5s8ANcbOpf4vZ5ud9MKBoKfozqwncC/c0ktlC/Dk08iedHr8Z5IT3s6PV3VqsQ1CnJ50O66jFm
iolM61fIXhF4WxGVCSAGxB3AzAjIHm3rGjS/pIzZhUJMsP0hfhWBCPDRYhkE3u1RhViIdFyuvUVM
diQxYuMb3YacjRwgApq5ZvE7hJMGfw646YFodgxjTKJJN/BWVIKVG1taJkrUpHWJ
--0000000000007471320611d839a5--

