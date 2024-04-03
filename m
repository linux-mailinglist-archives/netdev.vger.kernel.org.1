Return-Path: <netdev+bounces-84495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE91897104
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF363282152
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83741482F2;
	Wed,  3 Apr 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERFIcOwA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A58147C94
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150897; cv=none; b=U9yQxjX8zC80zBYbCyvlGxTTq6tcULLC/tPmwPxXr8by7El/gbtac+x6mAHlb5eOWFIMAk9WdiDzMVOP9nxla0SoynyZzHYiCYIRZ4dfOjE8OftnMzZbZPcJlPP2ophmXFBzJpeVZ8RausU9b8DbQyorws9yMdwtUD9c8+BYT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150897; c=relaxed/simple;
	bh=Z22CW2uny+60i1lQ3QoTbdSwPrcibQuglJCnv1A7FCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddLy5pQ5/6nw+6MSd+Qyc6ysUcnNw8OBqPZ1egZiAfLAfnRHinIVgw1cEYOvAVSOdTlC8b+GIoqtGjZv4rtOyADAZST6JfHtfGYs5WDVNqlCCuEb9U2X5PKiK39A79U7QFAuHh+ZOAojNFYVqJZoY9lLSuPR4oVW+0+TyF5spX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERFIcOwA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712150895; x=1743686895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z22CW2uny+60i1lQ3QoTbdSwPrcibQuglJCnv1A7FCA=;
  b=ERFIcOwA7cs2Y++rPus9iabg7g/r9FEn54PUrvITu0JcOtwqQyCZA+B6
   rqx2bv8/r2KohSDmaUQQxDPVfFuoMuiOnXg9snCXH5ewFUXCPcSZQ4h3t
   Ptg0i6yWCLpUd/Mzt9Ce0OXi3k26fuVX9q9MSqe8bdlLB4GGQwaqJ0kxe
   HIjWDj541cQQFUy9gsf6ONJlBVkNNGc3xQ3iLryf2/IN1opbx8k2yU1YR
   /kjFprlM4CV+3ITB8z2L0HkIB+GIOkM33gH3Wgx2bA4uAhFoJPs5/gcCj
   QVRa8sMTfwAw59hB29lKgNIQVM1TfLC3pz1ubXYObq3HCWRP2DO0WqNfE
   A==;
X-CSE-ConnectionGUID: uY/TXnRBRb+xZ49mfu80+Q==
X-CSE-MsgGUID: klTn35R6SHy6C91mapBQFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7568719"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7568719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:28:15 -0700
X-CSE-ConnectionGUID: mKfVT6VNQ9Siq2cicy0Uyw==
X-CSE-MsgGUID: JAHFWsW4RseSlE4M8cObAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="41592026"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 03 Apr 2024 06:28:13 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5285436A19;
	Wed,  3 Apr 2024 14:28:12 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v3 00/12] Add support for Rx timestamping for both ice and iavf drivers
Date: Wed,  3 Apr 2024 09:19:15 -0400
Message-Id: <20240403131927.87021-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Rx timestamping for both ice and iavf drivers.

Initially, during VF creation it registers the PTP clock in
the system and negotiates with PF it's capabilities. In the
meantime the PF enables the Flexible Descriptor for VF.
Only this type of descriptor allows to receive Rx timestamps.

Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Enable timestamping should be done using SIOCSHWTSTAMP ioctl,
e.g.
hwstamp_ctl -i $VF -r 14

In order to report the timestamps to userspace, the VF extends
timestamp to 40b.

To support this feature the flexible descriptors and PTP part
in iavf driver have been introduced.

---
v3:
- added RB in commit 6
- removed inline keyword in functions in commit 9
- fixed sparse issues in commit 9 and commit 10
- used GENMASK_ULL where possible in commit 9

v2:
- fixed warning related to wrong specifier to dev_err_once in
  commit 7
- fixed warnings related to unused variables in commit 9
https://lore.kernel.org/netdev/20240327132543.15923-1-mateusz.polchlopek@intel.com/

v1:
- initial series
https://lore.kernel.org/netdev/20240326115116.10040-1-mateusz.polchlopek@intel.com/
---

Jacob Keller (10):
  virtchnl: add support for enabling PTP on iAVF
  virtchnl: add enumeration for the rxdid format
  iavf: add support for negotiating flexible RXDID format
  iavf: negotiate PTP capabilities
  iavf: add initial framework for registering PTP clock
  iavf: add support for indirect access to PHC time
  iavf: periodically cache PHC time
  iavf: refactor iavf_clean_rx_irq to support legacy and flex
    descriptors
  iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
  iavf: add support for Rx timestamps to hotpath

Mateusz Polchlopek (1):
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  33 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 242 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 530 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  46 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 424 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  26 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 150 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 237 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 127 ++++-
 17 files changed, 1762 insertions(+), 161 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h

-- 
2.38.1


