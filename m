Return-Path: <netdev+bounces-176461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B915AA6A6FE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD8046848F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F819D067;
	Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD/aXfu+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB31CA84
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476773; cv=none; b=UlG/r8F4epl2K91cF/fvTl8Mu1DBmQfBbPm8xGR4YQVDGh/3v0AVqXbNRebL5/IGy+LJ5L9wotn7iR/6MCMqQT6L8ijqeDmhtDfmAvSztoRAbQfFqu1jlUN+gEDsQWEmPjn9FIUE0j1GPcJubaUJ2GeznFWjadhXN7lGrv+gq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476773; c=relaxed/simple;
	bh=8v2IlNO/kUlcnwT83q5ZXsTX+JsEa2epR2YhLXfU0YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tudiMa4Q3OGc+QgAwDaXPaaNX5UaJ6i8MLCddO+q0NzDcIKRj4bAkcolH32hVzx0pAIt0vs9RjREXMgbtgxSm2f5V/8oRjh9nQKZk8HOC7yDwb9BrqpeYKWg+J8rmEDeZdI8f/eaSD/yef/QmkVHb5e5T+HzvwfY5e6Sa4xszGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD/aXfu+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742476772; x=1774012772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8v2IlNO/kUlcnwT83q5ZXsTX+JsEa2epR2YhLXfU0YQ=;
  b=SD/aXfu+RP84XlGGsUrsMimX12JnO1P+h9mxWBZKdgzMyMLrt9VMutYm
   SzD6Rx1VB9vCBkb8iHbvcO/IGVJBhlVlYfgCUMdhnDfgBM1U2bZPEFROp
   +1ib3NkQ/5iY3ZCbVxB4m1tf7q7RyrgHiWRXduTr7WO/ucSvjbmRxUG6B
   PiSkFO8VlBzbPGw2Jqs9DRvAjeOgg/XwBFfLqsBRiJn0s5UMDThEpTEqy
   K4IZLV8RlJmw1pyjJEpASq1Q7qYyY6AROwgnDm1TP3b+0QYHIB31EUoFc
   PUY8KGwfbXcw42wB7L/RMXSIWnZWN9o8ds3sX58AerYCz46nhbn1GPXcu
   A==;
X-CSE-ConnectionGUID: h94hOUYdRMyeB5Au7MeNpw==
X-CSE-MsgGUID: el+JXPMdQyyeijk8ZFPA+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55083732"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="55083732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:19:31 -0700
X-CSE-ConnectionGUID: KOJKTDjzQV2xkHAHfocs7A==
X-CSE-MsgGUID: 08z3xn/GS0uv/VR5PmleUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160311374"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:19:30 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v3 0/3] E825C timesync dual NAC support
Date: Thu, 20 Mar 2025 14:15:35 +0100
Message-Id: <20250320131538.712326-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds full support for timesync operations for E8225C
devices which are configured in so called 2xNAC mode (Network
Acceleration Complex). 2xNAC mode is the mode in which IO die
is housing two complexes and each of them has its own PHY connected
to it. The complex which controls time transmitter is referred as
primary complex.

The series solves known configuration issues in dual config mode:
- side-band queue (SBQ) addressing when configuring the ports on the PHY
  on secondary NAC
- access to timesync config from the second NAC as only one PF in
  primary NAC controls time transmitter clock

v2->v3:
- update commit message (1/3) about regression risk after removing the
  workaround (no risk expected) 
 
v1->v2:
- fixed ice_pf_src_tmr_owned function doc
- fixed type for lane_num field in ice_hw struct 

Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

 drivers/net/ethernet/intel/ice/ice.h         | 60 +++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 49 +++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 82 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 +--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 7 files changed, 149 insertions(+), 67 deletions(-)


base-commit: 410597c085b1ab697bd40cc8cd532eb337a5405e
-- 
2.39.3


