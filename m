Return-Path: <netdev+bounces-217823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C0B39EA4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B92E17D382
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC0314B9C;
	Thu, 28 Aug 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cPna2CdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC7314B90
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387180; cv=none; b=ZojWC7OJGXImje1jN6l5vMnLuE9wqG/2RsuE7L8mWrPhOx0syyxxel1SMZC1AHY6kLOYO+XLFe+NLCjNaJBqa8nDcRlsUr8fyph322zaB3fMykjr3ISSPx0RK6dISjJw587Qd/FgdOQ/YmFrQtPM5C6dscSOYne3UcwVWdisybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387180; c=relaxed/simple;
	bh=RbKcN8+Od4rkeuv1f/gfVyGuOe+r4GLXLkJF5bJuNMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leqiEQ9GyIctpJrz6qMQH43xjmjriE20G2IMMYo22vJAASypZfUKqzSxBOYCCQNcbB6eCY9KzgVp/QcfglNTqOzwmqLiJu2Vmz58G5yYLiGfzDDO6r66WhR3SXHutlyYBfE+D/dqxj0eqi0UqVROshAs6PX9x4JIgL2m+WCLdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cPna2CdN; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-89018ea8f7cso477325241.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387177; x=1756991977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4+Pb6ANGRv9VcMh/z/Rm5dAdtsTvQuQgajANFmntgY=;
        b=v33wrxYsUm/910EGie4+We56RvFVDWEylIwO9r1JF+feT0d1Qiw35Wll/9Fd+g9csq
         kzjYj8f2csWV5vFN+wm6LoqlW5x8M/zhpm29m8hWKkjZ7FM7HnFfKBb/XR900P0HT9tj
         600EiTPqm4QrUP7r8ZO+mfOOe/NDGwNsMjDbLhzRqSERYKj9/fkcCsb/+0+qRXzvDvA5
         QO0GVc/IIqFQQ1xQSFaCc6a099FtsBpWwzrVHAPSS12VqSblu09A3tB+vZQn1MTXnxDG
         pHwIvSEuyt/FvCiZJH2FZdXLkr/q4bzONvtFgACpUKyCYJab8WGk5xgyRXT3vvvpnpbq
         xk/Q==
X-Gm-Message-State: AOJu0YzdLnnD0wE7D/eErp0ltZarCyJW5F1JD9Wqt4YKxIIw01akgRYI
	9eO7XpIu/5rn7lGHs6Ln1LhMFnThtJI0G5q+z18NRVbCH4gBFz4R2l5GY5IJTiPb56hNEjTiN6R
	1mzT6LPh1ZEij3N5HeKQcTQ5CSBfhz5EIN+hSrZngkMBQIMQV9Sho9A7x+lW3FTsfP8TBOtpVRQ
	y+D6kXra5W2cMr99dCsgfI8LvYCIjhqrlsC6URDrMdngADn+y3Ek5SGkzslw53SGeqZWxsLJ5QH
	5KZwDtb8SLxUPEOnA==
X-Gm-Gg: ASbGncs2EtmEC27ErMg8VC67AFVDxz64ya0Gdf3yDlE0MPVckHAaTpBlH0+NAam4xtB
	FZ12VBxVprMEOPYfDdY2odRnsyyWQ0eVLT7+ojF/Qa95qFWlPQyPZm0wt0VzpWS4U4xmwHizt6G
	hyCOzWLxwbOs4qKN9321NHb5R9G2rvG0R0WAjrbAvkmZs/ZsvsDS62OpSk2WSlwkW8U+Wzezm4N
	yHYvBOH/Xj1+w1MV9OSEeqhAcB3UH6D73A9cU4t9pBEodBPdGIONQVwde/6efNRq7K6g6CpsvzK
	51WybSf1TTgEbriV62eaPa18yDGiapr/V6HSUo8qQPhjBgffvPbiz3Tk0GWlbaz5Wq+l+TyjmfR
	HcmpVI8MAgV7kA3580yPNTlySmUo8jWWSjJHdLlS/oXUicf4QBGGesUEttkri01V6ax9dv0uEA1
	y7iL/s/A==
X-Google-Smtp-Source: AGHT+IESOlpYOQZsUTdGUGqWLx9PaJKJCH64mzAamcHVem5gLiW5OyNoNb2S4x20IkqX+k+82L959P9dwF8G
X-Received: by 2002:a05:6102:54a8:b0:525:9f17:9e55 with SMTP id ada2fe7eead31-5259f17a499mr2264366137.32.1756387176649;
        Thu, 28 Aug 2025 06:19:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-51e4b1abf8esm291253137.2.2025.08.28.06.19.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c72281674so177407a12.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387175; x=1756991975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4+Pb6ANGRv9VcMh/z/Rm5dAdtsTvQuQgajANFmntgY=;
        b=cPna2CdN8T6MIaeYwBAtF39JlgATzWXgvba8W770RjQhuctiVEoZzIdh4ETA0inQep
         wski+7zUpnQmjlZxf71ZpB4U6O/MwTj0/7ovD4Wl2lsVJ52/SpANPpPgGzD14jo343Rv
         uVHU91bY543DWXqmwziQGQqu4zmbSK9LMnChA=
X-Received: by 2002:a17:903:1b47:b0:246:9a64:8cbe with SMTP id d9443c01a7336-2469a648de7mr215922475ad.36.1756387175087;
        Thu, 28 Aug 2025 06:19:35 -0700 (PDT)
X-Received: by 2002:a17:903:1b47:b0:246:9a64:8cbe with SMTP id d9443c01a7336-2469a648de7mr215922045ad.36.1756387174568;
        Thu, 28 Aug 2025 06:19:34 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:33 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 9/9] bng_en: Configure default VNIC
Date: Thu, 28 Aug 2025 18:45:47 +0000
Message-ID: <20250828184547.242496-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add functions to add a filter to the VNIC to configure unicast
addresses. Also, add multicast, broadcast, and promiscuous settings
to the default VNIC.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  72 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   4 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 271 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  41 +++
 4 files changed, 388 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index fd54c72b0ad0..f4ef27c307ab 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -854,6 +854,78 @@ void bnge_hwrm_update_rss_hash_cfg(struct bnge_net *bn)
 	bnge_hwrm_req_drop(bd, req);
 }
 
+int bnge_hwrm_l2_filter_free(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_free_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_FILTER_FREE);
+	if (rc)
+		return rc;
+
+	req->l2_filter_id = fltr->base.filter_id;
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_alloc_output *resp;
+	struct hwrm_cfa_l2_filter_alloc_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_FILTER_ALLOC);
+	if (rc)
+		return rc;
+
+	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
+
+	req->flags |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
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
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		fltr->base.filter_id = resp->l2_filter_id;
+
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_cfa_l2_set_rx_mask(struct bnge_dev *bd,
+				 struct bnge_vnic_info *vnic)
+{
+	struct hwrm_cfa_l2_set_rx_mask_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_SET_RX_MASK);
+	if (rc)
+		return rc;
+
+	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+	if (vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_MCAST) {
+		req->num_mc_entries = cpu_to_le32(vnic->mc_list_count);
+		req->mc_tbl_addr = cpu_to_le64(vnic->mc_list_mapping);
+	}
+	req->mask = cpu_to_le32(vnic->rx_mask);
+	return bnge_hwrm_req_send_silent(bd, req);
+}
+
 int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 			 unsigned int nr_rings)
 {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 09517ffb1a21..042f28e84a05 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -43,6 +43,10 @@ int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 void bnge_hwrm_vnic_free_one(struct bnge_dev *bd, struct bnge_vnic_info *vnic);
 void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
 				 struct bnge_vnic_info *vnic, u16 ctx_idx);
+int bnge_hwrm_l2_filter_free(struct bnge_dev *bd, struct bnge_l2_filter *fltr);
+int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr);
+int bnge_hwrm_cfa_l2_set_rx_mask(struct bnge_dev *bd,
+				 struct bnge_vnic_info *vnic);
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 04635ade94ea..c92e521d10bf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1511,6 +1511,231 @@ static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	return rc;
 }
 
+static void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+{
+	if (!refcount_dec_and_test(&fltr->refcnt))
+		return;
+	hlist_del_rcu(&fltr->base.hash);
+	kfree_rcu(fltr, base.rcu);
+}
+
+static int bnge_init_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr,
+			       struct bnge_l2_key *key, u32 idx)
+{
+	struct hlist_head *head;
+
+	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
+	fltr->l2_key.vlan = key->vlan;
+	fltr->base.type = BNGE_FLTR_TYPE_L2;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hash, head);
+	refcount_set(&fltr->refcnt, 1);
+	return 0;
+}
+
+static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
+						      struct bnge_l2_key *key,
+						      u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+	struct hlist_head *head;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_for_each_entry_rcu(fltr, head, base.hash) {
+		struct bnge_l2_key *l2_key = &fltr->l2_key;
+
+		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
+		    l2_key->vlan == key->vlan)
+			return fltr;
+	}
+	return NULL;
+}
+
+static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+						    struct bnge_l2_key *key,
+						    u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+
+	rcu_read_lock();
+	fltr = __bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		refcount_inc(&fltr->refcnt);
+	rcu_read_unlock();
+	return fltr;
+}
+
+static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
+						   struct bnge_l2_key *key,
+						   gfp_t gfp)
+{
+	struct bnge_l2_filter *fltr;
+	u32 idx;
+	int rc;
+
+	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
+	      BNGE_L2_FLTR_HASH_MASK;
+	fltr = bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		return fltr;
+
+	fltr = kzalloc(sizeof(*fltr), gfp);
+	if (!fltr)
+		return ERR_PTR(-ENOMEM);
+	rc = bnge_init_l2_filter(bn, fltr, key, idx);
+	if (rc) {
+		bnge_del_l2_filter(bn, fltr);
+		fltr = ERR_PTR(rc);
+	}
+	return fltr;
+}
+
+static int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
+				     const u8 *mac_addr)
+{
+	struct bnge_l2_filter *fltr;
+	struct bnge_l2_key key;
+	int rc;
+
+	ether_addr_copy(key.dst_mac_addr, mac_addr);
+	key.vlan = 0;
+	fltr = bnge_alloc_l2_filter(bn, &key, GFP_KERNEL);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
+	fltr->base.fw_vnic_id = bn->vnic_info[vnic_id].fw_vnic_id;
+	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
+	if (rc)
+		bnge_del_l2_filter(bn, fltr);
+	else
+		bn->vnic_info[vnic_id].l2_filters[idx] = fltr;
+	return rc;
+}
+
+static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct netdev_hw_addr *ha;
+	int mc_count = 0, off = 0;
+	bool update = false;
+	u8 *haddr;
+
+	netdev_for_each_mc_addr(ha, dev) {
+		if (mc_count >= BNGE_MAX_MC_ADDRS) {
+			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+			vnic->mc_list_count = 0;
+			return false;
+		}
+		haddr = ha->addr;
+		if (!ether_addr_equal(haddr, vnic->mc_list + off)) {
+			memcpy(vnic->mc_list + off, haddr, ETH_ALEN);
+			update = true;
+		}
+		off += ETH_ALEN;
+		mc_count++;
+	}
+	if (mc_count)
+		*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_MCAST;
+
+	if (mc_count != vnic->mc_list_count) {
+		vnic->mc_list_count = mc_count;
+		update = true;
+	}
+	return update;
+}
+
+static bool bnge_uc_list_updated(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct netdev_hw_addr *ha;
+	int off = 0;
+
+	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+		return true;
+
+	netdev_for_each_uc_addr(ha, dev) {
+		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
+			return true;
+
+		off += ETH_ALEN;
+	}
+	return false;
+}
+
+static bool bnge_promisc_ok(struct bnge_net *bn)
+{
+	return true;
+}
+
+static int bnge_cfg_def_vnic(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	struct netdev_hw_addr *ha;
+	int i, off = 0, rc;
+	bool uc_update;
+
+	netif_addr_lock_bh(dev);
+	uc_update = bnge_uc_list_updated(bn);
+	netif_addr_unlock_bh(dev);
+
+	if (!uc_update)
+		goto skip_uc;
+
+	for (i = 1; i < vnic->uc_filter_count; i++) {
+		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
+
+		bnge_hwrm_l2_filter_free(bd, fltr);
+		bnge_del_l2_filter(bn, fltr);
+	}
+
+	vnic->uc_filter_count = 1;
+
+	netif_addr_lock_bh(dev);
+	if (netdev_uc_count(dev) > (BNGE_MAX_UC_ADDRS - 1)) {
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+	} else {
+		netdev_for_each_uc_addr(ha, dev) {
+			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
+			off += ETH_ALEN;
+			vnic->uc_filter_count++;
+		}
+	}
+	netif_addr_unlock_bh(dev);
+
+	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
+		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
+		if (rc) {
+			netdev_err(dev, "HWRM vnic filter failure rc: %d\n", rc);
+			vnic->uc_filter_count = i;
+			return rc;
+		}
+	}
+
+skip_uc:
+	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
+	    !bnge_promisc_ok(bn))
+		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+	rc = bnge_hwrm_cfa_l2_set_rx_mask(bd, vnic);
+	if (rc && (vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_MCAST)) {
+		netdev_info(dev, "Failed setting MC filters rc: %d, turning on ALL_MCAST mode\n",
+			    rc);
+		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_MCAST;
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+		vnic->mc_list_count = 0;
+		rc = bnge_hwrm_cfa_l2_set_rx_mask(bd, vnic);
+	}
+	if (rc)
+		netdev_err(dev, "HWRM cfa l2 rx mask failure rc: %d\n",
+			   rc);
+
+	return rc;
+}
+
 static void bnge_hwrm_vnic_free(struct bnge_net *bn)
 {
 	int i;
@@ -1534,11 +1759,27 @@ static void bnge_hwrm_vnic_ctx_free(struct bnge_net *bn)
 	bn->rsscos_nr_ctxs = 0;
 }
 
+static void bnge_hwrm_clear_vnic_filter(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	int i;
+
+	for (i = 0; i < vnic->uc_filter_count; i++) {
+		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
+
+		bnge_hwrm_l2_filter_free(bn->bd, fltr);
+		bnge_del_l2_filter(bn, fltr);
+	}
+
+	vnic->uc_filter_count = 0;
+}
+
 static void bnge_clear_vnic(struct bnge_net *bn)
 {
 	if (!bn->vnic_info)
 		return;
 
+	bnge_hwrm_clear_vnic_filter(bn);
 	bnge_hwrm_vnic_free(bn);
 	bnge_hwrm_vnic_ctx_free(bn);
 }
@@ -1783,6 +2024,36 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
+	/* Filter for default vnic 0 */
+	rc = bnge_hwrm_set_vnic_filter(bn, 0, 0, bn->netdev->dev_addr);
+	if (rc) {
+		netdev_err(bn->netdev, "HWRM vnic filter failure rc: %d\n", rc);
+		goto err_out;
+	}
+	vnic->uc_filter_count = 1;
+
+	vnic->rx_mask = 0;
+
+	if (bn->netdev->flags & IFF_BROADCAST)
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
+
+	if (bn->netdev->flags & IFF_PROMISC)
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+
+	if (bn->netdev->flags & IFF_ALLMULTI) {
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+		vnic->mc_list_count = 0;
+	} else if (bn->netdev->flags & IFF_MULTICAST) {
+		u32 mask = 0;
+
+		bnge_mc_list_updated(bn, &mask);
+		vnic->rx_mask |= mask;
+	}
+
+	rc = bnge_cfg_def_vnic(bn);
+	if (rc)
+		goto err_out;
+
 	return 0;
 err_out:
 	bnge_hwrm_resource_free(bn, 0);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index f5b1a6360f50..8f1e7080d770 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -6,6 +6,7 @@
 
 #include <linux/bnxt/hsi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/refcount.h>
 #include "bnge_db.h"
 
 struct tx_bd {
@@ -383,6 +384,10 @@ struct bnge_vnic_info {
 #define BNGE_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u16		mru;
+#define BNGE_MAX_UC_ADDRS	4
+	/* index 0 always dev_addr */
+	struct bnge_l2_filter *l2_filters[BNGE_MAX_UC_ADDRS];
+	u16		uc_filter_count;
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -394,6 +399,7 @@ struct bnge_vnic_info {
 #define BNGE_RSS_TABLE_MAX_TBL		8
 #define BNGE_MAX_RSS_TABLE_SIZE			\
 	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+	u32		rx_mask;
 
 	u8		*mc_list;
 	int		mc_list_size;
@@ -408,6 +414,41 @@ struct bnge_vnic_info {
 	u32		vnic_id;
 };
 
+struct bnge_filter_base {
+	struct hlist_node	hash;
+	struct list_head	list;
+	__le64			filter_id;
+	u8			type;
+#define BNGE_FLTR_TYPE_L2	2
+	u8			flags;
+	u16			rxq;
+	u16			fw_vnic_id;
+	u16			vf_idx;
+	unsigned long		state;
+#define BNGE_FLTR_VALID		0
+#define BNGE_FLTR_FW_DELETED	2
+
+	struct rcu_head         rcu;
+};
+
+struct bnge_l2_key {
+	union {
+		struct {
+			u8	dst_mac_addr[ETH_ALEN];
+			u16	vlan;
+		};
+		u32	filter_key;
+	};
+};
+
+#define BNGE_L2_KEY_SIZE	(sizeof(struct bnge_l2_key) / 4)
+struct bnge_l2_filter {
+	/* base filter must be the first member */
+	struct bnge_filter_base	base;
+	struct bnge_l2_key	l2_key;
+	refcount_t		refcnt;
+};
+
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 int bnge_get_nr_rss_ctxs(int rx_rings);
-- 
2.47.3


