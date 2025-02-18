Return-Path: <netdev+bounces-167285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561BA399E7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC7E3B0C5B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E312239094;
	Tue, 18 Feb 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URJ3vlD8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04322E002
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876938; cv=none; b=LKSysEJO+vhfFNIiwO3hSM+v09XfkPxTQZR8uP6jDW4RP3FE8qOuP2gBC7K3lF4WGydlvz0ODCT9gybGgxkXDtPNC0GY+xJ6T9OOH2ydrH4kiRvo0pvmTeW0u/rrBp/G+quP2XmzZ8gBSG01SsdOJ7ddKMjHziSAMgh0MbgX+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876938; c=relaxed/simple;
	bh=3X2dgPpJyZyTnQWOE8WE4baPq7cvRLGJ4s/o352Q8fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uGOcFTbjX+f91TqfKWqOxKLjfWm1CNGMLnCATkpukPp3BVOjcmu82NiYI1c+NVl3bRZyxCtYTywwU8rwDjVLtP+NqwBSYk5VJ5NXFagiUq+kn7WcB3crzQUPmb0aABEGWRQk/F3XfWSqNLNxiXgvwtSFosSow1b08lQ0W7dfqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URJ3vlD8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739876933; x=1771412933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3X2dgPpJyZyTnQWOE8WE4baPq7cvRLGJ4s/o352Q8fY=;
  b=URJ3vlD8SSiM/+bqKZ4CqZaM9AYE0ABUC37lq6iY3uwHopwH+0jMu7dw
   OdG/c93zP2XybQZ/cL8VqaVf3bp7QtigPH7Cef2F8mor7lJb2NZlJ7kmK
   4imOOcx0RR4HCXI41ZY32wIa2M5szOpw6jo0M634VjpHw3ABS8YX0aeJc
   1g7OcEGMMgxlaIYBVM4E4QSWWqoEoIuR8tF+9aXcOXH+VDDBBTC6p6lis
   VRD/PJqs+7W5nw6MwbCkpGhHwJNUCtIPLA6HbESTAtV8EQt94gEW7ZA78
   M+VazUJzAzDoQbR++1Rfd2y9DvgqZidPklRtbsfF8zH/AGa1ip+D6BfAk
   w==;
X-CSE-ConnectionGUID: /ALitvpUTciDdO1kjzgO5g==
X-CSE-MsgGUID: aS9mE7oOS+yfOsmqDugFzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51208029"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="51208029"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 03:08:53 -0800
X-CSE-ConnectionGUID: 4ASgDcxRQv2Wk3+vP3rqbQ==
X-CSE-MsgGUID: 48W7XPZuRBmBPnf3Gvj7cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114233289"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 03:08:51 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v6 iwl-next 00/10] idpf: add initial PTP support
Date: Tue, 18 Feb 2025 12:07:15 +0100
Message-Id: <20250218110724.2263357-1-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Precision Time Protocol (PTP) to
Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
supported when the PTP capability is negotiated with the Control
Plane (CP). IDPF creates a PTP clock and sets a set of supported
functions.

During the PTP initialization, IDPF requests a set of PTP capabilities
and receives a writeback from the CP with the set of supported options.
These options are:
- get time of the PTP clock
- get cross timestamp
- set the time of the PTP clock
- adjust the PTP clock
- Tx timestamping

Each feature is considered to have direct access, where the operations
on PCIe BAR registers are allowed, or the mailbox access, where the
virtchnl messages are used to perform any PTP action. Mailbox access
means that PTP requests are sent to the CP through dedicated secondary
mailbox and the CP reads/writes/modifies desired resource - PTP Clock
or Tx timestamp registers.

Tx timestamp capabilities are negotiated only for vports that have
UPLINK_VPORT flag set by the CP. Capabilities provide information about
the number of available Tx timestamp latches, their indexes and size of
the Tx timestamp value. IDPF requests Tx timestamp by setting the
TSYN bit and the requested timestamp index in the context descriptor for
the PTP packets. When the completion tag for that packet is received,
IDPF schedules a worker to read the Tx timestamp value.

Current implementation of the IDPF driver does not allow to get stable
Tx timestamping, when more than 1 request per 1 second is sent to the
driver. Debug is in progress, however PTP feature seems to be affected by
the IDPF transmit flow, as the Tx timestamping relies on the completion
tag.

v5 -> v6: change locking mechanism in get_ts_info, clean timestamp
fields when preparing flow descriptor, add Rx filter
v4 -> v5: fix spin unlock when Tx timestamp index is requested
v3 -> v4: change timestamp filters dependent on Tx timestamp cap,
rewrite function that extends Tx timestamp value, minor fixes
v2 -> v3: fix minor issues, revert idpf_for_each_vport changes,
extend idpf_ptp_set_rx_tstamp, split tstamp statistics
v1 -> v2: add stats for timestamping, use ndo_hwtamp_get/set,
fix minor spelling issues

Milena Olech (10):
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping
  idpf: change the method for mailbox workqueue allocation

 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  34 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  74 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  45 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 983 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 350 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 174 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 677 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 +++++-
 18 files changed, 2858 insertions(+), 102 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: d142eb657bb0367effe3c1a43f170dda379176b2
-- 
2.31.1


