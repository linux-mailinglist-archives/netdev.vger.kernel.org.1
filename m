Return-Path: <netdev+bounces-169163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966CA42C4F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08433A72D7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581471EA7F9;
	Mon, 24 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2o3C8K8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0016CD1D
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424016; cv=none; b=iByyHdfSuneua/3x5wL5V1HB3ziUGIxTqaGd2HoRDHwW7JqC9P3EDNUnoWBFs5SW96EEf3DnoHaBCigEzKuk7BEGwHkAtyQSpAPQWzOen9kxXCy5jcXBip61jotq9jVuS50bvy7Be0P5WXNKLNwFv6fGpdAH2hRCoqraI3OML6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424016; c=relaxed/simple;
	bh=81XMLKDQ0AO/FgwHGz1HRIWSA5Vy3bUuokQGTqHibIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARXkahzpLq2mo9g95JaGSsVBTWZafapjI8Sn3C8PIcq8ZZ/U034+aUwNy/Gozk4iHlYsyHaG41u0fTUxehlCfXUQUU+7+YMl8zWjcWqQyTRYUJkSJcOr4RxOsfaK8WBOSIUJPlIu5kKBjDlnFQdzTtdd1lhEVOooy9K0HWLea+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2o3C8K8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424015; x=1771960015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=81XMLKDQ0AO/FgwHGz1HRIWSA5Vy3bUuokQGTqHibIE=;
  b=g2o3C8K8+s6cWNs21FR3jhtiFwOW0nqiHyJCMeKPXJbxpyhZUH7lfp7k
   2Ze/l/orjTnf5k5jTIY8xiRoHqlxeY2F9eZUcm58PEl6KP0Sb8ax4ew4N
   0MdxrgUBsU1YRa763awcfbnvPJCKdslO3M6M9jwLONQqaWebJraYXxwr/
   vdwkb1LaUVuoVtul+f72FPdgMsDgF71At1aKyq/US97R5d8s5TpTOy4Rf
   2WFO4l05w3SW4C+7fF3dP+IlFOLTcUNqVFBb7KoCrYEQ4iAbFC5d1y39e
   kVHAlekjm846YLXYOn8WHytZ+9R69y1wjU1od9Jq4mRa06y3mMl375i5T
   w==;
X-CSE-ConnectionGUID: oANQbHjeReWfMV6e1toK1g==
X-CSE-MsgGUID: J9Ygl4e3SW2uxuyaveqQWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614182"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614182"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:54 -0800
X-CSE-ConnectionGUID: tksSM/yWSUSnYKrxjbS+7A==
X-CSE-MsgGUID: O+eDWEBhQe+FSFoEgGT0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358453"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-02-24 (ice, idpf, iavf, ixgbe)
Date: Mon, 24 Feb 2025 11:06:40 -0800
Message-ID: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Marcin moves incorrect call placement to clean up VF mailbox
tracking and changes call for configuring default VSI to allow
for existing rule.

For idpf:

Ahmed adds call to ensure IRQs are handled prior to cleanup.

For iavf:

Jake fixes a circular locking dependency.

For ixgbe:

Piotr corrects condition for determining media cage presence.

The following are changes since commit f15176b8b6e72ac30e14fd273282d2b72562d26b:
  net: dsa: rtl8366rb: Fix compilation problem
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Ahmed Zaki (1):
  idpf: synchronize pending IRQs after disable

Jacob Keller (1):
  iavf: fix circular lock dependency with netdev_lock

Marcin Szycik (2):
  ice: Fix deinitializing VF in error path
  ice: Avoid setting default Rx VSI twice in switchdev setup

Piotr Kwapulinski (1):
  ixgbe: fix media cage present detection for E610 device

 drivers/net/ethernet/intel/iavf/iavf_main.c         | 12 ++++++++----
 drivers/net/ethernet/intel/ice/ice_eswitch.c        |  3 +--
 drivers/net/ethernet/intel/ice/ice_sriov.c          |  5 +----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c         |  8 ++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         |  9 +++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c       |  2 +-
 7 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.47.1


