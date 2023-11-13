Return-Path: <netdev+bounces-47504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EB7EA6B9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABACB209F9
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399A3D96D;
	Mon, 13 Nov 2023 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKiqIKdN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C233B2B5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:10:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C4D68
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917056; x=1731453056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/TMt1WWaG7Wovk9gbj7c1lfq8tMWp1yWaB14ud4Mp0=;
  b=gKiqIKdN8RblEQhJlkFPvk+HF4PU7XdoOzEs1AaN4DdG/NpuR0GdvLRJ
   Ea89DStXm0A2G20i6Vy+cge662Rso/jm0ZsbCwIIoiMnwyJGwB2jvfzgj
   hpYy2WxoLr6Q6cVgSh7jVnse+Dd/SUXMiDYiKM7ImgEZi8qMaSisQJiod
   JG80HrHh4kEYsIEsbrO3lzaWugLgOkcQldhUsdygqARdqZ2m2+pLRagI5
   /WQ/EOc0NrJegbxThnxMsp38pdX6cnMXRv5VIvjLG5HM7QCqDgankYS40
   qLef+7nh3EkYv3i74o+7JR8WCv372/4Yv+jrLV0Vn7t3PSrBX4OfzzC4P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562605"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051399"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051399"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Stefan Assmann <sassmann@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 03/15] i40e: Change user notification of non-SFP module in i40e_get_module_info()
Date: Mon, 13 Nov 2023 15:10:22 -0800
Message-ID: <20231113231047.548659-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Staikov <andrii.staikov@intel.com>

Make the driver not produce an error message on
"ethtool -m ethX" command when a non-SFP module is encountered
hence there is no possibility to read the EEPROM.
Make the message to appear in the debug log rather
than as an error string.

Change the return code to -EOPNOTSUPP and the string to make
it more verbose.

Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
CC: Stefan Assmann <sassmann@redhat.com>
CC: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2e781fe24bba..93525a982df2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5584,8 +5584,8 @@ static int i40e_get_module_info(struct net_device *netdev,
 		modinfo->eeprom_len = I40E_MODULE_QSFP_MAX_LEN;
 		break;
 	default:
-		netdev_err(vsi->netdev, "Module type unrecognized\n");
-		return -EINVAL;
+		netdev_dbg(vsi->netdev, "SFP module type unrecognized or no SFP connector used.\n");
+		return -EOPNOTSUPP;
 	}
 	return 0;
 }
-- 
2.41.0


