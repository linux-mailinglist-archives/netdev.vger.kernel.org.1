Return-Path: <netdev+bounces-60403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2881F12C
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2365A1C214B5
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6746BB1;
	Wed, 27 Dec 2023 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDl1jaCn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1146B81
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703701548; x=1735237548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uRh45pj1Hj7HhrLWsvXmHsOFbGRI9+nihPqqHgx2JY=;
  b=aDl1jaCn9uncBah26wdtzGb9ResygwwztPm+jUl4e/rQZUyPSUr4ajuG
   alw5soEcz6B7T8oFF1zgKqCR9Siklw03F9jaYgJslk60oEH/f/PFKFD1s
   ClnWGwSFCmKIDxkwFreTf0Vx5aEQNeAk8BhloMlxITpHNqANaljkHEFaQ
   cCDlsdBgKTMKzu/r9o4LYun6HosSqZMzDyaMMq41gDgJcMcjFeartZSiu
   p+eFW3vf8GsGRCjn1/yU9l0Q/npW+1QZVh29bGMyn3UZgpMS2tBZGa2Ae
   jOLMuftbB+3LIAirNxUGUJrUV5V395l18p6DOFiqAUD6XyweJjbvjMFyz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3312833"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3312833"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868921419"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="868921419"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2023 10:25:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/4] ice: Shut down VSI with "link-down-on-close" enabled
Date: Wed, 27 Dec 2023 10:25:31 -0800
Message-ID: <20231227182541.3033124-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
References: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Disabling netdev with ethtool private flag "link-down-on-close" enabled
can cause NULL pointer dereference bug. Shut down VSI regardless of
"link-down-on-close" state.

Fixes: 8ac7132704f3 ("ice: Fix interface being down after reset with link-down-on-close flag on")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 270d68b69c59..adfdea1e2805 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9193,6 +9193,8 @@ int ice_stop(struct net_device *netdev)
 			else
 				netdev_err(vsi->netdev, "Failed to set physical link down, VSI %d error %d\n",
 					   vsi->vsi_num, link_err);
+
+			ice_vsi_close(vsi);
 			return -EIO;
 		}
 	}
-- 
2.41.0


