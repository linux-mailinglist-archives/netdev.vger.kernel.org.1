Return-Path: <netdev+bounces-88975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F48A925D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3731F22607
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D74F1E4;
	Thu, 18 Apr 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPIbr2eq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EC1755B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418470; cv=none; b=WY1VNP1zRJY/413ZPI8gpte6dlYIy6HPGszDYV3lyvM9tk1XOsoP7530W39I/iRL7Ug5daSVewZnvg9raCDbu6jLpPLWS4xMssPkbSPUfLBxWCvm0EscXC6uvi62peXwAV3gnlF9ZgBDMQhjpIp/dTM2sNDh9TK8S8dGZRkrRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418470; c=relaxed/simple;
	bh=nUCZ6MzDQkmuq8iV4mMLyZ2qoJhcoe/emBPH5fyR0hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=II53Jjjsy2C+a4ssF9W4IcHRAHvkahPCqTbJLR3VNWeyv6PdbXFxUkhhyLLCT3g+fbGax6XXL9MXc7SOB3u8u93v2b1oHA6vIHvKMviRI5QAzkNwGNebGSB8QkPj7E/hNh2kJR7/gjpIW0vykwLxeZt7mSsTEDeIMScMNbODacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPIbr2eq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418469; x=1744954469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nUCZ6MzDQkmuq8iV4mMLyZ2qoJhcoe/emBPH5fyR0hw=;
  b=fPIbr2eqzo13gHiKKKpeVCKkVXDILDhZI8B7wX4Xehb8xo5U4Ou5wMWz
   3QFquSX28sb8iL4PInEGBto/7K9md+r85TYs2QXx4ry292nH9Bkei2Yzk
   dAyu8ZF2nS2O7VFHL9CFj7FIiUQlozKlLAXfkDY4qV9lUfbR9vidnFIy3
   osWwcRq9XnE+ydPbcv6VIfHVOH5Lggppz8o1GobjZNwgbW6PhRJ1S2SZQ
   mxFX8ISVKXDTUShg2t9DemxEV04Oc+QRNEllUjPVOREJfz4eklg1/14OP
   33Q6b+EMRvwanRoCwxpcZstmJ+NL8RIN+U2xPicdx3Ele2klUx24KXwZd
   A==;
X-CSE-ConnectionGUID: Htgkf0nCTh2QOw9NhcutOQ==
X-CSE-MsgGUID: +nQfTnfDScmCR/mWonELMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20332374"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20332374"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:34:28 -0700
X-CSE-ConnectionGUID: 1+5p7IGiRWy5dod1MqjWEQ==
X-CSE-MsgGUID: SxA80oJUQiKa5WW9vgQwJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="60292202"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 17 Apr 2024 22:34:26 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C13B727BA1;
	Thu, 18 Apr 2024 06:34:24 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v5 00/12] Add support for Rx timestamping for both ice and iavf drivers.
Date: Thu, 18 Apr 2024 01:24:48 -0400
Message-Id: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v5:
- fixed all new issues generated by this series in kernel-doc

v4:
- fixed duplicated argument in iavf_virtchnl.c reported by coccicheck
https://lore.kernel.org/netdev/20240410121706.6223-1-mateusz.polchlopek@intel.com/

v3:
- added RB in commit 6
- removed inline keyword in commit 9
- fixed sparse issues in commit 9 and commit 10
- used GENMASK_ULL when possible in commit 9
https://lore.kernel.org/netdev/20240403131927.87021-1-mateusz.polchlopek@intel.com/

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
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 245 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 548 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  46 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 426 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  26 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 150 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 238 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 127 +++-
 17 files changed, 1786 insertions(+), 161 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h

-- 
2.38.1


