Return-Path: <netdev+bounces-59735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EB81BE62
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62273B2324E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07122634F7;
	Thu, 21 Dec 2023 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbWYq32h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B5B1ED
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703184185; x=1734720185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2JZTea/ctAx/Lm9DLzg2LS+vZy1sX/4loAqLLzTEXE=;
  b=jbWYq32hot2pNaaeNJcAbQ8nGLL5+8lF/rPzBfxTIOrHoozIQbPkWCe0
   CXyUgIRBYcqEdWhQb3RrarWp88nCVDFOtNZFidUzbFYc9NBESBbLoSPqY
   mcbXg26L01YQrhBpoEHnvcBt5OrSYLCq0hp+cDqkWWX3Q9ZNEwJmkLpCE
   eJIlyu6ECCZ576EqD+V3lgw19UZXdaAOHfjYBrhJ6htVufpLIFNnW4Q+U
   YR9S+4tHO4heP/17bfR7iRVuWGzop81sHxVoJhUKl57rahnwvHEWuIvZu
   WubO9jFvASeY7DvU/GwODUiWnkSCS1E7UVZbsW5CCd+SKA6SwWPqFSF+i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17576115"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="17576115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1023949966"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1023949966"
Received: from rkeeling-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.34.164])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:42:59 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	gal@nvidia.com,
	alexander.duyck@gmail.com,
	ecree.xilinx@gmail.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 2/2] net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm
Date: Thu, 21 Dec 2023 11:42:35 -0700
Message-Id: <20231221184235.9192-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221184235.9192-1-ahmed.zaki@intel.com>
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a NO_CHANGE uAPI value for the new RXFH/RSS input_xfrm uAPI field.
This needed so that user-space can set other RSS values (hkey or indir
table) without affecting input_xfrm.

Should have been part of [1].

Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/ [1]
Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/ioctl.c          | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 0787d561ace0..361c96653632 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2002,6 +2002,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
  * be exploited to reduce the RSS queue spread.
  */
 #define	RXH_XFRM_SYM_XOR	(1 << 0)
+#define	RXH_XFRM_NO_CHANGE	0xff
 
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9adc240b8f0e..4c4f46dfc251 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1304,14 +1304,16 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	/* If either indir, hash key or function is valid, proceed further.
-	 * Must request at least one change: indir size, hash key or function.
+	 * Must request at least one change: indir size, hash key, function
+	 * or input transformation.
 	 */
 	if ((rxfh.indir_size &&
 	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
 	     rxfh.indir_size != dev_indir_size) ||
 	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
 	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
-	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE))
+	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
+	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
 		return -EINVAL;
 
 	if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
-- 
2.34.1


