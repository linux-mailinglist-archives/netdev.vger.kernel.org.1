Return-Path: <netdev+bounces-76713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB76486E977
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1771C2552F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1C3A1B7;
	Fri,  1 Mar 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mt5NK/96"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101213AC0
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321158; cv=none; b=h3Z8KTE3hlZmlrJ/vtiyUk7Qu8HMlyDd9nqIyYuJNNXP23lf6EhIrT2RoGN6YmcHXG518/cHHQtAehqq4aKej/81bFUp9aWHQG83l69Y4zXR4lLQUZRMGO7C4Z4sLZJhGWeM3vkz5p5Vtyo634AF+AEVp2BOgqVo3l5/v0gLv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321158; c=relaxed/simple;
	bh=rmbPIs8fvm9gr5Q1yXTyUW/SChI+ma7CwkvFIOMWF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJWABEQ8SF25Mp4SCAGFG6kgoNiEZzA6Tvd4BxwscNqnuVJcyrFXrMZbiP2hwzpxzNWtYA9pecrY4oMO6EsqSd/98SUSsgLhEkO4GaOmjyU+5l0Wlu7joJjmnHcAp4qZsL4020snV+KYGT6t1Zx4yBkx9+kUWWHiKXL+5lK9Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mt5NK/96; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709321157; x=1740857157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rmbPIs8fvm9gr5Q1yXTyUW/SChI+ma7CwkvFIOMWF6M=;
  b=Mt5NK/96Pgif3hjcgmHqmAfAMcphsJC4yddNzFqb8uJ6rq50Nj5jScGv
   1Fioy7Vi4Ju4Hqnp6PH1cIah//IxLpQmghlitrTWjggT5LZSwGW7BxGWR
   v103LpZUUDyHxerXdhVxJpyJr/5PTfq3Kz+++RyZmSVLQzTj776CcJs8a
   SA8EEUI/uua1YcEssVa1lyIpHdhlXnHXtuRPNFcrETjY+SAUVcChZ4j5e
   36wTnNnNNQjaqKugDlz4Fi253aBud7NXj6ioAETYsGPYf7NZQge7ZHE0+
   hcy66jOZCqXagbIpVjEiPj9+z8WHSRvHflLO0nX4lWI2I3+IV3sf5evTB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7694911"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7694911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12998466"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 11:25:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-03-01 (ixgbe, i40e, ice)
Date: Fri,  1 Mar 2024 11:25:45 -0800
Message-ID: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ixgbe, i40e, and ice drivers.

Maciej corrects disable flow for ixgbe, i40e, and ice drivers which could
cause non-functional interface with AF_XDP.

Michal restores host configuration when changing MSI-X count for VFs on
ice driver.

The following are changes since commit 1c61728be22c1cb49c1be88693e72d8c06b1c81e:
  MAINTAINERS: net: netsec: add myself as co-maintainer
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 10GbE

Maciej Fijalkowski (3):
  ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
  i40e: disable NAPI right after disabling irqs when handling xsk_pool
  ice: reorder disabling IRQ and NAPI in ice_qp_dis

Michal Swiatkowski (1):
  ice: reconfig host after changing MSI-X on VF

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 11 +++-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  9 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
 4 files changed, 64 insertions(+), 14 deletions(-)

-- 
2.41.0


