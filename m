Return-Path: <netdev+bounces-73441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC085CA27
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995622816F6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A20151CD6;
	Tue, 20 Feb 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsr8cHur"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951714A4C8
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465494; cv=none; b=cAVqr3f8jJZAQe7gu8SJf4lNV0M/eMzT8+5j60+ysA5pkYzMvkID9bxWIb7HnNRxXpyLlFuBIGgjKmDWIJTLlzY/kWF22JWzTFOMC+HeA4yqPSc9U/SuuHMWXpTrour0ecnUDP/IFy6BLkMAsxoqT4ebN0Qpzwn/t+71KfYLvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465494; c=relaxed/simple;
	bh=+6TksG8ZkhmLQYjHX71zRpO0+zMpmzSfsM2xWEZpk+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNeJGp4IUe6aVuzkdrM/nXyZWvPX4CAw5hBXl2O3CNqx7Nd0o8z7Q0OILsVUuRI+EhIzkLkJkljeu3OQ76QDNBE1augwAzVhkOaTFrjgXP60etzdktlKpw4Qd0N08r0xepVT+85SgiLslPbIIonycZJP3SDzloXDAfVHJv4Qzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsr8cHur; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465493; x=1740001493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+6TksG8ZkhmLQYjHX71zRpO0+zMpmzSfsM2xWEZpk+A=;
  b=bsr8cHur3Q9jeNpueC6Ih8lqRJ69ddJjwNTkvRt8vcz5cX4cHy97cxNE
   Nk8+qLdXM7mYmWDy6Jqm6sQVxjVaolM2YDHCiJmwyYZL4/Ko5Y8QM8juJ
   9F3AKCTvNE41xrThO2ZJYlQWFtm7mQOUNKR9iEJ3Yxz2U11N7FOucaLce
   LxJoR0hBaCRkM1kBWawgleameAm4n+cHtLyvsNGKud/18ysxEdzDXr7WW
   kRlu/F24Ud80YIHmTP6hbPu0K/w7EE5Il8xC3WPqsDeoE6sUYYSaHudkB
   lpgwdgWIo2LcWBPM9+p9NDBM+YPRQRDbhfg+zsf5TxZde567eUeQaVYcg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472706"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614930"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2024-02-20 (ice)
Date: Tue, 20 Feb 2024 13:44:36 -0800
Message-ID: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Yochai sets parent device to properly reflect connection state between
source DPLL and output pin.

Arkadiusz fixes additional issues related to DPLL; proper reporting of
phase_adjust value and preventing use/access of data while resetting.

Amritha resolves ASSERT_RTNL() being triggered on certain reset/rebuild
flows.

The following are changes since commit 23f9c2c066e7e5052406fb8f04a115d3d0260b22:
  docs: netdev: update the link to the CI repo
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Amritha Nambiar (1):
  ice: Fix ASSERT_RTNL() warning during certain scenarios

Arkadiusz Kubalewski (4):
  ice: fix dpll input pin phase_adjust value updates
  ice: fix dpll and dpll_pin data access on PF reset
  ice: fix dpll periodic work data updates on PF reset
  ice: fix pin phase adjust updates on PF reset

Yochai Hagvi (1):
  ice: fix connection state of DPLL and out pin

 drivers/net/ethernet/intel/ice/ice_base.c | 10 +--
 drivers/net/ethernet/intel/ice/ice_dpll.c | 91 +++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.c  | 86 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.h  | 10 ++-
 drivers/net/ethernet/intel/ice/ice_main.c |  3 +-
 5 files changed, 161 insertions(+), 39 deletions(-)

-- 
2.41.0


