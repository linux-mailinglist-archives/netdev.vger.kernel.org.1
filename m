Return-Path: <netdev+bounces-23366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A527C76BB73
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F097281BD3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D623582;
	Tue,  1 Aug 2023 17:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEA2359F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:44 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A47268E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911455; x=1722447455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7xrqoSks47MhczR3NvhxeNPoScf6OqOvQ1gOrRhPvk=;
  b=avhwenmPCRVWnHnBBPzTefJYLNT7Jc46J2ZZsYtaqlWdZGCfXZVjKtNi
   CRzV6wJwIbZ4uAy4IfN6uwSnBkWqcjvlwr2CYleJpwVw6XKZO4ni27SQM
   RqRqr2smI3n5NhWbxVRUOO04/MPBrM6wEkbgy4OHJKGNfOMBv/lGs3jwO
   mw7nw7QI0721PS31J9+5SeWZx70cms2NOiLY5ceHbZZLel91+RMWnf5mr
   96kB8UdYWWDHeKGL4uypjZ2hMB5ytxtskvE2oiQpWUZgVN+oSpJdzqu6z
   cTaWkHzHeXHOkTXWTCaTZqwGQKaL4urRuw17aCqFhBfzitymHAbK9jITr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740658"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740658"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769691"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769691"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 1/7] ice: Accept LAG netdevs in bridge offloads
Date: Tue,  1 Aug 2023 10:31:06 -0700
Message-Id: <20230801173112.3625977-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

Allow LAG interfaces to be used in bridge offload using
netif_is_lag_master. In this case, search for ice netdev in
the list of LAG's lower devices.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 47 +++++++++++++++++--
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index cc7357ed6e5f..67bfd1f61cdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -20,8 +20,23 @@ static const struct rhashtable_params ice_fdb_ht_params = {
 
 static bool ice_eswitch_br_is_dev_valid(const struct net_device *dev)
 {
-	/* Accept only PF netdev and PRs */
-	return ice_is_port_repr_netdev(dev) || netif_is_ice(dev);
+	/* Accept only PF netdev, PRs and LAG */
+	return ice_is_port_repr_netdev(dev) || netif_is_ice(dev) ||
+		netif_is_lag_master(dev);
+}
+
+static struct net_device *
+ice_eswitch_br_get_uplink_from_lag(struct net_device *lag_dev)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(lag_dev, lower, iter) {
+		if (netif_is_ice(lower))
+			return lower;
+	}
+
+	return NULL;
 }
 
 static struct ice_esw_br_port *
@@ -31,8 +46,19 @@ ice_eswitch_br_netdev_to_port(struct net_device *dev)
 		struct ice_repr *repr = ice_netdev_to_repr(dev);
 
 		return repr->br_port;
-	} else if (netif_is_ice(dev)) {
-		struct ice_pf *pf = ice_netdev_to_pf(dev);
+	} else if (netif_is_ice(dev) || netif_is_lag_master(dev)) {
+		struct net_device *ice_dev;
+		struct ice_pf *pf;
+
+		if (netif_is_lag_master(dev))
+			ice_dev = ice_eswitch_br_get_uplink_from_lag(dev);
+		else
+			ice_dev = dev;
+
+		if (!ice_dev)
+			return NULL;
+
+		pf = ice_netdev_to_pf(ice_dev);
 
 		return pf->br_port;
 	}
@@ -1085,7 +1111,18 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
 		err = ice_eswitch_br_vf_repr_port_init(bridge, repr);
 		trace_ice_eswitch_br_port_link(repr->br_port);
 	} else {
-		struct ice_pf *pf = ice_netdev_to_pf(dev);
+		struct net_device *ice_dev;
+		struct ice_pf *pf;
+
+		if (netif_is_lag_master(dev))
+			ice_dev = ice_eswitch_br_get_uplink_from_lag(dev);
+		else
+			ice_dev = dev;
+
+		if (!ice_dev)
+			return 0;
+
+		pf = ice_netdev_to_pf(ice_dev);
 
 		err = ice_eswitch_br_uplink_port_init(bridge, pf);
 		trace_ice_eswitch_br_port_link(pf->br_port);
-- 
2.38.1


