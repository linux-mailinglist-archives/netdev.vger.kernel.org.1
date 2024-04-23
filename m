Return-Path: <netdev+bounces-90640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304908AF686
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A03D1C22B2E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2C13E418;
	Tue, 23 Apr 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To7hz2YV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F413F45A
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896860; cv=none; b=bXVXMDH050JMXOhZQ28Re3Qqyuyto9Sx79ZfNbiisyLJdIag8KfQzEjhLs8djFLHbcbmJ+O/fKkFK4NCzfm72jo847EQF0leyztjLGl9APTwQqVdKukYDec0RpK5vgMx5t4gPEKhImFAlSjAIgVgCvxsoWwvHmFhSTqTcTXYqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896860; c=relaxed/simple;
	bh=ZPTFPJ1QX6RzYm8f+99PYEVZMvJHAyafJ2jetlgldiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chJfQEuXdoIrZ6jN8kHBLwXhlLlppvU80PNWL5inVRsFvsoTgDfuTqQOCm2reCzxxKdJH3z9QsbHGne+5M9nMEg4dxj7rhw8Lv6SGADutHHIlss/AADuz9REVPAvu2km/HpPX/kRczoHqS2IizugWBAaUrrJoN6moGecdQpd74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=To7hz2YV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713896859; x=1745432859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPTFPJ1QX6RzYm8f+99PYEVZMvJHAyafJ2jetlgldiM=;
  b=To7hz2YVHRBsQpfihpy5mnKc2c9Dl1XD34H9sAY1ww8NcfJvzXmFkh9i
   tjanCP0uY6HIMV9R0gLg+qVZ8GCUJIV/FJUSO8a63bLch7dMTZm8UggiX
   EbQGBVF20go5RftV74R84Ej/oI88AOqO7ExVYBuF/3aBJKGXdTff6/N1i
   WDjj2IwPkyHlMEXTAjxZWX7rdGSr+zVnDHTuYGx+ueOtOi3p9VJPf2wgv
   2atSSRQBY794wgc8EBHgBoD+wZYFwzihZq6vwI2pdVNqNk6FA2JCyfkoY
   abe9Sr0stYhRmh1boWvi1u3SsIie4PUMCXaWSFG0IP3cbJVxKhp5Uhyk6
   g==;
X-CSE-ConnectionGUID: ukzMBKrfRTGYOoouRCGpoQ==
X-CSE-MsgGUID: bEUoJ6GIR8m7iBpewDYd8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20195277"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20195277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:35 -0700
X-CSE-ConnectionGUID: UE3jXiFkRKaXLmmRqF60Pg==
X-CSE-MsgGUID: /AcYXSt1RV2tdEft0c3+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47726111"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 11:27:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	anthony.l.nguyen@intel.com,
	Mineri Bhange <minerix.bhange@intel.com>
Subject: [PATCH net 3/4] iavf: Fix TC config comparison with existing adapter TC config
Date: Tue, 23 Apr 2024 11:27:19 -0700
Message-ID: <20240423182723.740401-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
References: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Same number of TCs doesn't imply that underlying TC configs are
same. The config could be different due to difference in number
of queues in each TC. Add utility function to determine if TC
configs are same.

Fixes: d5b33d024496 ("i40evf: add ndo_setup_tc callback to i40evf")
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Tested-by: Mineri Bhange <minerix.bhange@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 30 ++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ef2440f3abf8..166832a4213a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3502,6 +3502,34 @@ static void iavf_del_all_cloud_filters(struct iavf_adapter *adapter)
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 }
 
+/**
+ * iavf_is_tc_config_same - Compare the mqprio TC config with the
+ * TC config already configured on this adapter.
+ * @adapter: board private structure
+ * @mqprio_qopt: TC config received from kernel.
+ *
+ * This function compares the TC config received from the kernel
+ * with the config already configured on the adapter.
+ *
+ * Return: True if configuration is same, false otherwise.
+ **/
+static bool iavf_is_tc_config_same(struct iavf_adapter *adapter,
+				   struct tc_mqprio_qopt *mqprio_qopt)
+{
+	struct virtchnl_channel_info *ch = &adapter->ch_config.ch_info[0];
+	int i;
+
+	if (adapter->num_tc != mqprio_qopt->num_tc)
+		return false;
+
+	for (i = 0; i < adapter->num_tc; i++) {
+		if (ch[i].count != mqprio_qopt->count[i] ||
+		    ch[i].offset != mqprio_qopt->offset[i])
+			return false;
+	}
+	return true;
+}
+
 /**
  * __iavf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
@@ -3559,7 +3587,7 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 		if (ret)
 			return ret;
 		/* Return if same TC config is requested */
-		if (adapter->num_tc == num_tc)
+		if (iavf_is_tc_config_same(adapter, &mqprio_qopt->qopt))
 			return 0;
 		adapter->num_tc = num_tc;
 
-- 
2.41.0


