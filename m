Return-Path: <netdev+bounces-72551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEAB858827
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545C928443D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C06145FE7;
	Fri, 16 Feb 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UE8RUi2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18A2FE28
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119788; cv=none; b=ptq643gxC8qKMFNhgJLBBo0s3cwfV1taAhRUoc5xSxCxb33uSVdaK6ELJTdI3W4HATbbic31OaorsRseenEX9XQxn2M4gcQcOa1iSXUWawyqIDCjWIqRNqh3LqxHcdKqO5gHRsepV8Cme8Z2BOauQGVYe9GSRl+o0GtF4wone2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119788; c=relaxed/simple;
	bh=oGEUeMVI2rBCgR/wh8gmfCkfSexph4UNEi0r6s2eYhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQj7J8lGf2QxzoVmqFRm2ANfg9jgZpIp269C31bWfDuviqrE5fctWpM6oGRE4Ue6KCASuhLF6x5TwrZELJoBxogCO04VtkCGtN0V5huaJ/0rCeI85qTyAXzlMdsu+0guWR9rXT4iSIv/jzz8ub/V1rIBIMeSyAfnDsM6Z8vswQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UE8RUi2Y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119788; x=1739655788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oGEUeMVI2rBCgR/wh8gmfCkfSexph4UNEi0r6s2eYhQ=;
  b=UE8RUi2YbzzwSh9WrvcqTYuZRFDKgpIwa8Z4+PqiqoGKHlCxXnUOqYi1
   na/6JBFBMgL1zvBOy9twTmDOCOwBcVUpXYI+ANMW+L5rz9VQMS9X4WL68
   7wdeg16r4S+NvRA1+V/VrSkbscph1P3Nete8uvR8AlaV7bOO5WUtqDoN3
   zZmhjeer5zld6ZFCZNvoM9w+DqGo/IZsZNYirTd3Xx9BO3n4OGEWY2/2L
   xpXHovkSDFvs5Y4/c9/h5oBedh6iS+DwFUA277OunI8sJYxyt5prM6ju9
   hLzaUUHbUNEpYJ+JtKp5uOTjrmhze8ieMbf7AVecT8Zv89rC7UTr0R3Ue
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2122856"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2122856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8618666"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 16 Feb 2024 13:42:51 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ivecera@redhat.com
Subject: [PATCH net-next 0/5][pull request] i40e: Simplify VSI and VEB handling
Date: Fri, 16 Feb 2024 13:42:37 -0800
Message-ID: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ivan Vecera says:

The series simplifies handling of VSIs and VEBs by introducing for-each
iterating macros, 'find' helper functions. Also removes the VEB
recursion because the VEBs cannot have sub-VEBs according datasheet and
fixes the support for floating VEBs.

The series content:
Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
Patch 4 - Fixes broken support for floating VEBs
Patch 5 - Removes VEB recursion and simplifies VEB handling

The following are changes since commit 71b605d32017e5b8d257db7344bc2f8e8fcc973e:
  net: phy: aquantia: add AQR113 PHY ID
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (5):
  i40e: Use existing helper to find flow director VSI
  i40e: Introduce and use macros for iterating VSIs and VEBs
  i40e: Add helpers to find VSI and VEB by SEID and use them
  i40e: Fix broken support for floating VEBs
  i40e: Remove VEB recursion

 drivers/net/ethernet/intel/i40e/i40e.h        |  93 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
 4 files changed, 373 insertions(+), 390 deletions(-)

-- 
2.41.0


