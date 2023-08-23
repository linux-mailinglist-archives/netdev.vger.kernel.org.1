Return-Path: <netdev+bounces-30094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988D785F59
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1386A2812A0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3E1FB2C;
	Wed, 23 Aug 2023 18:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B381ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:11:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBDCC7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692814281; x=1724350281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9LKvTxSevpLEFQm5EUNabCxtuXlzk26Ycue2YeA3lIk=;
  b=XZJAD+GvbTcf/XH/8dOQpU0S3if68VwZgRzm2ps3PHar99mFMTky0UIk
   9KXWz8o5NGijipMF8lKWFOJmqNm1CHlpDBtEmS8J+9Ptd98FywequR0We
   IiddZyDxJRc5qaFavOlNj7zDrs2W+aNTRyaLOikmEexSoSCkjyfiE/aIp
   rzDshQXWEmR2i9YQgT1SO8WqUKEQ0TAEql3AGxeY310exphpah0AVlP93
   PEvI7jkfTsJwRyq3cRrcBWgsghd4QpJlVE5hfd3VhWNIm2biV3nzdgD/C
   QG7kLKnfLk99VPaWRgnO8Po0zpGb1BABAk9txS25ptcLf0nVnigZ7uhd/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374211878"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374211878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851141541"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851141541"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 11:11:19 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7AD9433E8D;
	Wed, 23 Aug 2023 19:11:18 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v3 8/8] ice: Hook up 4 E830 devices by adding their IDs
Date: Wed, 23 Aug 2023 20:06:32 +0200
Message-Id: <20230823180633.2450617-9-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
References: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9562ba928aae..5b16c03d2461 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5587,6 +5587,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
 	/* required last entry */
 	{}
 };
-- 
2.37.3


