Return-Path: <netdev+bounces-102676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7B9043D6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00941F25852
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC857CA7;
	Tue, 11 Jun 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAcxv4BU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048738FA1
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131368; cv=none; b=i99N5zrWL17UCYrCDH4B8MoGWlOX8jQnA3ASFIMnzjgeoOopqOWQnaUa5Wc0HQ8fqr+MVa/qPmMDQjJg1GqJiH4YXzMILgCsQaxUHyLe++ei80R0zcXVzwY25uIYaEcF6gYl1wmocxmfzNrcP01wvzmf9MBzrKVIbbOk10xeRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131368; c=relaxed/simple;
	bh=WFTS1PmTYURI0n/TGLnV4c0ZosxQrXr1eywDdVWL/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VR/YpuXbRRtvhhu2sNbIvPdaYUmcMXOj1MUtmifRyxhGiJMkVhd8AEHdE3hGh7/3H75JTIB4rWKcL2vnL+IUFU+SzHnDDgAIfZSGlRyzexB5REv/ZMybXS/Lf2hF0YY/AWr7+BJBy7310c8gl/RP+Vws4K6RFGNcRGdc6G0aNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAcxv4BU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131367; x=1749667367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WFTS1PmTYURI0n/TGLnV4c0ZosxQrXr1eywDdVWL/jo=;
  b=OAcxv4BU2avQMac/dj3+cqKhe6HrmI3s6C24iYWU+Z0BqmSHVYh/Xw5F
   OWDEHuM1F1nr/O7epARvqTD6tFCUdMlWfSiw4xwHs26le+K9c8RCSfMul
   ZamO3oIYcnxQ+8jV5Wzgj+2AUrSNjiyCDAH6ZAhe+HkLWHcLbG7yh4FwA
   blsCTIkRff2C8YEeChKbwiTx2WDzD96mQgz80Qc8ua0mFGp33wgAQIrQp
   S0diDpV2HBX76nIiQtx8rlKQgmtMNYUq4aHF0VylakLgJyeje1t64hwLu
   UikljFPhupavTAgfDqNp3/a/9Vzj8yqjODq3d/d+Qzyfz6BA9e9fFz3nt
   A==;
X-CSE-ConnectionGUID: myAOJXr/SrO9N7knLJrJjQ==
X-CSE-MsgGUID: nCF24wj3RPKGcKqGglvF2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12025534"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12025534"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:42:46 -0700
X-CSE-ConnectionGUID: vRvEaqQjSd6FzzgQlayxgg==
X-CSE-MsgGUID: 7xEH6KA4QpyM+Q4sax5iqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39592484"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 11:42:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-06-11 (i40e, ice)
Date: Tue, 11 Jun 2024 11:42:34 -0700
Message-ID: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e and ice drivers.

Michal fixes an issue when an XDP program is unloaded via rmmod on i40e.

En-Wei Wu resolves IRQ collision during suspend for ice.

Paul corrects 200Gbps speed being reported as unknown for ice.

Wojciech adds retry mechanism when package download fails on ice.

The following are changes since commit 36534d3c54537bf098224a32dc31397793d4594d:
  tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

En-Wei Wu (1):
  ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Michal Kubiak (1):
  i40e: Fix XDP program unloading while removing the driver

Paul Greenwalt (1):
  ice: fix 200G link speed message log

Wojciech Drewek (1):
  ice: implement AQ download pkg retry

 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 23 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c   | 10 ++++++++-
 3 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.41.0


