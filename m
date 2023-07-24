Return-Path: <netdev+bounces-20491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EAB75FBC6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8023D281470
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51DFBE1;
	Mon, 24 Jul 2023 16:18:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A31F9E0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:18:52 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1EE10C3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215531; x=1721751531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79tA6R4D+A/QMYQEA3LNxHLhEZ8D7FLVlpuFHwi3jSk=;
  b=PcNDkQw0/M5HNm8OxHcQA+kbhFCW+8eEOg26eZtFvZYjGx8H9PsgDa0v
   Weqs8yLnTzLekNTIddiyNcyTwaZboXmGiN4PLI/GXthappj3soJCtC9q7
   QtARi9WA3kIHBy2SNZENi2FA2v59JNDvq0P2/uk/9M0sJvVzsfgfUQ1aL
   rYnc7b5MmkXok0Zf9E3Z4jvAQb1YlBVKsSQJFUat50bQHBFcVtXkzXglR
   T/v01YPDOkSOyv9QPnJUDDP5pA0VHD2FzAbwX/G7GXjUXCLNLXqRRvPmJ
   o9GXdmW8M8jZV1s7vAYZbSQsLDwUdR367RpcJAk53zCyO3yNopD0oOXvC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398394108"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398394108"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899546002"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899546002"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 09:18:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com,
	vladbu@nvidia.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next v2 04/12] ice: Disable vlan pruning for uplink VSI
Date: Mon, 24 Jul 2023 09:11:44 -0700
Message-Id: <20230724161152.2177196-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

In switchdev mode, uplink VSI is configured to be default
VSI which means it will receive all unmatched packets.
In order to receive vlan packets we need to disable vlan pruning
as well. This is done by dis_rx_filtering vlan op.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 15a4c148c28b..bfd003135fc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -103,6 +103,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 		rule_added = true;
 	}
 
+	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
+	if (vlan_ops->dis_rx_filtering(uplink_vsi))
+		goto err_dis_rx;
+
 	if (ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_set_allow_override))
 		goto err_override_uplink;
 
@@ -114,6 +118,8 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 err_override_control:
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 err_override_uplink:
+	vlan_ops->ena_rx_filtering(uplink_vsi);
+err_dis_rx:
 	if (rule_added)
 		ice_clear_dflt_vsi(uplink_vsi);
 err_def_rx:
@@ -381,9 +387,13 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 {
 	struct ice_vsi *uplink_vsi = pf->switchdev.uplink_vsi;
 	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi_vlan_ops *vlan_ops;
+
+	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_security(ctrl_vsi, ice_vsi_ctx_clear_allow_override);
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
+	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_clear_dflt_vsi(uplink_vsi);
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
-- 
2.38.1


