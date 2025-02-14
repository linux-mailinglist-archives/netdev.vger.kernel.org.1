Return-Path: <netdev+bounces-166531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9FA36619
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EDD7A5C65
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDC1C84B4;
	Fri, 14 Feb 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9byimmG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6B19884C
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561275; cv=none; b=GHV9bwfAzHHxAvKSJScLwTAhnnxCygVVDJsGeGCICIjYZcaPLCPbu4tTnsB55WuPDJHc8hX5xNrZu3TgBAX+VMYIIUGL/vXZCWIYATHM4iV/Pgsx2DYUtcrsyQEaq5ZQx9D+/f9D827UAmy1mLQRBdHZyRRZCFJd1e94/yQ/VA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561275; c=relaxed/simple;
	bh=7uHnEZ6pJTP/wfX4bSVt2beByk8ImGuWKBZKpRW1XBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OleESCvDPDosQ5uWzTMm3mqTTWAuHKllhY/icR9E9AcHlDj0uaK8YYQ+AYkKI2kmZ20kRKMWNYrqRHpTfLkFdiMAW7ERI8jh1+vDd3g+85Ywh4tf4xarDKX/qFWG5L8Fs1gHXnmb9m3nbWzkLRFZT2GG92p8p+HA2SVj9xxThMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9byimmG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561273; x=1771097273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7uHnEZ6pJTP/wfX4bSVt2beByk8ImGuWKBZKpRW1XBk=;
  b=P9byimmGVB4oLQNVNRHPnmv8Ks/AOFO7EMdfmLsXgKJYF3OQuWIvQo7j
   Zz7YGxc5RbN/gvZeZTZxKWcz6A3UycWjSye2f9AQ0arwzt/kScDwJGIA1
   nQ2razS49yxfpb7ATa/iDmd6q2ISkJQkVyxhcW2vUEHqvKU3pKYlZ7EnB
   4L4v8huFnnePsxGbH+LpgJpq7uoTaPkx0O8jrnEAOGscUb26Qj5MsU9rP
   yC0R0crotPmhVjS908BPPlRmWuZ2nwEtW1ZSDOYFafP84T2oow5fUuqxi
   yFvc5lD16J/k6hraArDDksBbatfyxN2EfC3KTgaQtPgxNT4dH9hhbz//h
   A==;
X-CSE-ConnectionGUID: IdqUevLqSyaz09F0Rg3kDg==
X-CSE-MsgGUID: 5x9JaKJGTiqbIEI0EctHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244082"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244082"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:53 -0800
X-CSE-ConnectionGUID: sfoGRioZTkGEm0IgPT6LDQ==
X-CSE-MsgGUID: Btkm62lCQDOVktFHDfYYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144393974"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	mateusz.polchlopek@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net-next 00/14][pull request] ice, iavf: Add support for Rx timestamping
Date: Fri, 14 Feb 2025 11:27:21 -0800
Message-ID: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mateusz Polchlopek says:

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
---
IWL: https://lore.kernel.org/intel-wired-lan/20241106173731.4272-1-mateusz.polchlopek@intel.com/

The following are changes since commit 7a7e0197133d18cfd9931e7d3a842d0f5730223f:
  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

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

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/iavf/Makefile      |   2 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 228 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 485 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  47 ++
 drivers/net/ethernet/intel/iavf/iavf_trace.h  |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 433 ++++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  24 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 239 ++++-----
 drivers/net/ethernet/intel/iavf/iavf_types.h  |  34 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 203 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  80 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   7 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  16 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  19 -
 include/linux/avf/virtchnl.h                  | 135 ++++-
 include/net/libeth/rx.h                       |  47 ++
 25 files changed, 1790 insertions(+), 331 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h

-- 
2.47.1


