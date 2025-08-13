Return-Path: <netdev+bounces-213303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30648B247A7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA1687655
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3B2F658E;
	Wed, 13 Aug 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpYhAQL6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44442BE039
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081964; cv=none; b=Svd811jXqHR3Sod1oQ2aiNfFevXfrEiB0RVMU5VuxQKK9D7ewN8q+HTOA+R4Z42eDZdsIEv8v71fT4+G+LIie8E8JlP1J9zCmHeB1M/08UREOq/YrhGWg8lRSfLWZsv0CGsTfXo60SDv2UVIToW77o4XlEfqj17JrSdchn3VyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081964; c=relaxed/simple;
	bh=c+AwxJeNM6wAxu73Z1GFnbuNNeSvAUY12myHklmx9G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isodQ+LP/DY8YmCjNLnWfM9OvD1qQdA5pEJjqRpDMZlF7W+Xmf5aRogO4BgNNjBUHaXd4MZmdo9EdZh5oODU3U9wRs5sUulzNEIxR8Y29roj+NI6xMwvfdlpehJj4WePfuv5hB1q/79bwBz0TxlIwbuWCk/eT3O7aVD6IePD4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpYhAQL6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081962; x=1786617962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+AwxJeNM6wAxu73Z1GFnbuNNeSvAUY12myHklmx9G4=;
  b=JpYhAQL6yI0Oj6LVLrrZIMR+y94a+KodEsouOHBID7hdvo7hAoJ0jB1B
   OoLgJU+ejOKbKEFKkC7qARNuK/gj4SMpaTtFxvS/OAUFzdpZNLxsnDQES
   jo7TxqE/pceuc5OVMbIHWEgE1MVRTgS2j4CwIS44yvXq3BRoIkh5OnqnA
   ekFDx6qLRReoE+yz6laJ9+SDwU/U58Kb2GQ2mb+UVEzneR0bngNPiBIeY
   Fo+pEe2nLtek69xolgoVU+dkZteQpBQCt0ebaJG/mzRmXcVgfWALEmazn
   /F9CWApzpL+MGomln+N5mgsDC+7opFuu4xt5Z729dg1H/vH36EM2Pu3NU
   Q==;
X-CSE-ConnectionGUID: iHqOM20bSTO71iyR7vxmrw==
X-CSE-MsgGUID: 13qZvBetSumc79rO3APh0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949630"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44949630"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:46:02 -0700
X-CSE-ConnectionGUID: VrqLZhV7RHmFzhfxdF/phw==
X-CSE-MsgGUID: zUB18ZJDRIqTdFNuCDe12w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166066922"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:46:00 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C050D28782;
	Wed, 13 Aug 2025 11:45:58 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 6/8] i40e: add max boundary check for VF filters
Date: Wed, 13 Aug 2025 12:45:16 +0200
Message-ID: <20250813104552.61027-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

There is no check for max filters that VF can request. Add it.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5ef3dc43a8a0..f29941c00342 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3905,6 +3905,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3944,6 +3946,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		goto err_out;
 	}
 
+	if (vf->num_cloud_filters >= I40E_MAX_VF_CLOUD_FILTER) {
+		dev_warn(&pf->pdev->dev,
+			 "VF %d: Max number of filters reached, can't apply cloud filter\n",
+			 vf->vf_id);
+		aq_ret = -ENOSPC;
+		goto err_out;
+	}
+
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
 	if (!cfilter) {
 		aq_ret = -ENOMEM;
-- 
2.50.0


