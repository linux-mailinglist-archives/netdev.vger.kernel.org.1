Return-Path: <netdev+bounces-107818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392691C729
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21907B2103D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE67711E;
	Fri, 28 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmPNnACM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC113774B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605624; cv=none; b=e2E5WLmYCx7ynERTA3VPx5IB1UJgJzjg+ooZdC7Tg4lQC3tg+qHzoHQtonofo4anRvFWETLIUgY91uHIRD0NrQEsFmJnlKx4VSye2fMmoymrMjosAISPmn8ipUv5zWBPb1RC7m4ungRzkB1K0KoLVnjNNVYD9QIW2+5GI4A6qIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605624; c=relaxed/simple;
	bh=Ut4wOGe28jP2YbnIH88SBtFyzigim0TwpihLNV2RiV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkXLDu7hYFvthCXdD3w4aHD19ArlE61V2oIpeT0jTDz9ANGedy3b3iqmRNrfFsGUePCckPSQEU74JKOuMhvprO1cdRLMsAHbJ82IhG7rfuXkrSJELNwNo5XwBtHm932C/XDspl9lwCK3fdD+1xubxcqO3ejQ2VROgQ/qTQ+/wpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmPNnACM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605622; x=1751141622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ut4wOGe28jP2YbnIH88SBtFyzigim0TwpihLNV2RiV8=;
  b=cmPNnACM5xPsOpU8Zujx4urKgWzFakfhd3ECRV3VBZLKOye9l6lo1dLG
   ABDULc6yO29EoTJ87Apkuk2lwheoehxK4RVx7dDJd1QNtsJrbjd2vrONe
   s2eyGt0PoNuwFJUNtHtExcwIWD8ykSwCnk/iIDHrjMk3nQ9jea0YrwNQb
   5rwU82Uo91InL9p2YRbTRO/wBOjtG6OtKzkJtzZRGoOI9AgnTGNRQppeK
   3d1KuzWT8jlpzjRB0T/IN9cmLzRBjPvTl/EXznNBce4UtjXWHCfsd/otU
   OJjVmG5ydMFxJGKDOv5wzCahArRFuk1DsrVCSyoTTOKTDhpsVm8JIPYAB
   Q==;
X-CSE-ConnectionGUID: 6phJFbMvSGKm0UbRkmg81Q==
X-CSE-MsgGUID: K1Xc8iLJQmaeri1a+a9y3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674899"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:41 -0700
X-CSE-ConnectionGUID: FMiInvgMRy6FSHUuyIc+eA==
X-CSE-MsgGUID: 02IyDtn6T8WAuAqQ8jwgxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735518"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates 2024-06-28 (MAINTAINERS, ice)
Date: Fri, 28 Jun 2024 13:13:18 -0700
Message-ID: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to MAINTAINERS file and ice driver.

Jesse replaces himself with Przemek in the maintainers file.

Karthik Sundaravel adds support for VF get/set MAC address via devlink.

Eric checks for errors from ice_vsi_rebuild() during queue
reconfiguration.

Paul adjusts FW API version check for E830 devices.

Piotr adds differentiation of unload type when shutting down AdminQ.

Przemek changes ice_adapter initialization to occur once per physical
card.

The following are changes since commit 748e3bbf47212d5e2e22d731328b0c15ee3b85ae:
  Merge branch 'net-selftests-mirroring-cleanup' into main
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Eric Joyner (1):
  ice: Check all ice_vsi_rebuild() errors in function

Jesse Brandeburg (1):
  MAINTAINERS: update Intel Ethernet maintainers

Karthik Sundaravel (1):
  ice: Add get/set hw address for VFs using devlink commands

Paul Greenwalt (1):
  ice: Allow different FW API versions based on MAC type

Piotr Gardocki (1):
  ice: Distinguish driver reset and removal for AQ shutdown

Przemek Kitszel (1):
  ice: do not init struct ice_adapter more times than needed

 MAINTAINERS                                   |  2 +-
 .../ethernet/intel/ice/devlink/devlink_port.c | 59 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 60 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_common.h   |  2 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c | 30 ++++++----
 drivers/net/ethernet/intel/ice/ice_controlq.h | 15 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 19 ++++--
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 34 ++++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  8 +++
 9 files changed, 165 insertions(+), 64 deletions(-)

-- 
2.41.0


