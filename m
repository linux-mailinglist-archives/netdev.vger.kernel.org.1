Return-Path: <netdev+bounces-29074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD325781904
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B6A281C7F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9D63D0;
	Sat, 19 Aug 2023 10:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C38134D3
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336714F151
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438552; x=1723974552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAZ2k6g9Dy+6qxoBcnz+IIkmSJoYSZbZiomClWnQN94=;
  b=DD/MFTNWLKRsRDOENwT4OVDi6Pix1zFiKGC1iQ/egvSKixeRK/+g05Ik
   6wthH8Aa7DrAfFvLZA8bLSGYBf9A/pYNkb+6G24o/d55nCUNqa1Oz9n0I
   zPy52I5t9jkZxwpppqhbHR//qsUYuRza6Knl9hXE1Jdu4jOyn4ZPGOkus
   Q+VNoPTCeKW2k4Nw+ixkvy//IsXJfl+6tOLgu7lkhf0yKQu4kxjCU+ruJ
   18QBhhXiiZTMU+M+fWYLc49WCJKctbBXZQpSrFEzmKyCWeaQiA+1iLTXm
   FKYgPqL9+1LLkxieVvE3iWMstpAfkZVPGL3j67cdlxUJosZ1lyB4H4NdM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="404261832"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="404261832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="805419599"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="805419599"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2023 02:49:11 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	Alice Michael <alice.michael@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 5/9] ice: Add 200G speed/phy type use
Date: Sat, 19 Aug 2023 02:41:46 -0700
Message-Id: <20230819094146.15242-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
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
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alice Michael <alice.michael@intel.com>

Add the support for 200G phy speeds and the mapping for their
advertisement in link. Add the new PHY type bits for AQ command, as
needed for 200G E830 controllers.

Signed-off-by: Alice Michael <alice.michael@intel.com>
Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 14d030d208e0..cbd728386288 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -354,7 +354,6 @@ static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[] __ro_after_init
 	ETHTOOL_FORCED_SPEED_MAP(25000),
 	ETHTOOL_FORCED_SPEED_MAP(40000),
 	ETHTOOL_FORCED_SPEED_MAP(50000),
-	ETHTOOL_FORCED_SPEED_MAP(100000),
 };
 
 void __init ice_adv_lnk_speed_maps_init(void)
-- 
2.39.2


