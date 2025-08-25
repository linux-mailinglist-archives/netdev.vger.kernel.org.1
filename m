Return-Path: <netdev+bounces-216672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B8B34E66
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F23316874E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864D29D26A;
	Mon, 25 Aug 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERFXpEzP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885329B77E
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158628; cv=none; b=Xs7HSxUkJRfbDU9q5ZhJ1z6DwA9SegAjYy15vltY0zR+jgRE+1/LGHqU0kA3sOJ6KkXPDyDADSwf5khKWPLljx+tji0zdcQafB+ZajEcXF0W5O7TJO3WpRAXjEGXzpk8DCPcjQeZjHffIRAya+Mt4oyTUVym+Ve8aySXYLJnRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158628; c=relaxed/simple;
	bh=J7jzlYyHYqhSLsKNaBelpl2AG7nDpx3HcMbNCsj7g3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tojZkkIAd0PeEIqvb+l+58d3Mmfl7Pvk5d6AdoT2CXTAPvJBwEE5iOvT0WpOTyOJ3vMtjxszISAgIfiysvf7KEc9bkJLKx8IoMoYBJ4+vHZOrrJzKNz0hpoHLC3g122UQh5jAHKIcw9TRovaFKMT/is47VqkUHiHmyaVxdtI+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERFXpEzP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158627; x=1787694627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7jzlYyHYqhSLsKNaBelpl2AG7nDpx3HcMbNCsj7g3Y=;
  b=ERFXpEzPjQ2HFYUl9xbB/kz3FXIkex4RC9tAi6FqLgpEK2HP9WqwiPno
   vXU0fe0fiMk6OxFXgnW+asnC8KO97dR+HOe+oLjzGxYgFawIesYm77Qj/
   tBph0d8FVuqpkELoKee+vw9tV7/ha3gD6YVZwRZGXkp/sLcpnQAtRWK/b
   AWn8orgNCKmNoJh5i0+28mCu2wSS/IwPBvgm76V8WvrLlWCOBHxrkSdul
   I7mYMP4ioxlDiwMjZUG4cqG88twf67JI0EB1PZe2bIyw6NUluuVMzhH5K
   XosfN7SjnAyVfNJ8LzfqgzvbQq2asAOksGga/0ncUDu+1PunIZpiATGgf
   w==;
X-CSE-ConnectionGUID: 0979uEfNSVyH8dqu2GZHjg==
X-CSE-MsgGUID: +ww0gynfSXyoG6eRwBVAWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651369"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651369"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:25 -0700
X-CSE-ConnectionGUID: x8qzQp8WQ0C1IXMdCfMB2A==
X-CSE-MsgGUID: eGJe4eR+SJyz+cJu7uxflA==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	vgrinber@redhat.com,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/5] ice: don't leave device non-functional if Tx scheduler config fails
Date: Mon, 25 Aug 2025 14:50:13 -0700
Message-ID: <20250825215019.3442873-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
configuration based on NVM parameters, selecting either a 5 or 9 layer
topology.

As part of this flow, the driver acquires the "Global Configuration Lock",
which is a hardware resource associated with programming the DDP package
to the device. This "lock" is implemented by firmware as a way to
guarantee that only one PF can program the DDP for a device. Unlike a
traditional lock, once a PF has acquired this lock, no other PF will be
able to acquire it again (including that PF) until a CORER of the device.
Future requests to acquire the lock report that global configuration has
already completed.

The following flow is used to program the Tx topology:

 * Read the DDP package for scheduler configuration data
 * Acquire the global configuration lock
 * Program Tx scheduler topology according to DDP package data
 * Trigger a CORER which clears the global configuration lock

This is followed by the flow for programming the DDP package:

 * Acquire the global configuration lock (again)
 * Download the DDP package to the device
 * Release the global configuration lock.

However, if configuration of the Tx topology fails, (i.e.
ice_get_set_tx_topo returns an error code), the driver exits
ice_cfg_tx_topo() immediately, and fails to trigger CORER.

While the global configuration lock is held, the firmware rejects most
AdminQ commands, as it is waiting for the DDP package download (or Tx
scheduler topology programming) to occur.

The current driver flows assume that the global configuration lock has been
reset by CORER after programming the Tx topology. Thus, the same PF
attempts to acquire the global lock again, and fails. This results in the
driver reporting "an unknown error occurred when loading the DDP package".
It then attempts to enter safe mode, but ultimately fails to finish
ice_probe() since nearly all AdminQ command report error codes, and the
driver stops loading the device at some point during its initialization.

The only currently known way that ice_get_set_tx_topo() can fail is with
certain older DDP packages which contain invalid topology configuration, on
firmware versions which strictly validate this data. The most recent
releases of the DDP have resolved the invalid data. However, it is still
poor practice to essentially brick the device, and prevent access to the
device even through safe mode or recovery mode. It is also plausible that
this command could fail for some other reason in the future.

We cannot simply release the global lock after a failed call to
ice_get_set_tx_topo(). Releasing the lock indicates to firmware that global
configuration (downloading of the DDP) has completed. Future attempts by
this or other PFs to load the DDP will fail with a report that the DDP
package has already been downloaded. Then, PFs will enter safe mode as they
realize that the package on the device does not meet the minimum version
requirement to load. The reported error messages are confusing, as they
indicate the version of the default "safe mode" package in the NVM, rather
than the version of the file loaded from /lib/firmware.

Instead, we need to trigger CORER to clear global configuration. This is
the lowest level of hardware reset which clears the global configuration
lock and related state. It also clears any already downloaded DDP.
Crucially, it does *not* clear the Tx scheduler topology configuration.

Refactor ice_cfg_tx_topo() to always trigger a CORER after acquiring the
global lock, regardless of success or failure of the topology
configuration.

We need to re-initialize the HW structure when we trigger the CORER. Thus,
it makes sense for this to be the responsibility of ice_cfg_tx_topo()
rather than its caller, ice_init_tx_topology(). This avoids needless
re-initialization in cases where we don't attempt to update the Tx
scheduler topology, such as if it has already been programmed.

There is one catch: failure to re-initialize the HW struct should stop
ice_probe(). If this function fails, we won't have a valid HW structure and
cannot ensure the device is functioning properly. To handle this, ensure
ice_cfg_tx_topo() returns a limited set of error codes. Set aside one
specifically, -ENODEV, to indicate that the ice_init_tx_topology() should
fail and stop probe.

Other error codes indicate failure to apply the Tx scheduler topology. This
is treated as a non-fatal error, with an informational message informing
the system administrator that the updated Tx topology did not apply. This
allows the device to load and function with the default Tx scheduler
topology, rather than failing to load entirely.

Note that this use of CORER will not result in loops with future PFs
attempting to also load the invalid Tx topology configuration. The first PF
will acquire the global configuration lock as part of programming the DDP.
Each PF after this will attempt to acquire the global lock as part of
programming the Tx topology, and will fail with the indication from
firmware that global configuration is already complete. Tx scheduler
topology configuration is only performed during driver init (probe or
devlink reload) and not during cleanup for a CORER that happens after probe
completes.

Fixes: 91427e6d9030 ("ice: Support 5 layer topology")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c  | 44 ++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++---
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index e2a036ce76ca..3b2d9c436979 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2377,7 +2377,13 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
  * The function will apply the new Tx topology from the package buffer
  * if available.
  *
- * Return: zero when update was successful, negative values otherwise.
+ * Return:
+ * * 0 - Successfully applied topology configuration.
+ * * -EBUSY - Failed to acquire global configuration lock.
+ * * -EEXIST - Topology configuration has already been applied.
+ * * -EIO - Unable to apply topology configuration.
+ * * -ENODEV - Failed to re-initialize device after applying configuration.
+ * * Other negative error codes indicate unexpected failures.
  */
 int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 {
@@ -2410,7 +2416,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
-		return status;
+		return -EIO;
 	}
 
 	/* Is default topology already applied ? */
@@ -2497,31 +2503,45 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to acquire global lock\n");
-		return status;
+		return -EBUSY;
 	}
 
 	/* Check if reset was triggered already. */
 	reg = rd32(hw, GLGEN_RSTAT);
 	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
-		/* Reset is in progress, re-init the HW again */
 		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. Layer topology might be applied already\n");
 		ice_check_reset(hw);
-		return 0;
+		/* Reset is in progress, re-init the HW again */
+		goto reinit_hw;
 	}
 
 	/* Set new topology */
 	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
 	if (status) {
-		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology\n");
-		return status;
+		ice_debug(hw, ICE_DBG_INIT, "Failed to set Tx topology, status %pe\n",
+			  ERR_PTR(status));
+		/* only report -EIO here as the caller checks the error value
+		 * and reports an informational error message informing that
+		 * the driver failed to program Tx topology.
+		 */
+		status = -EIO;
 	}
 
-	/* New topology is updated, delay 1 second before issuing the CORER */
+	/* Even if Tx topology config failed, we need to CORE reset here to
+	 * clear the global configuration lock. Delay 1 second to allow
+	 * hardware to settle then issue a CORER
+	 */
 	msleep(1000);
 	ice_reset(hw, ICE_RESET_CORER);
-	/* CORER will clear the global lock, so no explicit call
-	 * required for release.
-	 */
+	ice_check_reset(hw);
+
+reinit_hw:
+	/* Since we triggered a CORER, re-initialize hardware */
+	ice_deinit_hw(hw);
+	if (ice_init_hw(hw)) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
+		return -ENODEV;
+	}
 
-	return 0;
+	return status;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0b06c1e02b..cae992d8f03c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4536,17 +4536,23 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 			dev_info(dev, "Tx scheduling layers switching feature disabled\n");
 		else
 			dev_info(dev, "Tx scheduling layers switching feature enabled\n");
-		/* if there was a change in topology ice_cfg_tx_topo triggered
-		 * a CORER and we need to re-init hw
+		return 0;
+	} else if (err == -ENODEV) {
+		/* If we failed to re-initialize the device, we can no longer
+		 * continue loading.
 		 */
-		ice_deinit_hw(hw);
-		err = ice_init_hw(hw);
-
+		dev_warn(dev, "Failed to initialize hardware after applying Tx scheduling configuration.\n");
 		return err;
 	} else if (err == -EIO) {
 		dev_info(dev, "DDP package does not support Tx scheduling layers switching feature - please update to the latest DDP package and try again\n");
+		return 0;
+	} else if (err == -EEXIST) {
+		return 0;
 	}
 
+	/* Do not treat this as a fatal error. */
+	dev_info(dev, "Failed to apply Tx scheduling configuration, err %pe\n",
+		 ERR_PTR(err));
 	return 0;
 }
 
-- 
2.47.1


