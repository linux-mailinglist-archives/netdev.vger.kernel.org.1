Return-Path: <netdev+bounces-214639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60126B2AAF3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B191B6752D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020033A010;
	Mon, 18 Aug 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RSLu+HrA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004623376BF
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526883; cv=none; b=bj/VYWbUHMzJdiXRiTUlmjt8IrW8Sfc1iLANm2msJoLnKWqUDLU6/miNqOaVFtlFYj1jIRWCgWTA89WKkFnxLIZn8RPJg6pqPjRkcrqVkqxhVrc1qK75S3XxpUpkF6KoimfXe+jSc4xz8vwKfbFvJawoIhRzn1AOSHLeqI9t2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526883; c=relaxed/simple;
	bh=aLlAp9bjckI+LiIP/7BuWizhzxmrJ/IfHd446Cdd0A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qu6d5oawCqp0vMxuIDsy4kkiYIdOX1pKbOA7Bvy+H6vOwreQC0VBHb1g/i0HhEIQ8TFiFpZEBrH+6qlHwfYwjDtYXOMQhaCtBqVeiiQCjxfx/TylDmZVICQWXtlCkFDtzrMJl95Q0yVwnReD6aT3pT/n+NyCdTAQotU34NDBNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RSLu+HrA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so1813253a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755526881; x=1756131681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO3e1o4BU80YLkrVIInNDSXqQSR6arEthgflDAPINIw=;
        b=RSLu+HrAcMV/NxROIy1B3+io8Zy0McdfkC5PpdLyDxGL2Q+7QbDN3kcctmZjhw1Lul
         MbSBH6brhEAspLKisJqIcnmU6KRNXzAToMc2PIQtzxpDAr8oacNXewKgoT6XR2WZ3ifd
         IoTTtB9WuJ0+D2ETL3Fus1LZHWVHDjhCVg0DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526881; x=1756131681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO3e1o4BU80YLkrVIInNDSXqQSR6arEthgflDAPINIw=;
        b=M+PabMp2TEEidm5uW3duH8/zj1PUMMlRUN5nKWOm/pQ7dBx/37c0PwbAIvT03yAg3p
         GdNPKfePdgEEZDjBny21KorZMgRJZeGapp5c4gQrxUwfpJ+u5v37MNSk+SotQyt8Cx11
         5p+4NSmtJ5oX9NbWgrFgwo5AxiIxjlLNZk2geIz0S9P3lPmOntdA5cktSRnw3BNmq/Ew
         Gl/RA/mn1DmMuYLBRr6B7mHyhKftV36GLvFwFPZeD5l6HCXPJ0AnOtb2NW4PnBjlk5Dr
         o7wNUcOn4okAwAlyexEl8rTd6x4lVf7XibbSQJiZCwTUOnWyr31FnmxnUWXXmPPYGQaZ
         aafQ==
X-Gm-Message-State: AOJu0YyDC1SDbAR4Kpii+7ZdSORmOKmbRDypFYjjCt6zNp/szKoFsRjM
	wMYDQ8Ydwijh8h9oto3KsntET7qucMFRaUxAbQ3FPf8fa8Jh0YUHpr7j3cTVwgrQZq4j9a8j2s7
	eTpdsdA==
X-Gm-Gg: ASbGnctZqosnDVCE01VnOnY+bZxHqOa7LD2EmtTe9JdllED/d8VALsi05fqX4xgP8xy
	6ur+H1UgGZK0Zg+NmkyHDQL01iDuAlIZy6Rd3Z+0TZe46LRWFJRnDtVefaMwV8LapafQQVvp8od
	B0+JbW1X4sb79HRxVXsbvA/rx5k9ofWD+COlH2WGQl3s50iUrrnUzV9pzvauUYZns76SLjhFBJ8
	KWu12z9SvjSsCTQZ/SWPBSbT2ZYnV9iQe+RhCbiMeqZqWYUNuLKPEx6eBBJO6e0b1riCyiaLnx9
	kouSQ/2sWQmyZ7qKFLKddLXxBIKPKQ9ctAeNlRMaHG2Qpgv3JY6wBAIblT3HyJ5h38axU8HsoJD
	buaBdW/pilaj/i8yEXZMmsQ+qKRY3KM3ouZWNJzW9c+Pd1HaffRJUKgcO3z3h8pXdxFs1+HipbL
	LcUesAr75bxrjF+nJta83GyxyX6x699Gd6ZkzM
X-Google-Smtp-Source: AGHT+IFU7WAkBvFT1Uro41CaQ62vT7i16b8vBNb2Sg5mlAQEJEHjgXMHbPHPQIGrd19UqmdngWIiVg==
X-Received: by 2002:a17:902:d4c8:b0:243:3fe:4294 with SMTP id d9443c01a7336-24478ed53e5mr137513915ad.12.1755526881189;
        Mon, 18 Aug 2025 07:21:21 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm81947835ad.153.2025.08.18.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:21:20 -0700 (PDT)
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
Subject: [v2, net-next 9/9] bng_en: Configure default VNIC
Date: Mon, 18 Aug 2025 19:47:16 +0000
Message-ID: <20250818194716.15229-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
References: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  40 +++
 4 files changed, 387 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 4d3cf73cdf5..a7eb5c5e5c9 100644
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
index 09517ffb1a2..042f28e84a0 100644
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
index 10d845b091c..ce802dd2e9f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1496,6 +1496,231 @@ static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	return rc;
 }
 
+static void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+{
+	if (!atomic_dec_and_test(&fltr->refcnt))
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
+	atomic_set(&fltr->refcnt, 1);
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
+		atomic_inc(&fltr->refcnt);
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
@@ -1519,11 +1744,27 @@ static void bnge_hwrm_vnic_ctx_free(struct bnge_net *bn)
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
@@ -1768,6 +2009,36 @@ static int bnge_init_chip(struct bnge_net *bn)
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
index 43c64633ed5..565a10b4dab 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -382,6 +382,10 @@ struct bnge_vnic_info {
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
@@ -393,6 +397,7 @@ struct bnge_vnic_info {
 #define BNGE_RSS_TABLE_MAX_TBL		8
 #define BNGE_MAX_RSS_TABLE_SIZE			\
 	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+	u32		rx_mask;
 
 	u8		*mc_list;
 	int		mc_list_size;
@@ -407,6 +412,41 @@ struct bnge_vnic_info {
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
+	atomic_t		refcnt;
+};
+
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 int bnge_get_nr_rss_ctxs(int rx_rings);
-- 
2.47.3


