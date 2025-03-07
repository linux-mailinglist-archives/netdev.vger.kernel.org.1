Return-Path: <netdev+bounces-172962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CEEA56A8B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F6616D454
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397F21C9E3;
	Fri,  7 Mar 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYoUIG8c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8B21B8F6
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358312; cv=none; b=QMgsHy8XJnSCm4XJ07jV4BU0i+HGJYkeZ269W+nqJgCzOliSIdjolb2kGCagDHc1JQgEI7miLML7lvaxQZa/tiIoY0llyDME+4UsMzNI44NiUMuDwtDBiAblIftT38fmRGDS+QtIFeprENUch7dWmK5SpeAI48ZarCR4zFZ1CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358312; c=relaxed/simple;
	bh=ZoO7cR9U0Yshb8fgBZBcB4ykUBfBmK0Dpd+DLzUpPfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxkhCVQhmKMa3IsDVk1rGMZVIZa4WCC5QbNTH7b7yp61e1MjRzJIJaTQDnNZDHVXBtsD9UwHiGDErfrO7La9fFR4DbntQWfTIi6xHrfOIRkmM8Xp+3QS/LaKfEiNESij+bNxq0wKSjdjBwdnsJ/+GCOGHuUkrrFTWS/YGaW580c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYoUIG8c; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741358309; x=1772894309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZoO7cR9U0Yshb8fgBZBcB4ykUBfBmK0Dpd+DLzUpPfM=;
  b=PYoUIG8cxI7m0XLNXJr/yx5cZKUxP6DWjXgr4t5pwe6j4igGdsqLKibj
   nZBZ6+pa4yX1VJRkv24V3MDLaMB253X4v9bkwxnF7Tz9nAyO7rl8FmH1Q
   /Dd4OrZK5NFdPEfVeEzjWraJchpKUtXogKtCNr8tbEiUt0T48RYVTZ7Ns
   rIM59NpBnkTfr5OQIty7ppYjbmvL6oMsMldRe0DCiYSEMOrynRUZVCTIK
   SqxH08wwp7gYRKGB63BH1A5WH9peNSuRTM8FDD016FMDCoP9XXvC9s0H+
   +KGp/tC0mozTS4IhErYTUCrtSs6txB/Zctdep5eQvNZNJn6k+EIPETo0K
   Q==;
X-CSE-ConnectionGUID: eE1rkLEUS66xLb41VvQcRA==
X-CSE-MsgGUID: R8QB7FnWTT2GzGamV+tqvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42263294"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42263294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:38:28 -0800
X-CSE-ConnectionGUID: Vud2wuvfT02AhLJVJ3CV5w==
X-CSE-MsgGUID: i9RGoAFpRmSmUdIFiat0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="142570752"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2025 06:38:25 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH iwl-next v6 01/15] devlink: add value check to devlink_info_version_put()
Date: Fri,  7 Mar 2025 15:24:05 +0100
Message-Id: <20250307142419.314402-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
References: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/devlink/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..02602704bdea 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -775,7 +775,7 @@ static int devlink_info_version_put(struct devlink_info_req *req, int attr,
 		req->version_cb(version_name, version_type,
 				req->version_cb_priv);
 
-	if (!req->msg)
+	if (!req->msg || !*version_value)
 		return 0;
 
 	nest = nla_nest_start_noflag(req->msg, attr);
-- 
2.31.1


