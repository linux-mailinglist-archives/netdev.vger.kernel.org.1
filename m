Return-Path: <netdev+bounces-151241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A59EDA01
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE11886163
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8C203D6A;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWmmFK9a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EE201259
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956361; cv=none; b=XVl5snp9VWf4oI/9efFgdqHPw1HbEeLrFfxxPMXK8Nb5djZq5iRLCyBRpT3l9Hg1tKJxZUTSivSBYVfv8Oq1zH+WwyVqKDFWH+C8YgpABX9S1vgpoyEggnFsRYtZ3mwuYVVlD3xF0fQ3wG00oNyQ+wB62px23msN2kpfl7QDJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956361; c=relaxed/simple;
	bh=LWmQEPZ4bG6LEk5LqIJucsKoiwr8W3YSykEz4mrzJRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe0tVTdwrNRy4VkqbQHjSneNaiPzAPx8JvWIyO47RuXTaW/drPWlbg4vU6BHDMPIfbkvHP6CwVqQ2WQ8chVi4UrDJoQYs5ySiPuv1p5G27+DKWfPUMx+B61y/UNG7GA9fYUmOkNYqAcmWSygOicyR7xnUyZ4PR189xz2zDuNYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWmmFK9a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956359; x=1765492359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWmQEPZ4bG6LEk5LqIJucsKoiwr8W3YSykEz4mrzJRc=;
  b=cWmmFK9au8u7VluApR8smV8txMrVC3zpxPc/L2KT8o1FlTXQX0yugQ78
   PC//U2rXB0qPKwH+eQbpuMre8kpyKZUMBDz311cxu2lo3FBSoyLQBJ+D5
   OAz0z0ZJrTBsfMG0sFSGEAY3mbyF6M/7C6sq21Dv7Ac9+PwO7Q2tCo/iq
   ZGAXYAmeluCBRmE2jmzdkOr043ZyDQ6z2kw+0AwYPr/4DpNvRYuli9MQb
   +04ZzWYv+qsmMW+AS6mpQ+anuY8FaPnUENi5tKJQT/GrSFVnxzIOMtAQh
   s/lpJ/dc3wIo1RvyTb9xPFERpWn3OBpEN/TyQk847rHQvCrzsTmuqOhgY
   g==;
X-CSE-ConnectionGUID: U6Ns/OhkSUGkkNAvhjJzKw==
X-CSE-MsgGUID: zI2nyYkrQ164yUnT63v8RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599591"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599591"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:38 -0800
X-CSE-ConnectionGUID: ZyRxAuQTSf2sevI7H2tMjQ==
X-CSE-MsgGUID: W5r5L0kPSnGOQeulzsNRcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192918"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com
Subject: [PATCH net-next 0/7][pull request] ice: add support for devlink health events
Date: Wed, 11 Dec 2024 14:32:08 -0800
Message-ID: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
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
IWL: https://lore.kernel.org/intel-wired-lan/20240930133724.610512-1-przemyslaw.kitszel@intel.com/

with patches squashed in:
https://lore.kernel.org/intel-wired-lan/20241210115620.3141094-1-mateusz.polchlopek@intel.com/
https://lore.kernel.org/intel-wired-lan/20241203082753.4831-2-przemyslaw.kitszel@intel.com/

The following are changes since commit c0b8980e6041afa363361e41fcafd7862721c3ee:
  l2tp: Handle eth stats using NETDEV_PCPU_STAT_DSTATS.
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Mateusz Polchlopek (1):
  devlink: add devlink_fmsg_dump_skb() function

Przemek Kitszel (5):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: rename devlink_port.[ch] to port.[ch]
  ice: add Tx hang devlink health reporter
  ice: dump ethtool stats and skb by Tx hang devlink health reporter

 drivers/net/ethernet/intel/ice/Makefile       |   3 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +-
 .../net/ethernet/intel/ice/devlink/health.c   | 301 ++++++++++++++++++
 .../net/ethernet/intel/ice/devlink/health.h   |  59 ++++
 .../ice/devlink/{devlink_port.c => port.c}    |   2 +-
 .../ice/devlink/{devlink_port.h => port.h}    |   0
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   2 +-
 include/net/devlink.h                         |  13 +
 net/devlink/health.c                          |  67 ++++
 scripts/checkpatch.pl                         |   2 +
 17 files changed, 497 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

-- 
2.42.0


