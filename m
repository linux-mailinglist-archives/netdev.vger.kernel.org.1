Return-Path: <netdev+bounces-232699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C698C0820C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F0406BE2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F32F547F;
	Fri, 24 Oct 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQuaswXt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D542FAC05
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338875; cv=none; b=ZVOYWNGtkizYyqpSAERa+J3aRGrovcEEoBW+iYmLbeOY+8bIQYxhNCSwczYljcph9otnatDLenJvZGKyGtAXRteX5mYVckdCxF8SeiZE0FAlb1BEshfm1KeXOJUt5ZVeFu957e8P5POQwMjAQzZlW9kex9XUh5d/dPwcmGyI6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338875; c=relaxed/simple;
	bh=JKabnHIWm+UZS0hFoSO0s+IWi6zu2F7/oLTzp2/QUZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+gNfezeAIFuBu7o4jvti1/1OOGBAOPy88tEZjHHIaxuZOsPNJbHZ7pC90abMV/fPHChElJpSVzH+768J18xC6qZwqoHCmh9jskpdy6TbzqLTQ5aoxut1O2o5D0FhD4t+vOpBKLqzCQzKBc/aaFFqM2QuOoFztYgkzwpICw61p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQuaswXt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338873; x=1792874873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JKabnHIWm+UZS0hFoSO0s+IWi6zu2F7/oLTzp2/QUZE=;
  b=KQuaswXtznMJR2QzxqcIMY5flKi30MaRYF9tnYfvzjywS+MzDSnq5Xnh
   53lxiuy1tlkkhxImydZmkG1eJtMI/V6ByO2rWlApnJcJQzuwll+wO9CSa
   8quTZHXYMJ42EeU14mUyin6NiP0mrdEh0VR29YA1lrM3o8UYCG9nJFuiw
   nB78Ou6GIKZg0ZP49Pm3geOXPmQy0rq8VBYyORCnRET4j/ny9c8Clgnnb
   FSb1vGfhRaY+2ixUSRTIpKzuSYZbrZUZSaNJo78COKlVKDX61PYqJPLpW
   UP2a/yf3AAdxiXD7Av7IoFi0s1CUyd2SHMWulVAYa8HCoIibbG+yc3/ON
   A==;
X-CSE-ConnectionGUID: Rlu+4IyqSauQHG1Cvmd17Q==
X-CSE-MsgGUID: 3UCO23JfQ/GCxnXiQehI5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139502"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139502"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:52 -0700
X-CSE-ConnectionGUID: jg9cL7mWQWq100OZ/ZNDgg==
X-CSE-MsgGUID: u9GMV+9ZSdik1uRFWqh0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821510"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next 0/9][pull request] ice: postpone service task disabling
Date: Fri, 24 Oct 2025 13:47:35 -0700
Message-ID: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Move service task shutdown to the very end of driver teardown procedure.
This is needed (or at least beneficial) for all unwinding functions that
talk to FW/HW via Admin Queue (so, most of top-level functions, like
ice_deinit_hw()).

Most of the patches move stuff around (I believe it makes it much easier
to review/proof when kept separate) in preparation to defer stopping the
service task to the very end of ice_remove() (and other unwinding flows).
Then last patch fixes duplicate call to ice_init_hw() (actual, but
unlikely to encounter, so -next, given the size of the changes).

First patch is not much related, only by that it was developed together
---
IWL: https://lore.kernel.org/intel-wired-lan/20250912130627.5015-1-przemyslaw.kitszel@intel.com/

The following are changes since commit f0a24b2547cfdd5ec85a131e386a2ce4ff9179cb:
  Merge branch 'net-dsa-lantiq_gswip-use-regmap-for-register-access'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Przemek Kitszel (9):
  ice: enforce RTNL assumption of queue NAPI manipulation
  ice: move service task start out of ice_init_pf()
  ice: move ice_init_interrupt_scheme() prior ice_init_pf()
  ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
  ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
  ice: move ice_init_pf() out of ice_init_dev()
  ice: extract ice_init_dev() from ice_init()
  ice: move ice_deinit_dev() to the end of deinit paths
  ice: remove duplicate call to ice_deinit_hw() on error paths

 .../net/ethernet/intel/ice/devlink/devlink.c  |  21 ++-
 drivers/net/ethernet/intel/ice/ice.h          |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 169 +++++++++---------
 5 files changed, 110 insertions(+), 91 deletions(-)

-- 
2.47.1


