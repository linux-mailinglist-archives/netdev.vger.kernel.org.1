Return-Path: <netdev+bounces-94689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3D8C0336
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EADB2518B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61B12DD8A;
	Wed,  8 May 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKyJM3mh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36D12C814
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189637; cv=none; b=XuMhft4mgAvbFsLMaGOuyEMAS44BKpByq0aEOByRZoDV6xoYchtf4U3qSrONg48HHIz1SDjewBWtyx87vIXw5qR7uW8xeukcDjTQhrmnOUJvi4CWTxSp01y3dSblsIdYq/JRJg3e2JGdxUYUB1zrIMjdAJz1EO1z0dghJ5Vi2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189637; c=relaxed/simple;
	bh=+UlE0uRvIBeDGtHuF18/CMaRnd6DaV+tRcmN2Mlr2mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/KDxL9z1AgOVyFLfphQGPmJAL0/x4FjmY9jn35L4OLCQ9bJg5YzOmBFz3cnz7yoqbNd/qPWzKUNYRpeb0M0NELAlxeYdGipr5TrWM0GiLLoa2YvqrXN2TIcR9tNVtydf7/rBof+7LKApQ0Bqxam5MP6iB2I3hwGyf8MywrE4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKyJM3mh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189636; x=1746725636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UlE0uRvIBeDGtHuF18/CMaRnd6DaV+tRcmN2Mlr2mI=;
  b=TKyJM3mh3BAEZEscgtTLZndKkfCKxseKekL7snZwDFbSE/iH/cBO6CGo
   EfwHWSQUwNOTayraAP2UwtdWUpSXvLWK3Mkh9jADhaiohGFIdSl5sFViu
   iU63QU3gEdoNb1wWlnThZb2Beolw92P0s2kdVOMdx6wpx/OY7JX5Obvx9
   IkOCMJIwCZl7tHMpOB7iQ7N/s22q5UqvggGiVmd0DGuUfdqqIJZ5NMMvR
   yvkkN00hGK6eoPtXDaMTUczCc+3YWzbl00kDqzS2224e0jn0U1SvCPpKS
   lh4AB0wA8eWQa9F9D9VFrPVQLg+LZK49M25fDLJe0cynpzGMAw6dNKu7W
   Q==;
X-CSE-ConnectionGUID: 07ZyBibwRpaRf+YpNm5vqg==
X-CSE-MsgGUID: qs1R3HbKQV+ONaAWF0XfJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938974"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:52 -0700
X-CSE-ConnectionGUID: uHYXkWLzTKScGAIu7lPIBQ==
X-CSE-MsgGUID: IbX97DHmQVaGSmGvfcisYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843722"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Corinna Vinschen <vinschen@redhat.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	Hariprasad Kelam <hkelam@marvell.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 6/7] igc: fix a log entry using uninitialized netdev
Date: Wed,  8 May 2024 10:33:38 -0700
Message-ID: <20240508173342.2760994-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Corinna Vinschen <vinschen@redhat.com>

During successful probe, igc logs this:

[    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The reason is that igc_ptp_init() is called very early, even before
register_netdev() has been called. So the netdev_info() call works
on a partially uninitialized netdev.

Fix this by calling igc_ptp_init() after register_netdev(), right
after the media autosense check, just as in igb.  Add a comment,
just as in igb.

Now the log message is fine:

[    5.200987] igc 0000:01:00.0 eth0: PHC added

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c30f0f572600..b5bcabab7a1d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7028,8 +7028,6 @@ static int igc_probe(struct pci_dev *pdev,
 	device_set_wakeup_enable(&adapter->pdev->dev,
 				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
 
-	igc_ptp_init(adapter);
-
 	igc_tsn_clear_schedule(adapter);
 
 	/* reset the hardware with the new settings */
@@ -7051,6 +7049,9 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Check if Media Autosense is enabled */
 	adapter->ei = *ei;
 
+	/* do hw tstamp init after resetting */
+	igc_ptp_init(adapter);
+
 	/* print pcie link status and MAC address */
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
-- 
2.41.0


