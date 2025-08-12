Return-Path: <netdev+bounces-212928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6FB22945
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13482683537
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE542857C7;
	Tue, 12 Aug 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLuZCytp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49234284B39
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005947; cv=none; b=rthIfYKl/rvf35V4wP1JKbxyWugXa6nEkmVPdbOFdNE1ZM9boBG0lIvZIUS7ZGY51Vw/JbmOW+av0mb36i8cT5fYO11DQgmJax8uEOc+KJ+jbJtEUjdLpO8m9bdieDZziWj/g2fAlEoBhUTVUDS22kJVeEzM61hKlGRPv3r2UD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005947; c=relaxed/simple;
	bh=vIpi+g0K3+O6k66kKqZ/03Vf+0OMHaf6O7+yzY2Gtgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tV0t2/rbxazjhRb08ue6QIe+N1v65jSio5yQKFf1FbLCFvJVtnK5CFhYh8j9SaGK1bVzklngzhV56AUpFWOHR/Wdt6mg/W/pyqam4JOUuxptGG/TDlYjGX3qd5DJAuJpqRTEXxi2mYLo3FukbX0jdn4zXkAZJ1aH3/SAP58WUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLuZCytp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005947; x=1786541947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vIpi+g0K3+O6k66kKqZ/03Vf+0OMHaf6O7+yzY2Gtgo=;
  b=VLuZCytpsWOhZAMwZCOeWfJOrxXoxCQkfQ18bjcc2CBJXZeRHOwqh3dZ
   JctlvuFeIQeQAbgt9z+PlFrGDbQvuEuPOgCOe0p3mpFj2bt9jHyffbnyt
   3wkzStl9dGz6e/N3mSAyYxqBbN+0yyLtegvG/YHXYDXO7J4wAM/dDppIh
   Lz7Y6zyYJ7H5KXs7MBFi5bIFDpJQYZCNCLmk2aMO0uTb8/qBgwqn5U89G
   pHdHRfnWz84Vez/3rFCY61Gw12cdZy8JCWZgPd5vEUy4b2YPoxbCsMwsn
   4wagYEQMY6G9RAX7/KpHfSIKcsJ4dJaDe9T+zYje+dCIMtgradOMv8tbe
   Q==;
X-CSE-ConnectionGUID: 9XJ5TtgGToSWyHYztM4pTw==
X-CSE-MsgGUID: nlLOFHl1RsGCcRyRVfKoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994323"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994323"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:06 -0700
X-CSE-ConnectionGUID: mtL56hs5Sg2reneZuOturg==
X-CSE-MsgGUID: fJezaJpqQK2KzlPZuwQ/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416064"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:04 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2305132CAD;
	Tue, 12 Aug 2025 14:39:03 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 05/12] ice: split RSS stuff out of ice_virtchnl.c - p1
Date: Tue, 12 Aug 2025 15:29:03 +0200
Message-Id: <20250812132910.99626-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Temporary rename of ice_virtchnl.c into ice_virtchnl_rss.c

In order to split ice_virtchnl.c in a way that makes it much easier
to still blame new file, we do it via multiple git steps.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                         | 2 +-
 .../ethernet/intel/ice/{ice_virtchnl.c => ice_virtchnl_rss.c}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.c => ice_virtchnl_rss.c} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 46a21ed67066..b5247d370663 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -47,7 +47,7 @@ ice-y := ice_main.o	\
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
-	ice_virtchnl.o		\
+	ice_virtchnl_rss.o	\
 	ice_virtchnl_allowlist.o \
 	ice_virtchnl_fdir.o	\
 	ice_virtchnl_queues.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.c
rename to drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
-- 
2.39.3


