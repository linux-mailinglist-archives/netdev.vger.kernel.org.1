Return-Path: <netdev+bounces-45997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204597E0C63
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70510B211D2
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41371262A7;
	Fri,  3 Nov 2023 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byz1p1BQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DC1D558
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 23:47:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65D1D44
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699055223; x=1730591223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YzpM3LzEmQIUG3/odpo1c+6u7KJG5TwlvRoNOTVPvHM=;
  b=byz1p1BQDY0+mCiBMpoWzcKbT0fQN6K3jjne0ahB6F4m6HT9yyEDF9eR
   6pY8/JMHa/fYsRjkZ8fP/uKoEJyQcYVss8lWD6QfFvBJTColzYvp5twde
   MCLsmRYBL2OX/Qz5aGZWAntWO/JxfJeFtYaAVsDQZfs/BVkZeUfJvBL/j
   bundQgjbqo1zSRbBtMoeGwbVk4gy6jQQP971dEc/21Qx4XeGEpWyqW1zo
   fARb3uIF87ENMnE68pcRfMLlSvOAA4LHHfJq1l3dqOOgxSxzU27Be+ep5
   XkBW/IzCHA8h/SgkT0NGlYek5ny1AxvzguMjQn2Q+pCqyUICcKId2QYrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="374076054"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="374076054"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 16:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="905504333"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="905504333"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 16:47:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 0/3] ice: restore timestamp config after reset
Date: Fri,  3 Nov 2023 16:46:55 -0700
Message-ID: <20231103234658.511859-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This was originally posted to net-next before 6.6 release, and later posted
as a v2 to net. I'm re-posting this to Tony's Intel Wired LAN dev queue so
we can queue it up since its driver only changes.

Changes since v2
* rebased on to Tony's net dev-queue to send through IWL

net V2 was posted here:
https://lore.kernel.org/netdev/20231031222725.2819172-1-jacob.e.keller@intel.com/

Changes since v1
* Update target to net and rebase onto current net tree.
* Add appropriate fixes tag to 1/3.
* Slightly update the cover message.
* picked up Jesse's Reviewed-by tag.

net-next V1 was posted here:
https://lore.kernel.org/netdev/20231028002322.2224777-1-jacob.e.keller@intel.com/

Jacob Keller (3):
  ice: remove ptp_tx ring parameter flag
  ice: unify logic for programming PFINT_TSYN_MSK
  ice: restore timestamp configuration after device reset

 drivers/net/ethernet/intel/ice/ice_main.c |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 146 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h |   1 -
 5 files changed, 84 insertions(+), 83 deletions(-)


base-commit: 1405b6c08fc9d3ba6c01de477556d127534ce52f
-- 
2.41.0


