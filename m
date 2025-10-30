Return-Path: <netdev+bounces-234415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F42C20727
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76DE44E9571
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B623D7C4;
	Thu, 30 Oct 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5kakjx1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280B22A80D
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832795; cv=none; b=SkEPKflJqOtzVrL8kdt3P0Ilah/9KTap+ZSmdiFbr2u2KPqe8KiAUzATgWWEMIWBAbOafmS9xrBm1FKZ8UkwEDETU/sA32oIt1vJ6PewsYnTpKXcmWYteuji5ca7gY6+S1nqKmJ38lqzxSaL+jFSx/bWQpbSVYH/kTTTeKD/Cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832795; c=relaxed/simple;
	bh=Vmxl21B1EmNQ2pqpdTn9OpyBv+1bJgvrYuvdM0SRPVw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=neqi7GUj4GUgmwErTuReut2xJsr7idVRQWw1rR5/9kV+2rzFatCkntJrCVQJbucQ+BHCSOpGWs6JlbBoRkywZb/gPkClCOUvOBlNev43C32CwZAYSSd4rN+sHC8qM8w69Y43ek2o7XQebdoM+VzErYAE6xQQ3eVWsSH9yxr/kVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5kakjx1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761832795; x=1793368795;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vmxl21B1EmNQ2pqpdTn9OpyBv+1bJgvrYuvdM0SRPVw=;
  b=X5kakjx11aVP+6HUPMruMlvim2YUXgXv8em7r0dipMJW2B189/u8qOga
   RFoXN5O4/zDGgp4/fiKV1V0eKPh2wUtMsOx/wCrCePGsGn0W3CFeOJhu3
   UiGWAbxEG4oyA8Ahzs8X1Cn2vU9PH1ujAQSQK0Jp/li5a0CDOA84qWt/m
   cWeMzVyzN5cEXlpTnRNPpARZHugA2RqeGOhmmwWN8ZfmwmhFYNYugOrKi
   g9LrsfisQsbOvBZRWtEyEOGQ4vY5rf9WaUjhLr9ueg7pLoVh26rjC4hby
   YyrPute0hyw2IvrXWU0QMIh9BOmiph+4yib3ukC7zu8JvkjwRmFw68UkI
   Q==;
X-CSE-ConnectionGUID: I/hpojBKRQW3sJeYfTLYow==
X-CSE-MsgGUID: r8b2FzJ+RxWclx5MK5oCmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64015137"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64015137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:59:54 -0700
X-CSE-ConnectionGUID: rCBX5y/9T76jBs9+Wk+AOw==
X-CSE-MsgGUID: 3LkIs1sRTz+jUZKJAoNryg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185895792"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 30 Oct 2025 06:59:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org
Subject: [PATCH iwl-next v8 0/6] iavf and ice: GTP RSS support and flow enhancements
Date: Thu, 30 Oct 2025 14:59:44 +0100
Message-ID: <20251030135951.424128-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
 - Adds new RSS flow segment headers and hash field definitions for GTP
   protocols.
 - Enhances ethtool parsing logic to support GTP-specific flow types.
 - Updates the virtchnl interface to propagate GTP RSS configuration to PF.
 - Extends the ICE driver to support GTP RSS configuration for VFs.

changelog:
v8:
   - patch 2/6 build fixed + kdoc updated
v7:
   - refactor ice_vc_rss_hash_update() to use int error codes
v6:
   - split patch 2/6 int static data and define changes + minor fixes
v5:
   -fix NULL ptr dereference and minor improvements in 1/5 & 2/5
v4:
   -remove redundant bitmask in iavf_adv_rss.c for dmesg
v3:
   -fix kdoc-s in ice_virtchnl_rss.c
v2:
   - reduce much repetition with ice_hash_{remove,moveout}() calls
     (Przemek, leftover from internal review)
   - now applies on Tony's tree

v1/RFC: https://lore.kernel.org/intel-wired-lan/20250811111213.2964512-1-aleksandr.loktionov@intel.com

Aleksandr Loktionov (4):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl and VF context support for GTP RSS
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Przemek Kitszel (1):
  ice: extend PTYPE bitmap coverage for GTP encapsulated flows

 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  251 ++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1404 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 11 files changed, 2070 insertions(+), 128 deletions(-)

--
2.47.1



