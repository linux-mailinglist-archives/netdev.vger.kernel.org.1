Return-Path: <netdev+bounces-93757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EB8BD189
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25221282BC1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CC155328;
	Mon,  6 May 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD94jljK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B452F2C
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009564; cv=none; b=OqvRPx2e4fpZ20GoSWfFg9Jp+DgoKDCKHaqeGJ/1nWo1v1fjfpWtbcqk5xUVGRDI2iIbnonwI6Iot0D+hzSzTDw75xcsbh1WhCOW/i/1gqvBT9hS4bTwxvYkzMfoFDKli6ZKot5B1DZUMdcCRh9PaLX3gMdw8OzR/CZWmQZE2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009564; c=relaxed/simple;
	bh=1g9/UzO4DojBJepU43J1CZ5e5mfSJucwa+C7ZrcaPms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlt4LLwIz5RY7jcMZdC0fbX/osSIu+UHqA4lGYhmGwN2WvzHUbjclHRUOBzjpu/i+8h0tIS7A+v+UCFyIIEjdL6hf+P4bs63LeOwRkDuoK0BNOdwxhkgIPbB4JbZ79RBJoypNWPM3YVbon5KPhUNA4I+pM1DTlkR2N0JdqwbQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD94jljK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715009563; x=1746545563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1g9/UzO4DojBJepU43J1CZ5e5mfSJucwa+C7ZrcaPms=;
  b=BD94jljKp5H8N0XE1G7pJroOOHipw0V9kNHn2oMEaHI5/Ad2PtdMme6M
   VFgFvI84u6VCXXs8f7m8ilYPexfPLBGKVgNDCscVSmSG+mA2/KAmr4IqT
   8NuQK5MrZHjZnvZBDidZRAG8EeAOYleyi3t+BLXSoOOAGwPZLubRm+5DO
   SMU3ry1bLQVB0Sv6VPLQokjB0AXG75TJjqhqZ8A1TMtZwoZw2QlX+bdQP
   aCFMkV6qUXtb0Vbf4BiAFr74ZHKklaW1vbpq9WuZFTQ3BB253yhmHl00z
   D7m706kuUfO0SSQmvBwaBAbvOpHb2q/KXZmFGCWw5kXMajfRbDMcFO4ma
   w==;
X-CSE-ConnectionGUID: mIoIyorJQGmNBBQkgMp8Cg==
X-CSE-MsgGUID: v57HmdUqQreHn/QZkcKUkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14543033"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="14543033"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 08:32:42 -0700
X-CSE-ConnectionGUID: viwsUyFpSfyP81AsmVwn7w==
X-CSE-MsgGUID: h+ZjToWiSS6GUL/hmLzsSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28589981"
Received: from unknown (HELO localhost.igk.intel.com) ([10.91.240.220])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 08:32:40 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH iwl-net v4] ice: Do not get coalesce settings while in reset
Date: Mon,  6 May 2024 17:33:07 +0200
Message-ID: <20240506153307.114104-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Getting coalesce settings while reset is in progress can cause NULL
pointer deference bug.
If under reset, abort get coalesce for ethtool.

Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
Changes since v1:
* Added "Fixes:" tag
Changes since v2:
* Rebased over current IWL net branch
* Confirmed that the issue previously reported for this patch [1] by
Himasekhar Reddy Pucha was caused by other, internally tracked issue
Changes since v3:
* Using ice_wait_for_reset() instead of returning -EBUSY 

[1] https://lore.kernel.org/netdev/BL0PR11MB3122D70ABDE6C2ACEE376073BD90A@BL0PR11MB3122.namprd11.prod.outlook.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d91f41f61bce..4ff16fd2eb94 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3815,6 +3815,13 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_reset_in_progress(vsi->back->state)) {
+		int err = ice_wait_for_reset(vsi->back, 10 * HZ);
+
+		if (err)
+			return err;
+	}
+
 	if (q_num < 0)
 		q_num = 0;
 
-- 
2.44.0


