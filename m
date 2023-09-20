Return-Path: <netdev+bounces-35286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C517A8A71
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44B11C20429
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047AB1A5A4;
	Wed, 20 Sep 2023 17:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAEF1A591
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:20:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418FCA
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695230404; x=1726766404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejs+R2EoIA8tgV6ngrHBWQ06OEvbXsWMsIx+zIH/EEk=;
  b=M8hFi08ErOqJvsdDljTgXsftpSKpHZwBfELVmQnQaBvOcS3YRT+jg11z
   ShXEum+OMMzPIrCE/Zw0/Ohashvi+aF3CcD8+tpKQuFXoXoHveu+WY+Gt
   PT7DAX9+JP8CIkB2VuUDWa6/zlRhjc4nVYZqUg06acJpSROOR76nDj00D
   kPhvP6BArzrCDL1I39ot/z7UczAdIjvb7hYzoukOKZMRpjNaTLjJyJNdT
   jz6DsIwBVkuYfd1hizHwRlbW8t111aNt7lX+JufLJJXBYuy19w6aU+LJa
   utKr0A1TNkOQrSUdlGrzHLrw8QCAfX16T8rmFQexXDT/sz5pqPRPRo4Td
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411234468"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411234468"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077543733"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077543733"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 10:20:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Michalik <michal.michalik@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/4] ice: Use PTP auxbus for all PHYs restart in E822
Date: Wed, 20 Sep 2023 10:19:27 -0700
Message-Id: <20230920171929.2198273-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
References: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Michalik <michal.michalik@intel.com>

The E822 (and other devices based on the same PHY) is having issue while
setting the PHC timer - the PHY timers are drifting from the PHC. After
such a set all PHYs need to be restarted and resynchronised - do it
using auxiliary bus.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9c21e81c29db..503cf351f5f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1488,6 +1488,24 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
 	ice_ptp_port_phy_restart(&pf->ptp.port);
 }
 
+/**
+ * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
+ * @pf: Board private structure
+ */
+static void ice_ptp_restart_all_phy(struct ice_pf *pf)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &pf->ptp.ports_owner.ports) {
+		struct ice_ptp_port *port = list_entry(entry,
+						       struct ice_ptp_port,
+						       list_member);
+
+		if (port->link_up)
+			ice_ptp_port_phy_restart(port);
+	}
+}
+
 /**
  * ice_ptp_adjfine - Adjust clock increment rate
  * @info: the driver's PTP info structure
@@ -1925,9 +1943,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* Reenable periodic outputs */
 	ice_ptp_enable_all_clkout(pf);
 
-	/* Recalibrate and re-enable timestamp block */
-	if (pf->ptp.port.link_up)
-		ice_ptp_port_phy_restart(&pf->ptp.port);
+	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
+	if (hw->phy_model == ICE_PHY_E822)
+		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set time %d\n", err);
-- 
2.38.1


