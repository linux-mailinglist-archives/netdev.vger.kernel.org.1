Return-Path: <netdev+bounces-54546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BF8076E4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DDA2816A1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9E6A339;
	Wed,  6 Dec 2023 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwQdlp4I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5ED18D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701884891; x=1733420891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XKczPfVFDpxiCBqQU2b3X2l9G0j9/ijvgX1GahluUT4=;
  b=mwQdlp4IDXZ/weeVogpYCEXkdDV7l6fWLP9b49wU6RHLJYYltdqMVd+a
   UDYNgJufBn5TpeeP3cPJJfDIP/hfWftqukUYAX1Ou27M+LoWj/PXKBBAD
   VtFZzHF+aLq1Wvxu8PFa4XBcaX/q/R6yW3kV0VKkXFGgcgF2i6XNTL4kR
   +PkfKZI94bbh2yAnbJ46Bi9xvlgICSJRE1Ct8cyQc7a+hS3HPm0zwf2Sc
   NKLKRe4FDwPUnqQC2P6QYIfjKHXqYyRk3AENtpWNKxcEzyS//N8UGdA/S
   IIg6VNI3NnmTDqeU0VZ9lr0S8YyHxruPLJPMf4YVEjLxXZi1enirAg4YW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7399505"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="7399505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764806498"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="764806498"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2023 09:48:08 -0800
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 708EE34331;
	Wed,  6 Dec 2023 17:48:03 +0000 (GMT)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH iwl-net v2] ice: Do not get coalesce settings while in reset
Date: Wed,  6 Dec 2023 18:39:36 +0100
Message-Id: <20231206173936.732818-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
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

Fixes: 67fe64d78c437 ("ice: Implement getting and setting ethtool coalesce")
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
Changes since v1:
 * Added "Fixes:" tag
 * targeting iwl-net instead of iwl-next
---
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bde9bc74f928..2d565cc484a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3747,6 +3747,9 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_reset_in_progress(vsi->back->state))
+		return -EBUSY;
+
 	if (q_num < 0)
 		q_num = 0;
 
-- 
2.37.3


