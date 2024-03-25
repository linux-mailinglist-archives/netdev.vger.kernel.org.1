Return-Path: <netdev+bounces-81765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A588B61C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B069C408C8
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152EC45BE1;
	Mon, 25 Mar 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZA1DiY5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DC4779D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398395; cv=none; b=XphzcL8yoNGXpnV44DDtlgQ3GgpLY0Xs8lwzWau7ATsBrwgxGExAMWAiBDWP3/c42t4gblWBWhxSQNr286aQDRRlkDdhTy7k8Ok0dOFdbXYhyUz9Fwc7bV7hQ0r3dkoIjqYYc81AObN4ZohvIHUH25YUJPCT8hWPa0oXBMTwdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398395; c=relaxed/simple;
	bh=ZZtn1k9mRuMopaQctBAHmOAeAZOYHoWL03f2w5LPDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukQwigZsmvsN55Zd0DKTaThTnC098IBY2l7oLv3kxxn8xfMsPIgZwibXUracUS9VCow1YkALbM5+6v+NLNozp3RlQsrP+Ln3wsswwrGtHe/65B1Tb2VZEzWMFFu/eNKFNoQnYAeRaP8aP+UwHMsAQHE/K5fNpfr2iYXXyRQs4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZA1DiY5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398394; x=1742934394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZtn1k9mRuMopaQctBAHmOAeAZOYHoWL03f2w5LPDPY=;
  b=eZA1DiY5Wot4XkHuZ8xqdhMKQ4BgmcuCaOgXQ4cMOWUFxjjtwvQL4a36
   r5b7gx0t0OEuytoRQg7zD7hQvBvpgiOj3qrK5/JveK5kwollqiXMaAF6U
   ww+eKpBCe+vkNV0VHQQiMbCKmM94GQYUbey/cidXNXv1LlEiwgrmLdPEc
   Yibq7T9ZJLEKgTuyS6fGPiHEehAHJCbECFjgHooDAh7Pyob54xlIrMSlB
   +mxDZvz6+9wZyW+LS6wJnH/h98zl9tjWF1vBL3wdK+pvi9EsWacE70YTU
   Kz/s/jhNBAthWFlUSybDDrs+5iMy5B4vPfm8HuYQ3USM6rGUyBuqsWxGf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219641"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787368"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 2/8] ice: do Tx through PF netdev in slow-path
Date: Mon, 25 Mar 2024 13:26:10 -0700
Message-ID: <20240325202623.1012287-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Tx can be done using PF netdev.

Checks before Tx are unnecessary. Checking if switchdev mode is set
seems too defensive (there is no PR netdev in legacy mode). If
corresponding VF is disabled or during reset, PR netdev also should be
down.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 26 +++++---------------
 drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ---------
 drivers/net/ethernet/intel/ice/ice_repr.h    |  2 --
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e999f801c0a..8ad271534d80 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -236,7 +236,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
  */
 static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 {
-	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
 	struct ice_vsi *vsi = repr->src_vsi;
 	struct metadata_dst *dst;
 
@@ -255,12 +255,11 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	netif_napi_add(repr->netdev, &repr->q_vector->napi,
 		       ice_napi_poll);
 
-	netif_keep_dst(repr->netdev);
+	netif_keep_dst(uplink_vsi->netdev);
 
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
-	dst->u.port_info.lower_dev = repr->netdev;
-	ice_repr_set_traffic_vsi(repr, ctrl_vsi);
+	dst->u.port_info.lower_dev = uplink_vsi->netdev;
 
 	return 0;
 
@@ -318,27 +317,14 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct ice_netdev_priv *np;
-	struct ice_repr *repr;
-	struct ice_vsi *vsi;
-
-	np = netdev_priv(netdev);
-	vsi = np->vsi;
-
-	if (!vsi || !ice_is_switchdev_running(vsi->back))
-		return NETDEV_TX_BUSY;
-
-	if (ice_is_reset_in_progress(vsi->back->state) ||
-	    test_bit(ICE_VF_DIS, vsi->back->state))
-		return NETDEV_TX_BUSY;
+	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	repr = ice_netdev_to_repr(netdev);
 	skb_dst_drop(skb);
 	dst_hold((struct dst_entry *)repr->dst);
 	skb_dst_set(skb, (struct dst_entry *)repr->dst);
-	skb->queue_mapping = repr->q_id;
+	skb->dev = repr->dst->u.port_info.lower_dev;
 
-	return ice_start_xmit(skb, netdev);
+	return dev_queue_xmit(skb);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5f30fb131f74..6191bee6c536 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -439,15 +439,3 @@ void ice_repr_stop_tx_queues(struct ice_repr *repr)
 	netif_carrier_off(repr->netdev);
 	netif_tx_stop_all_queues(repr->netdev);
 }
-
-/**
- * ice_repr_set_traffic_vsi - set traffic VSI for port representor
- * @repr: repr on with VSI will be set
- * @vsi: pointer to VSI that will be used by port representor to pass traffic
- */
-void ice_repr_set_traffic_vsi(struct ice_repr *repr, struct ice_vsi *vsi)
-{
-	struct ice_netdev_priv *np = netdev_priv(repr->netdev);
-
-	np->vsi = vsi;
-}
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index f9aede315716..b107e058d538 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -28,8 +28,6 @@ void ice_repr_rem_vf(struct ice_repr *repr);
 void ice_repr_start_tx_queues(struct ice_repr *repr);
 void ice_repr_stop_tx_queues(struct ice_repr *repr);
 
-void ice_repr_set_traffic_vsi(struct ice_repr *repr, struct ice_vsi *vsi);
-
 struct ice_repr *ice_netdev_to_repr(struct net_device *netdev);
 bool ice_is_port_repr_netdev(const struct net_device *netdev);
 
-- 
2.41.0


