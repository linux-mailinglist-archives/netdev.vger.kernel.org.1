Return-Path: <netdev+bounces-12357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14957737338
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3FC1C20D0B
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C3174C7;
	Tue, 20 Jun 2023 17:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019B171B4
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:49:38 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E681713
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687283377; x=1718819377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKYVAbUT9m+gzqlCrpUa5HCUtd1zBDLUeGhHzjgvZXg=;
  b=mGh69Fx9RihogqHvNL++IGDRM8SxhfDd1F6VeuQiva3//ZZRnXa8IxzJ
   +aJ9/TnQ7luSHsbaiNo1PFNC96dJfcsuXx4gDCpaDVyrzuRGc1gTlBfq/
   lOz49rbhV0TWGr/SZGn5wKDgOBbED8j+qZo4lvhIpnlkwG/dirvieGr26
   4erViohrk8InA/HO9sQo+3J5oxx9hhWwJwKeAJT37tWTA8qp520gMqJAC
   6sxhCFt2s0TouLBe7D53411tWqCC8uHlbgTb2rEak8U8uOUWGu5bliEnl
   WcKPqxZQOodiqjiN7Z3UlCBZFYXHCDZIQ4PAJBzGXUI+sbDx+armwSiAZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339554261"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="339554261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838300570"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="838300570"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 10:49:35 -0700
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
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 02/12] ice: Prohibit rx mode change in switchdev mode
Date: Tue, 20 Jun 2023 10:44:13 -0700
Message-Id: <20230620174423.4144938-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

Don't allow to change promisc mode in switchdev mode.
When switchdev is configured, PF netdev is set to be a
default VSI. This is needed for the slow-path to work correctly.
All the unmatched packets will be directed to PF netdev.

It is possible that this setting might be overwritten by
ndo_set_rx_mode. Prevent this by checking if switchdev is
enabled in ice_set_rx_mode.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 65bf399a0efc..7e0da19689f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5698,7 +5698,7 @@ static void ice_set_rx_mode(struct net_device *netdev)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
-	if (!vsi)
+	if (!vsi || ice_is_switchdev_running(vsi->back))
 		return;
 
 	/* Set the flags to synchronize filters
-- 
2.38.1


