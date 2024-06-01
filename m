Return-Path: <netdev+bounces-99890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAA8D6DFB
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 07:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45931C20C39
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2203AD5A;
	Sat,  1 Jun 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgtQ75rH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F397628
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717218367; cv=none; b=i0qFgq6FElH/YHquHsvZAcRAi5ax6zJuK4WiwSSCfGPS6TxF9ZLMVRc/JsJDGY7rwBkmXuP0jO5XS4ravQ/S20VRVHKKpjVIeeoOdRuXCmt5MEqVu/ANS6FtS9c4QBO/QMh7Wmi/ANZniX82wGXddWPRYUA9cFsacp5gvRFCmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717218367; c=relaxed/simple;
	bh=yU/C4l4Q78u14jU3ZqvnCtRDDVk4K6Yu94/TRH/XKzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1OnZirU5Un0aRav1Djy2C2eLbu7wRc1JX6FsELMpg/Gi3WITH9LjVBT6Rl6bc1GSSWO2dDUZGCI3abzWgojn43kEVpKdTbHumiI/oeimNPdRW8pxwojCU92LVa5gW9U2SFAV3El3nJ/WT5OPenQ4iuOndUde2toCx82hWWrM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgtQ75rH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717218368; x=1748754368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yU/C4l4Q78u14jU3ZqvnCtRDDVk4K6Yu94/TRH/XKzk=;
  b=JgtQ75rHrw2yTJgECtHHrlQZGhOUXR5R44oVBS2263BDDfKNkgUsmGHm
   j6PFF5jN0MSzdj1SE+urM5NN/pYScr+X7qTfI/sO0Rv7Dz7uixz743Mj9
   Aol2RCyyO8l+z6uQVM+NI7uhFID9usJN+9/vGKVK7++d4C3xG+97cf1ZA
   8oikwkXAk1tj8G/zZQCsBx5UmfevhdXAeTjo1cM7lAJkVS5Mvu7J8dSNA
   OvbV8x9L+INb1B73dta6MCmhuLNLGeHysP4u8HbLHXLQNomtdy4YvyG5t
   K5FBAfQ2u5Pij3U8urq+JmERGBGCPImQO6sSa0Lmc8DxA1nHRsVV7O0Nj
   A==;
X-CSE-ConnectionGUID: 9sgQ+7qKRnmMrvx1gXV0ng==
X-CSE-MsgGUID: 38wZC6FTRwuNEXCBv3LBNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17602858"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="17602858"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:06:07 -0700
X-CSE-ConnectionGUID: pFn8MCjcTHOBHvgmdFkdsQ==
X-CSE-MsgGUID: 90rqSCdqT5ORcLGeGwyBEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="36804491"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 31 May 2024 22:06:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B822C128; Sat, 01 Jun 2024 08:06:01 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Corinna Vinschen <vinschen@redhat.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/2] igc: fix BUG() during the driver probe
Date: Sat,  1 Jun 2024 08:05:59 +0300
Message-ID: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I noticed that with the v6.10-rc1 kernel I get BUG() because the
spinlock used by the PTP code is not properly initialized. This is due
the ordering change done recently and I suspect there might be other
issues the change causes. These two patches try to address this by
reverting the commit in question and then fixing the original issue by
using PCI device pointer instead for logging.

Mika Westerberg (2):
  Revert "igc: fix a log entry using uninitialized netdev"
  igc: Use PCI device pointer in logging in igc_ptp_init()

 drivers/net/ethernet/intel/igc/igc_main.c | 5 ++---
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0


