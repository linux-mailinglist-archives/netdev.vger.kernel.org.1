Return-Path: <netdev+bounces-104534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40890D1E6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EFDB23100
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AAC158DAA;
	Tue, 18 Jun 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEboPmiD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF81A2FAB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716407; cv=none; b=DavuDhd5dR7QICOTpBGKqpkqqNrwksxR/4/ZtEPwidZPq3xMQDmeECd/+NCRMd7YScDAisweMHdjXqv8uSnQEnFSwoDK7uvQo87PsIiygWpwg/BsJnvA24IXEmuM6TOpjJFge8jVCUm5hgb27ORqPQ6XpXuF1IBggRXbmzBw0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716407; c=relaxed/simple;
	bh=3HBoWOKl6SbY13vd0tm05QnlOYhyCgkxJmDDKHhVy5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbJn//fARLVvtebd5udZ5inFPpYwCBNTJMjoKFL+cAPzLZOauZ7T6jafpz3HsXEECTO/Ufp+6lkQEW+emCdbE6xSmWej9SLIAsSgOi+NdPV/AQallQ4o99PAW6YzNupL/f4qwf9v4QGHouh60RQJeU207MpcP+uqb7nSmVSkumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEboPmiD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716406; x=1750252406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3HBoWOKl6SbY13vd0tm05QnlOYhyCgkxJmDDKHhVy5E=;
  b=hEboPmiDnffG1FgCTyuzgXt5mTTLQhdYNiTP/zvIEPHMdn4KAnYOXy1q
   JzSk2rLAjGNreV31IYARYfKfyeoK8fT27TYGYxT28LzjmLR3UcQCJjtAr
   24eqj/yJaQ5uNqA/smfgaiiQzmG7HrNn0fUrxJRqQO4jAabNyk7e7spJo
   OowWLig6A8Ayakz5xSbksYODhW/fNs/44cxCCIhbIEksdjAMcAfaYyzMF
   plwtuX5dEjLmAjH0bJoMBtufPnOLXhyHTQJgG0NDxtiFrAbNy+tz0bxD5
   UmdA5EGOHMszfRrKJBRXP/M/1aFu/xO1tqkEtAahdlOw6yiUgCmZO9WZI
   Q==;
X-CSE-ConnectionGUID: 1Yg2c7gCQQGwDpicBQcsJA==
X-CSE-MsgGUID: uiInnQEtSdSlizCH3WMY+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15560407"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15560407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:13:26 -0700
X-CSE-ConnectionGUID: 9v6sGu/GSGOdkRpxkHzzvw==
X-CSE-MsgGUID: d1aG04vfRYyY1aKqWF4FkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46668313"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 06:13:24 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [RFC PATCH iwl-next v1 0/4] Replace auxbus with ice_adapter in the PTP support code
Date: Tue, 18 Jun 2024 15:12:04 +0200
Message-ID: <20240618131208.6971-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces multiple aux buses and devices used in
the PTP support code with struct ice_adapter holding the necessary
shared data

Patches 1,2 add convenience wrappers
Patch 3 does the main refactoring
Patch 4 finalizes the refactoring

Sergey Temerkhanov (4):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  21 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 338 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 111 insertions(+), 310 deletions(-)

-- 
2.43.0


