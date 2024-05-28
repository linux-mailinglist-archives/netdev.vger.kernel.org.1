Return-Path: <netdev+bounces-98804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32A8D287D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51BF2875CA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0F13E05F;
	Tue, 28 May 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaV+odoB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B017C6A
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937452; cv=none; b=gKUUoXI0DiQEbrEvttrA5mzakYieRPcpeakiUH8RdgA2SHJCeTp2O4OJvq7MmBp3BEEJ/xJKkznCgVZHQGabETwd7gXUesbBACXVGSSiV4Xss6y9n/kWDj2kDJ7GOW568m8274+GycisevzR+AaAYNubYUXsnhN5/0XyyM5yaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937452; c=relaxed/simple;
	bh=neNZ0trLxDq4KaYQSz2CuIGTMdO5JxtWmoq/N4ka65Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RPHMH2Czgcz04tz9MZL7L5pkByi7YevUEkQ3Oh38EHRPY3Cp71M4RZ1zfzHvtpMR+VUEYLjIevaUS7bGDZNJz79MIlayNgbQGQL2X24PLC3StSJj4XmvNz6Ebf0NztZwVHfgDPhE5APHtxrDd6gnf9GDp5rlCBRxps2ezYwnpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaV+odoB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937451; x=1748473451;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=neNZ0trLxDq4KaYQSz2CuIGTMdO5JxtWmoq/N4ka65Q=;
  b=KaV+odoB2gC+sy4KMYLYQoZEQ3BNkcyHIjC8Ka2jyIyESqp7aqN2yy7B
   y5NgID9m5qvy9udE4fL4ejf9vwwHKLwCVfIqyBkcYSbLzrSRCVOWe/8mY
   SyQ1Yr0Ti6k+zckytZYenpX/d+T+lZLaQTS+GiMjNh0OcuhUIRUrodMAO
   HmzF5DpuH4uILtV+fJabAHnu9yh2+tcmUlevGh6NrPGHXFTgQa+PwcYtG
   i4pdlm5HfSvboTv8oH5AQ5QjfgsG+LCkhmc3z7g5+2xEZTu6ebSxFARiU
   ZDePwOTYCW/HzetnTr/8rULcuqxL7kwc1FNMjf8HBa2jfS9iP1OueB4s0
   A==;
X-CSE-ConnectionGUID: HtwOFDn6R8WgplwcZt4k+A==
X-CSE-MsgGUID: 5aHqtTPpSEe/zHULKtb3OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13444857"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13444857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:11 -0700
X-CSE-ConnectionGUID: rSlfM6XdQ1ycz/dDOOONrQ==
X-CSE-MsgGUID: jbWKEqYbQYWzWk51Wn/gMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39672273"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH next 00/11] ice: Introduce ETH56G PHY model for E825C
 products
Date: Tue, 28 May 2024 16:03:50 -0700
Message-Id: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdiVmYC/x3MSwqAMAxF0a1IxgZqtf62Ig60Rs2klraIIO7d6
 PDwePeGSIEpQp/dEOjkyIcTFHkGdp/cRsiLGLTSlTK6RUdXwk+oDIp98hhonWw6QsSqs2VTN/U
 6mw6k4WXi6+8P8F1hfJ4Xvliot3UAAAA=
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Michal Michalik <michal.michalik@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>, 
 Pawel Kaminski <pawel.kaminski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
X-Mailer: b4 0.13.0

E825C products have a different PHY model than E822, E823 and E810 products.
This PHY is ETH56G and its support is necessary to have functional PTP stack
for E825C products.

This series refactors the ice driver to add support for the new PHY model.

Karol introduces the ice_ptp_hw structure. This is used to replace some
hard-coded values relating to the PHY quad and port numbers, as well as to
hold the phy_model type.

Jacob refactors the driver code that converts between the ice_ptp_tmr_cmd
enumeration and hardware register values to better re-use logic and reduce
duplication when introducing another PHY type.

Sergey introduces functions to help enable and disable the Tx timestamp
interrupts. This makes the ice_ptp.c code more generic and encapsulates the
PHY specifics into ice_ptp_hw.c

Karol introduces helper functions to clear the valid bits for Tx and Rx
timestamps. This enables informing hardware to discard stale timestamps
after performing clock operations.

Sergey moves the Clock Generation Unit (CGU) logic out of the E822 specific
area of the ice_ptp_hw.c file as it will be re-used for other device PHY
models.

Jacob introduces a helper function for obtaining the base increment values,
moving this logic out of ice_ptp.c and into the ice_ptp_hw.c file to better
encapsulate hardware differences.

Sergey builds on these refactors to introduce the new ETH56G PHY model used
by the E825C products. This includes introducing the required helpers,
constants, and PHY model checks.

Karol simplifies the CGU logic by using anonymous structures, dropping an
unnecessary ".field" name for accessing the CGU data.

Michal Michalik updates the CGU logic to support the E825C hardware,
ensuring that the clock generation is configured properly.

Grzegorz Nitka adds support to read the NAC topology data from the device.
This is in preparation for supporting devices which combine two NACs
together, connecting all ports to the same clock source. This enables the
driver to determine if its operating on such a device, or if its operating
on the standard 1-NAC configuration.

Grzsecgorz Nitka adjusts the PTP initialization to prepare for the 2x50G
E825C devices, introducing special mapping for the PHY ports to prepare for
support of the 2-NAC devices.

With this, the ice driver is capable of handling PTP for the single-NAC
E825C devices. Complete support for the 2-NAC devices requirs some work on
how the ports connect to the clock owner. During review of this work, it
was pointed out that our existing use of auxiliary bus is disliked, and
Jiri requested that we change it. We are currently working on developing a
replacement solution for the auxiliary bus implementation and have dropped
the relevant changes out of this series. A future series will refactor the
port to clock connection, at which time we will finish the support for
2-NAC E825C devices.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Grzegorz Nitka (2):
      ice: Add NAC Topology device capability parser
      ice: Adjust PTP init for 2x50G E825C devices

Jacob Keller (2):
      ice: Introduce helper to get tmr_cmd_reg values
      ice: Introduce ice_get_base_incval() helper

Karol Kolacinski (3):
      ice: Introduce ice_ptp_hw struct
      ice: Add PHY OFFSET_READY register clearing
      ice: Change CGU regs struct to anonymous

Michal Michalik (1):
      ice: Add support for E825-C TS PLL handling

Sergey Temerkhanov (3):
      ice: Implement Tx interrupt enablement functions
      ice: Move CGU block
      ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h   |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c     |   74 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |    2 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c        |  208 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h        |    1 +
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h |  402 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     | 3256 +++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h     |  295 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h    |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h       |   58 +-
 12 files changed, 3754 insertions(+), 634 deletions(-)
---
base-commit: 4b3529edbb8ff069d762c6947e055e10c1748170
change-id: 20240528-next-2024-05-28-ptp-refactors-49c37676fb59

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


