Return-Path: <netdev+bounces-101970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30886900D77
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F227B210E4
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 21:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792254502C;
	Fri,  7 Jun 2024 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY4ouJ2G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCB3B782
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795366; cv=none; b=Zn5c7hnK2fEMXI9OdEevTsgXwglbxLfxz27iRl5cGpO1FSsCQsSfewsNQTXeGGCRhP1cEctvoQKAZrRgEsE3lcwR4OJN2La9gGABR8Q3NhRNYHVptyKS5DV9lQ12nJr9lCJidiZhu+hR7tonxY+vTjLGZNmpXugwtZ/9v6nwOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795366; c=relaxed/simple;
	bh=g6fTb6iiJIiClNJrBkcIXFHoP0fMkCKPqZJaFCiEDD4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z07SXn9MQ9Gj7tdCd+zj2HNqK/fECexu+io4LKahj20joX3XGr+cCHulLM6WlaqO/MLNq1VikJdNnmi6tRfIDAULMT3P0QtIqzSrRZshLs+S3dJ9U0iUwukyt1HbnIZyW3qMPZPO4N0USTXm1W6xfy/CDtVczGHBgq8LKx/RfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY4ouJ2G; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717795365; x=1749331365;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=g6fTb6iiJIiClNJrBkcIXFHoP0fMkCKPqZJaFCiEDD4=;
  b=MY4ouJ2GJRgOpzOCEqC+7RDv8l7Z6EP00+XuRTCrampUNRq7xLMGZz7q
   1MThdlXy0FJA2NGAoYu7dtJSFwmLXrM8fcO6uoRHtm/iivlWHKOymwteJ
   BeWlQIn8+lt/9g0qt5QMoWP392GgQVckozEygGsbOHrhxBL6BH4JzUFBy
   g8YILV05Qy8fnx1HVfqxEq6GTvLajOUgfDkYDgZqhYUy20iIIZH/lD91r
   oqtqmW1MCF4lnFMRBAuRkJF7AMeH7wv09REBgGp8ClBwS4ZzhOBaUSlb8
   3e57uFHCrfFl2cqg/GqLOoR8ZqkBKAjYKayOMvQHlX5YontySSHTtM5zn
   Q==;
X-CSE-ConnectionGUID: 0EaSrxI8QeinFF7/VFebkA==
X-CSE-MsgGUID: 5+VsAc00TNqkcF577yXHpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14417703"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14417703"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 14:22:44 -0700
X-CSE-ConnectionGUID: uCH5dZAyRDGAFobBkNZo1g==
X-CSE-MsgGUID: iJTCPhkyRPKqLEhp6vJ1Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38571781"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 14:22:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/3] Intel Wired LAN Driver Updates 2024-06-03
Date: Fri, 07 Jun 2024 14:22:31 -0700
Message-Id: <20240607-next-2024-06-03-intel-next-batch-v3-0-d1470cee3347@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABd6Y2YC/5XNTQ6CMBCG4auYrh3TzlB+XHkP4wLKIE0UTNs0G
 MLdLbhhqcv3y+SZWXh2lr04H2bhOFpvxyEFHQ/C9PVwZ7BtaoESM5lLgoGnAGuBzCG1HQI/vmt
 TB9NDpqloWFWtQSUS83Lc2Wl7cb2l7q0Po3tvH6Na1z/wqEACS43UYNkR6st2cjLjU6x4xD2of
 wAxgVQZpCqnri7KPbgsywd65F+GIQEAAA==
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Michal Schmidt <mschmidt@redhat.com>, Sunil Goutham <sgoutham@marvell.com>
X-Mailer: b4 0.13.0

This series includes miscellaneous improvements for the ice as well as a
cleanup to the Makefiles for all Intel net drivers.

Andy fixes all of the Intel net driver Makefiles to use the documented
'*-y' syntax for specifying object files to link into kernel driver
modules, rather than the '*-objs' syntax which works but is documented as
reserved for user-space host programs.

Jacob has a cleanup to refactor rounding logic in the ice driver into a
common roundup_u64 helper function.

Michal Schmidt replaces irq_set_affinity_hint() to use
irq_update_affinity_hint() which behaves better with user-applied affinity
settings.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v3:
- Dropped Michal's subfunction patches
- Link to v2: https://lore.kernel.org/r/20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com

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

 drivers/net/ethernet/intel/e1000/Makefile   |  2 +-
 drivers/net/ethernet/intel/e1000e/Makefile  |  7 +++----
 drivers/net/ethernet/intel/i40e/Makefile    |  2 +-
 drivers/net/ethernet/intel/iavf/Makefile    |  5 ++---
 drivers/net/ethernet/intel/ice/ice_lib.c    |  4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c   |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  3 +--
 drivers/net/ethernet/intel/igb/Makefile     |  6 +++---
 drivers/net/ethernet/intel/igbvf/Makefile   |  6 +-----
 drivers/net/ethernet/intel/igc/Makefile     |  6 +++---
 drivers/net/ethernet/intel/ixgbe/Makefile   |  8 ++++----
 drivers/net/ethernet/intel/ixgbevf/Makefile |  6 +-----
 drivers/net/ethernet/intel/libeth/Makefile  |  2 +-
 drivers/net/ethernet/intel/libie/Makefile   |  2 +-
 include/linux/math64.h                      | 28 ++++++++++++++++++++++++++++
 15 files changed, 54 insertions(+), 37 deletions(-)
---
base-commit: a999973236543f0b8f6daeaa7ecba7488c3a593b
change-id: 20240603-next-2024-06-03-intel-next-batch-4537be19dc21

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


