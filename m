Return-Path: <netdev+bounces-101575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79B8FF7C5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D1283FCB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8113DDAD;
	Thu,  6 Jun 2024 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUfu1Yz0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B313C69B;
	Thu,  6 Jun 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714035; cv=none; b=fB2Z/CfFF6kxAAQmx50PNitoFMk10HwVgJwbKsCmZ7h+dGsRMc7ZdgbenKS5ecpj9zKcG03N7hAY6ChUeExi+vXI04tC0efc3NpQ418vNyZ4LOoBxJ3GOGD8umALk2HmSFwI0C5AE32fAktvKr6nfQYg2nLRF8lGigS9vBMKJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714035; c=relaxed/simple;
	bh=JwHQnooLsYQJEJd80jekD4Sd5j4++MqVQNbMLJLcE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLhCuIPMEshvJw61/zMwF8QEE45/gw65bjMS5cy67PAm2Tk3yh3aSEt6mg7VIXC6M15eor/kGccfRK8SYoOzT1OnFwVpNj+pBQurIWa1SsX+eqkTkE7E+I2lipen+IoAIkJXd4e9q3/3lJjqyDB2zWxpC4oF5tEaFEzWtNUpz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUfu1Yz0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717714034; x=1749250034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwHQnooLsYQJEJd80jekD4Sd5j4++MqVQNbMLJLcE+I=;
  b=gUfu1Yz0ls9VOFDzH4Pz4xV2PYo3LV3RidpGL3a1ktDu2slqtaXin9vT
   /b53oxDy75s5Ui0Ij2OYSgAlPs0+3PXJD5WtmyTMM79raRkYzHvhpFJvY
   +yMAeIRkM3sEe8GtpMFW42u/THpO5S0wkqEFlG1P+YXILYC91bOeXyQNb
   RmJcP3voyqjnvVG3kyXtFMRKmERw74PrwlwtMDwo4Ct9yFqMNz91IJcrk
   xaP0g+Zzru6fXyWFaw2c5bPIUO8a8ZT876EEAHhBzU6vfxJKTyexzQlVO
   511u3eAkXeZDtgArgKNvJ9lajXL/Q1zdIwfia6eK2txNiVvA9EIQqy0op
   A==;
X-CSE-ConnectionGUID: EOs+ciE3TfO8kWuzYQEXIg==
X-CSE-MsgGUID: zZuBcGiRSmix8oxemzaqtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14224001"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14224001"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
X-CSE-ConnectionGUID: hSq34+ReTMSf+Ga1+VM6uQ==
X-CSE-MsgGUID: GVlBoXQZQcKFnX4OC5EiAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38243833"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iwl-next v2 1/5] net: docs: add missing features that can have stats
Date: Thu,  6 Jun 2024 15:46:55 -0700
Message-ID: <20240606224701.359706-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606224701.359706-1-jesse.brandeburg@intel.com>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to figure out ethtool -I | --include-statistics, I noticed
some docs got missed when implementing commit 0e9c127729be ("ethtool:
add interface to read Tx hardware timestamping statistics").

Fix up the docs to match the kernel code, and while there, sort them in
alphabetical order.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: fix up a mixup of backticks and quotes (Jakub)

I didn't add a Fixes: tag because this is not an urgent kind of fix that
should require backports.
---
 Documentation/networking/statistics.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 75e017dfa825..06f01c0cd65a 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
 the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
 statistics are supported in the following commands:
 
-  - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
+  - `ETHTOOL_MSG_LINKSTATE_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_PAUSE_GET`
+  - `ETHTOOL_MSG_TSINFO_GET`
 
 debugfs
 -------
-- 
2.43.0


