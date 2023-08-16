Return-Path: <netdev+bounces-28219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC577EB1F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739A41C211A5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B541ADDF;
	Wed, 16 Aug 2023 20:54:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4E1ADDE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F12716
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219275; x=1723755275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BQ3gKsh2/IOoYRxbNpWTmMOaEkLIZpyW1jYRpvl1hTM=;
  b=RLw7xSkMumPTmnFubZe7DYSKCfZUoOmGG0caj+Lccw/8HJ4CZ4Z7zNou
   0fOOxaKF8akrxla19zNxwQ2u4MzXaKbne0XjucqLls1ehoqYvd8ta+tCo
   cnXMBaB2+iY45xpDFY79oPA59d52C5H0Ceaz1oJr7ql+Ou8+UDvlhfNvv
   u5CeHrQoXhaeDfI6y8dxsyPHSTeV+sbkVxeiQX0Rtk4hfOKYDsi31OlK9
   4xgHzlunwFydPITb/wS0zV47vhlVp/eyadyOLQz/KSjW2DUP2UR/9StMf
   rpea31//2+uD8FqznyUjKxpghZaJpBBHgmXdIkH+JZ8y9dDxLNOCgliwh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604797"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604797"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626400"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626400"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 09/14] ice: Remove redundant VSI configuration in eswitch setup
Date: Wed, 16 Aug 2023 13:47:31 -0700
Message-Id: <20230816204736.1325132-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Remove a call to disable VLAN stripping on switchdev control plane VSI, as
it is disabled by default.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 9a53a5e5d73e..62b54100273f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -84,10 +84,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	struct ice_vsi_vlan_ops *vlan_ops;
 	bool rule_added = false;
 
-	vlan_ops = ice_get_compat_vsi_vlan_ops(ctrl_vsi);
-	if (vlan_ops->dis_stripping(ctrl_vsi))
-		return -ENODEV;
-
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
 	netif_addr_lock_bh(uplink_netdev);
-- 
2.38.1


