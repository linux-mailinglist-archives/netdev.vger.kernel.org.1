Return-Path: <netdev+bounces-18234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BE755F19
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FF22812BB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33D947F;
	Mon, 17 Jul 2023 09:20:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE10846E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:20:02 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35AAC7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689585601; x=1721121601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A+tNpp1B2GMC6J+XCqkkLSUfvqd1LUEI1yHKunNN9HY=;
  b=YkmB3wOyCnUI9xv/YSIzyCCpm2xu/Br9BjzOUirnFZi4uE2i6rouWAZz
   rKjYF0yt26HL90Bzycpq2lJ14uRswmPMWEWL7sP+bxZifs/WFE3hDE9++
   TmSbTKdRcgM/PokPKmkBV7CEci05DksKV7ER28bBm7174mVAE1s381zam
   lLSfycIakpg+b+MiIQc8fLgqMbQPMa+Lrv52orMNG6f7+sEQD+zA3+fbN
   WZFi24AwyLLsXiFOqFknc1E15iww6afuJIVuhqWTwx48aKS7Ys/7wgt5Z
   OZfXhGGs3VDDU38NWojE4oVDUQZuTcj2xFL3V8+9kM36Xh9lfyUMCnweV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="364760125"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364760125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752830769"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752830769"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 02:19:59 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1E8EC33BD2;
	Mon, 17 Jul 2023 10:19:58 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	michal.swiatkowski@linux.intel.com,
	marcin.szycik@linux.intel.com,
	simon.horman@corigine.com,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us
Subject: [PATCH iwl-next v2] ice: Accept LAG netdevs in bridge offloads
Date: Mon, 17 Jul 2023 11:18:43 +0200
Message-Id: <20230717091843.108015-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow LAG interfaces to be used in bridge offload using
netif_is_lag_master. In this case, search for ice netdev in
the list of LAG's lower devices.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
Note for Tony: This patch needs to go with Dave's LAG
patchset:
http://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=360621

v2: fix spelling of uplink in ice_eswitch_br_get_uplink_from_lag
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
2.40.1


