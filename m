Return-Path: <netdev+bounces-28285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885977EE16
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6961C21280
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC1382;
	Thu, 17 Aug 2023 00:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C635A45
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:05:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E02133
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692230719; x=1723766719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7CpkAGm9AMDYpLCrvBWk5/DAhJHRJZsYuZXPpX0QRn8=;
  b=NaVGrbS84ipWbK6gWqfmShA1bEmlGLBxSHl3pIQWmhuXUkm+8hvX564R
   MXtlZdobg3HPl8XHZgF2/wK9Y3CiRHIe5KaK4X4cdFJFo/4vWV495ATMb
   rZwHHB4ayqKkgwBQUK8N0o/2n+UDlDC8oGQXO/GNKaswFo6N1s/4cbGEa
   MvPxwFF4QpDm9/QSLI1fWgCE+BiCeoNAfkJQbuTwYHNbaiidpAllTDUHA
   lopAXYNSSrqBGRxmDwqnhAndyU4VNlQIkpfCOWx5bkIrsrjvCzTLcSh99
   L1hLehWbJuewnlCE3+jB/B28B6oBRBF1+acUrFtT2d/AIoSg0J9D74d6K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371570665"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="371570665"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 17:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824422151"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="824422151"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 17:04:55 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 7/7] ice: Enable support for E830 device IDs
Date: Wed, 16 Aug 2023 16:57:19 -0700
Message-Id: <20230816235719.1120726-8-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816235719.1120726-1-paul.greenwalt@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d6715a89ec78..80013c839579 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5630,6 +5630,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT)},
 	/* required last entry */
 	{ 0, }
-- 
2.39.2


