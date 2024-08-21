Return-Path: <netdev+bounces-120533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538C959B87
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00328333C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887516C86B;
	Wed, 21 Aug 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jnt5U1fP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDA166F26
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242713; cv=none; b=Suq9s0p3nf19JcSdcLmQB9PvY2K0huGYvJdmmWxC4ySlUWhKzw1QYsnfn6IkWakI7Z+y6Ki6LZ8gxJ6k3mN/3UiddccgtCBwM0p/zu0OTyocNhDM0ZQyrV1j2PcboLGil7BcGDS5HK3awntD1k2F640ijd+DgzIzS/3PI5P83TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242713; c=relaxed/simple;
	bh=OPnRBzvKZWyyz7eDVVY49Nhm3OL9Pr4f3e5BJJuLy9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9Zkzq0l2iI4rK6aO3EjGCVjzMOFqBwfnipf4jK5WraFlPQOM4XV94GsYWK/13CZLxiIZ8aQhEeR1Nw32JrLLLyj7Frr8VE1k2JstyGb55/6ACIB3kPYkjlgiwGTg8ypWvxSrumLfEDYtFYaa+8+LeCSoR9Ctb90VU15cHJljJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jnt5U1fP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242712; x=1755778712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OPnRBzvKZWyyz7eDVVY49Nhm3OL9Pr4f3e5BJJuLy9g=;
  b=Jnt5U1fPIyDrdUUPcmKcG/bklUMbnfz3ED73JFRlsAQJmGKVLTkvBd53
   Jb1W8s4M7uCBbLsOzH8DeN0m7n+TE6gH8G6/eqEL5EhrZJO2MSxhrvwil
   GWZ8Gbx8Ui/fTeUigGpnVyfodGz+quD0p4GTaFPzBpGQ7Jm62K3U8FRkz
   xd1Te5I6KkE5oBCxn1sEFPw5SRaPecwBG06qUAZ6IsUGeAqG6Re7vtQ6+
   it2Yy1cPhQcm8npjL8DsR5rmb0B8BYEgPRGrmRM4isZYdD8fgiHMhUn0B
   0ZTSw8ByjEhOuIrZwHj8a5MOSPA5FMGkVryxUNL4tNflWoiKtBB/myDnW
   A==;
X-CSE-ConnectionGUID: oEwTvDyXR4C0rek/Lq1GLg==
X-CSE-MsgGUID: wlP6s27KQ5Sv/WnOt2vvAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34017078"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34017078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:18:18 -0700
X-CSE-ConnectionGUID: i0XSeIlQRZSAt3IdDoUPRQ==
X-CSE-MsgGUID: YvHyOz8WRAiRoOq9X89BQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60732472"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2024 05:18:14 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B548028789;
	Wed, 21 Aug 2024 13:18:12 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	alexandr.lobakin@intel.com
Subject: [PATCH iwl-next v10 00/14] Add support for Rx timestamping for both ice and iavf drivers
Date: Wed, 21 Aug 2024 14:15:25 +0200
Message-Id: <20240821121539.374343-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
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

Enable timestamping should be done using userspace tools, e.g.
hwstamp_ctl -i $VF -r 14

In order to report the timestamps to userspace, the VF extends
timestamp to 40b.

To support this feature the flexible descriptors and PTP part
in iavf driver have been introduced.

Side notes:
Originally Mateusz Polchlopek was taking care of ths series,
I'm replacing him since he's on holidays. Previously I was
also involved in reviewing some of those patches, because
of that some of them have both my Reviewed-by tag and my
Signed-off tag.

---
v10:
- only cosmetic changes, make every patch compile, fixing
  checkpatch issues

v9:
- another big refactor of code, again the list is too long to describe each change. Only
  patch1 and patch12 has not been changed AFAIR. Please take a look on v8 and changes
  requests from Alexander L. (in short - fixed structs paddings, aligns, optimized rx hot
  path, renamed few structs, added "const" keyword where applicable, added kdoc comments
  to newly introduced structs and defines, removed unnecessary casts, simplified few
  functions and few more).

v8:
- big refactor to make code more optimised (too many changes to list them here, please
  take a look on v7 patch9 and comments from Alexander L) - patch 11. Because of that I
  decided to remove all gathered RB tags.
- changed newly introduced spinlock aq_cmd_lock to mutex type to avoid deadlock - patch 7
- adjusted function iavf_is_descriptor_done() to extract fields from descriptor in a new
  way - patch 12
- changed (and removed unused) defines that describe specific fields and bits in
  descriptor
https://lore.kernel.org/netdev/20240730091509.18846-1-mateusz.polchlopek@intel.com/

v7:
- changed .ndo_eth_ioctl to .ndo_hwtstamp_get and .ndo_hwtstamp_set
  (according to Kuba's suggestion) - patch 11
https://lore.kernel.org/netdev/20240604131400.13655-1-mateusz.polchlopek@intel.com/

v6:
- reordered tags
- added RB tags where applicable
- removed redundant instructions in ifs - patch 4 and patch 5
- changed teardown to LIFO, adapter->ptp.initialized = false
  moved to the top of function - patch 6
- changed cpu-endianess for testing - patch 9
- aligned to libeth changes - patch 9
https://lore.kernel.org/netdev/20240528112301.5374-1-mateusz.polchlopek@intel.com/

v5:
- fixed all new issues generated by this series in kernel-doc
https://lore.kernel.org/netdev/20240418052500.50678-1-mateusz.polchlopek@intel.com/

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
  iavf: handle set and get timestamps ops
  iavf: add support for Rx timestamps to hotpath

Mateusz Polchlopek (3):
  libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
  iavf: define Rx descriptors as qwords
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   2 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 228 ++++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 479 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  26 +
 drivers/net/ethernet/intel/iavf/iavf_trace.h  |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 425 ++++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  22 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 275 +++++-----
 drivers/net/ethernet/intel/iavf/iavf_types.h  |  36 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 225 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  96 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   7 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  16 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  19 -
 include/linux/avf/virtchnl.h                  | 133 ++++-
 include/net/libeth/rx.h                       |  42 ++
 24 files changed, 1815 insertions(+), 336 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h

-- 
2.40.1


