Return-Path: <netdev+bounces-92582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A18B7F76
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917A6285260
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF1199E85;
	Tue, 30 Apr 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW26ft5v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547B194C77
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500409; cv=none; b=dXw2Q93f76KuXCj07QfIRa00sjd1Oi3g84Yd4bV1x7HDxKW1tJjozbTta/OehtJURbp/iZ6hQmz1COuhtEzIdD3fxMKs5K71aRZm3//qTQAmH5lI7oHTcVQ8ix42SMiPVkSLaBguW8qO1P/q5NK1xMSC4j1J52sqezCjwD/tse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500409; c=relaxed/simple;
	bh=8I0TjILjx7uyiIy6a6j647rTMc1AG6OluhFsKOt8rH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSJz/s3ZBYptkuEEoHOK6rIW8BfM2F28Uk2EW+1klemO/4gzMBlVsl/QxgCyEI6xArko6MSSD2xMmkXSpbKQVUrqQx640sZx1KJeGpUOJSuOIimOTBSGtXpj+sNmF0Bi3adaho2BD6Es53uGvC8UZlDg08QHpHI6pA2AVBBlxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gW26ft5v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500408; x=1746036408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8I0TjILjx7uyiIy6a6j647rTMc1AG6OluhFsKOt8rH8=;
  b=gW26ft5vvax5z83GGh47gy4ro5Y8BD49k8udVJyvR23HqioCNorFxV2V
   7wMW8+EIoeYCDx4w8tnGwBIYhV6+ZGRVYtETCDtPEUAcABlO/RfiFSx+1
   VDyqC9q14wDePLtHbe6iKZTdPvnWpUFm0ydb9UR/o2a/IRnUYiylQFifZ
   19VIR0bvDH1T2uGI8EXnRZAZc3vj9XbxrSxGCA7pbCgAzQUe74m3WgP+i
   oihJRcLAOayNLtNfR/PU2oZzUwkA8Fdm0DrKJdYd5ffSsaNzTzBS3YL9C
   J8NHv/qzc7x2bm0PBVw9FGB6gkduYB9+aYt8CW1NDf8hKkTIdfbsOeS0m
   w==;
X-CSE-ConnectionGUID: rITXQ24yRBim5eSJdAt1tg==
X-CSE-MsgGUID: 1y/yZRhWSkeeXQYUz4X1FA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839444"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:45 -0700
X-CSE-ConnectionGUID: xHvBloRcSg6Xnreqv9yXAA==
X-CSE-MsgGUID: zXhhxwNbQzKJ7X0KlxztFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147310"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 6/7] i40e: Add helper to access main VEB
Date: Tue, 30 Apr 2024 11:06:36 -0700
Message-ID: <20240430180639.1938515-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
References: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Add a helper to access main VEB:

i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 11 ++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 27 ++++++++++++-------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 58610a624a59..bca2084cc54b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1401,4 +1401,15 @@ i40e_pf_get_veb_by_seid(struct i40e_pf *pf, u16 seid)
 	return NULL;
 }
 
+/**
+ * i40e_pf_get_main_veb - get pointer to main VEB
+ * @pf: pointer to a PF
+ *
+ * Return: pointer to main VEB or NULL if it does not exist
+ **/
+static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
+{
+	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5cd0d1b45f01..4e28785c9fb2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2425,14 +2425,11 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
-	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
-		     (pf->lan_veb < I40E_MAX_VEB) &&
-		     test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags));
+	veb = i40e_pf_get_main_veb(pf);
+	veb_stats = veb && test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 
-	if (veb_stats) {
-		veb = pf->veb[pf->lan_veb];
+	if (veb_stats)
 		i40e_update_veb_stats(veb);
-	}
 
 	/* If veb stats aren't enabled, pass NULL instead of the veb so that
 	 * we initialize stats to zero and update the data pointer
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 85d609ad81dc..26e5c21df19d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2481,7 +2481,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 	int aq_ret;
 
 	if (vsi->type == I40E_VSI_MAIN &&
-	    pf->lan_veb != I40E_NO_VEB &&
+	    i40e_pf_get_main_veb(pf) &&
 	    !test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		/* set defport ON for Main VSI instead of true promisc
 		 * this way we will get all unicast/multicast and VLAN
@@ -9909,6 +9909,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 static void i40e_link_event(struct i40e_pf *pf)
 {
 	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+	struct i40e_veb *veb = i40e_pf_get_main_veb(pf);
 	u8 new_link_speed, old_link_speed;
 	bool new_link, old_link;
 	int status;
@@ -9948,8 +9949,8 @@ static void i40e_link_event(struct i40e_pf *pf)
 	/* Notify the base of the switch tree connected to
 	 * the link.  Floating VEBs are not notified.
 	 */
-	if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
-		i40e_veb_link_event(pf->veb[pf->lan_veb], new_link);
+	if (veb)
+		i40e_veb_link_event(veb, new_link);
 	else
 		i40e_vsi_link_event(vsi, new_link);
 
@@ -14881,7 +14882,8 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		/* Main VEB? */
 		if (uplink_seid != pf->mac_seid)
 			break;
-		if (pf->lan_veb >= I40E_MAX_VEB) {
+		veb = i40e_pf_get_main_veb(pf);
+		if (!veb) {
 			int v;
 
 			/* find existing or else empty VEB */
@@ -14895,12 +14897,15 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 				pf->lan_veb = v;
 			}
 		}
-		if (pf->lan_veb >= I40E_MAX_VEB)
+
+		/* Try to get again main VEB as pf->lan_veb may have changed */
+		veb = i40e_pf_get_main_veb(pf);
+		if (!veb)
 			break;
 
-		pf->veb[pf->lan_veb]->seid = seid;
-		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
-		pf->veb[pf->lan_veb]->pf = pf;
+		veb->seid = seid;
+		veb->uplink_seid = pf->mac_seid;
+		veb->pf = pf;
 		break;
 	case I40E_SWITCH_ELEMENT_TYPE_VSI:
 		if (num_reported != 1)
@@ -15045,13 +15050,15 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	/* first time setup */
 	main_vsi = i40e_pf_get_main_vsi(pf);
 	if (!main_vsi || reinit) {
+		struct i40e_veb *veb;
 		u16 uplink_seid;
 
 		/* Set up the PF VSI associated with the PF's main VSI
 		 * that is already in the HW switch
 		 */
-		if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
-			uplink_seid = pf->veb[pf->lan_veb]->seid;
+		veb = i40e_pf_get_main_veb(pf);
+		if (veb)
+			uplink_seid = veb->seid;
 		else
 			uplink_seid = pf->mac_seid;
 		if (!main_vsi)
-- 
2.41.0


