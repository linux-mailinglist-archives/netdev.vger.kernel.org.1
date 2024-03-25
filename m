Return-Path: <netdev+bounces-81753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C788B10D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ACAB348FE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DCF446D9;
	Mon, 25 Mar 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUGqlfxc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D151F5F3
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397227; cv=none; b=TCbEb+gg2wSyjcjOtmT3eIKH6sXORQFNVBv5r4bXbI11vrJYNKR+xiGpXlrfhQn8McG/HK3X4vN/DNfSMRKld/ip1UTS6bsvo5aCqbJH4y1FGQw85CP4wsyVAB8egX/OIAeQ2blxi2W3yYxH4k6k/BqtBwW1xHsX2TKc32KKiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397227; c=relaxed/simple;
	bh=KuT6XdYYvq+HTuTpGFIELvmsAmA0qxG8HDCZ7yRtcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCRA5YkFUejM2nM2lzp1V/VKQc8nck0L1qLT5BtBOVFmQpVeaX0EY6s2Y1Zqxhb60PVbBsCQvh2L4pCHO+Pm+ioj1rrP6iP/oopaNDUsqEExZB/C+sb9+Qgme+u6jOnSgVxCdYsxA9eWBq7DdF0Pw9/YcRxE2KorYaen8wWL2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUGqlfxc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711397226; x=1742933226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KuT6XdYYvq+HTuTpGFIELvmsAmA0qxG8HDCZ7yRtcSk=;
  b=QUGqlfxcQyyC4SMKMAdadmY7Qm5KGrgm68r1SDGHXQNcz0jjV6Fi1vsr
   UIjhGA+wK6yjFoH0ObqN/HWH8R0ADKpl5uo4e1+J1yurAbbHIERunRAe7
   BbeicWJm0p9ox8pchw6xzn4kTxmv6NXAbAHWMx20UrxRk/lYLxC7xJ2VC
   3e9pdKMNqLvOlkmv2MXs4v6vX9WAmHICGRF8kftb+a7+EqB/mq30Lo+Sk
   W4U4PjzG8GBKzrSgFm886crF4K5eZG1QuWLsnebhQYa3hZ/IN+MjMjKvj
   ZY6jz9T6rYQwTqeXTVDY7rLBOmOnqAxj8biGrB0MhYEyA9AfXHyKJagfW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17855092"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17855092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20459290"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 25 Mar 2024 13:07:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-03-25 (ice, ixgbe, igc)
Date: Mon, 25 Mar 2024 13:06:44 -0700
Message-ID: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice, ixgbe, and igc drivers.

Steven fixes incorrect casting of bitmap type for ice driver.

Jesse fixes memory corruption issue with suspend flow on ice.

Przemek adds GFP_ATOMIC flag to avoid sleeping in IRQ context for ixgbe.

Kurt Kanzenbach removes no longer valid comment on igc.

The following are changes since commit c2deb2e971f5d9aca941ef13ee05566979e337a4:
  net: mark racy access on sk->sk_rcvbuf
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jesse Brandeburg (1):
  ice: fix memory corruption bug with suspend and rebuild

Kurt Kanzenbach (1):
  igc: Remove stale comment about Tx timestamping

Przemek Kitszel (1):
  ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Steven Zou (1):
  ice: Refactor FW data type and fix bitmap casting issue

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 ++-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  4 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c      | 18 +++++++-------
 drivers/net/ethernet/intel/ice/ice_switch.c   | 24 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c     |  4 ----
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 16 ++++++-------
 7 files changed, 37 insertions(+), 36 deletions(-)

-- 
2.41.0


