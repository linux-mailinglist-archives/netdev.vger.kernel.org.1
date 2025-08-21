Return-Path: <netdev+bounces-215714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6BB2FF3E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EE5E4E64CF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD32E090E;
	Thu, 21 Aug 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GbUbY4Jb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F722E0405
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791360; cv=none; b=PE4j4+8kaq4dcaqPaDB0f8s6l6VigHhPZJJy+jSahhTZSaP305o1m7aG02rFabN+DwtHvfEteZc5/d9GhpvOL8Foa5nGvtElJZC7EEgSAPia328KP+TDw0vybWNeX5Hl4gbLIdFJPgfM+HqhM+PUSWUfWYH6C3eQmhgvdmjTFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791360; c=relaxed/simple;
	bh=5q40fAciYRzHACAQM/CWw8hbNPkiVw8dn4NbZB2sMPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYLKBKj22b4L0R9D/DeENq6+OVQijeTGS2w4TIoUmSfV6EzwXA21DZWB3NA0UuVnkSCADHJqM6Ic/i9mcszxqYHQHTb5wOMWPJI8XfR3PTmHwuJiJGdbriS/0nchLZKaCCDJTRlYE5O4bnM82M06Ff42X2mXhXRbF3lsmLAo3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GbUbY4Jb; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-244580523a0so10936455ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791358; x=1756396158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI4mte+2XC3hMm1QTzxaNmd4rdx0AI16Ne+5vaYpu78=;
        b=AwYZqGjqUa9dZRnnV4bU/w2oneVoBb+Dzyzzu81R70FN4WZdwOzJByfZhfwZSOFgfx
         dfWKb/VmqPe+4hGGd1ICJkpn+3wdi5/skIdTmHG1BCAqArxWBXDdqOsDxuY5Ou24q6ZT
         NSZ9NPpRDqDVeEeAb91kS3Om9pEyGqwwRqvfkCHgF0xRKeQYNRVTlKiKIZ30wNby8CkO
         G1Ul7NvYbodzuNLyGUPKkz5eMcMWdCVBOAWR6j+3xs4Kr78pv+ZRYW4spoB48UB3n9WL
         daNj1YbodBiNrGdljY/H8zxlkudxig6aVoO8sgGZ0zIhJ3JntvQcJQBV/mquPC/fbyhz
         WgaA==
X-Gm-Message-State: AOJu0YzPG3XR1vmmfwC4ppsLSfyIRRaNPYrJPRDx0kYAwVM1Lz/wu9+I
	xxLp1g19aWp7qrT7jX4ZS49u+VurdRs01SRtL5DrZpm8vyXcdQ6HV+BJbja0QQrYvV+DsUSHXEw
	mIVub1xrDdZ1gu2HxeQotaeVa4aOVUrQ8jBpm9JUcU/audWae3ilaCQ+Or9ItKbRJ+Tsiid3rjj
	hwbs4NU0PcTsXL447Fwg+YeGVRhcgBhYoul+sBksClIpAiCW3CejT2/o6xUHCQ993iHL4UVZ5Xe
	OGd86/+HkejWohrtNAQ
X-Gm-Gg: ASbGncvlNl2I8EG0YQ7GuG9WYYCpGimntMUEnOXmG56gtEOQyRkW7OM2Rb3NZDA/olJ
	tKKyBxapSAvtWQJZhvcYdjJnnHHSFujSIYm3/8aew7pbAdm2I/RWDBkE5NNcWFVF1YHZMv3u7+E
	W1fIrEZW72VBA3gO7D8tVmaG4NoerTvMdKFm/2FanVduSGZiOMVdAo+/w+xIm9kp85mK90SucNH
	XpAenEVJH0+3JFRDyqVbfHp/1QQJxnP8hHau3Wd+pwvgTHnPLJrbTnEbRQV4oiiXvNOKM8pm7/c
	3/kq67oFpW3tQcjGvYqAJB6PULRlWabwmMn1iD0ZF60OADPB/6IYxGr6z5fcyUDmoBYxtzMHa1A
	EmHacU8GkKelqIdpWVzOlYoviq6/DFbN/yOjIFAwGKB3anb3VAyIwILJwBLu4EuGyNM/80JWxcC
	QGHxaDUw==
X-Google-Smtp-Source: AGHT+IF3FChEwIXN8kRkVOPpILoL1Y6+jeKEFfwIupiJOvLGvHnvWeYKGCsb/fzFPxINGBJ11wCVQFqt+SiK
X-Received: by 2002:a17:902:d505:b0:235:e8da:8d1 with SMTP id d9443c01a7336-245febef4aemr39706115ad.8.1755791358146;
        Thu, 21 Aug 2025 08:49:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2461879b281sm1147255ad.11.2025.08.21.08.49.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:49:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324f2d61681so1044185a91.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791356; x=1756396156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI4mte+2XC3hMm1QTzxaNmd4rdx0AI16Ne+5vaYpu78=;
        b=GbUbY4JbuVq6UXE2q2MJwy447wl4vDIT18w05KRqfsK93oVDAQmjzeLMBXTm/WGA8C
         unBGFXgbqZLSygYw3t1/DinDF1lmCdFmOq/mn8G9C2/G5tEbPU4ZV+izPFeb7LZJMVmh
         yYqQzYAele9mgqd/1KIkRGrvUlXt9EYcxW3o0=
X-Received: by 2002:a17:90b:4a09:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-324ed1bf38amr4103891a91.19.1755791356351;
        Thu, 21 Aug 2025 08:49:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4a09:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-324ed1bf38amr4103850a91.19.1755791355768;
        Thu, 21 Aug 2025 08:49:15 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:49:15 -0700 (PDT)
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
Subject: [v3, net-next 9/9] bng_en: Configure default VNIC
Date: Thu, 21 Aug 2025 21:15:17 +0000
Message-ID: <20250821211517.16578-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
index 10d845b091cf..419669520dc2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1496,6 +1496,231 @@ static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
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
index 43c64633ed50..b12cf5ddf038 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -6,6 +6,7 @@
 
 #include <linux/bnxt/hsi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/refcount.h>
 #include "bnge_db.h"
 
 struct tx_bd {
@@ -382,6 +383,10 @@ struct bnge_vnic_info {
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
@@ -393,6 +398,7 @@ struct bnge_vnic_info {
 #define BNGE_RSS_TABLE_MAX_TBL		8
 #define BNGE_MAX_RSS_TABLE_SIZE			\
 	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+	u32		rx_mask;
 
 	u8		*mc_list;
 	int		mc_list_size;
@@ -407,6 +413,41 @@ struct bnge_vnic_info {
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


