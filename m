Return-Path: <netdev+bounces-103299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA96907771
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07281F21856
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297714600F;
	Thu, 13 Jun 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/IFGq5H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBE1420BC
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293522; cv=none; b=U/zZvXWetk2g2kIXWefGBIe84k7wuW4RaAJKOoFSb/S9ynyQbcGWKrIE3/GVwTmkSSZRBvaXs/BeQFthqKRarAUGO+8/ZSNW2Y3NSLKii5ZTT5cBKpUb5D7ePXheRFr6GvMrulV3IIf45gSwGYvptqVz/LUVk8gO1R7KA4xWE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293522; c=relaxed/simple;
	bh=+in5zN2w5/r2m3ZPLJLnNVayiRyNGo08nlVuX+JTdRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMV1sbHp6J/Rglb9hfn5EJ64i8XFS1JlIXBcFX1mrzZGTCRa3XueMmbYf7cj2wAauaXnRuEfTyY14sMTYLCFahXoROmdXaHNHrwkCRLdVZmXYhGQUhFnpDwTTw7t4XRrPEDWF43uj+644KaLhDZnKnbKnvvCSIXUhm3nPQEl4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/IFGq5H; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718293521; x=1749829521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+in5zN2w5/r2m3ZPLJLnNVayiRyNGo08nlVuX+JTdRM=;
  b=g/IFGq5HnTVHVXFalUVLAmC+4+pHsHIfSDPqaNFFDYaaA5C4r1ESRJ0H
   Dcm7EoasHOLeywdLGf8vhJ3t2jXFOhqZjxQ1ZK73aBJnHAYkYdALENBy7
   GPDrZhmuuW90tWURBmtY+3ydErgpJPk7n18tYcWKCs3DDCC9NenZcEV+k
   4fBumDKa9RzG01o4AD7/E9xGLfKD8HlnZH0StVOKFIZ8Ve4uKr5guezLv
   /t8M8q1QUTWZA3spI6O1KQ8tSb07fUPKfImUO4cgTzMEuWX24YwjpCL2+
   tyilJOO5doVLCrHgD+Daj4qhzZSOmTtRg/mleg78k43YNOhFPRQ4Ekrdh
   Q==;
X-CSE-ConnectionGUID: 8XHaifa0SnaTpgccT1E5Cg==
X-CSE-MsgGUID: JqcVzc5aTwi+sNui+q0XpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37645757"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="37645757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:45:20 -0700
X-CSE-ConnectionGUID: 6LJbBIWIQR2nvfcdRjVqUA==
X-CSE-MsgGUID: fhRySCnXTHOXrim3NcHhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40124483"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Jun 2024 08:45:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/3][pull request] Intel Wired LAN Driver Updates 2024-06-11 (ice)
Date: Thu, 13 Jun 2024 08:45:07 -0700
Message-ID: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

En-Wei Wu resolves IRQ collision during suspend.

Paul corrects 200Gbps speed being reported as unknown.

Wojciech adds retry mechanism when package download fails.
---
v2:
- Drop, previous, patch 1

v1: https://lore.kernel.org/netdev/20240611184239.1518418-1-anthony.l.nguyen@intel.com/

The following are changes since commit a9b9741854a9fe9df948af49ca5514e0ed0429df:
  bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

En-Wei Wu (1):
  ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Paul Greenwalt (1):
  ice: fix 200G link speed message log

Wojciech Drewek (1):
  ice: implement AQ download pkg retry

 drivers/net/ethernet/intel/ice/ice_ddp.c  | 23 +++++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.41.0


