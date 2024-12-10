Return-Path: <netdev+bounces-150560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13F9EAA8B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B05D1664BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841922F3BB;
	Tue, 10 Dec 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYdZ4Xlc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CA23099E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819104; cv=none; b=a4jCeOYdDUO72SzGJJTc1cDROTurTx8xBnJ6Nlrs30FF3cGXA2QKrNhAK/zGEM1kawSuHdNIWFwV9R1NBDjcg+L0ttq861HTDASZJ8e4wBIS3lFIb9TGdcFmrVpLWUSZMPHcCLYueTSx2Rk7xKbzFIdClqiqy+vJVK4fduizlgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819104; c=relaxed/simple;
	bh=KQfHFQ/ZYKUlItWNvsZBVoWc70S6XVSP9gazTBBIOPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zuk5MXV/mOZZ4m1GoL+YOLDQmki1eLFyEug9WccZ5usKFILwu7GxnpKl9qbiKL7BD141HfWp9T4iDk6OZlfXBWo6C8wyIHif2BmqiJNglnAw7qSUe3D37vd9zKfgH8YHRZdp32lhmEcco9StegSJ0FvP+jOA/0PfZz89kVi3/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYdZ4Xlc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733819102; x=1765355102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KQfHFQ/ZYKUlItWNvsZBVoWc70S6XVSP9gazTBBIOPc=;
  b=WYdZ4XlcHYor3Xt8Hopj4YyFRvT2gY9JG6HN6iBE6YYH+o2jf0AgXsBW
   uwbUmQOx2hAEi/tb9ZkwFUeWN+hT/kK6iv5qiSTtOmGgZw9GvHe5Ui5gO
   PoNplWE0R/9T3UJGcjN0r8TSQf2AsPUCV9v/pA8HszkqQOI8w8rmktMUK
   QqSQh625VsPPrE5d2ss9wjt2Ou7zr09tHB7hOpxVJXgFaxwgJdmCWQIq0
   srTXmpY0I6mkTK+yuT5gFex/hZkn/Dt9MlZTuH+U1WvwFH6caNCfW3FBp
   y6kUHMSRqygC/TLm9bawXvbQQ+dvAc+jM79wqTp/TwcXqYNeBm5TpbcxC
   g==;
X-CSE-ConnectionGUID: CX/2Pzq/RT6xLj90A1N7PQ==
X-CSE-MsgGUID: ZjDcfQFlRbOhSLzLlLG6wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34398236"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="34398236"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 00:25:02 -0800
X-CSE-ConnectionGUID: GikukbA1R5iupS4uLBVLPQ==
X-CSE-MsgGUID: IOBTeSDPTTq0EF2vbHtSdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="99398098"
Received: from host61.igk.intel.com ([10.123.220.61])
  by fmviesa003.fm.intel.com with ESMTP; 10 Dec 2024 00:25:01 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 0/5] ice: implement low latency PHY timer updates
Date: Tue, 10 Dec 2024 09:22:04 -0500
Message-ID: <20241210142333.320515-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Programming the PHY registers in preparation for an increment value change
or a timer adjustment on E810 requires issuing Admin Queue commands for
each PHY register. It has been found that the firmware Admin Queue
processing occasionally has delays of tens or rarely up to hundreds of
milliseconds. This delay cascades to failures in the PTP applications which
depend on these updates being low latency.

Consider a standard PTP profile with a sync rate of 16 times per second.
This means there is ~62 milliseconds between sync messages. A complete
cycle of the PTP algorithm

1) Sync message (with Tx timestamp) from source
2) Follow-up message from source
3) Delay request (with Tx timestamp) from sink
4) Delay response (with Rx timestamp of request) from source
5) measure instantaneous clock offset
6) request time adjustment via CLOCK_ADJTIME systemcall

The Tx timestamps have a default maximum timeout of 10 milliseconds. If we
assume that the maximum possible time is used, this leaves us with ~42
milliseconds of processing time for a complete cycle.

The CLOCK_ADJTIME system call is synchronous and will block until the
driver completes its timer adjustment or frequency change.

If the writes to prepare the PHY timers get hit by a latency spike of 50
milliseconds, then the PTP application will be delayed past the point where
the next cycle should start. Packets from the next cycle may have already
arrived and are waiting on the socket.

In particular, LinuxPTP ptp4l may start complaining about missing an
announce message from the source, triggering a fault. In addition, the
clockcheck logic it uses may trigger. This clockcheck failure occurs
because the timestamp captured by hardware is compared against a reading of
CLOCK_MONOTONIC. It is assumed that the time when the Rx timestamp is
captured and the read from CLOCK_MONOTONIC are relatively close together.
This is not the case if there is a significant delay to processing the Rx
packet.

Newer firmware supports programming the PHY registers over a low latency
interface which bypasses the Admin Queue. Instead, software writes to the
REG_LL_PROXY_H and REG_LL_PROXY_L registers. Firmware reads these registers and
then programs the PHY timers.

Implement functions to use this interface when available to program the PHY
timers instead of using the Admin Queue. This avoids the Admin Queue
latency and ensures that adjustments happen within acceptable latency
bounds.

Jacob Keller (5):
  ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
  ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
  ice: add lock to protect low latency interface
  ice: check low latency PHY timer update firmware capability
  ice: implement low latency PHY timer updates

 drivers/net/ethernet/intel/ice/ice_common.c |   3 +
 drivers/net/ethernet/intel/ice/ice_osdep.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  48 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 155 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  17 ++-
 drivers/net/ethernet/intel/ice/ice_type.h   |  12 ++
 6 files changed, 204 insertions(+), 34 deletions(-)


base-commit: 4376b34cf49c2f38e761beacd173d1dc15a255fd
-- 
2.42.0


