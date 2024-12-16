Return-Path: <netdev+bounces-152121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128D9F2C6E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AFB188727D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC7200BA1;
	Mon, 16 Dec 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEPoa+Kg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF161FFC7C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339391; cv=none; b=XmqNOzYnjv+IdleCldKBhW3YblaciXfVgXFJ0uOj9mmXzWDh2mKi6CRfticCnLFBgdH7njTy4ui+lZZ2ba4o7Nxv7Vcu2Qm03nfWBM3mYIV9aY1U9OxB0ftunRKlSlbryfA9IBgx2oJUxGEn/vzc3wyAYxGNu7xlvtH6C/uzjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339391; c=relaxed/simple;
	bh=r2hR/ZHSKVaxwEoJHYXj1YqdVNCMbvBl9B8S+1faMYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMSRza0JlxeOYhI4CtrIhUqg4iIDUb7iT1BMLrhczAOX4l0JnfCUbrHn7qFxrZ1MfikGog3fWpVngwrAPSkMLreSH4+l8eihWadbrbOfAhinqxUfxJPeobnyGzxoGxjEr8b/3gxoysOXcDMRQ9RnS9RnjH7pdQrkJIwVO9UycCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEPoa+Kg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734339389; x=1765875389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r2hR/ZHSKVaxwEoJHYXj1YqdVNCMbvBl9B8S+1faMYs=;
  b=dEPoa+KgyYMd1OjLHsFozFj4sox7qcFNiErQq8Qb0ZWqAd21ww3fqYPR
   6Dgg2PXRTsRVo7PV50GKhtud5I/NE679zEsMTOroVegwefnnkThKfz3sA
   At3vdickQif0Vj0ODzYDFkpJsd2m9ghp22NCueu+qHZj6kkJOHt0ExQwv
   ShwCA5Og5+dtZy3Ix+8G1RHe+iXNxS5mMLnzJIhn1Akx+eweSbInqUKan
   m5Shv2fvqaJUO2bPvtaPS7XckpXx0BRQDhl8ExfaGL1egT93O8EJMdaJ4
   vpmAiOd8XgHhzmUk2sZvDBFY8UEAceCPQGp83tdYW3fiOZPIlq78vCutm
   A==;
X-CSE-ConnectionGUID: vNTULkcqRJOL5X0DbVAO3A==
X-CSE-MsgGUID: loJ5mjSSSl+cZvg800DGvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34942388"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34942388"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:56:27 -0800
X-CSE-ConnectionGUID: /YVEv/+YT7KRxsj0lZ3guQ==
X-CSE-MsgGUID: 8lgb95+dSRC4R5tHO7ejeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102117140"
Received: from host61.igk.intel.com ([10.123.220.61])
  by orviesa005.jf.intel.com with ESMTP; 16 Dec 2024 00:56:24 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 0/5] ice: implement low latency PHY timer updates
Date: Mon, 16 Dec 2024 09:53:27 -0500
Message-ID: <20241216145453.333745-1-anton.nadezhdin@intel.com>
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
---
v1->v2: Change type for err variable

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


base-commit: 46773e40fb01b6d76ab63618d1ebf6a7a79682c6
-- 
2.42.0


