Return-Path: <netdev+bounces-101147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60798FD7AB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F951F23096
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706315EFD2;
	Wed,  5 Jun 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8LB4YDS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9415ECF1
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620046; cv=none; b=KPkENf90BE2zH0h0vyB3v5UikN67yQmrGbSr+pFd4BzUcs7p6o23doxKgjrgBaR6lQ0GBMpVL+WXtdi5LJ6Yz48x9XJqT6J/2GA/BlNkA+8eEglQIFLCjY5ZRTWxY7RpzERe8NnqKGr4Ry8p9AwUbfS+AT03dxiRIQT6jhnyLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620046; c=relaxed/simple;
	bh=DIBvAYLVbcU412FJ1XCPawYIG88jckHxjOxbrxPTmHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BsjR8u8n0sjMVQXG8BPu1WCneU2pA0eW8x5Og8ZixXnxetCIVHgvdFzY8o2YY++DSp3DKlyrPv6C9JJfjHsiHZzTxQY+/vHWS7Q1CyMtEk/4/ZzgS1ltJrzSxEKtQ46ZE4Oh/7+4fkUiWVtx3RiqMFFZWuoPyc/s2LLfnci27II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8LB4YDS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620045; x=1749156045;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DIBvAYLVbcU412FJ1XCPawYIG88jckHxjOxbrxPTmHM=;
  b=L8LB4YDSa7LAzndJ66Q8Iuz+p5hyudCPkAq9wjuU3UMwG9lXnWiYXedc
   1zr8rJVC6CBXI8ZmWhFdBGVzwv3KnDvAiWRn3jTiZv9pVvCt7az87Udck
   Vrv+pymRRwLKNVzUrKqIx706zbjN4S+1fSmyxrIN/0e0DUoeWDb8KaiFI
   R3WonRO7rocTTHk77uvT/SMmojj7zO2aHF/6gERvRDQHX19TO5SCHhyf7
   MfEAcE6bUFmhQrqfpbJK+9vc/Neupxi2KcRpbTPHwPJDGjxCR2Cqd1EFj
   1oj33sU18QzEb8RUhIkFaCAgaST/xP9blgEwFgJeJVrrIhpMZb675K2Ec
   A==;
X-CSE-ConnectionGUID: 1nX7bYV7QCa4nh5RD4i+mA==
X-CSE-MsgGUID: brcaK+3JQs+veBwHtKx/tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18103030"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18103030"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:45 -0700
X-CSE-ConnectionGUID: 4SpOyMXZRbeGrX+A+VDH2w==
X-CSE-MsgGUID: nhvMbH4nSiqhy1QlBLvPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37824304"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/7] Intel Wired LAN Driver Updates 2024-06-03
Date: Wed, 05 Jun 2024 13:40:40 -0700
Message-Id: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEjNYGYC/5XNTQ6CMBAF4KuQWTumnQL+rLyHYQFlkEm0mLYhG
 NK7W/AELr+Xl/dWCOyFA1yLFTzPEmRyGXQowI6tezBKnw2kqFS1Muh4ibgJVY3Z4iI/f2nXRjt
 iWZlTx/rSW9KQZ96eB1n2i3uTPUqIk//sj7Pe0j/GZ40KWVVkOjoPhqrbXjna6QVNSukLYBBUH
 dAAAAA=
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

This series includes miscellaneous improvements for the ice as well as a
cleanup to the Makefiles for all Intel net drivers.

Andy fixes all of the Intel net driver Makefiles to use the documented
'*-y' syntax for specifying object files to link into kernel driver
modules, rather than the '*-objs' syntax which works but is documented as
reserved for user-space host programs.

Michal Swiatkowski has four patches to prepare the ice driver for
supporting subfunctions. This includes some cleanups to the locking around
devlink port creation as well as improvements to the driver's handling of
port representor VSIs.

Jacob has a cleanup to refactor rounding logic in the ice driver into a
common roundup_u64 helper function.

Michal Schmidt replaces irq_set_affinity_hint() to use
irq_update_affinity_hint() which behaves better with user-applied affinity
settings.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Drop patches 8 and 9 based on review feedback, so that they can be
  reworked.
- Link to v1: https://lore.kernel.org/r/20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com

---
Andy Shevchenko (1):
      net: intel: Use *-y instead of *-objs in Makefile

Jacob Keller (1):
      ice: add and use roundup_u64 instead of open coding equivalent

Michal Schmidt (1):
      ice: use irq_update_affinity_hint()

Michal Swiatkowski (4):
      ice: store representor ID in bridge port
      ice: move devlink locking outside the port creation
      ice: move VSI configuration outside repr setup
      ice: update representor when VSI is ready

 drivers/net/ethernet/intel/e1000/Makefile          |  2 +-
 drivers/net/ethernet/intel/e1000e/Makefile         |  7 +-
 drivers/net/ethernet/intel/i40e/Makefile           |  2 +-
 drivers/net/ethernet/intel/iavf/Makefile           |  5 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  2 -
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       | 85 ++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h       | 14 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  3 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  2 +-
 drivers/net/ethernet/intel/igb/Makefile            |  6 +-
 drivers/net/ethernet/intel/igbvf/Makefile          |  6 +-
 drivers/net/ethernet/intel/igc/Makefile            |  6 +-
 drivers/net/ethernet/intel/ixgbe/Makefile          |  8 +-
 drivers/net/ethernet/intel/ixgbevf/Makefile        |  6 +-
 drivers/net/ethernet/intel/libeth/Makefile         |  2 +-
 drivers/net/ethernet/intel/libie/Makefile          |  2 +-
 include/linux/math64.h                             | 28 +++++++
 24 files changed, 144 insertions(+), 76 deletions(-)
---
base-commit: 83042ce9b7c39b0e64094d86a70d62392ac21a06
change-id: 20240603-next-2024-06-03-intel-next-batch-4537be19dc21

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


