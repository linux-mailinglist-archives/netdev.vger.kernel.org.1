Return-Path: <netdev+bounces-61320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC08235A2
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782EC28280C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A21CFAC;
	Wed,  3 Jan 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb/WV/xw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6671CF8B
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704310393; x=1735846393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EL1Me9z815GA4T5ByS3EhvFaPCo8odPZ+IBZ9YnuIs8=;
  b=Sb/WV/xwkv4O7dBucJrisG3GBJ9Uzs/mVHggTviE6N8hn03IBSzLOdbu
   3xLCFuANYtMgm6qYHNOjGXl0slTSGWtXA/PMdzHl2LwLyFYwSmHRj2xNw
   DlPv3Jme+3tAZ99GOzzzGESYOl5y1kDYIDJqHsEzcqbVwkQ5g8j4O8lI5
   /3Urmt4Y0pvYEG1HjwlHODWw1i+fNuLsL8m75ZgHtT7Gt5ZIetmV6pmxd
   n8NctS2TlXkNGyXch2LVsSrEq8WYS+pk/EtE/k8Rnb+7ZFseYGkuBXnSl
   bfVq/uOGhjKHqKmVJzEeXwv7BDstkc33t6rmF4w6p1j9LTbm76080OzPS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="395927491"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="395927491"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 11:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780079854"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780079854"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 11:33:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/4] ice: fix Get link status data length
Date: Wed,  3 Jan 2024 11:32:51 -0800
Message-ID: <20240103193254.822968-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
References: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Get link status version 2 (opcode 0x0607) is returning an error because FW
expects a data length of 56 bytes, and this is causing the driver to fail
probe.

Update the get link status version 2 data length to 56 bytes by adding 5
byte reserved5 field to the end of struct ice_aqc_get_link_status_data and
passing it as parameter to offsetofend() to the fix error.

Fixes: 2777d24ec6d1 ("ice: Add ice_get_link_status_datalen")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index d7fdb7ba7268..fbd5d92182d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1359,8 +1359,9 @@ struct ice_aqc_get_link_status_data {
 	u8 lp_flowcontrol;
 #define ICE_AQ_LINK_LP_PAUSE_ADV       BIT(0)
 #define ICE_AQ_LINK_LP_ASM_DIR_ADV     BIT(1)
+	u8 reserved5[5];
 #define ICE_AQC_LS_DATA_SIZE_V2 \
-	offsetofend(struct ice_aqc_get_link_status_data, lp_flowcontrol)
+	offsetofend(struct ice_aqc_get_link_status_data, reserved5)
 } __packed;
 
 /* Set event mask command (direct 0x0613) */
-- 
2.41.0


