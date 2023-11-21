Return-Path: <netdev+bounces-49789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED67F37DF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FA91C20BC5
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA654664;
	Tue, 21 Nov 2023 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAEdKT+4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD2719E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601185; x=1732137185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dWAmyq0Zwu8wAmt5qnj0Wp00KuaU5bz37J/+djrJtO4=;
  b=TAEdKT+42ltZ1JuXlZASdycoVjPX5ilj+dQOy4k87ENzSkErfsyXCZfk
   dYOOvNixrb+kMtb/dWkwuKXnnX0V1z4I6NsZVb9PgtY9HIXNd/JJSnxE2
   5DwQB4lAn9IFobN+AaeFmpj2nYpLqjCGvZRDiSXLoEbdBEUNmhExavI+m
   LkEQRBT646KGEd6PIHx1dpyC2FTWR1uVJ+3y2Z/ZufyIy5NXqXYffFw1g
   y6/xI7qD5qoKATw2YMle6RzVm8M17nrnqoxOYDnNzqydnF6sp8Vm4FNH8
   qsfJnQ2ZIBHhdyXDCn8a9T/zmaz5quoOc7UaUNAGEKgbUMnZUm4DuAu4B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391701745"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391701745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014031667"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1014031667"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 13:13:04 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net 0/3][pull request] ice: restore timestamp config after reset
Date: Tue, 21 Nov 2023 13:12:54 -0800
Message-ID: <20231121211259.3348630-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jake Keller says:

We recently discovered during internal validation that the ice driver has
not been properly restoring Tx timestamp configuration after a device reset,
which resulted in application failures after a device reset.

After some digging, it turned out this problem is two-fold. Since the
introduction of the PTP support the driver has been clobbering the storage
of the current timestamp configuration during reset. Thus after a reset, the
driver will no longer perform Tx or Rx timestamps, and will report
timestamp configuration as disabled if SIOCGHWTSTAMP ioctl is issued.

In addition, the recently merged auxiliary bus support code missed that
PFINT_TSYN_MSK must be reprogrammed on the clock owner for E822 devices.
Failure to restore this register configuration results in the driver no
longer responding to interrupts from other ports. Depending on the traffic
pattern, this can either result in increased latency responding to
timestamps on the non-owner ports, or it can result in the driver never
reporting any timestamps. The configuration of PFINT_TSYN_MSK was only done
during initialization. Due to this, the Tx timestamp issue persists even if
userspace reconfigures timestamping.

This series fixes both issues, as well as removes a redundant Tx ring field
since we can rely on the skb flag as the primary detector for a Tx timestamp
request.

Note that I don't think this series will directly apply to older stable
releases (even v6.6) as we recently refactored a lot of the PTP code to
support auxiliary bus. Patch 2/3 only matters for the post-auxiliary bus
implementation. The principle of patch 1/3 and 3/3 could apply as far back
as the initial PTP support, but I don't think it will apply cleanly as-is.
---
This will conflict when merging with net-next.
Resolution:

--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@@ -7403,18 -7401,9 +7403,9 @@@ static void ice_rebuild(struct ice_pf *
  		goto err_vsi_rebuild;
  	}
  
- 	/* configure PTP timestamping after VSI rebuild */
- 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
- 		if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
- 			ice_ptp_cfg_timestamp(pf, false);
- 		else if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_ALL)
- 			/* for E82x PHC owner always need to have interrupts */
- 			ice_ptp_cfg_timestamp(pf, true);
- 	}
- 
 -	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_SWITCHDEV_CTRL);
 +	err = ice_eswitch_rebuild(pf);
  	if (err) {
 -		dev_err(dev, "Switchdev CTRL VSI rebuild failed: %d\n", err);
 +		dev_err(dev, "Switchdev rebuild failed: %d\n", err);
  		goto err_vsi_rebuild;
  	}

The following are changes since commit 9c6dc13106f2dd2d6819d66618b25a6f41f0ee6a:
  MAINTAINERS: Add indirect_call_wrapper.h to NETWORKING [GENERAL]
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jacob Keller (3):
  ice: remove ptp_tx ring parameter flag
  ice: unify logic for programming PFINT_TSYN_MSK
  ice: restore timestamp configuration after device reset

 drivers/net/ethernet/intel/ice/ice_main.c |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 144 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h |   1 -
 5 files changed, 83 insertions(+), 82 deletions(-)

-- 
2.41.0


