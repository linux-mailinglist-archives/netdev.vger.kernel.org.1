Return-Path: <netdev+bounces-100769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5DB8FBE97
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21E11F23CCD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98F14C5AA;
	Tue,  4 Jun 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF5x3aPa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78942143C4D;
	Tue,  4 Jun 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539218; cv=none; b=jureE6T3NvpdOqcuFH2aplmo5TtaVuaInjjDYPC5vyK+qvNOZhTulwLpj46KxZJDTogYJhmlM2gZoqpls3l+u7VdIV9ZDm/AosgB4P6B7F5zYFbZjpf87teVCumXEPgf6wYu1LW76z7dFfrZHit49N88mzg97oK/2wolJW3TasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539218; c=relaxed/simple;
	bh=sPI1vmf9knwUD727FBcKhAG4rMv2hV9/5rA9aOi+/7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIghR8AQxy4BzaYnU8IW3ktKFJCNmcHfEkbNcDvd7fV3q22ernxotF1QIUwjtk0aVCYNGUcY7nMlb/rnvKCwRjhNMwpJQ+7eJgUPidSVTAxqNTnjdm59cZyS87AI+QfYzsd0YswawX8SKg5bF0Heswq3eayNb2BDotINZA3rGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF5x3aPa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539217; x=1749075217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPI1vmf9knwUD727FBcKhAG4rMv2hV9/5rA9aOi+/7A=;
  b=LF5x3aPa0inuv+Rrnrz5/RuZ/uW5j4xdVbpEwy/HdjCIHoHU8wilxl3d
   ecOr+WlBGpSAYTm5qKCSXGJ57PkCvVktkJNNTNfYDwfXE3rDe5Qt/Keq3
   yuUeq3QzqMWgEBZdT0ZE36/olb06W/l3EBdmTvNGhzvgmqsxI/Z+X/00X
   zFw9T0W3TV5W2fPdTomh2RRsDIkvVRp9IHhtpiyFwEz6SHFnHDM6iFk37
   QYAzNFahy8abPMVHx/b4HEolQUNrwh1mFHvfdTu4uHkrYWWeq7A4Nt0AI
   thm5388zochYBbq3qbQmu+Ld0LF/l3+CS5O8+mRizmT3LTfpmfhvmRrm5
   g==;
X-CSE-ConnectionGUID: gG7X9sKEQI64EAG8OIT4sQ==
X-CSE-MsgGUID: xLfF0gv8QuSCGkf5HWqmlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635262"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="36635262"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:33 -0700
X-CSE-ConnectionGUID: SWJB63lcQD+crIeTePZKCg==
X-CSE-MsgGUID: NbgbaTUIQAWvWMxL/mN2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37503242"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v1 3/5] ice: add tracking of good transmit timestamps
Date: Tue,  4 Jun 2024 15:13:23 -0700
Message-ID: <20240604221327.299184-4-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604221327.299184-1-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a pre-requisite to implementing timestamp statistics, start tracking
successful PTP timestamps. There already existed a trace event, but
add a counter as well so it can be displayed by the next patch.

Good count is a u64 as it is much more likely to be incremented. The
existing error stats are all u32 as before, and are less likely so will
wrap less.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..ff0ba81d0694 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -628,6 +628,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	if (tstamp) {
 		shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 		ice_trace(tx_tstamp_complete, skb, idx);
+
+		/* Count the number of Tx timestamps that succeeded */
+		pf->ptp.tx_hwtstamp_good++;
 	}
 
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -686,6 +689,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
 	struct ice_ptp_port *ptp_port;
 	unsigned long flags;
+	u32 tstamp_good = 0;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
@@ -786,11 +790,16 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (tstamp) {
 			shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 			ice_trace(tx_tstamp_complete, skb, idx);
+
+			/* Count the number of Tx timestamps that succeeded */
+			tstamp_good++;
 		}
 
 		skb_tstamp_tx(skb, &shhwtstamps);
 		dev_kfree_skb_any(skb);
 	}
+
+	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3af20025043a..2b15f2b58789 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -253,6 +253,7 @@ struct ice_ptp {
 	struct ptp_clock *clock;
 	struct hwtstamp_config tstamp_config;
 	u64 reset_time;
+	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_flushed;
-- 
2.43.0


