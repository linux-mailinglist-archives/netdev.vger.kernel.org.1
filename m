Return-Path: <netdev+bounces-68540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5884724C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640F7B264CC
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26A144633;
	Fri,  2 Feb 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbxP3bAm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F01420D2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885725; cv=none; b=eDSBTRJbph5blI78KEO+Olzj7W/kAOzXE3WNcKaJ6y93KMucC1fLbebumO0LyOIeO4MT7iqS4pnsU6uDOhC7Af680lZ7vBY7+2xXSiYuxlLDuVXYpgcVjwPx2yEfSmwSAYqEl52tTkLMVuXJUZOtmduG1zKQVcLtlar5FhFyyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885725; c=relaxed/simple;
	bh=3BqrikNqgOSR6LBNBuR3Hfonyz+/O5OtmaNKpbUw4KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4Zu/fiqMEfGDGx8U2jx/ax+oYYSXBcS/tBvV8sa0MMSspBRJGa4nXp9+m2P52h2+yXXVQT+k1DpusH9Q5Z9qXmlldlvmf/QhVRgk/H60nsLbkSvJhhhd4neLLJislR7H4mAoNRbX2AvpnhuOBGMUQ+Qxs9jgaBjxvbWh0Jcfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbxP3bAm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706885724; x=1738421724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3BqrikNqgOSR6LBNBuR3Hfonyz+/O5OtmaNKpbUw4KM=;
  b=PbxP3bAm/81m89rbHC4ZFTxASNudYjkMRArLG2gnqa/Ie3tL272OGHpA
   qABNc5rSP6AIwKrwrvsG5Wfy0rxxiGAcDQUAURzkriht57QmqUyZ8OW59
   TVPIzsbz+BX/lRgaZjLf8iR36tf0AJd+51rHKGg4MiYYiWKMHyIDQgaKB
   +NP/zN3kn50h5xZdaLL4E796mGKDhuSqHpI3stQg8kWNQRZzBIAZEXz4R
   0O34D8aUH1DLllb8cKGiiC+Lk7iqLR51BJNE5X3DdYzN4PuTiTivR8GoX
   vY3XQw+pi3d+rT5Je2a6VJrnTYmKw5GawPMFx/kWArEaM7hZH4M2QKMa0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10823003"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="10823003"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="98333"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 02 Feb 2024 06:55:18 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v2 0/8] ice: use less resources in switchdev
Date: Fri,  2 Feb 2024 15:59:20 +0100
Message-ID: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Switchdev is using one queue per created port representor. This can
quickly lead to Rx queue shortage, as with subfunction support user
can create high number of PRs.

Save one MSI-X and 'number of PRs' * 1 queues.
Refactor switchdev slow-path to use less resources (even no additional
resources). Do this by removing control plane VSI and move its
functionality to PF VSI. Even with current solution PF is acting like
uplink and can't be used simultaneously for other use cases (adding
filters can break slow-path).

In short, do Tx via PF VSI and Rx packets using PF resources. Rx needs
additional code in interrupt handler to choose correct PR netdev.
Previous solution had to queue filters, it was way more elegant but
needed one queue per PRs. Beside that this refactor mostly simplifies
switchdev configuration.

v1 --> v2 [1]:
 * more idiomatic error handling in config LAG

[1] https://lore.kernel.org/netdev/20240125125314.852914-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (8):
  ice: remove eswitch changing queues algorithm
  ice: do Tx through PF netdev in slow-path
  ice: default Tx rule instead of to queue
  ice: control default Tx rule in lag
  ice: remove switchdev control plane VSI
  ice: change repr::id values
  ice: do switchdev slow-path Rx using PF VSI
  ice: count representor stats

 drivers/net/ethernet/intel/ice/ice.h          |   7 -
 drivers/net/ethernet/intel/ice/ice_base.c     |  44 +--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 362 +++---------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  51 ++-
 drivers/net/ethernet/intel/ice/ice_lag.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  49 +--
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 126 +++---
 drivers/net/ethernet/intel/ice/ice_repr.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   1 -
 18 files changed, 230 insertions(+), 489 deletions(-)

-- 
2.42.0


