Return-Path: <netdev+bounces-69639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445084BF54
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056CF1F21EBE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC21B971;
	Tue,  6 Feb 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPRi1qH2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D51B94C
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255674; cv=none; b=i2/BjvlLUI7EjQRcrmjMeXANPZ6o/FxEnaCLlmNb0U56aXklhBnEEeEJwraS141UjkMAIAWLKgrm4zzY+YX4jZTcZvaGDsXNdM65K1lZFAQLNg/+tut58S5dfRXyLURWfI4Gqb39+/PZx/yCi2UBAvB4euHm7PLQ211BXua2gE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255674; c=relaxed/simple;
	bh=aMdZL2rd09aPLQawZGdQ0Uq2SmABgUuaIW3E4Znno+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+bDhILd+e2fDSR5WQ4xu/nUuOdMzzJccNYOU8neAvKB4BZGMqQZVLeslbZuQuj/XrW+A8PMTS1niZzxJ9K2tctPcIpGfj4rBwAITxCjArFq1vbWYaocSeV0EHSgIvXnZM3iZGXImQKONqGV2BYde+XEg0oekB2m2r+B7SabtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPRi1qH2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707255673; x=1738791673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMdZL2rd09aPLQawZGdQ0Uq2SmABgUuaIW3E4Znno+k=;
  b=FPRi1qH23r3Dm/YCRCB3DzavXs17E6nwT3NupQVdAh/g2ocIHny5LLyY
   8xPi26GpPQ6UKY6zjSv//ITxpL8PuILlzJFN7yCG5BZDHVzA1SZcnD7nx
   t0ZOhvxuJuKmP7s8vS3Qem4asiB2HaXNaTK6FEj2aafaW2OTIuwBi0oaE
   586a/zoxVQ7IctO9nXid1pTEagzan0rsdy/fZAgqc15M2gunskVpBZ57/
   uM5dei3EFXP1wxndNnLlvlFD37c7DCWgPHuVrW+Dc8BPkAzqQqRVA/CKt
   UytiErLNULnPvc5x1iiuLUmwd6c4+ncIQJI7l9tlUym2eLzR9CKLCsvyF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="759309"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="759309"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5917808"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2024 13:41:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2024-02-06 (ixgbe)
Date: Tue,  6 Feb 2024 13:40:50 -0800
Message-ID: <20240206214054.1002919-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ixgbe driver only.

Jedrzej continues cleanup work from conversion away from ixgbe_status;
s32 values are changed to int, various style issues are addressed, and
some return statements refactored to address some smatch warnings.

The following are changes since commit 60b4dfcda647f86c62dc7b8219d2bfed19bb2698:
  Merge branch 'nfc-hci-save-a-few-bytes-of-memory-when-registering-a-nfc_llc-engine'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Jedrzej Jagielski (3):
  ixgbe: Convert ret val type from s32 to int
  ixgbe: Rearrange args to fix reverse Christmas tree
  ixgbe: Clarify the values of the returning status

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  16 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  70 ++---
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    | 151 ++++-----
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 262 ++++++++--------
 .../net/ethernet/intel/ixgbe/ixgbe_common.h   | 112 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c  |  12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h  |  10 +-
 .../ethernet/intel/ixgbe/ixgbe_dcb_82598.c    |  26 +-
 .../ethernet/intel/ixgbe/ixgbe_dcb_82598.h    |  30 +-
 .../ethernet/intel/ixgbe/ixgbe_dcb_82599.c    |  12 +-
 .../ethernet/intel/ixgbe/ixgbe_dcb_82599.h    |  35 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  46 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |  10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 210 ++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  52 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 186 +++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  66 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |  18 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 294 +++++++++---------
 22 files changed, 808 insertions(+), 832 deletions(-)

-- 
2.41.0


