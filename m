Return-Path: <netdev+bounces-100388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236DB8FA5CA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26A31F23ECC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663213E036;
	Mon,  3 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHbRwB0D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAA13D8B2
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454303; cv=none; b=Q0he04RhSMNYVc5+l/ad8FYdCtztsJ/TKxsbDvTtIztgsgvT8/PuWIK6zIyO3r3YH2T4iFoyi3OeWS3m/pENUEbyf3rmNyTVD0lodg6ZsACj+HIg9/y7MP4FOBxHxenbH/LZGLxBSd6KgNUATXgrTUuaCl+JuoWHb7tkisk4uZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454303; c=relaxed/simple;
	bh=CPnhehRogum4rtVIL0GC1rZXbOQrbojpQv/NriwaFIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=epS0jyoaHhRxidepWCo0OAcx8POtbcnsFlNrtsWmKqUmqq413EifdKRbhKYe/gp3/dVb3OSIqeplGtAOnPh5glvqh/dw4SPUAo4TXZWghCeW6M3nqccGrkGzVl+3M/MtvKb4GOiLz+/QXNqNHLIgkg82jVsaaeDONgmBuNJFkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHbRwB0D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454302; x=1748990302;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=CPnhehRogum4rtVIL0GC1rZXbOQrbojpQv/NriwaFIU=;
  b=QHbRwB0DWxiXgWpqs7KWgDlKAn4EVNcf0LC56uwivuXhMfH/4D8g2Qc+
   3fY/xUDAJEY12U1e6QE+jyPCAeU8W2NqKQosSaCJ/SnZR4GHA7pnqqK8v
   1Xp598JkB/5oGPNT1SwCfimdIarYZPUDZvighPZg6bcCvD5Rw+QcxBTw8
   Sa/QX2EG4xwtmxH4LnMTqUvdiKgjRGmb5lmh5lNOxJlw7Alcv6ZMpx8p+
   zfCANQrTM0Rq/Nrm6HbGe2yIMZ7JdXfyS3ScpicXHr8VjjHBUHsG4siQ2
   nzkCd99dq9Hcnt4UkKXkY2XqlGzYCY9Dq+7vAp4RzWKuoZE4UPKr5mzsa
   A==;
X-CSE-ConnectionGUID: Xc/Jvp3+TCujZmeulHoUHA==
X-CSE-MsgGUID: jGggj9B+RFelh3ny71YmgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780098"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:21 -0700
X-CSE-ConnectionGUID: assjV7R3SfO2XwJsonVrIQ==
X-CSE-MsgGUID: 0k7ndTyDQNmLJknx1B1VmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471170"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/9] Intel Wired LAN Driver Updates 2024-06-03
Date: Mon, 03 Jun 2024 15:38:12 -0700
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRFXmYC/yXNQQ5AMBCF4avIrE3SVlW4ilhQg0mkpG1EIu6uW
 H7/4r0LAnmmAE12gaeDA28uQeYZ2KV3MyGPyaCE0sKIAh2dEV+hMJjMLtL616GPdkFdFtVAsh6
 tkpBmdk8Tn99F2933A3Re80FyAAAA
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Eric Joyner <eric.joyner@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Karen Ostrowska <karen.ostrowska@intel.com>, 
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Menachem Fogel <menachem.fogel@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>, Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

This series includes miscellaneous improvements for the ice and igc, as
well as a cleanup to the Makefiles for all Intel net drivers.

Andy fixes all of the Intel net driver Makefiles to use the documented
'*-y' syntax for specifying object files to link into kernel driver
modules, rather than the '*-objs' syntax which works but is documented as
reserved for user-space host programs.

Michal Swiatkowski has four patches to prepare the ice driver for
supporting subfunctions. This includes some cleanups to the locking around
devlink port creation as well as improvements to the driver's handling of
port representor VSIs.

Jacob has a cleanup to refactor rounding logic in the ice driver into a
common roundup_u64 helper function.

Michal Schmidt replaces irq_set_affinity_hint() to use
irq_update_affinity_hint() which behaves better with user-applied affinity
settings.

Eric improves checks to the ice_vsi_rebuild() function, checking and
reporting failures when the function is called during a reset.

Vitaly adds support for ethtool .set_phys_id, used for blinking the device
LEDs to identify the physical port for which a device is connected to.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Andy Shevchenko (1):
      net: intel: Use *-y instead of *-objs in Makefile

Eric Joyner (1):
      ice: Check all ice_vsi_rebuild() errors in function

Jacob Keller (1):
      ice: add and use roundup_u64 instead of open coding equivalent

Michal Schmidt (1):
      ice: use irq_update_affinity_hint()

Michal Swiatkowski (4):
      ice: store representor ID in bridge port
      ice: move devlink locking outside the port creation
      ice: move VSI configuration outside repr setup
      ice: update representor when VSI is ready

Vitaly Lifshits (1):
      igc: add support for ethtool.set_phys_id

 drivers/net/ethernet/intel/e1000/Makefile          |  2 +-
 drivers/net/ethernet/intel/e1000e/Makefile         |  7 +-
 drivers/net/ethernet/intel/i40e/Makefile           |  2 +-
 drivers/net/ethernet/intel/iavf/Makefile           |  5 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  2 -
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       | 85 ++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h       | 14 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          | 17 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  3 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  2 +-
 drivers/net/ethernet/intel/igb/Makefile            |  6 +-
 drivers/net/ethernet/intel/igbvf/Makefile          |  6 +-
 drivers/net/ethernet/intel/igc/Makefile            |  6 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       | 22 ++++++
 drivers/net/ethernet/intel/igc/igc_ethtool.c       | 32 ++++++++
 drivers/net/ethernet/intel/igc/igc_hw.h            |  2 +
 drivers/net/ethernet/intel/igc/igc_leds.c          | 21 +-----
 drivers/net/ethernet/intel/igc/igc_main.c          |  2 +
 drivers/net/ethernet/intel/ixgbe/Makefile          |  8 +-
 drivers/net/ethernet/intel/ixgbevf/Makefile        |  6 +-
 drivers/net/ethernet/intel/libeth/Makefile         |  2 +-
 drivers/net/ethernet/intel/libie/Makefile          |  2 +-
 include/linux/math64.h                             | 28 +++++++
 29 files changed, 214 insertions(+), 98 deletions(-)
---
base-commit: 83042ce9b7c39b0e64094d86a70d62392ac21a06
change-id: 20240603-next-2024-06-03-intel-next-batch-4537be19dc21

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


