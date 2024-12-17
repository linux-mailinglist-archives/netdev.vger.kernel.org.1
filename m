Return-Path: <netdev+bounces-152718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2109F5878
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD61894502
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30261F9ABF;
	Tue, 17 Dec 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3ETCYBh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA261DC18F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469730; cv=none; b=Q4BewLcKHd4ngKsYvU+RxX35Dkc9JExvOoa+pgN3xXvN7KAMVLQ3zhdRJIPRokkDpF7XsFobDBqVV6lY7/ZOGnxe4G9bSX9zNrX2x9qCErTq/SNsMbh75w0idkiepOKTxqyvfjynqp4RJ32pO2ABCUsTJtMG+el6mnGstlF4b70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469730; c=relaxed/simple;
	bh=9kk+T88yE99DMbvHX3sqUfSNDW1gf4QT3AAq7EqRQcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaKbjRY8iGeNOmtFnJPl1E4eWG2xXw5KjaZuM1p03pR2IrjG9WvkCXA0vnByxN5yFiVOJDfcTYWYXMAWE9Ecl7ChBNu6L7S1VLCsbfMluJokVtZLQnA9mVDdsAZEBVNw6WWg3zjZn60EAQHhsaNG7qm/jZwFVAmCryeireihpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3ETCYBh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469729; x=1766005729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9kk+T88yE99DMbvHX3sqUfSNDW1gf4QT3AAq7EqRQcY=;
  b=M3ETCYBh6QCf56McZ6pusDN2bS0+aa+GreEINKziZO7YRNQKvZZPLAOk
   egwdjKkQOyGuTjKXdM6nLQzLn0uRyevEhTtk8fb38wG3Fd4npTwpPFDVg
   JeBpWZeoJKVCN24c2K6U1oE10ZFiTN7fKihN3hcPG/5Y7dqd+H22ewKe3
   6z51ysOCPhmvM0EOiKXEdpfyAUhmWwWJGA+0kEtDWbIdPDBHXLXVNleVy
   u2elsTPqak1neco97kjs2O97mGzOYFxCjhq89fTyRzjvvg1H9rdfSOqI1
   w2SnzxJ0m6hi02E4LUdbmz4LVWt6q/ggAqkQ+jCvNH+7VUwGZCabMCA0W
   w==;
X-CSE-ConnectionGUID: XOJbLx/fQ8qG7iKR0Um9BQ==
X-CSE-MsgGUID: 5QjRDzn+RLWlZtWDYRtD7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34794817"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34794817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:08:49 -0800
X-CSE-ConnectionGUID: NXUfAED3SbSR/nsUbReBWQ==
X-CSE-MsgGUID: qcu+aO/lSwKEpNv0ZTqLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97436291"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2024 13:08:47 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com
Subject: [PATCH net-next v2 0/6][pull request] ice: add support for devlink health events
Date: Tue, 17 Dec 2024 13:08:27 -0800
Message-ID: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2, 3: core improvements (checkpatch.pl, devlink extension)
Patch 4: rename current ice devlink/ files
Patches 5, 6, 7: ice devlink health infra + reporters

Mateusz did good job caring for this series, and hardening the code.
---
v2:
- dropped ethtool stats dumping (Kuba), what resulted in Tx hang reporter
  patches to be squashed into one
- collected Joe's Ack, and Kalesh's RB

v1: https://lore.kernel.org/netdev/20241211223231.397203-1-anthony.l.nguyen@intel.com

IWL: https://lore.kernel.org/intel-wired-lan/20240930133724.610512-1-przemyslaw.kitszel@intel.com/

with patches squashed in:
https://lore.kernel.org/intel-wired-lan/20241210115620.3141094-1-mateusz.polchlopek@intel.com/
https://lore.kernel.org/intel-wired-lan/20241203082753.4831-2-przemyslaw.kitszel@intel.com/

The following are changes since commit d22f955cc2cb9684dd45396f974101f288869485:
  rust: net::phy scope ThisModule usage in the module_phy_driver macro
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Mateusz Polchlopek (1):
  devlink: add devlink_fmsg_dump_skb() function

Przemek Kitszel (4):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: rename devlink_port.[ch] to port.[ch]
  ice: add Tx hang devlink health reporter

 drivers/net/ethernet/intel/ice/Makefile       |   3 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +-
 .../net/ethernet/intel/ice/devlink/health.c   | 269 ++++++++++++++++++
 .../net/ethernet/intel/ice/devlink/health.h   |  58 ++++
 .../ice/devlink/{devlink_port.c => port.c}    |   2 +-
 .../ice/devlink/{devlink_port.h => port.h}    |   0
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   2 +-
 include/net/devlink.h                         |  13 +
 net/devlink/health.c                          |  67 +++++
 scripts/checkpatch.pl                         |   2 +
 14 files changed, 438 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)

-- 
2.47.1


