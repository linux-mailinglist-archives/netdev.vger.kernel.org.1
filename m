Return-Path: <netdev+bounces-110930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B35B92F036
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A351C20A6C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACA16D4CA;
	Thu, 11 Jul 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl9eliLD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70914D431
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729179; cv=none; b=mIP0Dt7LkK8I3qtOrUR+2ZwqCxHFnxCrx2bVz9bm5LhAMJJumBI9c9NpGIEnuDvhmyBpFxc+pJxczIFCiPB06JokBMtA95Nx/PoQBvbRfKe/E4+vhRSYPL5vMtVWVYtmCm+YAfBUYKqtMt2KYRBT5CIx81iY4hXaZ3bvFR/jpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729179; c=relaxed/simple;
	bh=2Q/OHXb6B60UW1xeJH/nSvAwFA7/2AeW/Umhsf9WCy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTzPiPTq4adlqY8HTzcUOVNu6Zj39J8z4q214yiInlHZWMWypIG34Y3VHK2xfKl66Rb5FpSXyPpRYCI6jwcxAcAUuVZFYSWpYSiEsDy3ktVNWl4BU5Q5o8ntdsjIX9Yx8DVo2h0lz7jxETkxe3Z3qi6OWupKrFnpQCsz7AMdioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl9eliLD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729177; x=1752265177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Q/OHXb6B60UW1xeJH/nSvAwFA7/2AeW/Umhsf9WCy8=;
  b=Fl9eliLDL9gLwkIoJzd7UdS81Ee/1lwBHV1eKwLx08tS4WVdv333+DAm
   UbXIsjFKJm/7FuPeSr3g0mh92zF3YTqjVy4lxLFhZtUqrXiuj/tiFWok+
   0dZUw+w0co+lrZozWmKfcoVEoUzKJkZqjzrp/qcnfi9tfSqDOA6qPOy+B
   0ESPlhzmte3yTRvINVkzejBy4Fl4WTB+FL8rPM9C2bzF3tMc1JoPSyoR/
   CK0L/w0YJMsNhhd8dOzNigbYW++kjXJiMig8FrDkqPmhhHaJ+p+zY9ftZ
   VihsQiZPWydqgIbuauM8QHnqyVLYNmh3lOG1lWrGvjnAYzjqWrR0TwcUJ
   A==;
X-CSE-ConnectionGUID: uHxJx6K5Q6aMnGDWoP9p9Q==
X-CSE-MsgGUID: mtA613wgQRKlFsSpVHIp3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508382"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:37 -0700
X-CSE-ConnectionGUID: zvFOni81QTWlA/JF26wMQw==
X-CSE-MsgGUID: CAjni4iwQLai+9E1rnaHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887398"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates 2024-07-11 (net/intel)
Date: Thu, 11 Jul 2024 13:19:25 -0700
Message-ID: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to most Intel network drivers.

Tony removes MODULE_AUTHOR from drivers containing the entry.

Simon Horman corrects a kdoc entry for i40e.

Pawel adds implementation for devlink param "local_forwarding" on ice.

Michal removes unneeded call, and code, for eswitch rebuild for ice.

Sasha removed a no longer used field from igc.

The following are changes since commit 58f9416d413aa2c20b2515233ce450a1607ef843:
  Merge branch 'ice-support-to-dump-phy-config-fec'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Michal Swiatkowski (1):
  ice: remove eswitch rebuild

Pawel Kaminski (1):
  ice: Add support for devlink local_forwarding param

Sasha Neftin (1):
  igc: Remove the internal 'eee_advert' field

Simon Horman (1):
  i40e: correct i40e_addr_to_hkey() name in kdoc

Tony Nguyen (1):
  net: intel: Remove MODULE_AUTHORs

 Documentation/networking/devlink/ice.rst      |  25 ++++
 drivers/net/ethernet/intel/e100.c             |   1 -
 drivers/net/ethernet/intel/e1000/e1000_main.c |   1 -
 drivers/net/ethernet/intel/e1000e/netdev.c    |   1 -
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   1 -
 drivers/net/ethernet/intel/i40e/i40e.h        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   1 -
 .../net/ethernet/intel/ice/devlink/devlink.c  | 126 ++++++++++++++++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   4 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |  16 ---
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   6 -
 drivers/net/ethernet/intel/ice/ice_main.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c     |   1 -
 drivers/net/ethernet/intel/igbvf/netdev.c     |   1 -
 drivers/net/ethernet/intel/igc/igc.h          |   1 -
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |   6 -
 drivers/net/ethernet/intel/igc/igc_main.c     |   4 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   1 -
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   1 -
 drivers/net/ethernet/intel/libeth/rx.c        |   1 -
 drivers/net/ethernet/intel/libie/rx.c         |   1 -
 24 files changed, 167 insertions(+), 50 deletions(-)

-- 
2.41.0


