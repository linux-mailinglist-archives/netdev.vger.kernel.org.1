Return-Path: <netdev+bounces-82393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128988D831
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3891C262E1
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449337147;
	Wed, 27 Mar 2024 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uo2KY+oU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5A364AE
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526275; cv=none; b=RfiGmVpiSjTuFV7AiIIOd3hoSDf2VdarM6u3dz82m4qhyJHcWti8O8Hxuy+KGWF/MvCsS8g0aU65TRR3GSMgOFUEM5ryVudKlhlBSCYX2VPP0zNZwiSktwQqXKAJBFSfbHWst6W5JWQoyb7sdFm/rB08s/9y38yQjqqk8e0x2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526275; c=relaxed/simple;
	bh=Cfb72RysCueskKGpWK9bu7zX0TlJfMwe/MT7oNK6xOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GibFJaL2+ZaVXoEGUU5Ck0OQQuDWdHbQfUCdKRHtmFVYokgv+PwD9cFh/mf1Xu6FR4s6Efr/jNURG0qavyMuJUf+r5rsRkdtU6paUHoI9BuOFFlAdPEjmbwewyAtylWJG9yu6iyc23l4RW4R/F+QAZViudWewFfwHWNZRcf3jYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uo2KY+oU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9r9uJKxs4sN3XEzGi5ajONAMlc18lEisCoHBIPhThM=;
	b=Uo2KY+oUnqSC1kiHarno0l74K+iIy4UxxFvy3J/YrC5pX0IlwANL2uMOHrVH8V0K9EJSrr
	MI/dY3RwgZwybeFIZ/m8p99ArOizaCqxj6BOh2uU+nVbE4bwoQEf5ONuhASrmeV+73eHs6
	HKV5jtiCLlEeOj1iQ2tRtqBoSumYcL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-kEQGMq8VOpiD5Tv-cBsnJQ-1; Wed, 27 Mar 2024 03:57:49 -0400
X-MC-Unique: kEQGMq8VOpiD5Tv-cBsnJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA85E811E81;
	Wed, 27 Mar 2024 07:57:48 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA8BC15776;
	Wed, 27 Mar 2024 07:57:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mschmidt@redhat.com,
	aleksandr.loktionov@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-next v2 5/7] i40e: Consolidate checks whether given VSI is main
Date: Wed, 27 Mar 2024 08:57:31 +0100
Message-ID: <20240327075733.8967-6-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-1-ivecera@redhat.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

In the driver code there are 3 types of checks whether given
VSI is main or not:
1. vsi->type ==/!= I40E_VSI_MAIN
2. vsi ==/!= pf->vsi[pf->lan_vsi]
3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid

All of them are equivalent and can be consolidated. Convert cases
2 and 3 to case 1.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 12 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 19 +++++++++----------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 09db46de2994..abf624d770e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -129,7 +129,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		dev_info(&pf->pdev->dev,
 			 "    state[%d] = %08lx\n",
 			 i, vsi->state[i]);
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		dev_info(&pf->pdev->dev, "    MAC address: %pM Port MAC: %pM\n",
 			 pf->hw.mac.addr,
 			 pf->hw.mac.port_addr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0905c1fb2337..5cd0d1b45f01 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1241,7 +1241,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		i40e_partition_setting_complaint(pf);
 		return -EOPNOTSUPP;
 	}
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 	if (hw->phy.media_type != I40E_MEDIA_TYPE_BASET &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_FIBER &&
@@ -1710,7 +1710,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	is_an = hw_link_info->an_info & I40E_AQ_AN_COMPLETED;
@@ -2292,7 +2292,7 @@ static int i40e_get_stats_count(struct net_device *netdev)
 	struct i40e_pf *pf = vsi->back;
 	int stats_len;
 
-	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1)
+	if (vsi->type == I40E_VSI_MAIN && pf->hw.partition_id == 1)
 		stats_len = I40E_PF_STATS_LEN;
 	else
 		stats_len = I40E_VSI_STATS_LEN;
@@ -2422,7 +2422,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	}
 	rcu_read_unlock();
 
-	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
+	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
 	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
@@ -2495,7 +2495,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 				      "rx", i);
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
+	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
 	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
@@ -2792,7 +2792,7 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* NVM bit on means WoL disabled for the port */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 86bc3fc0579b..d6dbd0fd79eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -989,7 +989,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	ns->tx_dropped = es->tx_discards;
 
 	/* pull in a couple PF stats if this is the main vsi */
-	if (vsi == pf->vsi[pf->lan_vsi]) {
+	if (vsi->type == I40E_VSI_MAIN) {
 		ns->rx_crc_errors = pf->stats.crc_errors;
 		ns->rx_errors = pf->stats.crc_errors + pf->stats.illegal_bytes;
 		ns->rx_length_errors = pf->stats.rx_length_errors;
@@ -1234,7 +1234,7 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
 
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		i40e_update_pf_stats(pf);
 
 	i40e_update_vsi_stats(vsi);
@@ -6819,7 +6819,7 @@ static void i40e_dcb_reconfigure(struct i40e_pf *pf)
 		/* - Enable all TCs for the LAN VSI
 		 * - For all others keep them at TC0 for now
 		 */
-		if (v == pf->lan_vsi)
+		if (vsi->type == I40E_VSI_MAIN)
 			tc_map = i40e_pf_get_tc_map(pf);
 		else
 			tc_map = I40E_DEFAULT_TRAFFIC_CLASS;
@@ -9126,7 +9126,7 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 	i40e_vsi_free_rx_resources(vsi);
 err_setup_tx:
 	i40e_vsi_free_tx_resources(vsi);
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 
 	return err;
@@ -12001,7 +12001,7 @@ static int i40e_vsi_alloc_q_vectors(struct i40e_vsi *vsi)
 	/* if not MSIX, give the one vector only to the LAN VSI */
 	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		num_q_vectors = vsi->num_q_vectors;
-	else if (vsi == pf->vsi[pf->lan_vsi])
+	else if (vsi->type == I40E_VSI_MAIN)
 		num_q_vectors = 1;
 	else
 		return -EINVAL;
@@ -13118,7 +13118,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	int rem;
 
 	/* Only for PF VSI for now */
-	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for PF VSI */
@@ -13190,7 +13190,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct i40e_veb *veb;
 
 	/* Only for PF VSI for now */
-	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for the PF VSI */
@@ -14142,8 +14142,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 			 vsi->seid, vsi->uplink_seid);
 		return -ENODEV;
 	}
-	if (vsi == pf->vsi[pf->lan_vsi] &&
-	    !test_bit(__I40E_DOWN, pf->state)) {
+	if (vsi->type == I40E_VSI_MAIN && !test_bit(__I40E_DOWN, pf->state)) {
 		dev_info(&pf->pdev->dev, "Can't remove PF VSI\n");
 		return -ENODEV;
 	}
@@ -14407,7 +14406,7 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		if (veb) {
-			if (vsi->seid != pf->vsi[pf->lan_vsi]->seid) {
+			if (vsi->type != I40E_VSI_MAIN) {
 				dev_info(&vsi->back->pdev->dev,
 					 "New VSI creation error, uplink seid of LAN VSI expected.\n");
 				return NULL;
-- 
2.43.0


