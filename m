Return-Path: <netdev+bounces-60046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DC81D225
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F231C22CC7
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26246AD;
	Sat, 23 Dec 2023 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PPNsgHc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF017E4
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f9f24e7b1so6402186d6.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305360; x=1703910160; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xokg3G/Y/WJIZta5JM6RJCucBoOMfkVsjMpbpc+5CBc=;
        b=PPNsgHc2eDGGx4l8WrwBrZT94AOulyIwKH3JIGSvKBzq3J8A0YTH+Kx1rbyZjrQKwJ
         yYOs8JhHIU2zjEiMpmvJXv8hoONOz6YiBOadQqM5e5369jCnuG6Ae2NlWpS2lId6dAW+
         Ztf/zmyBsdsTVsZF30avLMB1Yq4NeVJZI3kEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305360; x=1703910160;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xokg3G/Y/WJIZta5JM6RJCucBoOMfkVsjMpbpc+5CBc=;
        b=nXEN/urer67gzHby1z8p3n86lly1vPbERKworFpizeNwuW77Q5ZOXxrobip87//i/3
         f+zL2mpxo46CDdoU5+YuAeqe8HfbGNfqPQIHw7ZNhsLr9+IAe5RCYPWx9tpX+J2XcyEq
         FheYroklU32DnwVN98fxZRa11c7zUJeYX6E4Nxi/Ms6XvOYpu2yiSEmtCPEjuNLmOaOm
         egapz9gHmAsMR3cjys6S9R/gN1hCsFXBY4sKP29pGbhdaoX0gYRA0RkAmxO3LJcMASJ0
         lizt+nHCKquQqg76D/ObP32nvDIdRISVM7MqdnQHZZ94X+dBHCEHgYGsablzCs87r9Y/
         AT1g==
X-Gm-Message-State: AOJu0Yw5HQa8DkbytCz/cJ0LLmG6Cl/tiFOMbHz7sTYNZNuDhB4I8Z/s
	pM2fIHsbO+BzO1C8mkVtvSzEdqpAhtJR
X-Google-Smtp-Source: AGHT+IElEEYAsMEdF3suJhBR7L5lwqSJOvYUkQO3Lv3lpDG9Z3NqC7GHcjJoubaL/O8tXc2Kdh6y/g==
X-Received: by 2002:ad4:5c6c:0:b0:67a:a721:caf8 with SMTP id i12-20020ad45c6c000000b0067aa721caf8mr3416058qvh.89.1703305359573;
        Fri, 22 Dec 2023 20:22:39 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:39 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 02/13] bnxt_en: Add bnxt_l2_filter hash table.
Date: Fri, 22 Dec 2023 20:21:59 -0800
Message-Id: <20231223042210.102485-3-michael.chan@broadcom.com>
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
	boundary="000000000000ed327b060d25aeab"

--000000000000ed327b060d25aeab
Content-Transfer-Encoding: 8bit

The current driver only has an array of 4 additional L2 unicast
addresses to support the netdev uc address list.  Generalize and
expand this infrastructure with an L2 address hash table so we can
support an expanded list of unicast addresses (for bridges,
macvlans, OVS, etc).  The L2 hash table infrastructure will also
allow more generalized n-tuple filter support.

This patch creates the bnxt_l2_filter structure and the hash table.
This L2 filter structure has the same bnxt_filter_base structure
as used in the bnxt_ntuple_filter structure.

All currently supported L2 filters will now have an entry in this
new table.

Note that L2 filters may be created for the VF.  VF filters should
not be freed when the PF goes down.  Add some logic in
bnxt_free_l2_filters() to allow keeping the VF filters or to free
everything during rmmod.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 175 ++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  30 +++-
 2 files changed, 191 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bf3b9b2cad76..8e9a02629450 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4789,7 +4789,7 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 	}
 }
 
-static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool irq_reinit)
+static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
 #ifdef CONFIG_RFS_ACCEL
 	int i;
@@ -4804,14 +4804,19 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool irq_reinit)
 
 		head = &bp->ntp_fltr_hash_tbl[i];
 		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
+			if (!all && (fltr->base.flags & BNXT_ACT_FUNC_DST))
+				continue;
 			hlist_del(&fltr->base.hash);
+			clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
+			bp->ntp_fltr_count--;
 			kfree(fltr);
 		}
 	}
-	if (irq_reinit) {
-		bitmap_free(bp->ntp_fltr_bmap);
-		bp->ntp_fltr_bmap = NULL;
-	}
+	if (!all)
+		return;
+
+	bitmap_free(bp->ntp_fltr_bmap);
+	bp->ntp_fltr_bmap = NULL;
 	bp->ntp_fltr_count = 0;
 #endif
 }
@@ -4821,7 +4826,7 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	int i, rc = 0;
 
-	if (!(bp->flags & BNXT_FLAG_RFS))
+	if (!(bp->flags & BNXT_FLAG_RFS) || bp->ntp_fltr_bmap)
 		return 0;
 
 	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++)
@@ -4839,6 +4844,38 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 #endif
 }
 
+static void bnxt_free_l2_filters(struct bnxt *bp, bool all)
+{
+	int i;
+
+	for (i = 0; i < BNXT_L2_FLTR_HASH_SIZE; i++) {
+		struct hlist_head *head;
+		struct hlist_node *tmp;
+		struct bnxt_l2_filter *fltr;
+
+		head = &bp->l2_fltr_hash_tbl[i];
+		hlist_for_each_entry_safe(fltr, tmp, head, base.hash) {
+			if (!all && (fltr->base.flags & BNXT_ACT_FUNC_DST))
+				continue;
+			hlist_del(&fltr->base.hash);
+			if (fltr->base.flags) {
+				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
+				bp->ntp_fltr_count--;
+			}
+			kfree(fltr);
+		}
+	}
+}
+
+static void bnxt_init_l2_fltr_tbl(struct bnxt *bp)
+{
+	int i;
+
+	for (i = 0; i < BNXT_L2_FLTR_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&bp->l2_fltr_hash_tbl[i]);
+	get_random_bytes(&bp->hash_seed, sizeof(bp->hash_seed));
+}
+
 static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 {
 	bnxt_free_vnic_attributes(bp);
@@ -4846,7 +4883,8 @@ static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 	bnxt_free_rx_rings(bp);
 	bnxt_free_cp_rings(bp);
 	bnxt_free_all_cp_arrays(bp);
-	bnxt_free_ntp_fltrs(bp, irq_re_init);
+	bnxt_free_ntp_fltrs(bp, false);
+	bnxt_free_l2_filters(bp, false);
 	if (irq_re_init) {
 		bnxt_free_ring_stats(bp);
 		if (!(bp->phy_flags & BNXT_PHY_FL_PORT_STATS_NO_RESET) ||
@@ -5290,6 +5328,92 @@ static int bnxt_hwrm_cfa_l2_set_rx_mask(struct bnxt *bp, u16 vnic_id)
 	return hwrm_req_send_silent(bp, req);
 }
 
+void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr)
+{
+	if (!atomic_dec_and_test(&fltr->refcnt))
+		return;
+	spin_lock_bh(&bp->ntp_fltr_lock);
+	hlist_del_rcu(&fltr->base.hash);
+	if (fltr->base.flags) {
+		clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
+		bp->ntp_fltr_count--;
+	}
+	spin_unlock_bh(&bp->ntp_fltr_lock);
+	kfree_rcu(fltr, base.rcu);
+}
+
+static struct bnxt_l2_filter *__bnxt_lookup_l2_filter(struct bnxt *bp,
+						      struct bnxt_l2_key *key,
+						      u32 idx)
+{
+	struct hlist_head *head = &bp->l2_fltr_hash_tbl[idx];
+	struct bnxt_l2_filter *fltr;
+
+	hlist_for_each_entry_rcu(fltr, head, base.hash) {
+		struct bnxt_l2_key *l2_key = &fltr->l2_key;
+
+		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
+		    l2_key->vlan == key->vlan)
+			return fltr;
+	}
+	return NULL;
+}
+
+static struct bnxt_l2_filter *bnxt_lookup_l2_filter(struct bnxt *bp,
+						    struct bnxt_l2_key *key,
+						    u32 idx)
+{
+	struct bnxt_l2_filter *fltr = NULL;
+
+	rcu_read_lock();
+	fltr = __bnxt_lookup_l2_filter(bp, key, idx);
+	if (fltr)
+		atomic_inc(&fltr->refcnt);
+	rcu_read_unlock();
+	return fltr;
+}
+
+static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
+			       struct bnxt_l2_key *key, u32 idx)
+{
+	struct hlist_head *head;
+
+	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
+	fltr->l2_key.vlan = key->vlan;
+	fltr->base.type = BNXT_FLTR_TYPE_L2;
+	head = &bp->l2_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hash, head);
+	atomic_set(&fltr->refcnt, 1);
+	return 0;
+}
+
+static struct bnxt_l2_filter *bnxt_alloc_l2_filter(struct bnxt *bp,
+						   struct bnxt_l2_key *key,
+						   gfp_t gfp)
+{
+	struct bnxt_l2_filter *fltr;
+	u32 idx;
+	int rc;
+
+	idx = jhash2(&key->filter_key, BNXT_L2_KEY_SIZE, bp->hash_seed) &
+	      BNXT_L2_FLTR_HASH_MASK;
+	fltr = bnxt_lookup_l2_filter(bp, key, idx);
+	if (fltr)
+		return fltr;
+
+	fltr = kzalloc(sizeof(*fltr), gfp);
+	if (!fltr)
+		return ERR_PTR(-ENOMEM);
+	spin_lock_bh(&bp->ntp_fltr_lock);
+	rc = bnxt_init_l2_filter(bp, fltr, key, idx);
+	spin_unlock_bh(&bp->ntp_fltr_lock);
+	if (rc) {
+		bnxt_del_l2_filter(bp, fltr);
+		fltr = ERR_PTR(rc);
+	}
+	return fltr;
+}
+
 #ifdef CONFIG_RFS_ACCEL
 static int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 					    struct bnxt_ntuple_filter *fltr)
@@ -5330,6 +5454,7 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	struct hwrm_cfa_ntuple_filter_alloc_output *resp;
 	struct hwrm_cfa_ntuple_filter_alloc_input *req;
 	struct flow_keys *keys = &fltr->fkeys;
+	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_vnic_info *vnic;
 	u32 flags = 0;
 	int rc;
@@ -5338,7 +5463,9 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	if (rc)
 		return rc;
 
-	req->l2_filter_id = bp->vnic_info[0].fw_l2_filter_id[fltr->l2_fltr_idx];
+	l2_fltr = bp->vnic_info[0].l2_filters[fltr->l2_fltr_idx];
+	req->l2_filter_id = l2_fltr->base.filter_id;
+
 
 	if (bp->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2) {
 		flags = CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DEST_RFS_RING_IDX;
@@ -5400,8 +5527,16 @@ static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 {
 	struct hwrm_cfa_l2_filter_alloc_output *resp;
 	struct hwrm_cfa_l2_filter_alloc_input *req;
+	struct bnxt_l2_filter *fltr;
+	struct bnxt_l2_key key;
 	int rc;
 
+	ether_addr_copy(key.dst_mac_addr, mac_addr);
+	key.vlan = 0;
+	fltr = bnxt_alloc_l2_filter(bp, &key, GFP_KERNEL);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
 	rc = hwrm_req_init(bp, req, HWRM_CFA_L2_FILTER_ALLOC);
 	if (rc)
 		return rc;
@@ -5425,9 +5560,13 @@ static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
-	if (!rc)
-		bp->vnic_info[vnic_id].fw_l2_filter_id[idx] =
-							resp->l2_filter_id;
+	if (rc) {
+		bnxt_del_l2_filter(bp, fltr);
+	} else {
+		fltr->base.filter_id = resp->l2_filter_id;
+		set_bit(BNXT_FLTR_VALID, &fltr->base.state);
+		bp->vnic_info[vnic_id].l2_filters[idx] = fltr;
+	}
 	hwrm_req_drop(bp, req);
 	return rc;
 }
@@ -5447,9 +5586,13 @@ static int bnxt_hwrm_clear_vnic_filter(struct bnxt *bp)
 		struct bnxt_vnic_info *vnic = &bp->vnic_info[i];
 
 		for (j = 0; j < vnic->uc_filter_count; j++) {
-			req->l2_filter_id = vnic->fw_l2_filter_id[j];
+			struct bnxt_l2_filter *fltr;
+
+			fltr = vnic->l2_filters[j];
+			req->l2_filter_id = fltr->base.filter_id;
 
 			rc = hwrm_req_send(bp, req);
+			bnxt_del_l2_filter(bp, fltr);
 		}
 		vnic->uc_filter_count = 0;
 	}
@@ -11759,9 +11902,12 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 		return rc;
 	hwrm_req_hold(bp, req);
 	for (i = 1; i < vnic->uc_filter_count; i++) {
-		req->l2_filter_id = vnic->fw_l2_filter_id[i];
+		struct bnxt_l2_filter *fltr = vnic->l2_filters[i];
+
+		req->l2_filter_id = fltr->base.filter_id;
 
 		rc = hwrm_req_send(bp, req);
+		bnxt_del_l2_filter(bp, fltr);
 	}
 	hwrm_req_drop(bp, req);
 
@@ -13901,6 +14047,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 
 	bnxt_ptp_clear(bp);
 	unregister_netdev(dev);
+	bnxt_free_l2_filters(bp, true);
+	bnxt_free_ntp_fltrs(bp, true);
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	/* Flush any pending tasks */
 	cancel_work_sync(&bp->sp_task);
@@ -14450,6 +14598,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_pci_clean;
 
+	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4653abbd2fe4..77c7084e47cd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1219,7 +1219,7 @@ struct bnxt_vnic_info {
 	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
 	u16		fw_l2_ctx_id;
 #define BNXT_MAX_UC_ADDRS	4
-	__le64		fw_l2_filter_id[BNXT_MAX_UC_ADDRS];
+	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
 				/* index 0 always dev_addr */
 	u16		uc_filter_count;
 	u8		*uc_list;
@@ -1349,6 +1349,8 @@ struct bnxt_filter_base {
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
 #define BNXT_FLTR_UPDATE	1
+
+	struct rcu_head         rcu;
 };
 
 struct bnxt_ntuple_filter {
@@ -1360,6 +1362,24 @@ struct bnxt_ntuple_filter {
 	u32			flow_id;
 };
 
+struct bnxt_l2_key {
+	union {
+		struct {
+			u8	dst_mac_addr[ETH_ALEN];
+			u16	vlan;
+		};
+		u32	filter_key;
+	};
+};
+
+#define BNXT_L2_KEY_SIZE	(sizeof(struct bnxt_l2_key) / 4)
+
+struct bnxt_l2_filter {
+	struct bnxt_filter_base	base;
+	struct bnxt_l2_key	l2_key;
+	atomic_t		refcnt;
+};
+
 struct bnxt_link_info {
 	u8			phy_type;
 	u8			media_type;
@@ -2388,6 +2408,13 @@ struct bnxt {
 	unsigned long		*ntp_fltr_bmap;
 	int			ntp_fltr_count;
 
+#define BNXT_L2_FLTR_MAX_FLTR	1024
+#define BNXT_L2_FLTR_HASH_SIZE	32
+#define BNXT_L2_FLTR_HASH_MASK	(BNXT_L2_FLTR_HASH_SIZE - 1)
+	struct hlist_head	l2_fltr_hash_tbl[BNXT_L2_FLTR_HASH_SIZE];
+
+	u32			hash_seed;
+
 	/* To protect link related settings during link changes and
 	 * ethtool settings changes.
 	 */
@@ -2595,6 +2622,7 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
+void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
-- 
2.30.1


--000000000000ed327b060d25aeab
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMuK651dGNKLgSA0uepV3eswuePmOmm/
RWZ36/xFMo4fMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjIzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBCggPktqYo77VZjgunemza/DZKV203m1tROzuheTctWFtO5QPR
FgjoNwtH6VRIDsbQsFd6YiBppVpfSYT18F5X69ON0GwaXjZfuZ38qgHX6+hEzYF5uHG/g6QRBYpR
JUHrTmK9EFlppDe53mNarCeM05EvOInZUT8Khtab388/5sPEpwAqu2YCvwPwK/FwoWEZQ7//j159
9fL5aUY6qUb+zBIIcpu6YwySu9m4CLZo4QtFiKLV7PYXGhyvMyTebyCd8dlXiNZ0hSH7iKT7TQfN
4AwF1BNfe0K+40kGlmCYk5JFPFbJrUpUjilyxPjmkh0uzOAow6EOqvvhs6G8M/E+
--000000000000ed327b060d25aeab--

